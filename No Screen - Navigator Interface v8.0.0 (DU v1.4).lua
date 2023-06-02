--SETUP
 function Setup()
  local SoftwareVersion="v8.0.0"
  databank.setStringValue("Navigator Interface No Scr ver", SoftwareVersion)
  ScrW=system.getScreenWidth()
  ScrH=system.getScreenHeight()
  ScRt=ScrH/1080
  xStart=ScrW/4
  yStart=ScrH/5
  MenuW=ScrW/10
  MenuY=ScrH/30
  MENU_ON=true --export
  L_SHIFT=false
  L_ALT=false
  PVPStationIsON=false
  if shield then unit.setTimer("PVPStation", 1) end
  if receiver then receiver.setChannelList({"AviatorWPBaseSync"}) end
  atlas=require('atlas')
  system.print("- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -")
  system.print("NAVIGATOR INTERFACE System ONLINE")
  system.print("Release "..SoftwareVersion)
  system.print("- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -")
 end
 Setup()

--DATABANK INITIALIZATION
 Databank_Soft_Reset=false --export
 Databank_Hard_Reset=false --export
 function databank_initialization()
  databank.setStringValue("databank_verification", "Verified")
  databank.setStringValue("Ship ID", "No ID")
  databank.setFloatValue("navigator_speed", "n/a")
  databank.setFloatValue("navigator_distance", "n/a")
  databank.setStringValue("navigator_target_destination", "no Dest.")
  databank.setStringValue("navigator_coordinates", "n/a")
  databank.setFloatValue("navigator_eta_h", 0)
  databank.setFloatValue("navigator_eta_m", 0)
  databank.setFloatValue("navigator_eta_s", 0)
  databank.setStringValue("navigator_from_coordinates", "n/a")
  databank.setStringValue("navigator_from", "no From")
  databank.setFloatValue("navigator_pe_target_altitude", factory_PE_target_altitude)
  databank.setFloatValue("navigator_from_planet_radius", 0)
  databank.setFloatValue("navigator_target_planet_radius", 0)
  factory_autobrake=2.3
  databank.setFloatValue("navigator_autobrake", factory_autobrake)
  factory_MTOW=730000
  databank.setFloatValue("navigator_MTOW", factory_MTOW)
  wp_sequencing_distance=0.5
  databank.setFloatValue("navigator_wpdist", wp_sequencing_distance)
  databank.setStringValue("SCRFontColor", "{217,217,217}")
  databank.setStringValue("SCRButtonColor", "{0,0,255}")
  databank.setStringValue("SCRTableColor", "{0,0,255}")
  databank.setStringValue("SCRFontTitle", "{255,255,0}")
  databank.setStringValue("SCRButtonPressed", "{255,0,0}")
  databank.setStringValue("FontColor", "{217,217,217}")
  databank.setStringValue("Background", "{0,0,100}")
  databank.setStringValue("TableColor", "{0,0,255}")
  databank.setStringValue("FontTitle", "{255,255,0}")
  databank.setStringValue("Selection", "{0,100,200}")
  databank.setFloatValue("Alpha1", 0.4)
  databank.setFloatValue("Alpha2", 0.8)
  databank.setStringValue("wp_color", "none")
  databank.setStringValue("agg eng/stby", "STBY")
  databank.setStringValue("agg off/stby", "OFF")
  databank.setIntValue("agg_base", 1000)
  databank.setIntValue("agg_t_alt", 1000)
  databank.setStringValue("nav agg", "OFF")
  databank.setFloatValue("DMG Scale", 3)
  databank.setFloatValue("DMG TV U/D", -20)
  databank.setFloatValue("DMG TV L/R", 30)
  databank.setFloatValue("DMG SV U/D", 40)
  databank.setFloatValue("DMG SV L/R", 100)
  databank.setIntValue("holding_speed", 300)
  databank.setIntValue("Holding", 0)
  local check=databank.getStringValue("wp_settings"):gsub("@@@","\"")
  if check=="" then
   local data={}
   data=json.encode(data)
   databank.setStringValue("wp_settings", data:gsub("\"","@@@"))
  end
 end
 if (Databank_Soft_Reset or databank.getStringValue("databank_verification")~="Verified") then databank_initialization() end
 if Databank_Hard_Reset then databank.clear() databank_initialization() end

--PARAMETERS
 if (databank.getFloatValue("navigator_MTOW")~=0) then
  factory_MTOW=databank.getFloatValue("navigator_MTOW")
  new_MTOW=factory_MTOW/1000
 else
  factory_MTOW=730000 --export
  new_MTOW=factory_MTOW/1000
 end

 if (databank.getFloatValue("navigator_autobrake")~=0) then
  factory_autobrake=databank.getFloatValue("navigator_autobrake")
 else
  factory_autobrake=2.3 --export
 end
 factory_PE_target_altitude=20000 --export

 if (databank.getFloatValue("navigator_wpdist")~="") then
  wp_sequencing_distance=databank.getFloatValue("navigator_wpdist")
 else
  wp_sequencing_distance=0.5 --export
 end

 if (databank.getIntValue("holding_speed")~=0) then
  holding_speed=databank.getIntValue("holding_speed")
 else
  holding_speed=300 --export
 end

 local FontColor=databank.getStringValue("FontColor")
  FontColor=json.decode(FontColor)
  Font_R=FontColor[1]
  Font_G=FontColor[2]
  Font_B=FontColor[3]
 local ButtonColor=databank.getStringValue("Background")
  ButtonColor=json.decode(ButtonColor)
  Button_R=ButtonColor[1]
  Button_G=ButtonColor[2]
  Button_B=ButtonColor[3]
 local TableColor=databank.getStringValue("TableColor")
  TableColor=json.decode(TableColor)
  Table_R=TableColor[1]
  Table_G=TableColor[2]
  Table_B=TableColor[3]
 local FontTitle=databank.getStringValue("FontTitle")
  FontTitle=json.decode(FontTitle)
  Title_R=FontTitle[1]
  Title_G=FontTitle[2]
  Title_B=FontTitle[3]
 local ButtonPressed=databank.getStringValue("Selection")
  ButtonPressed=json.decode(ButtonPressed)
  Button_Pressed_R=ButtonPressed[1]
  Button_Pressed_G=ButtonPressed[2]
  Button_Pressed_B=ButtonPressed[3]
 local Alpha1=databank.getFloatValue("Alpha1")
 local Alpha2=databank.getFloatValue("Alpha2")

--CSS
 function css_html()
  HUD_HTML={}
  HUD_HTML[#HUD_HTML+1]=[[
  <style>
   td {border:]]..2*ScRt..[[px solid rgb(]].. Table_R ..[[,]].. Table_G ..[[,]].. Table_B ..[[);
    color:rgb(]].. Font_R ..[[,]].. Font_G ..[[,]].. Font_B ..[[);
    font-family:Arial;
    font-size:]]..15*ScRt..[[px;
    text-align:center;
    vertical-align:middle;}
   .pvp {font-size:]]..12*ScRt..[[px;}
   .bkgnd {background:rgba(]].. Button_R ..[[,]].. Button_G ..[[,]].. Button_B ..[[,]].. Alpha1 ..[[)}
   .bkgndSolid {background:rgba(]].. Button_R ..[[,]].. Button_G ..[[,]].. Button_B ..[[,]].. Alpha2 ..[[)}
   .center {text-align:center}
   .left {text-align:left}
   .right {text-align:right}
   .Fright {float:right}
   .Fleft {float:left}
   .Title {color:rgb(]].. Title_R ..[[,]].. Title_G ..[[,]].. Title_B ..[[) !important}
   .Units {color:rgb(0,255,255) !important}
   .select {background-color:rgb(]].. Button_Pressed_R ..[[,]].. Button_Pressed_G ..[[,]].. Button_Pressed_B ..[[)}
   .green {color:rgb(0,255,0) !important}
   .red {color:rgb(255,0,0) !important}
  </style>]]
  return HUD_HTML
 end

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
  local dbKeys=databank.getNbKeys()
  if option==0 then
   if dbKeys>0 then
    local counter=0
    local wp_id=""
    for i=1, dbKeys do
     wp_id=tostring("wp"..i)
     local name=databank.getStringValue(wp_id)
     if (tostring(name)~=nil and tostring(name)~="") then counter=counter + 1 end
    end
    pages=math.ceil(counter/10)
    if pages==0 then pages=1 end
   else
    pages=1
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
  local dbn=databank.getNbKeys()
  stored=""
  for i=1, dbn+1 do
   local wp_id=tostring("wp"..i)
   local wp_checking=databank.getStringValue(wp_id)
   if keypad_input_wpname==wp_checking then
    stored="WP Name Already Exist"
    if screenState~=7 then system.print("WP Name Already Exist") end
   break end
  end
  if stored~="WP Name Already Exist" then
   for i=1, dbn+1 do
    local wp_id=tostring("wp"..i)
    local wp_checking=databank.getStringValue(wp_id)
    if wp_checking=="" then
     local name=databank.setStringValue(wp_id, keypad_input_wpname)
     local coord=databank.setStringValue(wp_id.."_coord", tostring(from_coordinates))
     stored="STORED"
     if screenState~=7 then system.print("WP Stored") end
     break
    end
   end
  end
  wp_settings_init()
 end

--ENT DESTINATION WP
 function ent_to_wp(x)
  if (screenState==0 or RouteActivated) then
   if (wp_list[x]~=nil) then
    local dest=wp_list[x].id
    if dest~="" then
     if (RouteActivated==false or RouteActivated==nil) then screenState=3 end
     keypad_input_dest=dest
     databank.setStringValue("to", keypad_input_dest)
     destination_inserted=false
     destination_coord=""
     distance_to_go=""
     distance_to_go_warp=0
     HUDScreen()
     ent_button()
    else
     screenState=3
     HUDScreen()
    end
   else
    screenState=3
    HUDScreen()
   end
  elseif screenState==6 then
   local dest=atlas_list[x]
   for i, v in pairs(atlas[0]) do
    if dest==atlas[0][i].name[1] then
     screenState=3
     keypad_input_dest=dest
     databank.setStringValue("to", keypad_input_dest)
     destination_inserted=false
     destination_coord=""
     distance_to_go=""
     distance_to_go_warp=0
     HUDScreen()
     ent_button()
     break
    end
   end
  else
   screenState=3
   HUDScreen()
  end
 end

--ENT FROM WP
 function ent_from_wp(x)
  FROMSelect={"select",""}
  if screenState==0 then
   if (wp_list[x]~=nil) then
    local from=wp_list[x].id
    if from~="" then
     screenState=2
     keypad_input_from=from
     databank.setStringValue("from", keypad_input_from)
     from_coordinates=""
     from_inserted=false
     FROMSelect[1]="select"
     keypad_input_wpname=""
     wpname_inserted=false
     FROMSelect[2]=""
     stored=""
     HUDScreen()
     ent_button()
    else
     screenState=2
     HUDScreen()
    end
   else
    screenState=2
    HUDScreen()
   end
  elseif screenState==6 then
   local from=atlas_list[x]
   for i, v in pairs(atlas[0]) do
    if from==atlas[0][i].name[1] then
     screenState=2
     keypad_input_from=from
     databank.setStringValue("from", keypad_input_from)
     from_coordinates=""
     from_inserted=false
     FROMSelect[1]="select"
     keypad_input_wpname=""
     wpname_inserted=false
     FROMSelect[2]=""
     stored=""
     HUDScreen()
     ent_button()
     break
    end
   end
  else
   screenState=2
   HUDScreen()
  end
 end

--WP SETTINGS INIT
 function wp_settings_init()
  local dbKeys=databank.getNbKeys()

  local check=databank.getStringValue("wp_settings"):gsub("@@@","\"")
  if check=="" then
   local data={}
   data=json.encode(data)
   databank.setStringValue("wp_settings", data:gsub("\"","@@@"))
  else
   check=json.decode(check)
   for i, v in pairs(check) do
    if (check[i].alt=="" and check[i].s=="") then check[i]=nil end
   end
   check=json.encode(check)
   databank.setStringValue("wp_settings", check:gsub("\"","@@@"))
  end
 end
 wp_settings_init()

