local util = require('util')
local api = {}
api.util = util

api.new = 
{
    vec2 = function(x,y)
        return{x=x,y=y}
    end,
    signal = function(position,direction,power,data,speed)
        return {
            speed = speed or 10,
            direction = direction or {x=1,y=0},
            data = data,
            position = position,
            power = power
        }
    end,
    worker = function(ruleset,id,position,timer,defaults)
        return {
            id = id,
            func = ruleset[id],
            defaults = defaults,
            position = position,
            timer = timer
        }
    end
}

api.signal = 
{
    move = function(world,signal)
        local sum = {x=signal.position.x+signal.direction.x,y=signal.position.y+signal.direction.y}
        world.session.status = sum.x
        if world.map.signal[sum.x][sum.y] == '.' then
            world.map.signal[signal.position.x][signal.position.y] = '.'
            signal.position.x,signal.position.y = sum.x,sum.y
            world.map.signal[sum.x][sum.y] = signal
            
        end
    end,
    emit = function(world,position,direction, power,data)
        if world.map.signal[position.x][position.y] == '.' then
            table.insert(world.signal,api.new.signal(position,direction,power,data,world.speed))
            world.map.signal[position.x][position.y] = world.signal[#world.signal]
        end
    end,
}

api.worker = 
{
    spawn = function(world, position, id, timer, defaults)
        defaults = defaults or world.ruleset.defaults[id]
        if world.map[position.x][position.y] == '.' then 
           table.insert(world.worker,api.new.worker(world.ruleset,id,position,timer,defaults))
           world.map[position.x][position.y] = world.worker[#world.worker]
           return world.map[position.x][position.y]
        end
    end,
    work = function(world, worker)
        local sig = world.map.signal[worker.position.x][worker.position.y]
        local advanced = {world = world ,signal=sig, worker = worker, api = api}
        if world.map.signal[worker.position.x][worker.position.y] ~= '.' and worker.timer == 0 then
            if sig.data ~= nil then
                if sig.power ~= nil then
                    worker.func(util.array.unpack(sig.data),advanced)
                else
                    worker.defaults = sig.data
                end
            elseif(sig.power ~= nil) then
                worker.func(util.array.unpack(worker.defaults), advanced)
            end
        elseif(world.session.time % worker.timer == 0) then
            worker.func(util.array.unpack(worker.defaults), {world = world ,signal=sig, worker = worker, api = api})
        end
    end
}

return api