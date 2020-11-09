--[[ 
  DualUniverse kinematic equations
  Author: JayleBreak

  Usage (unit.start):
  Kinematics = require('autoconf.custom.kinematics')

  Methods:
   computeAccelerationTime - "relativistic" version of t = (vf - vi)/a
   computeDistanceAndTime - Return distance & time needed to reach final speed.
   computeTravelTime - "relativistic" version of t=(sqrt(2ad+v^2)-v)/a

  Description
  DualUniverse increases the effective mass of constructs as their absolute
  speed increases by using the "lorentz" factor (from relativity) as the scale
  factor.  This results in an upper bound on the absolute speed of constructs
  (excluding "warp" drive) that is set to 30 000 KPH (8 333 MPS). This module
  provides utilities for computing some physical quantities taking this
  scaling into account.
]]--

local Kinematic = {} -- just a namespace

local C       = 30000000/3600
local C2      = C*C
local ITERATIONS = 100 -- iterations over engine "warm-up" period

local function lorentz(v) return 1/math.sqrt(1 - v*v/C2) end

--
-- computeAccelerationTime - "relativistic" version of t = (vf - vi)/a
-- initial      [in]: initial (positive) speed in meters per second.
-- acceleration [in]: constant acceleration until 'finalSpeed' is reached.
-- final        [in]: the speed at the end of the time interval.
-- return: the time in seconds spent in traversing the distance
--
function Kinematic.computeAccelerationTime(initial, acceleration, final)
    -- The low speed limit of following is: t=(vf-vi)/a (from: vf=vi+at)
    local k1 = C*math.asin(initial/C)
    return (C * math.asin(final/C) - k1)/acceleration
end

--
-- computeDistanceAndTime - Return distance & time needed to reach final speed.
-- initial[in]:     Initial speed in meters per second.
-- final[in]:       Final speed in meters per second.
-- restMass[in]:    Mass of the construct at rest in Kg.
-- thrust[in]:      Engine's maximum thrust in Newtons.
-- t50[in]:         (default: 0) Time interval to reach 50% thrust in seconds.
-- brakeThrust[in]: (default: 0) Constant thrust term when braking.
-- return: Distance (in meters), time (in seconds) required for change.
--
function Kinematic.computeDistanceAndTime(initial,
                                          final,
                                          restMass,
                                          thrust,
                                          t50,
                                          brakeThrust)
    -- This function assumes that the applied thrust is colinear with the
    -- velocity. Furthermore, it does not take into account the influence
    -- of gravity, not just in terms of its impact on velocity, but also
    -- its impact on the orientation of thrust relative to velocity.
    -- These factors will introduce (usually) small errors which grow as
    -- the length of the trip increases.
    t50            = t50 or 0
    brakeThrust    = brakeThrust or 0 -- usually zero when accelerating

    local tau0     = lorentz(initial)
    local speedUp  = initial <= final
    local a0       = thrust * (speedUp and 1 or -1)/restMass
    local b0       = -brakeThrust/restMass
    local totA     = a0+b0

    if speedUp and totA <= 0 or not speedUp and totA >= 0 then
        return -1, -1 -- no solution
    end

    local distanceToMax, timeToMax = 0, 0

    -- If, the T50 time is set, then assume engine is at zero thrust and will
    -- reach full thrust in 2*T50 seconds. Thrust curve is given by:
    -- Thrust: F(z)=(a0*(1+sin(z))+2*b0)/2 where z=pi*(t/t50 - 1)/2
    -- Acceleration is given by F(z)/m(z) where m(z) = m/sqrt(1-v^2/c^2)
    -- or v(z)' = (a0*(1+sin(z))+2*b0)*sqrt(1-v(z)^2/c^2)/2

    if a0 ~= 0 and t50 > 0 then
        -- Closed form solution for velocity exists:
        -- v(t) = -c*tan(w)/sqrt(tan(w)^2+1) => w = -asin(v/c)
        -- w=(pi*t*(a0/2+b0)-a0*t50*sin(pi*t/2/t50)+*pi*c*k1)/pi/c
        -- @ t=0, v(0) = vi
        -- pi*c*k1/pi/c = -asin(vi/c)
        -- k1 = asin(vi/c)
        local k1  = math.asin(initial/C)

        local c1  = math.pi*(a0/2+b0)
        local c2  = a0*t50
        local c3  = C*math.pi

        local v = function(t)
            local w  = (c1*t - c2*math.sin(math.pi*t/2/t50) + c3*k1)/c3
            local tan = math.tan(w)
            return C*tan/math.sqrt(tan*tan+1)
        end

        local speedchk = speedUp and function(s) return s >= final end or
                                     function(s) return s <= final end
        timeToMax  = 2*t50

        if speedchk(v(timeToMax)) then
            local lasttime = 0

            while math.abs(timeToMax - lasttime) > 0.5 do
                local t = (timeToMax + lasttime)/2
                if speedchk(v(t)) then
                    timeToMax = t 
                else
                    lasttime = t
                end
            end
        end

        -- There is no closed form solution for distance in this case.
        -- Numerically integrate for time t=0 to t=2*T50 (or less)
        local lastv = initial
        local tinc  = timeToMax/ITERATIONS

        for step = 1, ITERATIONS do
            local speed = v(step*tinc)
            distanceToMax = distanceToMax + (speed+lastv)*tinc/2
            lastv = speed
        end

        if timeToMax < 2*t50 then
            return distanceToMax, timeToMax
        end
        initial     = lastv
    end
    -- At full thrust, acceleration only depends on the Lorentz factor:
    -- v(t)' = (F/m(v)) = a*sqrt(1-v(t)^2/c^2) where a = a0+b0
    -- -> v = c*sin((at+k1)/c)
    -- @ t=0, v=vi: k1 = c*asin(vi/c)
    -- -> t = (c*asin(v/c) - k1)/a
    -- x(t)' = c*sin((at+k1)/c)
    -- x = k2 - c^2 cos((at+k1)/c)/a
    -- @ t=0, x=0: k2 = c^2 * cos(k1/c)/a
    local k1       = C*math.asin(initial/C)
    local time     = (C * math.asin(final/C) - k1)/totA

    local k2       = C2 *math.cos(k1/C)/totA
    local distance = k2 - C2 * math.cos((totA*time + k1)/C)/totA

    return distance+distanceToMax, time+timeToMax
end

--
-- computeTravelTime - "relativistic" version of t=(sqrt(2ad+v^2)-v)/a
-- initialSpeed [in]: initial (positive) speed in meters per second
-- acceleration [in]: constant acceleration until 'distance' is traversed
-- distance [in]: the distance traveled in meters
-- return: the time in seconds spent in traversing the distance
--
function Kinematic.computeTravelTime(initial, acceleration, distance)
    -- The low speed limit of following is: t=(sqrt(2ad+v^2)-v)/a
    -- (from: d=vt+at^2/2)
    if distance == 0 then return 0 end

    if acceleration > 0 then
        local k1       = C*math.asin(initial/C)
        local k2       = C2*math.cos(k1/C)/acceleration
        return (C*math.acos(acceleration*(k2 - distance)/C2) - k1)/acceleration
    end
    assert(initial > 0, 'Acceleration and initial speed are both zero.')
    return distance/initial
end

function Kinematic.lorentz(v) return lorentz(v) end

return Kinematic
