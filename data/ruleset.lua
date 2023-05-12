local ruleset = {}
ruleset.defaults = {}
ruleset.auto = {}
ruleset.speed = {}

ruleset.speed['a'] = 2
ruleset.auto['a'] = true
ruleset.defaults['a'] = {}
ruleset['a'] = function(input,adv)
  adv.api.signal.emit(adv.world,adv.worker.position,{x=0,y=1},true,{4})
  --adv.world.session.message = "teste"
  return input 
end

ruleset.speed['b'] = 1
ruleset.auto['b'] = false
ruleset.defaults['b'] = {'a'}
ruleset['b'] = function(input,adv)
  adv.api.signal.emit(adv.world,adv.worker.position,{x=1,y=0},nil,input)
  return input 
end

ruleset.speed['c'] = 2
ruleset.auto['c'] = false
ruleset.defaults['c'] = {}
ruleset['c'] = function(input,advanced)
  return input 
end

ruleset.speed['d'] = 2
ruleset.auto['d'] = false
ruleset.defaults['d'] = {}
ruleset['d'] = function(input,advanced)
  return input 
end

ruleset.speed['e'] = 2
ruleset.auto['e'] = false
ruleset.defaults['e'] = {}
ruleset['e'] = function(input,advanced)
  return input 
end

ruleset.speed['f'] = 2
ruleset.auto['f'] = false
ruleset.defaults['f'] = {}
ruleset['f'] = function(input,advanced)
  return input 
end

ruleset.speed['g'] = 2
ruleset.auto['g'] = false
ruleset.defaults['g'] = {}
ruleset['g'] = function(input,advanced)
  return input 
end

ruleset.speed['h'] = 2
ruleset.auto['h'] = false
ruleset.defaults['h'] = {}
ruleset['h'] = function(input,advanced)
  return input 
end

ruleset.speed['i'] = 2
ruleset.auto['i'] = false
ruleset.defaults['i'] = {}
ruleset['i'] = function(input,advanced)
  return input 
end

ruleset.speed['j'] = 2
ruleset.auto['j'] = false
ruleset.defaults['j'] = {}
ruleset['j'] = function(input,advanced)
  return input 
end

ruleset.speed['k'] = 2
ruleset.auto['k'] = false
ruleset.defaults['k'] = {}
ruleset['k'] = function(input,advanced)
  return input 
end

ruleset.speed['l'] = 2
ruleset.auto['l'] = false
ruleset.defaults['l'] = {}
ruleset['l'] = function(input,advanced)
  return input 
end

ruleset.speed['m'] = 2
ruleset.auto['m'] = false
ruleset.defaults['m'] = {}
ruleset['m'] = function(input,advanced)
  return input 
end

ruleset.speed['n'] = 2
ruleset.auto['n'] = false
ruleset.defaults['n'] = {}
ruleset['n'] = function(input,advanced)
  return input 
end

ruleset.speed['o'] = 2
ruleset.auto['o'] = false
ruleset.defaults['o'] = {}
ruleset['o'] = function(input,advanced)
  return input 
end

ruleset.speed['p'] = 2
ruleset.auto['p'] = false
ruleset.defaults['p'] = {}
ruleset['p'] = function(input,advanced)
  return input 
end

ruleset.speed['q'] = 2
ruleset.auto['q'] = false
ruleset.defaults['q'] = {}
ruleset['q'] = function(input,advanced)
  return input 
end

ruleset.speed['r'] = 2
ruleset.auto['r'] = false
ruleset.defaults['r'] = {}
ruleset['r'] = function(input,advanced)
  return input 
end

ruleset.speed['s'] = 2
ruleset.auto['s'] = false
ruleset.defaults['s'] = {}
ruleset['s'] = function(input,advanced)
  return input 
end

ruleset.speed['t'] = 2
ruleset.auto['t'] = false
ruleset.defaults['t'] = {}
ruleset['t'] = function(input,advanced)
  return input 
end

ruleset.speed['u'] = 2
ruleset.auto['u'] = false
ruleset.defaults['u'] = {}
ruleset['u'] = function(input,advanced)
  return input 
end

ruleset.speed['v'] = 2
ruleset.auto['v'] = false
ruleset.defaults['v'] = {}
ruleset['v'] = function(input,advanced)
  return input 
end

ruleset.speed['w'] = 2
ruleset.auto['w'] = false
ruleset.defaults['w'] = {}
ruleset['w'] = function(input,advanced)
  return input 
end

ruleset.speed['x'] = 2
ruleset.auto['x'] = false
ruleset.defaults['x'] = {}
ruleset['x'] = function(input,advanced)
  return input 
end