--CREATE ROUTE
 function AddRemoveRoute()
  if WpRouteList==nil then WpRouteList={} end
  if DistanceList==nil then DistanceList={} end
  if FlyStat==nil then FlyStat={} end
  if GoTo==nil then GoTo={} end
  if ItHasSettings==nil then ItHasSettings={} end
  local x=WPSelected
  if SelectionList[2]=="select" then --Settings > Route > Execute
   if RouteExist then WpRouteList={} DistanceList={} FlyStat={} GoTo={} ItHasSettings={} MenuSelect={[0]="0","","","","","","","","select"} end
  elseif ((SelectionList[5]=="select" or SelectionList[6]=="select") and wp_list[x]) then --WP > +Route/+Route and HOLD
   local WpName=wp_list[x].name
   for i=1, (#WpRouteList+1) do
    if (WpRouteList[i]==nil or WpRouteList[i]=="") then
     WpRouteList[i]=WpName
     MenuSelect[i+8]=""
     DistanceList[i]=""
     FlyStat[i]=""
     GoTo[i]="Go To &#8594;"
     ItHasSettings[i]=""
     if SelectionList[6]=="select" then
      WpRouteList[i+1]="HOLD"
      MenuSelect[i+1+8]=""
      DistanceList[i+1]=""
      FlyStat[i+1]=""
      GoTo[i+1]=""
      ItHasSettings[i+1]=""
     end
     break
    end
   end
  elseif (SelectionList[7]=="select" and wp_list[x]) then --WP > -Route
   local WpName=wp_list[x].name
   for i=1, #WpRouteList do
    if WpRouteList[i]==WpName then
     WpRouteList[i]=""
     MenuSelect[i+8]=nil
     DistanceList[i]=nil
     FlyStat[i]=nil
     GoTo[i]=nil
     ItHasSettings[i]=nil
     if WpRouteList[i+1]=="HOLD" then
      WpRouteList[i+1]=""
      MenuSelect[i+1+8]=nil
      DistanceList[i+1]=nil
      FlyStat[i+1]=nil
      GoTo[i+1]=nil
      ItHasSettings[i+1]=nil
     end
     break
    end
   end
   local WpRouteList_temp={}
   local counter=0
   for i=1, #WpRouteList do
    if WpRouteList[i]~="" then counter=counter+1 WpRouteList_temp[counter]=WpRouteList[i] GoTo[i]="Go To &#8594;" end
   end
   WpRouteList=WpRouteList_temp
  end
  SelectionList=nil
  if #WpRouteList>0 then RouteExist=true else RouteExist=false end
  HUDScreen()
 end

--ROUTE CHECK
 function RouteCheck()
  local RoutePossible=false
  if (#WpRouteList==1 or (#WpRouteList==2 and WpRouteList[2]=="HOLD")) then
   local D1=DistanceList[1]
   D1=D1:gsub("%a","")
   if tonumber(D1)>=wp_sequencing_distance then RoutePossible=true end
  elseif #WpRouteList>1 then
   for i=1, #WpRouteList do
    local D1=DistanceList[i]
    if D1=="Holding" then D1="999 Km" end
    D1=D1:gsub("%a","")
    if tonumber(D1)>=wp_sequencing_distance then RoutePossible=true break else RoutePossible=false end
   end
  end
  if RoutePossible then SelectionIsTrue=false RouteActivated=true route_page()
  else WpRouteList[1]="WP Too Close" route_page() HUDScreen() end
 end

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
   local dbn=databank.getNbKeys()
   local counter=0
   for i=1, dbn do
    local key="wp"..i
    local value=databank.getStringValue(key)
    local key_coord="wp"..i.."_coord"
    local value_coord=databank.getStringValue(key_coord)
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
    local data=databank.getStringValue(route_id):gsub("@@@","\"")
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
   local data=databank.getStringValue("wp_settings"):gsub("@@@","\"")
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
   local value=databank.getFloatValue("navigator_MTOW")
   settings_list[1]={["name"]=name, ["value"]=value}
   name="navigator_autobrake"
   value=databank.getFloatValue("navigator_autobrake")
   settings_list[2]={["name"]=name, ["value"]=value}
   name="navigator_wpdist"
   value=databank.getFloatValue("navigator_wpdist")
   settings_list[3]={["name"]=name, ["value"]=value}
   name="holding_speed"
   value=databank.getFloatValue("holding_speed")
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
   local value=databank.getStringValue("Ship ID")
   id_list[1]={["name"]=name, ["value"]=value}
  else
   keypad_input_shipid=""
   item_cleared=item_cleared.."(3)"
  end

  if colors==true then
   local name="TableColor"
   local value=databank.getStringValue("TableColor")
   colors_list[1]={["name"]=name, ["value"]=value}
   name="FontTitle"
   value=databank.getStringValue("FontTitle")
   colors_list[2]={["name"]=name, ["value"]=value}
   name="FontColor"
   value=databank.getStringValue("FontColor")
   colors_list[3]={["name"]=name, ["value"]=value}
   name="Selection"
   value=databank.getStringValue("Selection")
   colors_list[4]={["name"]=name, ["value"]=value}
   name="Background"
   value=databank.getStringValue("Background")
   colors_list[5]={["name"]=name, ["value"]=value}
  else
   Table_RGB="0,0,255"
   databank.setStringValue("TableColor", "{0,0,255}")
   Title_RGB="255,255,0"
   databank.setStringValue("FontTitle", "{255,255,0}")
   Font_RGB="217,217,217"
   databank.setStringValue("FontColor", "{217,217,217}")
   Button_Pressed_RGB="0,0,255"
   databank.setStringValue("Background", "{0,0,255}")
   Button_RGB="255,0,0"
   databank.setStringValue("Selection", "{255,0,0}")
   item_cleared=item_cleared.."(4)"
  end

  if dmg==true then
   local name="DMG Scale"
   local value=databank.getFloatValue("DMG Scale")
   dmg_list[1]={["name"]=name, ["value"]=value}
   name="DMG TV U/D"
   value=databank.getFloatValue("DMG TV U/D")
   dmg_list[2]={["name"]=name, ["value"]=value}
   name="DMG TV L/R"
   value=databank.getFloatValue("DMG TV L/R")
   dmg_list[3]={["name"]=name, ["value"]=value}
   name="DMG SV U/D"
   value=databank.getFloatValue("DMG SV U/D")
   dmg_list[4]={["name"]=name, ["value"]=value}
   name="DMG SV L/R"
   value=databank.getFloatValue("DMG SV L/R")
   dmg_list[5]={["name"]=name, ["value"]=value}
  else
   keypad_input_dmg1=3
   DMG_REP_TOP_VIEW_Up_Down=-20
   DMG_REP_TOP_VIEW_LH_RH=30
   DMG_REP_SIDE_VIEW_Up_Down=40
   DMG_REP_SIDE_VIEW_LH_RH=100
   item_cleared=item_cleared.."(5)"
  end

  databank.clear()
  system.print("CLEARING DATABANK")
  databank_initialization()
  system.print("REGENERATING DATABANK, KEYS: "..databank.getNbKeys())

  if wp==true then
   local id=0
   local restore_data={}
   local route_id=""
   for i=1, #store_db_wp do
    databank.setStringValue(store_db_wp[i].key, store_db_wp[i].value)
    databank.setStringValue(store_db_wp[i].key_coord, store_db_wp[i].value_coord)
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
    databank.setStringValue(route_id, restore_data:gsub("\"","@@@"))
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
    databank.setStringValue("wp_settings", restore_data:gsub("\"","@@@"))
   end
  end

  if settings==true then
   for i=1, #settings_list do
    databank.setFloatValue(settings_list[i].name, settings_list[i].value)
   end
  end

  if id==true then
   for i=1, #id_list do
    databank.setStringValue(id_list[i].name, id_list[i].value)
   end
  end

  if colors==true then
   for i=1, #colors_list do
    databank.setStringValue(colors_list[i].name, colors_list[i].value)
   end
  end

  if dmg==true then
   for i=1, #dmg_list do
    databank.setFloatValue(dmg_list[i].name, dmg_list[i].value)
   end
  end

  wp_settings_init()

  reset_db_status="CLEARED: "..item_cleared.." Restart The Interface"
  system.print("DATABANK REGENERATED, KEYS: "..databank.getNbKeys())

  HUDScreen()
 end

--DATA STATUS
 ship_id=""
 ship_id_verified=false

 if (databank.getStringValue("databank_verification")=="Verified") then
  databank.clearValue("")
  ship_id=databank.getStringValue("Ship ID")
 end
 if (ship_id=="No ID" or ship_id=="") then ShipIdCheck=false else ShipIdCheck=true end

--BUTTON FUNCTIONS
 --ADD/RENAME WP BUTTON
  function add_wp()
   if (screenState==2 and keypad_input_from=="PPOS" and keypad_input_wpname~="") then
    wp_check()
    screenState=2
   elseif (screenState==2 and keypad_input_from~="" and keypad_input_wpname~="") then
    databank.setStringValue(wp_id_rename, keypad_input_wpname)
    stored="WP RENAMED"
    local ext=databank.getStringValue("wp_settings"):gsub("@@@","\"")
    ext=json.decode(ext)
    if ext[keypad_input_from] then
     ext[keypad_input_wpname]={["alt"]=ext[keypad_input_from].alt,["s"]=ext[keypad_input_from].s}
     ext=json.encode(ext)
     databank.setStringValue("wp_settings", ext:gsub("\"","@@@"))
    end
    screenState=2
   elseif (screenState==7 and wp_name_inserted==true and wp_lat_inserted==true and wp_lon_inserted==true and wp_alt_inserted==true and WPSTORESelect[1]=="select") or (LuaWp and LuaWpName and LuaSavingWp) then
    keypad_input_wpname=keypad_input_wp_name
    if (wp_selected_planet~="Invalid Entry" and wp_selected_planet~="World Coordinates" and wp_coordinated_stored~="") then from_coordinates=coord_converter()
    else from_coordinates=vec3(tonumber(keypad_input_wp_lat),tonumber(keypad_input_wp_lon),tonumber(keypad_input_wp_alt)) end
    wp_check()
   end
  end

 --CLR WP BUTTON
  function clr_wp(clr)
   if (wp_list[clr] and screenState==0) then
    local wp_id=wp_list[clr].id
    for i=1, #wp_list do
     if wp_list[i].id==wp_id then
      local wp_del=wp_list[i].wp
      local wp_name=wp_list[i].name
      databank.clearValue(wp_del)
      databank.clearValue(wp_del.."_coord")
      local ext=databank.getStringValue("wp_settings"):gsub("@@@","\"")
      ext=json.decode(ext)
      ext[wp_name]=nil
      ext=json.encode(ext)
      databank.setStringValue("wp_settings", ext:gsub("\"","@@@"))
      wp_settings_init()
      break
     end
    end
   end
   HUDScreen()
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
  end

 --ENT BUTTON
  function ent_button()
   --ENT Time Calculator
    if screenState==1 then
     if (su_distance_inserted==true and (keypad_input_speed~="" or keypad_input_speed=="" or tonumber(keypad_input_speed)>0)) then
      local su_num=tonumber(keypad_input_su)
      local speed_num=tonumber(keypad_input_speed)
      if keypad_input_speed=="" then
       if ConstructVel()==0 then
        keypad_input_speed=0
        databank.setFloatValue("navigator_speed", 0)
        speed_num=0
        databank.setFloatValue("navigator_eta_h", 0)
        databank.setFloatValue("navigator_eta_m", 0)
        databank.setFloatValue("navigator_eta_s", 0)
        speed_inserted=false
       else
        keypad_input_speed=tostring(ConstructVel())
        speed_num=ConstructVel()
        databank.setFloatValue("navigator_speed", speed_num)
        speed_inserted=true
       end
      elseif keypad_input_speed~="" then
       if tonumber(keypad_input_speed)>MaxSpeed() then keypad_input_speed=math.floor(MaxSpeed()) end
       speed_num=tonumber(keypad_input_speed)
       databank.setFloatValue("navigator_speed", speed_num)
      end
      if speed_num==0 then
       time_to_go="Speed Is Invalid"
       databank.setFloatValue("navigator_eta_h", 0)
       databank.setFloatValue("navigator_eta_m", 0)
       databank.setFloatValue("navigator_eta_s", 0)
       speed_inserted=false
      else
       local time_min=(su_num*200/speed_num*60)
       local time_h  =(time_min/60)
       local time_m  =(time_h - math.floor(time_h))*60
       local time_s  =(time_m - math.floor(time_m))*60
       time_to_go=math.floor(time_h) .." h ".. math.floor(time_m) .." m ".. math.floor(time_s) .." s"
       databank.setFloatValue("navigator_eta_h", math.floor(time_h))
       databank.setFloatValue("navigator_eta_m", math.floor(time_m))
       databank.setFloatValue("navigator_eta_s", math.floor(time_s))
       speed_inserted=true
      end
     elseif (su_distance_inserted==false and keypad_input_su=="" and keypad_input_speed=="") then
      databank.setFloatValue("navigator_distance", "n/a")
     elseif (su_distance_inserted==false and keypad_input_su~="" and keypad_input_speed=="") then
      databank.setFloatValue("navigator_distance", keypad_input_su)
      su_distance_inserted=true
      su_tick=""
      TimeCalcSelect[1]=""
      speed_tick=">"
      TimeCalcSelect[2]="select"
     end
    end

   --ENT From
    if screenState==2 then
     if (from_inserted==false and keypad_input_from=="") then
      local myPos=ConstructPos()
      keypad_input_from="PPOS"
      databank.setStringValue("navigator_from", "PPOS")
      databank.setStringValue("from", "PPOS")
      from_coordinates=tostring(myPos)
      databank.setStringValue("navigator_from_coordinates", tostring(myPos))
      from_inserted=true
      FROMSelect[1]=""
      FROMSelect[2]="select" 
     elseif (from_inserted==false and keypad_input_from~="") then
      from_coordinates_check=false
      for i, v in pairs(atlas[0]) do
       if atlas[0][i].name[1]==keypad_input_from then
        databank.setStringValue("navigator_from", atlas[0][i].name[1])
        databank.setFloatValue("navigator_from_planet_radius", atlas[0][i].radius)
        databank.setStringValue("from", keypad_input_from)
        from_inserted=true
        from_coordinates=vec3(atlas[0][i].center)
        databank.setStringValue("navigator_from_coordinates", tostring(from_coordinates))
        from_coordinates_check=true
        break
       elseif databank.hasKey(keypad_input_from) then
        local wp_check=keypad_input_from
        for x=1, #wp_list do 
         if wp_list[x].id==wp_check then
          local wp_id=wp_list[x].wp
          wp_id_rename=wp_id
          keypad_input_from=databank.getStringValue(wp_id)
          keypad_input_from_coord=wp_id .."_coord"
          databank.setStringValue("navigator_from", keypad_input_from)
          databank.setStringValue("from", keypad_input_from)
          databank.setFloatValue("navigator_from_planet_radius", 1)
          from_inserted=true
          from_coordinates=vec3FromStr(databank.getStringValue(keypad_input_from_coord))
          databank.setStringValue("navigator_from_coordinates", tostring(from_coordinates))
          from_coordinates_check=true
          FROMSelect[1]=""
          FROMSelect[2]="select" 
          break
         end
        end
       elseif from_coordinates_check==false then
        databank.setStringValue("navigator_from", "no From")
        from_inserted=false
        from_coordinates="Not Present In Databank"
        databank.setStringValue("navigator_from_coordinates", "n/a")
        FROMSelect[1]="select"
        FROMSelect[2]=""
       end
      end
     end
    end

   --ENT Destination
    if (screenState==3 or RouteActivated) then
     if (destination_inserted==false and keypad_input_dest~="") then
      destination_check=false
      for i, v in pairs(atlas[0]) do
       if atlas[0][i].name[1]==keypad_input_dest then
        databank.setStringValue("navigator_target_destination", atlas[0][i].name[1])
        databank.setStringValue("to", keypad_input_dest)
        databank.setFloatValue("navigator_target_planet_radius", atlas[0][i].radius)
        destination_inserted=true
        local myPos=ConstructPos()
        destination_coord=vec3(atlas[0][i].center)
        databank.setStringValue("navigator_coordinates", tostring(destination_coord))
        set_coordinates(atlas[0][i])
        distance_to_go=math.floor(((vec3(atlas[0][i].center) - myPos):len())/1000/200*100)/100
        distance_to_go_warp=distance_to_go
        databank.setFloatValue("navigator_distance", distance_to_go)
        databank.setFloatValue("navigator_eta_h", 0)
        databank.setFloatValue("navigator_eta_m", 0)
        databank.setFloatValue("navigator_eta_s", 0)
        destination_check=true
        break
       elseif databank.hasKey(keypad_input_dest) then
        local wp_check=keypad_input_dest
        for x=1, #wp_list do 
         if wp_list[x].id==wp_check then
          local wp_id=wp_list[x].wp
          keypad_input_dest=databank.getStringValue(wp_id)
          keypad_input_dest_coord=wp_id .."_coord"
          databank.setStringValue("navigator_target_destination", keypad_input_dest)
          databank.setStringValue("to", keypad_input_dest)
          databank.setFloatValue("navigator_target_planet_radius", 1)
          destination_inserted=true
          local myPos=ConstructPos()
          destination_coord=vec3FromStr(databank.getStringValue(keypad_input_dest_coord))
          databank.setStringValue("navigator_coordinates", tostring(destination_coord))
          set_wp_coordinates(databank.getStringValue(keypad_input_dest_coord))
          distance_to_go=math.floor(((destination_coord - myPos):len())/1000/200*100)/100
          distance_to_go_warp=distance_to_go
          databank.setFloatValue("navigator_distance", distance_to_go)
          databank.setFloatValue("navigator_eta_h", 0)
          databank.setFloatValue("navigator_eta_m", 0)
          databank.setFloatValue("navigator_eta_s", 0)
          destination_check=true
          break
         else
          databank.setStringValue("navigator_target_destination", "no Dest.")
          destination_inserted=false
          destination_coord="Not Present In Databank"
          databank.setStringValue("navigator_coordinates", "n/a")
         end
        end
       elseif (destination_check==false) then
        databank.setStringValue("navigator_target_destination", "no Dest.")
        destination_inserted=false
        destination_coord="Not Present In Databank"
        databank.setStringValue("navigator_coordinates", "n/a")
       end
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
      elseif (tonumber(keypad_input_pe_target_alt)<MinimumABSAltitude and MinimumABSAltitude>=MinimumAltitude) then
       target_alt_warning="Warning Altitude below 10.000 m"
       target_pe_altitude_inserted=true
      elseif (tonumber(keypad_input_pe_target_alt)<MinimumAltitude) then
       target_alt_warning="Warning Destination Atmosphere Altitude is "..MinimumAltitude
       target_pe_altitude_inserted=true
      elseif (tonumber(keypad_input_pe_target_alt)>=MinimumABSAltitude and tonumber(keypad_input_pe_target_alt)>=MinimumAltitude) then
       databank.setFloatValue("navigator_pe_target_altitude", tonumber(keypad_input_pe_target_alt))
       target_pe_altitude_inserted=true
       stored_pe_target_alt=keypad_input_pe_target_alt
       databank.setFloatValue("PE_altitude", math.floor(stored_pe_target_alt))
      elseif target_alt_warning=="Invalid Input" then
       target_alt_warning="Invalid Input"
       target_pe_altitude_inserted=true
      end
     else
      target_alt_warning="Invalid Input"
      target_pe_altitude_inserted=true
     end
    end

   --ENT Settings
    if screenState==9 then        --(Settings Menu)
     if SETTINGSSelect[1]=="select" then     --SELECT Ship Settings
      screenState=5
      SHIPSETINGSSelect={[0]="select","","","",""}
     elseif SETTINGSSelect[2]=="select" then --SELECT WP Store
      screenState=7
      WPSTORESelect={[0]="select","","","",""}
      wp_selected_planet=""
      keypad_input_wp_name=""
      keypad_input_wp_lat=""
      keypad_input_wp_lon=""
      keypad_input_wp_alt=""
     elseif SETTINGSSelect[3]=="select" then --SELECT WP Sync
      screenState=8
      WPSYNCSelect={[0]="select","","",""}
      sync_result=""
      receiving_wp=0
      wp_synced=0
      index_sync=1
      prog_bar=0
      keypad_input_shipid=databank.getStringValue("Ship ID")
     elseif SETTINGSSelect[4]=="select" then --SELECT Screen Colors
      screenState=10
      COLORSSelect={[0]="select","","","","","","",""}
      local TableColor=databank.getStringValue("TableColor")
      TableColor=json.decode(TableColor)
      keypad_input_color1=TableColor[1] ..",".. TableColor[2] ..",".. TableColor[3]
      local FontTitle=databank.getStringValue("FontTitle")
      FontTitle=json.decode(FontTitle)
      keypad_input_color2=FontTitle[1] ..",".. FontTitle[2] ..",".. FontTitle[3]
      local FontColor=databank.getStringValue("FontColor")
      FontColor=json.decode(FontColor)
      keypad_input_color3=FontColor[1] ..",".. FontColor[2] ..",".. FontColor[3]
      local ButtonPressed=databank.getStringValue("Selection")
      ButtonPressed=json.decode(ButtonPressed)
      keypad_input_color4=ButtonPressed[1] ..",".. ButtonPressed[2] ..",".. ButtonPressed[3]
      local ButtonColor=databank.getStringValue("Background")
      ButtonColor=json.decode(ButtonColor)
      keypad_input_color5=ButtonColor[1] ..",".. ButtonColor[2] ..",".. ButtonColor[3]
      local Alpha1=databank.getFloatValue("Alpha1")
      keypad_input_color6=Alpha1
      local Alpha2=databank.getFloatValue("Alpha2")
      keypad_input_color7=Alpha2
     elseif SETTINGSSelect[5]=="select" then --SELECT DMG Rep.
      screenState=11  
      DMGREPSelect={[0]="select","","","","",""}
      keypad_input_dmg1=databank.getFloatValue("DMG Scale")
      DMG_REP_TOP_VIEW_Up_Down=databank.getFloatValue("DMG TV U/D")
      DMG_REP_TOP_VIEW_LH_RH=databank.getFloatValue("DMG TV L/R")
      DMG_REP_SIDE_VIEW_Up_Down=databank.getFloatValue("DMG SV U/D")
      DMG_REP_SIDE_VIEW_LH_RH=databank.getFloatValue("DMG SV L/R")
     elseif SETTINGSSelect[6]=="select" then --SELECT DB Reset
      screenState=12
      DBRESSelect={[0]="select","","","","","",""}
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
      reset_db_status=databank.getNbKeys().." Keys"
      HUDScreen()
     end
    elseif screenState==5 then    --(Ship Settings)
     if SHIPSETINGSSelect[1]=="select" then
      if (keypad_input_MTOW=="") then
       keypad_input_MTOW=factory_MTOW/1000
       new_MTOW=keypad_input_MTOW
       databank.setFloatValue("navigator_MTOW", new_MTOW*1000)
      else
       new_MTOW=tonumber(keypad_input_MTOW)
       databank.setFloatValue("navigator_MTOW", new_MTOW*1000)
      end
     elseif SHIPSETINGSSelect[2]=="select" then
      if keypad_input_autobrake=="" then
       keypad_input_autobrake=factory_autobrake
       databank.setFloatValue("navigator_autobrake", keypad_input_autobrake)
      else
       keypad_input_autobrake=tonumber(keypad_input_autobrake)
       databank.setFloatValue("navigator_autobrake", keypad_input_autobrake)
      end
     elseif SHIPSETINGSSelect[3]=="select" then
      if keypad_input_wpdist=="" then
       keypad_input_wpdist=wp_sequencing_distance
       databank.setFloatValue("navigator_wpdist", keypad_input_wpdist)
      else
       keypad_input_wpdist=tonumber(keypad_input_wpdist)
       wp_sequencing_distance=keypad_input_wpdist
       databank.setFloatValue("navigator_wpdist", keypad_input_wpdist)
      end
     elseif SHIPSETINGSSelect[4]=="select" then
      if keypad_input_holding=="" then
       keypad_input_holding=databank.getIntValue("holding_speed")
       holding_speed=keypad_input_holding
      else
       keypad_input_holding=tonumber(keypad_input_holding)
       holding_speed=keypad_input_holding
       databank.setIntValue("holding_speed", holding_speed)
      end
     end
    elseif screenState==8 then    --(WP Sync)
     msg_counter=0
     if (WPSYNCSelect[1]=="select" and keypad_input_shipid~="") then
      ship_id=keypad_input_shipid
      databank.setStringValue("Ship ID", ship_id)
      ShipIdCheck=true
     end
     if (WPSYNCSelect[2]=="select" and keys_number>0 and WPSYNCSelect[3]=="" and emitter) then
      emitter.send("AviatorHUD", "<SendDataToBase>"..ship_id)
      sync_result="Downlink Requested"
      delay_timer=5
      delay_id="ShipIDResponse"
      unit.setTimer("delay", 1)
     elseif (keys_number==0) then
      prog_bar=0
      sync_result="No Data To Sync"
     end
     if WPSYNCSelect[3]=="select" then ship_id=databank.getStringValue("Ship ID")
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
     if COLORSSelect[1]=="select" then
      if (keypad_input_color1:find("%a")~=nil or keypad_input_color1:find("(%d+),(%d+),(%d+)")==nil) then keypad_input_color1="Insert RGB"
      elseif keypad_input_color1~="" then
       Table_RGB="{".. keypad_input_color1 .."}"
       databank.setStringValue("TableColor", Table_RGB)
       local TableColor=json.decode(Table_RGB)
       Table_R=(TableColor[1])
       Table_G=(TableColor[2])
       Table_B=(TableColor[3])
      end
     elseif COLORSSelect[2]=="select" then
      if (keypad_input_color2:find("%a")~=nil or keypad_input_color2:find("(%d+),(%d+),(%d+)")==nil) then keypad_input_color2="Insert RGB"
      elseif keypad_input_color2~="" then
       Title_RGB="{".. keypad_input_color2 .."}"
       databank.setStringValue("FontTitle", Title_RGB)
       local FontTitle=json.decode(Title_RGB)
       Title_R=(FontTitle[1])
       Title_G=(FontTitle[2])
       Title_B=(FontTitle[3])
      end
     elseif COLORSSelect[3]=="select" then
      if (keypad_input_color3:find("%a")~=nil or keypad_input_color3:find("(%d+),(%d+),(%d+)")==nil) then keypad_input_color3="Insert RGB"
      elseif keypad_input_color3~="" then
       Font_RGB="{".. keypad_input_color3 .."}"
       databank.setStringValue("FontColor", Font_RGB)
       local FontColor=json.decode(Font_RGB)
       Font_R=(FontColor[1])
       Font_G=(FontColor[2])
       Font_B=(FontColor[3])
      end
     elseif COLORSSelect[4]=="select" then
      if (keypad_input_color4:find("%a")~=nil or keypad_input_color4:find("(%d+),(%d+),(%d+)")==nil) then keypad_input_color4="Insert RGB"
      elseif keypad_input_color4~="" then
       Button_Pressed_RGB="{".. keypad_input_color4 .."}"
       databank.setStringValue("Selection", Button_Pressed_RGB)
       local ButtonPressed=json.decode(Button_Pressed_RGB)
       Button_Pressed_R=(ButtonPressed[1])
       Button_Pressed_G=(ButtonPressed[2])
       Button_Pressed_B=(ButtonPressed[3])
      end
     elseif COLORSSelect[5]=="select" then
      if (keypad_input_color5:find("%a")~=nil or keypad_input_color5:find("(%d+),(%d+),(%d+)")==nil) then keypad_input_color5="Insert RGB"
      elseif keypad_input_color5~="" then
       Button_RGB="{".. keypad_input_color5 .."}"
       databank.setStringValue("Background", Button_RGB)
       local ButtonColor=json.decode(Button_RGB)
       Button_R=(ButtonColor[1])
       Button_G=(ButtonColor[2])
       Button_B=(ButtonColor[3])
      end
     elseif COLORSSelect[6]=="select" then
      if keypad_input_color6~="" then
       Alpha1=keypad_input_color6
       databank.setFloatValue("Alpha1", Alpha1)
      end
     elseif COLORSSelect[7]=="select" then
      if keypad_input_color7~="" then
        Alpha2=keypad_input_color7
        databank.setFloatValue("Alpha2", Alpha2)
       end
     end
    elseif screenState==12 then   --(DB reset)
     if DBRESSelect[1]=="select" then db_mark_1="X" db_mark_1_TF=true
     elseif DBRESSelect[2]=="select" then db_mark_2="X" db_mark_2_TF=true
     elseif DBRESSelect[3]=="select" then db_mark_3="X" db_mark_3_TF=true
     elseif DBRESSelect[4]=="select" then db_mark_4="X" db_mark_4_TF=true
     elseif DBRESSelect[5]=="select" then db_mark_5="X" db_mark_5_TF=true
     end
    elseif screenState==16 then   --(WP Setting)
     if WPSETTINGSelect[1]=="select" then
      if (tonumber(keypad_input_wp_altitude)~=nil) then wp_altitude_inserted=true end
     elseif WPSETTINGSelect[2]=="select" then
      if (tonumber(keypad_input_wp_speed)~=nil) then wp_speed_inserted=true end
     end

     local ext=databank.getStringValue("wp_settings"):gsub("@@@","\"")
     ext=json.decode(ext)
     ext[edit_wp]={["alt"]=keypad_input_wp_altitude,["s"]=keypad_input_wp_speed}
     ext=json.encode(ext)
     databank.setStringValue("wp_settings", ext:gsub("\"","@@@"))
     wp_settings_init()
    end

  end

 --CLR BUTTON
  function clr_button()
   --CLR Time Calculator
    if screenState==1 then
     if (su_distance_inserted==true and keypad_input_su~="" and keypad_input_speed~="") then
      keypad_input_speed=nil
      databank.setFloatValue("navigator_speed", "0")
      speed_inserted=false
      time_to_go=""
      databank.setFloatValue("navigator_eta_h", 0)
      databank.setFloatValue("navigator_eta_m", 0)
      databank.setFloatValue("navigator_eta_s", 0)
     elseif (su_distance_inserted==true and keypad_input_su~="" and keypad_input_speed=="") then
      keypad_input_su=nil
      databank.setStringValue("navigator_distance", "n/a")
      su_distance_inserted=false
      speed_inserted=false
      databank.setStringValue("navigator_speed", "0")
      databank.setFloatValue("navigator_eta_h", 0)
      databank.setFloatValue("navigator_eta_m", 0)
      databank.setFloatValue("navigator_eta_s", 0)
     elseif (su_distance_inserted==false and keypad_input_su~="" and keypad_input_speed=="") then
      keypad_input_su=nil
      databank.setStringValue("navigator_distance", "n/a")
      databank.setFloatValue("navigator_eta_h", 0)
      databank.setFloatValue("navigator_eta_m", 0)
      databank.setFloatValue("navigator_eta_s", 0)
     end
    end

   --CLR From
    if screenState==2 then
     if (keypad_input_from~="" or FROMSelect[2]=="select")then
      keypad_input_from=nil
      databank.setStringValue("navigator_from", "no From")
      from_coordinates=""
      databank.setStringValue("navigator_from_coordinates", "n/a")
      from_inserted=false
      databank.setFloatValue("navigator_from_planet_radius", 0)
      wpname_inserted=false
      FROMSelect[1]="select"
      FROMSelect[2]=""
      stored=""
     end
    end

   --CLR Distance To Coordinates
    if screenState==3 then
     if (keypad_input_dest~="") then
      if routing_timer then unit.stopTimer("routing") end
      keypad_input_dest=nil
      databank.setStringValue("navigator_target_destination", "no Dest.")
      destination_inserted=false
      destination_coord=nil
      databank.setStringValue("navigator_coordinates", "n/a")
      distance_to_go=""
      databank.setFloatValue("navigator_target_planet_radius", 0)
     end
    end

   --CLR Settings
    if screenState==8 then  --(WP Sync)
     if WPSYNCSelect[1]=="select" then
      keypad_input_shipid="No ID"
      ship_id=keypad_input_shipid
      databank.setStringValue("Ship ID", ship_id)
      ShipIdCheck=false
     end
    elseif screenState==12 then --(DB reset)
     if DBRESSelect[1]=="select" then db_mark_1="" db_mark_1_TF=false
     elseif DBRESSelect[2]=="select" then db_mark_2="" db_mark_2_TF=false
     elseif DBRESSelect[3]=="select" then db_mark_3="" db_mark_3_TF=false
     elseif DBRESSelect[4]=="select" then db_mark_4="" db_mark_4_TF=false
     elseif DBRESSelect[5]=="select" then db_mark_5="" db_mark_5_TF=false
     elseif DBRESSelect[6]=="select" then databank_clean(db_mark_1_TF, db_mark_2_TF, db_mark_3_TF, db_mark_4_TF, db_mark_5_TF)
     end
    elseif screenState==16 then --(WP Setting)
     if WPSETTINGSelect[1]=="select" then
      keypad_input_wp_altitude=""
      wp_altitude_inserted=false
     elseif WPSETTINGSelect[2]=="select" then
      keypad_input_wp_speed=""
      wp_speed_inserted=false
     end
     ent_button()
    end

  end
 
--SCREEN GENERATOR (← &#8592;)(↑ &#8593;)(→ &#8594;)(↓ &#8595;)
 --MAIN MENU               (screenState=-1)
  function MainMenu()
   if MenuSelect==nil then MenuSelect={[0]="0","","","","","","","",""} end
   if MenuTick==nil then MenuTick=1 MenuSelect[1]="select" else MenuSelect[MenuTick]="select" end
   local List={"Time Calculator","ATLAS","WP","FROM","DESTINATION","PE Target Altitude","Shield","Settings"}
   HUD_HTML[#HUD_HTML+1]=[[
    <div style="position:absolute;top:]].. yStart ..[[px;left:]].. xStart ..[[px;">
    <table class="bkgnd" width="]].. MenuW ..[[">
    <tr height="]].. MenuY ..[["><td class="Title" width="]].. MenuW ..[[">]].. ship_id ..[[</td></tr>]]
    for i=1, #List do
     HUD_HTML[#HUD_HTML+1]=[[<tr height="]].. MenuY ..[["><td class="]].. MenuSelect[i] ..[[" width="]].. MenuW ..[[">]].. List[i] ..[[<span class="Fright">></span></td></tr>]]
    end
    HUD_HTML[#HUD_HTML+1]=[[</table></div>]]
   local HTML=table.concat(HUD_HTML)
   return HTML
  end

 --STORED WAYPOINTS        (screenState=0)
  function stored_waypoints_1()
   local dbKeys=databank.getNbKeys()
   local ext=databank.getStringValue("wp_settings"):gsub("@@@","\"")
   ext=json.decode(ext)
   local wp_setting_color_l=""
   local wp_setting_color_r=""
   local sel=""

   order_list={}
   for i=1, dbKeys do
    local dbkey="wp"..i
    local value=databank.getStringValue(dbkey)
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
     local v=databank.getStringValue(key)
     if dbkeysort==v then
      wp_counter=wp_counter + 1
      local id="wp"..wp_counter
      if ext[v]~=nil then
       if (ext[v].alt~="" or ext[v].s~="") then sel="*" end
      else sel="" end
      wp_list[wp_counter]={["id"]=id,["wp"]=key,["name"]=v,["settings"]=sel}
      break
     end
    end
   end
   wp_pages=generating_wp_pages(0)
   if wp_page_index==nil then wp_page_index=1 else wp_page_index=wp_page_index end

   HUD_HTML[#HUD_HTML+1]=[[
    <div style="position:absolute;top:]].. yStart+(MenuY * MenuTick) ..[[px;left:]].. (xStart+MenuW+10) ..[[px;">
    <table class="bkgnd" width="]]..500*ScRt..[[px">
    <tr height="]].. MenuY ..[["><td colspan="4" class="Title ]].. WPSelect[0] ..[["><span class="Fleft">&#8592;</span> &#8592; Page ]]..wp_page_index..[[ / ]]..wp_pages..[[ &#8594;</td></tr>]]

   local index=(wp_page_index*10)-9
   local x=0
   for i=index, (index+4) do
    if i<=wp_counter then wp_id_l=wp_list[i].wp else wp_id_l="" end
    if (i+5)<=wp_counter then wp_id_r=wp_list[i+5].wp else wp_id_r="" end
    x=x+1
    local tick_l=WPSelect[x]
    local tick_r=WPSelect[x+5]
        
    wp_name_l=databank.getStringValue(wp_id_l)
    if ext[wp_name_l] then
     if wp_list[i].settings=="*" then wp_setting_color_l="green" end
    else wp_setting_color_l="" end

    wp_name_r=databank.getStringValue(wp_id_r)
    if ext[wp_name_r] then 
     if wp_list[i+5].settings=="*" then wp_setting_color_r="green" end
    else wp_setting_color_r="" end

    HUD_HTML[#HUD_HTML+1]=[[
     <tr height="]].. MenuY ..[["><td class="Title" width="]]..40*ScRt..[[px">]]..i..[[</td><td class="]]..wp_setting_color_l..[[ ]]..tick_l..[[" width="210vw">]].. wp_name_l ..[[<span class="Fright">></span></td><td class="Title" width="]]..40*ScRt..[[px">]]..(i+5)..[[</td><td class="]]..wp_setting_color_r..[[ ]]..tick_r..[[" width="210vw">]].. wp_name_r ..[[<span class="Fright">></span></td></tr>]]
   end
   HUD_HTML[#HUD_HTML+1]=[[</table></div>]]
   local HTML=table.concat(HUD_HTML)
   return HTML
  end

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

   HUD_HTML[#HUD_HTML+1]=[[
    <div style="position:absolute;top:]].. yStart+(MenuY * MenuTick) ..[[px;left:]].. (xStart+MenuW+10) ..[[px;">
    <table class="bkgnd" width="]]..500*ScRt..[[px">
    <tr height="]].. MenuY ..[["><td colspan="4" class="Title ]].. ATLASSelect[0] ..[["><span class="Fleft">&#8592;</span> &#8592; Page ]]..atlas_page_index..[[ / ]]..atlas_pages..[[ &#8594;</td></tr>]]

   local index=(atlas_page_index*10)-9
   local x=0
   for i=index, (index+4) do
    if i<=atlas_counter then atlas_id_l=atlas_list[i]
    else atlas_id_l="" end
    if (i+5)<=atlas_counter then atlas_id_r=atlas_list[i+5]
    else atlas_id_r="" end
    x=x+1
    local tick_l=ATLASSelect[x]
    local tick_r=ATLASSelect[x+5]

    HUD_HTML[#HUD_HTML+1]=[[
     <tr height="]].. MenuY ..[["><td class="Title" width="]]..40*ScRt..[[px">]]..i..[[</td><td class="]].. tick_l ..[[" width="]]..210*ScRt..[[px">]].. atlas_id_l ..[[<span class="Fright">></span></td><td class="Title" width="]]..40*ScRt..[[px">]]..(i+5)..[[</td><td class="]].. tick_r ..[[" width="]]..210*ScRt..[[px">]].. atlas_id_r ..[[<span class="Fright">></span></td></tr>]]
   end
   HUD_HTML[#HUD_HTML+1]=[[</table></div>]]
   local HTML=table.concat(HUD_HTML)
   return HTML
  end

 --SELECTED ITEM           (SelectionIsTrue)
  function SelectedItem()
   if SelectionList==nil then SelectionList={} end
   if WPclr==nil then WPclr={"","","","","","",""} end
   local List={}
   if screenState==6 then atlas_list_page()
    List={"Destination","From"}
   elseif screenState==0 then stored_waypoints_1()
    List={"Settings","Destination","From","Clear","+ Route","+ Route and HOLD","- Route"}
   elseif screenState==9 then settings_menu()
    List={"Execute","Clear"}
   end

   if #SelectionList~=#List then
    SelectionList[0]="0"
    for i=1, #List do if i==1 then SelectionList[i]="select" else SelectionList[i]="" end end
   end
   local DiffW=250*ScRt
   local DiffH=(MenuY * CellSelected)
   if CellSelected>5 then DiffW=500*ScRt DiffH=(MenuY * (CellSelected-5)) end
   HUD_HTML[#HUD_HTML+1]=[[
    <div style="position:absolute;top:]].. yStart+(MenuY * MenuTick)+DiffH ..[[px;left:]].. (xStart+MenuW+10+DiffW) ..[[px;">
    <table class="bkgndSolid" width="]].. MenuW ..[[">]]
   for i=1, #List do
    HUD_HTML[#HUD_HTML+1]=[[<tr height="]].. MenuY ..[["><td class="]].. SelectionList[i] ..[[">]].. List[i] ..[[<span class="]].. WPclr[i] ..[[ Fright">ent &#8594;</span></td></tr>]]
   end
   HUD_HTML[#HUD_HTML+1]=[[</table></div>]]
   local HTML=table.concat(HUD_HTML)
   return HTML
  end

 --SU DISTANCE TIME PAGE   (screenState=1)
  function su_distance_time()
   if TimeCalcSelect==nil then TimeCalcSelect={"select",""} end
   if time_to_go==nil then time_to_go="" end
   if su_distance_inserted==nil then su_distance_inserted=false end
   if speed_inserted==nil then speed_inserted=false end
   if distance_to_go~=nil then
    if distance_to_go~="" then
    keypad_input_su=distance_to_go
    databank.setFloatValue("navigator_distance", keypad_input_su)
    su_distance_inserted=true
    su_tick=""
    TimeCalcSelect[1]=""
    speed_tick=">"
    TimeCalcSelect[2]="select"
    end
   end

   if (tonumber(keypad_input_su)==nil or keypad_input_su==".") then
    keypad_input_su=""
    su_tick=">"
    TimeCalcSelect[1]="select"
    speed_tick=""
    TimeCalcSelect[2]=""
   end
   if (tonumber(keypad_input_speed)==nil or keypad_input_speed==".") then keypad_input_speed="" end
   if time_to_go==nil then time_to_go="" end

   if (keypad_input_su==nil or keypad_input_su=="") then warp_distance=0
   else warp_distance=keypad_input_su end

   if (keypad_input_su~="" or keypad_input_su~="") then
    TimeCalcSelect[1]=""
    TimeCalcSelect[2]="select"
   end

   if tonumber(warp_distance)==nil then warp_distance=0 end
   MinWpCells=ConstructMass() * warp_distance * 0.00025
   MaxWpCells=math.floor((new_MTOW) * warp_distance * 0.00025)

   HUD_HTML[#HUD_HTML+1]=[[
    <div style="position:absolute;top:]].. (yStart+MenuY) ..[[px;left:]].. (xStart+MenuW+10) ..[[px;">
    <table class="bkgnd" width="]]..300*ScRt..[[px">
    <tr height="]].. MenuY ..[["><td class="Title" colspan="2">Insert The Distance</td></tr>
    <tr height="]].. MenuY ..[["><td class="]].. TimeCalcSelect[1] ..[[" colspan="2"><span class="Fleft">&#8592;</span>]].. keypad_input_su ..[[&nbsp<span class="Units">Su</span></td></tr>
    <tr height="]].. MenuY ..[["><td class="Title" colspan="2">Insert Cruising Speed</td></tr>
    <tr height="]].. MenuY ..[["><td class="]].. TimeCalcSelect[2] ..[[" colspan="2"><span class="Fleft">&#8592; &#8593; clr</span>]].. keypad_input_speed ..[[&nbsp<span class="Units">Km/h</span><span class="Fright">ent &#8595;</span></td></tr>
    <tr height="]].. MenuY ..[["><td width="]]..150*ScRt..[[px" class="Title">ETA After</td><td class="Title">Warp Cells</td></tr>
    <tr height="]].. MenuY ..[["><td>]].. time_to_go ..[[</td><td>]].. math.floor(ConstructMass() * warp_distance * 0.00025) ..[[<span class="Title">&nbsp Max:&nbsp</span>]].. math.floor((new_MTOW) * warp_distance * 0.00025) ..[[</td></tr>
    </table></div>]]
   local HTML=table.concat(HUD_HTML)
   return HTML
  end

 --FROM PAGE               (screenState=2)
  function from()
   if FROMclr==nil then FROMclr="" end
   if (databank.getStringValue("navigator_from")~="no From" and databank.getStringValue("navigator_from")~="PPOS") then keypad_input_from=databank.getStringValue("from") end

   if from_inserted==nil then
    from_inserted=false
    FROMSelect[1]="select"
    keypad_input_wpname=""
    wpname_inserted=false
    FROMSelect[2]=""
    stored=""
   end

   if keypad_input_from==nil then
    keypad_input_from=""
    from_coordinates=""
    from_inserted=false
    FROMSelect[1]="select"
    keypad_input_wpname=""
    wpname_inserted=false
    FROMSelect[2]=""
    stored=""
   end

   if from_coordinates~="" then FROMSelect[1]="" FROMSelect[2]="select" end

   HUD_HTML[#HUD_HTML+1]=[[
    <div style="position:absolute;top:]].. yStart+(MenuY * MenuTick) ..[[px;left:]].. (xStart+MenuW+10) ..[[px;">
    <table class="bkgnd" width="]]..500*ScRt..[[px">
    <tr height="]].. MenuY ..[["><td class="Title" colspan="2">Insert Departure or Arrow Down for PPOS</td></tr>
    <tr height="]].. MenuY ..[["><td class="]].. FROMSelect[1] ..[[" colspan="2"><span class="Fleft"> &#8592; &#8595; ppos</span>]].. keypad_input_from ..[[</td></tr>
    <tr height="]].. MenuY ..[["><td class="Title" colspan="2">Coordinates</td></tr>
    <tr height="]].. MenuY ..[["><td colspan="2">]].. tostring(from_coordinates) ..[[</td></tr>
    <tr height="]].. MenuY ..[["><td class="Title" colspan="2">WP Add / Rename</td></tr>
    <tr height="]].. MenuY ..[["><td width="]]..250*ScRt..[[px" class="]].. FROMSelect[2] ..[["><span class="Fleft"> &#8592; <span class="]].. FROMclr ..[[">&#8593; clr</span></span>]].. keypad_input_wpname ..[[<span class="Fright">ad/rn wp &#8594;</span></td><td width="]]..250*ScRt..[[px">]].. stored ..[[</td></tr>
    </table></div>]]
   stored=""
   local HTML=table.concat(HUD_HTML)
   return HTML
  end

 --DESTINATION PAGE        (screenState=3)
  function distance_to_wp()
   if DESTclr==nil then DESTclr="" end
   if (databank.getStringValue("navigator_target_destination")~="no Dest.") then
    keypad_input_dest=databank.getStringValue("to")
    distance_to_go=databank.getFloatValue("navigator_distance")
    distance_to_go_warp=databank.getFloatValue("navigator_distance")
   end

   if destination_inserted==nil then destination_inserted=false end

   if keypad_input_dest==nil then
    keypad_input_dest=""
    destination_coord=""
    distance_to_go=""
    distance_to_go_warp=0
   else keypad_input_dest=keypad_input_dest end

   HUD_HTML[#HUD_HTML+1]=[[
    <div style="position:absolute;top:]].. yStart+(MenuY * MenuTick) ..[[px;left:]].. (xStart+MenuW+10) ..[[px;">
    <table class="bkgnd" width="]]..500*ScRt..[[px">
    <tr height="]].. MenuY ..[["><td class="Title" colspan="2">Insert Destination</td></tr>
    <tr height="]].. MenuY ..[["><td class="select" colspan="2"><span class="Fleft"> &#8592; <span class="]].. DESTclr ..[[">&#8593; clr</span></span>]].. keypad_input_dest ..[[</td></tr>
    <tr height="]].. MenuY ..[["><td width="]]..300*ScRt..[[px" class="Title">Distance</td><td width="]]..200*ScRt..[[px" class="Title">Warp Cells</td></tr>
    <tr height="]].. MenuY ..[["><td>]] .. distance_to_go .. [[&nbsp<span class="Units">Su</span></td><td>]].. math.floor(ConstructMass() * distance_to_go_warp * 0.00025) ..[[<span class="Title">&nbsp Max:&nbsp</span>]].. math.floor((new_MTOW) * distance_to_go_warp * 0.00025) ..[[</td></tr>
    <tr height="]].. MenuY ..[["><td class="Title" colspan="2">Coordinates</td></tr>
    <tr height="]].. MenuY ..[["><td colspan="2">]].. tostring(destination_coord) ..[[</td></tr>
    </table></div>]]
   local HTML=table.concat(HUD_HTML)
   return HTML
  end

 --TARGET PE ALTITUDE PAGE (screenState=4)
  function target_pe_altitude()
   if target_alt_warning==nil then target_alt_warning="" end
   if target_pe_altitude_inserted==nil then target_pe_altitude_inserted=false end

   if (databank.getFloatValue("PE_altitude")~=0) then stored_pe_target_alt=math.floor(databank.getFloatValue("PE_altitude"))
   else stored_pe_target_alt=factory_PE_target_altitude end

   if keypad_input_pe_target_alt==nil then
    keypad_input_pe_target_alt=""
    target_pe_altitude_inserted=false
   else keypad_input_pe_target_alt=keypad_input_pe_target_alt end

   HUD_HTML[#HUD_HTML+1]=[[
    <div style="position:absolute;top:]].. yStart+(MenuY * MenuTick) ..[[px;left:]].. (xStart+MenuW+10) ..[[px;">
    <table class="bkgnd" width="]]..500*ScRt..[[px">
    <tr height="]].. MenuY ..[["><td class="Title">Insert PE Target Altitude</td></tr>
    <tr height="]].. MenuY ..[["><td class="select"><span class="Fleft"> &#8592;</span>]].. keypad_input_pe_target_alt ..[[&nbsp<span class="Units">m</span></td></tr>
    <tr height="]].. MenuY ..[["><td>]].. target_alt_warning ..[[</td></tr>
    <tr height="]].. MenuY ..[["><td class="Title">Stored Altitude</td></tr>
    <tr height="]].. MenuY ..[["><td>]].. stored_pe_target_alt ..[[&nbsp<span class="Units">m</span></td></tr>
    </table></div>]]
   local HTML=table.concat(HUD_HTML)
   return HTML
  end

 --SHIELD                  (screenState=17)
  function shieldFunction()
   if SHIELDSelect==nil then SHIELDSelect={[0]="select","","","","","","","",""} end
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
    if x=="ShieldToggle" then shield.toggle()
    elseif x=="VENTING" then if shield.isVenting() then shield.stopVenting() else shield.startVenting() end
    elseif x=="RESET" then
     if EnergyDistribution then menu("Shield")
     elseif ShieldBaseEnergy==false then
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
    elseif (x=="SET" and EnergyDistribution) then
     shield.setResistances((Ran-10)/100,(Rel-10)/100,(Rki-10)/100,(Rth-10)/100)
     EnergyDistribution=false
    end
   end
   if (Ran~=an or Rel~=el or Rki~=ki or Rth~=th) then EnergyDistribution=true else EnergyDistribution=false end
   local EnergyColor="Title"
   if EnergyDistribution then EnergyColor="Units" end
  
   local ShieldOnOff="RAISE"
   local ShieldOpacity=0.2
   local isActive=shield.isActive()
   if isActive then ShieldOnOff="DROP" ShieldOpacity=1 end

   local ShieldVENT="VENTING"
   local ventCool=shield.getVentingCooldown()
   if ventCool>0 then ShieldVENT=string.format("%.0f", ventCool) .." STOP" end

   local ShieldSET="SET"
   local ShieldRESET="RESET"
   local resCool=shield.getResistancesCooldown()
   if resCool>0 then ShieldSET=string.format("%.0f", resCool) end

   local ShieldStressTable={San,Sel,Ski,Sth}
   local Buttons={ShieldOnOff,ShieldVENT,ShieldSET,ShieldRESET}
   local ShieldData={ShieldPercent,ShieldEnergyPool,an,el,ki,th}
   if EnergyDistribution then ShieldData={ShieldPercent,ShieldEnergyPool,Ran,Rel,Rki,Rth} end

   HUD_HTML[#HUD_HTML+1]=[[
    <div style="position:absolute;top:]].. yStart+(MenuY * MenuTick) ..[[px;left:]].. (xStart+MenuW+10) ..[[px;">
    <table class="bkgnd" width="]]..500*ScRt..[[px">
    <tr height="]].. MenuY ..[["><td colspan="4" class="]].. SHIELDSelect[0] ..[[ Title"><span class="Fleft"> &#8592;</span>Shield</td></tr>
    <tr height="]].. MenuY ..[["><td width="]]..200*ScRt..[[px" class="]].. SHIELDSelect[1] ..[[">]].. Buttons[1] ..[[<span class="Fright">ent &#8594;</span></td><td width="]]..300*ScRt..[[px" colspan="3">]].. ShieldData[1] ..[[ %</td></tr>
    <tr height="]].. MenuY ..[["><td class="]].. SHIELDSelect[2] ..[[">]].. Buttons[2] ..[[<span class="Fright">ent &#8594;</span></td>
     <td colspan="3"><span class="Fleft"><svg width="]].. ((ShieldData[1]*300*ScRt)/100) ..[[px" height="]].. MenuY ..[["><rect x="0" y="5" width="100%" height="100%" style="fill:yellow" opacity="]].. ShieldOpacity ..[["/></svg></span></td></tr>
    <tr height="]].. MenuY ..[["><td class="Title">Energy Pool</td><td width="]]..160*ScRt..[[px" class="]].. SHIELDSelect[5] ..[[ Title"><span class="Fleft"> &#8592; -5</span>A<span class="Fright">+5 &#8594;</span></td><td width="]]..40*ScRt..[[px" class="]].. EnergyColor ..[[">]].. ShieldData[3] ..[[</td>
     <td width="]]..100*ScRt..[[px"><span class="Fleft"><svg width="]].. ((ShieldStressTable[1]*100)/100)*ScRt ..[[px" height="]].. MenuY ..[["><rect x="2" y="5" width="100%" height="100%" style="fill:red"/></svg></span></td></tr>
    <tr height="]].. MenuY ..[["><td>]].. ShieldData[2] ..[[</td><td class="]].. SHIELDSelect[6] ..[[ Title"><span class="Fleft"> &#8592; -5</span>E<span class="Fright">+5 &#8594;</span></td><td class="]].. EnergyColor ..[[">]].. ShieldData[4] ..[[</td>
     <td><span class="Fleft"><svg width="]].. ((ShieldStressTable[2]*100)/100) ..[[px" height="]].. MenuY ..[["><rect x="2" y="5" width="100%" height="100%" style="fill:red"/></svg></span></td></tr>
    <tr height="]].. MenuY ..[["><td class="]].. SHIELDSelect[3] ..[[">]].. Buttons[3] ..[[<span class="Fright">ent &#8594;</span></td><td class="]].. SHIELDSelect[7] ..[[ Title"><span class="Fleft"> &#8592; -5</span>K<span class="Fright">+5 &#8594;</span></td><td class="]].. EnergyColor ..[[">]].. ShieldData[5] ..[[</td>
     <td><span class="Fleft"><svg width="]].. ((ShieldStressTable[3]*100)/100) ..[[px" height="]].. MenuY ..[["><rect x="2" y="5" width="100%" height="100%" style="fill:red"/></svg></span></td></tr>
    <tr height="]].. MenuY ..[["><td class="]].. SHIELDSelect[4] ..[[">]].. Buttons[4] ..[[<span class="Fright">ent &#8594;</span></td><td class="]].. SHIELDSelect[8] ..[[ Title"><span class="Fleft"> &#8592; -5</span>T<span class="Fright">+5 &#8594;</span></td><td class="]].. EnergyColor ..[[">]].. ShieldData[6] ..[[</td>
     <td><span class="Fleft"><svg width="]].. ((ShieldStressTable[4]*100)/100) ..[[px" height="]].. MenuY ..[["><rect x="2" y="5" width="100%" height="100%" style="fill:red"/></svg></span></td></tr>
    </table></div>]]
   local HTML=table.concat(HUD_HTML)
   return HTML
  end

 --PVP INFO
  function PVPInfoFunction()
   local cooldown=math.floor(shield.getVentingCooldown())
   if cooldown==0 then cooldown="" end
   HUD_HTML[#HUD_HTML+1]=[[
    <div style="position:absolute;top:10px;left:]].. (ScrW/2)-(MenuW/2) ..[[px;">
    <table class="bkgnd" width="]].. MenuW*ScRt ..[[px">
    <tr height="]].. MenuY*ScRt ..[[px"><td class="Title pvp" width="]].. MenuW*ScRt ..[[px">
    <span class="Fleft">SHIFT+G Start/Stop VENTING</span>
    <span class="Fright">]].. cooldown ..[[</span>
    </td></tr></table></div>]]
   local HTML=table.concat(HUD_HTML)
   return HTML
  end

 --WP SETTINGS             (screenState=16)
  function wp_settings()
   if WPSETTINGSelect==nil then WPSETTINGSelect={[0]="select","",""} end
   if WPSETclr==nil then WPSETclr={"",""} end
   if tonumber(keypad_input_wp_altitude)==nil then keypad_input_wp_altitude="" end
   if tonumber(keypad_input_wp_speed)==nil then keypad_input_wp_speed="" end

   local DivPos=""
   if ScreenOrigin==-1 then DivPos=[[<div style="position:absolute;top:]].. yStart+(MenuY * (MenuTick-8)) ..[[px;left:]].. (xStart+MenuW+10) ..[[px;">]]
   else DivPos=[[<div style="position:absolute;top:]].. yStart+(MenuY * MenuTick) ..[[px;left:]].. (xStart+MenuW+10) ..[[px;">]] end
   HUD_HTML[#HUD_HTML+1]=DivPos..[[
    <table class="bkgnd" width="]]..500*ScRt..[[px">
    <tr height="]].. MenuY ..[["><td colspan="2" class="]].. WPSETTINGSelect[0] ..[[ Title"><span class="Fleft">&#8592;</span> WP: ]].. edit_wp ..[[</td></tr>
    <tr height="]].. MenuY ..[["><td width="]]..250*ScRt..[[px" class="Title">Altitude</td><td width="]]..250*ScRt..[[px" class="]].. WPSETTINGSelect[1] ..[["><span class="]].. WPSETclr[1] ..[[ Fleft"> &#8592; clr</span>]].. keypad_input_wp_altitude ..[[&nbsp<span class="Units">m</span></td></tr>
    <tr height="]].. MenuY ..[["><td class="Title">Speed</td><td class="]].. WPSETTINGSelect[2] ..[["><span class="]].. WPSETclr[2] ..[[ Fleft"> &#8592; clr</span>]].. keypad_input_wp_speed ..[[&nbsp<span class="Units">Km/h</span></td></tr>
    </table></div>]]
   local HTML=table.concat(HUD_HTML)
   return HTML
  end

 --ROUTING                 (screenState=15)
  function FindWP()
   if WpRouteList[IDToNextWp]~="HOLD" then
    for i=1, #wp_list do
     if wp_list[i].name==WpRouteList[IDToNextWp] then
      local WpID=wp_list[i].id
      WpID=WpID:gsub("wp", "")
      for i=1, #WpRouteList do
       FlyStat[i]=""
       if WpRouteList[i]~="HOLD" then GoTo[i]="Go To &#8594;" end
      end
      FlyStat[IDToNextWp]="To &#8594; "
      GoTo[IDToNextWp]=""
      DistToNextWp=DistToNextWp+1
      ent_to_wp(tonumber(WpID))
      break
     end
    end
   end
  end

  function route_page()
   if ROUTESelect==nil then ROUTESelect={} end
   if InitRoute==nil then InitRoute=false end 
   RouteStatus="Inactive"
   if (RouteActivated and RouteStatus~="Holding") then RouteStatus="Activated" end
   local ext=databank.getStringValue("wp_settings"):gsub("@@@","\"")
   ext=json.decode(ext)
   WpSettingsList=ext
   databank.setIntValue("Holding", 0)

   WPCoordinates={}
   local myPos=ConstructPos()
   local distance=""   
   local vec3_coord=""
   for i=1, #WpRouteList do
    local WpName=WpRouteList[i]
    for x=1, #wp_list do
     local wp_id="wp"..x
     local wpMatch=databank.getStringValue(wp_id)
     if wpMatch==WpName then
      local wp_coord=databank.getStringValue(wp_id.."_coord")
      vec3_coord=vec3FromStr(wp_coord)
      WPCoordinates[i]=vec3_coord
      distance=math.floor(((vec3(vec3_coord) - myPos):len())/1000*100)/100
      if distance>200 then DistanceList[i]=math.floor((distance/200)*100)/100 .." Su"
      else DistanceList[i]=distance .." Km" end
      break
     elseif WpName=="HOLD" then DistanceList[i]="Holding" end
    end
   end

   if (InitRoute==false and RouteActivated) then
    InitRoute=true
    IDToNextWp=1
    DistToNextWp=0
    FindWP()
    unit.setTimer("routing", 1)
   elseif (InitRoute==true and RouteActivated and RouteStatus~="Holding") then
    local distanceSTR=DistanceList[DistToNextWp]
    if WpRouteList[IDToNextWp]~="HOLD" then distance=distanceSTR:gsub("%a", "")
    else distance=nil end
    if tonumber(distance)~=nil then
     databank.setIntValue("Holding", 0)
     distance=tonumber(distance)
     local d=math.sqrt((wp_sequencing_distance)^2 + ((math.floor(core.getAltitude())/1000)^2))
     if (distance<d) then IDToNextWp=IDToNextWp+1
      if (WpRouteList[IDToNextWp]~=nil and WpRouteList[IDToNextWp]~="HOLD") then FindWP()
      elseif WpRouteList[IDToNextWp]~="HOLD" then IDToNextWp=1 DistToNextWp=0 FindWP()
      end
     end
    elseif WpRouteList[IDToNextWp]=="HOLD" then
     databank.setIntValue("Holding", 1)
     RouteStatus="Holding"
    end
   end

   local LeftForSett=""
   if RouteActivated then LeftForSett=[[<span class="Fleft">&#8592; wp sett.</span>]] else LeftForSett="" end
   HUD_HTML[#HUD_HTML+1]=[[
    <div style="position:absolute;top:]].. yStart ..[[px;right:]].. xStart-80 ..[[px;">
    <table class="bkgnd" width="]].. (MenuW + MenuW/2) ..[[">
    <tr height="]].. MenuY ..[["><td colspan="2" class="Title" width="]].. MenuW ..[[">]].. LeftForSett ..[[ROUTE: ]].. RouteStatus ..[[</td></tr>]]
    for i=1, #WpRouteList do
     if MenuSelect[i+8] then ROUTESelect[i]=MenuSelect[i+8] else ROUTESelect[i]="" end
     if MenuSelect[i+8]==nil then ROUTESelect[i]="" end
     if WpRouteList[i]==nil then WpRouteList[i]="" end
     if DistanceList[i]==nil then DistanceList[i]="" end
     if FlyStat[i]==nil then FlyStat[i]="" end
     if GoTo[i]==nil then GoTo[i]="" end
     if WpSettingsList[WpRouteList[i]] then ItHasSettings[i]="green" else ItHasSettings[i]="" end
     HUD_HTML[#HUD_HTML+1]=[[<tr height="]].. MenuY ..[[">
      <td class="]].. ROUTESelect[i] ..[[" width="]].. MenuW ..[["><span class="]].. ItHasSettings[i] ..[[ Fleft"><span class="Title">]].. FlyStat[i] ..[[</span>]].. WpRouteList[i] ..[[</span><span class="Fright">]].. GoTo[i] ..[[</span></td>
      <td width="]]..  MenuW/2 ..[[">]].. DistanceList[i] ..[[</td></tr>]]
    end
    HUD_HTML[#HUD_HTML+1]=[[</table></div>]]
   local HTML=table.concat(HUD_HTML)
   return HTML
  end

 --SETTINGS MENU           (screenState=9)
  function settings_menu()
   if SETTINGSSelect==nil then SETTINGSSelect={[0]="select","","","","","","","","","",""} end
   HUD_HTML[#HUD_HTML+1]=[[
    <div style="position:absolute;top:]].. yStart+(MenuY * MenuTick) ..[[px;left:]].. (xStart+MenuW+10) ..[[px;">
    <table class="bkgnd" width="]]..500*ScRt..[[px">
    <tr height="]].. MenuY ..[["><td colspan="4" class="]].. SETTINGSSelect[0] ..[[ Title"><span class="Fleft"> &#8592;</span>Settings</td></tr>
    <tr height="]].. MenuY ..[["><td class="Title" width="]]..40*ScRt..[[px">1</td><td class="]].. SETTINGSSelect[1] ..[[" width="]]..210*ScRt..[[px">Ship Settings<span class="Fright">></span></td><td class="Title" width="]]..40*ScRt..[[px">6</td><td class="]].. SETTINGSSelect[6] ..[[" width="]]..210*ScRt..[[px">DB Reset<span class="Fright">></span></td></tr>
    <tr height="]].. MenuY ..[["><td class="Title">2</td><td class="]].. SETTINGSSelect[2] ..[[">WP Store<span class="Fright">></span></td><td class="Title">7</td><td class="]].. SETTINGSSelect[7] ..[[">Route<span class="Fright">></span></td></tr>
    <tr height="]].. MenuY ..[["><td class="Title">3</td><td class="]].. SETTINGSSelect[3] ..[[">WP Sync<span class="Fright">></span></td><td class="Title">8</td><td class="]].. SETTINGSSelect[8] ..[[">---</td></tr>
    <tr height="]].. MenuY ..[["><td class="Title">4</td><td class="]].. SETTINGSSelect[4] ..[[">Interface Colors<span class="Fright">></span></td><td class="Title">9</td><td class="]].. SETTINGSSelect[9] ..[[">---</td></tr>
    <tr height="]].. MenuY ..[["><td class="Title">5</td><td class="]].. SETTINGSSelect[5] ..[[">DMG Report<span class="Fright">></span></td><td class="Title">10</td><td class="]].. SETTINGSSelect[10] ..[[">---</td></tr>
    </table></div>]]
   local HTML=table.concat(HUD_HTML)
   return HTML
  end
  --SETTINGS PAGE 1        (Ship Settings)(screenState=5)
   function settings1()
    if SHIPSETINGSSelect==nil then SHIPSETINGSSelect={[0]="select","","","",""} end
    if keypad_input_MTOW==nil then
     keypad_input_MTOW=factory_MTOW/1000
     new_MTOW=factory_MTOW/1000
    end
    if keypad_input_autobrake==nil then keypad_input_autobrake=factory_autobrake end
    if keypad_input_wpdist==nil then keypad_input_wpdist=wp_sequencing_distance end
    if keypad_input_holding==nil then keypad_input_holding=holding_speed end

    HUD_HTML[#HUD_HTML+1]=[[
     <div style="position:absolute;top:]].. yStart+(MenuY * MenuTick) ..[[px;left:]].. (xStart+MenuW+10) ..[[px;">
     <table class="bkgnd" width="]]..500*ScRt..[[px">
     <tr height="]].. MenuY ..[["><td colspan="2" class="]].. SHIPSETINGSSelect[0] ..[[ Title"><span class="Fleft"> &#8592;</span>Ship Settings</td></tr>
     <tr height="]].. MenuY ..[["><td width="]]..250*ScRt..[[px" class="Title">MTOW</td><td width="]]..250*ScRt..[[px" class="]].. SHIPSETINGSSelect[1] ..[[">]].. keypad_input_MTOW ..[[&nbsp<span class="Units">t</span></td></tr>
     <tr height="]].. MenuY ..[["><td class="Title">Autobrake</td><td class="]].. SHIPSETINGSSelect[2] ..[[">]].. keypad_input_autobrake ..[[&nbsp<span class="Units">Su</span></td></tr>
     <tr height="]].. MenuY ..[["><td class="Title">Dist. To WP</td><td class="]].. SHIPSETINGSSelect[3] ..[[">]].. keypad_input_wpdist ..[[&nbsp<span class="Units">Km</span></td></tr>
     <tr height="]].. MenuY ..[["><td class="Title">Holding Speed</td><td class="]].. SHIPSETINGSSelect[4] ..[[">]].. keypad_input_holding ..[[&nbsp<span class="Units">Km/h</span></td></tr>
     </table></div>]]
    local HTML=table.concat(HUD_HTML)
    return HTML
   end

  --SETTINGS PAGE 2        (WP Store)(screenState=7)
   function settings2()
    if WPSTORESelect==nil then WPSTORESelect={[0]="select","","","",""} end
    if databank.getStringValue("to")~=nil then
     for i, v in pairs(atlas[0]) do
      if atlas[0][i].name[1]==keypad_input_dest then wp_selected_planet=databank.getStringValue("to") end
     end
    else wp_selected_planet="" end

    if (wp_selected_planet==nil or wp_selected_planet=="" or wp_selected_planet=="Set Destination or Paste Coord.") then
     wp_selected_planet="Set Destination or Paste Coord."
     WPSTORESelect={[0]="select","","","",""}
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

    HUD_HTML[#HUD_HTML+1]=[[
     <div style="position:absolute;top:]].. yStart+(MenuY * MenuTick) ..[[px;left:]].. (xStart+MenuW+10) ..[[px;">
     <table class="bkgnd" width="]]..500*ScRt..[[px">
     <tr height="]].. MenuY ..[["><td class="]].. WPSTORESelect[0] ..[[ Title" colspan="2"><span class="Fleft"> &#8592;</span>WP Store</td></tr>
     <tr height="]].. MenuY ..[["><td class="Units" width="]]..250*ScRt..[[px">]].. wp_selected_planet ..[[</td><td width="]]..250*ScRt..[[px" class="Title">WP Coord</td></tr>
     <tr height="]].. MenuY ..[["><td class="Title">WP Name</td><td class="]].. WPSTORESelect[2] ..[[">]].. keypad_input_wp_lat ..[[&nbsp<span class="Units">Lat</span></td></tr>
     <tr height="]].. MenuY ..[["><td class="]].. WPSTORESelect[1] ..[[">]].. keypad_input_wp_name ..[[<span class="Fright">store &#8594;</span></td><td class="]].. WPSTORESelect[3] ..[[">]].. keypad_input_wp_lon ..[[&nbsp<span class="Units">Lon</span></td></tr>
     <tr height="]].. MenuY ..[["><td >]].. stored ..[[</td><td class="]].. WPSTORESelect[4] ..[[">]].. keypad_input_wp_alt ..[[&nbsp<span class="Units">Alt</span></td></tr>
     <tr height="]].. MenuY ..[["><td colspan="2">]].. wp_coordinated_stored ..[[</td></tr>
     </table></div>]]
    stored=""
    local HTML=table.concat(HUD_HTML)
    return HTML
   end

  --SETTINGS PAGE 3        (WP Sync)(screenState=8)
   function settings3()
    if WPSYNCSelect==nil then WPSYNCSelect={[0]="select","","",""} end
    if ShipIDclr==nil then ShipIDclr="" end
    if FleetNumber==nil then FleetNumber=0 end
    local FleetList=databank.getStringValue("Fleet")
    FleetList=json.decode(FleetList)
    if FleetList==nil then FleetNumber=0
    else FleetNumber=#FleetList end

    local dbKeys=databank.getNbKeys()

    if dbKeys>0 then
     local counter=0
     for i=1, dbKeys do
      local wp_name="wp"..i
      local wp_name=databank.getStringValue(wp_name)

      if (tostring(wp_name)~=nil and tostring(wp_name)~="") then counter=counter + 1 end
      keys_number=counter
     end
    else keys_number=0 end
    if (sync_result==nil or sync_result=="") then sync_result="" end

    HUD_HTML[#HUD_HTML+1]=[[
     <div style="position:absolute;top:]].. yStart+(MenuY * MenuTick) ..[[px;left:]].. (xStart+MenuW+10) ..[[px;">
     <table class="bkgnd" width="]]..500*ScRt..[[px">
     <tr height="]].. MenuY ..[["><td class="]].. WPSYNCSelect[0] ..[[ Title" colspan="2"><span class="Fleft"> &#8592;</span>WP Sync</td></tr>
     <tr height="]].. MenuY ..[["><td width="]]..250*ScRt..[[px" class="Title" >Ship ID</td><td width="]]..250*ScRt..[[px" class="]].. WPSYNCSelect[1] ..[["><span class="]].. ShipIDclr ..[[ Fleft"> &#8592; clr</span>]].. keypad_input_shipid ..[[</td></tr>
     <tr height="]].. MenuY ..[["><td class="Title">Data Stored</td><td>WP:]].. keys_number ..[[ - Fleet:]].. FleetNumber ..[[</td></tr>
     <tr height="]].. MenuY ..[["><td class="]].. WPSYNCSelect[2] ..[[ Units"> << Downlink >> <span class="Fright">ent &#8594;</span></td><td class="]].. WPSYNCSelect[3] ..[[ Units"> >> Uplink << <span class="Fright">ent &#8594;</span></td></tr>
     <tr height="]].. MenuY ..[["><td colspan="2"><span class="Fleft">
      <svg width="]].. prog_bar ..[[px" height="]].. MenuY ..[[">
      <rect x="2" y="5" width="100%" height="100%" style="fill:yellow"/>
      </svg>
     </span></td></tr>
     <tr height="]].. MenuY ..[["><td colspan="2" >]].. sync_result ..[[</td></tr>
     </table></div>]]
    local HTML=table.concat(HUD_HTML)
    return HTML
   end

  --SETTINGS PAGE 4        (Screen Colours)(screenState=10)
   function settings4()
    if COLORSSelect==nil then COLORSSelect={[0]="select","","","","","","",""} end

    HUD_HTML[#HUD_HTML+1]=[[
     <div style="position:absolute;top:]].. yStart+(MenuY * MenuTick) ..[[px;left:]].. (xStart+MenuW+10) ..[[px;">
     <table class="bkgnd" width="]]..500*ScRt..[[px">
     <tr height="]].. MenuY ..[["><td colspan="2" class="]].. COLORSSelect[0] ..[[ Title"><span class="Fleft"> &#8592;</span>HUD Menu Colors</td></tr>
     <tr height="]].. MenuY ..[["><td width="]]..250*ScRt..[[px" class="Title">Table Borders</td><td width="]]..250*ScRt..[[px" class="]].. COLORSSelect[1] ..[[">]]..keypad_input_color1..[[</td></tr>
     <tr height="]].. MenuY ..[["><td class="Title">Titles</td><td class="]].. COLORSSelect[2] ..[[">]]..keypad_input_color2..[[</td></tr>
     <tr height="]].. MenuY ..[["><td class="Title">Text</td><td class="]].. COLORSSelect[3] ..[[">]]..keypad_input_color3..[[</td></tr>
     <tr height="]].. MenuY ..[["><td class="Title">Selection</td><td class="]].. COLORSSelect[4] ..[[">]]..keypad_input_color4..[[</td></tr>
     <tr height="]].. MenuY ..[["><td class="Title">Background</td><td class="]].. COLORSSelect[5] ..[[">]]..keypad_input_color5..[[</td></tr>
     <tr height="]].. MenuY ..[["><td class="Title">Background Alpha</td><td class="]].. COLORSSelect[6] ..[[">]]..keypad_input_color6..[[</td></tr>
     <tr height="]].. MenuY ..[["><td class="Title">Overlapped Table Alpha</td><td class="]].. COLORSSelect[7] ..[[">]]..keypad_input_color7..[[</td></tr>
     </table></div>]]
    local HTML=table.concat(HUD_HTML)
    return HTML
   end

  --SETTINGS PAGE 5        (DMG Rep.)(screenState=11)
   function settings5()
    if DMGREPSelect==nil then DMGREPSelect={[0]="select","","","","",""} end

    HUD_HTML[#HUD_HTML+1]=[[
     <div style="position:absolute;top:]].. yStart+(MenuY * MenuTick) ..[[px;left:]].. (xStart+MenuW+10) ..[[px;">
     <table class="bkgnd" width="]]..500*ScRt..[[px">
     <tr height="]].. MenuY ..[["><td colspan="5" class="]].. DMGREPSelect[0] ..[[ Title"><span class="Fleft"> &#8592;</span>DMG Report Position</td></tr>
     <tr height="]].. MenuY ..[["><td width="240px" class="Title">Top View</td><td width="30px" class="Title">X</td><td width="]]..100*ScRt..[[px" class="]].. DMGREPSelect[1] ..[[">]].. DMG_REP_TOP_VIEW_LH_RH ..[[</td><td width="30px" class="Title">Y</td><td width="]]..100*ScRt..[[px" class="]].. DMGREPSelect[2] ..[[">]].. DMG_REP_TOP_VIEW_Up_Down ..[[</td></tr>
     <tr height="]].. MenuY ..[["><td class="Title">Side View</td><td class="Title">X</td><td class="]].. DMGREPSelect[3] ..[[">]].. DMG_REP_SIDE_VIEW_LH_RH ..[[</td><td class="Title">Y</td><td class="]].. DMGREPSelect[4] ..[[">]].. DMG_REP_SIDE_VIEW_Up_Down ..[[</td></tr>
     <tr height="]].. MenuY ..[["><td colspan="3" class="Title">Scale</td><td colspan="2" class="]].. DMGREPSelect[5] ..[[">]].. keypad_input_dmg1 ..[[</td></tr>
     </table></div>]]
    local HTML=table.concat(HUD_HTML)
    return HTML
   end
  
  --SETTINGS PAGE 6        (DB Reset)(screenState=12)
   function settings6()
    if DBRESSelect==nil then DBRESSelect={[0]="select","","","","","",""} end

    HUD_HTML[#HUD_HTML+1]=[[
     <div style="position:absolute;top:]].. yStart+(MenuY * MenuTick) ..[[px;left:]].. (xStart+MenuW+10) ..[[px;">
     <table class="bkgnd" width="]]..500*ScRt..[[px">
     <tr height="]].. MenuY ..[["><td colspan="2" class="]].. DBRESSelect[0] ..[[ Title"><span class="Fleft"> &#8592;</span>Databank Reset</td></tr>
     <tr height="]].. MenuY ..[["><td width="]]..200*ScRt..[[px">]].. db_mark_1 ..[[</td><td class="]].. DBRESSelect[1] ..[[ Title" width="]]..300*ScRt..[[px"><span class="Fleft"> &#8592; clr</span>Stored WP<span class="Fright">keep &#8594;</span></td></tr>
     <tr height="]].. MenuY ..[["><td>]].. db_mark_2 ..[[</td><td class="]].. DBRESSelect[2] ..[[ Title"><span class="Fleft"> &#8592; clr</span>Ship Settings<span class="Fright">keep &#8594;</span></td></tr>
     <tr height="]].. MenuY ..[["><td>]].. db_mark_3 ..[[</td><td class="]].. DBRESSelect[3] ..[[ Title"><span class="Fleft"> &#8592; clr</span>Ship ID<span class="Fright">keep &#8594;</span></td></tr>
     <tr height="]].. MenuY ..[["><td>]].. db_mark_4 ..[[</td><td class="]].. DBRESSelect[4] ..[[ Title"><span class="Fleft"> &#8592; clr</span>HUD Menu Colors<span class="Fright">keep &#8594;</span></td></tr>
     <tr height="]].. MenuY ..[["><td>]].. db_mark_5 ..[[</td><td class="]].. DBRESSelect[5] ..[[ Title"><span class="Fleft"> &#8592; clr</span>DMG Report<span class="Fright">keep &#8594;</span></td></tr>
     <tr height="]].. MenuY ..[["><td class="]].. DBRESSelect[6] ..[[ Title">EXECUTE<span class="Fright">ent &#8594;</span></td><td>]].. reset_db_status ..[[</td></tr>
     </table></div>]]
    local HTML=table.concat(HUD_HTML)
    return HTML
   end

