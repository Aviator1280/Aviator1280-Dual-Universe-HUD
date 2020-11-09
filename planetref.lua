--[[ 
  Provide coordinate transforms and access to kinematic related parameters
  Author: JayleBreak

  Usage (unit.start):
  PlanetaryReference = require('planetref')
  galaxyReference = PlanetaryReference(referenceTableSource)
  helios = galaxyReference[0] -- PlanetaryReference.PlanetarySystem instance
  alioth = helios[2]          -- PlanetaryReference.BodyParameters instance

  Methods:
    PlanetaryReference:getPlanetarySystem - based on planetary system ID.
    PlanetaryReference.isMapPosition - 'true' if an instance of 'MapPosition'
    PlanetaryReference.createBodyParameters - for entry into reference table
    PlanetaryReference.BodyParameters - a class containing a body's information.
    PlanetaryReference.MapPosition - a class for map coordinates
    PlanetaryReference.PlanetarySystem - a container for planetary system info.

    PlanetarySystem:castIntersections - from a position in a given direction.
    PlanetarySystem:closestBody - to the specified coordinates.
    PlanetarySystem:convertToBodyIdAndWorldCoordinates - from map coordinates.
    PlanetarySystem:getBodyParameters - from reference table.
    PlanetarySystem:getPlanetarySystemId - for the instance.

    BodyParameters:convertToWorldCoordinates - from map coordinates
    BodyParameters:convertToMapPosition - from world coordinates
    BodyParameters:getAltitude - of world coordinates
    BodyParameters:getDistance - from center to world coordinates
    BodyParameters:getGravity - at a given position in world coordinates.

  Description
  An instance of the 'PlanetaryReference' "class" can contain transform and
  kinematic reference information for all planetary systems in DualUniverse.
  Each planetary system is identified by a numeric identifier. Currently,
  the only planetary system, Helios, has the identifier: zero. This "class"
  supports the indexing ('[]') operation which is equivalent to the
  use of the 'getPlanetarySystem' method. It also supports the 'pairs()'
  method for iterating over planetary systems.
  
  An instance of the 'PlanetarySystem' "class" contains all reference
  information for a specific system. It supports the indexing ('[]') and
  'pairs()' functions which allows iteration over each "body" in the
  system where the key is the numeric body ID. It also supports the
  'tostring()' method.

  An instance of the 'BodyParameters' "class" contains all reference
  information for a single celestial "body" (a moon or planet). It supports
  the 'tostring()' method, and contains the data members:
          planetarySystemId - numeric planetary system ID
          bodyId            - numeric body ID
          radius            - radius of the body in meters (zero altitude)
          center            - world coordinates of the body's center position
          GM                - the gravitation parameter (g = GM/radius^2)
  Note that the user is allowed to add custom fields (e.g. body name), but
  should insure that complex table values have the '__tostring' metamethod
  implemented.

  Transform and Kinematics:
  "World" coordinates is a cartesian coordinate system with an origin at an
  arbitrary fixed point in a planetary system and with distances measured in
  meters. The coordinates are expressible either as a simple table of 3 values
  or an instance of the 'vec3' class.  In either case, the planetary system
  identity is implicit.

  "Map" coordinates is a geographic coordinate system with an origin at the
  center of an identified (by a numeric value) celestial body which is a
  member of an identified (also a numeric value) planetary system. Note that
  the convention that latitude, longitude, and altitude values will be the
  position's x, y, and z world coordinates in the special case of body ID 0.

  The kinematic parameters in the reference data permit calculations of the
  gravitational attraction of the celestial body on other objects.

  Reference Data:
  This is an example of reference data with a single entry assigned to
  planetary system ID 0, and body ID 2 ('Alioth'):
    referenceTable = {
          [0] = { [2] = { planetarySystemId = 0,
                          bodyId = 2,
                          radius = 126068,
                          center = vec3({x=-8, y=-8, z=-126303}),
                          GM = 1.572199+11 } -- as in F=-GMm/r^2
          }
      }
    ref=PlanetaryReference(referenceTable)

  Collecting Reference Data:
  A combination of information from the "Map" screen in the DU user interface,
  and values reported by the DU Lua API can be the source of the reference
  table's data (planetarySystemId, bodyId, and surfaceArea is from the user
  interface):
    referenceTable = {}
    referenceTable[planetarySystemId][bodyId] =
         PlanetaryReference.createBodyParameters(planetarySystemId,
                                                 bodyId,
                                                 surfaceArea,
                                                 core.getConstructWorldPos(),
                                                 core.getWorldVertical(),
                                                 core.getAltitude(),
                                                 core.g())


  Adapting Data Sources:
  Other sources of data can be adapted or converted. An example of adapting a
  table, defined in the file: 'planets.lua', containing information on a single
  planetary system and using celestial body name as the key follows (note that
  a 'name' field is added to the BodyParameters instance transparently after
  construction, and the '__pairs' meta function is required to support the
  'closestBody' and '__tostring' methods):
    ref=PlanetaryReference(
        {[0] = setmetatable(require('planets'),
                        { __index = function(bodies, bodyId)
                             for _,v in pairs(bodies) do
                                 if v and v.bodyId == bodyId then return v end
                             end
                             return nil
                           end,
                         __pairs = function(bodies)
                             return function(t, k)
                                     local nk, nv = next(t, k)
                                     if nv then
                                         local GM = nv.gravity * nv.radius^2
                                         local bp = BodyParameters(0,
                                                                   nv.id,
                                                                   nv.radius,
                                                                   nv.pos,
                                                                   GM)
                                         bp.name = nk
                                         return nk, bp
                                    end
                                    return nk, nv
                                 end, bodies, nil
                           end })
    })
    
  Converting Data Sources:
  An instance of 'PlanetaryReference' that has been adapted to a data source
  can be used to convert that source to simple table. For example,
  using the adapted instance shown above:
    load('convertedData=' .. tostring(ref))()
    newRef=PlanetaryReference(convertedData)

  Also See: kepler.lua
  ]]--

