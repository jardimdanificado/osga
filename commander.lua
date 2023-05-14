return function(world, command, api)
    master = {world=world,api=api}
    local fullcmd = command or io.read()
    local splited = api.console.formatcommand(fullcmd)
    for i, cmd in ipairs(splited) do

        local split = api.util.string.split(cmd, " ")
        cmd = string.gsub(cmd, "^%s*(.-)%s*$", "%1")

        if api.util.string.includes(cmd, "edit") then

            world.session.cposi = {
                x = tonumber(split[2]),
                y = tonumber(split[3])
            }
            world.session.editmode = true

        elseif api.util.string.includes(cmd, "add") then

            if #split >= 4 then
                api.worker.spawn(world, {
                    x = tonumber(split[3]),
                    y = tonumber(split[4])
                }, split[2], split[5] or 2)
            end

        elseif api.util.string.includes(cmd, 'master.') or api.util.string.includes(cmd, '>') then

            cmd = api.util.string.replace(cmd, ">", 'master.')
            assert(api.util.load(cmd))()

        elseif api.util.string.includes(cmd, "rm") then

            if world.map[tonumber(split[2])][tonumber(split[3])] ~= '.' then
                world.session.cposi = {
                    x = tonumber(split[2]),
                    y = tonumber(split[3])
                }
                world.map[tonumber(split[2])][tonumber(split[3])].position = nil
                world.map[tonumber(split[2])][tonumber(split[3])] = '.'
            end

        elseif api.util.string.includes(cmd, 'exit') then

            world.session.exit = true

        elseif api.util.string.includes(cmd, 'clear') then

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
                end
                if worker ~= nil and worker.position then
                    table.insert(temp, worker)
                end
            end
            world.session.print = temp
            temp = {}
            for i, prt in ipairs(world.session.print) do
                if prt.timer < 1 then
                    table.insert(temp, prt)
                end
            end
            world.session.print = temp

        elseif api.util.string.includes(cmd, 'turn') then

            if type(world.session[split[2]]) == 'boolean' then
                world.session[split[2]] = api.util.turn(world.session[split[2]])
            else
                print("\n\27[32mavaliable to turn:\27[0m")
                for k, v in pairs(world.session) do
                    if type(v) == 'boolean' then
                        print(k)
                    end
                end
                print()
                api.console.commander(world,command, api)
            end

        elseif api.util.string.includes(cmd, 'skip') then

            world.session.toskip = tonumber(split[2])
            print("please wait...")

        elseif api.util.string.includes(cmd, 'run') then

            local script = api.util.file.load.text(split[2])
            api.console.commander(world, script)

        elseif api.util.string.includes(cmd, 'save') then

            if split[2] ~= nil then
                api.util.file.save.charMap(split[2], world.map)
            else
                api.util.file.save.charMap('data/map.txt', world.map)
            end

        end
    end
end