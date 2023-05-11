local util = require("util")
local api = require("api")

local install = function(dataname,x,y)
  dataname = dataname or 'data'
  x = x or 16
  y = y or 16
  os.execute(util.unix("rm -rf","rd /s /q") .. " " .. dataname)
  os.execute("mkdir " .. dataname)
  local text = "local ruleset = {}\nruleset.defaults = {}\n\n"
  for k,v in pairs(util.char) do
    text = text .. "ruleset.defaults['" .. v .. "']" .. " = {}\n"
    text = text .. "ruleset['" .. v .. "'] = function(input,advanced)\n  return input \nend\n\n"
  end
  text = text .. "return ruleset\n"
  util.file.save.text(dataname .. "/ruleset.lua", text)
  util.file.save.charMap(dataname .. "/map.txt",util.matrix.new(x,y,'.'))
  return dataname
end

local function frame(world)
  world.session.time = world.session.time + 1
  for i = 1, #world.signal do
    if(world.signal[i].position ~= nil) then
      if(world.session.time % world.signal[i].speed == 0) then
        api.signal.move(world,world.signal[i])
      end
    else
      world.signal[i] = nil
    end
  end

  for i = 1, #world.worker do
    if(world.worker[i].position ~= nil) then
        api.worker.work(world,world.worker[i])
    else
      world.worker[i] = nil
    end
  end
  return world
end

local function print_map(world)
  local str = ''
  for x = 1, #world.map, 1 do
    for y = 1, #world.map[x], 1 do
        if world.map.signal[x][y] ~= '.' then
          local sig = world.map.signal[x][y]
          if(sig.power == nil) then
            str = str .. '$'
          elseif sig.data == nil then
            str = str .. '*'
          else
            str = str .. '@'
          end
        elseif type(world.map[x][y]) == 'table' then
          str = str .. world.map[x][y].id
        else
          str = str .. world.map[x][y]
        end
    end
    str = str .. '\n'
  end
  os.execute(util.unix('clear', 'cls'))
  io.write(str)
end

local function movecursor(x,y)
  return io.write("\27[".. x .. ";".. y .."H")
end

local function commander(world)
  local cmd = io.read()
  if util.string.includes(cmd,"edit") then
    local split = util.string.split(cmd,' ')
    world.session.cposi = {x=tonumber(split[2]),y=tonumber(split[3])}
    world.session.editmode = true
  elseif util.string.includes(cmd,"new") or util.string.includes(cmd,"add") then
    local split = util.string.split(cmd,' ')
    if #split >= 4 then
      api.worker.spawn(world,{x=tonumber(split[3]),y=tonumber(split[4])},split[2],split[5] or 2)
    end
  elseif util.string.includes(cmd,"rm") then
    local split = util.string.split(cmd,' ')
    if world.map[tonumber(split[2])][tonumber(split[3])]  ~= '.' then
      world.session.cposi = {x=tonumber(split[2]),y=tonumber(split[3])}
      world.map[tonumber(split[2])][tonumber(split[3])].position = nil
      world.map[tonumber(split[2])][tonumber(split[3])] = '.'
    end
    
  elseif cmd == "exit" then
    world.session.exit = true
  end
end

local function makemap(world,charmap)
  local result = {}
  for x, vx in ipairs(charmap) do
    result[x] = {}
    for y, vy in ipairs(vx) do
      if vy ~= '.' and vy ~= '#' then
        result[x][y] = api.worker.spawn(world,{x=x,y=y},vy,2)
      else
        result[x][y] = vy
      end
    end
  end
  return result
end

local function main()
  local location = arg[2] or 'data'
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
      frame = true,
      redraw = true,
      editmode = false,
      cposi = {x=1,y=1},
      status = 'idle'
    }
  }
  local charmap = util.file.load.charMap(location .. "/map.txt")
  world.map = makemap(world,charmap)
  world.map.char = charmap
  world.map.signal = util.matrix.new(#charmap,#charmap[1],'.')
  while not world.session.exit do
    print_map(world)
    print(world.session.time)
    print(world.session.status)
    frame(world)
    if world.session.editmode then
      movecursor(world.session.cposi.x,world.session.cposi.y)
      local chin = io.stdin:read(1)
      world.map[world.session.cposi.x][world.session.cposi.y] = api.worker.spawn(world, world.session.cposi, chin, 2)
      world.session.editmode = false
    end
    commander(world,world.session.cposi)
  end
end

main()
