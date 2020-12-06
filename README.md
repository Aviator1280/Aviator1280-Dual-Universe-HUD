# Overview (HUD + Navigator Interface)

## Command/Hover Seat and Cockpit supported

### For support and keep updated please be my guest [Discord](https://discord.gg/Rve2jjZbvz)

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

# INDEX
| |
|------|
| [Functions](#Functions)|
| [Automations](#automations)|
| [DU Widgets](#du-widgets)|
| [Ship Requirements](#ship-requirements)|
| [How To Install](#how-to-install)|
| [How To Use It](#how-to-use-it)|
| [Piloting TIPS and how to use the instruments](#Piloting-tips-and-how-to-use-the-instruments)|
| [Warnings](#Warnings)|
| [Contacts](#Contacts)|
| [Credits](#Credits)|

## Functions
| [LOAD](#load-alt1) | [AI](#ai-alt2) | [SPC](#spc-alt3)   | [ORB](#orb-alt4)  | [DMG](#dmg-alt5)     |
| :---:     | :---:              | :---:                     | :---:             | :---:                |
| **ALT+1** | **ALT+2**          | **ALT+3**                 | **ALT+4**         | **ALT+5**            |
| DOW       | Artificial Horizon | FROM - TO                 | Orbital Data      | Ship Top View        |
| Loading   | Velocity Vector    | Time Left                 | Orbit Scheme      | Ship Side View       |
| ZFW       | WP direction       | Ship Position             | Space Orientation | Dmaged Elements List |
| FUEL      | WP Distance        | Space Orientation         | ... and more      |                      |
| GW        | Acc                | Braking Distance and more |                   |                      |

> NOTE: Using the **Navigator Interface** will enhance the **HUD** functionality. I strongly suggest to install it.

## Autopilot / Autobrake
| [Mode 1](#mode-1-alt6-first-press)| [Mode 2](#mode-2-alt6-second-press--3-seconds-delay)| [Mode 3](#mode-3-alt6-third-press--3-seconds-delay)| [Autobrake](#autobrake-alt7)|
| :---:     | :---:                 | :---:                 | :---:                 |
| **ALT+6** | **ALT+6** (3 seconds) | **ALT+6** (3 seconds) | **ALT+7**             |
| ProGrade  | ProGrade              | Destination           | Parking Brake         |
|           | Orbiting ARM          |                       | Destination Autobrake |
|           | Maintaining Orbit     |                       | Emergency Autobrake   |

> Note: **(ALT+6)** cycles between the **3 Modes** and also disengages them.

### LOAD **(ALT+1)**
![LOAD_page](/gallery/load_explained.png)

***(Load)*** Shows you the *DOW* (Dry Operating weight), *Load* (Cargo loaded), *ZFW* (Zero Fuel Weight), *Fuel* (Fuel Weight), *GW* (Gross Weight), *MTOW* (Maximum Take Off Weight) and the percentage of the *GW* respect to the *MTOW*.
> Note: Editing the Command/Hover Seat or Cockpit **LUA Parameters** you can set up the desired *MTOW* (Maximum Take Off Weight). You can also set it up using the **Settings** in the **Navigator Interface** if installed. The **LUA Parameters** will reset if the script is reloaded while the setting in the **Navigator Interface** are instead stored in the *Databank*.

[Return to Functions](#functions) | [Return to INDEX](#INDEX)

### AI **(ALT+2)**
![AI_page](/gallery/ai_explained.png)

***(Attitude Indicator)*** The most useful instrument while flying in the atmosphere. Not only gives you the attitude of the ship but I integrated in it the *Flight Path Vector* (in Airbus airplane called "Bird"). It shows you the direction where your ship is really flying to.
Integrated in the *AI* you will find the *RA* (Radioaltimeter) that will come out when at 60 mt (Using Vertical Booster) from the ground/water.
You can find also the selected wayypoint distance and its direction.

[Return to Functions](#functions) | [Return to INDEX](#INDEX)

### SPC **(ALT+3)**
![SPC_page](/gallery/spc_explained.png)

***(Space)*** This page is useful when flying in space. I made an instrument that shows you where your *Velocity Vector* is pointing respect to your nose and where the destination is to align your velocity properly. Plus there are some indicators that will show you are 90 or 180 degrees respect to the *Velocity Vector*, this with the scope to make the most important space maneuvers.
You can also find the *Braking Distance* to reach speed 0 plus a graphical representation of your position respect the departure point and destination Planet/Moon with distances and the time you will need to travel to arrive at the current speed.
> Note: If the **Navigator Interface** is not installed or the *Departure*/*Arrival* point are not selected the system will automatically chose for you. The *Departure* point will be your Present Position *(PPOS)* or if you are in an orbit the *(PPOS)* at the moment you will leave the orbit. The *Arrival* point will be the closest Planet/Moon. As consequence when flying between Planets/Moons you will always see there the closes one.

[Return to Functions](#functions) | [Return to INDEX](#INDEX)

### ORB **(ALT+4)**
![ORB_page](/gallery/orb_explained.png)

***(Orbit)*** Page used for Orbital operations. Here you have all the information to pilot your ship precisely to achieve an orbit. It includes the graphic representation of the ellipse with your actual position respect the *AP* and *PE*. It shows in scale the planet/moon depending on your distance, it shows the *Target PE Altitude* preselected at 20.000 mt and can be changed editing the **LUA Parameters** or from the **Navigator Interface**. Also here is the instrument to orientate your ship in space and the *Braking Distance*. This time the *Braking Distance* is the distance to achieve the *Circular Orbit Speed*.

[Return to Functions](#functions) | [Return to INDEX](#INDEX)

### DMG **(ALT+5)**
![DMG_page](/gallery/dmg_explained.png)

***(Damages Report)*** When on any other HUD pages if any damage to the ship occurres the text **DMG** will become red to warn you that something happened. If you shitch to the **DMG** page you can see the Top View and the Side View of your ship and a list of damaged *Elements*. When installing the script for the first time (or reloading it) you may need to center the layout. To do this I included in the **Lua Parameters** the *Size* in case is too big or too small (negative numbers are acceptable), and the *X*, *Y*, for the pivot where the rotation occurs and the *X*, *Y* to translate it. Note that since the *SVG* (Scalable Vector Graphics) is already rotated by -90 deg if you want to translate it for example in a lower position you need to change the *X* value (negative values are acceptable) and not *Y*. 

[Return to Functions](#functions) | [Return to INDEX](#INDEX)

## Automations

### Mode 1 **(ALT+6)** (first press)
![Mode 1](/gallery/mode1_explained.png)

* **ProGrade**
Provided you are in the **SPC** or **ORB** *MFD page* this will turn your ship in a *ProGrade* direction, useful during a trip to accelerate or keep your ship facing the orbit direction and to adjust it by yourself accelerating or braking.
When **Mode 1** is active you don't have anymore authority on direction.

[Return to Automations](#automations) | [Return to INDEX](#INDEX)

### Mode 2 **(ALT+6)** (second press + 3 seconds delay)
![Trajectory](/gallery/trajectory_adjust_explained.png)

In the picture we are approaching a moon. Few minutes before to reach it (in this case 4 minutes 22 second) we need to adjust our trajectory. If we are pointing to the planet/moon we need to turn 90 degrees in the direction we want to "push" our trajectory and give thrust.
Looking at the instrument on the left side when turning the ship you will see *Squares*, *lozenges* and a full *Dot*. The *Squares* and the *lozenges* indicate a turn of 90 degrees while the full *Dot* indicate the opposite direction of the velocity vector, practically a turn of 180 degrees.
The *Yaw* and the *Pitch* can help yo uto see if we are pointing to the planet or no, if the number are equal it means our *Velocity Vector* (White) is centered on our destination (Cyan). At this moment we don't need to be very precise, we just don't want to crash in to the planet/moon or go too far. Keep the *Yaw* and the *Pitch* sligthly different. Consider farest you are smaller the different should be.

![Mode 2](/gallery/mode2_explained.png)

At this point it is extremely important to refine our trajectory. Look on the picture, this time we are having the *ORB* active on the *MFD page*. On the left we have all the *Orbital Data* we need. We also need to be sure that the affecting gravity is the one from the planet/moon we are approaching, in some case where planet/moons are close each other it may not be the closer one affecting us. To verify we can simply go in the *AI* and check the *Attitude Indicator* if the gravity comes from the planet in front of us we should see our ship is pointing down.
Said so take a look at the *Pe Alt* on the left panel. That is your aiming point. That is the lowest predicted altitude you are going to have when passing by the planet, in this case 21491 mt. Also note that we still don't have an orbit and our *ECC* infact is > 1, we don't have an *Ap Alt* neither a *T* (Period). If you are not happy with the *Pe Alt* you can still turn your ship 90 degrees and increase/decrease it (In this case if I want to increase the *Pe Alt* I should turn 90 degrees to the left). If instead you are happy with it let's go on and let's *ARM* the **Mode 2**. Take a look to the left panel, here there are now 2 important data. The *Circular Orbit Speed* and the *Distance To PE*. We will need these 2 values shortly.

* **ProGrade**
* **Orbiting ARM**
![Mode 2 entering orb](/gallery/mode2_entering_orbit_explained.png)

Provided the same conditions for **Mode 1** it turns the ship *ProGrade* and *ARM* the function to maintain a stable and circular orbit.
We were approaching the Moon and we activated the **Mode 2**. This selection will be also reflected on the instruments.
All we need to do when approaching the *PE* *(Distance To Pe)* is braking. When do we brake? when the *Braking Distance* (On the lower left instrument) is similar to our distance left to the *PE*. While braking monitor the *Ecc* (it will reduce until it will be below 1 which means you have an orbit), the *Pe Alt* (for planets with strong gravity like Alioth while braking it may reduce up to several thousands meters so be whise to chose the initial altitude, you can still correct it while braking pointing 90 degrees out and give thrust), the *Distance To Pe* in relation to the *Braking Distance* and finally your speed in mt/s that should go down close to the *Circular Orbit Speed*.
If the **Mode 2** is active and you read **Orbiting ARM** as soon as an orbit has been achieved the automation will engage and will take control. Keep in mind that it will want to achieve the *Target PE Altitude* you selected.

* **Maintaining Orbit**
![Mode 2 maintaining orb](/gallery/mode2_maintaining_orbit_explained.png)

It will engage if you are in the **ORB** *MFD page* and *PE Altitude* > 6000 mt and if an orbit is achieved. It will maintain the orbit at the *Target PE Altitude* and can be changed anytime using the **Navigator interface** or change the preselection using **LUA Parameters**.
For example you are climbing from a planet with a good trajectory, you can *ARM* it and when the *PE Altitude* will be above 6000 mt the **Mode** it will automatically engage. When **Mode 2** is engaged you don't have anymore authority on direction, thrust and brakes.
Its logic, to make it simple, is that 2 seconds before to reach the *PE* or the *AP* if the opposite (*AP* or *PE*) is too high it will brake to reduce its altitude instead passing them if the opposite is too low it will give thrust to rise them. Messages on the screen will inform you what the automation is doing.
On this picture you can see the ship maintainig the orbit we achieved before. Since we entered on an orbit at about 21000 mt the automation passing the *PE* gave thrust and increased the *AP* close to the preselecter *Target PE Altitude* of 35000 mt. If continuing the orbit when the ship will pass the *AP*, in an extimated time of almost 16 minutes, it will give thrust to bring the *PE* as well to an altitude of about 35000 mt. Note when the *PE* and the *AP* altitude are similar and you are in a circular orbit the *PE* and *AP* can change any time since they simply are the lowes and highest altitude of your orbit but they will be always opposite each other.
The *Target PE Altitude* is represented on the screen by the white circle, when your orbit will be above that circle it will become Cyan. The yellow line starting from the center of the planet/moon is your position respect the *PE* and *AP*.
> Note: If your ship has really strong brakes using **Mode 2** it may not be advisable. You can try but monitor it and in case take over. In future I may find the way to reduce the effect of the brakes.

[Return to Automations](#automations) | [Return to INDEX](#INDEX)

### Mode 3 **(ALT+6)** (third press + 3 seconds delay)
![Mode 3](/gallery/mode3_leaving_orbit_autobrake_armed_explained.png)

Same conditions of preceeding **Modes**. This will turn the ship in the direction of the destination planet/moon.
Time to leave our orbit. Select with the **Navigator Interface** the new destination and activate the **Mode 3**. If you are not using the **Navigator Interface** point your ship manually or it will point the planet youare orbiting.
What I did in this picture I waited the right moment to give full thrust, you will see your *Pe Alt* reducing if you do it too early and it is ok but stop the thrust if you see the *Pe Alt* goint to touch the planet atmosphere, you don't want to burn ot be destroyed.
You can notice also I armed the *Autobrake*, they will engage only when close to the destination so again, if you can't select a destination don't arm them now or you will stop.
If everything is ok you will see your ship pointing in the direction of the destination and leaving the actual orbit. Just keep the thrust at full power.

[Return to Automations](#automations) | [Return to INDEX](#INDEX)

### Autobrake **(ALT+7)**
It will ARM or ENGAGE the **Autobrake**. I set it up to stop at about 2 Su from the center of the destination planet/moon, it can be modified editing the **LUA Parameters** or in the **Settings** of the **Navigator Interface**.
![Autobrake ARM](/gallery/autobrake_arm_spc_explained.png)
We left our orbit and on course to Alioth. On the left lower panel you can read *Autobrake ARM*, this means that a *Destination* has been set (if no *Destination* they will not ARM, sometime you will need to go in the **SPC** *MFD page* to activate the *Destination*).
On the upper right panel you can read *Autobrake in:*, this is the distance left before they will engage, it will show *Autobrake OFF* if they are not active. Next to it you can read the distance at which you want to stop your ship. Be aware that this is the distance from the **center** of the target planet/moon (ex. going to Alioth that has a radius of 0.63Su your ship will stop at 2.3 - 0.63 Su from the surface so be careful). On my trip the selected destination is my base on Alioth that's why the ship it is not pointing to the center of the planet. In this case be even more careful if the destination you set in on the other side of the planet/moon.
My direction in managed by the sytem and the thrust is set to 100%, when it will be time to stop the system will automatically cut the thrust and brake. You can disconnect the *Autobrake* at any time pressing **(ALT+7)**.

![Autobrake ON](/gallery/autobrake_on_stop_explained.png)
My trip finished here, I hope you found useful these instructions and that make you enjoy even more flying with my HUD.
You can see the *Autobrake* system stopped my ship at 2.26 Su from the destination. 2.3 Su was selected, approaching a planet/moon stronger is the gravity and havier you are it may require some small adjustment on the final stop distance.
The *autobrake* system is used also from the **Mode 2** in case something wrong happens during an orbit, to DISARM the **Autobrake** in the event that the **Mode 2** engaged it press **(ALT+7)**.

> NOTE: I'm still refining some value and some logic, based on your ship mass, inertia, engines, brakes it may need some adjustment. Editing the **LUA parameter** you can find for example how fast you want the ship turns, be aware that for big turns it may overshoot and then go back and point at the correct direction. You can play with those values and have for example a slower turn and it will not overshoot but it takes longer. This is up to you and based on how you built your ship. I tested the Orbit maintaining function a lot and for sure if you are in a circular orbit it will keep you there, it is also capable to adjust the orbit but still monitor it.

[Return to Automations](#automations) | [Return to INDEX](#INDEX)

## DU Widgets
At the moment I also keep the possibility to recall the DU Widgets. When you enter the cockpit or the seat they will be there, just to give a crosscheck.

* **(ALT+9)** Hide/Show DU widgets
* **(ALT+8)** Hide/Show Radar Widgets

[Return to INDEX](#INDEX)

# Ship Requirements
There are few requirements a ship needs to run this HUD.
1. a **Gyroscope**;
2. at least 1 **Atmo Fuel Tank**;
3. at least 1 **Space Fuel Tank**;
4. **Cargo Containers** are not required. To save slots you can chose to connect them or not or connect 1 single **Container HUB**. The weight calculations will be still correct but in case you will not connect them their weight will be included in the *DOW* and not in *LOAD*;
5. at least 1 **Vertical Booster** or in alternative 1 **Telemeter** (if you don't have **Vertical Boosters** and you use a **Telemeter** you need to link it manually and change the **Slot** name in **radio_alt**). This is for the Radio Altimeter. I personally use the **Vertical Booster** while it has a 60 meters range instead of 100 meters it returns water as an obstacle and the telemeter doesn't.

> NOTE: If you want to install the **Navigator Interface** you need additionally 1 **Screen (xs, s, m, transparent or not are all tested)**, 1 **Databank** and 1 **Programming Board**.

[Return to INDEX](#INDEX)

# How To Install

## HUD
1. Choose the file (.conf) that is suitable for your ship and download it, download also the 3 require_\*.lua files;
2. Past all of them in **Dual Universe\Game\data\lua\autoconf\custom**;
3. In the game Right click on the **control unit -> Advanced -> Update Custom Autoconf List**. Do it again and this time in **Run Custom Autoconfigure** choose the configuration you are installing. If you are going to manually link the Fuel Tanks choose the autoconf file intended to do so. The **Rocket Fuel Tanks** need to be connected manually if you have enough slots. You can also chose to connect only 1 tank per type (Atmo and Space) but you will only have indication for those and not for others not connected.
4. The autoconfig should do everything automatically (except for those elementes that need to be manually linked) and you are ready to go. If a script error comes out and you can't find out the problem contact me via [Discord](https://discord.gg/Rve2jjZbvz).

## Navigator Interface
* Before to place the *Elements* be sure to remove from them the *Dynamic Properties*.

1. Download **Navigator_Interface.txt** and save it wherever you prefer or copy the **RAW** format from GitHub;
2. In the game place the **Programming Board**, the **Databank** and the **Screen**;
3. Copy the content of the **.txt** file or if you already copied the **RAW** format make a Right click on the **Programming Board**. Go to **Advanced -> Paste Lua Configuration From Clipboard**;
4. Enter in the **Lua Editor** of the **Programming Board** *(CTRL+L)* and check that 3 of the slots are grey and have the name of **core**, **screen** and **databank**. Check their order;
3. Link the **Screen**, the **Databank** and the **CORE** of the ship to the **Programming Board** according the sequence you saw in the **Lua Editor**;
5. Turn it on and use it. First time you turn it on the top left button for some reason may not appear in that case switch it off then on.

> NOTE: one day I will also find the solution may be to solve the error "HTML CONTENT CANNOT EXCEED 20000 CHARACTERS", unfortunatelly the SGUI function is a bit bugged and I couldn't do exactly how I wanted to do and for now the solution is just turn off then on the **Programming Board**. All the data inserted are stored.
Going in pages like *From*, *Destination* you may find the first box already filled, that is because it is stored but the coordinates box will show *nil* in that case to write you may use *CLR* or if you press *ENT* you simply confirm that string and the coordinates should appear. If for any reason you can't do anything may be you are having the error mentioned befroe so just turn it off then on.

[Return to INDEX](#INDEX)

## How To Use It
1. Activate the **Programming Board**, the screen will turn ON and will show you a firt page with buttons and *Stored Waypoints*. Usually the top left button when turning ON the first time it doesn't render, restart the **Programming Board** to solve.

2. **Stored WP 1/2** is one of the 2 pages where you can see the name you gave to the waypoints you stored. You can scroll between the 2 pages with the up down arrow next to the keypad on the screen.

3. **Su Time Calculator** is a simple tool where to insert an Su distance a speed and you will get the time to travel it, the Warp Cells required in case you warp at the actual weight and at the MTOW (supposing you want to travel to load your ship and you want to go back for planning purpose). Note the MTOW is the one you set on the **Settings**.
In the **Distance** box if you inserted a destination it will automatically set the distance from your present position *(PPOS)* to the destination. To remove that distance you need to *CLR* the *Destination*.
On the *Speed* box you can set the speed you prefer from 1 to 30000 Km/h or if you simply press *ENT* it will automatically set your actual speed.
If the Warp Cells needed shows 0 it's because you are not using the ship since some time and it is like "sleeping", just seat on the Command/Hover seat or Cockpit and it will be updated.

4. **From** here you can set your departure point, the one you want to see on the HUD. Planets and moons are already in the database, you just type their name with the keyboard and press *ENT*. If the planet/moon is in the database it will show their VEC3 coordinates.
If you don't insert anything on the box and simply press *ENT* it will set for you the *PPOS* and your actual coordinates. You may notice that in this case the lateral white arrow will go next to the box where you can write the name of the **waypoint**. This is for the purpose of storing **waypoints**. You simply write the name you want to give to the **WP** and click on *ADD WP* (top left of the screen). From this moment you will have the **WP** stored and visible in the list. If you want to store a **WP** from *Map Coordinates* you can do in **Settings**.
To **clear** a **WP** you can anytime use **From** page and press *ENT* to have *PPOS* then in the **WP** box you simply write the **WP** number you want to clear (es. wp1, wp2 etc) and press *CLR WP* the **WP** will be removed from the list. If you write ***all*** and use *CLR WP* **ALL** the stored **WP** will be delated, use it carefully.
When you have a **WP** stored in the page *From* or *Destination* you can simply write the wp number you want to select (same as per clear them) and it will show you their name once you press *ENT*.

5. **Destination** here you will set your destination that will be shown also in the HUD. Can be a planet/moon from the database or a **stored wp**.

6. **Settings** is an important page, it has the basic settings of your ship. Here you can set your *MTOW* in Tons instead to use the **Lua Paramenters** (the **Lua Parameters** can be set before to seat but can't be changed while flying instead everything you set on the screen is live). The *MTOW* will be the reference for the maximum number of *Warp Cells* needed to cover a distance and it will be also sent to the HUD for the pilot to check if the ship is within the take off limits.
The *Autobrake* box is where you can set the distance you want your ship will stop from your destination if the system is armed. Note that this is the distance from the center of the planet/moon/wp (es. Alioth radius 0,63 Su, it means the ship will stop at about 1.4 Su from the planet surface). On the second page you can manually store **Waypoints** giving them a name and inserting the coordinates given from the Map.

7. **Pe Target Altitude** is the lowest altitude you wan to orbit around a planet/moon. It will be represented with a white circle on the HUD around the planet/moon in the **ORB** *MFD page*. It will be also the reference altitude for the **Mode 2** of the autopilot to keep a circular orbit. Also this can be setted in the **Lua Parameter** but doing on the screen is live and no need to stand up or going out of the Cockpit. This parameter can also be changed while the autopilot is ON and it will adapt to the new altitude.

8. **Show WP** will simply bring you to the **Stored WP** page.

[Return to INDEX](#INDEX)

## Piloting TIPS and how to use the instruments
* **LOAD page**, nothing special, be familiar with your ship and determine wisely the *MTOW* that it may be different from planet to planet. Also be in mind that you will burn fuel this will make you lighter but better don't exaggerate carrying fuel you don't need, be as light as you can.

* **AI page**, you will be always aware where your ship is flying. How many times you pitch up but you are still going down? Well here you can see it and you can also achieve a nicely level flight, it is pretty accurate. You want to have a level flight? Just bring the *Bird* on the horizon if it goes down you are going down if goes up you are going up, easy. Note that the angle between the pitch and the *Bird* is your *Angle of Attack*. If you are very heavy and you want to reach the orbit don't climb too fast, try to keep high speed, if very heavy you may need to fly with a pitch not more then 10 degrees, keep your vertical speed positive and the bird above the horizon, don't be in rush to climb if you don't have speed. Once your Space engine turns on be gentle but don't let the ship go down again so reduce carefully your pitch help yourself with the *Bird* and keep it on the horizon until you will have a good speed. Once the speed is increasing pitch up, you want to be out of the atmosphere to don't burn, when the atmosphere is at 0% then level off again and accelerate to get the *AP Altitude* you desire (here you may switch in **ORB page** to check it), once you have established the *AP altitude* cut the thrust and wait to reach it. When you reach the *AP* burn *ProGrade* and increase your *PE Altitude* to the desired one.

* **SPC page**, is time to travel between planets and moons. Did you set a destination? If not or if you can't because you are not using the **Navigator Interface** as default your destination will be the closest planet. If so, point by yourself where you want to go and pilot to have the *velocity vector* (White circle) in the correct direction. If you could set a destination, align the white circle with the cyan circle and you can also activate the **Mode 3** of the autopilot. If you are too lazy to follow the flight, activate the **Autobrake** function. Recall that it will stop you about 2 Su from the destination (Center of the planet/moon). It means if you couldn't set the destination it will engage at the closest planet, so if you are going away from it wait to be more than 2.3 Su (or the Su you edited in **LUA Parameters**) then activate it if there are no other planets between you and your destination. Once you will be closest to the next planet the destination will update so the **Autobrake**.

* **ORB page**, now you are approaching your planet/moon. Check that the gravity affecting your ship is actually from that planet you intend to go, one way to do it is to switch to **AI mode** and see where the terrain is in the **Attitude Indicator**. It may happen planets near moons will influence your ship even when you are well close to the moon. Once the gravity is the correct one the data for the orbit are correct. Initially you will only have a *PE Altitude* so what to do now? You can increase or decrease that altitude based on your preference. All you need to do is to align the ship 90 degrees respect your *Velocity Vector* and burn to increase or decrease it, just choose the correct side. While burning look at the *PE Altitude* when you are satisfied cut the thrust. Now you need to wait, you will have the *distance to the PE* and the calculated speed for a *circular orbit*. Also you have the *braking distance* to achieve that speed. Once you are approaching the desired braking distance brake! Be aware for planets with a strong gravity while braking your *PE Altitude* may decrease a bit. So you can initially have a higher altitude or while braking you can burn again 90 degrees respect your *Velocity Vector* to keep that altitude. While braking monitor the *braking distance*, the *PE distance* and the *Eccentricity* (ECC), once the *ECC* will be less than 1 it means you are in orbit and the graphic changes to represent it. If you previously ARMED the **Orbit Maintaining** function it will take controls and will adjust, at the proper time, the orbit, if not **you have control!** Once satisfied with the orbib if already not engaged you can engage the **Mode 1** of the autopilot. Be aware that it will aim for the *Target Altitude* you set or the *default 20.000 mt*. You can set a lower altitude down to 10.000 mt, less than that better not to be in orbit, on some planet you may hit the atmosphere or if something happens you don't really have time to recover.

[Return to INDEX](#INDEX)

# Warnings
> DISCLAIMER: I do not accept any responsibility for incorrect use of this HUD. Recall **you are still the pilot and if something goes wrong take over**.

* Enjoy flying more then use automations, if you use them choose the proper time and proper situation when to activate them. Monitor their behaviour.

* ARMING the **Mode 1** in a wrong moment may result in the **Autobrake** activation because the system is not able to maintain a safe orbit, this may happen if you are climbing away from a planet and you don't want it to happen above all in that moment when you need your maximum power. I will probably change the logic a bit more and probably I will insert a timer of 3 seconds also for this **Mode** to prevent the undesired engagement, probably also exchanging the **Mode 1** with **Mode 2**.

* Be aware the indicated speed it is not an horizontal speed, if you are descending to a planet vertically you will have a speed, use the *Bird* to understand your *flight path* and correct it, align your ship with the *Bird* to avoid the *Stall* or don't keep an *Angle Of Attack* too high (Angle between *Pitch* and *Bird*) gain lift on the wings and pitch up when in atmosphere, try to reduce your re-entry *Vertical Speed* if too high and you are heavy you will probably smash on the ground. Avoid a vertical re-entry, that is not the way to fly unless you built your ship with that concept.

* I usually fly using Mouse and Keyboard, unfortunately the Joystick is still bugged. Anyway I didn't change any key configuration so you should be able to fly with your preferred system.

* I experienced some FPS drop in these situation:
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
