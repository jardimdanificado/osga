local ruleset = {}
ruleset.auto = {}
ruleset.speed = {}

local combinations = 
{
  {x = -1, y = -1},
  {x = -1, y = 0},
  {x = -1, y = 1},
  {x = 0, y = -1},
  {x = 0, y = 0},
  {x = 0, y = 1},
  {x = 1, y = -1},
  {x = 1, y = 0},
  {x = 1, y = 1}
}

ruleset.auto['+'] = false
ruleset.speed['+'] = 1
ruleset['+'] = function(signal,worker,world,api)
  for i, v in ipairs(combinations) do
    if v.x ~= signal.direction.x *-1 or v.y ~= signal.direction.y *-1 then
      api.signal.emit(world,worker.position,combinations[i],signal.data)
    end
  end
  signal.position = nil
end

ruleset.auto['?'] = false
ruleset.speed['?'] = 2
ruleset['?'] = function(signal,worker,world,api)
  api.signal.emit(world,worker.position,combinations[api.util.random(1,#combinations+1)],signal.data)
  signal.position = nil
end

ruleset.auto['a'] = true
ruleset.speed['a'] = 2
ruleset['a'] = function(signal,worker,world,api)
    api.signal.emit(world,worker.position,{x=0,y=1},true,nil)
end

ruleset.auto['b'] = false
ruleset.speed['b'] = 2
ruleset['b'] = function(signal,worker,world,api)
    signal.direction = {x=1,y=0}
end

ruleset.auto['c'] = false
ruleset.speed['c'] = 2
ruleset['c'] = function(signal,worker,world,api)
--put your lua code here
end

ruleset.auto['d'] = false
ruleset.speed['d'] = 2
ruleset['d'] = function(signal,worker,world,api)
--put your lua code here
end

ruleset.auto['e'] = false
ruleset.speed['e'] = 2
ruleset['e'] = function(signal,worker,world,api)
--put your lua code here
end

ruleset.auto['f'] = false
ruleset.speed['f'] = 2
ruleset['f'] = function(signal,worker,world,api)
--put your lua code here
end

ruleset.auto['g'] = false
ruleset.speed['g'] = 2
ruleset['g'] = function(signal,worker,world,api)
--put your lua code here
end

ruleset.auto['h'] = false
ruleset.speed['h'] = 2
ruleset['h'] = function(signal,worker,world,api)
--put your lua code here
end

ruleset.auto['i'] = false
ruleset.speed['i'] = 2
ruleset['i'] = function(signal,worker,world,api)
--put your lua code here
end

ruleset.auto['j'] = false
ruleset.speed['j'] = 2
ruleset['j'] = function(signal,worker,world,api)
--put your lua code here
end

ruleset.auto['k'] = false
ruleset.speed['k'] = 2
ruleset['k'] = function(signal,worker,world,api)
--put your lua code here
end

ruleset.auto['l'] = false
ruleset.speed['l'] = 2
ruleset['l'] = function(signal,worker,world,api)
--put your lua code here
end

ruleset.auto['m'] = false
ruleset.speed['m'] = 2
ruleset['m'] = function(signal,worker,world,api)
--put your lua code here
end

ruleset.auto['n'] = false
ruleset.speed['n'] = 2
ruleset['n'] = function(signal,worker,world,api)
--put your lua code here
end

ruleset.auto['o'] = false
ruleset.speed['o'] = 2
ruleset['o'] = function(signal,worker,world,api)
--put your lua code here
end

ruleset.auto['p'] = false
ruleset.speed['p'] = 2
ruleset['p'] = function(signal,worker,world,api)
--put your lua code here
end

ruleset.auto['q'] = false
ruleset.speed['q'] = 2
ruleset['q'] = function(signal,worker,world,api)
--put your lua code here
end

ruleset.auto['r'] = false
ruleset.speed['r'] = 2
ruleset['r'] = function(signal,worker,world,api)
--put your lua code here
end

ruleset.auto['s'] = false
ruleset.speed['s'] = 2
ruleset['s'] = function(signal,worker,world,api)
--put your lua code here
end

ruleset.auto['t'] = false
ruleset.speed['t'] = 2
ruleset['t'] = function(signal,worker,world,api)
--put your lua code here
end

ruleset.auto['u'] = false
ruleset.speed['u'] = 2
ruleset['u'] = function(signal,worker,world,api)
--put your lua code here
end

ruleset.auto['v'] = false
ruleset.speed['v'] = 2
ruleset['v'] = function(signal,worker,world,api)
--put your lua code here
end

ruleset.auto['w'] = false
ruleset.speed['w'] = 2
ruleset['w'] = function(signal,worker,world,api)
--put your lua code here
end

ruleset.auto['x'] = false
ruleset.speed['x'] = 2
ruleset['x'] = function(signal,worker,world,api)
--put your lua code here
end

ruleset.auto['y'] = false
ruleset.speed['y'] = 2
ruleset['y'] = function(signal,worker,world,api)
--put your lua code here
end

ruleset.auto['z'] = false
ruleset.speed['z'] = 2
ruleset['z'] = function(signal,worker,world,api)
--put your lua code here
end

ruleset.auto['A'] = false
ruleset.speed['A'] = 2
ruleset['A'] = function(signal,worker,world,api)
--put your lua code here
end

ruleset.auto['B'] = false
ruleset.speed['B'] = 2
ruleset['B'] = function(signal,worker,world,api)
--put your lua code here
end

ruleset.auto['C'] = false
ruleset.speed['C'] = 2
ruleset['C'] = function(signal,worker,world,api)
--put your lua code here
end

ruleset.auto['D'] = false
ruleset.speed['D'] = 2
ruleset['D'] = function(signal,worker,world,api)
--put your lua code here
end

ruleset.auto['E'] = false
ruleset.speed['E'] = 2
ruleset['E'] = function(signal,worker,world,api)
--put your lua code here
end

ruleset.auto['F'] = false
ruleset.speed['F'] = 2
ruleset['F'] = function(signal,worker,world,api)
--put your lua code here
end

ruleset.auto['G'] = false
ruleset.speed['G'] = 2
ruleset['G'] = function(signal,worker,world,api)
--put your lua code here
end

ruleset.auto['H'] = false
ruleset.speed['H'] = 2
ruleset['H'] = function(signal,worker,world,api)
--put your lua code here
end

ruleset.auto['I'] = false
ruleset.speed['I'] = 2
ruleset['I'] = function(signal,worker,world,api)
--put your lua code here
end

ruleset.auto['J'] = false
ruleset.speed['J'] = 2
ruleset['J'] = function(signal,worker,world,api)
--put your lua code here
end

ruleset.auto['K'] = false
ruleset.speed['K'] = 2
ruleset['K'] = function(signal,worker,world,api)
--put your lua code here
end

ruleset.auto['L'] = false
ruleset.speed['L'] = 2
ruleset['L'] = function(signal,worker,world,api)
--put your lua code here
end

ruleset.auto['M'] = false
ruleset.speed['M'] = 2
ruleset['M'] = function(signal,worker,world,api)
--put your lua code here
end

ruleset.auto['N'] = false
ruleset.speed['N'] = 2
ruleset['N'] = function(signal,worker,world,api)
--put your lua code here
end

ruleset.auto['O'] = false
ruleset.speed['O'] = 2
ruleset['O'] = function(signal,worker,world,api)
--put your lua code here
end

ruleset.auto['P'] = false
ruleset.speed['P'] = 2
ruleset['P'] = function(signal,worker,world,api)
--put your lua code here
end

ruleset.auto['Q'] = false
ruleset.speed['Q'] = 2
ruleset['Q'] = function(signal,worker,world,api)
--put your lua code here
end

ruleset.auto['R'] = false
ruleset.speed['R'] = 2
ruleset['R'] = function(signal,worker,world,api)
--put your lua code here
end

ruleset.auto['S'] = false
ruleset.speed['S'] = 2
ruleset['S'] = function(signal,worker,world,api)
--put your lua code here
end

ruleset.auto['T'] = false
ruleset.speed['T'] = 2
ruleset['T'] = function(signal,worker,world,api)
--put your lua code here
end

ruleset.auto['U'] = false
ruleset.speed['U'] = 2
ruleset['U'] = function(signal,worker,world,api)
--put your lua code here
end

ruleset.auto['V'] = false
ruleset.speed['V'] = 2
ruleset['V'] = function(signal,worker,world,api)
--put your lua code here
end

ruleset.auto['W'] = false
ruleset.speed['W'] = 2
ruleset['W'] = function(signal,worker,world,api)
--put your lua code here
end

ruleset.auto['X'] = false
ruleset.speed['X'] = 2
ruleset['X'] = function(signal,worker,world,api)
--put your lua code here
end

ruleset.auto['Y'] = false
ruleset.speed['Y'] = 2
ruleset['Y'] = function(signal,worker,world,api)
--put your lua code here
end

ruleset.auto['Z'] = false
ruleset.speed['Z'] = 2
ruleset['Z'] = function(signal,worker,world,api)
--put your lua code here
end

ruleset.auto['ç'] = false
ruleset.speed['ç'] = 2
ruleset['ç'] = function(signal,worker,world,api)
--put your lua code here
end

ruleset.auto['Ç'] = false
ruleset.speed['Ç'] = 2
ruleset['Ç'] = function(signal,worker,world,api)
--put your lua code here
end

ruleset.auto['ã'] = false
ruleset.speed['ã'] = 2
ruleset['ã'] = function(signal,worker,world,api)
--put your lua code here
end

ruleset.auto['â'] = false
ruleset.speed['â'] = 2
ruleset['â'] = function(signal,worker,world,api)
--put your lua code here
end

ruleset.auto['Â'] = false
ruleset.speed['Â'] = 2
ruleset['Â'] = function(signal,worker,world,api)
--put your lua code here
end

ruleset.auto['Ã'] = false
ruleset.speed['Ã'] = 2
ruleset['Ã'] = function(signal,worker,world,api)
--put your lua code here
end

ruleset.auto['á'] = false
ruleset.speed['á'] = 2
ruleset['á'] = function(signal,worker,world,api)
--put your lua code here
end

ruleset.auto['à'] = false
ruleset.speed['à'] = 2
ruleset['à'] = function(signal,worker,world,api)
--put your lua code here
end

ruleset.auto['Á'] = false
ruleset.speed['Á'] = 2
ruleset['Á'] = function(signal,worker,world,api)
--put your lua code here
end

ruleset.auto['À'] = false
ruleset.speed['À'] = 2
ruleset['À'] = function(signal,worker,world,api)
--put your lua code here
end

ruleset.auto['ä'] = false
ruleset.speed['ä'] = 2
ruleset['ä'] = function(signal,worker,world,api)
--put your lua code here
end

ruleset.auto['Ä'] = false
ruleset.speed['Ä'] = 2
ruleset['Ä'] = function(signal,worker,world,api)
--put your lua code here
end

ruleset.auto['ê'] = false
ruleset.speed['ê'] = 2
ruleset['ê'] = function(signal,worker,world,api)
--put your lua code here
end

ruleset.auto['Ê'] = false
ruleset.speed['Ê'] = 2
ruleset['Ê'] = function(signal,worker,world,api)
--put your lua code here
end

ruleset.auto['é'] = false
ruleset.speed['é'] = 2
ruleset['é'] = function(signal,worker,world,api)
--put your lua code here
end

ruleset.auto['É'] = false
ruleset.speed['É'] = 2
ruleset['É'] = function(signal,worker,world,api)
--put your lua code here
end

ruleset.auto['è'] = false
ruleset.speed['è'] = 2
ruleset['è'] = function(signal,worker,world,api)
--put your lua code here
end

ruleset.auto['È'] = false
ruleset.speed['È'] = 2
ruleset['È'] = function(signal,worker,world,api)
--put your lua code here
end

ruleset.auto['ë'] = false
ruleset.speed['ë'] = 2
ruleset['ë'] = function(signal,worker,world,api)
--put your lua code here
end

ruleset.auto['Ë'] = false
ruleset.speed['Ë'] = 2
ruleset['Ë'] = function(signal,worker,world,api)
--put your lua code here
end

ruleset.auto['î'] = false
ruleset.speed['î'] = 2
ruleset['î'] = function(signal,worker,world,api)
--put your lua code here
end

ruleset.auto['Î'] = false
ruleset.speed['Î'] = 2
ruleset['Î'] = function(signal,worker,world,api)
--put your lua code here
end

ruleset.auto['ï'] = false
ruleset.speed['ï'] = 2
ruleset['ï'] = function(signal,worker,world,api)
--put your lua code here
end

ruleset.auto['Ï'] = false
ruleset.speed['Ï'] = 2
ruleset['Ï'] = function(signal,worker,world,api)
--put your lua code here
end

ruleset.auto['í'] = false
ruleset.speed['í'] = 2
ruleset['í'] = function(signal,worker,world,api)
--put your lua code here
end

ruleset.auto['Í'] = false
ruleset.speed['Í'] = 2
ruleset['Í'] = function(signal,worker,world,api)
--put your lua code here
end

ruleset.auto['ì'] = false
ruleset.speed['ì'] = 2
ruleset['ì'] = function(signal,worker,world,api)
--put your lua code here
end

ruleset.auto['Ì'] = false
ruleset.speed['Ì'] = 2
ruleset['Ì'] = function(signal,worker,world,api)
--put your lua code here
end

ruleset.auto['õ'] = false
ruleset.speed['õ'] = 2
ruleset['õ'] = function(signal,worker,world,api)
--put your lua code here
end

ruleset.auto['Õ'] = false
ruleset.speed['Õ'] = 2
ruleset['Õ'] = function(signal,worker,world,api)
--put your lua code here
end

ruleset.auto['ô'] = false
ruleset.speed['ô'] = 2
ruleset['ô'] = function(signal,worker,world,api)
--put your lua code here
end

ruleset.auto['Ô'] = false
ruleset.speed['Ô'] = 2
ruleset['Ô'] = function(signal,worker,world,api)
--put your lua code here
end

ruleset.auto['ó'] = false
ruleset.speed['ó'] = 2
ruleset['ó'] = function(signal,worker,world,api)
--put your lua code here
end

ruleset.auto['Ó'] = false
ruleset.speed['Ó'] = 2
ruleset['Ó'] = function(signal,worker,world,api)
--put your lua code here
end

ruleset.auto['ò'] = false
ruleset.speed['ò'] = 2
ruleset['ò'] = function(signal,worker,world,api)
--put your lua code here
end

ruleset.auto['Ò'] = false
ruleset.speed['Ò'] = 2
ruleset['Ò'] = function(signal,worker,world,api)
--put your lua code here
end

ruleset.auto['ö'] = false
ruleset.speed['ö'] = 2
ruleset['ö'] = function(signal,worker,world,api)
--put your lua code here
end

ruleset.auto['Ö'] = false
ruleset.speed['Ö'] = 2
ruleset['Ö'] = function(signal,worker,world,api)
--put your lua code here
end

ruleset.auto['ú'] = false
ruleset.speed['ú'] = 2
ruleset['ú'] = function(signal,worker,world,api)
--put your lua code here
end

ruleset.auto['Ú'] = false
ruleset.speed['Ú'] = 2
ruleset['Ú'] = function(signal,worker,world,api)
--put your lua code here
end

ruleset.auto['ù'] = false
ruleset.speed['ù'] = 2
ruleset['ù'] = function(signal,worker,world,api)
--put your lua code here
end

ruleset.auto['Ù'] = false
ruleset.speed['Ù'] = 2
ruleset['Ù'] = function(signal,worker,world,api)
--put your lua code here
end

ruleset.auto['û'] = false
ruleset.speed['û'] = 2
ruleset['û'] = function(signal,worker,world,api)
--put your lua code here
end

ruleset.auto['Û'] = false
ruleset.speed['Û'] = 2
ruleset['Û'] = function(signal,worker,world,api)
--put your lua code here
end

ruleset.auto['ü'] = false
ruleset.speed['ü'] = 2
ruleset['ü'] = function(signal,worker,world,api)
--put your lua code here
end

ruleset.auto['Ü'] = false
ruleset.speed['Ü'] = 2
ruleset['Ü'] = function(signal,worker,world,api)
--put your lua code here
end

ruleset.auto['ñ'] = false
ruleset.speed['ñ'] = 2
ruleset['ñ'] = function(signal,worker,world,api)
--put your lua code here
end

ruleset.auto['Ñ'] = false
ruleset.speed['Ñ'] = 2
ruleset['Ñ'] = function(signal,worker,world,api)
--put your lua code here
end

return ruleset
