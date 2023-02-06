--[[
DCS World Airbase & Parking export script.

Creates an array of GeoJSON Feature Point objects for airbases and associated parking
properties contains the airbase/parking information.

Example:
{
    "type": "Feature"
    "geometry": {
        "type": "Point"
        "coordinates": [37.359783477556,45.013174733772,43.00004196167],
    },
    "properties": {
        "id": "Anapa-Vityazevo",
        "category": "AIRDROME",
        "name": "Anapa-Vityazevo"
    }
}

This code is under MIT licence, you can find the complete file at https://opensource.org/licenses/MIT
]]--
local features = {}

local categories = { "AIRDROME", "HELIPAD", "SHIP" }

function addAirbase (airbase)
    local feature = {}
    feature.type = "Feature"

    -- Build up Geometry
    feature.geometry = {}
    feature.geometry.type = "Point"

    point = Airbase.getPoint(airbase)
    lat, lon, alt = coord.LOtoLL(point)

    feature.geometry.coordinates = {}
    feature.geometry.coordinates[1] = lon
    feature.geometry.coordinates[2] = lat
    feature.geometry.coordinates[3] = alt

    --Build up Properties
    feature.properties = { type = "AIRBASE" }
    feature.properties.id = Airbase.getCallsign(airbase)

    desc = Airbase.getDesc(airbase)
    feature.properties.name = desc.displayName
    feature.properties.category = categories[desc.category + 1]
    feature.properties.point = point

    --Add Feature to Collection
    table.insert(features, feature)
end

function addParking (airbase, parking)
    local feature = {}
    feature.type = "Feature"

    -- Build up Geometry
    feature.geometry = {}
    feature.geometry.type = "Point"
    lat, lon, alt = coord.LOtoLL(parking.vTerminalPos)

    feature.geometry.coordinates = {}
    feature.geometry.coordinates[1] = lon
    feature.geometry.coordinates[2] = lat
    feature.geometry.coordinates[3] = alt

    -- build up Properties
    feature.properties = { type = "PARKING" }
    feature.properties.id = "TBC"
    feature.properties.point = parking.vTerminalPos
    feature.properties.airbase = Airbase.getCallsign(airbase)

    --Add Feature to Collection
    table.insert(features, feature)
end

for _, airbase in pairs(world.getAirbases()) do
    addAirbase(airbase)
    for _, parking in pairs(Airbase.getParking(airbase)) do
        addParking(airbase, parking)
    end
end

return features