--SENDING DATA
 function sync_data()
  if emitter then
   local dbKeys=databank.getNbKeys()
   if dbKeys>0 then
    local counter=0
    for i=index_sync, dbKeys do
     local wp_name='wp'..i
     local wp_name=databank.getStringValue(wp_name)
     if (tostring(wp_name)~=nil and tostring(wp_name)~="") then
      counter=counter + 1
      local wp_coord='wp'..i..'_coord'
      local wp_coord=databank.getStringValue(wp_coord)
      system.print(ship_id.." is TRANSMITTING WP: "..wp_name)

      waypoint={wp_n=wp_name, wp_c=wp_coord}
      json_string=json.encode(waypoint,{indent=false})
      if counter<=1 then
       wp_synced=wp_synced + 1
       emitter.send("AviatorHUD", "<ShipData>"..json_string:gsub("\"","@@@"))
      else break end
     end
     sync_result="Synced ".. wp_synced .."/".. keys_number .." WP"
     prog_bar=(wp_synced * 500)/keys_number
     if index_sync<=dbKeys then
      index_sync=index_sync+1
      delay_timer=1
      delay_id="SyncData"
      unit.setTimer("delay", 0.5)
     end
    end
    HUDScreen()
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
  HUDScreen()
 end

 fleet_msg_counter=0
 function receiving_FleetData()
  local StoredFleetData=databank.getStringValue("Fleet")
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
  databank.setStringValue("Fleet", StoredFleetData)
  HUDScreen()
 end

