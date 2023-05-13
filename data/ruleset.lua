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


ruleset.color['+'] = 'blue'
ruleset.speed['+'] = 0
ruleset['+'] = function(signal,worker,world,api)
    for i, v in ipairs(api.combinations) do
        if v.x == 0 or v.y == 0 then
          local sig = api.signal.emit(world,worker.position,api.combinations[i],signal.data)
          sig.color = signal.color
          worker.color = signal.color
        end
      end
      signal.position = nil
end


ruleset.color['-'] = 'red'
ruleset.speed['-'] = 0
ruleset['-'] = function(signal,worker,world,api)
    signal.position = nil
end


ruleset.color['?'] = 'blue'
ruleset.speed['?'] = 0
ruleset['?'] = function(signal,worker,world,api)
    local sig = api.signal.emit(world,worker.position,api.combinations[api.util.random(1,#api.combinations)],signal.data)
    sig.color = api.console.randomcolor()
    worker.color = sig.color
    signal.position = nil
end


ruleset.color['*'] = 'blue'
ruleset.speed['*'] = 0
ruleset['*'] = function(signal,worker,world,api)
    local sig
    for i, v in ipairs(api.combinations) do
        sig = api.signal.emit(world,worker.position,api.combinations[i],signal.data)
        worker.color = sig.color
        sig.color = signal.color
    end
    signal.position = nil
end


ruleset.color['a'] = 'green'
ruleset.speed['a'] = 4
ruleset['a'] = function(signal,worker,world,api)
    local sig = api.signal.emit(world,worker.position,{x=0,y=1},true,nil)
end


ruleset.color['b'] = 'reset'
ruleset.speed['b'] = 0
ruleset['b'] = function(signal,worker,world,api)
--put your lua code here
end


ruleset.color['c'] = 'reset'
ruleset.speed['c'] = 0
ruleset['c'] = function(signal,worker,world,api)
--put your lua code here
end


ruleset.color['d'] = 'reset'
ruleset.speed['d'] = 0
ruleset['d'] = function(signal,worker,world,api)
--put your lua code here
end


ruleset.color['e'] = 'reset'
ruleset.speed['e'] = 0
ruleset['e'] = function(signal,worker,world,api)
--put your lua code here
end


ruleset.color['f'] = 'reset'
ruleset.speed['f'] = 0
ruleset['f'] = function(signal,worker,world,api)
--put your lua code here
end


ruleset.color['g'] = 'reset'
ruleset.speed['g'] = 0
ruleset['g'] = function(signal,worker,world,api)
--put your lua code here
end


ruleset.color['h'] = 'reset'
ruleset.speed['h'] = 0
ruleset['h'] = function(signal,worker,world,api)
--put your lua code here
end


ruleset.color['i'] = 'reset'
ruleset.speed['i'] = 0
ruleset['i'] = function(signal,worker,world,api)
--put your lua code here
end


ruleset.color['j'] = 'reset'
ruleset.speed['j'] = 0
ruleset['j'] = function(signal,worker,world,api)
--put your lua code here
end


ruleset.color['k'] = 'reset'
ruleset.speed['k'] = 0
ruleset['k'] = function(signal,worker,world,api)
--put your lua code here
end


ruleset.color['l'] = 'reset'
ruleset.speed['l'] = 0
ruleset['l'] = function(signal,worker,world,api)
--put your lua code here
end


ruleset.color['m'] = 'reset'
ruleset.speed['m'] = 0
ruleset['m'] = function(signal,worker,world,api)
--put your lua code here
end


ruleset.color['n'] = 'reset'
ruleset.speed['n'] = 0
ruleset['n'] = function(signal,worker,world,api)
--put your lua code here
end


ruleset.color['o'] = 'reset'
ruleset.speed['o'] = 0
ruleset['o'] = function(signal,worker,world,api)
--put your lua code here
end


ruleset.color['p'] = 'reset'
ruleset.speed['p'] = 0
ruleset['p'] = function(signal,worker,world,api)
--put your lua code here
end


ruleset.color['q'] = 'reset'
ruleset.speed['q'] = 0
ruleset['q'] = function(signal,worker,world,api)
--put your lua code here
end


ruleset.color['r'] = 'reset'
ruleset.speed['r'] = 0
ruleset['r'] = function(signal,worker,world,api)
--put your lua code here
end


ruleset.color['s'] = 'reset'
ruleset.speed['s'] = 0
ruleset['s'] = function(signal,worker,world,api)
--put your lua code here
end


ruleset.color['t'] = 'reset'
ruleset.speed['t'] = 0
ruleset['t'] = function(signal,worker,world,api)
--put your lua code here
end


ruleset.color['u'] = 'reset'
ruleset.speed['u'] = 0
ruleset['u'] = function(signal,worker,world,api)
--put your lua code here
end


ruleset.color['v'] = 'reset'
ruleset.speed['v'] = 0
ruleset['v'] = function(signal,worker,world,api)
--put your lua code here
end


ruleset.color['w'] = 'reset'
ruleset.speed['w'] = 0
ruleset['w'] = function(signal,worker,world,api)
--put your lua code here
end


ruleset.color['x'] = 'reset'
ruleset.speed['x'] = 0
ruleset['x'] = function(signal,worker,world,api)
--put your lua code here
end


ruleset.color['y'] = 'reset'
ruleset.speed['y'] = 0
ruleset['y'] = function(signal,worker,world,api)
--put your lua code here
end


ruleset.color['z'] = 'reset'
ruleset.speed['z'] = 0
ruleset['z'] = function(signal,worker,world,api)
--put your lua code here
end


ruleset.color['A'] = 'reset'
ruleset.speed['A'] = 0
ruleset['A'] = function(signal,worker,world,api)
--put your lua code here
end


ruleset.color['B'] = 'reset'
ruleset.speed['B'] = 0
ruleset['B'] = function(signal,worker,world,api)
--put your lua code here
end


ruleset.color['C'] = 'reset'
ruleset.speed['C'] = 0
ruleset['C'] = function(signal,worker,world,api)
--put your lua code here
end


ruleset.color['D'] = 'reset'
ruleset.speed['D'] = 0
ruleset['D'] = function(signal,worker,world,api)
--put your lua code here
end


ruleset.color['E'] = 'reset'
ruleset.speed['E'] = 0
ruleset['E'] = function(signal,worker,world,api)
--put your lua code here
end


ruleset.color['F'] = 'reset'
ruleset.speed['F'] = 0
ruleset['F'] = function(signal,worker,world,api)
--put your lua code here
end


ruleset.color['G'] = 'reset'
ruleset.speed['G'] = 0
ruleset['G'] = function(signal,worker,world,api)
--put your lua code here
end


ruleset.color['H'] = 'reset'
ruleset.speed['H'] = 0
ruleset['H'] = function(signal,worker,world,api)
--put your lua code here
end


ruleset.color['I'] = 'reset'
ruleset.speed['I'] = 0
ruleset['I'] = function(signal,worker,world,api)
--put your lua code here
end


ruleset.color['J'] = 'reset'
ruleset.speed['J'] = 0
ruleset['J'] = function(signal,worker,world,api)
--put your lua code here
end


ruleset.color['K'] = 'reset'
ruleset.speed['K'] = 0
ruleset['K'] = function(signal,worker,world,api)
--put your lua code here
end


ruleset.color['L'] = 'reset'
ruleset.speed['L'] = 0
ruleset['L'] = function(signal,worker,world,api)
--put your lua code here
end


ruleset.color['M'] = 'reset'
ruleset.speed['M'] = 0
ruleset['M'] = function(signal,worker,world,api)
--put your lua code here
end


ruleset.color['N'] = 'reset'
ruleset.speed['N'] = 0
ruleset['N'] = function(signal,worker,world,api)
--put your lua code here
end


ruleset.color['O'] = 'reset'
ruleset.speed['O'] = 0
ruleset['O'] = function(signal,worker,world,api)
--put your lua code here
end


ruleset.color['P'] = 'reset'
ruleset.speed['P'] = 0
ruleset['P'] = function(signal,worker,world,api)
--put your lua code here
end


ruleset.color['Q'] = 'reset'
ruleset.speed['Q'] = 0
ruleset['Q'] = function(signal,worker,world,api)
--put your lua code here
end


ruleset.color['R'] = 'reset'
ruleset.speed['R'] = 0
ruleset['R'] = function(signal,worker,world,api)
--put your lua code here
end


ruleset.color['S'] = 'reset'
ruleset.speed['S'] = 0
ruleset['S'] = function(signal,worker,world,api)
--put your lua code here
end


ruleset.color['T'] = 'reset'
ruleset.speed['T'] = 0
ruleset['T'] = function(signal,worker,world,api)
--put your lua code here
end


ruleset.color['U'] = 'reset'
ruleset.speed['U'] = 0
ruleset['U'] = function(signal,worker,world,api)
--put your lua code here
end


ruleset.color['W'] = 'reset'
ruleset.speed['W'] = 0
ruleset['W'] = function(signal,worker,world,api)
--put your lua code here
end


ruleset.color['X'] = 'reset'
ruleset.speed['X'] = 0
ruleset['X'] = function(signal,worker,world,api)
--put your lua code here
end


ruleset.color['Y'] = 'reset'
ruleset.speed['Y'] = 0
ruleset['Y'] = function(signal,worker,world,api)
--put your lua code here
end


ruleset.color['Z'] = 'reset'
ruleset.speed['Z'] = 0
ruleset['Z'] = function(signal,worker,world,api)
--put your lua code here
end


ruleset.color['ç'] = 'reset'
ruleset.speed['ç'] = 0
ruleset['ç'] = function(signal,worker,world,api)
--put your lua code here
end


ruleset.color['Ç'] = 'reset'
ruleset.speed['Ç'] = 0
ruleset['Ç'] = function(signal,worker,world,api)
--put your lua code here
end


ruleset.color['ã'] = 'reset'
ruleset.speed['ã'] = 0
ruleset['ã'] = function(signal,worker,world,api)
--put your lua code here
end


ruleset.color['â'] = 'reset'
ruleset.speed['â'] = 0
ruleset['â'] = function(signal,worker,world,api)
--put your lua code here
end


ruleset.color['Â'] = 'reset'
ruleset.speed['Â'] = 0
ruleset['Â'] = function(signal,worker,world,api)
--put your lua code here
end


ruleset.color['Ã'] = 'reset'
ruleset.speed['Ã'] = 0
ruleset['Ã'] = function(signal,worker,world,api)
--put your lua code here
end


ruleset.color['á'] = 'reset'
ruleset.speed['á'] = 0
ruleset['á'] = function(signal,worker,world,api)
--put your lua code here
end


ruleset.color['à'] = 'reset'
ruleset.speed['à'] = 0
ruleset['à'] = function(signal,worker,world,api)
--put your lua code here
end


ruleset.color['Á'] = 'reset'
ruleset.speed['Á'] = 0
ruleset['Á'] = function(signal,worker,world,api)
--put your lua code here
end


ruleset.color['À'] = 'reset'
ruleset.speed['À'] = 0
ruleset['À'] = function(signal,worker,world,api)
--put your lua code here
end


ruleset.color['ä'] = 'reset'
ruleset.speed['ä'] = 0
ruleset['ä'] = function(signal,worker,world,api)
--put your lua code here
end


ruleset.color['Ä'] = 'reset'
ruleset.speed['Ä'] = 0
ruleset['Ä'] = function(signal,worker,world,api)
--put your lua code here
end


ruleset.color['ê'] = 'reset'
ruleset.speed['ê'] = 0
ruleset['ê'] = function(signal,worker,world,api)
--put your lua code here
end


ruleset.color['Ê'] = 'reset'
ruleset.speed['Ê'] = 0
ruleset['Ê'] = function(signal,worker,world,api)
--put your lua code here
end


ruleset.color['é'] = 'reset'
ruleset.speed['é'] = 0
ruleset['é'] = function(signal,worker,world,api)
--put your lua code here
end


ruleset.color['É'] = 'reset'
ruleset.speed['É'] = 0
ruleset['É'] = function(signal,worker,world,api)
--put your lua code here
end


ruleset.color['è'] = 'reset'
ruleset.speed['è'] = 0
ruleset['è'] = function(signal,worker,world,api)
--put your lua code here
end


ruleset.color['È'] = 'reset'
ruleset.speed['È'] = 0
ruleset['È'] = function(signal,worker,world,api)
--put your lua code here
end


ruleset.color['ë'] = 'reset'
ruleset.speed['ë'] = 0
ruleset['ë'] = function(signal,worker,world,api)
--put your lua code here
end


ruleset.color['Ë'] = 'reset'
ruleset.speed['Ë'] = 0
ruleset['Ë'] = function(signal,worker,world,api)
--put your lua code here
end


ruleset.color['î'] = 'reset'
ruleset.speed['î'] = 0
ruleset['î'] = function(signal,worker,world,api)
--put your lua code here
end


ruleset.color['Î'] = 'reset'
ruleset.speed['Î'] = 0
ruleset['Î'] = function(signal,worker,world,api)
--put your lua code here
end


ruleset.color['ï'] = 'reset'
ruleset.speed['ï'] = 0
ruleset['ï'] = function(signal,worker,world,api)
--put your lua code here
end


ruleset.color['Ï'] = 'reset'
ruleset.speed['Ï'] = 0
ruleset['Ï'] = function(signal,worker,world,api)
--put your lua code here
end


ruleset.color['í'] = 'reset'
ruleset.speed['í'] = 0
ruleset['í'] = function(signal,worker,world,api)
--put your lua code here
end


ruleset.color['Í'] = 'reset'
ruleset.speed['Í'] = 0
ruleset['Í'] = function(signal,worker,world,api)
--put your lua code here
end


ruleset.color['ì'] = 'reset'
ruleset.speed['ì'] = 0
ruleset['ì'] = function(signal,worker,world,api)
--put your lua code here
end


ruleset.color['Ì'] = 'reset'
ruleset.speed['Ì'] = 0
ruleset['Ì'] = function(signal,worker,world,api)
--put your lua code here
end


ruleset.color['õ'] = 'reset'
ruleset.speed['õ'] = 0
ruleset['õ'] = function(signal,worker,world,api)
--put your lua code here
end


ruleset.color['Õ'] = 'reset'
ruleset.speed['Õ'] = 0
ruleset['Õ'] = function(signal,worker,world,api)
--put your lua code here
end


ruleset.color['ô'] = 'reset'
ruleset.speed['ô'] = 0
ruleset['ô'] = function(signal,worker,world,api)
--put your lua code here
end


ruleset.color['Ô'] = 'reset'
ruleset.speed['Ô'] = 0
ruleset['Ô'] = function(signal,worker,world,api)
--put your lua code here
end


ruleset.color['ó'] = 'reset'
ruleset.speed['ó'] = 0
ruleset['ó'] = function(signal,worker,world,api)
--put your lua code here
end


ruleset.color['Ó'] = 'reset'
ruleset.speed['Ó'] = 0
ruleset['Ó'] = function(signal,worker,world,api)
--put your lua code here
end


ruleset.color['ò'] = 'reset'
ruleset.speed['ò'] = 0
ruleset['ò'] = function(signal,worker,world,api)
--put your lua code here
end


ruleset.color['Ò'] = 'reset'
ruleset.speed['Ò'] = 0
ruleset['Ò'] = function(signal,worker,world,api)
--put your lua code here
end


ruleset.color['ö'] = 'reset'
ruleset.speed['ö'] = 0
ruleset['ö'] = function(signal,worker,world,api)
--put your lua code here
end


ruleset.color['Ö'] = 'reset'
ruleset.speed['Ö'] = 0
ruleset['Ö'] = function(signal,worker,world,api)
--put your lua code here
end


ruleset.color['ú'] = 'reset'
ruleset.speed['ú'] = 0
ruleset['ú'] = function(signal,worker,world,api)
--put your lua code here
end


ruleset.color['Ú'] = 'reset'
ruleset.speed['Ú'] = 0
ruleset['Ú'] = function(signal,worker,world,api)
--put your lua code here
end


ruleset.color['ù'] = 'reset'
ruleset.speed['ù'] = 0
ruleset['ù'] = function(signal,worker,world,api)
--put your lua code here
end


ruleset.color['Ù'] = 'reset'
ruleset.speed['Ù'] = 0
ruleset['Ù'] = function(signal,worker,world,api)
--put your lua code here
end


ruleset.color['û'] = 'reset'
ruleset.speed['û'] = 0
ruleset['û'] = function(signal,worker,world,api)
--put your lua code here
end


ruleset.color['Û'] = 'reset'
ruleset.speed['Û'] = 0
ruleset['Û'] = function(signal,worker,world,api)
--put your lua code here
end


ruleset.color['ü'] = 'reset'
ruleset.speed['ü'] = 0
ruleset['ü'] = function(signal,worker,world,api)
--put your lua code here
end


ruleset.color['Ü'] = 'reset'
ruleset.speed['Ü'] = 0
ruleset['Ü'] = function(signal,worker,world,api)
--put your lua code here
end


ruleset.color['ñ'] = 'reset'
ruleset.speed['ñ'] = 0
ruleset['ñ'] = function(signal,worker,world,api)
--put your lua code here
end


ruleset.color['Ñ'] = 'reset'
ruleset.speed['Ñ'] = 0
ruleset['Ñ'] = function(signal,worker,world,api)
--put your lua code here
end


return ruleset
