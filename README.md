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
| [Functions](##Functions)|
| [Ship Requirements](#Ship-Requirements)|
| [How To Install](#How-To-Install)|
| [How To Use It](##How-To-Use-It)|
| [Piloting TIPS and how to use the instruments](#Piloting-TIPS-and-how-to-use-the-instruments)|
| [Warnings](#Warnings)|
| [Contacts](#Contacts)|
| [Gallery](#Gallery)|
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

#### LOAD **(ALT+1)**
![Load_page](/gallery/load_explained.png)

***(Load)*** Shows you the *DOW* (Dry Operating weight), *Load* (Cargo loaded), *ZFW* (Zero Fuel Weight), *Fuel* (Fuel Weight), *GW* (Gross Weight), *MTOW* (Maximum Take Off Weight) and the percentage of the *GW* respect to the *MTOW*.
> Note: Editing the Command/Hover Seat or Cockpit **LUA Parameters** you can set up the desired *MTOW* (Maximum Take Off Weight). You can also set it up using the **Settings** in the **Navigator Interface** if installed. The **LUA Parameters** will reset if the script is reloaded while the setting in the **Navigator Interface** are instead stored in the *Databank*.

[Functions](#functions)

#### AI **(ALT+2)**
![AI_page](/gallery/ai_explained.png)

***(Attitude Indicator)*** The most useful instrument while flying in the atmosphere. Not only gives you the attitude of the ship but I integrated in it the *Flight Path Vector* (in Airbus airplane called "Bird"). It shows you the direction where your ship is really flying to.
Integrated in the *AI* you will find the *RA* (Radioaltimeter) that will come out when at 60 mt (Using Vertical Booster) from the ground/water.
You can find also the selected wayypoint distance and its direction.

[Functions](#functions)

#### SPC **(ALT+3)**
*(Space)* This page is useful when flying in space. I made an instrument that shows you where your *Velocity Vector* is pointing respect to your nose and where the destination is, so to align your velocity properly. Plus there are some indicators to know when you are 90 or 180 degrees with your *Velocity Vector* to make the most important maneuvers. Here you can also find the *Braking Distance* to reach speed 0 plus a graphical representation of your position respect the departure planet/point and destination planet/moon with distances and time you need to arrive there at the current speed.

[Functions](#functions)

![SPC_page](/gallery/pict_03.png)

#### ORB **(ALT+4)**
*(Orbit)* Page used for Orbital operations. Here you have all the information to pilot your ship precisely to achieve an orbit. It includes the graphic representation of the ellipse with your actual position respect the *AP* and *PE*. It shows in scale the planet/moon depending on your distance, it shows the *Target PE Altitude* preselected at 20.000 mt and can be changed **editing the LUA Parameters** or from the **Navigator Interface**. Also here is the instrument to orient your ship in space and the *Braking Distance* and this time is the distance to achieve the *Circular Orbit Speed*.

[Functions](#functions)

![ORB_page](/gallery/pict_04.png)

#### DMG **(ALT+5)**
*(Damage Report)* On any other HUD page if any damage to the ship occurres the text **DMG** will be red to warn you that something happened. You don't need to do anything else that shitch to the **DMG** page to see what's wrong. Here you can see the Top View and the Side View of your ship and a list of damaged *Elements*. When installing the script for the first time (or reloading it) you may need to center the layout. To do this I included in the *Lua Parameters* the *Size* in case is too big or too small (negative numbers are acceptable), and the *X*, *Y*, for the pivot where the rotation occurs and the *X*, *Y* to translate it. Note that since the *SVG* is already rotated by -90 deg if you want to translate it for example in a lower position you need to change the *X* value (negative values are acceptable) and not *Y*. 

[Functions](#functions)

As I mentioned I kept the automation at the minimum. These is what you have:

* **(ALT+6)** It cycles between **3 Modes**.

1. **Mode 1:** Provided you are in the **SPC** or **ORB Page** this will only keep your ship in a *ProGrade* direction, useful during a trip to accelerate or if you want to adjust an orbit by yourself accelerating or braking if you have thrusters to do so.

2. **Mode 2:** Provided the same conditions for **Mode 1** it turns the ship *ProGrade* and ARM the function to maintain a stable and circular orbit. It will engage if you are in the **ORB page** and *PE Altitude* > 6000 mt and if an orbit is achieved. It will maintain the orbit at the *Target PE Altitude* and can be changed anytime using the **Navigator interface**.
If your ship has really strong brakes using **Mode 2** it may not be advisable. You can try but monitor it and in case take over.

3. **Mode 3:** Same conditions of preceeding **Modes** this will engage after 3 seconds to give you the option to don't engage it and turn off all the modes. This will turn the ship in the direction of the destination planet/moon.

4. All **Modes** can be disengaged pressing a 4th time **(ALT+6)** or if in **AI Page** pressing 1 time **(ALT+6)**. All HUD pages can be view while **Modes** are on.

* **(Alt+7)** It will ARM or ENGAGE the **Autobrake**. I set it up to stop at about 2 Su from the center of the destination planet/moon, it can be modified **editing the LUA Parameters**. In the **SPC page** it will show you in how many Su it will engage. You can point your ship to the target accelerate as much as you wish and let it go. The ship will stop by itself and if engines were still on they will be turned off. This is used also to DISARM the **Autobrake** in the event that the **Mode 1** engaged it if something was wrong in the orbit and it became unsafe.

At the moment I also keep the possibility to recall the DU widgets. When you enter the cockpit or the seat they will be there, just to give a crosscheck.

* **(ALT+9)** To close or open the DU widgets
* **(ALT+8)** To close or open the Radar Widgets

* In all the HUD pages the bottom left display includes an indication about the **active Mode**, the **Autobrake** condition and **Fuel Cautions/Warnings** indicating a **Low Level Tank** or **Empty Tank** and which is the affected tank. There is an **Annunciator Light** for the **Landing Gear**, for the **External Lights** and also if you are using the **Rockets**.

* The bottom right display shows indications about:
1. Speed;
2. Thrust setting;
3. Pitch and Roll;
4. Altitude;
5. Vertical speed;
6. Radar Warning System
7. Average Percentage of fuel for each tank of the 3 different types;
8. Time left based on the Fuel Tank that will be empty as first and when it will be empty the next will be shown.

> NOTE: I'm still refining some value and some logic, based on your ship mass, inertia, engines, brakes it may need some adjustment. Editing the LUA parameter you can find for example how fast you want the ship turns, be aware that for big turns it may overshoot once to go back and point at the correct direction. You can play with those values and have for example a slower turn and it will not overshoot but it takes longer. This is up to you and based on how you built your ship. I tested the Orbit maintaining function a lot and for sure if you are in a circular orbit it will keep you there, it is also capable to adjust the orbit but still monitor it.

[Return to INDEX](#INDEX)

# Ship Requirements
There are few requirements a ship needs to run this HUD.
1. a **Gyroscope**;
2. at least 1 **Atmo Fuel Tank**;
3. at least 1 **Space Fuel Tank**;
4. **Cargo Containers** are not required. To save slots you can chose to connect them or not or connect 1 single **Container HUB**. The weight calculations will be still correct but in case you will not connect them their weight will be included in the *DOW* and not in *Load*;
5. at least 1 **Vertical Booster** or in alternative 1 **Telemeter** (if you don't have **Vertical Boosters** and you use a **Telemeter** you need to link it manually and change the **Slot** name in **radio_alt**). This is for the Radio Altimeter. I personally use the Vertical Booster, while it has a 60 meters range instead of 100 meters it returns water as an obstacle and the telemeter doesn't.

> NOTE: If you want to install the **Navigator Interface** you need additionally 1 **Screen (xs, s, m, transparent or not are tested)**, 1 **Databank** and 1 **Programming Board**.

[Return to INDEX](#INDEX)

# How To Install

## HUD
1. Choose the file (.conf) that is suitable for your ship and download it, downloadalso the 3 require lua files;
2. Past all of them in **Dual Universe\Game\data\lua\autoconf\custom**;
3. In the game Right click on the **control unit -> Advanced -> Update Custom Autoconf List**. Do it again and this time in **Run Custom Autoconfigure** choose the configuration you are installing. If you are going to manually link the Fuel Tanks choose the autoconf file intended to do so. The **Rocket Fuel Tanks** need to be connected manually if you have enough slots to do so. You can also chose to connect only 1 tank per type (Atmo and Space) but you will only have indication for those and not for others not connected.
4. The autoconfig should do everything automatically (except for those elementes that need to be manually linked) and you are ready to go. If a script error comes out and you can't find out the problem contact me via [Discord](https://discord.gg/Rve2jjZbvz).

## Navigator Interface
* Before to place the *Elements* be sure to remove from them the *Dynamic Properties*.

1. Download **Navigator_Interface.txt** and save it wherever you prefer or copy the **RAW** format from GitHub;
2. In the game place the **Programming Board**, the **Databank** and the **Screen**;
3. Copy the content of the **.txt** file or if you already copied the **RAW** format make a Right click on the **Programming Board**. Go to **Advanced -> Paste Lua Configuration From Clipboard**;
4. Enter in the **Lua Editor** of the **Programming Board** *(CTRL+L)* and check that 3 of the slots are grey and have the name of **core**, **screen** and **databank**. Check their order;
3. Link the **Screen**, the **Databank** and the **CORE** of the ship to the **Programming Board** according the sequence you saw in the **Lua Editor**;
5. Turn it on and use it. First time you turn it on the top left button for some reason may not appear in that case switch it off then on.

> NOTE: one day I will also find the solution may be to solve the error "HTML CONTENT CANNOT EXCEED 20000 CHARACTERS", unfortunatelly the SGUI function is a bit bugged and I couldn't do exactly how I wanted and for now the solution is just turn off then on the **Programming Board**. All the data inserted are stored.
Going in pages like *From*, *Destination* you may find the first box already filled, that is because it is stored but the coordinates you will see *nil* in that case to write you may use CLR or if you press ENT you simply confirm that string and the coordinates should appear. If for any reason you can't do anything may be you are having the error mentioned befroe so just turn it off then on.

[Return to INDEX](#INDEX)

## How To Use It
1. Activate the **Programming Board**, the screen will turn ON and will show you a firt page with buttons and *Stored Waypoints*. Usually the top left button when turning ON the first time it doesn't render, restart the **Programming Board** to solve.

2. **Stored WP 1/2** is one of the 2 pages where you can see the name you gave to the waypoints you stored. You can scroll between the 2 pages with the up down arrow next to the keypad on the screen.

3. **Su Time Calculator** a simple tool where to insert an Su distance a speed and you will get the time to travel it, the Warp Cells required in case you warp at the actual weight and at the MTOW (supposing you want to travel to load your ship and you want to go back for planning purpose). Note the MTOW is the one you set on the **Settings**.
In the **Distance** box if you inserted a destination it will automatically set the distance from your present position *(PPOS)* to the destination. To remove that distance you need to CLR the destination.
On the *Speed* box you can set the speed you prefer from 1 to 30000 Km/h or if you simply press ENT it will automatically set your actual speed.
If the Warp Cells needed shows 0 it's because you are not using the ship since some time, just seat on the command/hover seat or Cockpit and it will be updated.

4. **From** here you can set your departure point, the one you want to see on the HUD. Planets and Moons are already in the database, you just type their name with the keyboard and press ENT. If the Planet/Moon is in the database it will show their VEC3 coordinates.
if you don't insert anything on the box and simply press ENT it will set for you the *PPOS* and your actual coordinates. You may notice that in this case the lateral arrow will go next to the box where you can write the name of the waypoint. This is for the purpose of storing waypoints. You simply write the name you want to give to the WP and click on *ADD WP* (top left of the screen). From this moment you will have the WP Wtored and visible in the list. If you want to store a WP from *Map Coordinates* you look on **Settings**.
To clear a WP you can anytime use this page and press ENT to have *PPOS* then in the WP box you simply write the WP number you want to clear (es. wp1, wp2 etc) and press *CLR WP* the WP will be removed from the list. Is you write *all* and use *CLR WP* ALL the stored WP will be delated, use it carefully.
When you have a WP stored in the page *From* or *Destination* you can simply write the wp number you want to select (same as per clear them) and it will show you the name.

5. **Destination** here you will set your destination that will be shown also in the HUD. Can be a Planet/Moon from the database or a stored wp.

6. **Settings** is an important page, it has the basic settings of your ship. Here you can set your *MTOW* in Tons instead to use the *Lua Paramenters* (the *Lua Parameters* can be set before to seat but can't be changed while flying instead everything you set on the screen is live) and this weight will be the reference for the maximum number of Warp Cells needed to cover a distance and it will be sent to the HUD for the pilot to check if within the limits of the intended maximum take off weight.
The *Autobrake* box is where you can set the distance you want your ship will stop from your destination engaging the Autobrakes if armed.  Note that is the distance from the center of the Planet/Moon/wp (es. Alioth radius 0,63 Su, it means the ship will stop at about 1.4 Su from the planet). On the second page you can manually store Waypoints giving them a name and inserting the coordinates given from the Map.

7. **Pe Target Altitude** is the lowest altitude you wan to orbit around a Planet/Moon. It will be represented with a white circle on the HUD around the Planet/Moon in the *ORB page*. It will be also the reference altitude for the *Mode 2* of the autopilot that will keep a circular orbit. Also this can be setted in the *Lua Parameter* but doing on the screen is live and no need to stand up or going out of the cockpit. Can be changed also if the autopilot is on it will adapt to the new altitude.

8. **Show WP** will simply bring you to the Stored WP page.

[Return to INDEX](#INDEX)

# Piloting TIPS and how to use the instruments
* **Load page**, nothing special, be familiar with your ship and determine wisely the MTOW that it may be different from planet to planet. Also be in mind that you will burn fuel this will make you lighter but better don't exaggerate carrying fuel you don't need, be as light as you can.

* **AI page**, you will be always aware where your ship is flying. How many times you pitch up but you are still going down? Well here you can see it and you can also achieve a nicely level flight, it is pretty accurate. You want to have a level flight? Just bring the *Bird* on the horizon if it goes down you are going down if goes up you are going up, easy. Note that the angle between the pitch and the *Bird* is your *Angle of Attack*. If you are very heavy and you want to reach the orbit don't climb too fast, try to keep high speed, if very heavy you may need to fly with a pitch not more then 10 degrees, keep your vertical speed positive and the bird above the horizon, don't be in rush to climb if you don't have speed. Once your Space engine turns on be gentle but don't let the ship go down again so reduce carefully your pitch help yourself with the *Bird* and keep it on the horizon until you will have a good speed. Once the speed is increasing pitch up, you want to be out of the atmosphere to don't burn, when the atmosphere is at 0% then level off again and accelerate to get the *AP Altitude* you desire (here you may switch in **ORB page** to check it), once you have established the *AP altitude* cut the thrust and wait to reach it. When you reach the *AP* burn *ProGrade* and increase your *PE Altitude* to the desired one.

* **SPC page**, is time to travel between planets and moons. Did you set a destination? If not or if you can't because you are not using the **Navigator Interface** as default your destination will be the closest planet. If so, point by yourself where you want to go and pilot to have the *velocity vector* (White circle) in the correct direction. If you could set a destination, align the white circle with the light blue circle and you can also activate the **Mode 3** of the autopilot. If you are too lazy to follow the flight, activate the **Autobrake** function. Recall that it will stop you about 2 Su from the destination (Center of the planet/moon). It means if you couldn't set the destination it will engage at the closest planet, so if you are going away from it wait to be more than 2.3 Su (or the Su you edited in **LUA Parameters**) then activate it if there are no other planets between you and your destination. Once you will be closest to the next planet the destination will update so the **Autobrake**.

* **ORB page**, so now you are approaching your planet/moon. Check that the gravity affecting your ship is actually from that planet you intend to go, one way to do it is to switch to **AI mode** and see where the terrain is in the **Attitude Indicator**. It may happen planets near moons will influence your ship even when you are well close to the moon. Once the gravity is the correct one the data for the orbit are correct. Initially you will only have a *PE Altitude* so what to do now? You can increase or decrease that altitude based on your preference. All you need to do is to align the ship 90 degrees respect your *Velocity Vector* and burn to increase or decrease it, just choose the correct side. While burning look at the *PE Altitude* when you are satisfied cut the thrust. Now you need to wait, you will have the *distance to the PE* and the calculated speed for a *circular orbit*. Also you have the *braking distance* to achieve that speed. Once you are approaching the desired braking distance brake! Be aware for planets with a strong gravity while braking your *PE Altitude* may decrease a bit. So you can initially have a higher altitude or while braking you can burn again 90 degrees respect your *Velocity Vector* to keep that altitude. While braking monitor the *braking distance*, the *PE distance* and the *Eccentricity* (ECC), once the *ECC* will be less than 1 it means you are in orbit and the graphic changes to represent it. If you previously ARMED the **Orbit Maintaining** function it will take controls and will adjust, at the proper time, the orbit, if not **you have control!** Once satisfied with the orbib if already not engaged you can engage the **Mode 1** of the autopilot. Be aware that it will aim for the *Target Altitude* you set or the *default 20.000 mt*. You can set a lower altitude down to 10.000 mt, less than that better not to be in orbit, on some planet you may hit the atmosphere or if something happens you don't really have time to recover.

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

# Gallery
![Climbing](/gallery/pict_05.png)
![Orbiting](/gallery/pict_06.png)
![Bird](/gallery/pict_07.png)

[Return to INDEX](#INDEX)

# Credits
Jayle Break (orbital data) - https://gitlab.com/JayleBreak/dualuniverse/-/tree/master/DUflightfiles/autoconf/custom

Catharius (Damages Report) - https://github.com/Catharius/DU-MINIMALIST-HUD

DU Lua Scripting Community - https://discord.gg/dualuniverse

[Return to INDEX](#INDEX)
