screen.activate()
--DATABANK INITIALIZATION
 local SoftwareVersion="v8.0.0"
 db.setStringValue("Navigator Interface ver", SoftwareVersion)
 system.print("- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -")
 system.print("NAVIGATOR INTERFACE System ONLINE")
 system.print("Release "..SoftwareVersion)
 system.print("- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -")
 Databank_Soft_Reset=false --export
 Databank_Hard_Reset=false --export
 function databank_initialization()
  db.setStringValue("databank_verification", "Verified")
  db.setStringValue("Ship ID", "n/a")
  db.setFloatValue("navigator_speed", "n/a")
  db.setFloatValue("navigator_distance", "n/a")
  db.setStringValue("navigator_target_destination", "no Dest.")
  db.setStringValue("navigator_coordinates", "n/a")
  db.setFloatValue("navigator_eta_h", 0)
  db.setFloatValue("navigator_eta_m", 0)
  db.setFloatValue("navigator_eta_s", 0)
  db.setStringValue("navigator_from_coordinates", "n/a")
  db.setStringValue("navigator_from", "no From")
  db.setFloatValue("navigator_pe_target_altitude", factory_PE_target_altitude)
  db.setFloatValue("navigator_from_planet_radius", 0)
  db.setFloatValue("navigator_target_planet_radius", 0)
  factory_autobrake=2.3
  db.setFloatValue("navigator_autobrake", factory_autobrake)
  factory_MTOW=730000
  db.setFloatValue("navigator_MTOW", factory_MTOW)
  wp_sequencing_distance=0.5
  db.setFloatValue("navigator_wpdist", wp_sequencing_distance)
  db.setStringValue("SCRFontColor", "{217,217,217}")
  db.setStringValue("SCRButtonColor", "{0,0,255}")
  db.setStringValue("SCRTableColor", "{0,0,255}")
  db.setStringValue("SCRFontTitle", "{255,255,0}")
  db.setStringValue("SCRButtonPressed", "{255,0,0}")
  db.setStringValue("FontColor", "{217,217,217}")
  db.setStringValue("Background", "{0,0,100}")
  db.setStringValue("TableColor", "{0,0,255}")
  db.setStringValue("FontTitle", "{255,255,0}")
  db.setStringValue("Selection", "{0,100,200}")
  db.setFloatValue("Alpha1", 0.4)
  db.setFloatValue("Alpha2", 0.8)
  db.setStringValue("wp_color", "none")
  db.setStringValue("agg eng/stby", "STBY")
  db.setStringValue("agg off/stby", "OFF")
  db.setIntValue("agg_base", 1000)
  db.setIntValue("agg_t_alt", 1000)
  db.setStringValue("nav agg", "OFF")
  db.setFloatValue("DMG Scale", 3)
  db.setFloatValue("DMG TV U/D", -20)
  db.setFloatValue("DMG TV L/R", 30)
  db.setFloatValue("DMG SV U/D", 40)
  db.setFloatValue("DMG SV L/R", 100)
  db.setIntValue("holding_speed", 300)
  db.setIntValue("Holding", 0)
  local check=db.getStringValue("wp_settings"):gsub("@@@","\"")
  if check=="" then
   local data={}
   data=json.encode(data)
   db.setStringValue("wp_settings", data:gsub("\"","@@@"))
  end
 end
 if (Databank_Soft_Reset or db.getStringValue("databank_verification")~="Verified") then databank_initialization() end
 if Databank_Hard_Reset then db.clear() databank_initialization() end

--PARAMETERS
 if (db.getFloatValue("navigator_MTOW")~=0) then
  factory_MTOW=db.getFloatValue("navigator_MTOW")
  new_MTOW=factory_MTOW/1000
 else
  factory_MTOW=730000 --export
  new_MTOW=factory_MTOW/1000
 end

 if (db.getFloatValue("navigator_autobrake")~=0) then
  factory_autobrake=db.getFloatValue("navigator_autobrake")
 else
  factory_autobrake=2.3 --export
 end
 factory_PE_target_altitude=20000 --export

 if (db.getFloatValue("navigator_wpdist")~="") then
  wp_sequencing_distance=db.getFloatValue("navigator_wpdist")
 else
  wp_sequencing_distance=0.5 --export
 end

 if (db.getIntValue("holding_speed")~=0) then
  holding_speed=db.getIntValue("holding_speed")
 else
  holding_speed=300 --export
 end

 local Menu_First_Page="WP/ATLAS" --export
 local FontName="Montserrat-Light"--export
 FontName=[["]].. FontName ..[["]]
 local FontSize=25--export

 function ColorConvert(x)
  local y=tonumber(x)/255
  return y
 end

 local FontColor=db.getStringValue("SCRFontColor")
 FontColor=json.decode(FontColor)
 Font_R=ColorConvert(FontColor[1])
 Font_G=ColorConvert(FontColor[2])
 Font_B=ColorConvert(FontColor[3])
 local ButtonColor=db.getStringValue("SCRButtonColor")
 ButtonColor=json.decode(ButtonColor)
 Button_R=ColorConvert(ButtonColor[1])
 Button_G=ColorConvert(ButtonColor[2])
 Button_B=ColorConvert(ButtonColor[3])
 local TableColor=db.getStringValue("SCRTableColor")
 TableColor=json.decode(TableColor)
 Table_R=ColorConvert(TableColor[1])
 Table_G=ColorConvert(TableColor[2])
 Table_B=ColorConvert(TableColor[3])
 local FontTitle=db.getStringValue("SCRFontTitle")
 FontTitle=json.decode(FontTitle)
 Title_R=ColorConvert(FontTitle[1])
 Title_G=ColorConvert(FontTitle[2])
 Title_B=ColorConvert(FontTitle[3])
 local ButtonPressed=db.getStringValue("SCRButtonPressed")
 ButtonPressed=json.decode(ButtonPressed)
 Button_Pressed_R=ColorConvert(ButtonPressed[1])
 Button_Pressed_G=ColorConvert(ButtonPressed[2])
 Button_Pressed_B=ColorConvert(ButtonPressed[3])
 local Alpha1=db.getFloatValue("Alpha1")
 
 local MenuButtonWidth=280
 local MenuButtonHeight=40
 local MenuKeyWidth=60
 local MenuKeyHeight=40

 local ButtonSep=10

 local Menu_Line1=ButtonSep
 local Menu_Line2=ButtonSep+Menu_Line1+MenuKeyHeight
 local Menu_Line3=ButtonSep+Menu_Line2+MenuKeyHeight
 local Menu_Line4=ButtonSep+Menu_Line3+MenuKeyHeight
 local Menu_Line5=ButtonSep+Menu_Line4+MenuKeyHeight
 local Menu_Line6=ButtonSep+Menu_Line5+MenuKeyHeight
 local Menu_Line7=ButtonSep+Menu_Line6+MenuKeyHeight
 local Menu_Line8=ButtonSep+Menu_Line7+MenuKeyHeight
 local Menu_Line9=ButtonSep+Menu_Line8+MenuKeyHeight
 local Menu_Line10=ButtonSep+Menu_Line9+MenuKeyHeight
 local Menu_Line11=ButtonSep+Menu_Line10+MenuKeyHeight

 PVPStationIsON=false
 if shield then unit.setTimer("PVPStation", 1) end
 if receiver then receiver.setChannelList({"AviatorWPBaseSync"}) end

 atlas=require('atlas')

--STRING CONVERTER TO VEC3
 function vec3FromStr(vStr) --to convert string to vec3
  local v3={};
  for num in string.gmatch(vStr, "[-%d%.]+") do
   local vN=string.gsub(num, "%+", "")
   table.insert(v3, tonumber(vN))
  end
  return vec3(table.unpack(v3))
 end

--SET COORDINATES FROM ATLAS
 function set_coordinates(body)
  planet_lat=body.center[1]
  planet_lon=body.center[2]
  planet_alt=body.center[3]

  local world_coord="::pos{0,0,"..planet_lat..","..planet_lon..","..planet_alt.."}"
  system.setWaypoint(world_coord)
 end

--SET COORDINATES FROM WP
 function set_wp_coordinates(body)
  system.setWaypoint("::pos{0,0,"..body:gsub("[()]","").."}")
 end

--WORLD TO VEC3 COORDINATES
 function coord_converter()
  for i, v in pairs(atlas[0]) do
   if atlas[0][i].name[1]==wp_selected_planet then
    planet_center=vec3(atlas[0][i].center)
    planet_radius=atlas[0][i].radius
    planet_system=0
   end
  end

  local wp_pos={system=planet_system, lat=tonumber(keypad_input_wp_lat), lon=tonumber(keypad_input_wp_lon), alt=tonumber(keypad_input_wp_alt)}
  local deg2rad=math.pi/180
  local lat_rad=wp_pos.lat * deg2rad
  local lon_rad=wp_pos.lon * deg2rad
  local xproj=math.cos(lat_rad)

  return planet_center + (planet_radius + wp_pos.alt) * vec3(xproj*math.cos(lon_rad), xproj*math.sin(lon_rad), math.sin(lat_rad))
 end

--GENERATING WP LIST PAGES
 function generating_wp_pages(option)
  local dbKeys=db.getNbKeys()
  if option==0 then
   if dbKeys>0 then
    local counter=0
    local wp_id=""
    for i=1, dbKeys do
     wp_id=tostring("wp"..i)
     local name=db.getStringValue(wp_id)
     if (tostring(name)~=nil and tostring(name)~="") then counter=counter + 1 end
    end
    pages=math.ceil(counter/10)
    if pages==0 then pages=1 end
   else
    pages=1
   end
  end
  if option==14 then
   if dbKeys>0 then
    local counter=1
    local route_id=""
    for i=1, dbKeys do
     route_id=tostring("Route"..i)
     local name=db.getStringValue(route_id)
     if (tostring(name)~=nil and tostring(name)~="") then counter=counter + 1 end
    end
    pages=math.ceil(counter/5)
    if (counter/pages*5)==1 then pages=pages+1
    elseif pages==0 then pages=1 end
   end
  end
  if option=="14routes" then
   if dbKeys>0 then
    local counter=1
    local route_id=""
    for i=1, dbKeys do
     route_id=tostring("Route"..i)
     local name=db.getStringValue(route_id)
     if (tostring(name)~=nil and tostring(name)~="") then counter=counter + 1 end
    end
    pages=math.ceil(counter/5)*5
    if pages==0 then pages=1 end
   end
  end
  if option=="14wp" then
   local route_id=""
   for i=1, #route_tick_ do
    if (route_tick_[i]==">" or route_tick_[i]=="*") then
     RouteTickList=json.encode(route_tick_)
     route_id=routes_list[i]
     if route_id~=nil and route_id~="" then route_id=routes_list[i].id end
     break
    end
   end
   if route_id and route_id~="" then
    local data=db.getStringValue(route_id):gsub("@@@","\"")
    data=json.decode(data)
    if data~=nil then
     local counter=0
     for i,v in pairs(data) do counter=counter +1 end
     pages=math.ceil(counter/5)
    else
     pages=1
     routes_wp_page_index=1
    end
   else
    pages=1
    routes_wp_page_index=1
   end
  end
  return pages
 end
 wp_pages=generating_wp_pages(0)

--WP CHECK
 function wp_check()
  if LuaWp and LuaWpName and LuaSavingWp then
   system.print("Saving:")
   system.print(keypad_input_wpname)
   system.print("At Coordinates:")
   system.print(tostring(from_coordinates))
   LuaWp=false
   LuaSavingWp=false
   LuaWpName=false
  end
  local dbn=db.getNbKeys()
  stored=""
  for i=1, dbn+1 do
   local wp_id=tostring("wp"..i)
   local wp_checking=db.getStringValue(wp_id)
   if keypad_input_wpname==wp_checking then
    stored="WP Name Already Exist"
    if screenState~=7 then system.print("WP Name Already Exist") end
   break end
  end
  if stored~="WP Name Already Exist" then
   for i=1, dbn+1 do
    local wp_id=tostring("wp"..i)
    local wp_checking=db.getStringValue(wp_id)
    if wp_checking=="" then
     local name=db.setStringValue(wp_id, keypad_input_wpname)
     local coord=db.setStringValue(wp_id.."_coord", tostring(from_coordinates))
     stored="STORED"
     if screenState~=7 then system.print("WP Stored") end
     break
    end
   end
  end
  wp_settings_init()
 end

--ROUTING
 function routing(id, name)
  local route={["name"]=name}
  route=json.encode(route)
  db.setStringValue(id, route:gsub("\"","@@@"))
 end

 function add_wp_to_route(id, wp)
  local route_id=route_id_selected
  local data=db.getStringValue(route_id):gsub("@@@","\"")
  data=json.decode(data)
  data[id]=wp
  data=json.encode(data)
  db.setStringValue(route_id, data:gsub("\"","@@@"))
 end

--INVERT ROUTE
 function invert_route()
  local dest=db.getStringValue("from")
  local from=db.getStringValue("to")

  if dest~="" and from~="" then
   keypad_input_from=from
   for i=1, #wp_list do
    local from_check=db.getStringValue(wp_list[i].wp)
    if from_check==from then
     keypad_input_from=wp_list[i].id
     break
    end
   end
   db.setStringValue("from", keypad_input_from)

   keypad_input_dest=dest
   if (dest=="" or dest=="PPOS") then keypad_input_dest="No Previous Point"
   else
    for i=1, #wp_list do
     local dest_check=db.getStringValue(wp_list[i].wp)
     if dest_check==dest then
      keypad_input_dest=wp_list[i].id
      break
     end
    end
   end
   db.setStringValue("to", keypad_input_dest)

   from_coordinates=""
   from_inserted=false
   status_FM=""
   status_TO=""
   FROM_tick=">"
   keypad_input_wpname=""
   wpname_inserted=false
   WPADD_tick=""
   stored=""
   destination_inserted=false
   destination_coord=""
   distance_to_go=""
   distance_to_go_warp=0
  end
 end

--ENT DESTINATION WP
 function ent_to_wp(dest)
  ScreenSelection=""
  if ((screenState==0 or screenState==15) and dest~="") then
   for i=1, #wp_list do
    if dest==wp_list[i].name then
     dest=wp_list[i].id
     if screenState==0 then screenState=3 end
     keypad_input_dest=dest
     db.setStringValue("to", keypad_input_dest)
     status_TO=""
     destination_inserted=false
     destination_coord=""
     distance_to_go=""
     distance_to_go_warp=0
     ent_button()
     break
    end
   end
  elseif (screenState==6 and dest~="") then
   for i, v in pairs(atlas[0]) do
    if dest==atlas[0][i].name[1] then
     screenState=3
     keypad_input_dest=dest
     db.setStringValue("to", keypad_input_dest)
     status_TO=""
     destination_inserted=false
     destination_coord=""
     distance_to_go=""
     distance_to_go_warp=0
     ent_button()
     break
    end
   end
  end
 end

--ENT FROM WP
 function ent_from_wp(from)
  if (screenState==0 and from~="") then
   for i=1, #wp_list do
    if from==wp_list[i].name then
     from=wp_list[i].id
     screenState=2
     keypad_input_from=from
     db.setStringValue("from", keypad_input_from)
     from_coordinates=""
     from_inserted=false
     status_FM=""
     FROM_tick=">"
     keypad_input_wpname=""
     wpname_inserted=false
     WPADD_tick=""
     stored=""
     ent_button()
     break
    else
     screenState=2
    end
   end
  elseif (screenState==6 and from~="") then
   for i, v in pairs(atlas[0]) do
    if from==atlas[0][i].name[1] then
     screenState=2
     keypad_input_from=from
     db.setStringValue("from", keypad_input_from)
     from_coordinates=""
     from_inserted=false
     status_FM=""
     FROM_tick=">"
     keypad_input_wpname=""
     wpname_inserted=false
     WPADD_tick=""
     stored=""
     ent_button()
     break
    end
   end
  else
   screenState=2
  end
 end

--WP SETTINGS INIT
 function wp_settings_init()
  local dbKeys=db.getNbKeys()

  local check=db.getStringValue("wp_settings"):gsub("@@@","\"")
  if check=="" then
   local data={}
   data=json.encode(data)
   db.setStringValue("wp_settings", data:gsub("\"","@@@"))
  else
   check=json.decode(check)
   for i, v in pairs(check) do
    if (check[i].alt=="" and check[i].s=="") then check[i]=nil end
   end
   check=json.encode(check)
   db.setStringValue("wp_settings", check:gsub("\"","@@@"))
  end
 end
 wp_settings_init()

--MAIN MENU
 if not screenState then screenState=0 end
 --MENU FUNCTIONS
  function menu_time_calculator()
   ScreenSelection=""
   time_to_go=[[""]]
   screenState=1
  end

  function menu_from(from)
   ScreenSelection=""
   if (screenState==0 or screenState==6) then
    if from then ent_from_wp(from) else screenState=2 end
   else screenState=2 end
  end

  function menu_destination(dest)
   if dest==nil then dest="" end
   ScreenSelection=""
   if (screenState==0 or screenState==6 or screenState==15) and dest~="" then
    if dest~="" then ent_to_wp(dest) end
   elseif (screenState==14 and dest~="") then
    local DbKeys=db.getNbKeys()
    for i=1, DbKeys do
     local key="Route"..i
     local data=db.getStringValue(key):gsub("@@@","\"")
     if data~="" then
      data=json.decode(data)
      if data.name==dest then
       for i=1, #routes_list do
        if routes_list[i].route==dest then
         selected_route_id=routes_list[i].id
         break
        end
       end
       selected_route_name=dest
       selected_route_page_index=1
       wp_tick_={}
       wp_tick_n=1
       wp_tick_[1]=">"
       WpTickList=json.encode(wp_tick_)
       first_wp_selected=false
       next_wp_selected=false
       screenState=15
       break
      end
     end
    end
   else
    screenState=3
   end
  end

  function menu_PE_targe_alt()
   target_alt_warning=""
   screenState=4
  end

  function menu_settings()
   if screenState==0 then ScreenOrigin=0 end
   if (screenState==0 or screenState==15) then
    edit_wp=nil

    if (screenState==15 and status_TO=="TO") then
     for i, v in pairs(WpRouteList) do
      if string.find(v, "To ") then UserSelectedWp="WpID "..i end
     end
     local WpID=ScreenSelection:gsub("WpID ", "")
     WpID=tonumber(WpID)
     if WpID==nil then edit_wp=nil
     else ScreenSelection=WpRouteList[WpID]:gsub("To ", "") end
    end

    for i=1, #wp_list do
     if wp_list[i].name==ScreenSelection then edit_wp=wp_list[i].id break end
    end

    if edit_wp~=nil then
     screenState=16
     wp_altitude_tick=">"
     wp_speed_tick=""
     wp_altitude_inserted=true
     wp_speed_inserted=true
     for x=1, #wp_list do
      if wp_list[x].id==edit_wp then
       local wp_id=wp_list[x].wp
       edit_wp=db.getStringValue(wp_id)
       break
      end
     end
     local ext=db.getStringValue("wp_settings"):gsub("@@@","\"")
     ext=json.decode(ext)
     if ext[edit_wp] then
      keypad_input_wp_altitude=ext[edit_wp].alt
      keypad_input_wp_speed=ext[edit_wp].s
     else
      keypad_input_wp_altitude=""
      keypad_input_wp_speed=""
     end
    elseif (ScreenSelection=="HOLD" or ScreenSelection=="hold") then
     screenState=5
     MTOW_tick=""
     autobrake_tick=""
     wp_dist_tick=""
     holding_tick=">"
    else 
     if (routing_timer and screenState==15) then
      for i=1, #WpRouteList do
       if string.find(WpRouteList[i], "To ") then UserSelectedWp="WpID "..i end
      end
     end
     screenState=9
     ScreenSelection=""
    end

   elseif (routing_timer and screenState==16) then screenState=15
   elseif (routing_timer and screenState==9) then screenState=15
   elseif (routing_timer and screenState==5) then screenState=15
   elseif (ScreenOrigin==0 and screenState==16) then screenState=0
    ScreenOrigin=""
    ScreenSelection=""
    screenState=0
   else screenState=9 end
  end

  function menu_wp_atlas()
   ScreenSelection=""
   if screenState==6 then
    screenState=0
    wp_atlas="wp"
    wp_page_index=1
   elseif screenState==0 then
    screenState=6
    wp_atlas="atlas"
    atlas_page_index=1
   elseif wp_atlas=="wp" then
    screenState=0
   elseif wp_atlas=="atlas" then
    screenState=6
   end
  end

 --MENU BUTTONS
  function menu(x)
   if x==nil then KeyLabel="WP/ATLAS" screenState=6 else KeyLabel=x end
   if KeyLabel=="Time Calculator" then menu_time_calculator()
   elseif KeyLabel=="From" then menu_from(ScreenSelection)
   elseif KeyLabel=="Destination" then menu_destination(ScreenSelection)
   elseif KeyLabel=="AD/RN WP" then add_wp()
   elseif KeyLabel=="CLR WP" then clr_wp(ScreenSelection)
   elseif KeyLabel=="WP/ATLAS" then menu_wp_atlas()
   elseif KeyLabel=="INV Route" then invert_route()
   elseif KeyLabel=="Settings" then menu_settings()
   elseif KeyLabel=="PE Target Altitude" then menu_PE_targe_alt()
   elseif KeyLabel=="Shield" then
    if shield then
     screenState=17
     local ResistanceTable=shield.getResistances()
     Ran=tonumber(string.format("%.0f", (ResistanceTable[1]*100)+10))
     Rel=tonumber(string.format("%.0f", (ResistanceTable[2]*100)+10))
     Rki=tonumber(string.format("%.0f", (ResistanceTable[3]*100)+10))
     Rth=tonumber(string.format("%.0f", (ResistanceTable[4]*100)+10))
     unit.setTimer("shield", 1)
     shieldFunction()
    end
   elseif KeyLabel=="AGG" then
    screenState=13
    agg_tick_1=""   
    agg_tick_input=""
    agg_tick_3=""
    keypad_input_agg_target_alt=db.getIntValue("agg_t_alt")
    agg_target_altitude=true
    unit.setTimer("agg", 1)
   end
   if init_menu then LuaScreen() else init_menu=true end
  end
  menu(Menu_First_Page)

--DATABANK CLEANING
 function databank_clean(wp, settings, id, colors, dmg)
  local store_db_wp={}
  local stored_db_route={}
  local stored_db_wpsettings={}
  local settings_list={}
  local id_list={}
  local colors_list={}
  local dmg_list={}
  local item_cleared=""

  if wp==true then
   local dbn=db.getNbKeys()
   local counter=0
   for i=1, dbn do
    local key="wp"..i
    local value=db.getStringValue(key)
    local key_coord="wp"..i.."_coord"
    local value_coord=db.getStringValue(key_coord)
    if (value~="" and value_coord~="") then
     counter=counter +1
     local new_key="wp"..counter
     local new_key_coord="wp"..counter.."_coord"
     store_db_wp[counter]={["key"]=new_key, ["value"]=value, ["key_coord"]=new_key_coord, ["value_coord"]=value_coord}
    end
   end

   stored_db_route={}
   local counter=0
   for x=1, dbn do
    local route_id="Route"..x
    local data=db.getStringValue(route_id):gsub("@@@","\"")
    data=json.decode(data)
    if data then
     if (data.wp1~=nil or data.wp1~="") then
      counter=counter +1
      local name=data.name
      stored_db_route[name]={}
      local x=-1
      for i, v in pairs(data) do x=x +1 end
      for y=1, x do
       local wp_id="wp"..y
       local wp=data[wp_id]
       if wp~=nil then
        table.insert(stored_db_route[name], y, wp)
       end
      end
     end
    end
   end

   stored_db_wpsettings={}
   local counter=0
   local data=db.getStringValue("wp_settings"):gsub("@@@","\"")
   data=json.decode(data)
   if data then
    for i, v in pairs(data) do
     if (data[i].alt~=nil or data[i].alt~="" or data[i].s~=nil or data[i].s~="") then
      counter=counter +1
      local name=i
      local alt=data[i].alt
      local s=data[i].s
      stored_db_wpsettings[counter]={["name"]=name,["alt"]=alt,["s"]=s}
     end
    end
   end
  else
   item_cleared=item_cleared.."(1)"
  end

  if settings==true then
   local name="navigator_MTOW"
   local value=db.getFloatValue("navigator_MTOW")
   settings_list[1]={["name"]=name, ["value"]=value}
   name="navigator_autobrake"
   value=db.getFloatValue("navigator_autobrake")
   settings_list[2]={["name"]=name, ["value"]=value}
   name="navigator_wpdist"
   value=db.getFloatValue("navigator_wpdist")
   settings_list[3]={["name"]=name, ["value"]=value}
   name="holding_speed"
   value=db.getFloatValue("holding_speed")
   settings_list[4]={["name"]=name, ["value"]=value}
  else
   keypad_input_MTOW=factory_MTOW/1000
   keypad_input_autobrake=factory_autobrake
   keypad_input_wpdist=wp_sequencing_distance
   keypad_input_holding=holding_speed
   item_cleared=item_cleared.."(2)"
  end

  if id==true then
   local name="Ship ID"
   local value=db.getStringValue("Ship ID")
   id_list[1]={["name"]=name, ["value"]=value}
  else
   keypad_input_shipid=""
   item_cleared=item_cleared.."(3)"
  end

  if colors==true then
   local name="SCRTableColor"
   local value=db.getStringValue("SCRTableColor")
   colors_list[1]={["name"]=name, ["value"]=value}
   name="SCRFontTitle"
   value=db.getStringValue("SCRFontTitle")
   colors_list[2]={["name"]=name, ["value"]=value}
   name="SCRFontColor"
   value=db.getStringValue("SCRFontColor")
   colors_list[3]={["name"]=name, ["value"]=value}
   name="SCRButtonPressed"
   value=db.getStringValue("SCRButtonPressed")
   colors_list[4]={["name"]=name, ["value"]=value}
   name="SCRButtonColor"
   value=db.getStringValue("SCRButtonColor")
   colors_list[5]={["name"]=name, ["value"]=value}
  else
   Table_RGB="0,0,255"
   db.setStringValue("SCRTableColor", "{0,0,255}")
   Title_RGB="255,255,0"
   db.setStringValue("SCRFontTitle", "{255,255,0}")
   Font_RGB="217,217,217"
   db.setStringValue("SCRFontColor", "{217,217,217}")
   Button_Pressed_RGB="0,0,255"
   db.setStringValue("SCRButtonColor", "{0,0,255}")
   Button_RGB="255,0,0"
   db.setStringValue("SCRButtonPressed", "{255,0,0}")
   item_cleared=item_cleared.."(4)"
  end

  if dmg==true then
   local name="DMG Scale"
   local value=db.getFloatValue("DMG Scale")
   dmg_list[1]={["name"]=name, ["value"]=value}
   name="DMG TV U/D"
   value=db.getFloatValue("DMG TV U/D")
   dmg_list[2]={["name"]=name, ["value"]=value}
   name="DMG TV L/R"
   value=db.getFloatValue("DMG TV L/R")
   dmg_list[3]={["name"]=name, ["value"]=value}
   name="DMG SV U/D"
   value=db.getFloatValue("DMG SV U/D")
   dmg_list[4]={["name"]=name, ["value"]=value}
   name="DMG SV L/R"
   value=db.getFloatValue("DMG SV L/R")
   dmg_list[5]={["name"]=name, ["value"]=value}
  else
   keypad_input_dmg1=3
   DMG_REP_TOP_VIEW_Up_Down=-20
   DMG_REP_TOP_VIEW_LH_RH=30
   DMG_REP_SIDE_VIEW_Up_Down=40
   DMG_REP_SIDE_VIEW_LH_RH=100
   item_cleared=item_cleared.."(5)"
  end

  db.clear()
  system.print("CLEARING DATABANK")
  databank_initialization()
  system.print("REGENERATING DATABANK, KEYS: "..db.getNbKeys())

  if wp==true then
   local id=0
   local restore_data={}
   local route_id=""
   for i=1, #store_db_wp do
    db.setStringValue(store_db_wp[i].key, store_db_wp[i].value)
    db.setStringValue(store_db_wp[i].key_coord, store_db_wp[i].value_coord)
   end
   table.sort(stored_db_route)
   for i, v in pairs(stored_db_route) do
    id=id +1
    route_id="Route"..id
    restore_data={["name"]=i}
    for k, f in pairs(stored_db_route[i]) do
     local wp_id="wp"..k
     restore_data[wp_id]=f
    end
    restore_data=json.encode(restore_data)
    db.setStringValue(route_id, restore_data:gsub("\"","@@@"))
   end

   if stored_db_wpsettings then
    restore_data={}
    for i=1, #stored_db_wpsettings do
     local name=stored_db_wpsettings[i].name
     local alt=stored_db_wpsettings[i].alt
     local s=stored_db_wpsettings[i].s
     restore_data[name]={["alt"]=alt,["s"]=s}
    end
    restore_data=json.encode(restore_data)
    db.setStringValue("wp_settings", restore_data:gsub("\"","@@@"))
   end
  end

  if settings==true then
   for i=1, #settings_list do
    db.setFloatValue(settings_list[i].name, settings_list[i].value)
   end
  end

  if id==true then
   for i=1, #id_list do
    db.setStringValue(id_list[i].name, id_list[i].value)
   end
  end

  if colors==true then
   for i=1, #colors_list do
    db.setStringValue(colors_list[i].name, colors_list[i].value)
   end
  end

  if dmg==true then
   for i=1, #dmg_list do
    db.setFloatValue(dmg_list[i].name, dmg_list[i].value)
   end
  end

  wp_settings_init()

  reset_db_status="CLEARED: "..item_cleared
  reset_db_status2="Restart The Interface"
  system.print("DATABANK REGENERATED, KEYS: "..db.getNbKeys())

  screenState=12
  LuaScreen()
 end

