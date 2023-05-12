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
            auto = ruleset.auto[id],
            defaults = defaults,
            position = position,
            timer = timer
        }
    end
}

api.signal = 
{
    work = function(world,signal)
        if signal.position == nil or world.map[signal.position.x][signal.position.y] == '.' then
            return
        end
        local worker = world.map[signal.position.x][signal.position.y]
        local advanced = {world = world ,signal=signal, worker = worker, api = api}
        if signal.data ~= nil then
            if signal.power ~= nil then
                worker.func(util.array.unpack(signal.data),advanced)
            else
                worker.defaults = signal.data
            end
            signal.position = nil
        elseif(signal.power ~= nil) then
            worker.func(util.array.unpack(worker.defaults), advanced)
            signal.position = nil
        end
    end,
    move = function(world,signal)
        local sum = {x=signal.position.x+signal.direction.x,y=signal.position.y+signal.direction.y}
        if sum.x < 1 or sum.x > #world.map or sum.y < 1 or sum.y > #world.map[1] then
            signal.position = nil
        else
            signal.position = {x=signal.position.x+signal.direction.x,y=signal.position.y+signal.direction.y}
        end
    end,
    emit = function(world,position,direction, power,data)
        table.insert(world.signal,api.new.signal(position,direction,power,data,world.speed/2))
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
    end
}

return api