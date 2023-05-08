

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
  else
    
  end
  local config = require("data.config")
end

local function frame()
  
end

main()