--DATA STATUS
 ship_id=""
 status_FM=""
 status_TO=""
 status_TA=""
 local ship_id_verified=false

 if (db.getStringValue("databank_verification")=="Verified") then
  db.clearValue("")
  ship_id=db.getStringValue("Ship ID")
 end
 if (ship_id=="n/a" or ship_id=="") then ShipIdCheck=false else ShipIdCheck=true end

--KEYPAD ADD DIGITS
 function insert_keys(new_digit) --set rules
  --TIME CALCULATOR PAGE
   if (screenState==1 and (tonumber(new_digit)~=nil or new_digit==".")) then
    if keypad_input_su==[[""]] then
     keypad_input_su=nil
     db.setFloatValue("navigator_distance", "n/a")
     su_distance_inserted=false
    end

    if time_to_go==[["Speed Is Invalid"]] then
     keypad_input_speed=nil
     db.setFloatValue("navigator_speed", "0")
     time_to_go=[[""]]
     db.setFloatValue("navigator_eta_h", 0)
     db.setFloatValue("navigator_eta_m", 0)
     db.setFloatValue("navigator_eta_s", 0)
    end

    if (su_distance_inserted==true and speed_inserted==true) or (keypad_input_speed==[[""]]) then
     keypad_input_speed=nil
     db.setFloatValue("navigator_speed", "0")
     speed_inserted=false
     time_to_go=[[""]]
     db.setFloatValue("navigator_eta_h", 0)
     db.setFloatValue("navigator_eta_m", 0)
     db.setFloatValue("navigator_eta_s", 0)
    end

    if su_distance_inserted==false then
     keypad_input=keypad_input_su
     keypad_input_su=add_digit(new_digit, keypad_input)
    elseif speed_inserted==false then
     keypad_input=keypad_input_speed
     keypad_input_speed=add_digit(new_digit, keypad_input)
    end
   end

  --FROM PAGE
   if screenState==2 then
    if (FROM_tick==">" and from_inserted==true or keypad_input_from=="No Previous Point") then
     keypad_input_from=nil
     db.setStringValue("navigator_from", "no From")
     from_inserted=false
     status_FM=""
     from_coordinates=""
     db.setStringValue("navigator_from_coordinates", "n/a")
    end

    if from_inserted==false then
     keypad_input=keypad_input_from
     keypad_input_from=add_digit(new_digit, keypad_input)
    elseif (from_inserted==true and WPADD_tick==">"   ) then
     keypad_input=keypad_input_wpname
     keypad_input_wpname=add_digit(new_digit, keypad_input)
    end
   end

  --DESTINATION PAGE
   if screenState==3 then
    if (destination_coord=="Not Present In Databank" or destination_inserted==true or keypad_input_dest=="No Previous Point") then
     keypad_input_dest=nil
     db.setStringValue("navigator_target_destination", "no Dest.")
     destination_inserted=false
     status_TO=""
     distance_to_go=""
     destination_coord=""
     db.setStringValue("navigator_coordinates", "n/a")
    end
    keypad_input=keypad_input_dest
    keypad_input_dest=add_digit(new_digit, keypad_input)
   end

  --TARGET PE ALTITUDE PAGE
   if screenState==4 then
    if (target_alt_warning=="Warning Altitude Too Low" or target_pe_altitude_inserted==true or target_alt_warning=="Invalid Input") then
     keypad_input_pe_target_alt=nil
     target_pe_altitude_inserted=false
     status_TA=""
     target_alt_warning=""
    else
     keypad_input_pe_target_alt=keypad_input_pe_target_alt
    end

    if tonumber(new_digit)~=nil then
     keypad_input=keypad_input_pe_target_alt
     keypad_input_pe_target_alt=add_digit(new_digit, keypad_input)
    end
   end

  --AGG
   if (screenState==13 and agg_tick_input==">") then
    if (agg_target_altitude==true and tonumber(new_digit)~=nil) then
     keypad_input_agg_target_alt=""
     agg_target_altitude=false
    end

    if tonumber(new_digit)~=nil then
     keypad_input=keypad_input_agg_target_alt
     keypad_input_agg_target_alt=add_digit(new_digit, keypad_input)
    end
   end

  --SETTINGS PAGE
   if (screenState==5 and (tonumber(new_digit)~=nil or new_digit==".")) then  --(Ship Settings)
    if (MTOW_inserted==true and MTOW_tick==">") then
     keypad_input_MTOW=""
     MTOW_inserted=false
    elseif (autobrake_stops_at_inserted==true and autobrake_tick==">") then
     keypad_input_autobrake=""
     autobrake_stops_at_inserted=false
    elseif (wp_dist_inserted==true and wp_dist_tick==">") then
     keypad_input_wpdist=""
     wp_dist_inserted=false
    elseif (holding_speed_inserted==true and holding_tick==">") then
     keypad_input_holding=""
     holding_speed_inserted=false
    end
    if MTOW_inserted==false then
     keypad_input=keypad_input_MTOW
     keypad_input_MTOW=add_digit(new_digit, keypad_input)
    elseif autobrake_stops_at_inserted==false then
     keypad_input=keypad_input_autobrake
     keypad_input_autobrake=add_digit(new_digit, keypad_input)
    elseif wp_dist_inserted==false then
     keypad_input=keypad_input_wpdist
     keypad_input_wpdist=add_digit(new_digit, keypad_input)
    elseif holding_speed_inserted==false then
     keypad_input=keypad_input_holding
     keypad_input_holding=add_digit(new_digit, keypad_input)
    end
   elseif screenState==7 then --(WP Store)
    if wp_name_tick==">" then
     keypad_input=keypad_input_wp_name
     keypad_input_wp_name=add_digit(new_digit, keypad_input)
    elseif wp_lat_tick==">" then
     keypad_input=keypad_input_wp_lat
     keypad_input_wp_lat=add_digit(new_digit, keypad_input)
    elseif wp_lon_tick==">" then
     keypad_input=keypad_input_wp_lon
     keypad_input_wp_lon=add_digit(new_digit, keypad_input)
    elseif wp_alt_tick==">" then
     keypad_input=keypad_input_wp_alt
     keypad_input_wp_alt=add_digit(new_digit, keypad_input)
    end
   elseif screenState==8 then --(WP Sync)
    if shipid_tick==">" then
     keypad_input=keypad_input_shipid
     keypad_input_shipid=add_digit(new_digit, keypad_input)
    end
   elseif screenState==10 then --(Screen Colors)
    if (tick_color_1==">" and (keypad_input_color1=="Insert RGB" or RGBColor1==true)) then
     keypad_input_color1=""
     RGBColor1=false
    elseif (tick_color_2==">" and (keypad_input_color2=="Insert RGB" or RGBColor2==true)) then
     keypad_input_color2=""
     RGBColor2=false
    elseif (tick_color_3==">" and (keypad_input_color3=="Insert RGB" or RGBColor3==true)) then
     keypad_input_color3=""
     RGBColor3=false
    elseif (tick_color_4==">" and (keypad_input_color4=="Insert RGB" or RGBColor4==true)) then
     keypad_input_color4=""
     RGBColor4=false
    elseif (tick_color_5==">" and (keypad_input_color5=="Insert RGB" or RGBColor5==true)) then
     keypad_input_color5=""
     RGBColor5=false
    end
    if tick_color_1==">" then
     RGBColor1=false
     keypad_input=keypad_input_color1
     keypad_input_color1=add_digit(new_digit, keypad_input)
    elseif tick_color_2==">" then
     RGBColor2=false
     keypad_input=keypad_input_color2
     keypad_input_color2=add_digit(new_digit, keypad_input)
    elseif tick_color_3==">" then
     RGBColor3=false
     keypad_input=keypad_input_color3
     keypad_input_color3=add_digit(new_digit, keypad_input)
    elseif tick_color_4==">" then
     RGBColor4=false
     keypad_input=keypad_input_color4
     keypad_input_color4=add_digit(new_digit, keypad_input)
    elseif tick_color_5==">" then
     RGBColor5=false
     keypad_input=keypad_input_color5
     keypad_input_color5=add_digit(new_digit, keypad_input)
    end
   elseif screenState==16 then --(WP Setting)
    if (wp_altitude_inserted==true and wp_altitude_tick==">") then
     keypad_input_wp_altitude=""
     wp_altitude_inserted=false
    elseif (wp_speed_inserted==true and wp_speed_tick==">") then
     keypad_input_wp_speed=""
     wp_speed_inserted=false
    end
    if (wp_altitude_inserted==false and wp_altitude_tick==">") then
     keypad_input=keypad_input_wp_altitude
     keypad_input_wp_altitude=add_digit(new_digit, keypad_input)
    elseif (wp_speed_inserted==false and wp_speed_tick==">") then
     keypad_input=keypad_input_wp_speed
     keypad_input_wp_speed=add_digit(new_digit, keypad_input)
    end
   end
 end

 function add_digit(new_digit, keypad_input) --concatenate digits
  if keypad_input then
   return tostring(keypad_input) .. tostring(new_digit)
  else
   return new_digit
  end
 end

--KEYPAD NUMBERS
 if CAPS==nil then CAPS=true end
 function keypad_numbers()
  local new_digit=""
  if KeyLabel=="1" then new_digit=1
  elseif KeyLabel=="2" then new_digit=2
  elseif KeyLabel=="3" then new_digit=3
  elseif KeyLabel=="4" then new_digit=4
  elseif KeyLabel=="5" then new_digit=5
  elseif KeyLabel=="6" then new_digit=6
  elseif KeyLabel=="7" then new_digit=7
  elseif KeyLabel=="8" then new_digit=8
  elseif KeyLabel=="9" then new_digit=9
  elseif KeyLabel=="0" then new_digit=0
  elseif KeyLabel=="CLR" then clr_button()
  elseif KeyLabel=="ENT" then ent_button()
  elseif KeyLabel=="." then
   if screenState==10 then new_digit="," else new_digit="." end
  elseif KeyLabel=="-" then new_digit="-0"
  elseif KeyLabel=="arrowup" then small_arrow_up()
  elseif KeyLabel=="arrowdn" then small_arrow_down()
  elseif KeyLabel=="arrowUP" then big_arrow_up()
  elseif KeyLabel=="arrowDN" then big_arrow_down()
  elseif KeyLabel=="CAPS" then
   if CAPS then CAPS=false else CAPS=true end
  end
  if new_digit~="" then insert_keys(new_digit) end
  LuaScreen()
 end

--KEYPAD LETTERS
 function keypad_letters()
  local new_digit=""
  if KeyLabel=="A" then new_digit="A"
  elseif KeyLabel=="B" then new_digit="B"
  elseif KeyLabel=="C" then new_digit="C"
  elseif KeyLabel=="D" then new_digit="D"
  elseif KeyLabel=="E" then new_digit="E"
  elseif KeyLabel=="F" then new_digit="F"
  elseif KeyLabel=="G" then new_digit="G"
  elseif KeyLabel=="H" then new_digit="H"
  elseif KeyLabel=="I" then new_digit="I"
  elseif KeyLabel=="J" then new_digit="J"
  elseif KeyLabel=="K" then new_digit="K"
  elseif KeyLabel=="L" then new_digit="L"
  elseif KeyLabel=="M" then new_digit="M"
  elseif KeyLabel=="N" then new_digit="N"
  elseif KeyLabel=="O" then new_digit="O"
  elseif KeyLabel=="P" then new_digit="P"
  elseif KeyLabel=="Q" then new_digit="Q"
  elseif KeyLabel=="R" then new_digit="R"
  elseif KeyLabel=="S" then new_digit="S"
  elseif KeyLabel=="T" then new_digit="T"
  elseif KeyLabel=="U" then new_digit="U"
  elseif KeyLabel=="V" then new_digit="V"
  elseif KeyLabel=="W" then new_digit="W"
  elseif KeyLabel=="X" then new_digit="X"
  elseif KeyLabel=="Y" then new_digit="Y"
  elseif KeyLabel=="Z" then new_digit="Z"
  elseif KeyLabel=="_" then new_digit="_"
  elseif KeyLabel=="moon" then new_digit="_moon_"
  elseif KeyLabel=="a" then new_digit="a"
  elseif KeyLabel=="b" then new_digit="b"
  elseif KeyLabel=="c" then new_digit="c"
  elseif KeyLabel=="d" then new_digit="d"
  elseif KeyLabel=="e" then new_digit="e"
  elseif KeyLabel=="f" then new_digit="f"
  elseif KeyLabel=="G" then new_digit="g"
  elseif KeyLabel=="h" then new_digit="h"
  elseif KeyLabel=="i" then new_digit="i"
  elseif KeyLabel=="j" then new_digit="j"
  elseif KeyLabel=="k" then new_digit="k"
  elseif KeyLabel=="l" then new_digit="l"
  elseif KeyLabel=="m" then new_digit="m"
  elseif KeyLabel=="n" then new_digit="n"
  elseif KeyLabel=="o" then new_digit="o"
  elseif KeyLabel=="p" then new_digit="p"
  elseif KeyLabel=="q" then new_digit="q"
  elseif KeyLabel=="r" then new_digit="r"
  elseif KeyLabel=="s" then new_digit="s"
  elseif KeyLabel=="t" then new_digit="t"
  elseif KeyLabel=="u" then new_digit="u"
  elseif KeyLabel=="v" then new_digit="v"
  elseif KeyLabel=="w" then new_digit="w"
  elseif KeyLabel=="x" then new_digit="x"
  elseif KeyLabel=="y" then new_digit="y"
  elseif KeyLabel=="z" then new_digit="z"
  end
  insert_keys(new_digit)
  LuaScreen()
 end

