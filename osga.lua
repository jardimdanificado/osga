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
cfg.name = "main"
return cfg]]

local util = require("util")
local api = require("api")

local install = function()
  util.file.save.text("./data/config.lua",cfgtxt)
  local text = "local ruleset = {}\n\n"
  for k,v in pairs(util.char) do
    text = text .. "ruleset['" .. v .. "'] = function(input,api)\n  return input \nend\n\n"
  end
  util.file.save.text("./data/ruleset.lua", text)
  util.file.save.charMap("./data/map.txt",util.matrix.new(16,16,'.'))
end

local function frame(world)
  for i = 1, #world.signal do
    if(world.signal[i].position ~= nil) then
      if(world.time % world.signal[i].speed == 0) then
        api.signal.move(world,world.signal[i])
      end
    else
      world.signal[i] = nil
    end
    world.time = world.time + 1
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
  os.execute(world.session.clear)
  io.write(str)
end

local function main()
  if util.file.exist("./data/config.lua") == false then
    install()
  end

  local world = 
  {
    config = require("data.config"),
    ruleset = require("data.ruleset"),
    session = {},
    signal={},
    worker = {},
    speed = 10,
    time = 1
  }
  world.map = util.matrix.new(world.config.size.w,world.config.size.h,'.')
  world.map.char = util.file.load.charMap("./data/map.txt")
  world.map.signal = util.matrix.new(world.config.size.w,world.config.size.h,'.')

  if package.config:sub(1,1) == '\\' then
    print("Running on Windows")
    world.session.clear = 'cls'
  else
      world.session.clear = 'clear'
      print("Running on Unix-like system")
  end
  while true do
    frame(world)
    print_map(world)
  end
end

install()
main()