--MAIN MENU INIT
 if screenState==nil then
  MenuSelect={[0]="0","","","","","","","",""}
  MenuTick=1 MenuSelect[1]="select"
  screenState=-1
 end

 function menu_from()
  if screenState==0 then ent_from_wp(WPSelected)
  elseif screenState==6 then ent_from_wp(ATLASSelected) end
  FROMSelect={"select",""}
  screenState=2
  HUDScreen()
 end

 function menu_destination()
  if screenState==0 then ent_to_wp(WPSelected)
  elseif screenState==6 then ent_to_wp(ATLASSelected)   
  end
  screenState=3
  HUDScreen()
 end

 function menu_settings()
  if (ScreenOrigin==0 or ScreenOrigin==-1) then
   edit_wp=nil

   if ScreenOrigin==-1 then
    local WpSel=MenuTick-8
    for i=1, #wp_list do
     if wp_list[i].name==WpRouteList[WpSel] then edit_wp=wp_list[i].id break end
    end
   else
    if wp_list[WPSelected]~=nil then edit_wp=wp_list[WPSelected].id end
   end

   if edit_wp~=nil then
    screenState=16
    if WPSETTINGSelect==nil then WPSETTINGSelect={[0]="select","",""} end
    wp_altitude_inserted=true
    wp_speed_inserted=true
    for x=1, #wp_list do
     if wp_list[x].id==edit_wp then
      local wp_id=wp_list[x].wp
      edit_wp=databank.getStringValue(wp_id)
      break
     end
    end
    local ext=databank.getStringValue("wp_settings"):gsub("@@@","\"")
    ext=json.decode(ext)
    if ext[edit_wp] then
     keypad_input_wp_altitude=ext[edit_wp].alt
     keypad_input_wp_speed=ext[edit_wp].s
    else
     keypad_input_wp_altitude=""
     keypad_input_wp_speed=""
    end
    HUDScreen()
   end
  end
 end

 function menu_wp_atlas()
  if screenState==0 then
   wp_page_index=1
   WPSelect={[0]="select","","","","","","","","","",""}
  elseif screenState==6 then
   atlas_page_index=1
   ATLASSelect={[0]="select","","","","","","","","","",""}
  end
  HUDScreen()
 end