--BUTTON FUNCTIONS
 --ADD/RENAME WP BUTTON
  function add_wp()
   ScreenSelection=""
   if (screenState==2 and keypad_input_from=="PPOS" and keypad_input_wpname~="") then
    wp_check()
    screenState=2
   elseif (screenState==2 and keypad_input_from~="" and keypad_input_wpname~="") then
    db.setStringValue(wp_id_rename, keypad_input_wpname)
    stored="WP RENAMED"
    local ext=db.getStringValue("wp_settings"):gsub("@@@","\"")
    ext=json.decode(ext)
    if ext[keypad_input_from] then
     ext[keypad_input_wpname]={["alt"]=ext[keypad_input_from].alt,["s"]=ext[keypad_input_from].s}
     ext=json.encode(ext)
     db.setStringValue("wp_settings", ext:gsub("\"","@@@"))
    end
    screenState=2
   elseif (screenState==7 and wp_name_inserted==true and wp_lat_inserted==true and wp_lon_inserted==true and wp_alt_inserted==true and (wp_name_tick==">" or wp_lat_tick==">" or wp_lon_tick==">" or wp_alt_tick==">")) or (LuaWp and LuaWpName and LuaSavingWp) then
    keypad_input_wpname=keypad_input_wp_name
    if (wp_selected_planet~="Invalid Entry" and wp_selected_planet~="World Coordinates" and wp_coordinated_stored~="") then from_coordinates=coord_converter()
    else from_coordinates=vec3(tonumber(keypad_input_wp_lat),tonumber(keypad_input_wp_lon),tonumber(keypad_input_wp_alt)) end
    wp_check()
    if stored=="WP Name Already Exist" then screenState=7
    else screenState=0 end
   end
  end

 --CLR WP BUTTON
  function clr_wp(clr)
   ScreenSelection=""
   if (clr~="" and screenState==0) then
    local wp_name=clr
    for x=1, #wp_list do
     if wp_list[x].name==wp_name then
      local wp_del=wp_list[x].wp
      db.clearValue(wp_del)
      db.clearValue(wp_del.."_coord")
      local ext=db.getStringValue("wp_settings"):gsub("@@@","\"")
      ext=json.decode(ext)
      ext[wp_name]=nil
      ext=json.encode(ext)
      db.setStringValue("wp_settings", ext:gsub("\"","@@@"))
      break
     end
    end
   elseif screenState==14 then
    if route_tick_[route_tick_n]==">" then
     local RouteName=clr
     local dbn=db.getNbKeys()
     for i=1, dbn do
      local RouteID="Route"..i
      local data=db.getStringValue(RouteID):gsub("@@@","\"")
      if data~="" then
       data=json.decode(data)
       if data.name==RouteName then db.setStringValue(RouteID, "") break end
      end
     end
    elseif route_tick_[route_tick_n]=="*" then
     local route_id=routes_list[route_tick_n]
     if (route_id~=nil and route_id~="") then
      route_id=routes_list[route_tick_n].id
      local data=db.getStringValue(route_id):gsub("@@@","\"")
      data=json.decode(data)
      local wp_id="wp"..wp_tick_n
      data[wp_id]=""

      local RefreshList={}
      for i, v in pairs(data) do
       if (v~=nil and v~="") then RefreshList[i]=v end
      end

      local RebuildList={}
      RebuildList["name"]=RefreshList["name"]
      local WpNb=0
      for i, v in pairs(RefreshList) do
       local WpNb2=0
       if string.find(i, "wp") then
        local x=i:gsub("wp", "")
        WpNb2=tonumber(x)
       end
       if WpNb2>WpNb then WpNb=WpNb2 end
      end

      for i=1, WpNb do
       local WpID="wp"..i
       if RefreshList[WpID]==nil then RebuildList[WpID]=""
       else RebuildList[WpID]=RefreshList[WpID] end
      end

      data=RebuildList
      data=json.encode(data)
      db.setStringValue(route_id, data:gsub("\"","@@@"))
     end
    end
   end
  end

 --BIG ARROW UP
  function big_arrow_up()
   if screenState==0  then      --wp page up
    if wp_page_index>1 then
     wp_page_index=wp_page_index -1
    end
   elseif screenState==6 then    --atlas page up
    if atlas_page_index>1 then
     atlas_page_index=atlas_page_index -1
    end
   end

   if screenState==14 then   --settings7
    if route_tick_[route_tick_n]~="*" then
     if routes_page_index>1 then
      routes_page_index=routes_page_index -1
      route_tick_n=(routes_page_index*5)-4
      local x=generating_wp_pages("14routes")
      for i=1, x do route_tick_[i]="" end
      route_tick_[route_tick_n]=">"
      RouteTickList=json.encode(route_tick_)
     else
      routes_page_index=1
     end
    else
     if routes_wp_page_index>1 then
      routes_wp_page_index=routes_wp_page_index -1
      wp_tick_n=(routes_wp_page_index*5)-4
      local x=generating_wp_pages("14wp")*5
      for i=1, x do wp_tick_[i]="" end
      wp_tick_[wp_tick_n]=">"
      WpTickList=json.encode(wp_tick_)
     else
      routes_wp_page_index=1
     end
    end
   elseif screenState==15 then   --Routing
    if UserSelectedWp=="" then
     unit.stopTimer("routing")
     for i, v in pairs(FullWpList) do
      if string.find(FullWpList[i], "To ") then UserSelectedWp="WpID "..i end
     end
    end
    if selected_route_page_index >=1 then
     if selected_route_page_index==1 then selected_route_page_index=1
     else selected_route_page_index=selected_route_page_index -1 end
     wp_tick_n=(selected_route_page_index*5)-4
     for i=wp_tick_n, wp_tick_n+4 do wp_tick_[i]="" end
     wp_tick_[wp_tick_n]=">"
    end
   end
  end

 --BIG ARROW DOWN
  function big_arrow_down()
   if screenState==0 then       --wp page down
    if wp_page_index<wp_pages then
     wp_page_index=wp_page_index +1
    end
   elseif screenState==6 then    --atlas page down
    if atlas_page_index<atlas_pages then
     atlas_page_index=atlas_page_index +1
    end
   end

   if screenState==14 then     --settings7
    if route_tick_[route_tick_n]~="*" then
     if routes_page_index<routes_pages then
      routes_page_index=routes_page_index +1
      route_tick_n=(routes_page_index*5)-4
      local x=generating_wp_pages("14routes")
      for i=1, x do route_tick_[i]="" end
      route_tick_[route_tick_n]=">"
      RouteTickList=json.encode(route_tick_)
     else routes_page_index=routes_pages end
    else
     if routes_wp_page_index<routes_wp_pages then
      routes_wp_page_index=routes_wp_page_index +1
      wp_tick_n=(routes_wp_page_index*5)-4
      local x=generating_wp_pages("14wp")*5
      for i=1, x do wp_tick_[i]="" end
      wp_tick_[wp_tick_n]=">"   
     else routes_wp_page_index=routes_wp_pages end
    end
   elseif screenState==15 then --Routing
    if UserSelectedWp=="" then
     for i, v in pairs(FullWpList) do
      if string.find(FullWpList[i], "To ") then UserSelectedWp="WpID "..i end
     end
    end
    if selected_route_page_index<selected_route_pages then
     selected_route_page_index=selected_route_page_index +1
     wp_tick_n=(selected_route_page_index*5)-4
     for i=wp_tick_n, wp_tick_n+4 do wp_tick_[i]="" end
     wp_tick_[wp_tick_n]=">"
     unit.stopTimer("routing")
    else selected_route_page_index=selected_route_pages end
   end
  end

 --SMALL ARROW UP
  function small_arrow_up()
   if screenState==5 then      --(Ship Settings)
    if holding_tick==">" then holding_tick="" wp_dist_tick=">"
    elseif wp_dist_tick==">" then wp_dist_tick="" autobrake_tick=">"
    elseif autobrake_tick==">" then autobrake_tick="" MTOW_tick=">"
    end
   elseif screenState==7 then  --(WP Store)
    if wp_lat_tick==">" then wp_name_tick=">" wp_lat_tick=""
    elseif wp_lon_tick==">" then wp_lat_tick=">" wp_lon_tick=""
    elseif wp_alt_tick==">" then wp_lon_tick=">" wp_alt_tick=""
    end
   elseif screenState==8 then  --(WP Sync)
    if up_sync_tick==">" then up_sync_tick="" dwn_sync_tick=">"
    elseif dwn_sync_tick==">" then dwn_sync_tick="" shipid_tick=">"
    end
   elseif screenState==10 then --(Screen Colors)
    if tick_color_5==">" then tick_color_5="" tick_color_4=">"
    elseif tick_color_4==">" then tick_color_4="" tick_color_3=">"
    elseif tick_color_3==">" then tick_color_3="" tick_color_2=">"
    elseif tick_color_2==">" then tick_color_2="" tick_color_1=">"
    end
   elseif screenState==11 then --(DMG Rep.)
    if tick_dmg_2==">" then tick_dmg_2="" tick_dmg_1=">" end
   elseif screenState==12 then --(DB Reset)
    if tick_[5]==">" then tick_[5]="" tick_[4]=">"
    elseif tick_[4]==">" then tick_[4]="" tick_[3]=">"
    elseif tick_[3]==">" then tick_[3]="" tick_[2]=">"
    elseif tick_[2]==">" then tick_[2]="" tick_[1]=">"
    end
   elseif screenState==14 then --(Routes)
    if route_tick_[route_tick_n]~="*" then
     route_tick_n=route_tick_n -1
     if route_tick_n<route_tick_index then route_tick_n=route_tick_index end
     route_tick_[route_tick_n+1]=""
     route_tick_[route_tick_n]=">"
    else
     wp_tick_n=wp_tick_n -1
     if wp_tick_n<wp_tick_index then wp_tick_n=wp_tick_index end
     wp_tick_[wp_tick_n +1]=""
     wp_tick_[wp_tick_n]=">"
     WpTickList=json.encode(wp_tick_)
    end
    RouteTickList=json.encode(route_tick_)
   elseif screenState==16 then --(WP Setting)
    if wp_speed_tick==">" then wp_speed_tick="" wp_altitude_tick=">" end
   end
  end

 --SMALL ARROW DOWN
  function small_arrow_down()
   if screenState==5 then      --(Ship Settings)
    if MTOW_tick==">" then MTOW_tick="" autobrake_tick=">"
    elseif autobrake_tick==">" then autobrake_tick="" wp_dist_tick=">"
    elseif wp_dist_tick==">" then wp_dist_tick="" holding_tick=">"
    end
   elseif screenState==7 then  --(WP Store)
    if wp_name_tick==">" then wp_name_tick="" wp_lat_tick=">"
    elseif wp_lat_tick==">" then wp_lat_tick="" wp_lon_tick=">"
    elseif wp_lon_tick==">" then wp_lon_tick="" wp_alt_tick=">"
    end
   elseif screenState==8 then  --(WP Sync)
    if shipid_tick==">" then shipid_tick="" dwn_sync_tick=">"
    elseif dwn_sync_tick==">" then dwn_sync_tick="" up_sync_tick=">"
    end
   elseif screenState==10 then --(Screen Colors)
    if tick_color_1==">" then tick_color_1="" tick_color_2=">"
    elseif tick_color_2==">" then tick_color_2="" tick_color_3=">"
    elseif tick_color_3==">" then tick_color_3="" tick_color_4=">"
    elseif tick_color_4==">" then tick_color_4="" tick_color_5=">"
    end
   elseif screenState==11 then --(DMG Rep.)
    if tick_dmg_1==">" then tick_dmg_1="" tick_dmg_2=">" end
   elseif screenState==12 then --(DB Reset)
    if tick_[1]==">" then tick_[1]="" tick_[2]=">"
    elseif tick_[2]==">" then tick_[2]="" tick_[3]=">"
    elseif tick_[3]==">" then tick_[3]="" tick_[4]=">"
    elseif tick_[4]==">" then tick_[4]="" tick_[5]=">"
    end
   elseif screenState==14 then --(Routes)
    if route_tick_[route_tick_n]~="*" then
     route_tick_n=route_tick_n +1
     if route_tick_n>(route_tick_index +4) then route_tick_n=(route_tick_index +4) end
     route_tick_[route_tick_n-1]=""
     route_tick_[route_tick_n]=">"
    else
     wp_tick_n=wp_tick_n +1
     if wp_tick_n>(wp_tick_index +4) then wp_tick_n=(wp_tick_index +4) end
     wp_tick_[wp_tick_n -1]=""
     wp_tick_[wp_tick_n]=">"
     WpTickList=json.encode(wp_tick_)
    end
    RouteTickList=json.encode(route_tick_)
   elseif screenState==16 then --(WP Setting)
    if wp_altitude_tick==">" then wp_altitude_tick="" wp_speed_tick=">" end
   end
  end

 --ENT BUTTON
  function ent_button()
   --ENT Time Calculator
    if screenState==1 then
     if (su_distance_inserted==true and (keypad_input_speed~=[[""]] or keypad_input_speed==[[""]] or tonumber(keypad_input_speed)>0)) then
      local su_num=tonumber(keypad_input_su)
      local speed_num=tonumber(keypad_input_speed)
      if keypad_input_speed==[[""]] then
       if ConstructVel()==0 then
        keypad_input_speed=0
        db.setFloatValue("navigator_speed", 0)
        speed_num=0
        db.setFloatValue("navigator_eta_h", 0)
        db.setFloatValue("navigator_eta_m", 0)
        db.setFloatValue("navigator_eta_s", 0)
        speed_inserted=false
       else
        keypad_input_speed=tostring(ConstructVel())
        speed_num=ConstructVel()
        db.setFloatValue("navigator_speed", speed_num)
        speed_inserted=true
       end
      elseif keypad_input_speed~=[[""]] then
       if tonumber(keypad_input_speed)>MaxSpeed() then keypad_input_speed=math.floor(MaxSpeed()) end
       speed_num=tonumber(keypad_input_speed)
       db.setFloatValue("navigator_speed", speed_num)
      end
      if speed_num==0 then
       time_to_go=[["Speed Is Invalid"]]
       db.setFloatValue("navigator_eta_h", 0)
       db.setFloatValue("navigator_eta_m", 0)
       db.setFloatValue("navigator_eta_s", 0)
       speed_inserted=false
      else
       local time_min=(su_num*200/speed_num*60)
       local time_h  =(time_min/60)
       local time_m  =(time_h - math.floor(time_h))*60
       local time_s  =(time_m - math.floor(time_m))*60
       time_to_go=math.floor(time_h) ..[[ .." h "..]].. math.floor(time_m) ..[[ .." m "..]].. math.floor(time_s) ..[[ .." s"]]
       db.setFloatValue("navigator_eta_h", math.floor(time_h))
       db.setFloatValue("navigator_eta_m", math.floor(time_m))
       db.setFloatValue("navigator_eta_s", math.floor(time_s))
       speed_inserted=true
      end
     elseif (su_distance_inserted==false and keypad_input_su==[[""]] and keypad_input_speed==[[""]]) then
      db.setFloatValue("navigator_distance", "n/a")
     elseif (su_distance_inserted==false and keypad_input_su~=[[""]] and keypad_input_speed==[[""]]) then
      db.setFloatValue("navigator_distance", keypad_input_su)
      su_distance_inserted=true
      su_tick=""
      speed_tick=">"
     end
    end

   --ENT From
    if screenState==2 then
     if (from_inserted==false and keypad_input_from=="") then
      local myPos=ConstructPos()
      keypad_input_from="PPOS"
      db.setStringValue("navigator_from", "PPOS")
      db.setStringValue("from", "PPOS")
      from_coordinates=tostring(myPos)
      db.setStringValue("navigator_from_coordinates", tostring(myPos))
      from_inserted=true
      status_FM="FM"
      FROM_tick=""
      WPADD_tick=">"   
     elseif (from_inserted==false and keypad_input_from~="") then
      from_coordinates_check=false
      for i, v in pairs(atlas[0]) do
       if atlas[0][i].name[1]==keypad_input_from then
        db.setStringValue("navigator_from", atlas[0][i].name[1])
        db.setFloatValue("navigator_from_planet_radius", atlas[0][i].radius)
        db.setStringValue("from", keypad_input_from)
        from_inserted=true
        status_FM="FM"
        from_coordinates=vec3(atlas[0][i].center)
        db.setStringValue("navigator_from_coordinates", tostring(from_coordinates))
        from_coordinates_check=true
        break
       elseif db.hasKey(keypad_input_from) then
        local wp_check=keypad_input_from
        for x=1, #wp_list do 
         if wp_list[x].id==wp_check then
          local wp_id=wp_list[x].wp
          wp_id_rename=wp_id
          keypad_input_from=db.getStringValue(wp_id)
          keypad_input_from_coord=wp_id .."_coord"
          db.setStringValue("navigator_from", keypad_input_from)
          db.setStringValue("from", keypad_input_from)
          db.setFloatValue("navigator_from_planet_radius", 1)
          from_inserted=true
          status_FM="FM"
          from_coordinates=vec3FromStr(db.getStringValue(keypad_input_from_coord))
          db.setStringValue("navigator_from_coordinates", tostring(from_coordinates))
          from_coordinates_check=true
          FROM_tick=""
          WPADD_tick=">"   
          break
         end
        end
       elseif from_coordinates_check==false then
        db.setStringValue("navigator_from", "no From")
        from_inserted=false
        status_FM=""
        from_coordinates="Not Present In Databank"
        db.setStringValue("navigator_from_coordinates", "n/a")
        FROM_tick=">"
        WPADD_tick=""
       end
      end
     end
    end

   --ENT Destination
    if (screenState==3 or screenState==15) then
     if (destination_inserted==false and keypad_input_dest~="") then
      destination_check=false
      for i, v in pairs(atlas[0]) do
       if atlas[0][i].name[1]==keypad_input_dest then
        db.setStringValue("navigator_target_destination", atlas[0][i].name[1])
        db.setStringValue("to", keypad_input_dest)
        db.setFloatValue("navigator_target_planet_radius", atlas[0][i].radius)
        destination_inserted=true
        status_TO="TO"
        local myPos=ConstructPos()
        destination_coord=vec3(atlas[0][i].center)
        db.setStringValue("navigator_coordinates", tostring(destination_coord))
        set_coordinates(atlas[0][i])
        distance_to_go=math.floor(((vec3(atlas[0][i].center) - myPos):len())/1000/200*100)/100
        distance_to_go_warp=distance_to_go
        db.setFloatValue("navigator_distance", distance_to_go)
        db.setFloatValue("navigator_eta_h", 0)
        db.setFloatValue("navigator_eta_m", 0)
        db.setFloatValue("navigator_eta_s", 0)
        destination_check=true
        break
       elseif db.hasKey(keypad_input_dest) then
        local wp_check=keypad_input_dest
        for x=1, #wp_list do 
         if wp_list[x].id==wp_check then
          local wp_id=wp_list[x].wp
          keypad_input_dest=db.getStringValue(wp_id)
          keypad_input_dest_coord=wp_id .."_coord"
          db.setStringValue("navigator_target_destination", keypad_input_dest)
          db.setStringValue("to", keypad_input_dest)
          db.setFloatValue("navigator_target_planet_radius", 1)
          destination_inserted=true
          status_TO="TO"
          local myPos=ConstructPos()
          destination_coord=vec3FromStr(db.getStringValue(keypad_input_dest_coord))
          db.setStringValue("navigator_coordinates", tostring(destination_coord))
          set_wp_coordinates(db.getStringValue(keypad_input_dest_coord))
          distance_to_go=math.floor(((destination_coord - myPos):len())/1000/200*100)/100
          distance_to_go_warp=distance_to_go
          db.setFloatValue("navigator_distance", distance_to_go)
          db.setFloatValue("navigator_eta_h", 0)
          db.setFloatValue("navigator_eta_m", 0)
          db.setFloatValue("navigator_eta_s", 0)
          destination_check=true
          break
         else
          db.setStringValue("navigator_target_destination", "no Dest.")
          destination_inserted=false
          status_TO=""
          destination_coord="Not Present In Databank"
          db.setStringValue("navigator_coordinates", "n/a")
         end
        end
       elseif (destination_check==false) then
        db.setStringValue("navigator_target_destination", "no Dest.")
        destination_inserted=false
        status_TO=""
        destination_coord="Not Present In Databank"
        db.setStringValue("navigator_coordinates", "n/a")
       end
      end
     elseif (routing_timer and screenState==15) then
      for i=1, #WpRouteList do
       if string.find(WpRouteList[i], "To ") then UserSelectedWp="WpID "..i end
      end
     end
    end

   --ENT Target Pe Altitude
    if screenState==4 then
     local Destination=""
     local MinimumABSAltitude=10000
     local MinimumAltitude=0
     local SelectabledAltitude=0
     if (keypad_input_dest==nil or keypad_input_dest=="") then Destination=core.getCurrentPlanetId()
     else Destination=keypad_input_dest end
     if (tonumber(Destination)~=nil and Destination~=0) then MinimumAltitude=atlas[0][Destination].atmosphereThickness
     elseif Destination==0 then MinimumAltitude=10000
     else
      for i, v in pairs(atlas[0]) do
       if atlas[0][i].name[1]==Destination then MinimumAltitude=atlas[0][i].atmosphereThickness break end
      end
     end

     if (target_pe_altitude_inserted==false and keypad_input_pe_target_alt~="") then
      if tonumber(keypad_input_pe_target_alt)==nil then
       target_alt_warning="Invalid Input"
       target_pe_altitude_inserted=true
       status_TA="TA"
      elseif (tonumber(keypad_input_pe_target_alt)<MinimumABSAltitude and MinimumABSAltitude>=MinimumAltitude) then
       target_alt_warning="Warning Altitude below 10.000 m"
       target_pe_altitude_inserted=true
       status_TA="TA"
      elseif (tonumber(keypad_input_pe_target_alt)<MinimumAltitude) then
       target_alt_warning="Warning Destination Atmosphere Altitude is "..MinimumAltitude
       target_pe_altitude_inserted=true
       status_TA="TA"
      elseif (tonumber(keypad_input_pe_target_alt)>=MinimumABSAltitude and tonumber(keypad_input_pe_target_alt)>=MinimumAltitude) then
       db.setFloatValue("navigator_pe_target_altitude", tonumber(keypad_input_pe_target_alt))
       target_pe_altitude_inserted=true
       status_TA="TA"
       stored_pe_target_alt=keypad_input_pe_target_alt
       db.setFloatValue("PE_altitude", math.floor(stored_pe_target_alt))
      elseif target_alt_warning=="Invalid Input" then
       target_alt_warning="Invalid Input"
       target_pe_altitude_inserted=true
       status_TA="TA"
      end
     else
      target_alt_warning="Invalid Input"
      target_pe_altitude_inserted=true
      status_TA="TA"
     end
    end

   --ENT Settings
    if screenState==9 then        --(Settings Menu)
     local x=ScreenSelection
     if x=="Ship Settings" then     --SELECT Ship Settings
      screenState=5
      MTOW_tick=">"
      autobrake_tick=""
      wp_dist_tick=""
      holding_tick=""
     elseif x=="WP Store" then      --SELECT WP Store
      screenState=7
      wp_name_tick=">"   
      wp_lat_tick=""
      wp_lon_tick=""
      wp_alt_tick=""
      wp_selected_planet=""
      keypad_input_wp_name=""
      keypad_input_wp_lat=""
      keypad_input_wp_lon=""
      keypad_input_wp_alt=""
     elseif x=="WP Sync" then       --SELECT WP Sync
      screenState=8
      dwn_sync_tick=">"   
      up_sync_tick=""
      sync_result=""
      receiving_wp=0
      wp_synced=0
      index_sync=1
      prog_bar=0
      keypad_input_shipid=db.getStringValue("Ship ID")
      shipid_tick=""
     elseif x=="Screen Colors" then --SELECT Screen Colors
      screenState=10
      tick_color_1=">"   
      tick_color_2=""
      tick_color_3=""
      tick_color_4=""
      tick_color_5=""
      local TableColor=db.getStringValue("SCRTableColor")
      TableColor=json.decode(TableColor)
      keypad_input_color1=TableColor[1] ..",".. TableColor[2] ..",".. TableColor[3]
      local FontTitle=db.getStringValue("SCRFontTitle")
      FontTitle=json.decode(FontTitle)
      keypad_input_color2=FontTitle[1] ..",".. FontTitle[2] ..",".. FontTitle[3]
      local FontColor=db.getStringValue("SCRFontColor")
      FontColor=json.decode(FontColor)
      keypad_input_color3=FontColor[1] ..",".. FontColor[2] ..",".. FontColor[3]
      local ButtonPressed=db.getStringValue("SCRButtonPressed")
      ButtonPressed=json.decode(ButtonPressed)
      keypad_input_color4=ButtonPressed[1] ..",".. ButtonPressed[2] ..",".. ButtonPressed[3]
      local ButtonColor=db.getStringValue("SCRButtonColor")
      ButtonColor=json.decode(ButtonColor)
      keypad_input_color5=ButtonColor[1] ..",".. ButtonColor[2] ..",".. ButtonColor[3]
      RGBColor1, RGBColor2, RGBColor3, RGBColor4, RGBColor5=true, true, true, true, true
     elseif x=="DMG Report" then    --SELECT DMG Rep.
      screenState=11  
      tick_dmg_1=">"
      tick_dmg_2=""
      keypad_input_dmg1=db.getFloatValue("DMG Scale")
      DMG_REP_TOP_VIEW_Up_Down=db.getFloatValue("DMG TV U/D")
      DMG_REP_TOP_VIEW_LH_RH=db.getFloatValue("DMG TV L/R")
      DMG_REP_SIDE_VIEW_Up_Down=db.getFloatValue("DMG SV U/D")
      DMG_REP_SIDE_VIEW_LH_RH=db.getFloatValue("DMG SV L/R")
      keypad_input_dmg2=1
      dmg_factor=keypad_input_dmg2
     elseif x=="DB Reset" then      --SELECT DB Reset
      screenState=12
      tick_={}
      tick_[1]=">"   
      tick_[2]=""
      tick_[3]=""
      tick_[4]=""
      tick_[5]=""
      db_mark_1="X"
      db_mark_1_TF=true
      db_mark_2="X"
      db_mark_2_TF=true
      db_mark_3="X"
      db_mark_3_TF=true
      db_mark_4="X"
      db_mark_4_TF=true
      db_mark_5="X"
      db_mark_5_TF=true
      reset_db_status=db.getNbKeys().." Keys"
      reset_db_status2=""
      LuaScreen()
     elseif x=="Routes" then        --SELECT Routes
      screenState=14
      routes_page_index=1
      routes_wp_page_index=1
      route_tick_n=1
      order_routes_list={}
      routes_list={}
      route_tick_={}
      local x=(routes_page_index*5)-4
      local y=generating_wp_pages("14routes")
      for i=1, y do route_tick_[i]="" end
      route_tick_[x]=">"
      RouteTickList=json.encode(route_tick_)
      wp_tick_={}
      WpTickList=json.encode(wp_tick_)
     end
    elseif screenState==5 then    --(Ship Settings)
     if MTOW_tick==">" then
      if (keypad_input_MTOW=="") then
       keypad_input_MTOW=factory_MTOW/1000
       new_MTOW=keypad_input_MTOW
       MTOW_inserted=true
       db.setFloatValue("navigator_MTOW", new_MTOW*1000)
      else
       new_MTOW=tonumber(keypad_input_MTOW)
       MTOW_inserted=true
       db.setFloatValue("navigator_MTOW", new_MTOW*1000)
      end
     elseif autobrake_tick==">" then
      if keypad_input_autobrake=="" then
       keypad_input_autobrake=factory_autobrake
       autobrake_stops_at_inserted=true
       db.setFloatValue("navigator_autobrake", keypad_input_autobrake)
      else
       keypad_input_autobrake=tonumber(keypad_input_autobrake)
       autobrake_stops_at_inserted=true
       db.setFloatValue("navigator_autobrake", keypad_input_autobrake)
      end
     elseif wp_dist_tick==">" then
      if keypad_input_wpdist=="" then
       keypad_input_wpdist=wp_sequencing_distance
       wp_dist_inserted=true
       db.setFloatValue("navigator_wpdist", keypad_input_wpdist)
      else
       keypad_input_wpdist=tonumber(keypad_input_wpdist)
       wp_sequencing_distance=keypad_input_wpdist
       wp_dist_inserted=true
       db.setFloatValue("navigator_wpdist", keypad_input_wpdist)
      end
     elseif holding_tick==">" then
      if keypad_input_holding=="" then
       keypad_input_holding=db.getIntValue("holding_speed")
       holding_speed=keypad_input_holding
       holding_speed_inserted=true
      else
       keypad_input_holding=tonumber(keypad_input_holding)
       holding_speed=keypad_input_holding
       holding_speed_inserted=true
       db.setIntValue("holding_speed", holding_speed)
      end
     end
    elseif screenState==8 then    --(WP Sync)
     msg_counter=0
     if (shipid_tick==">" and keypad_input_shipid~="") then
      ship_id=keypad_input_shipid
      db.setStringValue("Ship ID", ship_id)
      ShipIdCheck=true
     end
     if (dwn_sync_tick==">" and keys_number>0 and up_sync_tick=="" and emitter) then
      emitter.send("AviatorHUD", "<SendDataToBase>"..ship_id)
      sync_result="Downlink Requested"
      delay_timer=5
      delay_id="ShipIDResponse"
      unit.setTimer("delay", 1)
     elseif (keys_number==0) then
      prog_bar=0
      sync_result="No Data To Sync"
     end
     if (up_sync_tick==">" ) then ship_id=db.getStringValue("Ship ID")
      if (ship_id~="" and ship_id~="No ID" and emitter) then
       emitter.send("AviatorHUD", "<SendShipID>"..ship_id)
       sync_result="Ship ID Sent"
       delay_timer=5
       delay_id="ShipIDResponse"
       unit.setTimer("delay", 1)
      else
        if emitter then sync_result="No Ship ID" else sync_result="No Emitter/Receiver" end
      end
     end
    elseif screenState==10 then   --(Screen Colors)
     if tick_color_1==">" then
      if (keypad_input_color1:find("%a")~=nil or keypad_input_color1:find("(%d+),(%d+),(%d+)")==nil) then
       keypad_input_color1="Insert RGB"
      elseif keypad_input_color1~="" then
       Table_RGB="{".. keypad_input_color1 .."}"
       db.setStringValue("SCRTableColor", Table_RGB)
       local TableColor=json.decode(Table_RGB)
       Table_R=ColorConvert(TableColor[1])
       Table_G=ColorConvert(TableColor[2])
       Table_B=ColorConvert(TableColor[3])
       RGBColor1=true
      end
     elseif tick_color_2==">" then
      if (keypad_input_color2:find("%a")~=nil or keypad_input_color2:find("(%d+),(%d+),(%d+)")==nil) then
       keypad_input_color2="Insert RGB"
      elseif keypad_input_color2~="" then
       Title_RGB="{".. keypad_input_color2 .."}"
       db.setStringValue("SCRFontTitle", Title_RGB)
       local FontTitle=json.decode(Title_RGB)
       Title_R=ColorConvert(FontTitle[1])
       Title_G=ColorConvert(FontTitle[2])
       Title_B=ColorConvert(FontTitle[3])
       RGBColor2=true
      end
     elseif tick_color_3==">" then
      if (keypad_input_color3:find("%a")~=nil or keypad_input_color3:find("(%d+),(%d+),(%d+)")==nil) then
       keypad_input_color3="Insert RGB"
      elseif keypad_input_color3~="" then
       Font_RGB="{".. keypad_input_color3 .."}"
       db.setStringValue("SCRFontColor", Font_RGB)
       local FontColor=json.decode(Font_RGB)
       Font_R=ColorConvert(FontColor[1])
       Font_G=ColorConvert(FontColor[2])
       Font_B=ColorConvert(FontColor[3])
       RGBColor3=true
      end
     elseif tick_color_4==">" then
      if (keypad_input_color4:find("%a")~=nil or keypad_input_color4:find("(%d+),(%d+),(%d+)")==nil) then
       keypad_input_color4="Insert RGB"
      elseif keypad_input_color4~="" then
       Button_Pressed_RGB="{".. keypad_input_color4 .."}"
       db.setStringValue("SCRButtonPressed", Button_Pressed_RGB)
       local ButtonPressed=json.decode(Button_Pressed_RGB)
       Button_Pressed_R=ColorConvert(ButtonPressed[1])
       Button_Pressed_G=ColorConvert(ButtonPressed[2])
       Button_Pressed_B=ColorConvert(ButtonPressed[3])
       RGBColor4=true
      end
     elseif tick_color_5==">" then
      if (keypad_input_color5:find("%a")~=nil or keypad_input_color5:find("(%d+),(%d+),(%d+)")==nil) then
       keypad_input_color5="Insert RGB"
      elseif keypad_input_color5~="" then
       Button_RGB="{".. keypad_input_color5 .."}"
       db.setStringValue("SCRButtonColor", Button_RGB)
       local ButtonColor=json.decode(Button_RGB)
       Button_R=ColorConvert(ButtonColor[1])
       Button_G=ColorConvert(ButtonColor[2])
       Button_B=ColorConvert(ButtonColor[3])
       RGBColor5=true
      end
     end
    elseif screenState==12 then   --(DB reset)
     if tick_[1]==">" then
      if db_mark_1=="X" then db_mark_1="" db_mark_1_TF=false
      else db_mark_1="X" db_mark_1_TF=true end
     elseif tick_[2]==">" then
      if db_mark_2=="X" then db_mark_2="" db_mark_2_TF=false
      else db_mark_2="X" db_mark_2_TF=true end
     elseif tick_[3]==">" then
      if db_mark_3=="X" then db_mark_3="" db_mark_3_TF=false
      else db_mark_3="X" db_mark_3_TF=true end
     elseif tick_[4]==">" then
      if db_mark_4=="X" then db_mark_4="" db_mark_4_TF=false
      else db_mark_4="X" db_mark_4_TF=true end
     elseif tick_[5]==">" then
      if db_mark_5=="X" then db_mark_5="" db_mark_5_TF=false
      else db_mark_5="X" db_mark_5_TF=true end
     end
    elseif screenState==14 then   --(Routes)
     for i=0, #routes_list do
      if route_tick_[i]==">" then
       local route_id=routes_list[i]
       if (route_id~=nil and route_id~="") then
        route_tick_[i]="*"
        RouteTickList=json.encode(route_tick_)
        route_id=routes_list[i].id
        route_id_selected=route_id
        local data=db.getStringValue(route_id):gsub("@@@","\"")
        data=json.decode(data)
        wp_tick_={}
        local counter=0
        for i,v in pairs(data) do
         counter=counter +1
         wp_tick_[counter]=""
        end
        wp_tick_[1]=">"
        WpTickList=json.encode(wp_tick_)
        wp_tick_n=1
       end
       break
      end
     end
    elseif screenState==16 then   --(WP Setting)
     if wp_altitude_tick==">" then
      if (tonumber(keypad_input_wp_altitude)~=nil) then
       wp_altitude_inserted=true
      end
     elseif wp_speed_tick==">" then
      if (tonumber(keypad_input_wp_speed)~=nil) then
       wp_speed_inserted=true
      end
     end

     local ext=db.getStringValue("wp_settings"):gsub("@@@","\"")
     ext=json.decode(ext)
     ext[edit_wp]={["alt"]=keypad_input_wp_altitude,["s"]=keypad_input_wp_speed}
     ext=json.encode(ext)
     db.setStringValue("wp_settings", ext:gsub("\"","@@@"))
    end

   --ENT ROUTING
    if (screenState==15 and ScreenSelection~="") then UserSelectedWp=ScreenSelection end

   --ENT AGG
    if screenState==13 then
     if ScreenSelection=="ENGAGE" then
      local status=db.getStringValue("nav agg")
      if status=="STBY" then db.setStringValue("nav agg", "ENG") end
     elseif (ScreenSelection=="OFF" or ScreenSelection=="STBY") then
      local status=db.getStringValue("nav agg")
      if (status=="OFF" or status=="ENG") then db.setStringValue("nav agg", "STBY")
      elseif status=="STBY" then db.setStringValue("nav agg", "OFF") end
     elseif (agg_tick_input==">" and agg_target_altitude==false and keypad_input_agg_target_alt~="") then
      if tonumber(keypad_input_agg_target_alt)<1000 then keypad_input_agg_target_alt=1000 end
      db.setIntValue("agg_t_alt", keypad_input_agg_target_alt)
      if antigrav then antigrav.setBaseAltitude(keypad_input_agg_target_alt) end
      agg_target_altitude=true
     end
    end

  end

 --CLR BUTTON
  function clr_button()
   --CLR Time Calculator
    if screenState==1 then
     if (su_distance_inserted==true and keypad_input_su~=[[""]] and keypad_input_speed~=[[""]]) then
      keypad_input_speed=nil
      db.setFloatValue("navigator_speed", "0")
      speed_inserted=false
      time_to_go=[[""]]
      db.setFloatValue("navigator_eta_h", 0)
      db.setFloatValue("navigator_eta_m", 0)
      db.setFloatValue("navigator_eta_s", 0)
     elseif ( su_distance_inserted==true and keypad_input_su~=[[""]] and keypad_input_speed==[[""]]) then
      keypad_input_su=nil
      db.setStringValue("navigator_distance", "n/a")
      su_distance_inserted=false
      speed_inserted=false
      db.setStringValue("navigator_speed", "0")
      db.setFloatValue("navigator_eta_h", 0)
      db.setFloatValue("navigator_eta_m", 0)
      db.setFloatValue("navigator_eta_s", 0)
     elseif ( su_distance_inserted==false and keypad_input_su~=[[""]] and keypad_input_speed==[[""]]) then
      keypad_input_su=nil
      db.setStringValue("navigator_distance", "n/a")
      db.setFloatValue("navigator_eta_h", 0)
      db.setFloatValue("navigator_eta_m", 0)
      db.setFloatValue("navigator_eta_s", 0)
     end
    end

   --CLR From
    if screenState==2 then
     if (keypad_input_from~="" or WPADD_tick==">"   )then
      keypad_input_from=nil
      db.setStringValue("navigator_from", "no From")
      from_coordinates=""
      db.setStringValue("navigator_from_coordinates", "n/a")
      from_inserted=false
      status_FM=""
      db.setFloatValue("navigator_from_planet_radius", 0)
      wpname_inserted=false
      FROM_tick=">"
      WPADD_tick=""
      stored=""
     end
    end

   --CLR Distance To Coordinates
    if (screenState==3 or screenState==15) then
     if (keypad_input_dest~="") then
      if routing_timer then unit.stopTimer("routing") end
      keypad_input_dest=nil
      db.setStringValue("navigator_target_destination", "no Dest.")
      destination_inserted=false
      status_TO=""
      destination_coord=nil
      db.setStringValue("navigator_coordinates", "n/a")
      distance_to_go=""
      db.setFloatValue("navigator_target_planet_radius", 0)
     end
    end

   --CLR Target Pe Altitude
    if screenState==4 then
     if (keypad_input_pe_target_alt~="") then
      keypad_input_pe_target_alt=nil
      target_pe_altitude_inserted=false
      status_TA=""
      target_alt_warning=""
     end
    end

   --CLR Settings
    if screenState==5 then    --(Ship Settings)
     if ((MTOW_inserted==true or keypad_input_MTOW~="") and MTOW_tick==">") then
      keypad_input_MTOW=""
      new_MTOW=factory_MTOW/1000
      MTOW_inserted=false
      db.setFloatValue("navigator_MTOW", factory_MTOW)
     elseif ((autobrake_stops_at_inserted==true or keypad_input_autobrake~="") and autobrake_tick==">") then
      keypad_input_autobrake=""
      autobrake_stops_at_inserted=false
      db.setFloatValue("navigator_autobrake", factory_autobrake)
     elseif ((wp_dist_inserted==true or keypad_input_wpdist~="") and wp_dist_tick==">") then
      keypad_input_wpdist=""
      wp_dist_inserted=false
      db.setFloatValue("navigator_wpdist", wp_sequencing_distance)
     elseif ((holding_speed_inserted==true or keypad_input_holding~="") and holding_tick==">") then
      keypad_input_holding=""
      holding_speed_inserted=false
      db.setIntValue("holding_speed", "")
     end
    elseif screenState==7 then  --(WP Store)
     if wp_name_tick==">" then keypad_input_wp_name=""
     elseif wp_lat_tick==">" then keypad_input_wp_lat=""
     elseif wp_lon_tick==">" then keypad_input_wp_lon=""
     elseif wp_alt_tick==">" then keypad_input_wp_alt=""
     end
    elseif screenState==8 then  --(WP Sync)
     if shipid_tick==">" then
      keypad_input_shipid=""
      ship_id=keypad_input_shipid
      db.setStringValue("Ship ID", ship_id)
      ShipIdCheck=false
     end
    elseif screenState==10 then --(Screen Colors)
     if tick_color_1==">" then keypad_input_color1="" RGBColor1=false
     elseif tick_color_2==">" then keypad_input_color2="" RGBColor2=false
     elseif tick_color_3==">" then keypad_input_color3="" RGBColor3=false
     elseif tick_color_4==">" then keypad_input_color4="" RGBColor4=false
     elseif tick_color_5==">" then keypad_input_color5="" RGBColor5=false
     end
    elseif screenState==12 then --(DB reset)
     databank_clean(db_mark_1_TF, db_mark_2_TF, db_mark_3_TF, db_mark_4_TF, db_mark_5_TF)
    elseif screenState==14 then --(Routes)
     for i=1, #route_tick_ do
      if route_tick_[i]=="*" then
       route_tick_[i]=">"
       RouteTickList=json.encode(route_tick_)  
       for x=1, #wp_tick_ do
        wp_tick_[x]=""
       end
       WpTickList=json.encode(wp_tick_)
       routes_wp_page_index=1
      end
     end
    elseif screenState==16 then --(WP Setting)
     if wp_altitude_tick==">" then
      keypad_input_wp_altitude=""
      wp_altitude_inserted=false
     elseif wp_speed_tick==">" then
      keypad_input_wp_speed=""
      wp_speed_inserted=false
     end
     ent_button()
    end

   --CLR AGG
    if screenState==13 then    --(AGG)
     if keypad_input_agg_target_alt~="" then
      keypad_input_agg_target_alt=""
      agg_target_altitude=false
     end
    end
  end