--[[                    START OF LOCAL IMPLEMENTATION DETAILS             ]]--

-- Type checks

local function isNumber(n)  return type(n)           == 'number' end
local function isSNumber(n) return type(tonumber(n)) == 'number' end
local function isTable(t)   return type(t)           == 'table'  end
local function isString(s)  return type(s)           == 'string' end
local function isVector(v)  return isTable(v)
                                    and isNumber(v.x and v.y and v.z) end

local function isMapPosition(m) return isTable(m) and isNumber(m.latitude  and
                                                               m.longitude and
                                                               m.altitude  and
                                                               m.bodyId    and
                                                               m.systemId) end

-- Constants

local deg2rad    = math.pi/180
local rad2deg    = 180/math.pi
local epsilon    = 1e-10
local num        = ' *([+-]?%d+%.?%d*e?[+-]?%d*)'
local posPattern = '::pos{' .. num .. ',' .. num .. ',' ..  num .. ',' ..
                   num ..  ',' .. num .. '}'

-- Utilities

local utils  = require('cpml.utils')
local vec3   = require('cpml.vec3')
local clamp  = utils.clamp

local function float_eq(a,b)
    if a == 0 then return math.abs(b) < 1e-09 end
    if b == 0 then return math.abs(a) < 1e-09 end
    return math.abs(a - b) < math.max(math.abs(a),math.abs(b))*epsilon
end

local function formatNumber(n)
    local result = string.gsub(
                    string.reverse(string.format('%.4f',n)),
                    '^0*%.?','')
    return result == '' and '0' or string.reverse(result)
end