--MENU PRELOAD
 function menu()
  if screenState==2 then menu_from()
  elseif screenState==3 then menu_destination()
  elseif (screenState==0 or screenState==6) then menu_wp_atlas()
  elseif (screenState==9 or screenState==16) then menu_settings()
  elseif screenState==17 then
   if shield then
    SHIELDSelect={[0]="select","","","","","","","",""}
    local ResistanceTable=shield.getResistances()
    Ran=tonumber(string.format("%.0f", (ResistanceTable[1]*100)+10))
    Rel=tonumber(string.format("%.0f", (ResistanceTable[2]*100)+10))
    Rki=tonumber(string.format("%.0f", (ResistanceTable[3]*100)+10))
    Rth=tonumber(string.format("%.0f", (ResistanceTable[4]*100)+10))
    unit.setTimer("shield", 1/4)
    shieldFunction()
   end
  end
  HUDScreen()
 end

 if DataProcessed==nil then
  HUD_HTML={}
  wp_page_index=1
  WPSelect={[0]="select","","","","","","","","","",""}
  atlas_page_index=1
  ATLASSelect={[0]="select","","","","","","","","","",""}
  atlas_list_page()
  stored_waypoints_1()
  DataProcessed=true
 end

--SCREEN SCRIPT BUILDIER
 function HUDScreen()
  local ScreenHTML=css_html()
  if screenState~=-1 then ScreenHTML=MainMenu() end

  if screenState==-1 then ScreenHTML=MainMenu()
  elseif screenState==0 then 
   if SelectionIsTrue==false then ScreenHTML=stored_waypoints_1()
   else ScreenHTML=SelectedItem() end
  elseif screenState==1 then ScreenHTML=su_distance_time()
  elseif screenState==2 then ScreenHTML=from()
  elseif screenState==3 then ScreenHTML=distance_to_wp()
  elseif screenState==4 then ScreenHTML=target_pe_altitude()
  elseif screenState==5 then ScreenHTML=settings1()
  elseif screenState==6 then
   if SelectionIsTrue==false then ScreenHTML=atlas_list_page()
   else ScreenHTML=SelectedItem() end
  elseif screenState==7 then ScreenHTML=settings2()
  elseif screenState==8 then ScreenHTML=settings3()
  elseif screenState==9 then
   if SelectionIsTrue==false then ScreenHTML=settings_menu()
   else ScreenHTML=SelectedItem() end
  elseif screenState==10 then ScreenHTML=settings4()
  elseif screenState==11 then ScreenHTML=settings5()
  elseif screenState==12 then ScreenHTML=settings6()
  elseif screenState==16 then ScreenHTML=wp_settings()
  elseif screenState==17 then ScreenHTML=shieldFunction()
  end

  if RouteExist then ScreenHTML=route_page() end
  if PVPStationIsON then ScreenHTML=PVPInfoFunction() end

  if MENU_ON then system.setScreen(ScreenHTML) system.showScreen(1) else
   if PVPStationIsON then
    HUD_HTML={}
    ScreenHTML=css_html()
    ScreenHTML=PVPInfoFunction()
    system.setScreen(ScreenHTML)
    system.showScreen(1)
   else system.showScreen(0) end
  end
 end
 HUDScreen()