--SCREEN GENERATOR
 --STORED WAYPOINTS        (screenState=0)
  function stored_waypoints_1()
   local dbKeys=db.getNbKeys()
   local ext=db.getStringValue("wp_settings"):gsub("@@@","\"")
   ext=json.decode(ext)

   order_list={}
   for i=1, dbKeys do
    local dbkey="wp"..i
    local value=db.getStringValue(dbkey)
    if value~="" then
     table.insert(order_list, value)
     table.sort(order_list)
    end
   end

   wp_list={}
   wp_counter=0
   for i=1, #order_list do
    local dbkeysort=order_list[i]
    for x=1, dbKeys do
     local key="wp"..x
     local v=db.getStringValue(key)
     if dbkeysort==v then
      wp_counter=wp_counter + 1
      local id="wp"..wp_counter
      if ext[v]~=nil then
       if (ext[v].alt~="" or ext[v].s~="") then s="*" else s="" end
      else s="" end
      wp_list[wp_counter]={["id"]=id,["wp"]=key,["name"]=v,["settings"]=s}
      break
     end
    end
   end
   wp_pages=generating_wp_pages(0)
   if wp_page_index==nil then wp_page_index=1 else wp_page_index=wp_page_index end

   local wp_list_index={}
   local index=wp_page_index*10-9
   for i=index, index+9 do
    if wp_list[i]~=nil then table.insert(wp_list_index, wp_list[i]) end
   end
   screen.setScriptInput(json.encode(wp_list_index))
  end
  if wp_list==nil then stored_waypoints_1() end

 --ATLAS LIST              (screenState=6)
  function atlas_list_page()
   atlas_list={}
   atlas_pages=0
   atlas_counter=0
   for i, v in pairs(atlas[0]) do
    atlas_counter=atlas_counter + 1
    local name=atlas[0][i].name[1]
    table.insert(atlas_list, name)
    table.sort(atlas_list)
   end
   atlas_pages=math.ceil(atlas_counter/10)
   atlas_page_index=atlas_page_index

   screen.setScriptInput(json.encode(atlas_list))
  end

 --SU DISTANCE TIME PAGE   (screenState=1)
  function su_distance_time()

   if su_distance_inserted==nil then su_distance_inserted=false end
   if speed_inserted==nil then speed_inserted=false end
   if distance_to_go~=nil then
    if distance_to_go~="" then
    keypad_input_su=distance_to_go
    db.setFloatValue("navigator_distance", keypad_input_su)
    su_distance_inserted=true
    su_tick=""
    speed_tick=">"
    end
   end

   if (tonumber(keypad_input_su)==nil or keypad_input_su==".") then
    keypad_input_su=[[""]]
    su_tick=">"
    speed_tick=""
   end
   if (tonumber(keypad_input_speed)==nil or keypad_input_speed==".") then keypad_input_speed=[[""]] end
   if time_to_go==nil then time_to_go=[[""]] end

   if (keypad_input_su==nil or keypad_input_su==[[""]]) then warp_distance=0
   else warp_distance=keypad_input_su end

   if tonumber(warp_distance)==nil then warp_distance=0 end
   MinWpCells=ConstructMass() * warp_distance * 0.00025
   MaxWpCells=math.floor((new_MTOW) * warp_distance * 0.00025)

  end

 --FROM PAGE               (screenState=2)
  function from()
   if (db.getStringValue("navigator_from")~="no From" and db.getStringValue("navigator_from")~="PPOS") then
    keypad_input_from=db.getStringValue("from")
   end

   if from_inserted==nil then
    from_inserted=false
    status_FM=""
    FROM_tick=">"
    keypad_input_wpname=""
    wpname_inserted=false
    WPADD_tick=""
    stored=""
   end

   if keypad_input_from==nil then
    keypad_input_from=""
    from_coordinates=""
    from_inserted=false
    status_FM=""
    FROM_tick=">"
    keypad_input_wpname=""
    wpname_inserted=false
    WPADD_tick=""
    stored=""
   end

  end

 --DESTINATION PAGE        (screenState=3)
  function distance_to_wp()
   if (db.getStringValue("navigator_target_destination")~="no Dest.") then
    keypad_input_dest=db.getStringValue("to")
    distance_to_go=db.getFloatValue("navigator_distance")
    distance_to_go_warp=db.getFloatValue("navigator_distance")
   end

   if destination_inserted==nil then
    destination_inserted=false
    status_TO=""
   end

   if keypad_input_dest==nil then
    keypad_input_dest=""
    destination_coord=""
    distance_to_go=""
    distance_to_go_warp=0
   else
    keypad_input_dest=keypad_input_dest
   end

   MinWpCells=ConstructMass() * distance_to_go_warp * 0.00025
   MaxWpCells=math.floor((new_MTOW) * distance_to_go_warp * 0.00025)

  end

 --TARGET PE ALTITUDE PAGE (screenState=4)
  function target_pe_altitude()
   if target_pe_altitude_inserted==nil then
    target_pe_altitude_inserted=false
    status_TA=""
   end

   if (db.getFloatValue("PE_altitude")~=0) then stored_pe_target_alt=math.floor(db.getFloatValue("PE_altitude"))
   else stored_pe_target_alt=factory_PE_target_altitude end

   if keypad_input_pe_target_alt==nil then
    keypad_input_pe_target_alt=""
    target_pe_altitude_inserted=false
    status_TA=""
   else keypad_input_pe_target_alt=keypad_input_pe_target_alt end
  end

 --AGG                     (screenState=13)
  function agg()

   if antigrav then agg_base_altitude=antigrav.getBaseAltitude() else agg_base_altitude=db.getIntValue("agg_b_alt") end
   if not antigrav then agg_base_altitude="PB Not Linked to AGG" agg_tick_input="X" else agg_tick_input=">" end

   agg_eng_stby=db.getStringValue("agg eng/stby")
   if (agg_eng_stby=="" or agg_eng_stby=="STBY") then  AGG_Eng_Dis="" agg_eng_stby="RED"
   elseif agg_eng_stby=="ENG" then AGG_Eng_Dis="" agg_eng_stby="GREEN" end

   agg_off_stby=db.getStringValue("agg off/stby")
   if agg_off_stby=="" then AGG_Off_Stby="STBY" agg_off_stby="OFF" AGG_Eng_Dis=""
   elseif agg_off_stby=="STBY" then AGG_Off_Stby="OFF" AGG_Eng_Dis="ENGAGE"
   elseif (agg_off_stby=="OFF" or agg_off_stby=="ACTIVE") then AGG_Eng_Dis="" AGG_Off_Stby="STBY" end

   if keypad_input_agg_target_alt==nil then
    keypad_input_agg_target_alt=1000
    db.setIntValue("agg_t_alt", 1000)
    agg_target_altitude=true
   end

   ship_altitude=math.floor(core.getAltitude())
   local AntiG=0
   if antigrav then
    AntiG=json.decode(antigrav.getData())
    AntiG=AntiG.antiGPower
    if (((ship_altitude-agg_base_altitude)*-1<=300) and AntiG>=0.8) then ALTDiffCheck="GREEN" else ALTDiffCheck="" end
   end
   if ALTDiffCheck==nil then ALTDiffCheck="" end
  end

 --SHIELD                  (screenState=17)
  function shieldFunction()
   if EnergyDistribution==nil then EnergyDistribution=false end
   local EnergyPool=(shield.getResistancesPool())*100
   if EnergyDistribution==false then  EneryLeft=(shield.getResistancesRemaining())*100 end
   local ShieldEnergyPool=string.format("%.0f / %.0f", EneryLeft, EnergyPool)

   local shieldHp=shield.getShieldHitpoints()
   local shieldMaxHp=shield.getMaxShieldHitpoints()
   local ShieldPercent=(shieldHp/shieldMaxHp*100)

   local ShieldStress=shield.getStressRatio()
   local San=tonumber(string.format("%.0f", (ShieldStress[1]*100)))
   local Sel=tonumber(string.format("%.0f", (ShieldStress[2]*100)))
   local Ski=tonumber(string.format("%.0f", (ShieldStress[3]*100)))
   local Sth=tonumber(string.format("%.0f", (ShieldStress[4]*100)))

   local ResistanceTable=shield.getResistances()
   local an=tonumber(string.format("%.0f", (ResistanceTable[1]*100)+10))
   local el=tonumber(string.format("%.0f", (ResistanceTable[2]*100)+10))
   local ki=tonumber(string.format("%.0f", (ResistanceTable[3]*100)+10))
   local th=tonumber(string.format("%.0f", (ResistanceTable[4]*100)+10))
   if (an==10 and el==10 and ki==10 and th==10) then ShieldBaseEnergy=true else ShieldBaseEnergy=false end

   if ScreenSelection~="" then
    local x=ScreenSelection
    ScreenSelection=""
    if (x=="RAISE" or x=="DROP") then shield.toggle()
    elseif x=="VENTING" then shield.startVenting()
    elseif x=="RESET" then
     if EnergyDistribution==true then menu("Shield")
     else
      Ran, Rel, Rki, Rth=10, 10, 10, 10
      shield.setResistances(0,0,0,0)--setResistances(antimatter,electromagnetic,kinetic,thermic)
      ShieldBaseEnergy=true
     end
    elseif x=="A-" then if Ran>=15 then Ran=Ran-5 EneryLeft=EneryLeft+5 end
    elseif x=="A+" then if EneryLeft>=5 then Ran=Ran+5 EneryLeft=EneryLeft-5 end
    elseif x=="E-" then if Rel>=15 then Rel=Rel-5 EneryLeft=EneryLeft+5 end
    elseif x=="E+" then if EneryLeft>=5 then Rel=Rel+5 EneryLeft=EneryLeft-5 end
    elseif x=="K-" then if Rki>=15 then Rki=Rki-5 EneryLeft=EneryLeft+5 end
    elseif x=="K+" then if EneryLeft>=5 then Rki=Rki+5 EneryLeft=EneryLeft-5 end
    elseif x=="T-" then if Rth>=15 then Rth=Rth-5 EneryLeft=EneryLeft+5 end
    elseif x=="T+" then if EneryLeft>=5 then Rth=Rth+5 EneryLeft=EneryLeft-5 end
    elseif x=="SET" then
     shield.setResistances((Ran-10)/100,(Rel-10)/100,(Rki-10)/100,(Rth-10)/100)
     EnergyDistribution=false
    end
   end
   if (Ran~=an or Rel~=el or Rki~=ki or Rth~=th) then EnergyDistribution=true else EnergyDistribution=false end

   local ShieldOnOff="RAISE"
   local isActive=shield.isActive()
   if isActive then ShieldOnOff="DROP" end

   local ShieldVENT="VENTING"
   local ventCool=shield.getVentingCooldown()
   if ventCool>0 then ShieldVENT=string.format("%.0f", ventCool) end

   local ShieldSET="SET"
   local ShieldRESET="RESET"
   local resCool=shield.getResistancesCooldown()
   if resCool>0 then ShieldSET=string.format("%.0f", resCool) end

   local ShieldStressTable={San,Sel,Ski,Sth}
   local Buttons={ShieldOnOff,ShieldVENT,ShieldSET,ShieldRESET}
   local ShieldData={ShieldPercent,ShieldEnergyPool,an,el,ki,th,EnergyDistribution,ShieldBaseEnergy}
   if EnergyDistribution then ShieldData={ShieldPercent,ShieldEnergyPool,Ran,Rel,Rki,Rth,EnergyDistribution,ShieldBaseEnergy} end
   screen.setScriptInput(json.encode({Buttons,ShieldData,ShieldStressTable}))
  end

 --PVP INFO
  function PVPInfoFunction()
   local ScrW=system.getScreenWidth()
   local ScrH=system.getScreenHeight()
   local MenuW=ScrW/10
   local MenuY=ScrH/30
   local cooldown=math.floor(shield.getVentingCooldown())
   if cooldown==0 then cooldown="" end
   HUD_HTML={}
   HUD_HTML[#HUD_HTML+1]=[[<style>
    td {border:2px solid rgb(]].. TableColor[1] ..[[,]].. TableColor[2] ..[[,]].. TableColor[3] ..[[);
    color:rgb(]].. FontColor[1] ..[[,]].. FontColor[2] ..[[,]].. FontColor[3] ..[[);
    font-family:Arial;
    font-size:15px;
    text-align:center;
    vertical-align:middle;}
    .Fright {float:right}
    .Fleft {float:left}
    .pvp {font-size:12px;}
    .bkgnd {background:rgba(]].. ButtonColor[1] ..[[,]].. ButtonColor[2] ..[[,]].. ButtonColor[3] ..[[,]].. Alpha1 ..[[)}
    .Title {color:rgb(]].. FontTitle[1] ..[[,]].. FontTitle[2] ..[[,]].. FontTitle[3] ..[[) !important}
    </style>
    <div style="position:absolute;top:10px;left:]].. (ScrW/2)-(MenuW/2) ..[[px;">
    <table class="bkgnd" width="]].. MenuW ..[[px">
    <tr height="]].. MenuY ..[[px"><td class="Title pvp" width="]].. MenuW ..[[px">
    <span class="Fleft">SHIFT+G Start/Stop VENTING</span>
    <span class="Fright">]].. cooldown ..[[</span>
    </td></tr></table></div>]]
   local HTML=table.concat(HUD_HTML)
   return HTML
  end

 --WP SETTINGS             (screenState=16)
  function wp_settings()

   if tonumber(keypad_input_wp_altitude)==nil then
   keypad_input_wp_altitude=""
   end

   if tonumber(keypad_input_wp_speed)==nil then
   keypad_input_wp_speed=""
   end

  end

 --ROUTING                 (screenState=15)
  function route_page()

   local ext=db.getStringValue("wp_settings"):gsub("@@@","\"")
   ext=json.decode(ext)
   WpSettingsList=ext
   db.setIntValue("Holding", 0)

   FullWpList=db.getStringValue(selected_route_id):gsub("@@@","\"")
   FullWpList=json.decode(FullWpList)
      
   local counter=0
   for i, v in pairs(FullWpList) do
    if (i~="name" and v~="") then counter=counter +1 end
   end
   selected_route_page_index=selected_route_page_index
   selected_route_pages=math.ceil((counter+1)/5)
   wp_tick_index=(selected_route_page_index*5)-4
  
   WpRouteList={}
   local WpSettingList_temp={}
   for i=wp_tick_index, (wp_tick_index +4) do
    local wp="wp"..i
    if (FullWpList[wp]~=nil) then
     local WpName=FullWpList[wp]
     WpRouteList[i]=WpName
     if WpSettingsList[WpName] then WpSettingList_temp[WpName]=WpSettingsList[WpName] end
    else WpRouteList[i]="" end
   end
   WpSettingsList=WpSettingList_temp

   DistanceList={}
   WPCoordinates={}
   local myPos=ConstructPos()
   local distance=""   
   local vec3_coord=""
   for i=wp_tick_index, (wp_tick_index +4) do
    local wp=WpRouteList[i]
    for x=1, #wp_list do
     local wp_id="wp"..x
     local wpMatch=db.getStringValue(wp_id)
     if wpMatch==wp then
      local wp_coord=db.getStringValue(wp_id.."_coord")
      vec3_coord=vec3FromStr(wp_coord)
      WPCoordinates[i]=vec3_coord
      distance=math.floor(((vec3(vec3_coord) - myPos):len())/1000*100)/100
      if distance>200 then DistanceList[i]=math.floor((distance/200)*100)/100 .." Su"
      else DistanceList[i]=distance .." Km" end
      break
     elseif (wp=="HOLD" or wp=="hold") then DistanceList[i]="Holding"
     elseif wp=="" then DistanceList[i]=""
     else DistanceList[i]="Wrong Wp Name" end
    end
   end

   local function NextWp(x)
    menu_destination(x)
   end

   if UserSelectedWp==nil then UserSelectedWp="" end

   if not first_wp_selected then
    if selected_route_page_index>1 then
     selected_route_page_index=1
     LuaScreen()
    else
     local WpN=1
     DistToNextWp=1
     if WpRouteList[WpN] then
      ToWp=WpRouteList[WpN]
      NextWp(ToWp)
      WpRouteList[WpN]="To "..ToWp
      FullWpList[WpN]="To "..ToWp
      first_wp_selected=true
      if DistanceList[WpN]~="Wrong Wp Name" then unit.setTimer("routing", 1) end
     end
    end
   elseif (first_wp_selected and next_wp_selected) then
    DistToNextWp=DistToNextWp+1
    if DistToNextWp>(wp_tick_index +4) then
     DistToNextWp=DistToNextWp-1
     big_arrow_down()
     LuaScreen()
    elseif WpRouteList[DistToNextWp] then
     ToWp=WpRouteList[DistToNextWp]
     if WpRouteList[DistToNextWp]~="" then
      NextWp(ToWp)
      WpRouteList[DistToNextWp]="To "..ToWp
      FullWpList[DistToNextWp]="To "..ToWp
     end
     if DistanceList[ToWp]~="Wrong Wp Name" then unit.setTimer("routing", 1) end
    end
    next_wp_selected=false
   elseif string.find(UserSelectedWp, "WpID") then
    local WpID=UserSelectedWp:gsub("WpID ", "")
    WpID=tonumber(WpID)
    ToWp=WpRouteList[WpID]
    if ToWp~=nil then
     DistToNextWp=WpID
     NextWp(ToWp)
     WpRouteList[WpID]="To "..ToWp
     FullWpList[WpID]="To "..ToWp
     next_wp_selected=false
     UserSelectedWp=""
     if DistanceList[ToWp]~="Wrong Wp Name" then unit.setTimer("routing", 1) end
    end
   end

   screen.setScriptInput(json.encode({WpSettingsList,WpRouteList,DistanceList}))
  end

 --SETTINGS MENU           (screenState=9)
  --SETTINGS PAGE 1        (Ship Settings)(screenState=5)
   function settings1()

    if (tonumber(keypad_input_MTOW)==nil or keypad_input_MTOW==".") then
     keypad_input_MTOW=factory_MTOW/1000
     new_MTOW=factory_MTOW/1000
     MTOW_inserted=true
    end

    if (tonumber(keypad_input_autobrake)==nil or keypad_input_autobrake==".") then
     keypad_input_autobrake=factory_autobrake
     autobrake_stops_at_inserted=true
    end

    if (tonumber(keypad_input_wpdist)==nil or keypad_input_wpdist==".") then
     keypad_input_wpdist=wp_sequencing_distance
     wp_dist_inserted=true
    end

    if (tonumber(keypad_input_holding)==nil or keypad_input_holding==".") then
     keypad_input_holding=holding_speed
     holding_speed_inserted=true
    end

   end

  --SETTINGS PAGE 2        (WP Store)(screenState=7)
   function settings2()

    if db.getStringValue("to")~=nil then
     for i, v in pairs(atlas[0]) do
      if atlas[0][i].name[1]==keypad_input_dest then wp_selected_planet=db.getStringValue("to") end
     end
    else wp_selected_planet="" end

    if (wp_selected_planet==nil or wp_selected_planet=="" or wp_selected_planet=="Insert Destination") then
     wp_selected_planet="Insert Destination"
     wp_name_tick=""
     wp_lat_tick=""
     wp_lon_tick=""
     wp_alt_tick=""
     stored=""
    end

    if (keypad_input_wp_name==nil or keypad_input_wp_name=="") then
     keypad_input_wp_name=""
     wp_name_inserted=false
    else wp_name_inserted=true end

    if (tonumber(keypad_input_wp_lat)==nil or keypad_input_wp_lat=="") then
     keypad_input_wp_lat=""
     wp_lat_inserted=false
    else wp_lat_inserted=true end

    if (tonumber(keypad_input_wp_lon)==nil or keypad_input_wp_lon=="") then
     keypad_input_wp_lon=""
     wp_lon_inserted=false
    else wp_lon_inserted=true end

    if (tonumber(keypad_input_wp_alt)==nil or keypad_input_wp_alt=="") then
     keypad_input_wp_alt=""
     wp_alt_inserted=false
    else wp_alt_inserted=true end

    if (wp_selected_planet~="World Coordinates" and wp_name_inserted==true and wp_lat_inserted==true and wp_lon_inserted==true and wp_alt_inserted==true) then
     wp_coordinated_stored=tostring(coord_converter())
    else wp_coordinated_stored="" end

    if (stored==nil or stored=="STORED" or stored=="WP RENAMED") then stored="" end

   end

  --SETTINGS PAGE 3        (WP Sync)(screenState=8)
   function settings3()
    if FleetNumber==nil then FleetNumber=0 end
    local FleetList=db.getStringValue("Fleet")
    FleetList=json.decode(FleetList)
    if FleetList==nil then FleetNumber=0
    else FleetNumber=#FleetList end
    local dbKeys=db.getNbKeys()

    if dbKeys>0 then
     local counter=0
     for i=1, dbKeys do
      local wp_name="wp"..i
      local wp_name=db.getStringValue(wp_name)

      if (tostring(wp_name)~=nil and tostring(wp_name)~="") then counter=counter + 1 end
      keys_number=counter
     end
    else keys_number=0 end
    if (sync_result==nil or sync_result=="") then sync_result="" end

   end

  --SETTINGS PAGE 4        (Screen Colours)(screenState=10)
  --SETTINGS PAGE 5        (DMG Rep.)(screenState=11)
   function DMGReportClick(x)
    if screenState==11 then
     if x=="UP" then
      if tick_dmg_1==">" then
       DMG_REP_TOP_VIEW_Up_Down=DMG_REP_TOP_VIEW_Up_Down + dmg_factor
       db.setFloatValue("DMG TV U/D", DMG_REP_TOP_VIEW_Up_Down)
      elseif tick_dmg_2==">" then
       DMG_REP_SIDE_VIEW_Up_Down=DMG_REP_SIDE_VIEW_Up_Down - dmg_factor
       db.setFloatValue("DMG SV U/D", DMG_REP_SIDE_VIEW_Up_Down)
      end
     elseif x=="DN" then
      if tick_dmg_1==">" then
       DMG_REP_TOP_VIEW_Up_Down=DMG_REP_TOP_VIEW_Up_Down - dmg_factor
       db.setFloatValue("DMG TV U/D", DMG_REP_TOP_VIEW_Up_Down)
      elseif tick_dmg_2==">" then
       DMG_REP_SIDE_VIEW_Up_Down=DMG_REP_SIDE_VIEW_Up_Down + dmg_factor
       db.setFloatValue("DMG SV U/D", DMG_REP_SIDE_VIEW_Up_Down)
      end
     elseif x=="LH" then
      if tick_dmg_1==">" then
       DMG_REP_TOP_VIEW_LH_RH=DMG_REP_TOP_VIEW_LH_RH - dmg_factor
       db.setFloatValue("DMG TV L/R", DMG_REP_TOP_VIEW_LH_RH)
      elseif tick_dmg_2==">" then
       DMG_REP_SIDE_VIEW_LH_RH=DMG_REP_SIDE_VIEW_LH_RH - dmg_factor
       db.setFloatValue("DMG SV L/R", DMG_REP_SIDE_VIEW_LH_RH)
      end
     elseif x=="RH" then
      if tick_dmg_1==">" then
       DMG_REP_TOP_VIEW_LH_RH=DMG_REP_TOP_VIEW_LH_RH + dmg_factor
       db.setFloatValue("DMG TV L/R", DMG_REP_TOP_VIEW_LH_RH)
      elseif tick_dmg_2==">" then
       DMG_REP_SIDE_VIEW_LH_RH=DMG_REP_SIDE_VIEW_LH_RH + dmg_factor
       db.setFloatValue("DMG SV L/R", DMG_REP_SIDE_VIEW_LH_RH)
      end
     elseif x=="+" then
      keypad_input_dmg1=keypad_input_dmg1 + dmg_factor
      db.setFloatValue("DMG Scale", keypad_input_dmg1)
     elseif x=="-" then
      keypad_input_dmg1=keypad_input_dmg1 - dmg_factor
      if keypad_input_dmg1<0.1 then keypad_input_dmg1=0.1 end 
      db.setFloatValue("DMG Scale", keypad_input_dmg1)
     elseif x==" + " then
      dmg_factor=dmg_factor + 0.1
      keypad_input_dmg2=dmg_factor
     elseif x==" - " then
      dmg_factor=dmg_factor - 0.1
      if dmg_factor<0.1 then dmg_factor=0.1 end
      keypad_input_dmg2=dmg_factor
     
     end
    end
   end
  
  --SETTINGS PAGE 6        (DB Reset)(screenState=12)
  --SETTINGS PAGE 7        (Routes)(screenState=14)
   function settings7()

    local stored_routes_table=""
    order_routes_list={}
    local dbKeys=db.getNbKeys()
    RouteCounter=0
    for i=1, dbKeys do
     local dbkey="Route"..i
     local data=db.getStringValue(dbkey):gsub("@@@","\"")
     data=json.decode(data)
     if data~=nil then
      local value=data.name
      if value~="" then
       RouteCounter=RouteCounter + 1
       table.insert(order_routes_list, value)
      end
     end
    end
    table.sort(order_routes_list)

    routes_list={}
    RouteCounter=0
    for i=1, #order_routes_list do
     local dbkeysort=order_routes_list[i]
     for x=1, dbKeys do
      local key="Route"..x
      local data=db.getStringValue(key):gsub("@@@","\"")
      if data~="" then
       data=json.decode(data)
       data=data.name
       if dbkeysort==data then
        RouteCounter=RouteCounter +1
        routes_list[RouteCounter]={["id"]=key,["route"]=data}
       end
      end
     end
    end
    routes_pages=generating_wp_pages(14)
    routes_page_index=routes_page_index

    route_tick_index=(routes_page_index*5)-4
    for i=route_tick_index, (route_tick_index+4) do
     if i<=RouteCounter then route_name=routes_list[i].route
     else route_name="" end
     local route_tick=route_tick_[i]
    end

    routes_wp_pages=generating_wp_pages("14wp")
    routes_wp_page_index=routes_wp_page_index
    wp_tick_index=(routes_wp_page_index*5)-4

    for i=route_tick_index, (route_tick_index +4) do
     if (route_tick_[i]==">" or route_tick_[i]=="*") then
      local route_id=routes_list[i]
      if (route_id~=nil and route_id~="") then
       route_id=routes_list[i].id
       local data=db.getStringValue(route_id):gsub("@@@","\"")
       data=json.decode(data)
       WpRouteList=data
       local counter=0
       if data~=nil then
        for i,v in pairs(data) do counter=counter +1 end
       else counter=5 end
       counter=math.ceil(counter/5)*5
       for i=1, counter do
        if wp_tick_[i]~=">" then wp_tick_[i]="" end
       end
       WpTickList=json.encode(wp_tick_)
      else WpRouteList={} end
     end
    end

    screen.setScriptInput(json.encode({routes_list,WpRouteList}))

   end

