local ruleset = {command={},worker={color={},speed={}},signal={}}

command.NADA = function(world,api,args)
end

ruleset.worker.color['.'] = 'reset'
ruleset.worker.speed['.'] = 8
ruleset.worker['.'] = function(signal,worker,world,api)
end

signal.NADA = function(signal,worker,world,api)
end

return ruleset