--[[

speed = 10 --iterations, bigger the speed slower it will be
. = empty space
a-Z = workers
all workers must have their defaults

signals:
  * = power, always true, when it touch a worker run it with the defaults 
  $ = setup, only data, this override the worker defaults
  @ = transmission, this do not override the worker defaults, but run a single time the data in the worker

signal operators: -- operators are pre-built logic controlers 
  ! = outputer
  # = blocker
  
special(need outputs): -- special are made with api functions
  ? = redirects a signal
  & = queue
  + = send the signal in the 3 other directions
  < = slow down by 1
  > = speed up by 1
--]]

local cfgtxt = 
[[local cfg = {}
cfg.size = 
{
  w = 16,
  h = 16
}
cfg.name = "osga"
return cfg]]

local util = require("util")
local api = require("api")

local install = function()
  os.execute(util.unix("rm -rf","rd /s /q") .. " data")
  os.execute("mkdir data")
  util.file.save.text("./data/config.lua",cfgtxt)
  local text = "local ruleset = {}\nruleset.defaults = {}\n\n"
  for k,v in pairs(util.char) do
    text = text .. "ruleset.defaults['" .. v .. "']" .. " = {}\n"
    text = text .. "ruleset['" .. v .. "'] = function(input,api,worker)\n  return input \nend\n\n"
  end
  util.file.save.text("./data/ruleset.lua", text)
  util.file.save.charMap("./data/map.txt",util.matrix.new(16,16,'.'))
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
end

local function print_map(world)
  local str = ''
  for x = 1, #world.map, 1 do
    for y = 1, #world.map[x], 1 do
        if type(world.map[x][y]) == 'table' then
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
  if cmd == "exit" then
    world.config.exit = true
  end
end

local function makemap(world,charmap)
  local result = {}
  for x, vx in ipairs(charmap) do
    result[x] = {}
    for y, vy in ipairs(vx) do
      if vy ~= '.' and vy ~= '#' then
        result[x][y] = api.worker.spawn(world,{x=x,y=y},vy,world.rulemap.defaults[vy])
      else
        result[x][y] = vy
      end
    end
  end
end

local function main()
  if util.file.exist("./data") == false or arg[1] == 'setup' or arg[1] == 'reset' or arg[1] == 'install' then
    install()
  end

  local world = 
  {
    ruleset = require("data.ruleset"),
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
      cposi = {x=1,y=1}
    }
  }
  world.map = util.matrix.new(16,16,'.')
  world.map.char = util.file.load.charMap("./data/map.txt")
  world.map.signal = util.matrix.new(16,16,'.')
  world.session.editmode = true
  while not world.config.exit do
    frame(world)
    print_map(world)
    
    if world.session.editmode then
      movecursor(world.session.cposi.x,world.session.cposi.y)
      world.map[world.session.cposi.x][world.session.cposi.y] = io.stdin:read(1)
      world.session.editmode = false
    end
    commander(world,world.session.cposi)
  end
end

main()
