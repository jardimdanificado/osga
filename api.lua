local util = require('util')
local api = {}
api.util = util

api.new = 
{
    vec2 = function(x,y)
        return{x=x,y=y}
    end,
    power = function(position,direction,speed)
        return {
            speed = speed or 10,
            direction = direction or {x=1,y=0},
            position = position
        }
    end,
    transmission = function(data,position,direction,speed)
        return {
            speed = speed or 10,
            direction = direction or {x=1,y=0},
            data = data,
            position = position
        }
    end,
    setup = function(data,position,direction,speed)
        return {
            speed = speed or 10,
            direction = direction or {x=1,y=0},
            setup = data,
            position = position
        }
    end,
    worker = function(ruleset,id,defaults)
        return {
            id = id,
            func = ruleset[id],
            defaults = defaults
        }
    end
}

api.signal = 
{
    move = function(world,signal)
        local sum = {x=signal.position.x+signal.direction.x,y=signal.position.y+signal.direction.y}
        if world.map.signal[sum.x][sum.y] ~= nil then 
            if world.map.signal[sum.x][sum.y] == '.' then
                signal.position = sum
                world.map.signal[sum.x][sum.y] = signal
                world.map.signal[signal.position.x][signal.position.y] = '.'
            elseif world.map[sum.x][sum.y] == '#' then
                signal.position = nil
            elseif 
                (world.map.signal[sum.x][sum.y].setup ~= nil and world.map.signal[signal.position.x][signal.position.y].data == nil) or 
                (world.map.signal[signal.position.x][signal.position.y].setup ~= nil and world.map.signal[sum.x][sum.y].data == nil)
            then
                local chosen,unchosen = 0,0
                if world.map.signal[sum.x][sum.y].setup ~= nil then
                    chosen,unchosen = world.map.signal[sum.x][sum.y], world.map.signal[signal.position.x][signal.position.y]
                else
                    chosen,unchosen = world.map.signal[signal.position.x][signal.position.y],world.map.signal[sum.x][sum.y]
                end
                
                chosen.position = sum
                chosen.data = chosen.setup
                chosen.setup = nil
                unchosen.position = nil
                world.map.signal[sum.x][sum.y] = chosen
                world.map.signal[signal.position.x][signal.position.y] = '.'
            end
        else
            signal = nil
            return
        end
    end,
    emit = function(world,origin,direction)
        if world.map.signal[origin.x][origin.y] == '.' then
            table.insert(world.signal,api.new.power(origin,direction,world.speed))
            world.map.signal[origin.x][origin.y] = world.signal[#world.signal]
        end
    end,
    transmit = function(world,data,origin,direction,setup)
        setup = setup or false
        if world.map.signal[origin.x][origin.y] == '.' then
            if setup then
                table.insert(world.signal,api.new.setup(data,origin,direction,world.speed))
                world.map.signal[origin.x][origin.y] = world.signal[#world.signal]
            else
                table.insert(world.signal,api.new.transmission(data,origin,direction,world.speed))
                world.map.signal[origin.x][origin.y] = world.signal[#world.signal]
            end
        end
    end,
}

api.worker = 
{
    findOutput = function(world, worker)
        local sum = 0
        for x = -1, 1, 1 do
            for y = -1, 1, 1 do
                if x ~= 0 or y ~= 0 then -- exclude the center position
                    local sum = {x=worker.position.x + x, y = worker.position.y + y}
                    if world.map[sum.x][sum.y] == '!' then
                        return {x=x,y=y}
                    end
                end
            end
        end
    end,
    spawn = function(world, position, id, defaults)
        if world.map[position.x][position.y] == '.' then 
           table.insert(world.worker,api.new.worker(world.ruleset,id,defaults or {world}))
           world.map[position.x][position.y] = world.worker[#world.worker]
           return world.map[position.x][position.y]
        end
    end,
    work = function(world, worker)
        if world.map.signal[worker.position.x][worker.position.y] ~= '.' then
            local sig = world.map.signal[worker.position.x][worker.position.y]
            if sig.data ~= nil then
                local result = worker.func(util.array.unpack(sig.data),api)
                if result ~= nil then
                    local direction = api.worker.findOutput(world,worker)
                    if direction ~= nil then
                        api.signal.transmit(world,result,worker.position,direction,true)
                    end
                end
            elseif sig.setup ~= nil then
                worker.defaults = sig.setup
            else
                local result = worker.func(util.array.unpack(worker.defaults), {world = world ,signal=sig, worker = worker, api = api})
                if result ~= nil then
                    local direction = api.worker.findOutput(world,worker)
                    if direction ~= nil then
                        api.signal.transmit(world,result,util.math.vec2add(worker.position,direction),direction,true)
                    end
                end
            end
        end
    end
}

return api