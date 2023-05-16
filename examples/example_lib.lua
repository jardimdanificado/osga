local ruleset = {color={},speed={}}

ruleset.color['a'] = 'green'
ruleset.speed['a'] = 8
ruleset['a'] = function(signal,worker,world,api)
    local sig = api.signal.emit(world,worker.position,{x=0,y=1})
    sig.color = api.console.randomcolor()
end


ruleset.color['b'] = 'reset'
ruleset.speed['b'] = 16
ruleset['b'] = function(signal,worker,world,api)
    local sig = api.signal.emit(world,worker.position,{x=1,y=0},{str='Open Scripting Grid Abstracter',timer = 8,position = worker.position})
end

return ruleset