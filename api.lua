local util = require('util')
local api = {}
api.util = util

api.print = function(world,string)
    world.session.message = string
end

api.new = 
{
    vec2 = function(x,y)
        return{x=x,y=y}
    end,
    signal = function(position,direction,data)
        return {
            direction = direction or {x=1,y=0},
            data = data,
            position = position,
        }
    end,
    worker = function(ruleset,id,position,timer,speed)
        return {
            id = id,
            func = ruleset[id],
            auto = ruleset.auto[id],
            position = position,
            timer = timer,
            speed = speed
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
        worker.func(signal,worker,world,api)
    end,
    move = function(world,signal)
        local sum = {x=signal.position.x+signal.direction.x,y=signal.position.y+signal.direction.y}
        if sum.x < 1 or sum.x > #world.map or sum.y < 1 or sum.y > #world.map[1] then
            signal.position = nil
        else
            signal.position = {x=signal.position.x+signal.direction.x,y=signal.position.y+signal.direction.y}
        end
    end,
    emit = function(world,position,direction,data)
        if position.direction ~= nil then
            table.insert(world.signal,position)
        end
        table.insert(world.signal,api.new.signal(position,direction,data))
    end,
}

api.worker = 
{
    spawn = function(world, position, id, timer, speed)
        speed = speed or world.ruleset.speed[id]
        if world.map[position.x][position.y] == '.' then 
           table.insert(world.worker,api.new.worker(world.ruleset,id,position,timer,speed))
           world.map[position.x][position.y] = world.worker[#world.worker]
           return world.map[position.x][position.y]
        end
    end
}

return api