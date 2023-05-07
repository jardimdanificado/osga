--[[

speed = 100 --iterations, bigger the speed slower it will be
. = empty space
a-Z = workers
all workers must have defaults

signals:
  * = power, always true, when it touch a worker run it with the defaults
  $ = setup, only data, this override the worker defaults
  @ = transmission, this do not override the worker defaults, but run a single time the data in the worker

signal operators:
  ! = output
  ? = redirects a signal, if no output present it works as a block
  + = send the signal in the 3 other directions
  < = slow down by 1
  > = speed up by 1
banks:
  & = queue
  ~ = waterbank
--]]

local util = require("util")

local install = function()
  util.file.save.text("./data/config.lua",
[[local cfg = {}
cfg.size = 
{
  w = 80,
  h = 24
}
cfg.name = "main"
return cfg]])
  local text = [[local ruleset = {}]]
  for k,v in pairs(util.char) do
    text = text .. "ruleset['" .. v .. "'] = function(input)\n  return input \nend\n\n"
  end
  util.file.save.text("./data/ruleset.lua", text)
  util.file.save.map("./data/map.txt",util.matrix.new(80,24,0))
  --util.file.save.map("./data/.txt",util.matrix.new(80,24,0))
end

local function main()
  if util.file.exist("./data/config.lua") == false then
    install()
  end
  local config = require("data.config")
end

local function frame()
  
end

main()
