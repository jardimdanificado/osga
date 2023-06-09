local ruleset = {}
ruleset.worker = {}
ruleset.worker.rate = {}
ruleset.worker.color = {}
ruleset.signal = {}
ruleset.command = {}

ruleset.signal.destroyer = function(signal,worker,world,api)
    if signal.position ~= nil and world.map[signal.position.x][signal.position.y] ~= '.' then
        world.map[signal.position.x][signal.position.y].position = nil
        world.map[signal.position.x][signal.position.y] = '.'
        signal.position = nil
    end
end

ruleset.signal.pusher = function(signal,_,world,api)
    local sum = 
    {
        x = signal.position.x + signal.direction.x,
        y = signal.position.y + signal.direction.y,
    }
    if signal.position ~= nil and 
    world.map[signal.position.x][signal.position.y] ~= nil and
    world.map[sum.x][sum.y] ~= nil then

        if world.map[signal.position.x][signal.position.y] ~= '.' and
        world.map[sum.x][sum.y] == '.' then
            local worker = world.map[signal.position.x][signal.position.y]
            world.map[signal.position.x][signal.position.y] = '.'
            world.map[sum.x][sum.y] = worker
            worker.position.x = sum.x
            worker.position.y = sum.y
            
            signal.position = nil
        end
    else
        signal.position = nil
    end
end

ruleset.signal.puller = function(signal,_,world,api)
    local sum = 
    {
        x = (signal.position.x + signal.direction.x*-1),
        y = (signal.position.y + signal.direction.y*-1),
    }
    if signal.position ~= nil and 
    world.map[signal.position.x][signal.position.y] ~= nil and
    world.map[sum.x] ~= nil and world.map[sum.x][sum.y] ~= nil then

        if world.map[signal.position.x][signal.position.y] ~= '.' and
        world.map[sum.x][sum.y] == '.' then
            local worker = world.map[signal.position.x][signal.position.y]
            world.map[signal.position.x][signal.position.y] = '.'
            world.map[sum.x][sum.y] = worker
            worker.position.x = sum.x
            worker.position.y = sum.y
            
            signal.position = nil
        end
    else
        signal.position = nil
    end
end


ruleset.worker.color['<'] = 'yellow'
ruleset.worker.rate['<'] = 0
ruleset.worker['<'] = function(signal,worker,world,api)
    signal.direction = {x=0,y=-1} -- x = up/down, y = right/left
end


ruleset.worker.color['>'] = 'yellow'
ruleset.worker.rate['>'] = 0
ruleset.worker['>'] = function(signal,worker,world,api)
    signal.direction = {x=0,y=1} -- x = up/down, y = right/left
end


ruleset.worker.color['^'] = 'yellow'
ruleset.worker.rate['^'] = 0
ruleset.worker['^'] = function(signal,worker,world,api)
    signal.direction = {x=-1,y=0} -- x = up/down, y = right/left
end


ruleset.worker.color['V'] = 'yellow'
ruleset.worker.rate['V'] = 0
ruleset.worker['V'] = function(signal,worker,world,api)
    signal.direction = {x=1,y=0} -- x = up/down, y = right/left
end


ruleset.worker.color['|'] = 'yellow'
ruleset.worker.rate['|'] = 0
ruleset.worker['|'] = function(signal,worker,world,api)
    signal.direction = {x = signal.direction.x*-1, y = signal.direction.y *-1}
    worker.color = signal.color
end


ruleset.worker.color['-'] = 'red'
ruleset.worker.rate['-'] = 0
ruleset.worker['-'] = function(signal,worker,world,api)
    signal.position = nil
end


