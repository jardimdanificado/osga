local ruleset = {}
ruleset.defaults = {}
ruleset.auto = {}

ruleset.auto['a'] = true
ruleset.defaults['a'] = {}
ruleset['a'] = function(input,adv)
  adv.api.signal.emit(adv.world,adv.worker.position,{x=0,y=1},true,{4})
  --adv.world.session.status = "teste"
  return input 
end

ruleset.auto['b'] = false
ruleset.defaults['b'] = {'a'}
ruleset['b'] = function(input,adv)
  adv.api.signal.emit(adv.world,adv.worker.position,{x=1,y=0},nil,input)
  return input 
end

ruleset.auto['c'] = false
ruleset.defaults['c'] = {}
ruleset['c'] = function(input,advanced)
  return input 
end

ruleset.auto['d'] = false
ruleset.defaults['d'] = {}
ruleset['d'] = function(input,advanced)
  return input 
end

ruleset.auto['e'] = false
ruleset.defaults['e'] = {}
ruleset['e'] = function(input,advanced)
  return input 
end

ruleset.auto['f'] = false
ruleset.defaults['f'] = {}
ruleset['f'] = function(input,advanced)
  return input 
end

ruleset.auto['g'] = false
ruleset.defaults['g'] = {}
ruleset['g'] = function(input,advanced)
  return input 
end

ruleset.auto['h'] = false
ruleset.defaults['h'] = {}
ruleset['h'] = function(input,advanced)
  return input 
end

ruleset.auto['i'] = false
ruleset.defaults['i'] = {}
ruleset['i'] = function(input,advanced)
  return input 
end

ruleset.auto['j'] = false
ruleset.defaults['j'] = {}
ruleset['j'] = function(input,advanced)
  return input 
end

ruleset.auto['k'] = false
ruleset.defaults['k'] = {}
ruleset['k'] = function(input,advanced)
  return input 
end

ruleset.auto['l'] = false
ruleset.defaults['l'] = {}
ruleset['l'] = function(input,advanced)
  return input 
end

ruleset.auto['m'] = false
ruleset.defaults['m'] = {}
ruleset['m'] = function(input,advanced)
  return input 
end

ruleset.auto['n'] = false
ruleset.defaults['n'] = {}
ruleset['n'] = function(input,advanced)
  return input 
end

ruleset.auto['o'] = false
ruleset.defaults['o'] = {}
ruleset['o'] = function(input,advanced)
  return input 
end

ruleset.auto['p'] = false
ruleset.defaults['p'] = {}
ruleset['p'] = function(input,advanced)
  return input 
end

ruleset.auto['q'] = false
ruleset.defaults['q'] = {}
ruleset['q'] = function(input,advanced)
  return input 
end

ruleset.auto['r'] = false
ruleset.defaults['r'] = {}
ruleset['r'] = function(input,advanced)
  return input 
end

ruleset.auto['s'] = false
ruleset.defaults['s'] = {}
ruleset['s'] = function(input,advanced)
  return input 
end

ruleset.auto['t'] = false
ruleset.defaults['t'] = {}
ruleset['t'] = function(input,advanced)
  return input 
end

ruleset.auto['u'] = false
ruleset.defaults['u'] = {}
ruleset['u'] = function(input,advanced)
  return input 
end

ruleset.auto['v'] = false
ruleset.defaults['v'] = {}
ruleset['v'] = function(input,advanced)
  return input 
end

ruleset.auto['w'] = false
ruleset.defaults['w'] = {}
ruleset['w'] = function(input,advanced)
  return input 
end

ruleset.auto['x'] = false
ruleset.defaults['x'] = {}
ruleset['x'] = function(input,advanced)
  return input 
end

ruleset.auto['y'] = false
ruleset.defaults['y'] = {}
ruleset['y'] = function(input,advanced)
  return input 
end

ruleset.auto['z'] = false
ruleset.defaults['z'] = {}
ruleset['z'] = function(input,advanced)
  return input 
end

ruleset.auto['A'] = false
ruleset.defaults['A'] = {}
ruleset['A'] = function(input,advanced)
  return input 
end

ruleset.auto['B'] = false
ruleset.defaults['B'] = {}
ruleset['B'] = function(input,advanced)
  return input 
end

ruleset.auto['C'] = false
ruleset.defaults['C'] = {}
ruleset['C'] = function(input,advanced)
  return input 
end

ruleset.auto['D'] = false
ruleset.defaults['D'] = {}
ruleset['D'] = function(input,advanced)
  return input 
end

ruleset.auto['E'] = false
ruleset.defaults['E'] = {}
ruleset['E'] = function(input,advanced)
  return input 
end

ruleset.auto['F'] = false
ruleset.defaults['F'] = {}
ruleset['F'] = function(input,advanced)
  return input 
end

ruleset.auto['G'] = false
ruleset.defaults['G'] = {}
ruleset['G'] = function(input,advanced)
  return input 
