# Overview 
## HUD - Helmet HUD - Navigator Interface -WayPoint Sync - Fuel Module

## Command/Hover Seat and Cockpit supported

### For support and keep updated please be my guest [Discord](https://discord.gg/Rve2jjZbvz)

### If you like my work and you think it deserves something make a [DONATION](https://paypal.me/aviator1280hud?locale.x=en_GB). Very appreciate. Thank you.

### For some video on how the system works visit [YouTube Channel](https://www.youtube.com/channel/UCyQQYHtvR988dq_A4oTLDWA/featured)

I'm an airline pilot and when for the first time I jumped in the DU cockpit everything I could think was "this thing is not made to fly".

With the help of the LUA community I got an introduction to script in LUA so I decided to apply what I was learning to have a better flying experience with
all the information a pilot would like to see.

While someone prefers to have tons of automations I still prefer to keep the pilot the main actor and not just a controller of what the automation is doing so
in my cockpit I used small automations and I give the pilots all the instruments to make good and precise flights from the atmosphere to the space.

There are few variants to make it compatible with cockpit and seats.
It is suitable for small ships or multi crew ships, can be integrated with a Navigator interface to interact with pilots and send them navigation data or a
pilot can also interact with it while piloting using the touch screen.

Creating it I used the MFD (Multi Functional Display) concept assigning to the different phases of the flight a different page. Easy to apply to your ship
and easy to use but a powerful instrument for your flights and yes it does make the difference.

### [You Tube Video](https://youtu.be/XMOVcDVfVQI)

