--[[
    Script to return a a JSON representation of the item passed in.

    Start from _G to explore global namespace, and drill down.

    Strings and Numbers are simply printed, tables, functions etc need to be explored

    This code is under MIT licence, you can find the complete file at https://opensource.org/licenses/MIT
]]--
local function getMeta (data) 
    local meta = {}

    for k,v in pairs(data) do
        local t = type(v)

        if t == 'string' or t == 'number' or t == 'nil' or t == 'boolean' then
            meta[k] = v
        else
            meta[k] = type(v)
        end
    end
    return meta
end

return getMeta(_G)
