local util = require("util")
local api = require("api")

local install = function(dataname,x,y)
  dataname = dataname or 'data'
  x = x or 64
  y = y or 64
  os.execute(util.unix("rm -rf","rd /s /q") .. " " .. dataname)
  os.execute("mkdir " .. dataname)
  local text = "local ruleset = {}\nruleset.auto = {}\nruleset.speed = {}\n\n"
  for k,v in pairs(util.char) do
    text = text .. "ruleset.auto['" .. v .. "']" .. " = false\n"
    text = text .. "ruleset.speed['" .. v .. "']" .. " = 2\n"
    text = text .. "ruleset['" .. v .. "'] = function(signal,worker,world,api)\n--put your lua code here\nend\n\n"
  end
  text = text .. "return ruleset\n"
  util.file.save.text(dataname .. "/ruleset.lua", text)
  util.file.save.charMap(dataname .. "/map.txt",util.matrix.new(x,y,'.'))
  return dataname
end

local function makemap(world,charmap)
  for x, vx in ipairs(charmap) do
    for y, vy in ipairs(vx) do
      if vy ~= '.' then
        charmap[x][y] = api.worker.spawn(world,{x=x,y=y},vy,2)
      else
        charmap[x][y] = '.'
      end
    end
  end
  return charmap
end

local function commander(world,command)
  local fullcmd = command or io.read()
  while util.string.includes(fullcmd,'\n') do
    fullcmd = util.string.replace(fullcmd,'\n',';')
  end
  while util.string.includes(fullcmd,'  ') do
    fullcmd = util.string.replace(fullcmd,'  ',' ')
  end
  fullcmd = util.string.replace(fullcmd,'; ',';')
  fullcmd = util.string.replace(fullcmd,' ;',';')
  local splited = util.string.split(fullcmd,';')
  for i, v in ipairs(splited) do
    if util.string.includes(v,'--') then
      splited[i] = ''
    end
  end
  for i,cmd in ipairs(splited) do
    local split = util.string.split(cmd," ")
    cmd = string.gsub(cmd, "^%s*(.-)%s*$", "%1")
    if util.string.includes(cmd,"edit") then
      world.session.cposi = {x=tonumber(split[2]),y=tonumber(split[3])}
      world.session.editmode = true
    elseif util.string.includes(cmd,"add") then
      if #split >= 4 then
        api.worker.spawn(world,{x=tonumber(split[3]),y=tonumber(split[4])},split[2],split[5] or 2)
      end
    elseif util.string.includes(cmd,'master.') or util.string.includes(cmd,'>') then
      cmd = util.string.replace(cmd,">",'master.')
      assert(util.load(cmd))()
    elseif util.string.includes(cmd,"rm") then
      if world.map[tonumber(split[2])][tonumber(split[3])]  ~= '.' then
        world.session.cposi = {x=tonumber(split[2]),y=tonumber(split[3])}
        world.map[tonumber(split[2])][tonumber(split[3])].position = nil
        world.map[tonumber(split[2])][tonumber(split[3])] = '.'
      end
    elseif util.string.includes(cmd,'exit') then
      world.session.exit = true
    elseif util.string.includes(cmd,'clear') then
      local temp = {} 
      for i, signal in ipairs(world.signal) do
        if signal ~= nil and signal.position ~= nil then
          table.insert(temp,signal)
        end
      end
      world.signal = temp
      temp = {} 
      for i, worker in ipairs(world.worker) do
        if worker ~= nil and worker.position then
          table.insert(temp,worker)
        end
      end
      world.worker = temp
    elseif util.string.includes(cmd,'render skip') then
      world.session.renderskip = util.turn(world.session.renderskip)
    elseif util.string.includes(cmd,'skip') then
      world.session.toskip = tonumber(split[2])
      print("please wait...")
    elseif util.string.includes(cmd,'run') then
      local script = util.file.load.text(split[2])
      commander(world,script)
    elseif util.string.includes(cmd,'save') then
      if split[2] ~= nil then
        util.file.save.charMap(split[2],world.map)
      else
        util.file.save.charMap('data/map.txt',world.map)
      end
    end
  end
end

local function frame(world)
  world.session.time = world.session.time + 1
  for i,v in ipairs(world.signal) do
    if v.position ~= nil then
      api.signal.move(world,v)
      api.signal.work(world,v)
    end
  end
  for i,v in ipairs(world.worker) do
    if v.auto == true then
      if(v.position ~= nil) then
        if(world.session.time % v.speed == 0) then
          v.func(nil,v,world,api)
        end
      end
    end
  end
  if world.session.collect and world.session.time % #world.map*2 == 0 then
    commander(world,'clear')
  end
  return world
end

local function print_map(world)
  local str = ''
  local printmap = {}
  for x = 1, #world.map, 1 do
    printmap[x] = {}
    for y = 1, #world.map[x], 1 do
      if type(world.map[x][y]) == 'table' then
        printmap[x][y] = world.map[x][y].id
      else
        printmap[x][y] = world.map[x][y]
      end
    end
  end
  for i, signal in ipairs(world.signal) do
    if signal.position ~= nil then
      if signal.data ~= nil then
        printmap[signal.position.x][signal.position.y] = '@'
      else
        printmap[signal.position.x][signal.position.y] = '*'
      end
    end
  end
  os.execute(util.unix('clear', 'cls'))
  io.write(util.matrix.tostring(printmap))
  print('frame: ' .. world.session.time)
  print('message: ' .. world.session.message)
  print('active signals: ' .. #world.signal)
  print('active worker count: ' .. #world.worker)
end

local function movecursor(x,y)
  return io.write("\27[".. x .. ";".. y .."H")
end

local function main()
  local location = arg[2]  or 'data'
  if util.file.exist(location .. "/ruleset.lua") == false or util.file.exist(location .. "/map.txt") == false then
    location = install(arg[2],arg[3],arg[4])
  end

  local world = 
  {
    ruleset = require(location .. ".ruleset"),
    signal={},
    worker = {},
    speed = 1,
    session = 
    {
      time = 1,
      exit = false,
      editmode = false,
      cposi = {x=1,y=1},
      message = 'idle',
      toskip = 0,
      renderskip = false,
      collect = true
    }
  }
  master = {world = world,api = api}
  local charmap = util.file.load.charMap(location .. "/map.txt")
  world.map = util.matrix.new(#charmap,#charmap[1],'.')
  world.map = makemap(world,charmap)
  --world.map.char = charmap
  --world.map.signal = util.matrix.new(#charmap,#charmap[1],'.')
  while not world.session.exit do
    if world.session.toskip == 0 or world.session.renderskip then      
      print_map(world)
    end
    if world.session.editmode then
      movecursor(world.session.cposi.x,world.session.cposi.y)
      local chin = io.stdin:read(1)
      world.map[world.session.cposi.x][world.session.cposi.y] = api.worker.spawn(world, world.session.cposi, chin, 2)
      world.session.editmode = false
    end

    if world.session.toskip == 0 then
      commander(world)
    else
      world.session.toskip = world.session.toskip - 1
    end
    
    frame(world)
  end
end

main()