--SENDING DATA
 function sync_data()
  if emitter then
   local dbKeys=db.getNbKeys()
   if dbKeys>0 then
    local counter=0
    for i=index_sync, dbKeys do
     local wp_name='wp'..i
     local wp_name=db.getStringValue(wp_name)
     if (tostring(wp_name)~=nil and tostring(wp_name)~="") then
      counter=counter + 1
      local wp_coord='wp'..i..'_coord'
      local wp_coord=db.getStringValue(wp_coord)
      system.print(ship_id.." is TRANSMITTING WP: "..wp_name)

      waypoint={wp_n=wp_name, wp_c=wp_coord}
      json_string=json.encode(waypoint,{indent=false})
      if counter<=1 then
       wp_synced=wp_synced + 1
       emitter.send("AviatorHUD", "<ShipData>"..json_string:gsub("\"","@@@"))
      else break end
     end
     sync_result="Synced ".. wp_synced .."/".. keys_number .." WP"
     prog_bar=(wp_synced * 100)/keys_number
     if index_sync<=dbKeys then
      index_sync=index_sync + 1
      delay_timer=1
      delay_id="SyncData"
      unit.setTimer("delay", 0.5)
     end
    end
    LuaScreen()
   end
  else sync_result="No Emitter/Receiver" end
 end

--RECEIVING DATA
 function reqst_waypoints()
  emitter.send("AviatorHUD", "<ShipRqst>")
  WP_request=true
  sync_result=">> Uplink << ".. msg_counter .."/".. receiving_wp
 end

 msg_counter=0
 function receiving_data()
  keypad_input_wpname=rcv_msg.wp_n
  from_coordinates=rcv_msg.wp_c
  wp_check()
  LuaScreen()
 end

 fleet_msg_counter=0
 function receiving_FleetData()
  local StoredFleetData=db.getStringValue("Fleet")
  StoredFleetData=json.decode(StoredFleetData)
  if StoredFleetData==nil then StoredFleetData={} end
  local ShipName=rcv_msg.sh_n
  local ShipID=rcv_msg.sh_id
  local ShipExist=false
  for i=1, #StoredFleetData do
   if ShipName==StoredFleetData[i].n then ShipExist=true break end
  end
  if not ShipExist then table.insert(StoredFleetData, {["n"]=ShipName,["id"]=ShipID}) end
  
  StoredFleetData=json.encode(StoredFleetData)
  db.setStringValue("Fleet", StoredFleetData)
  LuaScreen()
 end

