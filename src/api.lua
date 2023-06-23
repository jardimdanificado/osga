local util = require('src.util')
local api = {}
api.util = util

api.directions = 
{
  {x = -1, y = -1},
  {x = -1, y = 0},
  {x = -1, y = 1},
  {x = 0, y = -1},
  {x = 0, y = 1},
  {x = 1, y = -1},
  {x = 1, y = 0},
  {x = 1, y = 1}
}

api.colors = 
{
    "black","green","yellow","blue","magenta","cyan","white","reset"
}

api.new = {
    vec2 = function(x, y)
        return {
            x = x,
            y = y
        }
    end,
    signal = function(position, direction, data, func)
        return {
            direction = direction or {
                x = 1,
                y = 0
            },
            data = data,
            position = position,
            color = 'white',
            func = func or function() end
        }
    end,
    worker = function(ruleset, id, position, timer, speed, color, data)
        return {
            id = id,
            func = ruleset.worker[id],
            position = position,
            direction = {x=0,y=0},
            timer = timer,
            speed = speed,
            color = color or 'white',
            data = data or {}
        }
    end,
    map = function(world, filepath)
        
        local charmap = api.util.file.load.charMap(filepath)
        
        world.map = util.matrix.new(#charmap, #charmap[1], '.')
        for x, vx in ipairs(charmap) do
            for y, vy in ipairs(vx) do
                if vy ~= '.' then
                    charmap[x][y] = api.worker.spawn(world, {
                        x = x,
                        y = y
                    }, vy, 2)
                else
                    charmap[x][y] = '.'
                end
            end
        end
        return charmap
    end,
    world = function(sizex, sizey)
        local world = 
        {
            ruleset = 
            {

                worker = 
                {         
                    color = {},
                    speed = {}
                },
                signal = {},
                command = 
                {
                    require = function(world,api,args)
                        local templib
                        if not api.util.string.includes(args[1],'lib.') and not api.util.string.includes(args[1],'/') and not api.util.string.includes(args[1],'\\') then
                            templib = require('lib.' .. args[1])
                        else
                            templib = require(
                                api.util.string.replace(
                                    api.util.string.replace(
                                        api.util.string.replace(args[1],'.lua',''),'/','.'),'\\','.'))
                        end
                        local keys = util.array.keys(templib.worker)
                        for i, k in ipairs(keys) do
                            if k ~= 'speed' and k ~= 'color' then
                                world.ruleset.worker[k] = templib.worker[k]
                                world.ruleset.worker.color[k] = templib.worker.color[k]
                                world.ruleset.worker.speed[k] = templib.worker.speed[k]
                            end
                        end
                        for k, v in pairs(templib.command) do
                            world.ruleset.command[k] = v
                        end
                        for k, v in pairs(templib.signal) do
                            world.ruleset.signal[k] = v
                        end
                            
                        table.insert(world.session.loadedscripts,api.util.string.replace(api.util.string.replace(args[1],'.lua',''),'/','.'))
                    end,
                    import = function(world,api,args)
                        if not api.util.file.exist(args[1]) then
                            return
                        end
                        local templib = dofile(args[1])
                        local keys = util.array.keys(templib.worker)
                        for i, k in ipairs(keys) do
                            if k ~= 'speed' and k ~= 'color' then
                                world.ruleset.worker[k] = templib.worker[k]
                                world.ruleset.worker.color[k] = templib.worker.color[k]
                                world.ruleset.worker.speed[k] = templib.worker.speed[k]
                            end
                        end
                        for k, v in pairs(templib.command) do
                            world.ruleset.command[k] = v
                        end
                        for k, v in pairs(templib.signal) do
                            world.ruleset.signal[k] = v
                        end
                            
                        table.insert(world.session.loadedscripts,args[1])
                    end,
                    collect = function(world,api,args) -- garbagecollect
                        if args[1] ~= nil then
                            if tonumber(args[1]) ~= nil then
                                world.session.garbagecollector = args[1] or world.session.garbagecollector
                            else
                                print('current garbage collecting rate: ' .. world.session.garbagecollector)
                                api.run(world)
                                return
                            end
                        end
                        local temp = {}
                        for i, signal in ipairs(world.signal) do
                            if signal ~= nil and signal.position ~= nil then
                                table.insert(temp, signal)
                            end
                        end
                        world.signal = temp
                        temp = {}
                        for i, worker in ipairs(world.worker) do
                            local temp2 = {}
                            if worker.id == '&' then --if bank
                                for i, v in ipairs(worker.data) do
                                    table.insert(temp2,v)
                                end
                                worker.data = temp2
                            end
                            if worker ~= nil and worker.position ~= nil then
                                table.insert(temp, worker)
                            end
                        end
                        world.worker = temp
                    end
                }
            },
            signal = {},
            worker = {},
            session = {
                time = 1,
                skip = 0,
                garbagecollector = 17,-- 0 disable garbage collecting
                config = {exit = false, renderskip = true},
                loadedscripts = {}
            }
        }
        world.map = util.matrix.new(sizex,sizey,'.')
        world.ruleset.command['-r'] = world.ruleset.command.require
        world.ruleset.command['-i'] = world.ruleset.command.import
        world.ruleset.command['-c'] = world.ruleset.command.collect
        return world
    end
}

api.signal = {
    emit = function(world, position, direction, data, func)

        table.insert(world.signal, api.new.signal(position, direction, data, func))
        
        return world.signal[#world.signal]
    end
}

api.worker = {
    spawn = function(world, position, id, timer, speed)
        speed = speed or world.ruleset.worker.speed[id]
        if world.map[position.x][position.y] == '.' then
            table.insert(world.worker, api.new.worker(world.ruleset, id, position, timer, speed, world.ruleset.worker.color[id]))
            world.map[position.x][position.y] = world.worker[#world.worker]
            return world.map[position.x][position.y]
        end
    end
}

api.move = function(world, signal)
    local sum = {
        x = signal.position.x + signal.direction.x,
        y = signal.position.y + signal.direction.y
    }
    if sum.x < 1 or sum.x > #world.map or sum.y < 1 or sum.y > #world.map[1] then
        signal.position = nil
    else
        signal.position = {
            x = signal.position.x + signal.direction.x,
            y = signal.position.y + signal.direction.y
        }
    end
end

api.frame = function(world)
    world.session.time = world.session.time + 1
    local len = #world.signal
    for i = 1, len, 1 do
        local v = world.signal[i]
        if v.position ~= nil then
            local worker = world.map[v.position.x][v.position.y]
            api.move(world,v)
            if v.position ~= nil then
                worker = world.map[v.position.x][v.position.y]
                v.func(v, worker, world, api)
                if worker ~= nil and worker ~= '.' then
                    worker.func(v,worker,world,api)
                end
            end
        end
    end
    
    for i = 1, #world.worker, 1 do
        local v = world.worker[i]
        if v.speed > 0 then
            if (v.position ~= nil) then
                if (world.session.time % v.speed == 0) then
                    v.func(nil, v, world, api)
                end
            end
        end
    end

    if world.session.garbagecollector ~= 0 and world.session.time % world.session.garbagecollector == 0 then
        api.run(world, 'collect')
    end

    return world
end

api.console = {
    colors = 
    {
        black = '\27[30m',
        reset = '\27[0m',
        red = '\27[31m',
        green = '\27[32m',
        yellow = '\27[33m',
        blue = '\27[34m',
        magenta = '\27[35m',
        cyan = '\27[36m',
        white = '\27[37m',
    },

    colorstring = function(str,color)
        return api.console.colors[color] .. str .. api.console.colors.reset
    end,
    boldstring = function(str)
        return "\27[1m" .. str .. "\27[0m"
    end,
    randomcolor = function()
        return api.colors[api.util.random(3,#api.colors)]--ignores black and reset
    end,
    movecursor = function(x, y)
        return io.write("\27[" .. x .. ";" .. y .. "H")
    end,
    printmap = function(world)
        local str = ''
        local empty = world.session.hidedots and '.' or ' '
        local print_map = util.matrix.new(#world.map,#world.map[1],empty)
        for i, worker in ipairs(world.worker) do
            if worker.position ~= nil then
                if world.map[worker.position.x][worker.position.y] ~= '.' then
                    print_map[worker.position.x][worker.position.y] = api.console.boldstring(api.console.colorstring(world.map[worker.position.x][worker.position.y].id,worker.color))
                end
            end
        end

        for i, signal in ipairs(world.signal) do
            if signal.position ~= nil then
                if signal.data ~= nil then
                    print_map[signal.position.x][signal.position.y] = api.console.colorstring('@',signal.color)
                else
                    print_map[signal.position.x][signal.position.y] = api.console.colorstring('*',signal.color)
                end
            end
        end

        os.execute(util.unix('clear', 'cls'))
        io.write(util.matrix.tostring(print_map))
        print('frame: ' .. world.session.time)
    end,
    start = function(worldsizex,worldsizey)
        local world = api.new.world(worldsizex,worldsizey)
        local latermap = function() end
        local laterscript = {}
        local skip = false
        for i, v in ipairs(arg) do
            if skip ~= false then
                api.run(world,skip .. v)
                skip = false
            elseif v == '-l' then
                skip = "import "
            elseif util.string.includes(v,'-l') then
                api.run(world,"require lib." .. util.string.replace(v,'-l',''))
            elseif util.string.includes(v,'.osgs') then
                table.insert(laterscript,v)
            elseif util.string.includes(v,'.osgm') then
                latermap = function() world.map = api.new.map(world,v) end
            end
        end
        latermap()
        for i, v in ipairs(laterscript) do
            api.run(world,util.file.load.text(v))
        end
        while not world.session.config.exit do
    
            if (world.session.skip == 0 or world.session.config.renderskip)then
                api.console.printmap(world)
            end
    
            if world.session.skip == 0 then
                api.run(world)
            else
                world.session.skip = world.session.skip - 1
            end
    
            api.frame(world)
        end
    end
}

api.formatcommand = function(fullcmd)
    while api.util.string.includes(fullcmd, '\n') do
        fullcmd = api.util.string.replace(fullcmd, '\n', ';')
    end

    while api.util.string.includes(fullcmd, '  ') do
        fullcmd = api.util.string.replace(fullcmd, '  ', ' ')
    end

    fullcmd = api.util.string.replace(fullcmd, '; ', ';')
    fullcmd = api.util.string.replace(fullcmd, ' ;', ';')

    local splited = api.util.string.split(fullcmd, ';')
    for i, v in ipairs(splited) do
        if api.util.string.includes(v, '--') then
            splited[i] = ''
        end
    end
    return splited
end

api.run = function(world, command)
    local fullcmd = command or io.read()
    local splited = api.formatcommand(fullcmd)
    
    for i, cmd in ipairs(splited) do
        if cmd ~= '' then
            local split = api.util.string.split(cmd, " ")
            cmd = string.gsub(cmd, "^%s*(.-)%s*$", "%1")
            local args = {}
            for i = 2, #split, 1 do
                table.insert(args,split[i])
            end
            if world.ruleset.command[split[1]] == nil then
                print("unknown command!")
                api.run(world)
            else
                world.ruleset.command[split[1]](world,api,args,cmd)
            end
        end
    end
end

return api