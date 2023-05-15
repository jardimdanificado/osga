local ruleset = {}
ruleset.speed = {}
ruleset.color = {}

ruleset.color['<'] = 'yellow'
ruleset.speed['<'] = 0
ruleset['<'] = function(signal,worker,world,api)
    signal.direction = {x=0,y=-1} -- x = up/down, y = right/left
end


ruleset.color['>'] = 'yellow'
ruleset.speed['>'] = 0
ruleset['>'] = function(signal,worker,world,api)
    signal.direction = {x=0,y=1} -- x = up/down, y = right/left
end


ruleset.color['^'] = 'yellow'
ruleset.speed['^'] = 0
ruleset['^'] = function(signal,worker,world,api)
    signal.direction = {x=-1,y=0} -- x = up/down, y = right/left
end


ruleset.color['V'] = 'yellow'
ruleset.speed['V'] = 0
ruleset['V'] = function(signal,worker,world,api)
    signal.direction = {x=1,y=0} -- x = up/down, y = right/left
end


ruleset.color['|'] = 'yellow'
ruleset.speed['|'] = 0
ruleset['|'] = function(signal,worker,world,api)
    signal.direction = {x = signal.direction.x*-1, y = signal.direction.y *-1}
    worker.color = signal.color
end


ruleset.color['-'] = 'red'
ruleset.speed['-'] = 0
ruleset['-'] = function(signal,worker,world,api)
    signal.position = nil
end


ruleset.color['?'] = 'blue'
ruleset.speed['?'] = 0
ruleset['?'] = function(signal,worker,world,api)
    signal.direction = api.directions[api.util.random(1,#api.directions)]
    worker.color = signal.color
end


ruleset.color['+'] = 'blue'
ruleset.speed['+'] = 0
ruleset['+'] = function(signal,worker,world,api)
    for i, v in ipairs(api.directions) do
        if v.x == 0 or v.y == 0 then
          local sig = api.signal.emit(world,worker.position,api.directions[i],signal.data)
          sig.color = signal.color
          worker.color = signal.color
        end
      end
      signal.position = nil
end


ruleset.color['X'] = 'blue'
ruleset.speed['X'] = 0
ruleset['X'] = function(signal,worker,world,api)
    for i, v in ipairs(api.directions) do
        if v.x ~= 0 and v.y ~= 0 then
            local sig = api.signal.emit(world,worker.position,api.directions[i],signal.data)
            sig.color = signal.color
            worker.color = signal.color
        end
    end
    signal.position = nil
end


ruleset.color['$'] = 'blue'
ruleset.speed['$'] = 0
ruleset['$'] = function(signal,worker,world,api)
    local sig
    for i, v in ipairs(api.directions) do
        sig = api.signal.emit(world,worker.position,api.directions[i],signal.data)
        worker.color = sig.color
        sig.color = signal.color
    end
    signal.position = nil
end


ruleset.color['&'] = 'magenta'
ruleset.speed['&'] = 0
ruleset['&'] = function(signal,worker,world,api)
    if signal.data ~= nil then
        table.insert(worker.data,signal.data)
    elseif #worker.data > 0 then
        for i, v in ipairs(worker.data) do
            api.signal.emit(world,worker.position,{x = signal.direction.x, y = signal.direction.y},v)
            worker.data[i] = nil
            break
        end
    end
    signal.position = nil
end


ruleset.color['!'] = 'magenta'
ruleset.speed['!'] = 0
ruleset['!'] = function(signal,worker,world,api)
    if signal.data ~= nil then
        local result = {timer = signal.timer}
        table.insert(world.session.print,{timer=signal.data.timer, str = signal.data.str, position = {x=worker.position.x,y=worker.position.y}})
        signal.position = nil
    end
end


ruleset.color['%'] = 'magenta'
ruleset.speed['%'] = 0
ruleset['%'] = function(signal,worker,world,api)
    for i, v in ipairs(signal.data) do
        api.signal.emit(world,signal.position,signal.direction,v)
    end
    signal.position = nil
end


ruleset.color['¬'] = 'magenta'
ruleset.speed['¬'] = 0
ruleset['¬'] = function(signal,worker,world,api)
    if signal.data == nil then
        table.insert(worker.data,signal.data)
    else
        api.signal.emit(world,signal.position,signal.direction,worker.data)
        signal.data = {}
    end
end


return ruleset