--

--FILTERS
--construct.onStart()
 function ConstructMass() local M=math.floor(construct.getMass()/1000) return M end
 function ConstructVel() local V=math.floor((vec3(construct.getVelocity()):len())*3.6) return V end
 function ConstructPos() local P=vec3(construct.getWorldPosition()) return P end
 function ConstrucId() local I=construct.getId() return I end
 function MaxSpeed() local S=construct.getMaxSpeed()*3.6 return S end
--

--unit.onTimer("delay")
 delay_timer=delay_timer-1
 if delay_timer==0 then
  unit.stopTimer("delay")
  if delay_id=="SyncData" then sync_data()
  elseif delay_id=="ShipIDResponse" then
   if (sync_result=="Ship ID Sent" or sync_result=="Downlink Requested") then sync_result="No Response" HUDScreen() end
  end
 end
--

--unit.onTimer("Ship_Id")
 ship_id_verified=false
 WP_request=false
 unit.stopTimer("Ship_Id")
--

--unit.onTimer("routing")
 if (RouteExist and InitRoute) then HUDScreen() else InitRoute=false RouteActivated=false unit.stopTimer("routing") end
--

--unit.onTimer("shield")
 if screenState==17 then shieldFunction() HUDScreen() else unit.stopTimer("shield") end