local function formatValue(obj)
    if isVector(obj) then
        return string.format('{x=%.3f,y=%.3f,z=%.3f}', obj.x, obj.y, obj.z)
    end

    if isTable(obj) and not getmetatable(obj) then
        local list = {}
        local nxt  = next(obj)

        if type(nxt) == 'nil' or nxt == 1 then -- assume this is an array
            list = obj
        else
            for k,v in pairs(obj) do
                local value = formatValue(v)
                if type(k) == 'number' then
                    table.insert(list, string.format('[%s]=%s', k, value))
                else
                    table.insert(list, string.format('%s=%s',   k, value))
                end
            end
        end
        return string.format('{%s}', table.concat(list, ','))
    end

    if isString(obj) then
        return string.format("'%s'", obj:gsub("'",[[\']]))
    end
    return tostring(obj)
end

-- CLASSES

-- BodyParameters: Attributes of planetary bodies (planets and moons)

local BodyParameters = {}
BodyParameters.__index = BodyParameters
BodyParameters.__tostring =
    function(obj, indent)
        local sep = indent or ''
        local keys = {}
        for k in pairs(obj) do table.insert(keys, k) end
        table.sort(keys)
        local list = {}
        for _, k in ipairs(keys) do
            local value = formatValue(obj[k])
            if type(k) == 'number' then
                table.insert(list, string.format('[%s]=%s', k, value))
            else
                table.insert(list, string.format('%s=%s', k, value))
            end
        end
        if indent then
            return string.format('%s%s',
                                 indent,
                                 table.concat(list, ',\n' .. indent))
        end
        return string.format('{%s}', table.concat(list, ','))
    end
BodyParameters.__eq = function(lhs, rhs)
        return lhs.planetarySystemId == rhs.planetarySystemId and
               lhs.bodyId            == rhs.bodyId            and
               float_eq(lhs.radius, rhs.radius)               and
               float_eq(lhs.center.x, rhs.center.x)           and
               float_eq(lhs.center.y, rhs.center.y)           and
               float_eq(lhs.center.z, rhs.center.z)           and
               float_eq(lhs.GM, rhs.GM)
    end

local function mkBodyParameters(systemId, bodyId, radius, worldCoordinates, GM)
    -- 'worldCoordinates' can be either table or vec3
    assert(isSNumber(systemId),
           'Argument 1 (planetarySystemId) must be a number:' .. type(systemId))
    assert(isSNumber(bodyId),
           'Argument 2 (bodyId) must be a number:' .. type(bodyId))
    assert(isSNumber(radius),
           'Argument 3 (radius) must be a number:' .. type(radius))
    assert(isTable(worldCoordinates),
           'Argument 4 (worldCoordinates) must be a array or vec3.' ..
           type(worldCoordinates))
    assert(isSNumber(GM),
           'Argument 5 (GM) must be a number:' .. type(GM))
    return setmetatable({planetarySystemId = tonumber(systemId),
                         bodyId            = tonumber(bodyId),
                         radius            = tonumber(radius),
                         center            = vec3(worldCoordinates),
                         GM                = tonumber(GM) }, BodyParameters)
end

-- MapPosition: Geographical coordinates of a point on a planetary body.

local MapPosition = {}
MapPosition.__index = MapPosition
MapPosition.__tostring = function(p)
        return string.format('::pos{%d,%d,%s,%s,%s}',
                             p.systemId,
                             p.bodyId,
                             formatNumber(p.latitude*rad2deg),
                             formatNumber(p.longitude*rad2deg),
                             formatNumber(p.altitude))
    end
MapPosition.__eq       = function(lhs, rhs)
        return lhs.bodyId   == rhs.bodyId              and
               lhs.systemId == rhs.systemId            and
               float_eq(lhs.latitude,   rhs.latitude)  and
               float_eq(lhs.altitude,   rhs.altitude)  and
               (float_eq(lhs.longitude, rhs.longitude) or
                float_eq(lhs.latitude, math.pi/2)      or
                float_eq(lhs.latitude, -math.pi/2))
    end

-- latitude and longitude are in degrees while altitude is in meters

local function mkMapPosition(overload, bodyId, latitude, longitude, altitude)
    local systemId = overload -- Id or '::pos{...}' string

    if isString(overload) and not longitude and not altitude and
                              not bodyId    and not latitude then
        systemId, bodyId, latitude, longitude, altitude =
                                            string.match(overload, posPattern)
        assert(systemId, 'Argument 1 (position string) is malformed.')
    else
        assert(isSNumber(systemId),
               'Argument 1 (systemId) must be a number:' .. type(systemId))
        assert(isSNumber(bodyId),
               'Argument 2 (bodyId) must be a number:' .. type(bodyId))
        assert(isSNumber(latitude),
               'Argument 3 (latitude) must be in degrees:' .. type(latitude))
        assert(isSNumber(longitude),
               'Argument 4 (longitude) must be in degrees:' .. type(longitude))
        assert(isSNumber(altitude),
               'Argument 5 (altitude) must be in meters:' .. type(altitude))
    end
    systemId  = tonumber(systemId)
    bodyId    = tonumber(bodyId)
    latitude  = tonumber(latitude)
    longitude = tonumber(longitude)
    altitude  = tonumber(altitude)

    if bodyId == 0 then -- this is a hack to represent points in space
        return setmetatable({latitude  = latitude,
                             longitude = longitude,
                             altitude  = altitude,
                             bodyId    = bodyId,
                             systemId  = systemId}, MapPosition)
    end
    return setmetatable({latitude  = deg2rad*clamp(latitude, -90, 90),
                         longitude = deg2rad*(longitude % 360),
                         altitude  = altitude,
                         bodyId    = bodyId,
                         systemId  = systemId}, MapPosition)
end

-- PlanetarySystem - map body IDs to BodyParameters

local PlanetarySystem = {}
PlanetarySystem.__index = PlanetarySystem

PlanetarySystem.__tostring =
    function (obj, indent)
        local sep = indent and (indent .. '  ' )
        local bdylist = {}
        local keys = {}
        for k in pairs(obj) do table.insert(keys, k) end
        table.sort(keys)
        for _, bi in ipairs(keys) do
            bdy = obj[bi]
            local bdys = BodyParameters.__tostring(bdy, sep)
            if indent then
                table.insert(bdylist,
                             string.format('[%s]={\n%s\n%s}',
                                           bi, bdys, indent))
            else
                table.insert(bdylist, string.format('  [%s]=%s', bi, bdys))
            end
        end
        if indent then
            return string.format('\n%s%s%s',
                                 indent,
                                 table.concat(bdylist, ',\n' .. indent),
                                 indent)
        end
        return string.format('{\n%s\n}', table.concat(bdylist, ',\n'))
    end

local function mkPlanetarySystem(referenceTable)
    local atlas = {}
    local pid
    for _, v in pairs(referenceTable) do
        local id = v.planetarySystemId

        if type(id) ~= 'number' then
            error('Invalid planetary system ID: ' .. tostring(id))
        elseif pid and id ~= pid then
            error('Mismatch planetary system IDs: ' .. id .. ' and '
                  .. pid)
        end
        local bid = v.bodyId
        if type(bid) ~= 'number' then
            error('Invalid body ID: ' .. tostring(bid))
        elseif atlas[bid] then
            error('Duplicate body ID: ' .. tostring(bid))
        end
        setmetatable(v.center, getmetatable(vec3.unit_x))
        atlas[bid] = setmetatable(v, BodyParameters)
        pid = id
    end
    return setmetatable(atlas, PlanetarySystem)
end

-- PlanetaryReference - map planetary system ID to PlanetarySystem

PlanetaryReference = {}

local function mkPlanetaryReference(referenceTable)
    return setmetatable({ galaxyAtlas = referenceTable or {} },
                          PlanetaryReference)
end

PlanetaryReference.__index        = 
    function(t,i)
        if type(i) == 'number' then
            local system = t.galaxyAtlas[i]
            return mkPlanetarySystem(system)
        end
        return rawget(PlanetaryReference, i)
    end
PlanetaryReference.__pairs        =
    function(obj)
        return  function(t, k)
                    local nk, nv = next(t, k)
                    return nk, nv and mkPlanetarySystem(nv)
                end, obj.galaxyAtlas, nil
    end
PlanetaryReference.__tostring     =
    function (obj)
        local pslist = {}
        for _,ps in pairs(obj or {}) do
            local psi = ps:getPlanetarySystemId()
            local pss = PlanetarySystem.__tostring(ps, '    ')
            table.insert(pslist,
                         string.format('  [%s]={%s\n  }', psi, pss))
        end
        return string.format('{\n%s\n}\n', table.concat(pslist,',\n'))
    end


--[[                       START OF PUBLIC INTERFACE                       ]]--


-- PlanetaryReference CLASS METHODS:

--
-- BodyParameters - create an instance of BodyParameters class
-- planetarySystemId  [in]: the body's planetary system ID.
-- bodyId             [in]: the body's ID.
-- radius             [in]: the radius in meters of the planetary body.
-- bodyCenter         [in]: the world coordinates of the center (vec3 or table).
-- GM                 [in]: the body's standard gravitational parameter.
-- return: an instance of BodyParameters class.
--
PlanetaryReference.BodyParameters = mkBodyParameters

--
-- MapPosition - create an instance of the MapPosition class
-- overload [in]: either a planetary system ID or a position string ('::pos...')
-- bodyId [in]:   (ignored if overload is a position string) the body's ID.
-- latitude [in]: (ignored if overload is a position string) the latitude.
-- longitude [in]:(ignored if overload is a position string) the longitude.
-- altitude [in]: (ignored if overload is a position string) the altitude.
-- return: the class instance
--
PlanetaryReference.MapPosition    = mkMapPosition

--
-- PlanetarySystem - create an instance of PlanetarySystem class
-- referenceData [in]: a table (indexed by bodyId) of body reference info.
-- return: the class instance
--
PlanetaryReference.PlanetarySystem = mkPlanetarySystem

--
-- createBodyParameters - create an instance of BodyParameters class
-- planetarySystemId  [in]: the body's planetary system ID.
-- bodyId             [in]: the body's ID.
-- surfaceArea        [in]: the body's surface area in square meters.
-- aPosition          [in]: world coordinates of a position near the body.
-- verticalAtPosition [in]: a vector pointing towards the body center.
-- altitudeAtPosition [in]: the altitude in meters at the position.
-- gravityAtPosition  [in]: the magnitude of the gravitational acceleration.
-- return: an instance of BodyParameters class.
--
function PlanetaryReference.createBodyParameters(planetarySystemId,
                                                 bodyId,
                                                 surfaceArea,
                                                 aPosition,
                                                 verticalAtPosition,
                                                 altitudeAtPosition,
                                                 gravityAtPosition)
    assert(isSNumber(planetarySystemId),
           'Argument 1 (planetarySystemId) must be a number:' ..
           type(planetarySystemId))
    assert(isSNumber(bodyId),
           'Argument 2 (bodyId) must be a number:' .. type(bodyId))
    assert(isSNumber(surfaceArea),
           'Argument 3 (surfaceArea) must be a number:' .. type(surfaceArea))
    assert(isTable(aPosition),
           'Argument 4 (aPosition) must be an array or vec3:' ..
           type(aPosition))
    assert(isTable(verticalAtPosition),
           'Argument 5 (verticalAtPosition) must be an array or vec3:' ..
           type(verticalAtPosition))
    assert(isSNumber(altitudeAtPosition),
           'Argument 6 (altitude) must be in meters:' ..
           type(altitudeAtPosition))
    assert(isSNumber(gravityAtPosition),
           'Argument 7 (gravityAtPosition) must be number:' ..
           type(gravityAtPosition))
    local radius   = math.sqrt(surfaceArea/4/math.pi)
    local distance = radius + altitudeAtPosition
    local center   = vec3(aPosition) + distance*vec3(verticalAtPosition)
    local GM       = gravityAtPosition * distance * distance
    return mkBodyParameters(planetarySystemId, bodyId, radius, center, GM)
end

--
-- isMapPosition - check for the presence of the 'MapPosition' fields
-- valueToTest [in]: the value to be checked
-- return: 'true' if all required fields are present in the input value
--
PlanetaryReference.isMapPosition  = isMapPosition

-- PlanetaryReference INSTANCE METHODS:

--
-- getPlanetarySystem - get the planetary system using ID or MapPosition as key
-- overload [in]: either the planetary system ID or a MapPosition that has it.
-- return: instance of 'PlanetarySystem' class or nil on error
--
function PlanetaryReference:getPlanetarySystem(overload)
    if self.galaxyAtlas then
        local planetarySystemId = overload

        if isMapPosition(overload) then
            planetarySystemId = overload.systemId
        end

        if type(planetarySystemId) == 'number' then
            local system = self.galaxyAtlas[i]
            if system then
                if getmetatable(nv) ~= PlanetarySystem then
                    system = mkPlanetarySystem(system)
                end
                return system
            end
        end
    end
    return nil
end

-- PlanetarySystem INSTANCE METHODS:

--
-- castIntersections - Find the closest body that intersects a "ray cast".
-- origin [in]: the origin of the "ray cast" in world coordinates
-- direction [in]: the direction of the "ray cast" as a 'vec3' instance.
-- sizeCalculator [in]: (default: returns 1.05*radius) Returns size given body.
-- bodyIds[in]: (default: all IDs in system) check only the given IDs.
-- return: The closest body that blocks the cast or 'nil' if none.
--
function PlanetarySystem:castIntersections(origin,
                                           direction,
                                           sizeCalculator,
                                           bodyIds)
    local sizeCalculator = sizeCalculator or 
                            function (body) return 1.05*body.radius end
    local candidates = {}

    if bodyIds then
        for _,i in ipairs(bodyIds) do candidates[i] = self[i] end
    else
        bodyIds = {}
        for k,body in pairs(self) do
            table.insert(bodyIds, k)
            candidates[k] = body
        end
    end
    local function compare(b1,b2)
        local v1 = candidates[b1].center - origin
        local v2 = candidates[b2].center - origin
        return v1:len() < v2:len()
    end
    table.sort(bodyIds, compare)
    local dir = direction:normalize()

    for i, id in ipairs(bodyIds) do
        local body   = candidates[id]
        local c_oV3  = body.center - origin
        local radius = sizeCalculator(body)
        local dot    = c_oV3:dot(dir)
        local desc   = dot^2 - (c_oV3:len2() - radius^2)

        if desc >= 0 then
            local root     = math.sqrt(desc)
            local farSide  = dot + root
            local nearSide = dot - root
            if nearSide > 0 then
                return body, farSide, nearSide
            elseif farSide > 0 then
                return body, farSide, nil
            end
        end
    end
    return nil, nil, nil
end

--
-- closestBody - find the closest body to a given set of world coordinates
-- coordinates       [in]: the world coordinates of position in space
-- return: an instance of the BodyParameters object closest to 'coordinates'
--
function PlanetarySystem:closestBody(coordinates)
    assert(type(coordinates) == 'table', 'Invalid coordinates.')
    local minDistance2, body
    local coord = vec3(coordinates)

    for _,params in pairs(self) do
        local distance2 = (params.center - coord):len2()
        if not body or distance2 < minDistance2 then
            body         = params
            minDistance2 = distance2
        end
    end
    return body
end

--
-- convertToBodyIdAndWorldCoordinates - map to body Id and world coordinates
-- overload [in]: an instance of MapPosition or a position string ('::pos...)
-- return: a vec3 instance containing the world coordinates or 'nil' on error.
--
function PlanetarySystem:convertToBodyIdAndWorldCoordinates(overload)
    local mapPosition = overload
    if isString(overload) then
        mapPosition = mkMapPosition(overload)
    end

    if mapPosition.bodyId == 0 then
        return 0, vec3(mapPosition.latitude,
                       mapPosition.longitude,
                       mapPosition.altitude)
    end
    local params = self:getBodyParameters(mapPosition)

    if params then
        return mapPosition.bodyId,
               params:convertToWorldCoordinates(mapPosition)
    end
end

--
-- getBodyParameters - get or create an instance of BodyParameters class
-- overload [in]: either an instance of MapPosition or a body's ID.
-- return: a BodyParameters instance or 'nil' if body ID is not found.
--
function PlanetarySystem:getBodyParameters(overload)
    local bodyId = overload

    if isMapPosition(overload) then
        bodyId = overload.bodyId
    end
    assert(isSNumber(bodyId),
               'Argument 1 (bodyId) must be a number:' .. type(bodyId))

    return self[bodyId]
end

--
-- getPlanetarySystemId - get the planetary system ID for this instance
-- return: the planetary system ID or nil if no planets are in the system.
--
function PlanetarySystem:getPlanetarySystemId()
    local k, v = next(self)
    return v and v.planetarySystemId
end

-- BodyParameters INSTANCE METHODS:

--
-- convertToMapPosition - create an instance of MapPosition from coordinates
-- worldCoordinates [in]: the world coordinates of the map position.
-- return: an instance of MapPosition class
--
function BodyParameters:convertToMapPosition(worldCoordinates)
    assert(isTable(worldCoordinates),
           'Argument 1 (worldCoordinates) must be an array or vec3:' ..
           type(worldCoordinates))
    local worldVec  = vec3(worldCoordinates) 

    if self.bodyId == 0 then
        return setmetatable({latitude  = worldVec.x,
                             longitude = worldVec.y,
                             altitude  = worldVec.z,
                             bodyId    = 0,
                             systemId  = self.planetarySystemId}, MapPosition)
    end
    local coords    = worldVec - self.center
    local distance  = coords:len()
    local altitude  = distance - self.radius
    local latitude  = 0
    local longitude = 0

    if not float_eq(distance, 0) then
        local phi = math.atan(coords.y, coords.x)
        longitude = phi >= 0 and phi or (2*math.pi + phi)
        latitude  = math.pi/2 - math.acos(coords.z/distance)
    end
    return setmetatable({latitude  = latitude,
                         longitude = longitude,
                         altitude  = altitude,
                         bodyId    = self.bodyId,
                         systemId  = self.planetarySystemId}, MapPosition)
end

--
-- convertToWorldCoordinates - convert a map position to world coordinates
-- overload [in]: an instance of MapPosition or a position string ('::pos...')
--
function BodyParameters:convertToWorldCoordinates(overload)
    local mapPosition = isString(overload) and
                                           mkMapPosition(overload) or overload
    if mapPosition.bodyId == 0 then -- support deep space map position
        return vec3(mapPosition.latitude,
                    mapPosition.longitude,
                    mapPosition.altitude)
    end
    assert(isMapPosition(mapPosition),
           'Argument 1 (mapPosition) is not an instance of "MapPosition".')
    assert(mapPosition.systemId == self.planetarySystemId,
           'Argument 1 (mapPosition) has a different planetary system ID.')
    assert(mapPosition.bodyId == self.bodyId,
           'Argument 1 (mapPosition) has a different planetary body ID.')
    local xproj = math.cos(mapPosition.latitude)
    return self.center + (self.radius + mapPosition.altitude) *
           vec3(xproj*math.cos(mapPosition.longitude),
                xproj*math.sin(mapPosition.longitude),
                math.sin(mapPosition.latitude))
end

--
-- getAltitude - calculate the altitude of a point given in world coordinates.
-- worldCoordinates [in]: the world coordinates of the point.
-- return: the altitude in meters
--
function BodyParameters:getAltitude(worldCoordinates)
    return (vec3(worldCoordinates) - self.center):len() - self.radius
end

--
-- getDistance - calculate the distance to a point given in world coordinates.
-- worldCoordinates [in]: the world coordinates of the point.
-- return: the distance in meters
--
function BodyParameters:getDistance(worldCoordinates)
    return (vec3(worldCoordinates) - self.center):len()
end

--
-- getGravity - calculate the gravity vector induced by the body.
-- worldCoordinates [in]: the world coordinates of the point.
-- return: the gravity vector in meter/seconds^2
--
function BodyParameters:getGravity(worldCoordinates)
    local radial = self.center - vec3(worldCoordinates) -- directed towards body
    local len2   = radial:len2()
    return (self.GM/len2) * radial/math.sqrt(len2)
end

-- end of module

return setmetatable(PlanetaryReference,
                    { __call = function(_,...)
                                    return mkPlanetaryReference(...)
                               end })