ruleset.speed['y'] = 2
ruleset.auto['y'] = false
ruleset.defaults['y'] = {}
ruleset['y'] = function(input,advanced)
  return input 
end

ruleset.speed['z'] = 2
ruleset.auto['z'] = false
ruleset.defaults['z'] = {}
ruleset['z'] = function(input,advanced)
  return input 
end

ruleset.speed['A'] = 2
ruleset.auto['A'] = false
ruleset.defaults['A'] = {}
ruleset['A'] = function(input,advanced)
  return input 
end

ruleset.speed['B'] = 2
ruleset.auto['B'] = false
ruleset.defaults['B'] = {}
ruleset['B'] = function(input,advanced)
  return input 
end

ruleset.speed['C'] = 2
ruleset.auto['C'] = false
ruleset.defaults['C'] = {}
ruleset['C'] = function(input,advanced)
  return input 
end

ruleset.speed['D'] = 2
ruleset.auto['D'] = false
ruleset.defaults['D'] = {}
ruleset['D'] = function(input,advanced)
  return input 
end

ruleset.speed['E'] = 2
ruleset.auto['E'] = false
ruleset.defaults['E'] = {}
ruleset['E'] = function(input,advanced)
  return input 
end

ruleset.speed['F'] = 2
ruleset.auto['F'] = false
ruleset.defaults['F'] = {}
ruleset['F'] = function(input,advanced)
  return input 
end

ruleset.speed['G'] = 2
ruleset.auto['G'] = false
ruleset.defaults['G'] = {}
ruleset['G'] = function(input,advanced)
  return input 
end

ruleset.speed['H'] = 2
ruleset.auto['H'] = false
ruleset.defaults['H'] = {}
ruleset['H'] = function(input,advanced)
  return input 
end

ruleset.speed['I'] = 2
ruleset.auto['I'] = false
ruleset.defaults['I'] = {}
ruleset['I'] = function(input,advanced)
  return input 
end

ruleset.speed['J'] = 2
ruleset.auto['J'] = false
ruleset.defaults['J'] = {}
ruleset['J'] = function(input,advanced)
  return input 
end

ruleset.speed['K'] = 2
ruleset.auto['K'] = false
ruleset.defaults['K'] = {}
ruleset['K'] = function(input,advanced)
  return input 
end

ruleset.speed['L'] = 2
ruleset.auto['L'] = false
ruleset.defaults['L'] = {}
ruleset['L'] = function(input,advanced)
  return input 
end

ruleset.speed['M'] = 2
ruleset.auto['M'] = false
ruleset.defaults['M'] = {}
ruleset['M'] = function(input,advanced)
  return input 
end

ruleset.speed['N'] = 2
ruleset.auto['N'] = false
ruleset.defaults['N'] = {}
ruleset['N'] = function(input,advanced)
  return input 
end

ruleset.speed['O'] = 2
ruleset.auto['O'] = false
ruleset.defaults['O'] = {}
ruleset['O'] = function(input,advanced)
  return input 
end

ruleset.speed['P'] = 2
ruleset.auto['P'] = false
ruleset.defaults['P'] = {}
ruleset['P'] = function(input,advanced)
  return input 
end

ruleset.speed['Q'] = 2
ruleset.auto['Q'] = false
ruleset.defaults['Q'] = {}
ruleset['Q'] = function(input,advanced)
  return input 
end

ruleset.speed['R'] = 2
ruleset.auto['R'] = false
ruleset.defaults['R'] = {}
ruleset['R'] = function(input,advanced)
  return input 
end

ruleset.speed['S'] = 2
ruleset.auto['S'] = false
ruleset.defaults['S'] = {}
ruleset['S'] = function(input,advanced)
  return input 
end

ruleset.speed['T'] = 2
ruleset.auto['T'] = false
ruleset.defaults['T'] = {}
ruleset['T'] = function(input,advanced)
  return input 
end

ruleset.speed['U'] = 2
ruleset.auto['U'] = false
ruleset.defaults['U'] = {}
ruleset['U'] = function(input,advanced)
  return input 
end

ruleset.speed['V'] = 2
ruleset.auto['V'] = false
ruleset.defaults['V'] = {}
ruleset['V'] = function(input,advanced)
  return input 
end

ruleset.speed['W'] = 2
ruleset.auto['W'] = false
ruleset.defaults['W'] = {}
ruleset['W'] = function(input,advanced)
  return input 
end

ruleset.speed['X'] = 2
ruleset.auto['X'] = false
ruleset.defaults['X'] = {}
ruleset['X'] = function(input,advanced)
  return input 
end

