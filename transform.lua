--[[ 
  Provides methods for transforming between geometric representations.

  Methods:
    Transform.computeHeading - shown by a compass when on a planet.
    Transform.computePRYangles - to determine 'pitch', 'roll', and 'yaw'.
    Transform.makeCoordinateConverters - between world and construct coordinates

  Description
    DualUniverse (DU) defines several coordinate systems. This module deals with
    the conversion and use of 'world coordinates' (a cartesian coordinate
    system that spans a planetary system) and 'construct coordinates' which
    is the coordinate system defined by a 'core' element (when not overriden
    by a 'gyro' unit).
    A 'core' element orientates the coordinate system with the axis: 'right',
    'forward' (the direction indicated by the arrow on the core), and 'up'
    (indicated by the side of the core with the arrow). This coordinate system
    is a 'right-handed' coordinate system so 'right' is the direction pointed
    to by the thumb on the right hand when the fingers "curl" from 'forward'
    direction to the 'up' direction.

    Note that the routines in this module accept input vectors of type
    'cpml.vec3' or as a three element Lua array (as returned by DU API codex
    functions).  All returned vectors are of type 'cpml.vec3'

    The 'computeHeading' function takes a position (in world coordinates),
    a direction vector and the world coordinates of the planet's center and
    returns the "compass heading" in radians coresponding to the direction
    vector. "North" has a heading of 0 radians.

    The 'computePRYangles' function returns the "pitch", "roll", and "yaw"
    angles (in radians) which could be used to rotate a one coordinate system
    so that it aligns with another. These are equivalent (not equal) to Euler
    angles.

    The 'makeCoordinateConverters() function returns two functions and three
    vectors. The first function will convert a position in "world" coordinates
    to the same position in "construct" coordinates. 
    The second function returned converts a position in "construct" coordinates
    to the same position in "world coordinates".
    Finally, the three vectors define the 'right', 'forward', and 'up' axis
    of the construct coordinate system in terms of the world coordinates.

  Example Usage:

    Transform = require('autoconf.custom.transform')

    -- On Alioth, determine the direction a construct is heading (NOT facing).
    alioth = vec3({x=-8.000,y=-8.000,z=-126303.000}) -- center position
    heading = Transform.computeHeading(alioth,
                                       core.getConstructWorldPos(),
                                       core.getWorldVelocity())
    system.print('Heading: ' .. 180*heading/math.pi .. ' degrees from north')

    -- Find the PRY angles of a construct relative to a coordinate system of
    -- a construct that is level (i.e. 'up' is colinear with "vertical") and
    -- whose forward facing in the same direction as the other construct's
    -- velocity vector. Both sets of coordinate systems are defined using
    -- the world coordinate system:

    -- First define the reference coordinate system's axis:
    velocity   = vec3(core.getWorldVelocity())
    refUp      = -vec3(core.getWorldVertical())
    refForward = velocity:project_on_plane(refUp):normalize()
    -- if needed, refRight is given by: refForward:cross(refUp)

    -- Now get the construct's 'forward' and 'up' axis:
    fwd        = core.getConstructWorldOrientationForward()
    up         = core.getConstructWorldOrientationUp()

    pitch,roll,yaw = Transform.computePRYangles(refForward, refUp, fwd, up)
    system.print('Pitch: ' .. 180*pitch/math.pi ..
                 ' roll: ' .. 180*roll/math.pi ..
                  ' yaw: ' .. 180*yaw/math.pi)

    -- In some cases, the DU API provides functions to get the same vector
    -- in either world or construct coordinate systems. The following compares
    -- the native methods and the conversion results for one case:

    velocityWorld = vec3(core.getWorldVelocity())
    velocityCref  = vec3(core.getVelocity())
    
    worldToCref, crefToWorld = Transform.makeCoordinateConverters(core)

    error1 = (velocityCref  - worldToCref(velocityWorld)):len()
    error2 = (velocityWorld - crefToWorld(velocityCref)):len()
    system,print('differences: ' .. error1 .. ', ' .. error2)
                 
  Also See: planetref.lua
]]--

local vec3  = require('cpml.vec3')
local utils = require('cpml.utils')
local clamp = utils.clamp

local Transform = {}

