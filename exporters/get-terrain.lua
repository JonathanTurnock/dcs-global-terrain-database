--[[
    Script to return a GeoJSON Feature object of the theatre, including the projection string for transverse mercator projection

    Link to repo about tmerc proj
    https://github.com/JonathanTurnock/dcs-projections

    Good Resource About Meridians
    https://gisgeography.com/central-meridian/

    Good for Validating Central Meridian and UTM Zones
    https://mangomap.com/robertyoung/maps/69585/what-utm-zone-am-i-in-%23#

    This code is under MIT licence, you can find the complete file at https://opensource.org/licenses/MIT
]]--
function getUtm (lon)
    local utm = {}
    if lon >= 0 then
        utm.startLon = lon - (lon % 6)
        utm.endLon = utm.startLon + 6
        utm.centralMeridian = utm.startLon + 3
        utm.zone = 30 + (utm.endLon / 6)
    else
        utm.startLon = lon + ((lon * -1) % 6)
        utm.endLon = utm.startLon - 6
        utm.centralMeridian = utm.startLon - 3
        utm.zone = 30 + (utm.startLon / 6)
    end

    return utm
end

local type = "Feature"
local geometry = {type="Polygon",coordinates={}} --TODO: Calculate the BBOX of the theatre (Total Area)
local properties = { type = "TERRAIN", id = env.mission.theatre, name = env.mission.theatre }

lat, lon, alt = coord.LOtoLL({ x = 0, y = 0, z = 0 })

properties.center = { lat = lat, lon = lon, alt = alt }

local utm = getUtm(lon)

local scale = 0.9996

local offset = coord.LLtoLO(0, 0 + utm.centralMeridian)

local proj = "+proj=tmerc +lat_0=0 +lon_0=" .. utm.centralMeridian .. " +k_0=" .. scale .. " +x_0=" .. offset.z .. " +y_0=" .. offset.x .. " +towgs84=0,0,0,0,0,0,0 +units=m +vunits=m +ellps=WGS84 +no_defs +axis=neu"

properties.hemisphere = lat > 0 and "n" or "s"
properties.utm = utm
properties.projection = { scale = scale, offset = offset, proj = proj }

return { type = type, geometry = geometry, properties = properties }