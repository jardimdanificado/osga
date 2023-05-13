local util = require("util")
local api = require("api")

local function frame(world)
    world.session.time = world.session.time + 1
    for i, v in ipairs(world.signal) do
        if v.position ~= nil then
            api.signal.move(world, v)
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
    if world.session.collect and world.session.time % #world.map * 2 == 0 then
        api.console.commander(world, 'clear')
    end
    return world
end

local function main()
    
    local location = arg[2] or 'data'

    if util.file.exist(location .. "/ruleset.lua") == false or util.file.exist(location .. "/map.txt") == false then
        location = api.new.install(arg[2], arg[3], arg[4])
    end

    local world = api.new.world(location)
    
    while not world.session.exit do

        if world.session.toskip == 0 or world.session.renderskip then
            api.console.printmap(world)
        end

        if world.session.editmode then
            api.console.movecursor(world.session.cposi.x, world.session.cposi.y)
            local chin = io.stdin:read(1)
            world.map[world.session.cposi.x][world.session.cposi.y] =
                api.worker.spawn(world, world.session.cposi, chin, 2)
            world.session.editmode = false
        end

        if world.session.toskip == 0 then
            api.console.commander(world)
        else
            world.session.toskip = world.session.toskip - 1
        end

        frame(world)
    end
end

main()
