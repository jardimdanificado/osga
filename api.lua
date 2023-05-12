local util = require('util')
local commander = require('commander')
local api = {}
api.util = util


api.print = function(world, string)
    world.session.message = string
end

api.new = {
    install = function(dataname, x, y)
        dataname = dataname or 'data'
        x = x or 64
        y = y or 64
        os.execute(util.unix("rm -rf", "rd /s /q") .. " " .. dataname)
        os.execute("mkdir " .. dataname)
        local text = "local ruleset = {}\nruleset.auto = {}\nruleset.speed = {}\n\n"
        for k, v in pairs(util.char) do
            text = text .. "ruleset.auto['" .. v .. "']" .. " = false\n"
            text = text .. "ruleset.speed['" .. v .. "']" .. " = 2\n"
            text = text .. "ruleset['" .. v .. "'] = function(signal,worker,world,api)\n--put your lua code here\nend\n\n"
        end
        text = text .. "return ruleset\n"
        util.file.save.text(dataname .. "/ruleset.lua", text)
        util.file.save.charMap(dataname .. "/map.txt", util.matrix.new(x, y, '.'))
        return dataname
    end,
    vec2 = function(x, y)
        return {
            x = x,
            y = y
        }
    end,
    signal = function(position, direction, data)
        return {
            direction = direction or {
                x = 1,
                y = 0
            },
            data = data,
            position = position
        }
    end,
    worker = function(ruleset, id, position, timer, speed)
        return {
            id = id,
            func = ruleset[id],
            auto = ruleset.auto[id],
            position = position,
            timer = timer,
            speed = speed
        }
    end,
    map = function(world, charmap)
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
    world = function(location)
        local world = 
        {
            ruleset = require(location .. ".ruleset"),
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
                collect = true
            }
        }        
        world.map = api.new.map(world, api.util.file.load.charMap(location .. "/map.txt"))
        return world
    end
}

api.signal = {
    work = function(world, signal)
        if signal.position == nil or world.map[signal.position.x][signal.position.y] == '.' then
            return
        end
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
        if position.direction ~= nil then
            table.insert(world.signal, position)
        end
        table.insert(world.signal, api.new.signal(position, direction, data))
    end
}

api.worker = {
    spawn = function(world, position, id, timer, speed)
        speed = speed or world.ruleset.speed[id]
        if world.map[position.x][position.y] == '.' then
            table.insert(world.worker, api.new.worker(world.ruleset, id, position, timer, speed))
            world.map[position.x][position.y] = world.worker[#world.worker]
            return world.map[position.x][position.y]
        end
    end
}

api.console = {
    movecursor = function(x, y)
        return io.write("\27[" .. x .. ";" .. y .. "H")
    end,
    formatcommand = function(fullcmd)
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
    end,
    printmap = function(world)
        local str = ''
        local print_map = {}
        for x = 1, #world.map, 1 do
            print_map[x] = {}
            for y = 1, #world.map[x], 1 do
                if type(world.map[x][y]) == 'table' then
                    print_map[x][y] = world.map[x][y].id
                else
                    print_map[x][y] = world.map[x][y]
                end
            end
        end
        for i, signal in ipairs(world.signal) do
            if signal.position ~= nil then
                if signal.data ~= nil then
                    print_map[signal.position.x][signal.position.y] = '@'
                else
                    print_map[signal.position.x][signal.position.y] = '*'
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
    commander = function(world,command) return commander(world,command,api) end
}

return api
