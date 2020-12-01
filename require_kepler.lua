local vec3       = require('cpml.vec3')
                                local PlanetRef  = require('autoconf.custom.require_planetref')

                                local function isString(s) return type(s)   == 'string' end
                                local function isTable(t)  return type(t)   == 'table'  end

                                local function float_eq(a,b)
                                    if a == 0 then return math.abs(b) < 1e-09 end
                                    if b == 0 then return math.abs(a) < 1e-09 end
                                    return math.abs(a - b) < math.max(math.abs(a),math.abs(b))*epsilon
                                end

                                Kepler = {}
                                Kepler.__index = Kepler

                                function Kepler:escapeAndOrbitalSpeed(altitude)
                                    assert(self.body)
                                    local distance = altitude + self.body.radius

                                    if not float_eq(distance, 0) then
                                        local orbit = math.sqrt(self.body.GM/distance)
                                        return math.sqrt(2)*orbit, orbit
                                    end
                                    return nil, nil
                                end

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
                                        if trueAnomaly - math.pi > 0 then
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