--

--unit.onTimer("PVPStation")
 if PVPStationIsON==nil then PVPStationIsON=false end
 if databank.getStringValue("PVPStation")=="ON" then PVPStationIsON=true else PVPStationIsON=false end
--

--system.onInputText(*)
 input_text=text
 if MENU_ON then
  if (screenState==1 and tonumber(input_text)~=nil) then
   if (su_tick==">" and TimeCalcSelect[1]=="select") then keypad_input_su=input_text
   elseif (speed_tick==">" and TimeCalcSelect[2]=="select") then keypad_input_speed=input_text
   end
   ent_button()
  elseif screenState==2 then
   if FROMSelect[1]=="select" then keypad_input_from=input_text ent_button()
   elseif FROMSelect[2]=="select" then keypad_input_wpname=input_text ent_button() end
  elseif screenState==3 then keypad_input_dest=input_text ent_button()
  elseif (screenState==4 and tonumber(input_text)~=nil) then
   keypad_input_pe_target_alt=input_text
   target_pe_altitude_inserted=false
   target_alt_warning=""
   ent_button()
  elseif (screenState==5 and tonumber(input_text)~=nil) then
   if SHIPSETINGSSelect[1]=="select" then keypad_input_MTOW=input_text
   elseif SHIPSETINGSSelect[2]=="select" then keypad_input_autobrake=input_text
   elseif SHIPSETINGSSelect[3]=="select" then keypad_input_wpdist=input_text
   elseif SHIPSETINGSSelect[4]=="select" then keypad_input_holding=input_text
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
    WPSTORESelect[1]="select"
    keypad_input_wp_lat=tonumber(latitude)
    keypad_input_wp_lon=tonumber(longitude)
    keypad_input_wp_alt=tonumber(altitude)
   end
   if (WPSTORESelect[1]=="select" and input_text~="") then keypad_input_wp_name=input_text WPSTORESelect[1]="" WPSTORESelect[2]="select"
   elseif (WPSTORESelect[2]=="select" and tonumber(input_text)~=nil) then keypad_input_wp_lat=input_text WPSTORESelect[2]="" WPSTORESelect[3]="select"
   elseif (WPSTORESelect[3]=="select" and tonumber(input_text)~=nil) then keypad_input_wp_lon=input_text WPSTORESelect[3]="" WPSTORESelect[4]="select"
   elseif (WPSTORESelect[4]=="select" and tonumber(input_text)~=nil) then keypad_input_wp_alt=input_text
   end
  elseif screenState==8 then
   if WPSYNCSelect[1]=="select" then keypad_input_shipid=input_text end ent_button()
  elseif screenState==10 then
   if COLORSSelect[1]=="select" then keypad_input_color1=input_text
   elseif COLORSSelect[2]=="select" then keypad_input_color2=input_text
   elseif COLORSSelect[3]=="select" then keypad_input_color3=input_text
   elseif COLORSSelect[4]=="select" then keypad_input_color4=input_text
   elseif COLORSSelect[5]=="select" then keypad_input_color5=input_text
   elseif (COLORSSelect[6]=="select" and tonumber(input_text)~=nil and tonumber(input_text)<=1) then keypad_input_color6=input_text
   elseif (COLORSSelect[7]=="select" and tonumber(input_text)~=nil and tonumber(input_text)<=1) then keypad_input_color7=input_text
   end
   ent_button()
  elseif (screenState==11 and tonumber(input_text)~=nil) then
   if DMGREPSelect[1]=="select" then DMG_REP_TOP_VIEW_LH_RH=input_text databank.setFloatValue("DMG TV L/R", DMG_REP_TOP_VIEW_LH_RH)
   elseif DMGREPSelect[2]=="select" then DMG_REP_TOP_VIEW_Up_Down=input_text databank.setFloatValue("DMG TV U/D", DMG_REP_TOP_VIEW_Up_Down)
   elseif DMGREPSelect[3]=="select" then DMG_REP_SIDE_VIEW_LH_RH=input_text databank.setFloatValue("DMG SV L/R", DMG_REP_SIDE_VIEW_LH_RH)
   elseif DMGREPSelect[4]=="select" then DMG_REP_SIDE_VIEW_Up_Down=input_text databank.setFloatValue("DMG SV U/D", DMG_REP_SIDE_VIEW_Up_Down)
   elseif DMGREPSelect[5]=="select" then keypad_input_dmg1=input_text databank.setFloatValue("DMG Scale", keypad_input_dmg1)
   end
  elseif (screenState==16 and tonumber(input_text)~=nil) then
   if WPSETTINGSelect[1]=="select" then keypad_input_wp_altitude=input_text
   elseif WPSETTINGSelect[2]=="select" then keypad_input_wp_speed=input_text
   end
   ent_button()
  end
  HUDScreen()
 end

 if screenState~=7 then
  local check0=string.find(input_text, "::pos{0")
  local check1=string.find(input_text, "/Y")

  if LuaWp==nil then LuaWp=false end
  if LuaSavingWp==nil then LuaSavingWp=false end
  if LuaWpName==nil then LuaWpName=false end

  if check0 then
   LuaWp=true
   system.print(input_text)
   databank.setStringValue("TEMP_Coord", input_text)
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
   local pos=databank.getStringValue("TEMP_Coord")
   databank.clearValue("TEMP_Coord")
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

--system.onActionLoop(lshift)
 L_SHIFT=true