end

ruleset.auto['H'] = false
ruleset.defaults['H'] = {}
ruleset['H'] = function(input,advanced)
  return input 
end

ruleset.auto['I'] = false
ruleset.defaults['I'] = {}
ruleset['I'] = function(input,advanced)
  return input 
end

ruleset.auto['J'] = false
ruleset.defaults['J'] = {}
ruleset['J'] = function(input,advanced)
  return input 
end

ruleset.auto['K'] = false
ruleset.defaults['K'] = {}
ruleset['K'] = function(input,advanced)
  return input 
end

ruleset.auto['L'] = false
ruleset.defaults['L'] = {}
ruleset['L'] = function(input,advanced)
  return input 
end

ruleset.auto['M'] = false
ruleset.defaults['M'] = {}
ruleset['M'] = function(input,advanced)
  return input 
end

ruleset.auto['N'] = false
ruleset.defaults['N'] = {}
ruleset['N'] = function(input,advanced)
  return input 
end

ruleset.auto['O'] = false
ruleset.defaults['O'] = {}
ruleset['O'] = function(input,advanced)
  return input 
end

ruleset.auto['P'] = false
ruleset.defaults['P'] = {}
ruleset['P'] = function(input,advanced)
  return input 
end

ruleset.auto['Q'] = false
ruleset.defaults['Q'] = {}
ruleset['Q'] = function(input,advanced)
  return input 
end

ruleset.auto['R'] = false
ruleset.defaults['R'] = {}
ruleset['R'] = function(input,advanced)
  return input 
end

ruleset.auto['S'] = false
ruleset.defaults['S'] = {}
ruleset['S'] = function(input,advanced)
  return input 
end

ruleset.auto['T'] = false
ruleset.defaults['T'] = {}
ruleset['T'] = function(input,advanced)
  return input 
end

ruleset.auto['U'] = false
ruleset.defaults['U'] = {}
ruleset['U'] = function(input,advanced)
  return input 
end

ruleset.auto['V'] = false
ruleset.defaults['V'] = {}
ruleset['V'] = function(input,advanced)
  return input 
end

ruleset.auto['W'] = false
ruleset.defaults['W'] = {}
ruleset['W'] = function(input,advanced)
  return input 
end

ruleset.auto['X'] = false
ruleset.defaults['X'] = {}
ruleset['X'] = function(input,advanced)
  return input 
end

ruleset.auto['Y'] = false
ruleset.defaults['Y'] = {}
ruleset['Y'] = function(input,advanced)
  return input 
end

ruleset.auto['Z'] = false
ruleset.defaults['Z'] = {}
ruleset['Z'] = function(input,advanced)
  return input 
end

ruleset.auto['ç'] = false
ruleset.defaults['ç'] = {}
ruleset['ç'] = function(input,advanced)
  return input 
end

ruleset.auto['Ç'] = false
ruleset.defaults['Ç'] = {}
ruleset['Ç'] = function(input,advanced)
  return input 
end

ruleset.auto['ã'] = false
ruleset.defaults['ã'] = {}
ruleset['ã'] = function(input,advanced)
  return input 
end

ruleset.auto['â'] = false
ruleset.defaults['â'] = {}
ruleset['â'] = function(input,advanced)
  return input 
end

ruleset.auto['Â'] = false
ruleset.defaults['Â'] = {}
ruleset['Â'] = function(input,advanced)
  return input 
end

ruleset.auto['Ã'] = false
ruleset.defaults['Ã'] = {}
ruleset['Ã'] = function(input,advanced)
  return input 
end

ruleset.auto['á'] = false
ruleset.defaults['á'] = {}
ruleset['á'] = function(input,advanced)
  return input 
end

ruleset.auto['à'] = false
ruleset.defaults['à'] = {}
ruleset['à'] = function(input,advanced)
  return input 
end

ruleset.auto['Á'] = false
ruleset.defaults['Á'] = {}
ruleset['Á'] = function(input,advanced)
  return input 
end

ruleset.auto['À'] = false
ruleset.defaults['À'] = {}
ruleset['À'] = function(input,advanced)
  return input 
end

ruleset.auto['ä'] = false
ruleset.defaults['ä'] = {}
ruleset['ä'] = function(input,advanced)
  return input 
end

ruleset.auto['Ä'] = false
ruleset.defaults['Ä'] = {}
ruleset['Ä'] = function(input,advanced)
  return input 
end

ruleset.auto['ê'] = false
ruleset.defaults['ê'] = {}
ruleset['ê'] = function(input,advanced)
  return input 
end

ruleset.auto['Ê'] = false
ruleset.defaults['Ê'] = {}
ruleset['Ê'] = function(input,advanced)
  return input 
end

ruleset.auto['é'] = false
ruleset.defaults['é'] = {}
ruleset['é'] = function(input,advanced)
  return input 
end

