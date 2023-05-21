local ruleset = {command={},worker={color={},speed={}},signal={}}

command['bundle.pack'] = function(world,api,args)
    local scripts = {}
    local mapfile = ""
    local outfile = ""
	local rulsets = ""
	for i,v in ipairs(args) do
	    if api.util.string.includes(v,".osgs") then
	        table.insert(scripts,v)
	    elseif api.util.string.includes(v,".osgm") then
	        mapfile = v
	    elseif api.util.string.includes(v,".osgb") then
	        outfile = v
		elseif api.util.string.includes(v,".lua") then
			table.insert(rulsets,v)
	    end
	end
	if outfile == "" then
	    outfile = api.util.string.replace(mapfile,".osgm",".osgb")
	end
	local maptxt = api.util.file.load.text(mapfile)
	local map = api.util.file.load.charmap(mapfile)
	local key = api.util.id()
	while api.util.string.includes(maptxt, key) do 
	    key = api.util.id()
	end
	local result = key .. "\n" .. maptxt 
	if #scripts > 0 then
		result = result .. key
		for i,v in ipairs(scripts) do 
			result = result .. api.util.file.load.text(v) .. '\n'
		end
	end
	if #rulsets > 0 then
		for i,v in ipairs(rulsets) do 
			result = result .. key .. api.util.file.load.text(v)
		end
	end
	api.util.file.save.text(outfile,result)
end

return ruleset