# INDEX
| |
|------|
| [KEYS](#keys)|
| [Requirements](#requirements)|
| [HUD Installation](#hud-installation)|
| [HELMET HUD Installation](#helmet-hud-installation)|
| [NAVIGATOR INTERFACE Installation](#navigator-interface-installation)|
| [WAYPOINT SYNC Installation](#waypoint-sync-installation)|
| [FUEL MODULE Installation](#fuel-module-installation)|
| [How To Use - Helmet HUD](#how-to-use-the-helmet-hud)|
| [How To Use - Navigator Interface](#how-to-use-the-navigator-interface)|
| [How To Use - WayPoint Sync](#how-to-use-the-waypoint-sync)|
| [How To Use - Fuel Module](#how-to-use-the-fuel-module)|
| [Warnings](#Warnings)|
| [Contacts](#Contacts)|
| [Credits](#Credits)|

## KEYS
### Functions
| [LOAD](#load-alt1) | [AI](#ai-alt2) | [SPC](#spc-alt3) | [ORB](#orb-alt4) | [DMG](#dmg-alt5) | [Helmet HUD](#how-to-use-the-helmet-hud) |
| :---:       | :---:              | :---:                     | :---:             | :---:                | :---:            |
| **ALT+1**   | **ALT+2**          | **ALT+3**                 | **ALT+4**         | **ALT+5**            | **ALT + Mode n** |
| DOW         | Artificial Horizon | FROM - TO                 | Orbital Data      | Ship Top View        | HUD On / Off     |
| Loading     | Velocity Vector    | Time Left                 | Orbit Scheme      | Ship Side View       | **SHIFT + L**    |
| ZFW         | WP direction       | Ship Position             | Space Orientation | Dmaged Elements List | Switch Colors    |
| FUEL        | WP Distance        | Space Orientation         | ... and more      |                      |                  |
| GW          | Acc                | Braking Distance and more |                   |                      |                  |
|             | Helmet HUD         |  Helmet HUD               | Helmet HUD        |                      |                  |

> NOTE: Using the **Navigator Interface** will enhance the **HUD** functionality. I strongly suggest installing it. The **Helmet HUD** is an add on to install on an additional *Programming Board*.

| AGG                         | Remote Controller | PVP Station                     |
| :---:                       | :---:             | :---:                           |
| **ALT+G**                   | **ALT+8**         | **ALT+8**                       |
| AGG STBY/OFF                | Player            | If PVP Station Module Installed |
| **ALT+6**                   |Freeze/Unfreeze    |                                 |
| AGG ON                      |                   |                                 |
| **ALT+ Space/C**            |                   |                                 |
| Set AGG Target Altitude     |                   |                                 |
| Or from Navigator Interface |                   |                                 |

### Autopilot / Autobrake / Parking Brake / Gyro or VTOL ON/OFF
|          | [Autopilot](#autopilot-alt6) | [Mode 1](#mode-1-alt6-first-press)| [Mode 2](#mode-2-alt6-second-press--3-seconds-delay)| [Mode 3](#mode-3-alt6-third-press--3-seconds-delay)| [Brake System](#brake-system-alt7) | Auto[Brake System](#brake-system-alt7)| Gyro or [VTOL](#vtol-shiftmmb) ON/OFF |
| :---     | :---:     | :---:           | :---:             | :---:       | :---:                 |:---:                  | :---:               |
|          | **ALT+6** | **ALT+6**       | **ALT+6**         | **ALT+6**   | **ALT+7**             |**ALT+SHIFT+7**        | **Shift + MMB**     |
| **LOAD** |           |                 |                   |             | Parking Brake         | Destination Autobrake | Gyro or VTOL ON/OFF |
| **AI**   | Alt. Hold | Fly Route or WP |                   |             | Parking Brake         | Destination Autobrake | Gyro or VTOL ON/OFF |
| **SPC**  |           | ProGrade        | ProGrade          | Destination | Parking Brake         | Destination Autobrake | Gyro or VTOL ON/OFF |
|          |           |                 | Orbiting ARM      |             |                       |                       |                     |
| **ORB**  |           |                 | ProGrade          | Destination | Parking Brake         | Destination Autobrake | Gyro or VTOL ON/OFF |
|          |           |                 | Maintaining Orbit |             |                       |                       |                     |
| **DMG**  |           |                 | Orbiting ARM      |             | Parking Brake         | Destination Autobrake | Gyro or VTOL ON/OFF |

> NOTE 1: **(ALT+6)** cycles between the **3 Modes** and also disengages them.

> NOTE 2: **Gyro or VTOL ON/OFF** To have it working on 3rd Person modify the DU Keys of Camera Reset to don't match with SHIFT+MMB. Using a Gyro disable the VTOL function.

### DU Widgets
|**ALT+8** (If not PVP Station Installed) | **ALT+9**  | **SPC** Mode     |
| ---                                     | ---        | ---              |
| Hide/Show                               | Hide/Show  | Auto Warp Widget |
|Radar Widget                             | DU Widgets |                  |

> NOTE: When you seat the DU Widgets are hided by default. You can change this behaviour in *Lua Paramenters* flagging (*Widgets_ON_OFF*). The **Warp** Widget will come out automatically when a *Warp destination* has been set, the *Jump* is possible and you are in *SPC Mode*. Any *Warp Status* Message is displayed in the **SPC** Mode.

[Return to INDEX](#INDEX)

#### LOAD **(ALT+1)**
![LOAD_page](/gallery/load_explained.png)

***(Load)*** Shows you the *DOW* (Dry Operating weight), *Load* (Cargo loaded), *ZFW* (Zero Fuel Weight), *Fuel* (Fuel Weight), *GW* (Gross Weight), *MTOW* (Maximum Take Off Weight) and the percentage of the *GW* respect to the *MTOW*.
The left screen where messages appear, like in the picture above *"Parking brake ON"* it is called **ECAM** (*Electronic centralised aircraft monitor*). It is present in **ALL** the fligth modes.
On the **ECAM** you will have useful **information**, **cautions** and **warnings**. It is always a good idea give it a look. For example it will show you if any of your *LINKED* fuel tank is going to have less then 20% of fuel and when it will be empty. When you seat it will also inform you on some system that eventually has not been *LINKED* for example it will tell you the *"R.A. not Installed"* (Radioaltimeter) which means you didn't *LINK* any **Vertical Booster** or **Hover Engine** or **Telemeter** that will make the Radioaltimeter work.
> NOTE: Editing the Command/Hover Seat or Cockpit **LUA Parameters** you can set up the desired *MTOW* (Maximum Take Off Weight). You can also set it up using the **Settings** in the **Navigator Interface** if installed. The **LUA Parameters** will reset if the script is reloaded while the setting in the **Navigator Interface** are instead stored in the *Databank*.

[Return to Functions](#functions) | [Return to INDEX](#INDEX)

#### AI **(ALT+2)**
![AI_page](/gallery/ai_explained.png)

***(Attitude Indicator)*** The most useful instrument while flying in the atmosphere. Not only gives you the attitude of the ship but I integrated it with the *Flight Path Vector* (in an Airbus airplane called "Bird"). It shows you the direction where your ship is really flying to.
Integrated in the *AI* you will find the *RA* (Radioaltimeter) that will come out when at 60 mt (Using Vertical Booster) from the ground/water.
You can also find the selected *WayPoint* distance and its direction (Cyan lozenge), the direction is precise when wings are level, during turns higher is the bank angle less precise is the direction.

[Return to Functions](#functions) | [Return to INDEX](#INDEX)

#### SPC **(ALT+3)**
![SPC_page](/gallery/spc_explained.png)

***(Space)*** This page is useful when flying in space. I made an instrument that shows you where your *Velocity Vector* is pointing respect to your nose and where the destination is to align your velocity properly. Plus there are some indicators that will show you are 90 or 180 degrees respect to the *Velocity Vector*, this with the scope to make the most important space maneuvers.
You can also find the *Braking Distance* to reach speed 0 plus a graphical representation of your position respect the departure point and destination Planet/Moon with distances and the time you will need to travel to arrive at the current speed.
> NOTE: If the **Navigator Interface** is not installed or the *Departure*/*Arrival* points are not selected the system will automatically choose for you. The *Departure* point will be your Present Position *(PPOS)* or if you are in an orbit the *(PPOS)* at the moment you will leave the orbit. The *Arrival* point will be the closest planet/moon. As a consequence when flying between planets/moons you will always see there the closest one.

[Return to Functions](#functions) | [Return to INDEX](#INDEX)

#### ORB **(ALT+4)**
![ORB_page](/gallery/orb_explained.png)

***(Orbit)*** Page used for Orbital operations. Here you have all the information to pilot your ship precisely to achieve an orbit. It includes the graphic representation of the ellipse with your actual position in relation to *AP* and *PE*. It shows in scale the planet/moon depending on your distance, it shows the *Target PE Altitude* preselected at 20.000 mt and can be changed editing the **LUA Parameters** or from the **Navigator Interface**. Also here is the instrument to orientate your ship in space and the *Braking Distance*. This time the *Braking Distance* is the distance to achieve the *Circular Orbit Speed*.

[Return to Functions](#functions) | [Return to INDEX](#INDEX)

#### DMG **(ALT+5)**
![DMG_page](/gallery/dmg_explained.png)

***(Damages Report)*** When on any other HUD pages if any damage to the ship occurres the text **DMG** will become red to warn you that something happened. If you switch to the **DMG** page you can see the Top View and the Side View of your ship and a list of damaged *Elements*. When installing the script for the first time (or reloading it) you may need to center the layout. To do this I included in the **Lua Parameters** the *Size* in case is too big or too small (negative numbers are acceptable), and the *X*, *Y*, for the pivot where the rotation occurs and the *X*, *Y* to translate it. Note that since the *SVG* (Scalable Vector Graphics) is already rotated by -90 deg if you want to translate it for example in a lower position you need to change the *X* value (negative values are acceptable) and not *Y*. 
> NOTE: This Mode can be disabled from **LUA Parameters** in case the ship has about 500 *Elements* and the *CPU Overload* occurs.

[Return to Functions](#functions) | [Return to INDEX](#INDEX)

### Automations

#### Autopilot **(ALT+6)**

* **Alt. Hold** (Altitude Hold) (first press)
Provided you are in **AI** *MFD Page* oce pressed the ship will:
1. Inform you on the *ECAM* that the system is on;
2. Inform you on the *ECAM* which is the altitude that will be maintained (it will be the altitude recorded when the system has been activated);
3. Protect you from *Bank Angle* higher then **45** deg;
4. Letting you make turns just banking the ship using the standard **Q** and **E**. At the moment for *bank angle* higer than **10** deg.
> NOTE: the system it is not connected to the thrust, it will correct the *pitch* to maintain the altitude but eventually will *stall* if the speed is too low.

* **Autopilot ON** (Fly to WP or follow Route) (second press)
1. Inform you on the *ECAM* that the system is on;
2. Max *Bank Angle* set to **30** deg.
> NOTE: suggested the use of Cruise Mode whileAutopilot ON. This will let the system keep as much as possible the flight vector within a limit.

**[Video 1](https://youtu.be/-_vdygYxul0)** | **[Video 2](https://youtu.be/DcNms8qMoBE)**

#### Mode 1 **(ALT+6)** (first press)
![Mode 1](/gallery/mode1_explained.png)

* **ProGrade**
Provided you are in the **SPC** or **ORB** *MFD page* this will turn your ship in a *ProGrade* direction, useful during a trip to accelerate or keep your ship facing the orbit direction and to adjust it by yourself accelerating or braking.
When **Mode 1** is active you don't have any more authority on direction.

[Return to Autopilot / Autobrake](#autopilot--autobrake) | [Return to INDEX](#INDEX)

#### Mode 2 **(ALT+6)** (second press + 3 seconds delay)
![Trajectory](/gallery/trajectory_adjust_explained.png)

In the picture we are approaching a moon. Few minutes before reaching it (in this case 4 minutes 22 second) we need to adjust our trajectory. If we are pointing to the planet/moon we need to turn 90 degrees in the direction we want to "push" our trajectory and give thrust.
Looking at the instrument on the left side when turning the ship you will see *Squares*, *lozenges* and a full *Dot*. The *Squares* and the *lozenges* indicate a turn of 90 degrees while the full *Dot* indicate the opposite direction of the velocity vector, practically a turn of 180 degrees.
The *Yaw* and the *Pitch* can help you to see if we are pointing to the planet or not, if the numbers are equal it means our *Velocity Vector* (White) is centered on our destination (Cyan). At this moment we don't need to be very precise, we just don't want to crash into the planet/moon or go too far. Keep the *Yaw* and the *Pitch* slightly different. Consider farest you are smaller the different should be.

**[Related Video](https://youtu.be/mVDru9Gs_ZI)**

![Mode 2](/gallery/mode2_explained.png)

At this point it is extremely important to refine our trajectory. Look on the picture, this time we are having the *ORB* active on the *MFD page*. On the left we have all the *Orbital Data* we need. We also need to be sure that the affecting gravity is the one from the planet/moon we are approaching, in some cases where planets/moons are close to each other it may not be the closer one affecting us. To verify we can simply go in the *AI* and check the *Attitude Indicator* if the gravity comes from the planet in front of us we should see our ship is pointing down.
Said so take a look at the *Pe Alt* on the left panel. That is your aiming point. That is the lowest predicted altitude you are going to have when passing by the planet, in this case 21491 mt. Also note that we still don't have an orbit and our *ECC* in fact is > 1, we don't have an *Ap Alt* neither a *T* (Period). If you are not happy with the *Pe Alt* you can still turn your ship 90 degrees and increase/decrease it (In this case if I want to increase the *Pe Alt* I should turn 90 degrees to the left). If instead you are happy with it let's go on and let's *ARM* the **Mode 2**. Take a look to the left panel, here there are now 2 important data. The *Circular Orbit Speed* and the *Distance To PE*. We will need these 2 values shortly.

* **ProGrade**
* **Orbiting ARM**
![Mode 2 entering orb](/gallery/mode2_entering_orbit_explained.png)

Provided the same conditions for **Mode 1** it turns the ship *ProGrade* and *ARM* the function to maintain a stable and circular orbit.
We were approaching the Moon and we activated the **Mode 2**. This selection will be also reflected on the instruments.
All we need to do when approaching the *PE* *(Distance To Pe)* is braking. When do we brake? when the *Braking Distance* (On the lower left instrument) is similar to our distance left to the *PE*. While braking monitor the *Ecc* (it will reduce until it will be below 1 which means you have an orbit), the *Pe Alt* (for planets with strong gravity like Alioth while braking it may reduce up to several thousands meters so be wise to choose the initial altitude, you can still correct it while braking pointing 90 degrees out and give thrust), the *Distance To Pe* in relation to the *Braking Distance* and finally your speed in mt/s that should go down close to the *Circular Orbit Speed*.
If the **Mode 2** is active and you read **Orbiting ARM** as soon as an orbit has been achieved the automation will engage and will take control. Keep in mind that it will want to achieve the *Target PE Altitude* you selected.

* **Maintaining Orbit**
![Mode 2 maintaining orb](/gallery/mode2_maintaining_orbit_explained.png)

It will engage if you are in the **ORB** *MFD page* and *PE Altitude* > 6000 mt and if an orbit is achieved. It will maintain the orbit at the *Target PE Altitude* and can be changed anytime using the **Navigator interface** or change the preselection using **LUA Parameters**.
For example you are climbing from a planet with a good trajectory, you can *ARM* it and when the *PE Altitude* will be above 6000 mt the **Mode** it will automatically engage. When **Mode 2** is engaged you don't have any more authority on direction, thrust and brakes.
Its logic, to make it simple, is that 2 seconds before to reach the *PE* or the *AP* if the opposite (*AP* or *PE*) is too high it will brake to reduce its altitude instead passing them if the opposite is too low it will give thrust to raise them. Messages on the screen will inform you what the automation is doing.
In this picture you can see the ship maintaining the orbit we achieved before. Since we entered on an orbit at about 21000 mt the automation passing the *PE* gave thrust and increased the *AP* close to the preselecter *Target PE Altitude* of 35000 mt. If continuing the orbit when the ship will pass the *AP*, in an estimated time of almost 16 minutes, it will give thrust to bring the *PE* as well to an altitude of about 35000 mt. Note when the *PE* and the *AP* altitude are similar and you are in a circular orbit the *PE* and *AP* can change any time since they simply are the lowest and highest altitude of your orbit but they will be always opposite each other.
The *Target PE Altitude* is represented on the screen by the white circle, when your orbit will be above that circle it will become Cyan. The yellow line starting from the center of the planet/moon is your position in reference to the *PE* and *AP*.
> NOTE: If your ship has really strong brakes using **Mode 2** it may not be advisable. You can try but monitor it and in case take over. In the future I may find the way to reduce the effect of the brakes.

[Return to Autopilot / Autobrake](#autopilot--autobrake) | [Return to INDEX](#INDEX)

#### Mode 3 **(ALT+6)** (third press + 3 seconds delay)
![Mode 3](/gallery/mode3_leaving_orbit_autobrake_armed_explained.png)

Same conditions of preceding **Modes**. This will turn the ship in the direction of the destination planet/moon.
Time to leave our orbit. Select with the **Navigator Interface** the new destination and activate the **Mode 3**. If you are not using the **Navigator Interface** point your ship manually or it will point to the planet you are orbiting.
What I did in this picture I waited the right moment to give full thrust, you will see your *Pe Alt* reducing if you do it too early and it is ok but stop the thrust if you see the *Pe Alt* going to touch the planet atmosphere, you don't want to burn ot be destroyed.
You can notice also I armed the *Autobrake*, they will engage only when close to the destination so again, if you can't select a destination don't arm them now or you will stop.
If everything is ok you will see your ship pointing in the direction of the destination and leaving the actual orbit. Just keep the thrust at full power.

[Return to Autopilot / Autobrake](#autopilot--autobrake) | [Return to INDEX](#INDEX)

#### Brake System **(ALT+7)**
It will ENG the **Parking Brake** in all Flight Modes.

#### Auto Brake System **(ALT+SHIFT+7)**
The **Autobrake** is set to stop the ship at about **2 Su** from the **center** of the destination planet/moon, it can be modified by editing the *LUA Parameters* or in the **Settings** of the **Navigator Interface**.
![Autobrake ARM](/gallery/autobrake_arm_spc_explained.png)
We left our orbit and on course to Alioth. On the left lower panel you can read *Autobrake ARM*, this means that a *Destination* has been set (if no *Destination* they will not ARM, sometime you will need to go in the **SPC** *MFD page* to activate the *Destination*).
On the upper right panel you can read *Autobrake in:*, this is the distance left before they will engage, it will show *Autobrake OFF* if they are not active. Next to it you can read the distance at which you want to stop your ship. Be aware that this is the distance from the **center** of the target planet/moon (ex. going to Alioth that has a radius of 0.63Su your ship will stop at 2.3 - 0.63 Su from the surface so be careful). On my trip the selected destination is my base on Alioth that's why the ship is not pointing to the center of the planet. In this case be even more careful if the destination you set is on the other side of the planet/moon.
My direction is managed by the system and the thrust is set to 100%, when it will be time to stop the system will automatically cut the thrust and brake. You can disconnect the *Autobrake* at any time pressing **(ALT+7)**.

![Autobrake ON](/gallery/autobrake_on_stop_explained.png)
My trip finished here, I hope you found useful these instructions and that make you enjoy even more flying with my HUD.
You can see the *Autobrake* system stopped my ship at 2.26 Su from the destination. 2.3 Su was selected, approaching a planet/moon stronger is the gravity and heavier you are it may require some small adjustment on the final stop distance.
The *autobrake* system is used also from the **Mode 2** in case something wrong happens during an orbit, to DISARM the **Autobrake** in the event that the **Mode 2** engaged it press **(ALT+7)**.

> NOTE: I'm still refining some value and some logic, based on your ship mass, inertia, engines, brakes it may need some adjustment. Editing the *LUA parameter* you can find for example how fast you want the ship turns, be aware that for big turns it may overshoot and then go back and point in the correct direction. You can play with those values and have for example a slower turn and it will not overshoot but it takes longer. This is up to you and based on how you built your ship. I tested the Orbit maintaining function a lot and for sure if you are in a circular orbit it will keep you there, it is also capable to adjust the orbit but still monitor it.

[Return to Autopilot / Autobrake](#autopilot--autobrake) | [Return to INDEX](#INDEX)

#### VTOL **(Shift+MMB)**
To make the **VTOL** system work you can't have a *Gyroscope* installed in your ship. You also need to *TAG* the engines you want to use for the Vertical take Off and Landing with the *TAG* **vtol_eng**.
When pressing ( *Shift+MMB* ) the engines will not go to 0 as it happens when pressing only the *MMB*.
Altitude that can be reached depends on the amount of thrust and weight of your ship.
Use ( *Space Bar* ) to climb and *C* to descent.

**[Related Video](https://youtu.be/Q2eZ3fJU26c)**

[Return to INDEX](#INDEX)

# Requirements

## Ship Requirements
* To add the **Navigator Interface** **1 slot** for the *databank*.
* To add the **Helmet HUD** you can use the same *databank* used for the **Navigator Interface**
* The rest of the **slots** are **optionals** and  up to you.
> NOTE: The **HUD**, the **Navigator Interface** and the **Helmet HUD** run separately. Listed below are the **slots** needed in your **Command/Hover seat** or  **Cockpit**, the **Navigator Interface** and the **Helmet HUD** run on different **Programming Boards** (1 each) and the only *Element* they share is a **Databank**.
### HUD
#### Required Slots and Elements
1. **Core** *(Linked Automatically)*.
#### Required Slot and Element if the Navigator Interface is installed
2. **Databank** 1 *(Linked Automatically refer to the Note)*;
> NOTE: if your ship has more than 1 databank installed the autoconfig may link the wrong databank. Be sure the databank linked is the same databank you are using for the **Navigator Interface**. Before installing it if you were using the databank for another script please remove the **Dynamic Properties**.
#### Optional Slots and Elements (Atmo Fuel Tank, Space Fuel Tanks, Radioaltimeter, Cargo Containers, Rocket Fuel Tanks)
3. **Atmo Fuel Tank** *(Linked Automatically refer to the Note)*;
> NOTE: 2 version of autoconfiguration file, **Aviator1280.conf** and **Aviator1280_(Fuel Module).conf**. If you don't have enough **slots** you can use the second file and *LINK* just the **Fuel Tanks** you need to monitor or link the fuel tank to a dedicater **Programming Board**. The first file instead will connect **ALL** the **Atmo and Space Fuel Tanks** present on the ship.
4. **Space Fuel Tanks** *(Linked Automatically refer to the Note)*;
> NOTE: automatically linked unless you are using the file **Aviator1280_(Fuel Module).conf**.
5. **Vertical Booster** 1 or **Hover Engine** 1 or **Telemeter** 1 *(Linked Manually refer to the Note)*;
> NOTE: **Vertical Booster** and **Hover Engine**, while they have a 60 meters range instead of 100 meters they returns water as an obstacle and the telemeter doesn't.
6. **Cargo Containers** or **Container HUB** *(Linked Manually refer to the Note)*;
> NOTE: according your free **slots** available you can chose to connect them all or not or connect 1 single **Container HUB** (recommended). The weight calculations will be still correct but in case you will not connect them or part of them their weight will be included in the *DOW* and not in *LOAD*.
7. **Rocket Fuel Tanks** if you wish to see the *Level* the *Time Left* and if the *Rockets* are engaged *LINK* at least 1 **Rocket Fuel Tank**

## Helmet HUD
#### Required Elements
1. **Programming Board**
2. **Databank** (This databank need to be connected to the Command/Hover seat or Cockpit can be the same used for the **Navigator Interface**)

## Navigator Interface
#### Required Elements
1. **Programming Board**
2. **Screen** (Tested on XS, S, M, Transparent and not Transparent) 
3. **Databank** (This databank need to be connected to the Command/Hover seat or Cockpit)
4. **Emitter** *(Not Required if you don't need to sync your WPs with the WP Base Sync)*
5. **Receiver** *(Not Required if you don't need to sync your WPs with the WP Base Sync)
> NOTE: The **Screen** it is not mandatory. You can still use most of the functionalities typing commands in the *LUA Console*. The commands will be presented in the cconsole no need to recall them.

## WayPoint Sync
#### Required Emelents
1. **Programming Board**
2. **Screen**
3. **Databank**
4. **Emitter** (If you need to use the WP Sync)
5. **Receiver** (If you need to use the WP Sync)
6. **AGG** (If you havd an AGG and you want control it also when not at the pilot seat)

## Fuel Module
#### Required Emelents
1. **Programming board**
2. **Databank** (This databank need to be connected to the Command/Hover seat or Cockpit)

[Return to INDEX](#INDEX)

# HUD Installation
* When you will seat on the lower left screen if some of the **optional** Elements are not *LINKED* it will be written or if a wrong **Databank** is *LINKED* it will tell you to check it. While the **optional** Elements are not required if you connect a wrong **Databank** you will have a *Script Error*.
1. Choose the file (.conf) that is suitable for your ship and download it;
2. Paste it in **Dual Universe\Game\data\lua\autoconf\custom**;
3. Connect **manually** the **optional** *Elements* if you want them (1 **Vertical Booster** or 1 **Hover Engine** or 1 **Telemeter** to have the *Radio Altimeter*, **Containers** or 1 **Container HUB** to get their mass in the *LOAD*). If you choose the file **(Fuel Tank Manual)** *LINK* at least 1 **Atmo Fuel Tank** and 1 **Space Fuel Tank** 
4. In the game Right click on the **Command/Hover Seat or Cockpit -> Advanced -> Update Custom Autoconf List**. Do it again and this time open **Run Custom Autoconfigure** choose the configuration you want to install.

**[Related Video](https://youtu.be/xHha08kVJH0)**

[Return to INDEX](#INDEX)

# Helmet HUD Installation
1. Place the **Programming Board**;
2. Paste the content of the file **Helmet HUD.txt** on the **Programming Board**;
3. *Link* the **Databank** to it and be sure it is also *Linked* to the **Cockpit/Seat**. (If you are using the **Navigator Interface** the **Databank** is the same).

**[Related Video](https://youtu.be/gv-QjB9MB34)**

[Return to INDEX](#INDEX)

# Navigator Interface Installation
* Before to place the *Elements* be sure to remove from them the *Dynamic Properties*.
1. Download **Navigator_Interface.txt** and save it wherever you prefer **or** copy the **RAW** format from GitHub;
2. In the game place the **Programming Board**, the **Databank**, the **Screen** (if required), the **Emitter** (if required), the **Receiver** (if required) and don't *LINK* them yet;
3. Copy the content of the **.txt** file **or** if you already copied the **RAW** format make a Right click on the **Programming Board**. Go to **Advanced -> Paste Lua Configuration From Clipboard**;
4. Enter in the **Lua Editor** of the **Programming Board** *( Look at it and press CTRL+L)* and check that **5** of the slots are grey and have the name of **core**, **screen**, **databank**, **emitter** and **receiver**. Check their order;
5. Now *LINK* the *Elements* to the **Programming Board** according the sequence you saw in the **Lua Editor**;
>Note: If you are not using a **Screen** you still need to *Link* any element to fill the *screen Slot*, after all the *Elements* are *Linked* you can remove the *Element* linked to the *screen Slot*. 
6. Activate the **Programming Board**. The first time you turn it on the top left button for some reason may not appear in that case switch it off then on.

> NOTE: Going in pages like *From*, *Destination* you may find the first box already filled, that is because that data is stored but the coordinates box will show *nil* in that case to write you may use *CLR* or if you press *ENT* you simply confirm that string and the coordinates will appear. If for any reason you can't do anything, maybe you are having the error mentioned before so just turn it off then on.

**[Related Video](https://youtu.be/25d4O7AlEOY)**

[Return to INDEX](#INDEX)

# WayPoint Sync Installation
* At the moment there is a bug that prevent Emitters/Receivers to operate at a range more than 20/30 mt.
1. Download **WP_Sync_Base.txt** and save it wherever you prefer **or** copy the **RAW** format from GitHub;
2. In the game place the **Programming Board**, the **Databank**, the **Screen**, the **Emitter**, the **Receiver** and don't *LINK* them yet;
3. Copy the content of the **.txt** file **or** if you already copied the **RAW** format make a Right click on the **Programming Board**. Go to **Advanced -> Paste Lua Configuration From Clipboard**;
4. Enter in the **Lua Editor** of the **Programming Board** *( Look at it and press CTRL+L)* and check that **4** of the slots are grey and have the name of **databank**, **screen**, **emitter** and **receiver**. Check their order;
5. Now *LINK* the *Elements* to the **Programming Board** according the sequence you saw in the **Lua Editor**.
> NOTE: when connecting the **Emitter** and the **Receiver** do it starting from the **Programming Board**, in this way you will have a **green** *Link* and it will be connected to a *slot*. Doing the opposite will create a **blue** *Link* which will not connect to any *slot*, useful only to send impulse to an interactive *Element* such as lights, doors, screens and so on.

**[Related Video](https://youtu.be/U-w2eNu7uhw)**

[Return to INDEX](#INDEX)

# Fuel Module Installation
1. Place the **Programming Board**;
2. *Link* to it the *Ship Core* and the *Databank*;
3. *Link* the **Fuel Tanks** you want to monitor;
4. apply the code in the same way you probably already did for the other mmodules;
> NOTE: The system will swap, when activated and the **HUD** is in **LOAD Mode** the *Fuel Tanks* that are showed in the HUD (if any) and thise *Linked* to the **Programming board** IF the *Fuel  Tanks* are the same type otherwhise what you will see will be a mix. You can also have more **Programming Board** (ex 1 for all the Atmo Fuel Tank, 1 for all the Space Fuel Tank). The possibilities are many. You can also use this system to create a group of Fuel tank that you want to monitor time to time simply turning the **Programming Board** on.

**[Related Video](https://youtu.be/HsOpztNAfKs)**

[Return to INDEX](#INDEX)

## How To Use The Helmet HUD
> NOTE: You can chose the color you prefer editing the **LUA Parameters** and when switching between the others (**SHIFT + L**) the color you edited will cycle with the others. When you type the **NAME** of the color keep the quotation marks (es. **"aqua"**).
![Heelmet_HUD](/gallery/helmet_hud.png)
>TIP: The pitcure above shows a good use of the **Helmet HUD**. While flying you can simply lead the *Bird* on the spot you waant to arrive and your ship will fly there, it also corrects your *drift*. (Ex. you point it on the runway you want to land)
1. Recall to turn on the **Programming Board** dedicated to the **Helmet HUD**. If you are using a **Seat** you can just place it wherever you prefer but if you are using a **Cockpit** recall to turn it on before to enter otherwise you will be unable to turn it on in flight;
> NOTE: In this case *Switches*, *detection Zones* and so on will turn on the **Programming Board** but the script will not run. You need to turn the **Programming Board** pressing **F**.
2. When you switch to a *Flight Mode* for example **AI** Mode the **Helmet HUD** will be off. To show/hide it press again the key for the *Flight Mode* you are using;
3. To switch between colors press **SHIFT + L** which is the same key used for the ship *Headlights*.

[Return to INDEX](#INDEX)

## How To Use The Navigator Interface
> NOTE 1: You can set up your favourite colors in the **Settings** and inserting them in **RGB**. A good tool to find your favourite name colors can be found [HERE](https://www.w3schools.com/colors/colors_picker.asp).

> NOTE 2: If a **Screen** is *Linked* to don't use it you can deflag the option in the **LUA Parameters**. 

1. Activate the **Programming Board**, the screen will turn ON and will show you a first page with buttons and *Stored WayPoints*. Usually the top left button when turning ON the first time it doesn't render, restart the **Programming Board** to solve.

2. **WP/ATLAS** are the pages where you can see the name you gave to the *WayPoints* you stored or the **ATLAS** database. You can scroll between pages with the up down arrow next to the keypad on the screen. Here you can also select with the small arrow the *WayPoints* you want to clear and press **CLR WP**, instead if after selecting the *wayPoints*/*Planets*/*Moons* you push on **From** or **Destination** you will "Copy" the selected location in the new page to be *execute* pressing **ENT**.

3. **Su Time Calculator** is a simple tool where to insert an Su distance a speed and you will get the time to travel it, the Warp Cells required in case you warp at the actual weight and at the MTOW (supposing you want to travel to load your ship and you want to go back for planning purpose). Note the MTOW is the one you set on the **Settings**.
In the **Distance** box if you insert a destination it will automatically set the distance from your present position *(PPOS)* to the destination. To remove that distance you need to *CLR* the *Destination*.
On the *Speed* box you can set the speed you prefer from 1 to 30000 Km/h or if you simply press *ENT* it will automatically set your actual speed.
If the Warp Cells needed shows 0 it's because you have not used the ship since some time and it is like "sleeping", just sit on the Command/Hover seat or Cockpit and it will be updated.

4. **From** here you can set your departure point, the one you want to see on the HUD. Planets and moons are already in the database, you just type their name with the keyboard and press *ENT*. If the planet/moon is in the database it will show their VEC3 coordinates.
If you don't insert anything on the box and simply press *ENT* it will set for you the *PPOS* and your actual coordinates. You may notice that in this case the lateral white arrow will go next to the box where you can write the name of the **WayPoint**. This is for the purpose of storing **WayPoints**. You simply write the name you want to give to it and click on **ADD WP** (top left of the screen). From this moment you will have the *WayPoint* stored and visible in the list. If you want to store a *WayPoint* from *Map Coordinates* you can do it in **Settings**.
If you write ***all*** and use **CLR WP**, **ALL** the stored *WayPoints* will be deleted, use it carefully.
When you have a *WayPoint* stored in the page *From* or *Destination* you can simply write the **wp** number you want to select (same as per clear them) and it will show you their name once you press *ENT*.

5. **Destination** here you will set your destination that will be shown also in the HUD. Can be a planet/moon from the database or a **stored wp**.

6. **Settings** is an important page, it has the basic settings of your ship.
* **Page 1** Here you can set:
1. *MTOW* in Tons instead to use the **Lua Paramenters** (the **Lua Parameters** can be set before to seat but can't be changed while flying instead everything you set on the screen is live). The *MTOW* will be the reference for the maximum number of *Warp Cells* needed to cover a distance and it will be also sent to the HUD for the pilot to check if the ship is within the take off limits.
2. *Autobrake* box is where you can set the distance you want your ship to stop from your destination if the system is armed. Note that this is the distance from the center of the planet/moon/wp (es. Alioth radius 0,63 Su, it means the ship will stop at about 1.4 Su from the planet surface).
3. *Dist. To WP* is the distance at which the system will activate the next WP in the Route. The distance has to be in *Km* and it is already corrected by the *Altitude*.
* **Page 2** Here you can manually store *WayPoints* giving them a name and inserting the coordinates given from the Map.
**[Video 1](https://youtu.be/Fd56X4Tc3us)** | **[Video 2](https://youtu.be/6RB8q8bMSC8)**
* **Page 3** Here you can syncronize *WayPoints* stored in your ship and in your base and assign a *Ship ID*. Pressing **Downlink** you will **send** all your *WayPoint* list to your base where they will be stored and displayed. If some *WayPoint* has the same name of an existing one the existing one will be overwritten. Pressing **Uplink** all the stored *WayPoints* in your base **Databank** will be sent to your ship. The ship *WayPoint* list will not be overwritten and additional *WayPoints* will be added even if they have the same name. If you want to prevent this behaviour for any reason just be sure you sent all your *WayPoints* to your base **Databank** then before to **Uplink** clear your ship list so you will not have duplicates.
**[Video 1](https://youtu.be/Eafc3xyuaCo)** | **[Video 2](https://youtu.be/-60T1CAxfd4)**
* **Page 4** Here you can set up your favourite colors for the screen.
* **Page 5** This is to Center accuratelly teh **DMG Reports** Ship layout in to the TOP and SIDE view.
* **Page 6** Very useful tool that allows you to keep clean the *Databank* improving performances. You can keep the data you want to keep. remove the Flag if you want to erase them.
**[Video](https://youtu.be/nmaxgpNMpnU)**
* **Page 7** A system that allows you to create Routes. Input text in this case only from your own keyboard. Select an empty slot and press Enter. type the Route name. Select agian the route if it shifted up due to alphabetic order and this time press **ENT**. Type the name of your WPs in the same way you did for the Route name. The name have to be exactly the same of the Stored WP to be recognised. To go back to the Route List press **CLR**.
To select and fly the Route simply press **Destination**, the route will be presented in another page with its WPs and your distance respect each of them. You can select any WP at any time. When overflying a WP at the distance you preselected on the *LUA Parameters* (standard 0.5 km) the system will  sequence the next WP. If there are no more WPs or you left a discontinuity between WPs the system will restart from the WP1. If you want to terminate at your last WP without to follow the flight add as your last WP "HOLD" or "hold", the system will stop to sequensce the WPs and if you were flying with the **Autopilot ON** it will start to fly a circular orbit.

7. **Pe Target Altitude** is the lowest altitude you want to orbit around a planet/moon. It will be represented with a white circle on the HUD around the planet/moon in the **ORB** *MFD page*. It will also be the reference altitude for the **Mode 2** of the autopilot to keep a circular orbit. Also this can be setted in the **Lua Parameter** but doing on the screen is live and no need to stand up or go out of the Cockpit. This parameter can also be changed while the autopilot is ON and it will adapt to the new altitude.


[Return to INDEX](#INDEX)

## How To Use The WayPoint Sync
* Most actions are done from the **Navigator Interface** (*Downlink*, *Uplink* on the **Settings** page).
1. Keep the **WayPoint Sync** on if you want to transmit/receive data.
2. The **Screen** will show you a table  with number of *WayPoints* received, the *WayPoint* list, a *Progress Bar* when syncing and the *WayPoints* stored.
3. Once the *WayPoints* are stored the next time you will turn on the **Programming Board** the list of them will be displayed in a different colour (Cyan) to distinguish them from a new series of incoming *WayPoints*
4. On the right side a simple series of *buttons*. To scroll the table up, down or to go back to the top. A *button* **Send** to send all the *WayPoints* stored to all the ship with the **Navigator Interface** turned ON. A *button* **CLR DB** to clear **ALL** the *WayPoints* stored. (It is my intention to add the possibility to clear only selected *WayPoints*)

[Return to INDEX](#INDEX)

## How To Use The Fuel Module
When at your pilot seat select **LOAD Mode** if you need to switch the **Programming board** ON or OFF. If you turn ON the **Programming Board** before to seat the data will be already presented. The only combination you can't do is to show the same *Fuel Tank Type* from 2 different sources at the same time. The system will pick up only those from the **Programming Board** or in case of multiple **Programming Boards** from the latest switched ON. 

[Return to INDEX](#INDEX)

# Warnings
> DISCLAIMER: I do not accept any responsibility for incorrect use of this HUD. Recall **you are still the pilot and if something goes wrong take over**.

* Enjoy flying more than use automations, if you use them choose the proper time and proper situation to activate them. Monitor their behaviour.

* ARMING the **Mode 1** in a wrong moment may result in the **Autobrake** activation because the system is not able to maintain a safe orbit, this may happen if you are climbing away from a planet and you don't want it to happen above all in that moment when you need your maximum power. I will probably change the logic a bit more and probably I will insert a timer of 3 seconds also for this **Mode** to prevent the undesired engagement, probably also exchanging the **Mode 1** with **Mode 2**.

* Be aware the indicated speed it is not an horizontal speed, if you are descending to a planet vertically you will have a speed, use the *Bird* to understand your *flight path* and correct it, align your ship with the *Bird* to avoid the *Stall* or don't keep an *Angle Of Attack* too high (Angle between *Pitch* and *Bird*) gain lift on the wings and pitch up when in atmosphere, try to reduce your re-entry *Vertical Speed* if too high and you are heavy you will probably smash on the ground. Avoid a vertical re-entry, that is not the way to fly unless you built your ship with that concept.

* I usually fly using Mouse and Keyboard, unfortunately the Joystick is still bugged. Anyway I didn't change any key configuration so you should be able to fly with your preferred system.

* I experienced some FPS drop in these situations:
1. In the cockpit if looking around I click by mistake on the instruments;
2. On a seat if pressing **TAB** to interact with the widget and by mistake clicking out of them.

[Return to INDEX](#INDEX)

# Contacts
[Discord](https://discord.gg/Rve2jjZbvz)

[Return to INDEX](#INDEX)

# Credits
Jayle Break (orbital data) - https://gitlab.com/JayleBreak/dualuniverse/-/tree/master/DUflightfiles/autoconf/custom

Catharius (Damages Report) - https://github.com/Catharius/DU-MINIMALIST-HUD

DU Lua Scripting Community - https://discord.gg/dualuniverse

[Return to INDEX](#INDEX)