ruleset.auto['É'] = false
ruleset.defaults['É'] = {}
ruleset['É'] = function(input,advanced)
  return input 
end

ruleset.auto['è'] = false
ruleset.defaults['è'] = {}
ruleset['è'] = function(input,advanced)
  return input 
end

ruleset.auto['È'] = false
ruleset.defaults['È'] = {}
ruleset['È'] = function(input,advanced)
  return input 
end

ruleset.auto['ë'] = false
ruleset.defaults['ë'] = {}
ruleset['ë'] = function(input,advanced)
  return input 
end

ruleset.auto['Ë'] = false
ruleset.defaults['Ë'] = {}
ruleset['Ë'] = function(input,advanced)
  return input 
end

ruleset.auto['î'] = false
ruleset.defaults['î'] = {}
ruleset['î'] = function(input,advanced)
  return input 
end

ruleset.auto['Î'] = false
ruleset.defaults['Î'] = {}
ruleset['Î'] = function(input,advanced)
  return input 
end

ruleset.auto['ï'] = false
ruleset.defaults['ï'] = {}
ruleset['ï'] = function(input,advanced)
  return input 
end

ruleset.auto['Ï'] = false
ruleset.defaults['Ï'] = {}
ruleset['Ï'] = function(input,advanced)
  return input 
end

ruleset.auto['í'] = false
ruleset.defaults['í'] = {}
ruleset['í'] = function(input,advanced)
  return input 
end

ruleset.auto['Í'] = false
ruleset.defaults['Í'] = {}
ruleset['Í'] = function(input,advanced)
  return input 
end

ruleset.auto['ì'] = false
ruleset.defaults['ì'] = {}
ruleset['ì'] = function(input,advanced)
  return input 
end

ruleset.auto['Ì'] = false
ruleset.defaults['Ì'] = {}
ruleset['Ì'] = function(input,advanced)
  return input 
end

ruleset.auto['õ'] = false
ruleset.defaults['õ'] = {}
ruleset['õ'] = function(input,advanced)
  return input 
end

ruleset.auto['Õ'] = false
ruleset.defaults['Õ'] = {}
ruleset['Õ'] = function(input,advanced)
  return input 
end

ruleset.auto['ô'] = false
ruleset.defaults['ô'] = {}
ruleset['ô'] = function(input,advanced)
  return input 
end

ruleset.auto['Ô'] = false
ruleset.defaults['Ô'] = {}
ruleset['Ô'] = function(input,advanced)
  return input 
end

ruleset.auto['ó'] = false
ruleset.defaults['ó'] = {}
ruleset['ó'] = function(input,advanced)
  return input 
end

ruleset.auto['Ó'] = false
ruleset.defaults['Ó'] = {}
ruleset['Ó'] = function(input,advanced)
  return input 
end

ruleset.auto['ò'] = false
ruleset.defaults['ò'] = {}
ruleset['ò'] = function(input,advanced)
  return input 
end

ruleset.auto['Ò'] = false
ruleset.defaults['Ò'] = {}
ruleset['Ò'] = function(input,advanced)
  return input 
end

ruleset.auto['ö'] = false
ruleset.defaults['ö'] = {}
ruleset['ö'] = function(input,advanced)
  return input 
end

ruleset.auto['Ö'] = false
ruleset.defaults['Ö'] = {}
ruleset['Ö'] = function(input,advanced)
  return input 
end

ruleset.auto['ú'] = false
ruleset.defaults['ú'] = {}
ruleset['ú'] = function(input,advanced)
  return input 
end

ruleset.auto['Ú'] = false
ruleset.defaults['Ú'] = {}
ruleset['Ú'] = function(input,advanced)
  return input 
end

ruleset.auto['ù'] = false
ruleset.defaults['ù'] = {}
ruleset['ù'] = function(input,advanced)
  return input 
end

ruleset.auto['Ù'] = false
ruleset.defaults['Ù'] = {}
ruleset['Ù'] = function(input,advanced)
  return input 
end

ruleset.auto['û'] = false
ruleset.defaults['û'] = {}
ruleset['û'] = function(input,advanced)
  return input 
end

ruleset.auto['Û'] = false
ruleset.defaults['Û'] = {}
ruleset['Û'] = function(input,advanced)
  return input 
end

ruleset.auto['ü'] = false
ruleset.defaults['ü'] = {}
ruleset['ü'] = function(input,advanced)
  return input 
end

ruleset.auto['Ü'] = false
ruleset.defaults['Ü'] = {}
ruleset['Ü'] = function(input,advanced)
  return input 
end

ruleset.auto['ñ'] = false
ruleset.defaults['ñ'] = {}
ruleset['ñ'] = function(input,advanced)
  return input 
end

ruleset.auto['Ñ'] = false
ruleset.defaults['Ñ'] = {}
ruleset['Ñ'] = function(input,advanced)
  return input 
end

return ruleset
