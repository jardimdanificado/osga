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
                        local templib = require(api.util.string.replace(api.util.string.replace(args[1],'.lua',''),'/','.'))
                        local keys = util.array.keys(templib.worker)
                        for i, k in ipairs(keys) do
                            if k ~= 'speed' and k ~= 'color' then
                                world.ruleset.worker[k] = templib.worker[k]
                                world.ruleset.worker.color[k] = templib.worker.color[k]
                                world.ruleset.worker.speed[k] = templib.worker.speed[k]
                            end
                        end
                        for k, v in pairs(templib.command) do
                            --print(k)
                            world.ruleset.command[k] = v
                        end
                        for k, v in pairs(templib.signal) do
                            --print(k)
                            world.ruleset.signal[k] = v
                        end
                            
                        table.insert(world.session.loadedscripts,api.util.string.replace(api.util.string.replace(args[1],'.lua',''),'/','.'))
                    end,
                    import = function(world,api,args)
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
                    end
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
    for i, v in ipairs(world.worker) do
        api.move(world,v)
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
            world.ruleset.command[split[1]](world,api,args,cmd)
        end
        
    end
end

return api