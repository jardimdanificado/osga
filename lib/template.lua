local ruleset = {command={},worker={color={},speed={}},signal={}}

ruleset.command.empty = function(world,api,args)
end

ruleset.worker.color['.'] = 'reset'
ruleset.worker.speed['.'] = 8
ruleset.worker['.'] = function(signal,worker,world,api)
end

ruleset.signal.empty = function(signal,worker,world,api)
end

return ruleset