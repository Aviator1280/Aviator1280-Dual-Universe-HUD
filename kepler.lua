--[[ 
  Provides methods for computing orbital information for an object

  Usage:
  Kepler = require('autoconf.custom.kepler')
  alioth = Kepler({ GM=157470826617,
                    bodyId=2,
                    center={x=-8.000,y=-8.000,z=-126303.000},
                    name='Alioth',
                    planetarySystemId=0,
                    radius=126068
                  })
  altitude = 6000
  position = '::pos{0,2,0,0,6000}'

  e, o     = alioth:escapeAndOrbitalSpeed(altitude)
  orbit    = alioth:orbitalParameters(position, {0, o+1, 0})

  print("Eccentricity " .. orbit.eccentricity)
  print("Perihelion " .. orbit.periapsis.altitude)
  print("Max. speed " .. orbit.periapsis.speed)
  print("Circular orbit speed " .. orbit.periapsis.circularOrbitSpeed)
  print("Aphelion "  .. orbit.apoapsis.altitude)
  print("Min. speed " .. orbit.apoapsis.speed)
  print("Orbital period " .. orbit.period)
  --- output:
    Eccentricity 0.0018324307017878
    Perihelion 6000.0
    Max. speed 1092.9462297033
    Circular orbit speed 1091.9462297033
    Aphelion 6484.8994605062
    Min. speed 1088.9480596194
    Orbital period 762.02818214049

  Methods:
    Kepler:escapeAndOrbitalSpeed - for a given celestial body and altitude.
    Kepler:orbitalParameters - for a given massless object and a celestial body.

  Description
  The motion of an object in the vicinity of substantially larger mass is
  in the domain of the "2-body problem". By assuming the object whose motion
  is of interest is of negligable mass simplifies the calculations of:
  the speed to escape the body, the speed of a circular orbit, and the
  parameters defining the orbit of the object (or the lack of orbit as the
  case may be).

  Orbital Parameters:
     periapsis - the closest approach to the planet
      apoapsis - the furthest point from the planet if in orbit (otherwise nil)
  eccentricity - 0 for circular orbits
                <1 for elliptical orbits
                 1 for parabiolic trajectory
                >1 for hyperbolic trajectory
        period - time (in seconds) to complete an orbit

  Also See: planetref.lua
]]--

local vec3       = require('cpml.vec3')
local PlanetRef  = require('autoconf.custom.planetref')

local function isString(s) return type(s)   == 'string' end
local function isTable(t)  return type(t)   == 'table'  end

local function float_eq(a,b)
    if a == 0 then return math.abs(b) < 1e-09 end
    if b == 0 then return math.abs(a) < 1e-09 end
    return math.abs(a - b) < math.max(math.abs(a),math.abs(b))*epsilon
end

Kepler = {}
Kepler.__index = Kepler

--
-- escapeAndOrbitalSpeed - speed required to escape and for a circular orbit
-- altitude [in]: the height of the orbit in meters above "sea-level"
-- return: the speed in m/s needed to escape the celestial body and to orbit it.
--
function Kepler:escapeAndOrbitalSpeed(altitude)
    assert(self.body)
    -- P = -GMm/r and KE = mv^2/2 (no lorentz factor used)
    -- mv^2/2 = GMm/r
    -- v^2 = 2GM/r
    -- v = sqrt(2GM/r1)
    local distance = altitude + self.body.radius

    if not float_eq(distance, 0) then
        local orbit = math.sqrt(self.body.GM/distance)
        return math.sqrt(2)*orbit, orbit
    end
    return nil, nil
end

--
-- orbitalParameters: determine the orbital elements for a two-body system.
-- overload [in]: the world coordinates or map coordinates of a massless object.
-- velocity [in]: The velocity of the massless point object in m/s.
-- return: the 6 orbital elements for the massless object.
--
function Kepler:orbitalParameters(overload, velocity)
    assert(self.body)
    assert(isTable(overload) or isString(overload))
    assert(isTable(velocity))
    local pos = (isString(overload) or PlanetRef.isMapPosition(overload)) and
                            self.body:convertToWorldCoordinates(overload) or
                vec3(overload)
    local v   = vec3(velocity)
    local r   = pos - self.body.center
    local v2  = v:len2()
    local d   = r:len()
    local mu  = self.body.GM
    local e   = ((v2 - mu/d)*r - r:dot(v)*v)/mu
    local a   = mu/(2*mu/d - v2)

    local ecc = e:len()
    local dir = e:normalize()
    local pd  = a*(1-ecc)
    local ad  = a*(1+ecc)
    local per = pd*dir + self.body.center
    local apo = ecc <= 1 and -ad*dir + self.body.center or nil
    local trm = math.sqrt(a*mu*(1-ecc*ecc))
    local Period = apo and 2*math.pi*math.sqrt(a^3/mu)
    local trueAnomaly = math.acos((e:dot(r))/(ecc*d))
    if r:dot(v) < 0 then
        trueAnomaly = -(trueAnomaly - 2*math.pi)
    end
    local EccentricAnomaly = math.acos((math.cos(trueAnomaly) + ecc)/(1 + ecc * math.cos(trueAnomaly)))
    local timeTau = EccentricAnomaly
    if timeTau < 0 then
        timeTau = timeTau + 2*math.pi
    end
    local MeanAnomaly = timeTau - ecc * math.sin(timeTau)
    local TimeSincePeriapsis = 0
    local TimeToPeriapsis = 0
    local TimeToApoapsis = 0
    if Period ~= nil then
		TimeSincePeriapsis = MeanAnomaly/(2*math.pi/Period)
		TimeToPeriapsis = Period - TimeSincePeriapsis
		TimeToApoapsis = TimeToPeriapsis + Period/2
		if trueAnomaly - math.pi > 0 then -- TBH I think something's wrong in my formulas because I needed this.
			TimeToPeriapsis = TimeSincePeriapsis
			TimeToApoapsis = TimeToPeriapsis + Period/2
		end
		if TimeToApoapsis > Period then
        TimeToApoapsis = TimeToApoapsis - Period
        end
    end

    return { periapsis       = { position           = per,
                                 speed              = trm/pd,
                                 circularOrbitSpeed = math.sqrt(mu/pd),
                                 altitude           = pd - self.body.radius},
             apoapsis        = apo and
                               { position           = apo,
                                 speed              = trm/ad,
                                 circularOrbitSpeed = math.sqrt(mu/ad),
                                 altitude           = ad - self.body.radius},
             currentVelocity = v,
             currentPosition = pos,
             eccentricity    = ecc,
             period          = apo and 2*math.pi*math.sqrt(a^3/mu),
			 eccentricAnomaly = EccentricAnomaly,
             meanAnomaly = MeanAnomaly,
             timeToPeriapsis = TimeToPeriapsis,
             timeToApoapsis = TimeToApoapsis
           }
end

local function new(bodyParameters)
    local params = PlanetRef.BodyParameters(bodyParameters.planetarySystemId,
                                            bodyParameters.bodyId,
                                            bodyParameters.radius,
                                            bodyParameters.center,
                                            bodyParameters.GM)
    return setmetatable({body = params}, Kepler)
end

return setmetatable(Kepler, { __call = function(_,...) return new(...) end })
