local osga = {}
local util = require "util"
--[[
    osga = require "osgadata"
    a = {p = 'armando',l={1,2,3,4,5},k={ronaldo={12,34},rogerio={123}}}
    print(osga.objectToString(osga.generic(a),'vec3'))    

--]]

local function generic(original,name,parent)
    local obj = {relatives = {}}
    obj.name = name or 'noname'
    obj.type = type(original)
    if(parent ~= nil) then
        obj.parent = parent
    end
    if(obj.type == 'table') then
        for k, v in pairs(original) do
            if type(k) ~= "number" then
                table.insert(obj.relatives,generic(v,k,original))
            end
        end
    end
    return obj
end

local function stringifygeneric(obj,titled)
    titled = titled or false
    local result = ''
    if(obj.type == 'table') then
        if(titled) then
            result = obj.name .. '='
        end
        result = result .. '{'
        local typs = {}
        if(#obj.relatives>0) then
            for i, v in pairs(obj.relatives) do
                if(type(v) == 'table') then
                    result = result .. ',' .. stringifygeneric(v,true)
                end
            end
        end
        result = result .. '}'
    else
        return obj.name .. '=' .. obj.type
    end
    return result:gsub("{,", '{')
end

local function abstract(typ,ignorestring)
    ignorestring = ignorestring or false
    if(type(v) == 'function') then
        return osga.type(typ())
    elseif(type(v) == 'table') then
        return osga.type(typ)
    elseif(ignorestring and typ == 'string') then
        return typ
    else
        return type(typ)
    end
end

local function findBankObj(data,obj)
    local tipo = osga.type(obj)
    local bank 
    for k, v in pairs(data.types) do
        if(data.types[k] == tipo) then
            bank = data.banks[k]
            break
        end
    end
    if(bank == nil) then
        bank = data.new(data,obj)
    end
    data.add(data,obj)
    return bank
end

local function find(data,obj)--receive object returns id
    local tipo = osga.type(obj)
    local bank,key
    for k,v in pairs(data.types) do
        if(v == tipo) then
            bank = k
            break
        end
    end
    for k,v in pairs(data.banks) do
        for k,v in pairs(data.banks[k]) do
            if(v == tipo) then
                key = k
                break
            end
        end
    end
    if(bank ~= nil and key ~= nil) then
        return (bank .. ':' .. key), obj
    end
end

local function get(data,id)--receive id returns object
    local ids = util.string.split(id,':')
    if #ids == 2 then
        return data.banks[ids[1]][ids[2]],id
    end

    for x,v1 in pairs(data.banks) do
        for y,v2 in pairs(data.banks[k]) do
            if(k == id) then
                return data.banks[x][y],id
            end
        end
    end
end

osga.istype = function(obj)
    return string.sub(obj,1,1) ~= "{" and string.sub(obj,#obj,#obj) == "}"
end

osga.type = function(obj)
    local otype = osga.type(obj)
    if otype == 'string' then
        if osga.istype(obj) then
            return obj
        else
            return otype
        end
    else
        return stringifygeneric(generic(obj))
    end
end

osga.check = function(tipo, obj)
    local lt = abstract(tipo,true)
    local lo = abstract(obj,true)
    return lt == lo
end

osga.new = function(optionalTypeList)
    local result = 
    {
        new = function(data,obj,name)
            name = name or util.id()
            obj = osga.type(obj)
            data.banks[name] = {}
            data.types[name] = obj
            return data.banks[name]
        end,
        delete = function(data,bankid)
            if(type(bankid) ~= 'string') then
                bankid = osga.type(bankid)
            end
            local found = false
            if(string.sub(bankid,1,1) ~= "{" and string.sub(bankid,#bankid,#bankid) == "}") then
                for k, v in pairs(data.banks) do
                    if(k == bankid) then
                        bankid = k
                        found = true
                    end
                end
            else
                for k, v in pairs(data.banks) do
                    if(data.types[k] == bankid) then
                        bankid = k
                        found = true
                    end
                end
            end
            
            if found then 
                data.banks = util.array.filter(data.banks,function(value,name) return name == bankid end)
                return true
            else
                return false
            end
        end,
        --[[
        remove = function(data,value,bankid)
            if()
        end,
        --]]
        add = function(data,value,bank,name)
            if bank == nil then
                bank = findBankObj(data,value)
            end
            name = name or util.id()
            if osga.check(data.types[bank], value) == false then
                return false
            else
                data.banks[bank][name] = value
            end
            return name
        end,
        banks = 
        {
            number = {},
            string = {},
            fn = {},
            boolean = {}
        },
        types = 
        {
            number='number',
            string='string',
            fn='function',
            boolean='boolean'
        }
    }
    if(optionalTypeList ~= nil) then
        for k, v in pairs(args) do
            result.banks[k] = {}
            result.types[k] = abstract(v)
        end
    end
    return result
end

local a = {p = 'armando',l={abc=1,2,3,4,5},k={ronaldo={12,34},rogerio={123}}}
local c = osga.type(a)
return osga