--SCREEN SCRIPT BUILDIER
 atlas_list_page()
 function LuaScreen()

 --Parameters
  local Parameters=[[
  local FontName=]].. FontName ..[[
  local FontSize=]].. FontSize ..[[
  local FontColorR, FontColorG, FontColorB=]].. Font_R ..[[, ]].. Font_G ..[[, ]]..Font_B ..[[
  local TitleR, TitleG, TitleB=]].. Title_R ..[[, ]].. Title_G ..[[, ]]..Title_B ..[[
  local MenuButtonWidth=]].. MenuButtonWidth ..[[
  local MenuButtonHeight=]].. MenuButtonHeight ..[[
  local MenuKeyWidth=]].. MenuKeyWidth ..[[
  local MenuKeyHeight=]].. MenuKeyHeight ..[[
  local ButtonSep=]].. ButtonSep ..[[
  local ButtonColorR, ButtonColorG, ButtonColorB=]].. Button_R ..[[, ]].. Button_G ..[[, ]].. Button_B ..[[
  local TableR, TableG, TableB=]].. Table_R ..[[, ]].. Table_G ..[[, ]].. Table_B ..[[
  local ButtonPressedR, ButtonPressedG, ButtonPressedB=]].. Button_Pressed_R ..[[, ]].. Button_Pressed_G ..[[, ]].. Button_Pressed_B ..[[
  local ButtonEdgeR, ButtonEdgeG, ButtonEdgeB=192, 192, 192
  local UnitsColorR, UnitsColorG, UnitsColorB=0, 255, 255
  local SelectColorR, SelectColorG, SelectColorB=0, 255, 255
  local SelectedColorR, SelectedColorG, SelectedColorB=]].. Title_R ..[[, ]].. Title_G ..[[, ]]..Title_B ..[[
  ]]

 --Setup
  local Setup=[[
  local json=require('dkjson')

  --Layers
   local L_table=createLayer()
   local L_menu=createLayer()
   local L_text=createLayer()
   local L_title=createLayer()
   local L_units=createLayer()
   local L_select=createLayer()
   local L_selected=createLayer()

  --Cursor
   local rx, ry=getResolution()
   local cx, cy=getCursor()

  --Default
   setDefaultFillColor(L_text, Shape_Text, FontColorR, FontColorG, FontColorB, 1)
   setDefaultFillColor(L_title, Shape_Text, TitleR, TitleG, TitleB, 1)
   setDefaultFillColor(L_units, Shape_Text, UnitsColorR, UnitsColorG, UnitsColorB, 1)
   setDefaultFillColor(L_select, Shape_Text, SelectColorR, SelectColorG, SelectColorB, 1)
   setDefaultFillColor(L_selected, Shape_Text, SelectedColorR, SelectedColorG, SelectedColorB, 1)
   setDefaultStrokeColor(L_table, Shape_Line, TableR, TableG, TableB, 1)
   setDefaultStrokeWidth(L_table, Shape_Line, 2)

  --Fonts
   local FontText=loadFont(FontName , FontSize)
   local FontTitle=loadFont(FontName , FontSize+5)
   local FontTick=loadFont(FontName , FontSize+10)


  --Function drawTextBox
   function drawTextBox(font, text, x, y, w, h, r)
    local ww, hh=getTextBounds(font, text)
    if w==0 or w<ww then w=ww end if h==0 or h<hh then h=hh end
    setNextFillColor(L_menu, ButtonColorR, ButtonColorG, ButtonColorB, 1)
    setNextStrokeColor(L_menu, ButtonEdgeR, ButtonEdgeG, ButtonEdgeB, 1)
    setNextStrokeWidth(L_menu, 0.2)
    addBoxRounded(L_menu, x, y, w, h, r)
    setNextTextAlign(L_text, AlignH_Center, AlignV_Middle)
    addText(L_text, font, text, x+w/2, y+h/2)
   end
   ]]

 --Lists
  local MenuLists=[[
  local MenuLines={]].. Menu_Line1 ..[[,]].. Menu_Line2 ..[[,]].. Menu_Line3 ..[[,]].. Menu_Line4 ..[[,]].. Menu_Line5 ..[[,]].. Menu_Line6 ..[[,]].. Menu_Line7 ..[[,]].. Menu_Line8 ..[[,]].. Menu_Line9 ..[[,]].. Menu_Line10 ..[[,]].. Menu_Line11 ..[[}
  local xMenu={10,300,590,880,10,155,300,590,880,10,155}
  local MenuList={"Time Calculator","From","Destination","Shield","AD/RN WP","CLR WP","Settings","PE Target Altitude","AGG","WP/ATLAS","INV Route"}

  local xKeypad={10,80,150,220,260,10,80,150,220,260,10,80,150,220,10,80,150,220,260}
  local KeyPadList={"1","2","3","U","u","4","5","6","D","d","7","8","9","CAPS","CLR","0","ENT",".","-"}

  local xKeys={12,84,156,228,300,372,444,516,588,660,732,804,876,948,12,84,156,228,300,372,444,516,588,660,732,804,876,948}
  local KeyList1={"A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z","_","moon"}
  local KeyList2={"a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z","_","moon"}

  --Function TableNumbers
   function TableNumbers(page)
    local x, y, k=0, 0, 3
    local index=(page*10)-9
    for i=index, (index+4) do
     xL=xKeys[5]+MenuKeyWidth/2+5
     nL=i
     xR=xKeys[10]+MenuKeyWidth/2+5
     nR=i+5
     k=k+1
     y=MenuLines[k]+MenuKeyHeight/2+5
     setNextTextAlign(L_title, AlignH_Center, AlignV_Middle)
     addText(L_title, FontTitle, nL, xL, y)
     setNextTextAlign(L_title, AlignH_Center, AlignV_Middle)
     addText(L_title, FontTitle, nR, xR, y)
    end
   end
  ]]

 --Create Menu Buttons
  local MenuButtons=[[
  for i=1, #MenuList do
   local w, h=MenuButtonWidth, MenuButtonHeight
   local line=0
   if (i==4 or i==9) then w=MenuButtonWidth-146
   elseif (i==5 or i==6 or i==10 or i==11) then w=MenuButtonWidth/2-5
   end
   if i<=4 then line=MenuLines[1]
   elseif i<=9 then line=MenuLines[2]
   elseif i>=10 then line=MenuLines[3]
   end
   drawTextBox(FontText, MenuList[i], xMenu[i], line, w, h, 5)
  end
  ]]

 --Create KeyPad Buttons
  local KkeypadButtons=[[
  for i=1, #KeyPadList do
   local w, h=MenuKeyWidth, MenuKeyHeight
   local line=0
   if (i==4 or i==5 or i==9 or i==10 or i==18 or i==19) then w=MenuKeyWidth/2 end
   if i<=5 then line=MenuLines[5]
   elseif i<=10 then line=MenuLines[6]
   elseif i<=14 then line=MenuLines[7]
   elseif i>=15 then line=MenuLines[8]
   end
   drawTextBox(FontText, KeyPadList[i], xKeypad[i], line, w, h, 5)
  end
  ]]
 
 --Create Keys Buttons
  local KeysButton=[[
  CAPS=]].. tostring(CAPS) ..[[
  for i=1, #KeyList1 do
   local w, h=MenuKeyWidth, MenuKeyHeight
   local line=0
   local key=""
   if i<=14 then line=MenuLines[10]
   elseif i>=15 then line=MenuLines[11]
   end
   if CAPS then key=KeyList1[i] else key=KeyList2[i] end
   drawTextBox(FontText, key, xKeys[i], line, w, h, 5)
  end
  ]]
  
 --Cursor Click
  local CursorClick=[[
  local label="" setOutput(label)
  if getCursorDown() then
   local condition, xS, yS=0, 0, 0

   for i=1, #MenuList do
    local w, h=MenuButtonWidth, MenuButtonHeight
    local line=0
    if (i==4 or i==9) then w=MenuButtonWidth-146
    elseif (i==5 or i==6 or i==10 or i==11) then w=MenuButtonWidth/2-5
    end
    if i<=4 then line=MenuLines[1]
    elseif i<=9 then line=MenuLines[2]
    elseif i>=10 then line=MenuLines[3]
    end
    local x1, x2=xMenu[i], xMenu[i]+w 
    local y1, y2=line, line+h
    if cx>x1 and cx<x2 and cy>y1 and cy<y2 then label=MenuList[i] xS=x1 yS=y1 condition=1 end
   end

   for i=1, #KeyPadList do
    local w, h=MenuKeyWidth, MenuKeyHeight
    local line=0
    if (i==4 or i==5 or i==9 or i==10 or i==18) then w=MenuKeyWidth/2 end
    if i<=5 then line=MenuLines[5]
    elseif i<=10 then line=MenuLines[6]
    elseif i<=14 then line=MenuLines[7]
    elseif i>=15 then line=MenuLines[8]
    end
    local x1, x2=xKeypad[i], xKeypad[i]+w
    local y1, y2=line, line+h
    if cx>x1 and cx<x2 and cy>y1 and cy<y2 then label=KeyPadList[i] xS=x1 yS=y1 condition=2 end
   end
 
   for i=1, #xKeys do
    local h, w=MenuKeyHeight, MenuKeyWidth
    local line=0
    local key=""
    if i<=14 then line=MenuLines[10]
    elseif i>=15 then line=MenuLines[11]
    end
    local x1, x2=xKeys[i], xKeys[i]+w
    local y1, y2=line, line+h
    if CAPS then key=KeyList1[i] else key=KeyList2[i] end
    if cx>x1 and cx<x2 and cy>y1 and cy<y2 then label=key xS=x1 yS=y1 condition=3 end
   end

   if condition>0  then
    local w, h=0, 0
    if condition==1 then
     w, h=MenuButtonWidth, MenuButtonHeight
     if (label=="Shield" or label=="AGG") then w=MenuButtonWidth-146
     elseif (label=="AD/RN WP" or label=="CLR WP" or label=="WP/ATLAS" or label=="INV Route") then w=MenuButtonWidth/2-5
     end
    elseif condition==2 then 
     h, w=MenuKeyHeight, MenuKeyWidth
     if (label=="U" or label=="u" or label=="D" or label=="d" or label=="." or label=="-") then w=MenuKeyWidth/2
     elseif label=="CAPS" then w=68
     end
    elseif condition==3 then 
     h, w=MenuKeyHeight, MenuKeyWidth
     if label=="moon" then w=72 end
    end

    if condition==2 then
     if label=="U" then label="arrowUP"
     elseif label=="u" then label="arrowup"
     elseif label=="D" then label="arrowDN"
     elseif label=="d" then label="arrowdn"
     end
    end
    
    condition=0

    local L_keypressed=createLayer()
    setNextFillColor(L_keypressed, ButtonPressedR, ButtonPressedG, ButtonPressedB, 0.2)
    setNextStrokeColor(L_keypressed, ButtonPressedR, ButtonPressedG, ButtonPressedB, 1)
    setNextStrokeWidth(L_keypressed, 1)
    addBoxRounded(L_keypressed, xS, yS, w, h, 5)
    setOutput(label)
   end

  end
  ]]

 --Screen Data Status
  function DataStatus_Table_Function()
   local Table=[[
   local DataStatus_List={[1]="Ship ID",[3]="]].. ship_id ..[[",[8]="Stored",[12]="]].. status_FM ..[[",[13]="]].. status_TO ..[[",[14]="]].. status_TA ..[["}
   for i=1, 14 do
    if (i==9 or i==10) then
     local x1, y1, x2, y2=xKeys[1], MenuLines[i], xKeys[14]+MenuKeyWidth, MenuLines[i]
     if i==10 then
      x1, y1, x2, y2=xKeys[1], MenuLines[i]-ButtonSep, xKeys[14]+MenuKeyWidth, MenuLines[i]-ButtonSep
     end
     addLine(L_table, x1, y1, x2, y2)
    end

    if (i==1 or i==3 or i==8 or i>=12) then
     local x, y, x1, y1, x2, y2=xKeys[i]+ButtonSep, MenuLines[9]+MenuKeyHeight/2, xKeys[i], MenuLines[9], xKeys[i], MenuLines[10]-ButtonSep
     local Align=AlignH_Left
     addLine(L_table, x1, y1, x2, y2)
     if i==14 then
      x1=xKeys[i]+MenuKeyWidth x2=x1
      addLine(L_table, x1, y1, x2, y2)
     end
     if i>=12 then
      Align=AlignH_Center
      x=xKeys[i]+MenuKeyWidth/2+5
     end
     setNextTextAlign(L_table, Align, AlignV_Middle)
     if (i==1 or i==8) then
      setNextFillColor(L_table, TitleR, TitleG, TitleB, 1)
      addText(L_table, FontTitle, DataStatus_List[i], x, y)
     else addText(L_table, FontText, DataStatus_List[i], x, y) end
    end
   end
   ]]
   return Table
  end

 --Screen WP
  function WPStore_Table_Function()
   local Table=[[
   local wp_page_index=]].. wp_page_index ..[[
   local wp_pages=]].. wp_pages ..[[
   local wp_counter=]].. wp_counter ..[[
   local Title={"WP","Page ".. wp_page_index .."/".. wp_pages}
  
   for i=3, 14 do
    if i<=8 then
     local x1, y1, x2, y2=xKeys[5], MenuLines[i], xKeys[14]+MenuKeyWidth, MenuLines[i]
     addLine(L_table, x1, y1, x2, y2)
    end
  
    if (i==5 or i==6 or i==10 or i==11 or i==14) then
     local x1, y1, x2, y2=xKeys[i], MenuLines[3], xKeys[i], MenuLines[9]
     if (i>5 and i<14) then y1=MenuLines[4] end
     if i==14 then x1=xKeys[i]+MenuKeyWidth x2=x1 end
     addLine(L_table, x1, y1, x2, y2)
    end
   end

   TableNumbers(wp_page_index)

   function WP_Table_List_Function()
    for i=1, #Title do
     local x, y=0, 0
     if i==1 then x=xKeys[8] else x=xKeys[13] end
     y=MenuLines[3]+MenuKeyHeight/2+5
     setNextTextAlign(L_title, AlignH_Center, AlignV_Middle)
     addText(L_title, FontTitle, Title[i], x, y)
    end

    local wp_list=json.decode(getInput()) or {}
    local xL, xR, y, L, settingsL, settingsR=0, 0, 0, 3, "", ""
    if Selected==nil then Selected=false end

    for i=1, 5 do
     if wp_list[i]~=nil then
      wp_id_L=wp_list[i].name
      settingsL=wp_list[i].settings
      xL=xKeys[6]+ButtonSep
     else
      wp_id_L=""
      xL=xKeys[6]+ButtonSep
     end
     if wp_list[i+5]~=nil then
      wp_id_R=wp_list[i+5].name
      settingsR=wp_list[i+5].settings
      xR=xKeys[11]+ButtonSep
     else
      wp_id_R=""
      xR=xKeys[11]+ButtonSep
     end
     L=L+1
     y=MenuLines[L]+MenuKeyHeight/2+5
     if (cx>xL and cx<xKeys[10] and cy>MenuLines[L] and cy<MenuLines[L]+MenuKeyHeight+ButtonSep) then
      setNextTextAlign(L_select, AlignH_Left, AlignV_Middle)
      addText(L_select, FontText, wp_id_L, xL, y)
      if getCursorDown() then
       Selected=true
       SelectedID=wp_id_L
       setOutput(wp_id_L)
      end
     else
      setNextTextAlign(L_text, AlignH_Left, AlignV_Middle)
      if settingsL=="*" then setNextFillColor(L_text, 0, 1, 0, 1) end
      addText(L_text, FontText, wp_id_L, xL, y)
     end
     if (cx>xR and cx<xKeys[14]+MenuKeyWidth+ButtonSep and cy>MenuLines[L] and cy<MenuLines[L]+MenuKeyHeight+ButtonSep) then
      setNextTextAlign(L_select, AlignH_Left, AlignV_Middle)
      addText(L_select, FontText, wp_id_R, xR, y)
      if getCursorDown() then
       Selected=true
       SelectedID=wp_id_R
       setOutput(wp_id_R)
      end
     else
      setNextTextAlign(L_text, AlignH_Left, AlignV_Middle)
      if settingsR=="*" then setNextFillColor(L_text, 0, 1, 0, 1) end
      addText(L_text, FontText, wp_id_R, xR, y)
     end

     if Selected then
      setNextTextAlign(L_selected, AlignH_Center, AlignV_Middle)
      addText(L_selected, FontText, SelectedID, xKeys[3], MenuLines[4]+MenuKeyHeight/2) 
     end

    end

   end
   WP_Table_List_Function()

   requestAnimationFrame(10)
   ]]
   return Table
  end

 --Screen ATLAS
  function ATLAS_Table_Function()
   local Table=[[
   local atlas_page_index=]].. atlas_page_index ..[[
   local atlas_pages=]].. atlas_pages ..[[
   local atlas_counter=]].. atlas_counter ..[[
   local Title={"ATLAS","Page ".. atlas_page_index .."/".. atlas_pages}
   
   for i=3, 14 do
    if i<=8 then
     local x1, y1, x2, y2=xKeys[5], MenuLines[i], xKeys[14]+MenuKeyWidth, MenuLines[i]
     addLine(L_table, x1, y1, x2, y2)
    end

    if (i==5 or i==6 or i==10 or i==11 or i==14) then
     local x1, y1, x2, y2=xKeys[i], MenuLines[3], xKeys[i], MenuLines[9]
     if (i>5 and i<14) then y1=MenuLines[4] end
     if i==14 then x1=xKeys[i]+MenuKeyWidth x2=x1 end
     addLine(L_table, x1, y1, x2, y2)
    end
   end

   TableNumbers(atlas_page_index)

   function ATLAS_Table_List_Function()
    for i=1, #Title do
     local x, y=0, 0
     if i==1 then x=xKeys[8] else x=xKeys[13] end
     y=MenuLines[3]+MenuKeyHeight/2+5
     setNextTextAlign(L_title, AlignH_Center, AlignV_Middle)
     addText(L_title, FontTitle, Title[i], x, y)
    end

    local atlas_list=json.decode(getInput()) or {}
    local xL, xR, y, L=0, 0, 0, 3
    local index=(atlas_page_index*10)-9
    if Selected==nil then Selected=false end

    for i=index, (index+4) do
     if i<=atlas_counter then
      atlas_id_L=atlas_list[i]
      xL=xKeys[6]+ButtonSep
     else
      atlas_id_L=""
      xL=xKeys[6]+ButtonSep
     end
     if (i+5)<=atlas_counter then
      atlas_id_R=atlas_list[i+5]
      xR=xKeys[11]+ButtonSep
     else
      atlas_id_R=""
      xR=xKeys[11]+ButtonSep
     end
     L=L+1
     y=MenuLines[L]+MenuKeyHeight/2+5
     if (cx>xL and cx<xKeys[10] and cy>MenuLines[L] and cy<MenuLines[L]+MenuKeyHeight+ButtonSep) then
      setNextTextAlign(L_select, AlignH_Left, AlignV_Middle)
      addText(L_select, FontText, atlas_id_L, xL, y)
      if getCursorDown() then
       Selected=true
       SelectedID=atlas_id_L
       setOutput(atlas_id_L)
      end
     else
      setNextTextAlign(L_text, AlignH_Left, AlignV_Middle)
      addText(L_text, FontText, atlas_id_L, xL, y)
     end
     if (cx>xR and cx<xKeys[14]+MenuKeyWidth+ButtonSep and cy>MenuLines[L] and cy<MenuLines[L]+MenuKeyHeight+ButtonSep) then
      setNextTextAlign(L_select, AlignH_Left, AlignV_Middle)
      addText(L_select, FontText, atlas_id_R, xR, y)
      if getCursorDown() then
       Selected=true
       SelectedID=atlas_id_R
       setOutput(atlas_id_R)
      end
     else
      setNextTextAlign(L_text, AlignH_Left, AlignV_Middle)
      addText(L_text, FontText, atlas_id_R, xR, y)
     end
     
     if Selected then
      setNextTextAlign(L_selected, AlignH_Center, AlignV_Middle)
      addText(L_selected, FontText, SelectedID, xKeys[3], MenuLines[4]+MenuKeyHeight/2) 
     end

    end
   end
   ATLAS_Table_List_Function()

   requestAnimationFrame(10)
   ]]
   return Table
  end

 --Screen SU Distance Time
  function SuDistanceTime_Table_Function()
   local Table=[[
   local Title={"Insert The Distance","Insert Cruising Speed or press ENT:","ETA After:","Warp Cells:", "Max:"}
   local Units={"Su","Km/h"}
   local Tick={"]].. su_tick ..[[",]].. keypad_input_su ..[[,"]].. speed_tick ..[[",]].. keypad_input_speed ..[[}
   local Results={]].. time_to_go ..[[,"]].. MinWpCells ..[[","]].. MaxWpCells ..[["}

   for i=3, 14 do
    if i<=8 then
     local x1, y1, x2, y2=xKeys[5], MenuLines[i], xKeys[14]+MenuKeyWidth, MenuLines[i]
     addLine(L_table, x1, y1, x2, y2)
    end

    if (i==5 or i==6 or i==10 or i==14) then
     local x1, y1, x2, y2=xKeys[i], MenuLines[3], xKeys[i], MenuLines[9]
     if i==10 then y1=MenuLines[7] end
     if i==14 then x1=xKeys[i]+MenuKeyWidth x2=x1 end
     addLine(L_table, x1, y1, x2, y2)
    end
   end

   function SuDistanceTime_Table_List_Function()
    local x, y, k=0, 0, 1
    for i=1, #Title do
     if i<=3 then x=xKeys[6]+ButtonSep
     elseif i==4 then x=xKeys[10]+ButtonSep
     elseif i==5 then x=xKeys[12]+ButtonSep
     end
     if i<=3 then k=k+2
     elseif i==4 then k=k 
     elseif i==5 then k=k+1
     end
     y=MenuLines[k]+MenuKeyHeight/2+5
     setNextTextAlign(L_title, AlignH_Left, AlignV_Middle)
     addText(L_title, FontTitle, Title[i], x, y)
    end

    for i=1, #Units do
     x=xKeys[6]+ButtonSep
     if i==1 then k=4 else k=6 end
     y=MenuLines[k]+MenuKeyHeight/2+5
     setNextTextAlign(L_units, AlignH_Left, AlignV_Middle)
     addText(L_units, FontText, Units[i], x, y)
    end

    for i=1, #Tick do
     local Align=AlignH_Left
     if i%2==1 then
      x=xKeys[5]+MenuKeyWidth/2+5
      Align=AlignH_Center
     else x=xKeys[7]+ButtonSep end
     if i<=2 then k=4 else k=6 end
     y=MenuLines[k]+MenuKeyHeight/2+5
     setNextTextAlign(L_text, Align, AlignV_Middle)
     addText(L_text, FontTick, Tick[i], x, y)
    end

    for i=1, #Results do
     if i==1 then x=xKeys[6]+ButtonSep
     elseif i==2 then x=xKeys[10]+ButtonSep
     elseif i==3 then x=xKeys[13]+ButtonSep
     end
     y=MenuLines[8]+MenuKeyHeight/2+5
     setNextTextAlign(L_text, AlignH_Left, AlignV_Middle)
     addText(L_text, FontText, Results[i], x, y)
    end

   end
   SuDistanceTime_Table_List_Function()
   ]]
   return Table
  end

 --Screen From
  function from_Table_Function()
   local Table=[[
   local Title={"Insert Departure or press ENT","Coordinates:","Add/Rename WP"}
   local Tick={"]].. FROM_tick ..[[","]].. keypad_input_from ..[[","]].. WPADD_tick ..[[","]].. keypad_input_wpname ..[["}
   local Results={"]].. tostring(from_coordinates) ..[[","]].. stored ..[["}

   for i=3, 14 do
    if i<=8 then
     local x1, y1, x2, y2=xKeys[5], MenuLines[i], xKeys[14]+MenuKeyWidth, MenuLines[i]
     addLine(L_table, x1, y1, x2, y2)
    end
   
    if (i==5 or i==6 or i==10 or i==14) then
     local x1, y1, x2, y2=xKeys[i], MenuLines[3], xKeys[i], MenuLines[9]
     if i==6 then y2=MenuLines[6] y3=MenuLines[7] y4=MenuLines[9] end
     if i==10 then y1=MenuLines[8] end
     if i==14 then x1=xKeys[i]+MenuKeyWidth x2=x1 end
     addLine(L_table, x1, y1, x2, y2)
     if i==6 then addLine(L_table, x1, y3, x2, y4) end
    end
   end

   function from_Table_List_Function()
    local x, y , k=0, 0, 3
    for i=1, #Title do
     x=xKeys[6]+ButtonSep
     if i>1 then k=k+2 end
     y=MenuLines[k]+MenuKeyHeight/2+5
     setNextTextAlign(L_title, AlignH_Left, AlignV_Middle)
     addText(L_title, FontTitle, Title[i], x, y)
    end

    for i=1, #Tick do
     local Align=AlignH_Left
     if i%2==1 then
      x=xKeys[5]+MenuKeyWidth/2+5
      Align=AlignH_Center
     else x=xKeys[6]+ButtonSep end
     if i<=2 then k=4 else k=8 end
     y=MenuLines[k]+MenuKeyHeight/2+5
     setNextTextAlign(L_text, Align, AlignV_Middle)
     addText(L_text, FontTick, Tick[i], x, y)
    end

    for i=1, #Results do
     if i==1 then
      x=xKeys[5]+ButtonSep
      y=MenuLines[6]+MenuKeyHeight/2+5
     elseif i==2 then
      x=xKeys[10]+ButtonSep
      y=MenuLines[8]+MenuKeyHeight/2+5
     end
     setNextTextAlign(L_text, AlignH_Left, AlignV_Middle)
     addText(L_text, FontText, Results[i], x, y)
    end

   end
   from_Table_List_Function()
   ]]
   return Table
  end

 --Screen To
  function distance_to_wp_Table_Function()
   local Table=[[
   local Title={"Insert Destination","Distance:","Warp Cells:","Max:","Coordinates:"}
   local Tick={">","]].. keypad_input_dest ..[["}
   local Units={"Su"}
   local Results={"]].. distance_to_go ..[[","]].. MinWpCells ..[[","]].. MaxWpCells ..[[","]].. tostring(destination_coord) ..[["}

   for i=3, 14 do
    if i<=8 then
     local x1, y1, x2, y2=xKeys[5], MenuLines[i], xKeys[14]+MenuKeyWidth, MenuLines[i]
     addLine(L_table, x1, y1, x2, y2)
    end

    if (i==5 or i==6 or i==10 or i==14) then
     local x1, y1, x2, y2=xKeys[i], MenuLines[3], xKeys[i], MenuLines[9]
     if i==6 then y2=MenuLines[8] end
     if i==10 then y1=MenuLines[5] y2=MenuLines[7] end
     if i==14 then x1=xKeys[i]+MenuKeyWidth x2=x1 end
     addLine(L_table, x1, y1, x2, y2)
    end
   end

   function distance_to_wp_Table_List_Function()
    local x, y , k=0, 0, 2
    for i=1, #Title do
     x=xKeys[6]+ButtonSep
     if i==3 then x=xKeys[10]+ButtonSep end
     if i==4 then x=xKeys[12]+ButtonSep end
     if i==2 then k=5 elseif i==3 then k=k elseif i==4 then k=6 else k=k+1 end
     y=MenuLines[k]+MenuKeyHeight/2+5
     setNextTextAlign(L_title, AlignH_Left, AlignV_Middle)
     addText(L_title, FontTitle, Title[i], x, y)
    end

    for i=1, #Units do
     x=xKeys[6]+ButtonSep
     y=MenuLines[6]+MenuKeyHeight/2+5
     setNextTextAlign(L_units, AlignH_Left, AlignV_Middle)
     addText(L_units, FontText, Units[i], x, y)
    end

    for i=1, #Tick do
     local Align=AlignH_Left
     if i==1 then
      x=xKeys[5]+MenuKeyWidth/2+5
      Align=AlignH_Center
     else x=xKeys[6]+ButtonSep end
     y=MenuLines[4]+MenuKeyHeight/2+5
     setNextTextAlign(L_text, Align, AlignV_Middle)
     addText(L_text, FontTick, Tick[i], x, y)
    end

    for i=1, #Results do
     if i==1 then x=xKeys[7]+ButtonSep end
     if i==2 then x=xKeys[10]+ButtonSep end
     if i==3 then x=xKeys[13]+ButtonSep end
     y=MenuLines[6]+MenuKeyHeight/2+5
     if i==4 then x=xKeys[5]+ButtonSep y=MenuLines[8]+MenuKeyHeight/2+5 end
     setNextTextAlign(L_text, AlignH_Left, AlignV_Middle)
     addText(L_text, FontText, Results[i], x, y)
    end

   end
   distance_to_wp_Table_List_Function()
   ]]
   return Table
  end

 --Screen PE Altitude
  function target_pe_altitude_Table_Function()
   local Table=[[
   local Title={"Insert PE Target Altitude","Stored Altitude"}
   local Units={"m","m"}
   local Tick={]].. keypad_input_pe_target_alt ..[[}
   local Results={"]].. target_alt_warning ..[[",]].. stored_pe_target_alt ..[[}

   for i=3, 14 do
    if i<=8 then
     local x1, y1, x2, y2=xKeys[5], MenuLines[i], xKeys[14]+MenuKeyWidth, MenuLines[i]
     addLine(L_table, x1, y1, x2, y2)
    end

    if (i==5 or i==14) then
     local x1, y1, x2, y2=xKeys[i], MenuLines[3], xKeys[i], MenuLines[9]
     if i==14 then x1=xKeys[i]+MenuKeyWidth x2=x1 end
     addLine(L_table, x1, y1, x2, y2)
    end
   end

   function target_pe_altitude_Table_List_Function()
    local x, y , k=0, 0, 3
    for i=1, #Title do
     x=xKeys[5]+ButtonSep
     if i>1 then k=k+3 end
     y=MenuLines[k]+MenuKeyHeight/2+5
     setNextTextAlign(L_title, AlignH_Left, AlignV_Middle)
     addText(L_title, FontTitle, Title[i], x, y)
    end

    for i=1, #Units do
     x=xKeys[5]+ButtonSep
     if i==1 then k=4 else k=7 end
     y=MenuLines[k]+MenuKeyHeight/2+5
     setNextTextAlign(L_units, AlignH_Left, AlignV_Middle)
     addText(L_units, FontText, Units[i], x, y)
    end

    for i=1, #Tick do
     x=xKeys[6]+ButtonSep
     y=MenuLines[4]+MenuKeyHeight/2+5
     setNextTextAlign(L_text, AlignH_Left, AlignV_Middle)
     addText(L_text, FontTick, Tick[i], x, y)
    end

    for i=1, #Results do
     if i==1 then
      x=xKeys[5]+ButtonSep
      y=MenuLines[5]+MenuKeyHeight/2+5
     elseif i==2 then
      x=xKeys[6]+ButtonSep
      y=MenuLines[7]+MenuKeyHeight/2+5
     end
     setNextTextAlign(L_text, AlignH_Left, AlignV_Middle)
     addText(L_text, FontText, Results[i], x, y)
    end

   end
   target_pe_altitude_Table_List_Function()
   ]]
   return Table
  end

 --Screen AGG
  function agg_Table_Function()
   local Table=[[
   local agg_eng_stby="]].. agg_eng_stby ..[["
   local agg_target_altitude=]].. tostring(agg_target_altitude) ..[[
   local agg_base_altitude="]].. agg_base_altitude ..[["
   if tonumber(agg_base_altitude)~=nil then math.floor(agg_base_altitude) end
   local ALTDiffCheck="]].. ALTDiffCheck ..[["
   local Title={"Anti Gravity Generator","AGG Altitude",agg_base_altitude,"Target Altitude","Ship Altitude","]].. ship_altitude ..[["}
   local Buttons={"]].. AGG_Off_Stby ..[[","]].. AGG_Eng_Dis ..[["}
   local Units={"m","m","m"}
   local Tick={"]].. agg_tick_input ..[[","]].. keypad_input_agg_target_alt ..[["}
   local Results={"]].. agg_off_stby ..[["}

   for i=3, 14 do
    if i<=7 then
     local x1, y1, x2, y2=xKeys[5], MenuLines[i], xKeys[14]+MenuKeyWidth, MenuLines[i]
     addLine(L_table, x1, y1, x2, y2)
    end

    if (i==5 or i==6 or i==7 or i==10 or i==12 or i==14) then
     local x1, y1, x2, y2=xKeys[i], MenuLines[3], xKeys[i], MenuLines[9]
     if i==6 then y1=MenuLines[5] y2=MenuLines[6] end
     if (i==7 or i==12) then y1=MenuLines[7] end
     if i==10 then y1=MenuLines[4] end
     if i==14 then x1=xKeys[i]+MenuKeyWidth x2=x1 end
     addLine(L_table, x1, y1, x2, y2)
    end
   end

   function agg_Table_List_Function()
    local x, y, k=0, 0, 2
    for i=1, #Title do
     local AlignH=AlignH_Left
     local AlignV=AlignV_Middle
     if i==1 then x=xKeys[10] k=3 AlignH=AlignH_Center
     elseif i==2 then x=xKeys[5]+ButtonSep k=4
     elseif i==3 then
      if agg_base_altitude=="PB Not Linked to AGG" then
       x=xKeys[10]+ButtonSep
       setNextFillColor(L_title, 1, 0, 0, 1)
      else x=xKeys[11]+ButtonSep end
     elseif i==4 then x=xKeys[6]+ButtonSep k=5
     elseif i==5 then x=xKeys[5]+ButtonSep k=6
     elseif i==6 then x=xKeys[11]+ButtonSep
     end
     y=MenuLines[k]+MenuKeyHeight/2+5
     if ((i==3 or i==6) and ALTDiffCheck=="GREEN") then setNextFillColor(L_title, 0, 1, 0, 1) end 
     setNextTextAlign(L_title, AlignH, AlignV)
     addText(L_title, FontTitle, Title[i], x, y)
    end

    for i=1, #Buttons do
     local xCur1, xCur2=xKeys[5], xKeys[7]
     if i==1 then x=xKeys[6] setNextFillColor(L_text, 1, 0, 0, 1)
     else
      x=xKeys[11]
      xCur1, xCur2=xKeys[10], xKeys[12]
      setNextFillColor(L_text, 0, 1, 0, 1)
     end
     y=MenuLines[8]
     local yCur1, yCur2=MenuLines[7], MenuLines[9]
     setNextTextAlign(L_text, AlignH_Center, AlignV_Middle)
     addText(L_text, FontText, Buttons[i], x, y)
     if (Buttons[i]=="OFF" or Buttons[i]=="STBY" or Buttons[i]=="ENGAGE") then
      if (cx>xCur1 and cx<xCur2 and cy>yCur1 and cy<yCur2) then
       local Width=xCur2-xCur1
       local Height=yCur2-yCur1
       setNextFillColor(L_text, ButtonPressedR, ButtonPressedG, ButtonPressedB, 0.1)
       addBox(L_text, xCur1+2, yCur1+2, Width, Height)
       if getCursorDown() then setOutput(Buttons[i]) end
      end
     end
    end

    k=3
    local UnitIndex=1
    if agg_base_altitude=="PB Not Linked to AGG" then UnitIndex=2 k=4 end
    for i=UnitIndex, #Units do
     x=xKeys[10]+ButtonSep
     k=k+1
     y=MenuLines[k]+MenuKeyHeight/2+5
     setNextTextAlign(L_units, AlignH_Left, AlignV_Middle)
     addText(L_units, FontText, Units[i], x, y)
    end

    for i=1, #Tick do
     local Align=AlignH_Left
     if i==1 then x=xKeys[5]+MenuKeyWidth/2+5 Align=AlignH_Center
     else x=xKeys[11]+ButtonSep end
     y=MenuLines[5]+MenuKeyHeight/2+5
     if Tick[i]=="X" then setNextFillColor(L_text, 1, 0, 0, 1) end
     if (i==2 and agg_target_altitude) then setNextFillColor(L_text, TitleR, TitleG, TitleB, 1) end
     setNextTextAlign(L_text, Align, AlignV_Middle)
     addText(L_text, FontTick, Tick[i], x, y)
    end

    for i=1, #Results do
     x=xKeys[8]+MenuKeyWidth/2+5
     y=MenuLines[8]
     local xBOX=xKeys[12]+ButtonSep
     local wBOX=(xKeys[14]+MenuKeyWidth-xKeys[12])-(ButtonSep*2)
     local yBOX=MenuLines[7]+ButtonSep
     local hBOX=(MenuLines[9]-MenuLines[7])-(ButtonSep*2)
     setNextTextAlign(L_text, AlignH_Center, AlignV_Middle)
     addText(L_text, FontText, Results[i], x, y)
     if agg_eng_stby=="RED" then setNextFillColor(L_title, 1, 0, 0, 1)
     elseif agg_eng_stby=="GREEN" then setNextFillColor(L_title, 0, 1, 0, 1) end
     addBox(L_title, xBOX, yBOX, wBOX, hBOX)
    end

   end
   agg_Table_List_Function()

   requestAnimationFrame(10)
   ]]
   return Table
  end

 --Screen Shield
  function shield_Table_Function()
   local Table=[[
   local Title={"Shield","Energy Pool","A","E","K","T"}
   local Operators={"-","+","-","+","-","+","-","+"}
   local input=json.decode(getInput()) or {}
   local Buttons=input[1] or {}
   local ShieldData=input[2] or {}
   local ShieldStressTable=input[3] or {}
   local ShieldOnOff=Buttons[1]
   local ShieldSET=Buttons[3]
   local ShieldPercent=tonumber(ShieldData[1])
   local EnergyDistribution=ShieldData[7]
   local ShieldBaseEnergy=ShieldData[8]

   for i=3, 14 do
    if i<=8 then
     local x1, y1, x2, y2=xKeys[5], MenuLines[i], xKeys[14]+MenuKeyWidth, MenuLines[i]
     if i==6 then x1=xKeys[8] end
     addLine(L_table, x1, y1, x2, y2)
    end

    if (i==5 or i==8 or i==9 or i==10 or i==11 or i==12 or i==14) then
     local x1, y1, x2, y2=xKeys[i], MenuLines[3], xKeys[i], MenuLines[9]
     if (i==9 or i==10 or i==11 or i==12) then y1=MenuLines[5] end
     if i==14 then x1=xKeys[i]+MenuKeyWidth x2=x1 end
     addLine(L_table, x1, y1, x2, y2)
    end
   end

   function shield_Table_List_Function()
    local x, y, k, xCur1, xCur2, yCur1, yCur2, xCol=0, 0, 0, 0, 0, 0, 0, 0
    for i=1, #Title do
     local AlignH=AlignH_Left
     if i==1 then x=xKeys[11]+MenuKeyWidth/2 k=3 AlignH=AlignH_Center
     elseif i==2 then x=xKeys[5]+ButtonSep k=5
     elseif i==3 then x=xKeys[8]+MenuKeyWidth/2
     elseif i>=4 then k=k+1 end
     y=MenuLines[k]+MenuKeyHeight/2+5
     setNextTextAlign(L_title, AlignH, AlignV_Middle)
     addText(L_title, FontTitle, Title[i], x, y)
    end

    k=2
    for i=1, #Buttons do
     x=xKeys[6]+MenuKeyWidth/2
     xCur1=xKeys[5]
     xCur2=xKeys[8]
     if (i==1 or i==2) then k=k+1
     elseif i==3 then k=7
     elseif i==4 then k=8 end
     y=MenuLines[k]+MenuKeyHeight/2+5
     yCur1=MenuLines[k]
     yCur2=yCur1+MenuKeyHeight
     local Btn=Buttons[i]
     local Alpha=1
     if (i==1 and Btn=="RAISE") then setNextFillColor(L_text, 0, 1, 0, Alpha)
     elseif (i==1 and Btn=="DROP") then setNextFillColor(L_text, 1, 0, 0, Alpha)
     elseif (i==2 and Btn=="VENTING") then setNextFillColor(L_text, 1, 0, 0, Alpha)
     elseif (i==3 and Btn=="SET") then setNextFillColor(L_text, 0, 1, 0, Alpha)
     elseif (i==4 and Btn=="RESET") then setNextFillColor(L_text, 1, 0, 0, Alpha)
     end
     if (i==2 and Btn~="VENTING") then Alpha=0.3 setNextFillColor(L_text, 0.5, 0.5, 0.5, Alpha)
     elseif (i==3 and (Btn~="SET" or EnergyDistribution==false)) then Alpha=0.3 setNextFillColor(L_text, 0.5, 0.5, 0.5, Alpha)
     elseif(i==4 and (ShieldSET~="SET" or ShieldBaseEnergy) and EnergyDistribution==false) then Alpha=0.3 setNextFillColor(L_text, 0.5, 0.5, 0.5, Alpha)
     end
     setNextTextAlign(L_text, AlignH_Center, AlignV_Middle)
     addText(L_text, FontText, Btn, x, y)
     if ((cx>xCur1 and cx<xCur2 and cy>yCur1 and cy<yCur2) and Alpha==1) then
      local Width, Height=xCur2-xCur1, MenuKeyHeight+7
      setNextFillColor(L_text, ButtonPressedR, ButtonPressedG, ButtonPressedB, 0.1)
      addBox(L_text, xCur1+2, yCur1+2, Width, Height)
      if getCursorDown() then setOutput(Btn) end
     end
    end

    for i=1, #ShieldData-2 do
     x=xKeys[11]+MenuKeyWidth/2+5
     if i==1 then x=xKeys[13]+ButtonSep k=3 setNextFillColor(L_units, FontColorR, FontColorG, FontColorB, 1)
      ShieldData[i]=string.format("%.0f", ShieldData[i]) .." %"
     elseif i==2 then x=xKeys[6]+MenuKeyWidth/2 k=6
      if EnergyDistribution then setNextFillColor(L_units, UnitsColorR, UnitsColorG, UnitsColorB, 1)
      else setNextFillColor(L_units, FontColorR, FontColorG, FontColorB, 1) end      
     elseif i==3 then k=5 if not EnergyDistribution then setNextFillColor(L_units, TitleR, TitleG, TitleB, 1) end
     elseif i==4 then k=6 if not EnergyDistribution then setNextFillColor(L_units, TitleR, TitleG, TitleB, 1) end
     elseif i==5 then k=7 if not EnergyDistribution then setNextFillColor(L_units, TitleR, TitleG, TitleB, 1) end
     elseif i==6 then k=8 if not EnergyDistribution then setNextFillColor(L_units, TitleR, TitleG, TitleB, 1) end
     end
     y=MenuLines[k]+MenuKeyHeight/2+5
     setNextTextAlign(L_units, AlignH_Center, AlignV_Middle)
     addText(L_units, FontText, ShieldData[i], x, y)
    end

    k=4
    for i=1, #Operators do
     if i%2==1 then xCol=9 else xCol=10 end
     x=xKeys[xCol]+MenuKeyWidth/2+5
     xCur1=xKeys[xCol]+1
     xCur2=xKeys[xCol+1]-1
     if i%2==1 then k=k+1 end
     y=MenuLines[k]+MenuKeyHeight/2+5
     yCur1=MenuLines[k]+1
     yCur2=MenuLines[k+1]-1
     setNextTextAlign(L_text, AlignH_Center, AlignV_Middle)
     addText(L_text, FontTick, Operators[i], x, y)
     if ((cx>xCur1 and cx<xCur2 and cy>yCur1 and cy<yCur2) and ShieldSET=="SET") then
      local Width, Height=MenuKeyWidth+7, MenuKeyHeight+7
      setNextFillColor(L_text, ButtonPressedR, ButtonPressedG, ButtonPressedB, 0.1)
      addBox(L_text, xCur1, yCur1, Width, Height)
      local Output=""
      if i==1 then Output="A-"
      elseif i==2 then Output="A+"
      elseif i==3 then Output="E-"
      elseif i==4 then Output="E+"
      elseif i==5 then Output="K-"
      elseif i==6 then Output="K+"
      elseif i==7 then Output="T-"
      elseif i==8 then Output="T+"
      end
      if getCursorDown() then setOutput(Output) end
     end
    end

    k=4
    for i=1, #ShieldStressTable do
     k=k+1
     local x1BAR, y1BAR=xKeys[12]+4, MenuLines[k]+10
     local width=((xKeys[14]+MenuKeyWidth-xKeys[18]-8) * ShieldStressTable[i]*100)/100
     local height=MenuLines[k+1]-MenuLines[k]-20
     setNextFillColor(L_title, 0.53, 0.33, 0.97, 1)
     addBox(L_title, x1BAR, y1BAR, width, height)
    end

    if ShieldPercent>0 then
     local x1BAR, y1BAR=xKeys[8]+4, MenuLines[4]+4
     local width=((xKeys[14]+MenuKeyWidth-xKeys[8]-8) * ShieldPercent)/100
     local height=MenuLines[5]-MenuLines[4]-8
     local Alpha=1
     if ShieldOnOff=="RAISE" then Alpha=0.1 end
     setNextFillColor(L_title, TitleR, TitleG, TitleB, Alpha)
     addBox(L_title, x1BAR, y1BAR, width, height)
    end

   end
   shield_Table_List_Function()

   requestAnimationFrame(10)
   ]]
   return Table
  end

 --Screen Settings
  function settings_menu_Table_Function()
   local Table=[[
   local Title={"Settings","Page 1/1"}
   local Content={"Ship Settings","DB Reset","WP Store","Routes","WP Sync","---","Screen Colors","---","DMG Report","---"}

   for i=3, 14 do
    if i<=8 then
     local x1, y1, x2, y2=xKeys[5], MenuLines[i], xKeys[14]+MenuKeyWidth, MenuLines[i]
     addLine(L_table, x1, y1, x2, y2)
    end

    if (i==5 or i==6 or i==10 or i==11 or i==14) then
     local x1, y1, x2, y2=xKeys[i], MenuLines[3], xKeys[i], MenuLines[9]
     if (i>5 and i<14) then y1=MenuLines[4] end
     if i==14 then x1=xKeys[i]+MenuKeyWidth x2=x1 end
     addLine(L_table, x1, y1, x2, y2)
    end
   end

   TableNumbers(1)

   function settings_menu_Table_List_Function()
    for i=1, #Title do
     local x, y=0, 0
     if i==1 then x=xKeys[8] else x=xKeys[13] end
     y=MenuLines[3]+MenuKeyHeight/2+5
     setNextTextAlign(L_title, AlignH_Center, AlignV_Middle)
     addText(L_title, FontTitle, Title[i], x, y)
    end

    for i=1, #Content do
     if i%2==1 then x=xKeys[6]+ButtonSep
     else x=xKeys[11]+ButtonSep end
     if (i==1 or i==2) then k=4
     elseif (i==3 or i==4) then k=5
     elseif (i==5 or i==6) then k=6
     elseif (i==7 or i==8) then k=7
     elseif (i==9 or i==10) then k=8
     end
     y=MenuLines[k]+MenuKeyHeight/2+5
     if (cx>x-ButtonSep and cx<x+MenuButtonWidth and cy>MenuLines[k] and cy<MenuLines[k]+MenuKeyHeight+ButtonSep) then
      setNextTextAlign(L_select, AlignH_Left, AlignV_Middle)
      addText(L_select, FontText, Content[i], x, y)
      if getCursorDown() then
       Selected=true
       setOutput(Content[i])
      end
     else
      setNextTextAlign(L_text, AlignH_Left, AlignV_Middle)
      addText(L_text, FontText, Content[i], x, y)
     end

    end

   end
   settings_menu_Table_List_Function()

   requestAnimationFrame(10)
   ]]
   return Table
  end

 --Screen WP Settings
  function wp_settings_Table_Function()
   local Table=[[
   local edit_wp="]].. edit_wp ..[["
   local Title={"WP: ".. edit_wp,"Altitude","Speed"}
   local Units={"m","Km/h"}
   local Tick={"]].. wp_altitude_tick ..[[","]].. keypad_input_wp_altitude ..[[","]].. wp_speed_tick ..[[","]].. keypad_input_wp_speed ..[["}
   local wp_altitude_inserted=]].. tostring(wp_altitude_inserted) ..[[
   local wp_speed_inserted=]].. tostring(wp_speed_inserted) ..[[

   for i=3, 14 do
    if i<=6 then
     local x1, y1, x2, y2=xKeys[5], MenuLines[i], xKeys[14]+MenuKeyWidth, MenuLines[i]
     addLine(L_table, x1, y1, x2, y2)
    end

    if (i==5 or i==6 or i==10 or i==14) then
     local x1, y1, x2, y2=xKeys[i], MenuLines[3], xKeys[i], MenuLines[9]
     if (i==6 or i==10) then
      y1=MenuLines[4]
      y2=MenuLines[6]
     end
     if i==14 then x1=xKeys[i]+MenuKeyWidth x2=x1 end
     addLine(L_table, x1, y1, x2, y2)
    end
   end

   function wp_settings_Table_List_Function()
    local x, y, k=0, 0, 2
    for i=1, #Title do
     if i==1 then x=xKeys[8]+ButtonSep else x=xKeys[6]+ButtonSep end
     k=k+1
     y=MenuLines[k]+MenuKeyHeight/2+5
     setNextTextAlign(L_title, AlignH_Left, AlignV_Middle)
     addText(L_title, FontTitle, Title[i], x, y)
    end

    k=3
    for i=1, #Units do
     x=xKeys[10]+ButtonSep
     k=k+1
     y=MenuLines[k]+MenuKeyHeight/2+5
     setNextTextAlign(L_units, AlignH_Left, AlignV_Middle)
     addText(L_units, FontText, Units[i], x, y)
    end

    for i=1, #Tick do
     if i%2==1 then x=xKeys[5]+MenuKeyWidth/2+5
     else x=xKeys[12]+ButtonSep end
     if i<=2 then k=4 else k=5 end
     y=MenuLines[k]+MenuKeyHeight/2+5
     setNextTextAlign(L_text, AlignH_Left, AlignV_Middle)
     if ((i==2 and wp_altitude_inserted) or (i==4 and wp_speed_inserted)) then setNextFillColor(L_text, TitleR, TitleG, TitleB, 1) end
     addText(L_text, FontTick, Tick[i], x, y)
    end

   end
   wp_settings_Table_List_Function()
   ]]
   return Table
  end

 --Screen Ship Settings
  function settings1_Table_Function()
   local Table=[[
   local Title={"Ship Settings","MTOW","Autobrake","Dist. To WP","Holding Speed"}
   local Units={"t","Su","Km","Km/h"}
   local Tick={"]].. MTOW_tick ..[[","]].. keypad_input_MTOW ..[[","]].. autobrake_tick ..[[","]].. keypad_input_autobrake ..[[","]].. wp_dist_tick ..[[","]].. keypad_input_wpdist ..[[","]].. holding_tick ..[[","]].. keypad_input_holding ..[["}
   local MTOW_inserted=]].. tostring(MTOW_inserted) ..[[
   local autobrake_stops_at_inserted=]].. tostring(autobrake_stops_at_inserted) ..[[
   local wp_dist_inserted=]].. tostring(wp_dist_inserted) ..[[
   local holding_speed_inserted=]].. tostring(holding_speed_inserted) ..[[

   for i=3, 14 do
    if i<=8 then
     local x1, y1, x2, y2=xKeys[5], MenuLines[i], xKeys[14]+MenuKeyWidth, MenuLines[i]
     addLine(L_table, x1, y1, x2, y2)
    end

    if (i==5 or i==6 or i==10 or i==14) then
     local x1, y1, x2, y2=xKeys[i], MenuLines[3], xKeys[i], MenuLines[9]
     if (i==6 or i==10) then
      y1=MenuLines[4]
      y2=MenuLines[8]
     end
     if i==14 then x1=xKeys[i]+MenuKeyWidth x2=x1 end
     addLine(L_table, x1, y1, x2, y2)
    end
   end

   function settings1_Table_List_Function()
    local x, y, k=0, 0, 3
    for i=1, #Title do
     local Align=AlignH_Center
     if i==1 then x=xKeys[10]
     else
      x=xKeys[6]+ButtonSep
      Align=AlignH_Left
     end
     if i>=2 then k=k+1 end
     y=MenuLines[k]+MenuKeyHeight/2+5
     setNextTextAlign(L_title, Align, AlignV_Middle)
     addText(L_title, FontTitle, Title[i], x, y)
    end

    k=3
    for i=1, #Units do
     x=xKeys[10]+ButtonSep
     k=k+1
     y=MenuLines[k]+MenuKeyHeight/2+5
     setNextTextAlign(L_units, AlignH_Left, AlignV_Middle)
     addText(L_units, FontText, Units[i], x, y)
    end

    for i=1, #Tick do
     local Align=AlignH_Left
     if i%2==1 then x=xKeys[5]+MenuKeyWidth/2+5 Align=AlignH_Center
     else x=xKeys[12]+ButtonSep end
     if (i==1 or i==2) then k=4
     elseif (i==3 or i==4) then k=5
     elseif (i==5 or i==6) then k=6
     elseif (i==7 or i==8) then k=7
     end
     y=MenuLines[k]+MenuKeyHeight/2+5
     setNextTextAlign(L_text, Align, AlignV_Middle)
     if ((i==2 and MTOW_inserted) or
      (i==4 and autobrake_stops_at_inserted) or
      (i==6 and wp_dist_inserted) or
      (i==8 and holding_speed_inserted)) then setNextFillColor(L_text, TitleR, TitleG, TitleB, 1)
     end
     addText(L_text, FontTick, Tick[i], x, y)
    end

   end
   settings1_Table_List_Function()
   ]]
   return Table
  end

 --Screen WP Store
  function settings2_Table_Function()
   local Table=[[
   local Title={"WP Store","WP Coord","WP Name"}
   local Units={"Lat","Lon","Alt"}
   local Tick={"]].. wp_selected_planet ..[[","]].. wp_lat_tick ..[[","]].. keypad_input_wp_lat ..[[","]].. wp_name_tick ..[[","]].. keypad_input_wp_name ..[[","]].. wp_lon_tick ..[[","]].. keypad_input_wp_lon ..[[","]].. wp_alt_tick ..[[","]].. keypad_input_wp_alt ..[["}
   local Results={"]].. stored ..[[","]].. wp_coordinated_stored ..[["}

   for i=3, 14 do
    if i<=8 then
     local x1, y1, x2, y2=xKeys[5], MenuLines[i], xKeys[14]+MenuKeyWidth, MenuLines[i]
     addLine(L_table, x1, y1, x2, y2)
    end

    if (i==5 or i==6 or i==10 or i==11 or i==14) then
     local x1, y1, x2, y2=xKeys[i], MenuLines[3], xKeys[i], MenuLines[9]
     if i==6 then y1=MenuLines[6] y2=MenuLines[7]
     elseif (i==10 or i==11) then y1=MenuLines[4] y2=MenuLines[8]
     elseif i==14 then x1=xKeys[i]+MenuKeyWidth x2=x1
     end
     addLine(L_table, x1, y1, x2, y2)
    end
   end

   function settings2_Table_List_Function()
    local x, y, k=0, 0, 3
    for i=1, #Title do
     local Align=AlignH_Center
     if i==1 then x=xKeys[10]
     elseif i==2 then x=xKeys[13]
     elseif i==3 then x=xKeys[8]
     end
     if i>=2 then k=k+1 end
     y=MenuLines[k]+MenuKeyHeight/2+5
     setNextTextAlign(L_title, Align, AlignV_Middle)
     addText(L_title, FontTitle, Title[i], x, y)
    end

    k=4
    for i=1, #Units do
     x=xKeys[11]+ButtonSep
     k=k+1
     y=MenuLines[k]+MenuKeyHeight/2+5
     setNextTextAlign(L_units, AlignH_Left, AlignV_Middle)
     addText(L_units, FontText, Units[i], x, y)
    end

    k=3
    for i=1, #Tick do
     local Align=AlignH_Left
     if i==1 then x=xKeys[5]+ButtonSep
     elseif (i==2 or i==6 or i==8) then x=xKeys[10]+MenuKeyWidth/2+5 Align=AlignH_Center
     elseif (i==3 or i==7 or i==9) then x=xKeys[12]+ButtonSep
     elseif i==4 then x=xKeys[5]+MenuKeyWidth/2+5 Align=AlignH_Center
     elseif i==5 then x=xKeys[6]+ButtonSep
     end
     if i==1 then k=4
     elseif (i==2 or i==3) then k=5
     elseif (i>=4 and i<=7) then k=6
     else k=7
     end
     y=MenuLines[k]+MenuKeyHeight/2+5
     setNextTextAlign(L_text, Align, AlignV_Middle)
     addText(L_text, FontTick, Tick[i], x, y)
    end

    k=6
    for i=1, #Results do
     x=xKeys[5]+ButtonSep
     k=k+1
     y=MenuLines[k]+MenuKeyHeight/2+5
     setNextTextAlign(L_text, AlignH_Left, AlignV_Middle)
     addText(L_text, FontText, Results[i], x, y)
    end

   end
   settings2_Table_List_Function()
   ]]
   return Table
  end

 --Screen WP Sync
  function settings3_Table_Function()
   local Table=[[
   local Title={"WP Sync","Ship ID","Data Stored","WP:]]..keys_number..[[ - Fleet:]].. FleetNumber ..[["}
   local Units={"<< Downlink >>",">> Uplink <<"}
   local Tick={"]].. shipid_tick ..[[","]].. keypad_input_shipid ..[[","]].. dwn_sync_tick ..[[","]].. up_sync_tick ..[["}
   local Results={"]]..sync_result..[["}
   local prog_bar=]].. prog_bar ..[[
   local ShipIdCheck=]].. tostring(ShipIdCheck) ..[[

   for i=3, 14 do
    if i<=8 then
     local x1, y1, x2, y2=xKeys[5], MenuLines[i], xKeys[14]+MenuKeyWidth, MenuLines[i]
     addLine(L_table, x1, y1, x2, y2)
    end

    if (i==5 or i==6 or i==10 or i==11 or i==14) then
     local x1, y1, x2, y2, y3, y4=xKeys[i], MenuLines[3], xKeys[i], MenuLines[9], MenuLines[6], MenuLines[7]
     if i==6 then y1=MenuLines[4] y2=MenuLines[5]
     elseif i==10 then y1=MenuLines[4] y2=MenuLines[7]
     elseif i==11 then y1=y3 y2=y4
     end
     if i==14 then x1=xKeys[i]+MenuKeyWidth x2=x1 end
     addLine(L_table, x1, y1, x2, y2)
     if i==6 then addLine(L_table, x1, y3, x2, y4) end
    end
   end

   function settings3_Table_List_Function()
    local x, y, k=0, 0, 2
    for i=1, #Title do
     local Align=AlignH_Center
     if i==1 then x=xKeys[10]
     elseif (i==2 or i==3) then x=xKeys[8]
     else x=xKeys[12]+MenuKeyWidth/2+5
     end
     if i<=3 then k=k+1 end
     y=MenuLines[k]+MenuKeyHeight/2+5
     setNextTextAlign(L_title, Align, AlignV_Middle)
     addText(L_title, FontTitle, Title[i], x, y)
    end

    for i=1, #Units do
     if i==1 then x=xKeys[8] else x=xKeys[13] end
     y=MenuLines[6]+MenuKeyHeight/2+5
     setNextTextAlign(L_units, AlignH_Center, AlignV_Middle)
     addText(L_units, FontText, Units[i], x, y)
    end

    for i=1, #Tick do
     local Align=AlignH_Center
     if i%2==1 then x=xKeys[5]+MenuKeyWidth/2+5
     else x=xKeys[10]+MenuKeyWidth/2+5 end
     if i==2 then x=xKeys[10]+ButtonSep Align=AlignH_Left end
     if (i==1 or i==2) then k=4
     else k=6 end
     y=MenuLines[k]+MenuKeyHeight/2+5
     setNextTextAlign(L_text, Align, AlignV_Middle)
     if (i==2 and ShipIdCheck==true) then setNextFillColor(L_text, TitleR, TitleG, TitleB, 1) end
     addText(L_text, FontTick, Tick[i], x, y)
    end

    for i=1, #Results do
     x=xKeys[10]
     y=MenuLines[8]+MenuKeyHeight/2+5
     setNextTextAlign(L_text, AlignH_Center, AlignV_Middle)
     addText(L_text, FontText, Results[i], x, y)
    end

    if prog_bar>0 then
     x=xKeys[5]+2
     y=MenuLines[7]+2
     width=((xKeys[14]+MenuKeyWidth-xKeys[5]-4)* prog_bar)/ 100
     height=MenuLines[7]-MenuLines[6]-4
     setNextFillColor(L_title, TitleR, TitleG, TitleB, 1)
     addBox(L_title, x, y, width, height)
    end

   end
   settings3_Table_List_Function()
   ]]
   return Table
  end

 --Screen Colours
  function settings4_Table_Function()
   local Table=[[
   local Title={"Screen Colors","Table Borders","Titles","Text","Buttons Pressed","Buttons"}
   local Tick={"]].. tick_color_1 ..[[","]].. keypad_input_color1 ..[[","]].. tick_color_2 ..[[","]].. keypad_input_color2 ..[[","]].. tick_color_3 ..[[","]].. keypad_input_color3 ..[[","]].. tick_color_4 ..[[","]].. keypad_input_color4 ..[[","]].. tick_color_5 ..[[","]].. keypad_input_color5 ..[["}
   local Check={[2]="]].. tostring(RGBColor1) ..[[",[4]="]].. tostring(RGBColor2) ..[[",[6]="]].. tostring(RGBColor3) ..[[",[8]="]].. tostring(RGBColor4) ..[[",[10]="]].. tostring(RGBColor5) ..[["}

   for i=3, 14 do
    if i<=8 then
     local x1, y1, x2, y2=xKeys[5], MenuLines[i], xKeys[14]+MenuKeyWidth, MenuLines[i]
     addLine(L_table, x1, y1, x2, y2)
    end

    if (i==5 or i==6 or i==10 or i==14) then
     local x1, y1, x2, y2=xKeys[i], MenuLines[3], xKeys[i], MenuLines[9]
     if (i>5 and i<14) then y1=MenuLines[4] end
     if i==14 then x1=xKeys[i]+MenuKeyWidth x2=x1 end
     addLine(L_table, x1, y1, x2, y2)
    end
   end

   function settings4_Table_List_Function()
    local x, y, k=0, 0, 2
    for i=1, #Title do
     local Align=AlignH_Left
     if i==1 then x=xKeys[10] Align=AlignH_Center
     else x=xKeys[6]+ButtonSep end
     k=k+1
     y=MenuLines[k]+MenuKeyHeight/2+5
     setNextTextAlign(L_title, Align, AlignV_Middle)
     addText(L_title, FontTitle, Title[i], x, y)
    end

    k=3
    for i=1, #Tick do
     local Align=AlignH_Left
     if i%2==1 then x=xKeys[5]+MenuKeyWidth/2+5 Align=AlignH_Center
     else x=xKeys[10]+ButtonSep end
     if i%2==1 then k=k+1 end
     y=MenuLines[k]+MenuKeyHeight/2+5
     if i%2==0 then
      if Check[i]=="true" then setNextFillColor(L_text, TitleR, TitleG, TitleB, 1) end
     end
     setNextTextAlign(L_text, Align, AlignV_Middle)
     addText(L_text, FontTick, Tick[i], x, y)
    end

   end
   settings4_Table_List_Function()
   ]]
   return Table
  end

 --Screen DMG Report
  function settings5_Table_Function()
   local Table=[[
   local Title={"DMG Report Position","Top View","Side View","Scale","Factor"}
   local Units={"UP","LH","DN","RH"}
   local Tick={"]].. tick_dmg_1 ..[[","]]..tick_dmg_2..[["}
   local Results={"]].. keypad_input_dmg1 ..[[","]]..keypad_input_dmg2..[["}
   local Operators={"-","+"," - "," + "}

   for i=3, 14 do
    if i<=8 then
     local x1, y1, x2, y2=xKeys[5], MenuLines[i], xKeys[14]+MenuKeyWidth, MenuLines[i]
     addLine(L_table, x1, y1, x2, y2)
    end

    if (i==5 or i==6 or i==10 or i==11 or i==12 or i==13 or i==14) then
     local x1, y1, x2, y2=xKeys[i], MenuLines[3], xKeys[i], MenuLines[9]
     if i==6 then y1=MenuLines[4] y2=MenuLines[6]
     elseif i==10 then y1=MenuLines[4] y2=MenuLines[6] y3=MenuLines[7] y4=MenuLines[9]
     elseif i==11 then y1=MenuLines[5] y2=MenuLines[6] y3=MenuLines[7] y4=MenuLines[9]
     elseif (i==12 or i==13) then y1=MenuLines[4] y2=MenuLines[6]
     elseif i==14 then x3=xKeys[i]+MenuKeyWidth x4=x3 y1=MenuLines[5] y2=MenuLines[6] y3=MenuLines[7] y4=MenuLines[9]
     end
     addLine(L_table, x1, y1, x2, y2)
     if (i==10 or i==11 or i==14) then addLine(L_table, x1, y3, x2, y4) end
     if i==14 then
      y1, y2=MenuLines[3], MenuLines[9]
      addLine(L_table, x3, y1, x4, y2)
     end
    end
   end

   function settings5_Table_List_Function()
    local x, y, k, xCur1, xCur2, yCur1, yCur2=0, 0, 2, 0, 0, 0, 0
    for i=1, #Title do
     x=xKeys[6]+ButtonSep
     local Align=AlignH_Left
     if i==1 then x=xKeys[10] Align=AlignH_Center
     elseif (i==4 or i==5) then x=xKeys[5]+ButtonSep
     end
     if i<=3 then k=k+1
     elseif i==4 then k=7 
     elseif i==5 then k=8
     end
     y=MenuLines[k]+MenuKeyHeight/2+5
     setNextTextAlign(L_title, Align, AlignV_Middle)
     addText(L_title, FontTitle, Title[i], x, y)
    end

    for i=1, #Units do
     x=xKeys[12]+MenuKeyWidth/2+5
     xCur1=xKeys[12]
     xCur2=xCur1+MenuKeyWidth
     if i==2 then x=xKeys[11]+MenuKeyWidth/2+5 xCur1=xKeys[11] xCur2=xCur1+MenuKeyWidth
     elseif i==4 then x=xKeys[13]+MenuKeyWidth/2+5 xCur1=xKeys[13] xCur2=xCur1+MenuKeyWidth
     end
     if i>=2 then k=5 else k=4 end
     y=MenuLines[k]+MenuKeyHeight/2+5
     yCur1=MenuLines[k]
     yCur2=MenuLines[k]+MenuKeyHeight
     setNextTextAlign(L_units, AlignH_Center, AlignV_Middle)
     addText(L_units, FontText, Units[i], x, y)
     if (cx>xCur1 and cx<xCur2 and cy>yCur1 and cy<yCur2) then
      setNextFillColor(L_units, ButtonPressedR, ButtonPressedG, ButtonPressedB, 0.1)
      addBox(L_units, xCur1+2, yCur1+2, MenuKeyWidth+7, MenuKeyHeight+7)
      if getCursorDown() then setOutput(Units[i]) end
     end
    end

    for i=1, #Tick do
     x=xKeys[5]+MenuKeyWidth/2+5
     y=MenuLines[i+3]+MenuKeyHeight/2+5
     setNextTextAlign(L_text, AlignH_Center, AlignV_Middle)
     addText(L_text, FontTick, Tick[i], x, y)
    end

    for i=1, #Results do
     x=xKeys[12]+MenuKeyWidth/2+5
     y=MenuLines[i+6]+MenuKeyHeight/2+5
     setNextTextAlign(L_text, AlignH_Center, AlignV_Middle)
     addText(L_text, FontText, Results[i], x, y)
    end

    k=6
    for i=1, #Operators do
     x=xKeys[10]+MenuKeyWidth/2+5
     xCur1=xKeys[10]
     xCur2=xCur1+MenuKeyWidth
     local Width, Height=MenuKeyWidth+7, MenuKeyHeight+7
     if (i==2 or i==4) then x=xKeys[14]+MenuKeyWidth/2 xCur1=xKeys[14] xCur2=xCur1+MenuKeyWidth end
     if i%2==1 then k=k+1 end
     y=MenuLines[k]+MenuKeyHeight/2+5
     yCur1=MenuLines[k]
     yCur2=yCur1+MenuKeyHeight
     setNextTextAlign(L_text, AlignH_Center, AlignV_Middle)
     addText(L_text, FontTick, Operators[i], x, y)
     if (cx>xCur1 and cx<xCur2 and cy>yCur1 and cy<yCur2) then
      setNextFillColor(L_text, ButtonPressedR, ButtonPressedG, ButtonPressedB, 0.1)
      if (i==2 or i==4) then Width=MenuKeyWidth-5 end
      addBox(L_text, xCur1+2, yCur1+2, Width, Height)
      if getCursorDown() then setOutput(Operators[i]) end
     end
    end

   end
   settings5_Table_List_Function()

   requestAnimationFrame(10)
   ]]
   return Table
  end

 --Screen DB Reset
  function settings6_Table_Function()
   local Table=[[
   local Title={"Databank Reset","X to Keep","Stored WP","ENT to Change","Ship Settings","CLR to Execute","Ship ID","Screen Colors","DMG Rep."}
   local Tick={"]]..tick_[1]..[[","]]..db_mark_1..[[","]]..tick_[2]..[[","]]..db_mark_2..[[","]]..tick_[3]..[[","]]..db_mark_3..[[","]]..tick_[4]..[[","]]..db_mark_4..[[","]]..tick_[5]..[[","]]..db_mark_5..[["}
   local Results={"]]..reset_db_status..[[","]].. reset_db_status2 ..[["}
   
   for i=3, 14 do
    if i<=8 then
     local x1, y1, x2, y2, x3, x4=xKeys[5], MenuLines[i], xKeys[14]+MenuKeyWidth, MenuLines[i], xKeys[6], xKeys[10]
     if (i==5 or i==6 or i==8) then
      addLine(L_table, x1, y1, x3, y2)
      addLine(L_table, x4, y1, x2, y2)
     else addLine(L_table, x1, y1, x2, y2) end
    end
  
    if (i==5 or i==6 or i==10 or i==11 or i==14) then
     local x1, y1, x2, y2=xKeys[i], MenuLines[3], xKeys[i], MenuLines[9]
     if (i==6 or i==10 or i==11) then y1=MenuLines[4] y2=MenuLines[9]
     elseif i==14 then x1=xKeys[i]+MenuKeyWidth x2=x1
     end
     addLine(L_table, x1, y1, x2, y2)
    end
   end
   
   function settings6_Table_List_Function()
    local x, y, k=0, 0, 3
    for i=1, #Title do
     local Align=AlignH_Left
     if i==1 then x=xKeys[10] Align=AlignH_Center
     elseif (i==2 or i==4 or i==6) then x=xKeys[6]+ButtonSep 
     elseif (i==3 or i==5 or i>=7) then x=xKeys[11]+ButtonSep
     end
     if (i%2==0 and i<=7) then k=k+1
     elseif i>=8 then k=k+1 end
     y=MenuLines[k]+MenuKeyHeight/2+5
     setNextTextAlign(L_title, Align, AlignV_Middle)
     addText(L_title, FontTitle, Title[i], x, y)
    end
     
    k=3
    for i=1, #Tick do
     if i%2==1 then x=xKeys[5]+MenuKeyWidth/2+5
     else x=xKeys[10]+MenuKeyWidth/2+5 end
     if i%2==1 then k=k+1 end
     y=MenuLines[k]+MenuKeyHeight/2+5
     setNextTextAlign(L_text, AlignH_Center, AlignV_Middle)
     addText(L_text, FontTick, Tick[i], x, y)
    end
   
    for i=1, #Results do
     x=xKeys[6]+ButtonSep
     y=MenuLines[i+6]+MenuKeyHeight/2+5
     if Results[i]=="Restart The Interface" then setNextFillColor(L_text, 1, 0, 0, 1) end
     setNextTextAlign(L_text, AlignH_Left, AlignV_Middle)
     addText(L_text, FontText, Results[i], x, y)
    end
   
   end
   settings6_Table_List_Function()
   ]]
   return Table
  end

 --Screen Routes
  function settings7_Table_Function()
   local Table=[[
   local routes_page_index=]].. routes_page_index ..[[
   local routes_pages=]].. routes_pages ..[[
   local routes_wp_page_index=]].. routes_wp_page_index ..[[
   local routes_wp_pages=]].. routes_wp_pages ..[[
   local RouteCounter=]].. RouteCounter ..[[
   local Title={"ROUTES","Page ".. routes_page_index .."/".. routes_pages ,"WP","Page ".. routes_wp_page_index .."/".. routes_wp_pages}
   local route_tick_={]].. RouteTickList:gsub("[%[%]]+","") ..[[}
   local wp_tick_={]].. WpTickList:gsub("[%[%]]+","") ..[[}
   local input=json.decode(getInput()) or {}
   local routes_list=input[1]
   local WpRouteList=input[2]
   local DistanceList=input[3]

   for i=3, 14 do
    if i<=8 then
     local x1, y1, x2, y2=xKeys[5], MenuLines[i], xKeys[14]+MenuKeyWidth, MenuLines[i]
     addLine(L_table, x1, y1, x2, y2)
    end

    if (i==5 or i==6 or i==10 or i==11 or i==14) then
     local x1, y1, x2, y2=xKeys[i], MenuLines[3], xKeys[i], MenuLines[9]
     if (i==6 or i==11) then y1=MenuLines[4] end
     if i==14 then x1=xKeys[i]+MenuKeyWidth x2=x1 end
     addLine(L_table, x1, y1, x2, y2)
    end
   end

   function settings7_Table_List_Function()
    if Selected==nil then Selected=false end
    local x, y, k=0, 0, 3
    local RouteIndex=(routes_page_index*5)-4
    local wp_tick_index=(routes_wp_page_index*5)-4

    for i=1, #Title do
     if i==1 then x=xKeys[5]+ButtonSep
     elseif i==2 then x=xKeys[8]
     elseif i==3 then x=xKeys[10]+ButtonSep
     elseif i==4 then x=xKeys[13]
     end
     y=MenuLines[3]+MenuKeyHeight/2+5
     setNextTextAlign(L_title, AlignH_Left, AlignV_Middle)
     addText(L_title, FontTitle, Title[i], x, y)
    end

    for i=RouteIndex, (RouteIndex+4) do
     x=xKeys[5]+MenuKeyWidth/2+5
     k=k+1
     y=MenuLines[k]+MenuKeyHeight/2+5
     setNextTextAlign(L_text, AlignH_Center, AlignV_Middle)
     addText(L_text, FontTick, route_tick_[i], x, y)
    end

    k=3
    for i=wp_tick_index, (wp_tick_index +4) do
     if wp_tick_[i]==nil then wp_tick_[i]="" end
     x=xKeys[10]+MenuKeyWidth/2+5
     k=k+1
     y=MenuLines[k]+MenuKeyHeight/2+5
     setNextTextAlign(L_text, AlignH_Center, AlignV_Middle)
     addText(L_text, FontTick, wp_tick_[i], x, y)
    end

    k=3
    for i=RouteIndex, (RouteIndex +4) do
     if i<=RouteCounter then
      route_name=routes_list[i].route
      x=xKeys[6]+ButtonSep
     else route_name="" end
     k=k+1
     y=MenuLines[k]+MenuKeyHeight/2+5
     if (cx>x and cx<xKeys[10] and cy>MenuLines[k] and cy<MenuLines[k]+MenuKeyHeight+ButtonSep) then
      setNextTextAlign(L_select, AlignH_Left, AlignV_Middle)
      addText(L_select, FontText, route_name, x, y)
      if getCursorDown() then
       Selected=true
       SelectedID=route_name
       setOutput(route_name)
      end
     else
      setNextTextAlign(L_text, AlignH_Left, AlignV_Middle)
      addText(L_text, FontText, route_name, x, y)
     end
    end

    k=3
    for i=wp_tick_index, (wp_tick_index +4) do
     local wp="wp"..i
     local route_wp_name=""
     if WpRouteList~=nil then
      local wpn=WpRouteList[wp]
      if wpn and wpn~="" then
       route_wp_name=WpRouteList[wp]
       x=xKeys[11]+ButtonSep
      end
     end
     k=k+1
     y=MenuLines[k]+MenuKeyHeight/2+5
     setNextTextAlign(L_units, AlignH_Left, AlignV_Middle)
     addText(L_units, FontText, route_wp_name, x, y)
    end

    if Selected then
     setNextTextAlign(L_selected, AlignH_Center, AlignV_Middle)
     addText(L_selected, FontText, SelectedID, xKeys[3], MenuLines[4]+MenuKeyHeight/2) 
    end

   end
   settings7_Table_List_Function()

   requestAnimationFrame(10)
   ]]
   return Table
  end

 --Screen Routing
  function route_page_Table_Function()
   local Table=[[
   local selected_route_name="]].. selected_route_name ..[["
   local selected_route_page_index=]].. selected_route_page_index ..[[
   local selected_route_pages=]].. selected_route_pages ..[[
   local Title={"Route: ".. selected_route_name,"Page ".. selected_route_page_index .."/".. selected_route_pages}
   local input=json.decode(getInput()) or {}
   local WpSettingsList=input[1]
   local WpRouteList=input[2] or {}
   local DistanceList=input[3] or {}
   local distance=""

   local ListFix={}
   for i, v in pairs(WpRouteList) do ListFix[tonumber(i)]=v end
   WpRouteList=ListFix
   ListFix={}
   for i, v in pairs(DistanceList) do ListFix[tonumber(i)]=v end
   DistanceList=ListFix

   for i=3, 14 do
    if i<=8 then
     local x1, y1, x2, y2=xKeys[5], MenuLines[i], xKeys[14]+MenuKeyWidth, MenuLines[i]
     addLine(L_table, x1, y1, x2, y2)
    end

    if (i==5 or i==10 or i==14) then
     local x1, y1, x2, y2=xKeys[i], MenuLines[3], xKeys[i], MenuLines[9]
     if i==10 then y1=MenuLines[4] end
     if i==14 then x1=xKeys[i]+MenuKeyWidth x2=x1 end
     addLine(L_table, x1, y1, x2, y2)
    end
   end

   function route_page_Table_List_Function()
    local x, xSel, y, k, xDis, Unit=0, 0, 0, 2, 0, ""
    local Align=AlignH_Left
    local wp_tick_index=(selected_route_page_index*5)-4
    for i=1, #Title do
     if i==1 then x=xKeys[5]+ButtonSep
     else x=xKeys[12] end
     y=MenuLines[3]+MenuKeyHeight/2+5
     setNextTextAlign(L_title, Align, AlignV_Middle)
     addText(L_title, FontTitle, Title[i], x, y)
    end

    k=3
    for i=wp_tick_index, (wp_tick_index +4) do
     Align=AlignH_Left
     x=xKeys[5]+ButtonSep
     xSel=x
     k=k+1
     y=MenuLines[k]+MenuKeyHeight/2+5
     local route_wp_name=WpRouteList[i]
     local route_wp_nameMOD=""
     if route_wp_name==nil then route_wp_name="" end
     local CkSetting=route_wp_name:gsub("To ", "")
     if WpSettingsList[CkSetting] then
      if (WpSettingsList[CkSetting].alt~="" or WpSettingsList[CkSetting].s~="") then
      setNextFillColor(L_text, 0, 1, 0, 1)
      end
     end
     if string.match(route_wp_name, "To ") then
       route_wp_name=route_wp_name:gsub("To ", "")
      route_wp_nameMOD=">> ".. route_wp_name .." <<"
      Align=AlignH_Center
      x=xKeys[7]+MenuKeyWidth/2+5
     else route_wp_nameMOD=route_wp_name end
     if (cx>xSel and cx<xKeys[10] and cy>MenuLines[k] and cy<MenuLines[k]+MenuKeyHeight+ButtonSep) then
      setNextTextAlign(L_select, Align, AlignV_Middle)
      addText(L_select, FontText, route_wp_nameMOD, x, y)
      if getCursorDown() then
       Selected=true
       SelectedID=route_wp_name
       setOutput("WpID "..i)
      end
     else
      setNextTextAlign(L_text, Align, AlignV_Middle)
      addText(L_text, FontText, route_wp_nameMOD, x, y)
     end
     if DistanceList[i] then
      distance=DistanceList[i]
      local checkSu=string.find(distance, "Su")
      local checkKm=string.find(distance, "Km")
      if checkSu then Unit="Su" distance=distance:gsub("%a", "")
      elseif checkKm then Unit="Km" distance=distance:gsub("%a", "")
      end
      x=xKeys[10]+ButtonSep
      setNextFillColor(L_text, FontColorR, FontColorG, FontColorB, 1)
      setNextTextAlign(L_text, AlignH_Left, AlignV_Middle)
      addText(L_text, FontText, distance, x, y)
      if (distance~="" and distance~="Wrong Wp Name" and distance~="Holding") then
       x=xKeys[14]
       setNextTextAlign(L_units, AlignH_Left, AlignV_Middle)
       addText(L_units, FontText, Unit, x, y)
      end
     end
    end

    if Selected then
     setNextTextAlign(L_selected, AlignH_Center, AlignV_Middle)
     addText(L_selected, FontText, SelectedID, xKeys[3], MenuLines[4]+MenuKeyHeight/2) 
    end

   end
   route_page_Table_List_Function()

   requestAnimationFrame(10)
   ]]
   return Table
  end

 --RENDER
  function ScreenRender()
   local Menu_Interface=Parameters .. Setup .. MenuLists .. MenuButtons .. KkeypadButtons .. KeysButton .. CursorClick
   local DISPLAY=""

   if screenState==0 then stored_waypoints_1() DISPLAY=WPStore_Table_Function()
   elseif screenState==1 then su_distance_time() DISPLAY=SuDistanceTime_Table_Function()
   elseif screenState==2 then from() DISPLAY=from_Table_Function()
   elseif screenState==3 then distance_to_wp() DISPLAY=distance_to_wp_Table_Function()
   elseif screenState==4 then target_pe_altitude() DISPLAY=target_pe_altitude_Table_Function()
   elseif screenState==5 then settings1() DISPLAY=settings1_Table_Function()
   elseif screenState==6 then atlas_list_page() DISPLAY=ATLAS_Table_Function()
   elseif screenState==7 then settings2() DISPLAY=settings2_Table_Function()
   elseif screenState==8 then settings3() DISPLAY=settings3_Table_Function()
   elseif screenState==9 then DISPLAY=settings_menu_Table_Function()
   elseif screenState==10 then DISPLAY=settings4_Table_Function()
   elseif screenState==11 then DISPLAY=settings5_Table_Function()
   elseif screenState==12 then DISPLAY=settings6_Table_Function()
   elseif screenState==13 then agg() DISPLAY=agg_Table_Function()
   elseif screenState==14 then settings7() DISPLAY=settings7_Table_Function()
   elseif screenState==15 then route_page() DISPLAY=route_page_Table_Function()
   elseif screenState==16 then wp_settings() DISPLAY=wp_settings_Table_Function()
   elseif screenState==17 then shieldFunction() DISPLAY=shield_Table_Function()
   end

   local Status=DataStatus_Table_Function()

   local Screen=Menu_Interface .. DISPLAY .. Status
   screen.setRenderScript(Screen)
  end
  ScreenRender()

 end
 LuaScreen()
