local util = require('util')
local commander = require('commander')
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
    install = function(dataname, x, y)
        dataname = dataname or 'data'
        x = x or 64
        y = y or 64
        os.execute(util.unix("rm -rf", "rd /s /q") .. " " .. dataname)
        os.execute("mkdir " .. dataname)
        local text = "local ruleset = {}\nruleset.speed = {}\nruleset.color = {}\n\n"
        for k, v in pairs(util.char) do
            text = text .. "ruleset.color['" .. v .. "']" .. " = 'reset'\n"
            text = text .. "ruleset.speed['" .. v .. "']" .. " = 0\n"
            text = text .. "ruleset['" .. v .. "'] = function(signal,worker,world,api)\n--put your lua code here\nend\n\n\n"
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
            position = position,
            color = 'white'
        }
    end,
    worker = function(ruleset, id, position, timer, speed, color)
        return {
            id = id,
            func = ruleset[id],
            position = position,
            timer = timer,
            speed = speed,
            color = color or 'white'
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
                collect = true,
                print = {}
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
    emit = function(world, position, direction, data, color)
        table.insert(world.signal, api.new.signal(position, direction, data, color))
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
        local print_map = util.matrix.new(#world.map,#world.map[1],'.')
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
                    print_map[signal.position.x][signal.position.y] = api.console.colorstring('$',signal.color)
                end
            end
        end

        if #world.session.print > 0 then
            for i, v in ipairs(world.session.print) do
                print(v.timer)
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
    commander = function(world,command) return commander(world,command,api) end,
    message = function(world,str)
        world.session.message = str
    end
}

return api
