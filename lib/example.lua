local ruleset = {command={},worker={color={},rate={}},signal={}}

ruleset.worker.color['a'] = 'green'
ruleset.worker.rate['a'] = 8
ruleset.worker['a'] = function(signal,worker,world,api)
    local sig = api.signal.emit(world,worker.position,{x=0,y=1})
    sig.color = api.console.randomcolor()
end


ruleset.worker.color['b'] = 'reset'
ruleset.worker.rate['b'] = 16
ruleset.worker['b'] = function(signal,worker,world,api)
    local sig = api.signal.emit(world,worker.position,{x=1,y=0},{str='Open Scripting Grid Abstracter',timer = 8,position = worker.position})
end

ruleset.worker.color['x'] = 'green'
ruleset.worker.rate['x'] = 8
ruleset.worker['x'] = function(signal,worker,world,api)
    local sig = api.signal.emit(world,worker.position,{x=0,y=1},nil,world.ruleset.signal.destroyer)
    sig.color = 'red'
end

ruleset.worker.color['p'] = 'green'
ruleset.worker.rate['p'] = 8
ruleset.worker['p'] = function(signal,worker,world,api)
    local sig = api.signal.emit(world,worker.position,{x=0,y=1},nil,world.ruleset.signal.pusher)
    sig.color = 'magenta'
end

ruleset.worker.color['P'] = 'green'
ruleset.worker.rate['P'] = 8
ruleset.worker['P'] = function(signal,worker,world,api)
    local sig = api.signal.emit(world,worker.position,{x=0,y=1},nil,world.ruleset.signal.puller)
    sig.color = 'magenta'
end

return ruleset