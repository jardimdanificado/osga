local ruleset = {command={},worker={color={},speed={}},signal={}}

ruleset.worker.color['a'] = 'green'
ruleset.worker.speed['a'] = 8
ruleset.worker['a'] = function(signal,worker,world,api)
    local sig = api.signal.emit(world,worker.position,{x=0,y=1})
    sig.color = api.console.randomcolor()
end


ruleset.worker.color['b'] = 'reset'
ruleset.worker.speed['b'] = 16
ruleset.worker['b'] = function(signal,worker,world,api)
    local sig = api.signal.emit(world,worker.position,{x=1,y=0},{str='Open Scripting Grid Abstracter',timer = 8,position = worker.position})
end

ruleset.worker.color['x'] = 'green'
ruleset.worker.speed['x'] = 8
ruleset.worker['x'] = function(signal,worker,world,api)
    local sig = api.signal.emit(world,worker.position,{x=0,y=1},nil,world.ruleset.signal.destroyer)
    sig.color = 'red'
end

ruleset.worker.color['p'] = 'green'
ruleset.worker.speed['p'] = 8
ruleset.worker['p'] = function(signal,worker,world,api)
    local sig = api.signal.emit(world,worker.position,{x=0,y=1},nil,world.ruleset.signal.pusher)
    sig.color = 'magenta'
end

ruleset.worker.color['P'] = 'green'
ruleset.worker.speed['P'] = 8
ruleset.worker['P'] = function(signal,worker,world,api)
    local sig = api.signal.emit(world,worker.position,{x=0,y=1},nil,world.ruleset.signal.puller)
    sig.color = 'magenta'
end

return ruleset