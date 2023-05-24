local getch = require("lua-getch") 
local api = require("src.api")

api.console = {
    charbyte = function(ch)
        return ch:byte()
    end,
    getch = function()
        getch.get_char(io.stdin)
    end,
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
        local print_map = api.util.matrix.new(#world.map,#world.map[1],empty)
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

        os.execute(api.util.unix('clear', 'cls'))
        io.write(api.util.matrix.tostring(print_map))
        print('frame: ' .. world.session.time)
        print('message: ' .. world.session.message)
        print('active signals: ' .. #world.signal)
        print('active worker count: ' .. #world.worker)
    end,
    message = function(world,str)
        world.session.message = str
    end,
    start = function(worldsizex,worldsizey)
        io.stdin:setvbuf("no")
        getch.set_raw_mode(io.stdin)
        print("press space to skip, getch test.")
        while true do
            local char = getch.get_char(io.stdin)
            print("got: ", char)
            if((" "):byte() == char) then
                getch.restore_mode()
                io.stdin:setvbuf('line')
                break
            end
        end
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
            elseif api.util.string.includes(v,'-l') then
                api.run(world,"require lib." .. api.util.string.replace(v,'-l',''))
            elseif api.util.string.includes(v,'.osgs') then
                table.insert(laterscript,v)
            elseif api.util.string.includes(v,'.osgm') then
                latermap = function() world.map = api.new.map(world,v) end
            end
        end
        latermap()
        for i, v in ipairs(laterscript) do
            api.run(world,api.util.file.load.text(v))
        end
        while not world.session.exit do
    
            if world.session.toskip == 0 or world.session.renderskip then
                api.console.printmap(world)
            end
    
            if world.session.editmode then
                api.console.movecursor(world.session.cposi.x, world.session.cposi.y)
                local chin = io.stdin:read(1)
                world.map[world.session.cposi.x][world.session.cposi.y] = api.worker.spawn(world, world.session.cposi, chin, world.ruleset.worker[chin].speed)
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

api.console.start(16,32)