--
-- computeHeading - compute compass heading corresponding to a direction.
-- planetCenter[in]: planet's center in world coordinates.
-- position    [in]: construct's position in world coordinates.
-- direction   [in]: the direction in world coordinates of the heading.
-- return: the heading in radians where 0 is North, PI is South.
-- 
function Transform.computeHeading(planetCenter, position, direction)
    planetCenter   = vec3(planetCenter)
    position       = vec3(position)
    direction      = vec3(direction)
    local radius   = position - planetCenter
    if radius.x == 0 and radius.y == 0 then -- at north or south pole
        return radius.z >=0 and math.pi or 0
    end
    local chord    = planetCenter + vec3(0,0,radius:len()) - position
    local north    = chord:project_on_plane(radius):normalize_inplace()
    -- facing north, east is to the right
    local east     = north:cross(radius):normalize_inplace()
    local dir_prj  = direction:project_on_plane(radius):normalize_inplace()
    local adjacent = north:dot(dir_prj)
    local opposite = east:dot(dir_prj)
    local heading  = math.atan(opposite, adjacent) -- North==0

    if heading < 0 then heading = heading + 2*math.pi end
    if math.abs(heading - 2*math.pi) < .001 then heading = 0 end
    return heading
end

--
-- computePRYangles - compute rotation angles of the f-u coordinate system
-- yaxis [in]: The y-axis of the reference coordinate system in world coords.
-- zaxis [in]: The z-axis of the reference coordinate system in world coords.
-- faxis [in]: The f-axis of the rotated coordinate system in world coords.
-- uaxis [in]: The u-axis of the rotated coordinate system in world coords.
-- return: pitch roll, yaw angles of the f-u coordinate system
--
function Transform.computePRYangles(yaxis, zaxis, faxis, uaxis)
    yaxis = yaxis.x and yaxis or vec3(yaxis)
    zaxis = zaxis.x and zaxis or vec3(zaxis)
    faxis = faxis.x and faxis or vec3(faxis)
    uaxis = uaxis.x and uaxis or vec3(uaxis)
    local zproject = zaxis:project_on_plane(faxis):normalize_inplace()
    local adjacent = uaxis:dot(zproject)
    local opposite = faxis:cross(zproject):dot(uaxis)
    local roll     = math.atan(opposite, adjacent) -- rotate 'up' around 'fwd'
    local pitch    = math.asin(clamp(faxis:dot(zaxis), -1, 1))
    local fproject = faxis:project_on_plane(zaxis):normalize_inplace()
    local yaw      = math.asin(clamp(yaxis:cross(fproject):dot(zaxis), -1, 1))
    return pitch, roll, yaw
end

--
-- makeCoordinateConverters - create coordinate conversion functions
-- return: functors for conversions and the r-f-u vectors in world coordinates
-- 

if library and library.systemResolution3 then

-- systemResolution3 "solves" the equation M*x = c0 by finding the inverse
-- of 'M' so that x = M(inv)*c0. Since a native matrix multiplication routine
-- is not provided (shame), this fact is used to effect one by finding an 'M'
-- whose inverse, 'M(inv)' is the desired matrix needed in the mulitplication.
--
-- Fortunately, rotation matrices are "orthoganal", and orthoganal matrices
-- have the property that their inverse is equal to the matrix transposed.
--
-- Note: I have NOT benchmarked the following two implementations to see which
-- is faster, the presumption is the native version should be so it is used
-- when available.
local solve = library.systemResolution3

function Transform.makeCoordinateConverters(coreUnit)
    local core     = coreUnit or core
    local vc1      = core.getConstructWorldOrientationRight()
    local vc2      = core.getConstructWorldOrientationForward()
    local vc3      = core.getConstructWorldOrientationUp()
    local vc1t     = solve(vc1, vc2, vc3, {1,0,0})
    local vc2t     = solve(vc1, vc2, vc3, {0,1,0})
    local vc3t     = solve(vc1, vc2, vc3, {0,0,1})
    return  function(world) -- transform to construct coordinates
                world = world.x and {world:unpack()} or world
                return vec3(solve(vc1, vc2, vc3, world))
            end,
            function(cref) -- transform to world coordinates
                cref = cref.x and {cref:unpack()} or cref
                return vec3(solve(vc1t, vc2t, vc3t, cref))
            end,
            vec3(vc1), vec3(vc2), vec3(vc3)
end

else

function Transform.makeCoordinateConverters(coreUnit)
    local core     = coreUnit or core
    local right    = vec3(core.getConstructWorldOrientationRight())
    local fwd      = vec3(core.getConstructWorldOrientationForward())
    local up       = vec3(core.getConstructWorldOrientationUp())
    return  function(world) -- transform to construct coordinates
                world = world.x and world or vec3(world)
                return vec3(right:dot(world), fwd:dot(world), up:dot(world))
            end,
            function(cref) -- transform to world coordinates
                cref = cref.x and cref or vec3(cref)
                return right*cref.x + fwd*cref.y + up*cref.z
            end,
            right, fwd, up
end

end

return Transform