ruleset.speed['Y'] = 2
ruleset.auto['Y'] = false
ruleset.defaults['Y'] = {}
ruleset['Y'] = function(input,advanced)
  return input 
end

ruleset.speed['Z'] = 2
ruleset.auto['Z'] = false
ruleset.defaults['Z'] = {}
ruleset['Z'] = function(input,advanced)
  return input 
end

ruleset.speed['ç'] = 2
ruleset.auto['ç'] = false
ruleset.defaults['ç'] = {}
ruleset['ç'] = function(input,advanced)
  return input 
end

ruleset.speed['Ç'] = 2
ruleset.auto['Ç'] = false
ruleset.defaults['Ç'] = {}
ruleset['Ç'] = function(input,advanced)
  return input 
end

ruleset.speed['ã'] = 2
ruleset.auto['ã'] = false
ruleset.defaults['ã'] = {}
ruleset['ã'] = function(input,advanced)
  return input 
end

ruleset.speed['â'] = 2
ruleset.auto['â'] = false
ruleset.defaults['â'] = {}
ruleset['â'] = function(input,advanced)
  return input 
end

ruleset.speed['Â'] = 2
ruleset.auto['Â'] = false
ruleset.defaults['Â'] = {}
ruleset['Â'] = function(input,advanced)
  return input 
end

ruleset.speed['Ã'] = 2
ruleset.auto['Ã'] = false
ruleset.defaults['Ã'] = {}
ruleset['Ã'] = function(input,advanced)
  return input 
end

ruleset.speed['á'] = 2
ruleset.auto['á'] = false
ruleset.defaults['á'] = {}
ruleset['á'] = function(input,advanced)
  return input 
end

ruleset.speed['à'] = 2
ruleset.auto['à'] = false
ruleset.defaults['à'] = {}
ruleset['à'] = function(input,advanced)
  return input 
end

ruleset.speed['Á'] = 2
ruleset.auto['Á'] = false
ruleset.defaults['Á'] = {}
ruleset['Á'] = function(input,advanced)
  return input 
end

ruleset.speed['À'] = 2
ruleset.auto['À'] = false
ruleset.defaults['À'] = {}
ruleset['À'] = function(input,advanced)
  return input 
end

ruleset.speed['ä'] = 2
ruleset.auto['ä'] = false
ruleset.defaults['ä'] = {}
ruleset['ä'] = function(input,advanced)
  return input 
end

ruleset.speed['Ä'] = 2
ruleset.auto['Ä'] = false
ruleset.defaults['Ä'] = {}
ruleset['Ä'] = function(input,advanced)
  return input 
end

ruleset.speed['ê'] = 2
ruleset.auto['ê'] = false
ruleset.defaults['ê'] = {}
ruleset['ê'] = function(input,advanced)
  return input 
end

ruleset.speed['Ê'] = 2
ruleset.auto['Ê'] = false
ruleset.defaults['Ê'] = {}
ruleset['Ê'] = function(input,advanced)
  return input 
end

ruleset.speed['é'] = 2
ruleset.auto['é'] = false
ruleset.defaults['é'] = {}
ruleset['é'] = function(input,advanced)
  return input 
end

ruleset.speed['É'] = 2
ruleset.auto['É'] = false
ruleset.defaults['É'] = {}
ruleset['É'] = function(input,advanced)
  return input 
end

ruleset.speed['è'] = 2
ruleset.auto['è'] = false
ruleset.defaults['è'] = {}
ruleset['è'] = function(input,advanced)
  return input 
end

ruleset.speed['È'] = 2
ruleset.auto['È'] = false
ruleset.defaults['È'] = {}
ruleset['È'] = function(input,advanced)
  return input 
end

ruleset.speed['ë'] = 2
ruleset.auto['ë'] = false
ruleset.defaults['ë'] = {}
ruleset['ë'] = function(input,advanced)
  return input 
end

ruleset.speed['Ë'] = 2
ruleset.auto['Ë'] = false
ruleset.defaults['Ë'] = {}
ruleset['Ë'] = function(input,advanced)
  return input 
end

ruleset.speed['î'] = 2
ruleset.auto['î'] = false
ruleset.defaults['î'] = {}
ruleset['î'] = function(input,advanced)
  return input 
end

ruleset.speed['Î'] = 2
ruleset.auto['Î'] = false
ruleset.defaults['Î'] = {}
ruleset['Î'] = function(input,advanced)
  return input 
end

ruleset.speed['ï'] = 2
ruleset.auto['ï'] = false
ruleset.defaults['ï'] = {}
ruleset['ï'] = function(input,advanced)
  return input 
end

ruleset.speed['Ï'] = 2
ruleset.auto['Ï'] = false
ruleset.defaults['Ï'] = {}
ruleset['Ï'] = function(input,advanced)
  return input 