ruleset.worker.color['?'] = 'blue'
ruleset.worker.rate['?'] = 0
ruleset.worker['?'] = function(signal,worker,world,api)
    signal.direction = api.directions[api.util.random(1,#api.directions)]
    worker.color = signal.color
end


ruleset.worker.color['+'] = 'blue'
ruleset.worker.rate['+'] = 0
ruleset.worker['+'] = function(signal,worker,world,api)
    for i, v in ipairs(api.directions) do
        if v.x == 0 or v.y == 0 then
          local sig = api.signal.emit(world,worker.position,api.directions[i],signal.data)
          sig.color = signal.color
          worker.color = signal.color
        end
      end
      signal.position = nil
end


ruleset.worker.color['X'] = 'blue'
ruleset.worker.rate['X'] = 0
ruleset.worker['X'] = function(signal,worker,world,api)
    for i, v in ipairs(api.directions) do
        if v.x ~= 0 and v.y ~= 0 then
            local sig = api.signal.emit(world,worker.position,api.directions[i],signal.data)
            sig.color = signal.color
            worker.color = signal.color
        end
    end
    signal.position = nil
end


ruleset.worker.color['$'] = 'blue'
ruleset.worker.rate['$'] = 0
ruleset.worker['$'] = function(signal,worker,world,api)
    local sig
    for i, v in ipairs(api.directions) do
        sig = api.signal.emit(world,worker.position,api.directions[i],signal.data)
        worker.color = sig.color
        sig.color = signal.color
    end
    signal.position = nil
end


ruleset.worker.color['&'] = 'magenta'
ruleset.worker.rate['&'] = 0
ruleset.worker['&'] = function(signal,worker,world,api)
    if signal.data ~= nil then
        table.insert(worker.data,signal.data)
    elseif #worker.data > 0 then
        for i, v in ipairs(worker.data) do
            api.signal.emit(world,worker.position,{x = signal.direction.x, y = signal.direction.y},v)
            worker.data[i] = nil
            break
        end
    end
    signal.position = nil
end

--[[ printer, deprecated in 1.2
ruleset.worker.color['!'] = 'magenta'
ruleset.worker.rate['!'] = 0
ruleset.worker['!'] = function(signal,worker,world,api)
    if signal.data ~= nil then
        table.insert(world.session.print,{timer=signal.data.timer, str = signal.data.str, position = {x=worker.position.x,y=worker.position.y}})
        signal.position = nil
    end
end
--]]

ruleset.worker.color['%'] = 'magenta' --unpacker
ruleset.worker.rate['%'] = 0
ruleset.worker['%'] = function(signal,worker,world,api)
    if signal.data ~= nil then
        for i, v in ipairs(signal.data) do
            api.signal.emit(world,signal.position,signal.direction,v)
        end
    end
    signal.position = nil
end


ruleset.worker.color['¬'] = 'magenta' --packer
ruleset.worker.rate['¬'] = 0
ruleset.worker['¬'] = function(signal,worker,world,api)
    if signal.data == nil then
        table.insert(worker.data,signal.data)
    else
        api.signal.emit(world,signal.position,signal.direction,worker.data)
        signal.data = {}
    end
end

ruleset.worker.color['a'] = 'reset'
ruleset.worker.rate['a'] = 4
ruleset.worker['a'] = function(signal,worker,world,api)
--put your lua code here
end


ruleset.worker.color['b'] = 'reset'
ruleset.worker.rate['b'] = 16
ruleset.worker['b'] = function(signal,worker,world,api)
--put your lua code here
end


ruleset.worker.color['c'] = 'reset'
ruleset.worker.rate['c'] = 0
ruleset.worker['c'] = function(signal,worker,world,api)
--put your lua code here
end


ruleset.worker.color['d'] = 'reset'
ruleset.worker.rate['d'] = 0
ruleset.worker['d'] = function(signal,worker,world,api)
--put your lua code here
end


ruleset.worker.color['e'] = 'reset'
ruleset.worker.rate['e'] = 0
ruleset.worker['e'] = function(signal,worker,world,api)
--put your lua code here
end


ruleset.worker.color['f'] = 'reset'
ruleset.worker.rate['f'] = 0
ruleset.worker['f'] = function(signal,worker,world,api)
--put your lua code here
end


ruleset.worker.color['g'] = 'reset'
ruleset.worker.rate['g'] = 0
ruleset.worker['g'] = function(signal,worker,world,api)
--put your lua code here
end


ruleset.worker.color['h'] = 'reset'
ruleset.worker.rate['h'] = 0
ruleset.worker['h'] = function(signal,worker,world,api)
--put your lua code here
end


ruleset.worker.color['i'] = 'reset'
ruleset.worker.rate['i'] = 0
ruleset.worker['i'] = function(signal,worker,world,api)
--put your lua code here
end


ruleset.worker.color['j'] = 'reset'
ruleset.worker.rate['j'] = 0
ruleset.worker['j'] = function(signal,worker,world,api)
--put your lua code here
end


ruleset.worker.color['k'] = 'reset'
ruleset.worker.rate['k'] = 0
ruleset.worker['k'] = function(signal,worker,world,api)
--put your lua code here
end


ruleset.worker.color['l'] = 'reset'
ruleset.worker.rate['l'] = 0
ruleset.worker['l'] = function(signal,worker,world,api)
--put your lua code here
end


ruleset.worker.color['m'] = 'reset'
ruleset.worker.rate['m'] = 0
ruleset.worker['m'] = function(signal,worker,world,api)
--put your lua code here
end


ruleset.worker.color['n'] = 'reset'
ruleset.worker.rate['n'] = 0
ruleset.worker['n'] = function(signal,worker,world,api)
--put your lua code here
end


ruleset.worker.color['o'] = 'reset'
ruleset.worker.rate['o'] = 0
ruleset.worker['o'] = function(signal,worker,world,api)
--put your lua code here
end


ruleset.worker.color['p'] = 'reset'
ruleset.worker.rate['p'] = 0
ruleset.worker['p'] = function(signal,worker,world,api)
--put your lua code here
end


ruleset.worker.color['q'] = 'reset'
ruleset.worker.rate['q'] = 0
ruleset.worker['q'] = function(signal,worker,world,api)
--put your lua code here
end


ruleset.worker.color['r'] = 'reset'
ruleset.worker.rate['r'] = 0
ruleset.worker['r'] = function(signal,worker,world,api)
--put your lua code here
end


ruleset.worker.color['s'] = 'reset'
ruleset.worker.rate['s'] = 0
ruleset.worker['s'] = function(signal,worker,world,api)
--put your lua code here
end


ruleset.worker.color['t'] = 'reset'
ruleset.worker.rate['t'] = 0
ruleset.worker['t'] = function(signal,worker,world,api)
--put your lua code here
end


ruleset.worker.color['u'] = 'reset'
ruleset.worker.rate['u'] = 0
ruleset.worker['u'] = function(signal,worker,world,api)
--put your lua code here
end


ruleset.worker.color['v'] = 'reset'
ruleset.worker.rate['v'] = 0
ruleset.worker['v'] = function(signal,worker,world,api)
--put your lua code here
end


ruleset.worker.color['w'] = 'reset'
ruleset.worker.rate['w'] = 0
ruleset.worker['w'] = function(signal,worker,world,api)
--put your lua code here
end


ruleset.worker.color['x'] = 'reset'
ruleset.worker.rate['x'] = 0
ruleset.worker['x'] = function(signal,worker,world,api)
--put your lua code here
end


ruleset.worker.color['y'] = 'reset'
ruleset.worker.rate['y'] = 0
ruleset.worker['y'] = function(signal,worker,world,api)
--put your lua code here
end


ruleset.worker.color['z'] = 'reset'
ruleset.worker.rate['z'] = 0
ruleset.worker['z'] = function(signal,worker,world,api)
--put your lua code here
end


ruleset.worker.color['A'] = 'reset'
ruleset.worker.rate['A'] = 0
ruleset.worker['A'] = function(signal,worker,world,api)
--put your lua code here
end


ruleset.worker.color['B'] = 'reset'
ruleset.worker.rate['B'] = 0
ruleset.worker['B'] = function(signal,worker,world,api)
--put your lua code here
end


ruleset.worker.color['C'] = 'reset'
ruleset.worker.rate['C'] = 0
ruleset.worker['C'] = function(signal,worker,world,api)
--put your lua code here
end


ruleset.worker.color['D'] = 'reset'
ruleset.worker.rate['D'] = 0
ruleset.worker['D'] = function(signal,worker,world,api)
--put your lua code here
end


ruleset.worker.color['E'] = 'reset'
ruleset.worker.rate['E'] = 0
ruleset.worker['E'] = function(signal,worker,world,api)
--put your lua code here
end


ruleset.worker.color['F'] = 'reset'
ruleset.worker.rate['F'] = 0
ruleset.worker['F'] = function(signal,worker,world,api)
--put your lua code here
end


ruleset.worker.color['G'] = 'reset'
ruleset.worker.rate['G'] = 0
ruleset.worker['G'] = function(signal,worker,world,api)
--put your lua code here
end


ruleset.worker.color['H'] = 'reset'
ruleset.worker.rate['H'] = 0
ruleset.worker['H'] = function(signal,worker,world,api)
--put your lua code here
end


ruleset.worker.color['I'] = 'reset'
ruleset.worker.rate['I'] = 0
ruleset.worker['I'] = function(signal,worker,world,api)
--put your lua code here
end


ruleset.worker.color['J'] = 'reset'
ruleset.worker.rate['J'] = 0
ruleset.worker['J'] = function(signal,worker,world,api)
--put your lua code here
end


ruleset.worker.color['K'] = 'reset'
ruleset.worker.rate['K'] = 0
ruleset.worker['K'] = function(signal,worker,world,api)
--put your lua code here
end


ruleset.worker.color['L'] = 'reset'
ruleset.worker.rate['L'] = 0
ruleset.worker['L'] = function(signal,worker,world,api)
--put your lua code here
end


ruleset.worker.color['M'] = 'reset'
ruleset.worker.rate['M'] = 0
ruleset.worker['M'] = function(signal,worker,world,api)
--put your lua code here
end


ruleset.worker.color['N'] = 'reset'
ruleset.worker.rate['N'] = 0
ruleset.worker['N'] = function(signal,worker,world,api)
--put your lua code here
end


ruleset.worker.color['O'] = 'reset'
ruleset.worker.rate['O'] = 0
ruleset.worker['O'] = function(signal,worker,world,api)
--put your lua code here
end


ruleset.worker.color['P'] = 'reset'
ruleset.worker.rate['P'] = 0
ruleset.worker['P'] = function(signal,worker,world,api)
--put your lua code here
end


ruleset.worker.color['Q'] = 'reset'
ruleset.worker.rate['Q'] = 0
ruleset.worker['Q'] = function(signal,worker,world,api)
--put your lua code here
end


ruleset.worker.color['R'] = 'reset'
ruleset.worker.rate['R'] = 0
ruleset.worker['R'] = function(signal,worker,world,api)
--put your lua code here
end


ruleset.worker.color['S'] = 'reset'
ruleset.worker.rate['S'] = 0
ruleset.worker['S'] = function(signal,worker,world,api)
--put your lua code here
end


ruleset.worker.color['T'] = 'reset'
ruleset.worker.rate['T'] = 0
ruleset.worker['T'] = function(signal,worker,world,api)
--put your lua code here
end


ruleset.worker.color['U'] = 'reset'
ruleset.worker.rate['U'] = 0
ruleset.worker['U'] = function(signal,worker,world,api)
--put your lua code here
end


ruleset.worker.color['W'] = 'reset'
ruleset.worker.rate['W'] = 0
ruleset.worker['W'] = function(signal,worker,world,api)
--put your lua code here
end


ruleset.worker.color['Y'] = 'reset'
ruleset.worker.rate['Y'] = 0
ruleset.worker['Y'] = function(signal,worker,world,api)
--put your lua code here
end


ruleset.worker.color['Z'] = 'reset'
ruleset.worker.rate['Z'] = 0
ruleset.worker['Z'] = function(signal,worker,world,api)
--put your lua code here
end


ruleset.worker.color['ç'] = 'reset'
ruleset.worker.rate['ç'] = 0
ruleset.worker['ç'] = function(signal,worker,world,api)
--put your lua code here
end


ruleset.worker.color['Ç'] = 'reset'
ruleset.worker.rate['Ç'] = 0
ruleset.worker['Ç'] = function(signal,worker,world,api)
--put your lua code here
end


ruleset.worker.color['ã'] = 'reset'
ruleset.worker.rate['ã'] = 0
ruleset.worker['ã'] = function(signal,worker,world,api)
--put your lua code here
end


ruleset.worker.color['â'] = 'reset'
ruleset.worker.rate['â'] = 0
ruleset.worker['â'] = function(signal,worker,world,api)
--put your lua code here
end


ruleset.worker.color['Â'] = 'reset'
ruleset.worker.rate['Â'] = 0
ruleset.worker['Â'] = function(signal,worker,world,api)
--put your lua code here
end


ruleset.worker.color['Ã'] = 'reset'
ruleset.worker.rate['Ã'] = 0
ruleset.worker['Ã'] = function(signal,worker,world,api)
--put your lua code here
end


ruleset.worker.color['á'] = 'reset'
ruleset.worker.rate['á'] = 0
ruleset.worker['á'] = function(signal,worker,world,api)
--put your lua code here
end


ruleset.worker.color['à'] = 'reset'
ruleset.worker.rate['à'] = 0
ruleset.worker['à'] = function(signal,worker,world,api)
--put your lua code here
end


ruleset.worker.color['Á'] = 'reset'
ruleset.worker.rate['Á'] = 0
ruleset.worker['Á'] = function(signal,worker,world,api)
--put your lua code here
end


ruleset.worker.color['À'] = 'reset'
ruleset.worker.rate['À'] = 0
ruleset.worker['À'] = function(signal,worker,world,api)
--put your lua code here
end


ruleset.worker.color['ä'] = 'reset'
ruleset.worker.rate['ä'] = 0
ruleset.worker['ä'] = function(signal,worker,world,api)
--put your lua code here
end


ruleset.worker.color['Ä'] = 'reset'
ruleset.worker.rate['Ä'] = 0
ruleset.worker['Ä'] = function(signal,worker,world,api)
--put your lua code here
end


ruleset.worker.color['ê'] = 'reset'
ruleset.worker.rate['ê'] = 0
ruleset.worker['ê'] = function(signal,worker,world,api)
--put your lua code here
end


ruleset.worker.color['Ê'] = 'reset'
ruleset.worker.rate['Ê'] = 0
ruleset.worker['Ê'] = function(signal,worker,world,api)
--put your lua code here
end


ruleset.worker.color['é'] = 'reset'
ruleset.worker.rate['é'] = 0
ruleset.worker['é'] = function(signal,worker,world,api)
--put your lua code here
end


ruleset.worker.color['É'] = 'reset'
ruleset.worker.rate['É'] = 0
ruleset.worker['É'] = function(signal,worker,world,api)
--put your lua code here
end


ruleset.worker.color['è'] = 'reset'
ruleset.worker.rate['è'] = 0
ruleset.worker['è'] = function(signal,worker,world,api)
--put your lua code here
end


ruleset.worker.color['È'] = 'reset'
ruleset.worker.rate['È'] = 0
ruleset.worker['È'] = function(signal,worker,world,api)
--put your lua code here
end


ruleset.worker.color['ë'] = 'reset'
ruleset.worker.rate['ë'] = 0
ruleset.worker['ë'] = function(signal,worker,world,api)
--put your lua code here
end


ruleset.worker.color['Ë'] = 'reset'
ruleset.worker.rate['Ë'] = 0
ruleset.worker['Ë'] = function(signal,worker,world,api)
--put your lua code here
end


ruleset.worker.color['î'] = 'reset'
ruleset.worker.rate['î'] = 0
ruleset.worker['î'] = function(signal,worker,world,api)
--put your lua code here
end


ruleset.worker.color['Î'] = 'reset'
ruleset.worker.rate['Î'] = 0
ruleset.worker['Î'] = function(signal,worker,world,api)
--put your lua code here
end


ruleset.worker.color['ï'] = 'reset'
ruleset.worker.rate['ï'] = 0
ruleset.worker['ï'] = function(signal,worker,world,api)
--put your lua code here
end


ruleset.worker.color['Ï'] = 'reset'
ruleset.worker.rate['Ï'] = 0
ruleset.worker['Ï'] = function(signal,worker,world,api)
--put your lua code here
end


ruleset.worker.color['í'] = 'reset'
ruleset.worker.rate['í'] = 0
ruleset.worker['í'] = function(signal,worker,world,api)
--put your lua code here
end


ruleset.worker.color['Í'] = 'reset'
ruleset.worker.rate['Í'] = 0
ruleset.worker['Í'] = function(signal,worker,world,api)
--put your lua code here
end


ruleset.worker.color['ì'] = 'reset'
ruleset.worker.rate['ì'] = 0
ruleset.worker['ì'] = function(signal,worker,world,api)
--put your lua code here
end


ruleset.worker.color['Ì'] = 'reset'
ruleset.worker.rate['Ì'] = 0
ruleset.worker['Ì'] = function(signal,worker,world,api)
--put your lua code here
end


ruleset.worker.color['õ'] = 'reset'
ruleset.worker.rate['õ'] = 0
ruleset.worker['õ'] = function(signal,worker,world,api)
--put your lua code here
end


ruleset.worker.color['Õ'] = 'reset'
ruleset.worker.rate['Õ'] = 0
ruleset.worker['Õ'] = function(signal,worker,world,api)
--put your lua code here
end


ruleset.worker.color['ô'] = 'reset'
ruleset.worker.rate['ô'] = 0
ruleset.worker['ô'] = function(signal,worker,world,api)
--put your lua code here
end


ruleset.worker.color['Ô'] = 'reset'
ruleset.worker.rate['Ô'] = 0
ruleset.worker['Ô'] = function(signal,worker,world,api)
--put your lua code here
end


ruleset.worker.color['ó'] = 'reset'
ruleset.worker.rate['ó'] = 0
ruleset.worker['ó'] = function(signal,worker,world,api)
--put your lua code here
end


ruleset.worker.color['Ó'] = 'reset'
ruleset.worker.rate['Ó'] = 0
ruleset.worker['Ó'] = function(signal,worker,world,api)
--put your lua code here
end


ruleset.worker.color['ò'] = 'reset'
ruleset.worker.rate['ò'] = 0
ruleset.worker['ò'] = function(signal,worker,world,api)
--put your lua code here
end


ruleset.worker.color['Ò'] = 'reset'
ruleset.worker.rate['Ò'] = 0
ruleset.worker['Ò'] = function(signal,worker,world,api)
--put your lua code here
end


ruleset.worker.color['ö'] = 'reset'
ruleset.worker.rate['ö'] = 0
ruleset.worker['ö'] = function(signal,worker,world,api)
--put your lua code here
end


ruleset.worker.color['Ö'] = 'reset'
ruleset.worker.rate['Ö'] = 0
ruleset.worker['Ö'] = function(signal,worker,world,api)
--put your lua code here
end


ruleset.worker.color['ú'] = 'reset'
ruleset.worker.rate['ú'] = 0
ruleset.worker['ú'] = function(signal,worker,world,api)
--put your lua code here
end


ruleset.worker.color['Ú'] = 'reset'
ruleset.worker.rate['Ú'] = 0
ruleset.worker['Ú'] = function(signal,worker,world,api)
--put your lua code here
end


ruleset.worker.color['ù'] = 'reset'
ruleset.worker.rate['ù'] = 0
ruleset.worker['ù'] = function(signal,worker,world,api)
--put your lua code here
end


ruleset.worker.color['Ù'] = 'reset'
ruleset.worker.rate['Ù'] = 0
ruleset.worker['Ù'] = function(signal,worker,world,api)
--put your lua code here
end


ruleset.worker.color['û'] = 'reset'
ruleset.worker.rate['û'] = 0
ruleset.worker['û'] = function(signal,worker,world,api)
--put your lua code here
end


ruleset.worker.color['Û'] = 'reset'
ruleset.worker.rate['Û'] = 0
ruleset.worker['Û'] = function(signal,worker,world,api)
--put your lua code here
end


ruleset.worker.color['ü'] = 'reset'
ruleset.worker.rate['ü'] = 0
ruleset.worker['ü'] = function(signal,worker,world,api)
--put your lua code here
end


ruleset.worker.color['Ü'] = 'reset'
ruleset.worker.rate['Ü'] = 0
ruleset.worker['Ü'] = function(signal,worker,world,api)
--put your lua code here
end


ruleset.worker.color['ñ'] = 'reset'
ruleset.worker.rate['ñ'] = 0
ruleset.worker['ñ'] = function(signal,worker,world,api)
--put your lua code here
end


ruleset.worker.color['Ñ'] = 'reset'
ruleset.worker.rate['Ñ'] = 0
ruleset.worker['Ñ'] = function(signal,worker,world,api)
--put your lua code here
end

ruleset.command.run = function(world,api,args)
    api.run(world, api.util.file.load.text(args[1]))
end

ruleset.command.add = function(world,api,args)
    if #args >= 3 then
        api.worker.spawn(world, {
            x = tonumber(args[2]),
            y = tonumber(args[3])
        }, args[1], args[4] or 2)
    end
end

ruleset.command.load = function(world,api,args)
    world.signal = {}
    world.worker = {}
    world.map = api.new.map(world, args[1])
    world.session.map = args[1]
end

ruleset.command.new = function(world,api,args)
    world.map = api.util.matrix.new(args[1],args[2],'.')
end

ruleset.command['$'] = function(world,api,args,cmd)
    cmd = api.util.string.replace(cmd, ">>>", 'os.execute("') .. '")'
    assert(api.util.load(cmd))()
    api.run(world)
end

ruleset.command['>>'] = function(world,api,args,cmd)
    cmd = api.util.string.replace(cmd, ">>", '')
    assert(api.util.load(cmd))()
    api.run(world)
end

ruleset.command.expose = function(_world,_api,args,cmd)
    world = _world
    api = _api
    api.run(world)
end

ruleset.command.rm = function(world,api,args)
    if world.map[tonumber(args[1])][tonumber(args[2])] ~= '.' then
        world.session.cposi = {
            x = tonumber(args[1]),
            y = tonumber(args[2])
        }
        world.map[tonumber(args[1])][tonumber(args[2])].position = nil
        world.map[tonumber(args[1])][tonumber(args[2])] = '.'
    end
end

ruleset.command.turn = function(world,api,args)
    if type(world.session.config[args[1]]) == 'boolean' then
        world.session.config[args[1]] = api.util.turn(world.session.config[args[1]])
    else
        print("\n\27[32mavaliable to turn:\27[0m")
        for k, v in pairs(world.session.config) do
            if type(v) == 'boolean' then
                print(k)
            end
        end
        print()
        api.run(world)
    end
end

ruleset.command.skip = function(world,api,args)
    world.session.skip = tonumber(args[1])
    print("please wait...")
end

ruleset.command.pause = function(world,api,args)
    api.run(world)
end

ruleset.command.exit = function(world,api,args)
    world.session.config.exit = true
end

ruleset.command['end'] = function(world,api,args)
    os.exit()
end

ruleset.command.count = function(world,api,args)
    if args[1] == nil then
        print("Active workers: " .. #world.worker)
        print("Active signals: " .. #world.signal)
    elseif api.util.string.includes(args[1],'worker') then
        print("Active workers: " .. #world.worker)
    elseif api.util.string.includes(args[1],'signal') then
        print("Active signals: " .. #world.signal)
    end
    api.run(world)
end

ruleset.command.echo = function(world,api,args) --unblocked
    for i, v in ipairs(args) do
        io.write(v .. ' ')
    end
    io.write('\n')
end

ruleset.command.print = function(world,api,args) --blocked, user need to press enter or type a command to continue
    for i, v in ipairs(args) do
        io.write(v .. ' ')
    end
    io.write('\n')
    api.run(world)
end

ruleset.command.write = function(world,api,args)
    local text = ''
    for i, v in ipairs(world.session.loadedscripts) do
        text = text .. 'require ' .. v .. '\n'
    end
    text = text .. 'new ' .. #world.map .. ' ' .. #world.map[1] .. '\n'
    for x = 1, #world.map, 1 do
        for y = 1, #world.map[x], 1 do
            if world.map[x][y] ~= '.' then
                text = text .. 'add ' .. world.map[x][y].id .. ' ' .. x .. ' ' .. y .. '\n'
            end
        end
    end
    
    api.util.file.save.text(args[1],text)
end

ruleset.command.save = function(world,api,args)
    if args[1] ~= nil then
        api.util.file.save.charMap(args[1], world.map)
    else
        api.util.file.save.charMap(world.session.mapname, world.map)
    end
end

ruleset.command.help = function(world,api,args)
    io.write("\27[32mAvaliable commands:\27[0m ")
    for k, v in pairs(world.ruleset.command) do
        io.write(k .. ', ') 
    end
    io.write('\n')
    api.run(world)
end

return ruleset