--

--FILTERS
--construct.onStart()
 function ConstructMass() local M=math.floor(construct.getMass()/1000) return M end
 function ConstructVel() local V=math.floor((vec3(construct.getVelocity()):len())*3.6) return V end
 function ConstructPos() local P=vec3(construct.getWorldPosition()) return P end
 function ConstrucId() local I=construct.getId() return I end
 function MaxSpeed() local S=construct.getMaxSpeed()*3.6 return S end
--

--unit.onStop()
 screen.deactivate()
--

--unit.onTimer("delay")
 delay_timer=delay_timer-1
 if delay_timer==0 then
  unit.stopTimer("delay")
  if delay_id=="SyncData" then sync_data()
  elseif delay_id=="ShipIDResponse" then
   if (sync_result=="Ship ID Sent" or sync_result=="Downlink Requested") then sync_result="No Response" LuaScreen() end
  end
 end
--

--unit.onTimer("Ship_Id")
 ship_id_verified=false
 WP_request=false
 unit.stopTimer("Ship_Id")
--

--unit.onTimer("agg")
 if screenState==13 then
  if agg_target_altitude==true then keypad_input_agg_target_alt=db.getIntValue("agg_t_alt") end
  LuaScreen()
 else unit.stopTimer("agg") end
--

--unit.onTimer("routing")
 if (screenState==15 or screenState==16 or screenState==9 or screenState==5) then

  local myPos=vec3(core.getConstructWorldPos())
  local distance=""
  for i=1, #WpRouteList do
   local wp=WpRouteList[i]
   if WPCoordinates[i] then
    distance=math.floor(((vec3(WPCoordinates[i]) - myPos):len())/1000*100)/100
    if distance>200 then DistanceList[i]=math.floor((distance/200)*100)/100 .." Su"
    else DistanceList[i]=distance .." Km" end
   elseif (wp=="To HOLD" or wp=="To hold" or wp=="HOLD" or wp=="hold") then DistanceList[i]="Holding"
   elseif (wp=="" or wp=="To ") then DistanceList[i]=""
   else DistanceList[i]="Wrong Wp Name" end
  end
  screen.setScriptInput(json.encode({WpSettingsList,WpRouteList,DistanceList}))

  routing_timer=true
  RouteLoop=false
  local distance=DistanceList[DistToNextWp] or ""
  if (distance=="Holding" or distance=="Wrong Wp Name") then
   unit.stopTimer("routing")
   next_wp_selected=false
   db.setIntValue("Holding", 1)
  elseif (distance~="Holding" and distance~="") then
   distance=distance:gsub("%a", "")
   if tonumber(distance)~=nil then
    distance=tonumber(distance)
    local d=math.sqrt((wp_sequencing_distance)^2 + ((math.floor(core.getAltitude())/1000)^2))
    if (distance<d) then
     unit.stopTimer("routing")
     next_wp_selected=true
     db.setIntValue("Holding", 0)
     LuaScreen()
    end
   end
  else
   first_wp_selected=false
   db.setIntValue("Holding", 0)
   unit.stopTimer("routing")
   LuaScreen()
  end
 else
  db.setIntValue("Holding", 0)
  routing_timer=false
  unit.stopTimer("routing")
 end