end

ruleset.speed['í'] = 2
ruleset.auto['í'] = false
ruleset.defaults['í'] = {}
ruleset['í'] = function(input,advanced)
  return input 
end

ruleset.speed['Í'] = 2
ruleset.auto['Í'] = false
ruleset.defaults['Í'] = {}
ruleset['Í'] = function(input,advanced)
  return input 
end

ruleset.speed['ì'] = 2
ruleset.auto['ì'] = false
ruleset.defaults['ì'] = {}
ruleset['ì'] = function(input,advanced)
  return input 
end

ruleset.speed['Ì'] = 2
ruleset.auto['Ì'] = false
ruleset.defaults['Ì'] = {}
ruleset['Ì'] = function(input,advanced)
  return input 
end

ruleset.speed['õ'] = 2
ruleset.auto['õ'] = false
ruleset.defaults['õ'] = {}
ruleset['õ'] = function(input,advanced)
  return input 
end

ruleset.speed['Õ'] = 2
ruleset.auto['Õ'] = false
ruleset.defaults['Õ'] = {}
ruleset['Õ'] = function(input,advanced)
  return input 
end

ruleset.speed['ô'] = 2
ruleset.auto['ô'] = false
ruleset.defaults['ô'] = {}
ruleset['ô'] = function(input,advanced)
  return input 
end

ruleset.speed['Ô'] = 2
ruleset.auto['Ô'] = false
ruleset.defaults['Ô'] = {}
ruleset['Ô'] = function(input,advanced)
  return input 
end

ruleset.speed['ó'] = 2
ruleset.auto['ó'] = false
ruleset.defaults['ó'] = {}
ruleset['ó'] = function(input,advanced)
  return input 
end

ruleset.speed['Ó'] = 2
ruleset.auto['Ó'] = false
ruleset.defaults['Ó'] = {}
ruleset['Ó'] = function(input,advanced)
  return input 
end

ruleset.speed['ò'] = 2
ruleset.auto['ò'] = false
ruleset.defaults['ò'] = {}
ruleset['ò'] = function(input,advanced)
  return input 
end

ruleset.speed['Ò'] = 2
ruleset.auto['Ò'] = false
ruleset.defaults['Ò'] = {}
ruleset['Ò'] = function(input,advanced)
  return input 
end

ruleset.speed['ö'] = 2
ruleset.auto['ö'] = false
ruleset.defaults['ö'] = {}
ruleset['ö'] = function(input,advanced)
  return input 
end

ruleset.speed['Ö'] = 2
ruleset.auto['Ö'] = false
ruleset.defaults['Ö'] = {}
ruleset['Ö'] = function(input,advanced)
  return input 
end

ruleset.speed['ú'] = 2
ruleset.auto['ú'] = false
ruleset.defaults['ú'] = {}
ruleset['ú'] = function(input,advanced)
  return input 
end

ruleset.speed['Ú'] = 2
ruleset.auto['Ú'] = false
ruleset.defaults['Ú'] = {}
ruleset['Ú'] = function(input,advanced)
  return input 
end

ruleset.speed['ù'] = 2
ruleset.auto['ù'] = false
ruleset.defaults['ù'] = {}
ruleset['ù'] = function(input,advanced)
  return input 
end

ruleset.speed['Ù'] = 2
ruleset.auto['Ù'] = false
ruleset.defaults['Ù'] = {}
ruleset['Ù'] = function(input,advanced)
  return input 
end

ruleset.speed['û'] = 2
ruleset.auto['û'] = false
ruleset.defaults['û'] = {}
ruleset['û'] = function(input,advanced)
  return input 
end

ruleset.speed['Û'] = 2
ruleset.auto['Û'] = false
ruleset.defaults['Û'] = {}
ruleset['Û'] = function(input,advanced)
  return input 
end

ruleset.speed['ü'] = 2
ruleset.auto['ü'] = false
ruleset.defaults['ü'] = {}
ruleset['ü'] = function(input,advanced)
  return input 
end

ruleset.speed['Ü'] = 2
ruleset.auto['Ü'] = false
ruleset.defaults['Ü'] = {}
ruleset['Ü'] = function(input,advanced)
  return input 
end

ruleset.speed['ñ'] = 2
ruleset.auto['ñ'] = false
ruleset.defaults['ñ'] = {}
ruleset['ñ'] = function(input,advanced)
  return input 
end

ruleset.speed['Ñ'] = 2
ruleset.auto['Ñ'] = false
ruleset.defaults['Ñ'] = {}
ruleset['Ñ'] = function(input,advanced)
  return input 
end

return ruleset
