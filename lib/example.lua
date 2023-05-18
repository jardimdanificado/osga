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

ruleset.worker.color['c'] = 'green'
ruleset.worker.speed['c'] = 8
ruleset.worker['c'] = function(signal,worker,world,api)
    local sig = api.signal.emit(world,worker.position,{x=0,y=1},nil,world.ruleset.signal.destroyer)
    sig.color = 'red'
end

return ruleset