--

--system.onActionStop(lshift)
 L_SHIFT=false
--

--system.onActionStart(gear)
 if shield and L_SHIFT then
  if shield.isVenting() then shield.stopVenting() else shield.startVenting() end
 end
--

--system.onActionLoop(lalt)
 L_ALT=true
--

--system.onActionStop(lalt)
 L_ALT=false
--

--system.onActionStart(option1)
 if (L_SHIFT and MENU_ON) then MENU_ON=false else MENU_ON=true end
 HUDScreen()
--

--system.onActionStart(down)
 if (L_ALT and MENU_ON) then
  if SelectionIsTrue==nil then SelectionIsTrue=false end
  local SelectList={}
  local index=0
  if screenState==-1 then
   if RouteExist then for i=1, #WpRouteList do if #MenuSelect<(#WpRouteList+8) then table.insert(MenuSelect, ROUTESelect[i]) end end end
   SelectList=MenuSelect
  elseif (screenState==0 and SelectionIsTrue==false) then if WPSelected==nil then WPSelected=0 end SelectList=WPSelect
  elseif (screenState==6 and SelectionIsTrue==false) then if ATLASSelected==nil then ATLASSelected=0 end SelectList=ATLASSelect
  elseif ((screenState==0 or screenState==6 or screenState==9) and SelectionIsTrue==true) then SelectList=SelectionList
  elseif screenState==5 then SelectList=SHIPSETINGSSelect
  elseif screenState==7 then SelectList=WPSTORESelect
  elseif screenState==8 then SelectList=WPSYNCSelect
  elseif (screenState==9 and SelectionIsTrue==false) then SelectList=SETTINGSSelect
  elseif screenState==10 then SelectList=COLORSSelect
  elseif screenState==11 then SelectList=DMGREPSelect
  elseif screenState==12 then SelectList=DBRESSelect
  elseif screenState==16 then SelectList=WPSETTINGSelect
  elseif screenState==17 then SelectList=SHIELDSelect
  end

  local n=1
  if SelectList[0]~="0" then n=0 end
  for i=n, #SelectList do
   if SelectList[i]=="select" then
    if i<#SelectList then
     SelectList[i]=""
     SelectList[i+1]="select"
     index=i+1
     break
    end
   end
  end

  if screenState==-1 then
   MenuSelect=SelectList
   if index~=0 then MenuTick=index HUDScreen() end
  elseif screenState==1 then ent_button() HUDScreen()
  elseif screenState==2 then ent_button() HUDScreen()
  elseif (screenState==0 and SelectionIsTrue==false) then
   if index~=0 then
    CellSelected=index
    WPSelected=(wp_page_index*10)-10+index
    WPSelect=SelectList
    HUDScreen()
   end
  elseif (screenState==6 and SelectionIsTrue==false) then
   if index~=0 then
    CellSelected=index
    ATLASSelected=(atlas_page_index*10)-10+index
    ATLASSelect=SelectList
    HUDScreen()
   end
  elseif ((screenState==0 or screenState==6 or screenState==9) and SelectionIsTrue==true) then SelectionList=SelectList HUDScreen()
  elseif screenState==5 then if index~=0 then SHIPSETINGSSelect=SelectList HUDScreen() end
  elseif screenState==7 then if index~=0 then WPSTORESelect=SelectList HUDScreen() end
  elseif screenState==8 then if index~=0 then ShipIDclr="" WPSYNCSelect=SelectList HUDScreen() end
  elseif (screenState==9 and SelectionIsTrue==false) then if index~=0 then CellSelected=index SETTINGSSelect=SelectList HUDScreen() end
  elseif screenState==10 then if index~=0 then COLORSSelect=SelectList HUDScreen() end
  elseif screenState==11 then if index~=0 then DMGREPSelect=SelectList HUDScreen() end
  elseif screenState==12 then if index~=0 then DBRESSelect=SelectList HUDScreen() end
  elseif screenState==16 then if index~=0 then WPSETTINGSelect=SelectList HUDScreen() end
  elseif screenState==17 then if index~=0 then SHIELDSelect=SelectList HUDScreen() end
  end
 end
--

--system.onActionStart(up)
 if (L_ALT and MENU_ON) then
  if SelectionIsTrue==nil then SelectionIsTrue=false end
  local SelectList={}
  local index=0
  if screenState==-1 then SelectList=MenuSelect
  elseif (screenState==0 and SelectionIsTrue==false) then WPSelected=0 SelectList=WPSelect
  elseif (screenState==6 and SelectionIsTrue==false) then ATLASSelected=0 SelectList=ATLASSelect
  elseif ((screenState==0 or screenState==6 or screenState==9) and SelectionIsTrue==true) then SelectList=SelectionList
  elseif screenState==5 then SelectList=SHIPSETINGSSelect
  elseif screenState==7 then SelectList=WPSTORESelect
  elseif screenState==8 then SelectList=WPSYNCSelect
  elseif (screenState==9 and SelectionIsTrue==false) then SelectList=SETTINGSSelect
  elseif screenState==10 then SelectList=COLORSSelect
  elseif screenState==11 then SelectList=DMGREPSelect
  elseif screenState==12 then SelectList=DBRESSelect
  elseif screenState==16 then SelectList=WPSETTINGSelect
  elseif screenState==17 then SelectList=SHIELDSelect
  end

  local n=1
  if SelectList[0]~="0" then n=0 end
  for i=n, #SelectList do
   if SelectList[i]=="select" then
    if i>n then
     SelectList[i]=""
     SelectList[i-1]="select"
     index=i-1
     break
    end
   end
  end

  if screenState==-1 then
   MenuSelect=SelectList
   if index~=0 then MenuTick=index HUDScreen() end
  elseif screenState==1 then clr_button() HUDScreen()
  elseif (screenState==2 and FROMSelect[2]=="select") then if FROMclr=="" then FROMclr="red" HUDScreen() else FROMclr="" clr_button() HUDScreen() end
  elseif screenState==3 then if DESTclr=="" then DESTclr="red" HUDScreen() else DESTclr="" clr_button() HUDScreen() end
  elseif (screenState==0 and SelectionIsTrue==false) then
   if index~=0 then
    CellSelected=index
    WPSelected=(wp_page_index*10)-10+index
    WPSelect=SelectList
   end
   HUDScreen()
  elseif (screenState==6 and SelectionIsTrue==false) then
   if index~=0 then
    CellSelected=index
    ATLASSelected=(atlas_page_index*10)-10+index
    ATLASSelect=SelectList
   end
   HUDScreen()
  elseif ((screenState==0 or screenState==6 or screenState==9) and SelectionIsTrue==true) then SelectionList=SelectList HUDScreen()
  elseif screenState==5 then if index~=0 then SHIPSETINGSSelect=SelectList end HUDScreen()
  elseif screenState==7 then if index~=0 then WPSTORESelect=SelectList end HUDScreen()
  elseif screenState==8 then if index~=0 then WPSYNCSelect=SelectList end ShipIDclr="" HUDScreen()
  elseif (screenState==9 and SelectionIsTrue==false) then if index~=0 then CellSelected=index SETTINGSSelect=SelectList end HUDScreen()
  elseif screenState==10 then if index~=0 then COLORSSelect=SelectList end HUDScreen()
  elseif screenState==11 then if index~=0 then DMGREPSelect=SelectList end HUDScreen()
  elseif screenState==12 then if index~=0 then DBRESSelect=SelectList end HUDScreen()
  elseif screenState==16 then if index~=0 then WPSETTINGSelect=SelectList end HUDScreen()
  elseif screenState==17 then if index~=0 then SHIELDSelect=SelectList end HUDScreen()
  end
 end
--

--system.onActionStart(straferight)
 if (L_ALT and MENU_ON) then
  if SelectionIsTrue==nil then SelectionIsTrue=false end
  if screenState==-1 then
   if MenuTick<=8 then
    local i=MenuTick
    local screenStateList={[1]=1,[2]=6,[3]=0,[4]=2,[5]=3,[6]=4,[7]=17,[8]=9}
    screenState=screenStateList[i]
    if screenState==17 and shield==nil then screenState=-1 end
    menu()
   elseif RouteActivated then
    IDToNextWp=(MenuTick-8)
    DistToNextWp=(IDToNextWp-1)
    RouteStatus="Activated"
    FindWP()
   end
  elseif screenState==2 then FROMclr="" add_wp() HUDScreen()
  elseif (screenState==0 and WPSelect[0]=="select") then big_arrow_down() HUDScreen()
  elseif (screenState==0 and WPSelected>0 and SelectionIsTrue==false) then SelectionIsTrue=true HUDScreen()
  elseif (screenState==0 and SelectionIsTrue==true) then
   if (SelectionList[1]=="select" and wp_list[WPSelected]~=nil) then WPclr[4]="" SelectionList=nil SelectionIsTrue=false ScreenOrigin=0 menu_settings()
   elseif SelectionList[2]=="select" then WPclr[4]="" SelectionList=nil SelectionIsTrue=false menu_destination()
   elseif SelectionList[3]=="select" then WPclr[4]="" SelectionList=nil SelectionIsTrue=false menu_from()
   elseif SelectionList[4]=="select" then if WPclr[4]=="" then WPclr[4]="red" HUDScreen() else WPclr[4]="" SelectionList=nil SelectionIsTrue=false clr_wp(WPSelected) end
   elseif (SelectionList[5]=="select" or SelectionList[6]=="select" or SelectionList[7]=="select") then WPclr[4]="" SelectionIsTrue=false AddRemoveRoute()
   end
  elseif (screenState==6 and ATLASSelect[0]=="select") then big_arrow_down() HUDScreen()
  elseif (screenState==6 and ATLASSelected>0 and SelectionIsTrue==false) then SelectionIsTrue=true HUDScreen()
  elseif (screenState==6 and SelectionIsTrue==true) then
   if SelectionList[1]=="select" then SelectionList=nil SelectionIsTrue=false menu_destination()
   elseif SelectionList[2]=="select" then SelectionList=nil SelectionIsTrue=false menu_from() end
  elseif (screenState==7 and WPSTORESelect[1]=="select") then add_wp() HUDScreen()
  elseif screenState==8 then if (WPSYNCSelect[2]=="select" or WPSYNCSelect[3]=="select") then ShipIDclr="" ent_button() HUDScreen() end
  elseif (screenState==9 and SelectionIsTrue==false) then if SETTINGSSelect[7]=="select" then SelectionIsTrue=true else ent_button() end HUDScreen()
  elseif (screenState==9 and SelectionIsTrue==true) then
   if (SelectionList[1]=="select" and RouteExist) then RouteCheck()
   elseif (SelectionList[2]=="select" and RouteExist) then SelectionIsTrue=false AddRemoveRoute() end
  elseif screenState==12 then
   if (DBRESSelect[0]~="select" and DBRESSelect[6]~="select") then ent_button()
   elseif DBRESSelect[6]=="select" then clr_button() end  HUDScreen()
  elseif screenState==17 then
   if SHIELDSelect[1]=="select" then ScreenSelection="ShieldToggle"
   elseif SHIELDSelect[2]=="select" then ScreenSelection="VENTING"
   elseif SHIELDSelect[3]=="select" then ScreenSelection="SET"
   elseif SHIELDSelect[4]=="select" then ScreenSelection="RESET"
   elseif SHIELDSelect[5]=="select" then ScreenSelection="A+"
   elseif SHIELDSelect[6]=="select" then ScreenSelection="E+"
   elseif SHIELDSelect[7]=="select" then ScreenSelection="K+"
   elseif SHIELDSelect[8]=="select" then ScreenSelection="T+"
   end
  end
 end
--

--system.onActionStart(strafeleft)
 if (L_ALT and MENU_ON) then
  if screenState==1 then screenState=-1 menu()
  elseif (screenState==-1 and RouteActivated and MenuTick>8) then ScreenOrigin=-1 menu_settings()
  elseif screenState==2 then FROMclr="" screenState=-1 menu()
  elseif screenState==3 then DESTclr="" screenState=-1 menu()
  elseif screenState==4 then screenState=-1 menu()
  elseif screenState==5 then screenState=9 HUDScreen() 
  elseif screenState==7 then if WPSTORESelect[0]=="select" then screenState=9 end HUDScreen()
  elseif screenState==8 then
   if WPSYNCSelect[0]=="select" then ShipIDclr="" screenState=9
   elseif (WPSYNCSelect[1]=="select" and keypad_input_shipid~="No ID") then if ShipIDclr=="" then ShipIDclr="red" else ShipIDclr="" clr_button() end
   end HUDScreen()
  elseif (screenState==9 and SelectionIsTrue==false) then SETTINGSSelect={[0]="select","","","","","","","","","",""} screenState=-1 menu()
  elseif screenState==10 then screenState=9 HUDScreen()
  elseif screenState==11 then screenState=9 HUDScreen()
  elseif screenState==12 then if (DBRESSelect[0]=="select" or DBRESSelect[6]=="select") then screenState=9 else clr_button() end HUDScreen()
  elseif (screenState==0 and (WPSelect[0]~="select" or wp_page_index==1) and SelectionIsTrue==false) then SelectionList=nil screenState=-1 menu()
  elseif (screenState==0 and WPSelect[0]=="select") then big_arrow_up() HUDScreen()
  elseif (screenState==6 and (ATLASSelect[0]~="select" or atlas_page_index==1) and SelectionIsTrue==false) then SelectionList=nil screenState=-1 menu()
  elseif (screenState==6 and ATLASSelect[0]=="select") then big_arrow_up() HUDScreen()
  elseif ((screenState==0 or screenState==6 or screenState==9) and SelectionIsTrue==true) then WPclr[4]="" SelectionList=nil SelectionIsTrue=false menu()
  elseif screenState==16 then
   if WPSETTINGSelect[0]=="select" then WPSETclr={"",""} screenState=ScreenOrigin ScreenOrigin=""
   elseif WPSETTINGSelect[1]=="select" then if WPSETclr[1]=="" then  WPSETclr[1]="red" else WPSETclr[1]="" clr_button() end
   elseif WPSETTINGSelect[2]=="select" then if WPSETclr[2]=="" then  WPSETclr[2]="red" else WPSETclr[2]="" clr_button() end
   end HUDScreen()
  elseif screenState==17 then
   if SHIELDSelect[0]=="select" then screenState=-1 menu()
   elseif SHIELDSelect[5]=="select" then ScreenSelection="A-"
   elseif SHIELDSelect[6]=="select" then ScreenSelection="E-"
   elseif SHIELDSelect[7]=="select" then ScreenSelection="K-"
   elseif SHIELDSelect[8]=="select" then ScreenSelection="T-"
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
  prog_bar=(msg_counter * 496)/receiving_wp
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
  prog_bar=(fleet_msg_counter * 496)/receiving_wp
  msg_received=true
  rcv_msg=message:gsub("@@@","\"")
  rcv_msg=string.gsub(rcv_msg, "<FleetBaseData>", "")
  rcv_msg=json.decode(rcv_msg)
  receiving_FleetData()
  unit.setTimer("Ship_Id", 5)
 end

 if BaseData_n then receiving_wp=string.gsub(message, "<BaseData_n>", "") end
--