--

--unit.onTimer("shield")
 if screenState==17 then
  shieldFunction()
 else unit.stopTimer("shield") end
--

--unit.onTimer("PVPStation")
 if PVPStationIsON==nil then PVPStationIsON=false end
 if db.getStringValue("PVPStation")=="ON" then PVPStationIsON=true
 else PVPStationIsON=false end

 if PVPStationIsON then
  HUD_HTML={} 
  system.setScreen(PVPInfoFunction())
  system.showScreen(1)
 else system.showScreen(0) end
--

--system.actionLoop(lshift)
 L_SHIFT=true
--

--system.actionStop(lshift)
 L_SHIFT=false
--

--system.actionStart(gear)
 if shield and L_SHIFT then
  if shield.isVenting() then shield.stopVenting() else shield.startVenting() end
 end
--

--system.onInputText(*)
 input_text=text

 if (screenState==1 and tonumber(input_text)~=nil) then
  if su_tick==">" then keypad_input_su=input_text
  elseif speed_tick==">" then keypad_input_speed=input_text
  end
  ent_button()
 elseif screenState==2 then
  if FROM_tick==">" then keypad_input_from=input_text
  elseif WPADD_tick==">" then keypad_input_wpname=input_text
  end
  ent_button()
 elseif screenState==3 then keypad_input_dest=input_text
  ent_button()
 elseif (screenState==4 and tonumber(input_text)~=nil) then
  keypad_input_pe_target_alt=input_text
  target_pe_altitude_inserted=false
  status_TA=""
  target_alt_warning=""
  ent_button()
 elseif (screenState==5 and tonumber(input_text)~=nil) then
  if MTOW_tick==">" then keypad_input_MTOW=input_text
  elseif autobrake_tick==">" then keypad_input_autobrake=input_text
  elseif wp_dist_tick==">" then keypad_input_wpdist=input_text
  elseif holding_tick==">" then keypad_input_holding=input_text
  end
  ent_button()
 elseif screenState==7 then
  local check0=string.find(input_text, "::pos{")
  local check00=string.find(input_text, "::pos{0,0,")
  if check0 then
   local pos=input_text
   local num=' *([+-]?%d+%.?%d*e?[+-]?%d*)'
   local posPattern='::pos{0,' .. num .. ',' ..  num .. ',' .. num ..  ',' .. num .. '}'
   local bodyId, latitude, longitude, altitude=string.match(pos, posPattern);
   for i, v in pairs(atlas[0]) do
    if atlas[0][i].id==tonumber(bodyId) then wp_selected_planet=atlas[0][i].name[1] break
    elseif check00 then wp_selected_planet="World Coordinates"
    else wp_selected_planet="Invalid Entry" end
   end
   input_text=""
   wp_name_tick=">"   
   keypad_input_wp_lat=tonumber(latitude)
   keypad_input_wp_lon=tonumber(longitude)
   keypad_input_wp_alt=tonumber(altitude)
  end
  if wp_name_tick==">" then
   keypad_input_wp_name=input_text
  elseif (wp_lat_tick==">" and tonumber(input_text)~=nil) then keypad_input_wp_lat=input_text
  elseif (wp_lon_tick==">" and tonumber(input_text)~=nil) then keypad_input_wp_lon=input_text
  elseif (wp_alt_tick==">" and tonumber(input_text)~=nil) then keypad_input_wp_alt=input_text
  end
 elseif screenState==8 then
  if shipid_tick==">" then keypad_input_shipid=input_text end
  ent_button()
 elseif screenState==10 then
  if tick_color_1==">" then keypad_input_color1=input_text
  elseif tick_color_2==">" then keypad_input_color2=input_text
  elseif tick_color_3==">" then keypad_input_color3=input_text
  elseif tick_color_4==">" then keypad_input_color4=input_text
  elseif tick_color_5==">" then keypad_input_color5=input_text
  end
  ent_button()
 elseif (screenState==13 and agg_target_altitude==true and tonumber(input_text)~=nil) then
  keypad_input_agg_target_alt=input_text
  agg_target_altitude=false
  ent_button()
 elseif screenState==14 then
  route_tick_index=(routes_page_index*5)-4
  for i=route_tick_index, (route_tick_index +4) do
   if (route_tick_[i]==">" and (routes_list[i]=="" or routes_list[i]==nil)) then
    local check=db.getStringValue("Route"..i)
    if check~="" then
     local DbKeys=db.getNbKeys()
     for x=1, DbKeys do
      local find=db.getStringValue("Route"..x)
      if find=="" then i=x break end
     end
    end
    new_route_id="Route"..i
    keypad_input_route=input_text
    routing(new_route_id, keypad_input_route)
    break
   elseif (route_tick_[i]=="*") then
     local route_id="Route"..i
     local wp="wp"..wp_tick_n
     if (wp_tick_[wp_tick_n]==">") then
      local id="wp"..wp_tick_n
      keypad_input_wp_route=input_text
      add_wp_to_route(id, keypad_input_wp_route)
      wp_tick_n=wp_tick_n +1
      if wp_tick_n > (wp_tick_index +4) then wp_tick_n=(wp_tick_index +4) end
      wp_tick_[wp_tick_n -1]=""
      wp_tick_[wp_tick_n]=">"   
     end
    end
  end
 elseif (screenState==16 and tonumber(input_text)~=nil) then
  if wp_altitude_tick==">" then keypad_input_wp_altitude=input_text
  elseif wp_speed_tick==">" then keypad_input_wp_speed=input_text
  end
  ent_button()
 end
 LuaScreen()

 if screenState~=7 then
  local check0=string.find(input_text, "::pos{0")
  local check1=string.find(input_text, "/Y")

  if LuaWp==nil then LuaWp=false end
  if LuaSavingWp==nil then LuaSavingWp=false end
  if LuaWpName==nil then LuaWpName=false end

  if check0 then
   LuaWp=true
   system.print(input_text)
   db.setStringValue("TEMP_Coord", input_text)
   system.print("To save type => /Y")
  end

  if check1 and LuaWp then
   LuaSavingWp=true
   system.print("Type Waypoint name => /name")
  end

  if screenState~=7 and LuaWp and LuaSavingWp and not check1 and string.find(input_text, "/") then
   keypad_input_wp_name=string.gsub(input_text, "/", "")
   LuaWpName=true
  end

  if LuaWp and LuaSavingWp and LuaWpName then
   local pos=db.getStringValue("TEMP_Coord")
   db.clearValue("TEMP_Coord")
   local num=' *([+-]?%d+%.?%d*e?[+-]?%d*)'
   local posPattern='::pos{0,' .. num .. ',' ..  num .. ',' .. num ..  ',' .. num .. '}'
   local bodyId, latitude, longitude, altitude=string.match(pos, posPattern);

   local CoordinateSystem=false
   if tonumber(bodyId)==0 then
    wp_selected_planet="World Coordinates"
    CoordinateSystem=true
   elseif (bodyId==nil or latitude==nil or longitude==nil or altitude==nil) then
    system.print("Invalid Coordinates")
   else
    for i, v in pairs(atlas[0]) do
     if atlas[0][i].id==tonumber(bodyId) then wp_selected_planet=atlas[0][i].name[1] break end
    end
    CoordinateSystem=true
   end

   if CoordinateSystem then
    keypad_input_wp_lat=tonumber(latitude)
    keypad_input_wp_lon=tonumber(longitude)
    keypad_input_wp_alt=tonumber(altitude)
    add_wp()
   else
    LuaWp=false
    LuaSavingWp=false
    LuaWpName=false
   end

  end

 end
--

--receiver.onReceived(*,*)
 local DownlinkApproved=string.find(message, "<DownlinkApproved>")
 local ConstructIDRqst=string.find(message, "<ConstructIDRqst>")
 local BaseShipId=string.find(message, "<BaseShipId>")
 local WPBaseData=string.find(message, "<WPBaseData>")
 local FleetBaseData=string.find(message, "<FleetBaseData>")
 local BaseData_n=string.find(message, "<BaseData_n>")
 local SendDataTo=string.find(message, "<SendDataTo>")

 if SendDataTo then
  SendDataTo=string.gsub(message, "<SendDataTo>", "")
  if (SendDataTo==ship_id or SendDataTo=="ALL") then WP_request=true end
 end

 if DownlinkApproved then
  local CheckShipID=string.gsub(message, "<DownlinkApproved>", "")
  if CheckShipID==ship_id then sync_data() end
 end

 if ConstructIDRqst then
  local CheckShipID=string.gsub(message, "<ConstructIDRqst>", "")
  if CheckShipID==ship_id then
   local ConstructID=ConstrucId()
   emitter.send("AviatorHUD", "<"..ship_id..">"..ConstructID)
  end
 end

 if BaseShipId then
  base_ship_id=string.gsub(message, "<BaseShipId>", "")
  ship_id_verified=false
  if base_ship_id==ship_id then
   ship_id_verified=true
   reqst_waypoints()
  end
 end

 if WPBaseData and (ship_id_verified==true or WP_request==true) then
  msg_counter=msg_counter+1
  system.print(ship_id.." RECEIVED WP:"..msg_counter.." of "..receiving_wp)
  sync_result='>> WP Uplink << '..msg_counter ..'/'..receiving_wp
  prog_bar=(msg_counter * 100)/receiving_wp
  msg_received=true
  rcv_msg=message:gsub("@@@","\"")
  rcv_msg=string.gsub(rcv_msg, "<WPBaseData>", "")
  rcv_msg=json.decode(rcv_msg)
  receiving_data()
  unit.setTimer("Ship_Id", 5)
 end

 if FleetBaseData and (ship_id_verified==true or WP_request==true) then
  fleet_msg_counter=fleet_msg_counter+1
  system.print(ship_id.." RECEIVED Ship Data:"..fleet_msg_counter.." of "..receiving_wp)
  sync_result='>> Fleet Data Uplink << '..fleet_msg_counter ..'/'..receiving_wp
  prog_bar=(fleet_msg_counter * 100)/receiving_wp
  msg_received=true
  rcv_msg=message:gsub("@@@","\"")
  rcv_msg=string.gsub(rcv_msg, "<FleetBaseData>", "")
  rcv_msg=json.decode(rcv_msg)
  receiving_FleetData()
  unit.setTimer("Ship_Id", 5)
 end

 if BaseData_n then receiving_wp=string.gsub(message, "<BaseData_n>", "") end
--

--screen.mouseUp(*,*)
 KeyLabel=screen.getScriptOutput()
 function Key_Check(x)
  local Menu=true
  local Pad=true
  local Key1=true
  local Key2=true

  if Menu then
   local MenuList={"Time Calculator","From","Destination","Shield","AD/RN WP","CLR WP","Settings","PE Target Altitude","AGG","WP/ATLAS","INV Route"}
   for i=1, #MenuList do
    local k=MenuList[i]
    if k==x then menu(x) Menu=true break else Menu=false end
   end
  end

  if (screenState==0 and x~="arrowUP" and x~="arrowDN") then Menu=true Key2=false end
  if (screenState==11 and x~="arrowup" and x~="arrowdn") then Menu=true Key2=false end
  if (screenState==15 and x~="arrowUP" and x~="arrowDN" and x~="ENT" and x~="CLR") then Menu=true Key2=false end
  if not Menu then
   local KeyPad={"1","2","3","4","5","6","7","8","9","0",".","-","arrowUP","arrowDN","arrowup","arrowdn","CAPS","CLR","ENT"}
   for i=1, #KeyPad do
    local k=KeyPad[i]
    if k==x then keypad_numbers() Pad=true break else Pad=false end
   end
  end

  if not Pad then
   local KeyList1={"A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z","_","moon"}
   for i=1, #KeyList1 do
    local k=KeyList1[i]
    if k==x then keypad_letters() Key1=true break else Key1=false end
   end
  end

  if not Key1 then
   local KeyList2={"a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"}
   for i=1, #KeyList2 do
    local k=KeyList2[i]
    if k==x then keypad_letters() Key2=true break else Key2=false end
   end
  end

  if not Key2 then
   ScreenSelection=KeyLabel
   if (screenState==9 and ScreenSelection~="") then ent_button() LuaScreen()
   elseif (screenState==11 and ScreenSelection~="") then DMGReportClick(ScreenSelection) LuaScreen()
   elseif (screenState==13 and ScreenSelection~="") then ent_button() LuaScreen()
   elseif (screenState==17 and ScreenSelection~="") then shieldFunction()
   end
  end

 end
 if KeyLabel~="" then Key_Check(KeyLabel) end
--