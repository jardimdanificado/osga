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
            func = func or api.signal.move
        }
    end,
    worker = function(ruleset, id, position, timer, speed, color, data)
        return {
            id = id,
            func = ruleset[id],
            position = position,
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
                color = {},
                speed = {},
                commands = 
                {
                    require = function(world,api,args)
                        local templib = require(api.util.string.replace(api.util.string.replace(args[1],'.lua',''),'/','.'))
                        for k, v in pairs(templib) do
                            if k ~= 'speed' and k ~= 'color' and k ~= 'commands' then
                                world.ruleset[k] = v
                                world.ruleset.color[k] = templib.color[k] 
                                world.ruleset.speed[k] = templib.speed[k]
                            end
                        end
                        for k, v in pairs(templib.commands) do
                            --print(k)
                            world.ruleset.commands[k] = v
                        end
                            
                        table.insert(world.session.loadedscripts,args[1])
                    end,
                }
            },
            signal = {},
            worker = {},
            session = {
                time = 1,
                exit = false,
                editmode = false,
                cposi = {
                    x = 1,
                    y = 1
                },
                message = 'idle',
                toskip = 0,
                renderskip = true,
                garbagecollector = true,
                print = {},
                showdots = true,
                loadedscripts = {}
            }
        }
        world.map = util.matrix.new(sizex,sizey,'.')
        return world
    end
}

api.signal = {
    work = function(world, signal)
        if signal.position == nil or world.map[signal.position.x][signal.position.y] == '.' then
            return
        end
        signal.func(world,signal,worker,api)
        local worker = world.map[signal.position.x][signal.position.y]
        worker.func(signal, worker, world, api)
    end,
    move = function(world, signal)
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
    end,
    emit = function(world, position, direction, data)
        table.insert(world.signal, api.new.signal(position, direction, data, api.signal.move))
        return world.signal[#world.signal]
    end
}

api.worker = {
    spawn = function(world, position, id, timer, speed)
        speed = speed or world.ruleset.speed[id]
        if world.map[position.x][position.y] == '.' then
            table.insert(world.worker, api.new.worker(world.ruleset, id, position, timer, speed, world.ruleset.color[id]))
            world.map[position.x][position.y] = world.worker[#world.worker]
            return world.map[position.x][position.y]
        end
    end
}

api.frame = function(world)
    world.session.time = world.session.time + 1
    for i, v in ipairs(world.signal) do
        if v.position ~= nil then
            if signal.func == nil then
                signal.func = api.signal.move
            api.signal.work(world, v)
        end
    end
    for i, v in ipairs(world.worker) do
        if v.speed > 0 then
            if (v.position ~= nil) then
                if (world.session.time % v.speed == 0) then
                    v.func(nil, v, world, api)
                end
            end
        end
    end
    if world.session.garbagecollector and world.session.time % #world.map * 2 == 0 then
        api.run(world, 'clear')
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
                if type(worker) == 'table' then
                    print_map[worker.position.x][worker.position.y] = api.console.boldstring(api.console.colorstring(world.map[worker.position.x][worker.position.y].id,worker.color))
                else
                    print_map[worker.position.x][worker.position.y] = world.map[worker.position.x][worker.position.y]
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

        if #world.session.print > 0 then
            for i, v in ipairs(world.session.print) do
                for y = 1, #v.str, 1 do
                    if print_map[v.position.x][v.position.y + y] ~= nil then
                        print_map[v.position.x][v.position.y + y] = string.sub(v.str,y,y)
                    end
                end
                v.timer = v.timer - 1
                if v.timer < 1 then
                    world.session.print[i] = nil
                end
            end
        end

        os.execute(util.unix('clear', 'cls'))
        io.write(util.matrix.tostring(print_map))
        print('frame: ' .. world.session.time)
        print('message: ' .. world.session.message)
        print('active signals: ' .. #world.signal)
        print('active worker count: ' .. #world.worker)
    end,
    message = function(world,str)
        world.session.message = str
    end,
    start = function(worldsizex,worldsizey)
        local world = api.new.world(worldsizex,worldsizey)
        local latermap = function() end
        local laterscript = {}
        for i, v in ipairs(arg) do
            if util.string.includes(v,'-l') then
                api.run(world,"require lib." .. util.string.replace(v,'-l',''))
            end
            if util.string.includes(v,'.osgs') then
                table.insert(laterscript,v)
            elseif util.string.includes(v,'.osgm') then
                latermap = function() world.map = api.new.map(world,v) end
            end
        end
        latermap()
        for i, v in ipairs(laterscript) do
            api.run(world,util.file.load.text(v))
        end
        while not world.session.exit do
    
            if world.session.toskip == 0 or world.session.renderskip then
                api.console.printmap(world)
            end
    
            if world.session.editmode then
                api.console.movecursor(world.session.cposi.x, world.session.cposi.y)
                local chin = io.stdin:read(1)
                world.map[world.session.cposi.x][world.session.cposi.y] = api.worker.spawn(world, world.session.cposi, chin, 2)
                world.session.editmode = false
            end
    
            if world.session.toskip == 0 then
                api.run(world)
            else
                world.session.toskip = world.session.toskip - 1
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
    master = {world=world,api=api}
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
            world.ruleset.commands[split[1]](world,api,args,cmd)
        end
        
    end
end

return api
