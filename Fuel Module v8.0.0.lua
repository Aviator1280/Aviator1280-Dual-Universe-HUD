--[[

Author: Aviator1280

--]]

--unit.onStart()
    local SoftwareVersion="v8.0.0"
    db.setStringValue("Fuel Module ver", SoftwareVersion)
    db.setStringValue("Fuel Module", "true")
    system.print("- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -")
    system.print("FUEL MODULE System ONLINE")
    system.print("Release "..SoftwareVersion)
    system.print("- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -")

    --INITIALIZE FUEL TANKS/SCREEN
        slot = {}
        slot[1] = {slot1 ,{["class"]="", ["element"]="", ["number"]=""}}
        slot[2] = {slot2 ,{["class"]="", ["element"]="", ["number"]=""}}
        slot[3] = {slot3 ,{["class"]="", ["element"]="", ["number"]=""}}
        slot[4] = {slot4 ,{["class"]="", ["element"]="", ["number"]=""}}
        slot[5] = {slot5 ,{["class"]="", ["element"]="", ["number"]=""}}
        slot[6] = {slot6 ,{["class"]="", ["element"]="", ["number"]=""}}
        slot[7] = {slot7 ,{["class"]="", ["element"]="", ["number"]=""}}
        slot[8] = {slot8 ,{["class"]="", ["element"]="", ["number"]=""}}
        slot[9] = {slot9 ,{["class"]="", ["element"]="", ["number"]=""}}
        slot[10] = {slot10 ,{["class"]="" ,["element"]="", ["number"]=""}}

        atmofueltank_size = 0
        spacefueltank_size = 0
        rocketfueltank_size = 0
        ScreenUnit = false

        for i= 1, #slot do
            local slot_id = slot[i]
            if slot_id[1] then
                local class = slot_id[1].getClass()
                if class == "AtmoFuelContainer" then
                    AtmoTank = "true"
                    db.setStringValue("AtmoFuelContainer", AtmoTank)
                    atmofueltank_size = atmofueltank_size +1
                    local element = "atmofueltank_"..atmofueltank_size
                    slot_id[2] = {["class"]=class ,["element"]=element, ["number"]=atmofueltank_size}
                end
                if class == "SpaceFuelContainer" then
                    SpaceTank = "true"
                    db.setStringValue("SpaceFuelContainer", SpaceTank)
                    spacefueltank_size = spacefueltank_size +1
                    local element = "spacefueltank_"..spacefueltank_size
                    slot_id[2] = {["class"]=class ,["element"]=element, ["number"]=spacefueltank_size}
                end
                if class == "RocketFuelContainer" then
                    RocketTank = "true"
                    db.setStringValue("RocketFuelContainer", RocketTank)
                    rocketfueltank_size = rocketfueltank_size +1
                    local element = "rocketfueltank_"..rocketfueltank_size
                    slot_id[2] = {["class"]=class ,["element"]=element, ["number"]=rocketfueltank_size}
                end
                if class == "ScreenUnit" then
                    ScreenUnit = true
                    ScreenSlot = slot[i][1]
                end
            end
        end

    --NUMBER OF TANKS
        if atmofueltank_size > 0 then
            a_fuel_tank_n = atmofueltank_size
            db.setIntValue("a_fuel_tank_n", a_fuel_tank_n)
        else
            a_fuel_tank_n = 0
        end

        if spacefueltank_size > 0 then
            s_fuel_tank_n = spacefueltank_size
            db.setIntValue("s_fuel_tank_n", s_fuel_tank_n)
        else
            s_fuel_tank_n = 0
        end

        if rocketfueltank_size > 0 then
            r_fuel_tank_n = rocketfueltank_size
            db.setIntValue("r_fuel_tank_n", r_fuel_tank_n)
        else
            r_fuel_tank_n = 0
        end

        if ScreenUnit then
            TotalFuelTanks=a_fuel_tank_n+s_fuel_tank_n+r_fuel_tank_n
        end

    --FUEL DATA
        function fuel_data()

        --FUEL MASS
            fuel_mass = 0
            function total_fuel_mass()
                if atmofueltank_size > 0 then
                    a_fuel_mass = 0
                    for i = 1, #slot do
                        local slot_id = slot[i]
                        local class = slot_id[2].class
                        if class == "AtmoFuelContainer" then
                            a_fuel_mass = a_fuel_mass + slot_id[1].getItemsMass()
                            t_a_fuel_mass = math.floor(a_fuel_mass/1000*10)/10
                        end
                    end
                end

                if spacefueltank_size > 0 then
                    s_fuel_mass = 0
                    for i = 1, #slot do
                        local slot_id = slot[i]
                        local class = slot_id[2].class
                        if class == "SpaceFuelContainer" then
                            s_fuel_mass = s_fuel_mass + slot_id[1].getItemsMass()
                            t_s_fuel_mass = math.floor(s_fuel_mass/1000*10)/10
                        end
                    end
                end

                if rocketfueltank_size > 0 then
                    r_fuel_mass = 0
                    for i = 1, #slot do
                        local slot_id = slot[i]
                        local class = slot_id[2].class
                        if class == "RocketFuelContainer" then
                            r_fuel_mass = r_fuel_mass + slot_id[1].getItemsMass()
                            t_r_fuel_mass = math.floor(r_fuel_mass/1000*10)/10
                        end
                    end
                end
            end
            total_fuel_mass()

        --AVG FUEL PERCENTAGE
            s_fuel_percent_avg_hud = 0
            a_fuel_percent_avg_hud = 0
            r_fuel_percent_avg_hud = 0
            if ScreenUnit then FT_List={} end

            function avg_fuel_percentage()
                local a_fuel_percent = 0
                if atmofueltank_size > 0 then
                    for i = 1, #slot do
                        local slot_id = slot[i]
                        local class = slot_id[2].class
                        if class == "AtmoFuelContainer" then
                            if json.decode(slot_id[1].getWidgetData()).percentage then
                                local Percentage=json.decode(slot_id[1].getWidgetData()).percentage
                                if ScreenUnit then FT_List[i]={class; Percentage} end
                                a_fuel_percent = a_fuel_percent + Percentage
                            end
                        end
                    end
                    a_fuel_percent_avg_hud = math.ceil(a_fuel_percent/atmofueltank_size)
                else
                    a_fuel_percent_avg_hud = [[n/a]]
                end

                local s_fuel_percent = 0
                if spacefueltank_size > 0 then
                    for i = 1, #slot do
                        local slot_id = slot[i]
                        local class = slot_id[2].class
                        if class == "SpaceFuelContainer" then
                            if json.decode(slot_id[1].getWidgetData()).percentage then
                                local Percentage=json.decode(slot_id[1].getWidgetData()).percentage
                                if ScreenUnit then FT_List[i]={class; Percentage} end
                                s_fuel_percent = s_fuel_percent + Percentage
                            end
                        end
                    end
                    s_fuel_percent_avg_hud = math.ceil(s_fuel_percent/spacefueltank_size)
                else
                    s_fuel_percent_avg_hud = [[n/a]]
                end

                local r_fuel_percent = 0
                if rocketfueltank_size > 0 then
                    for i = 1, #slot do
                        local slot_id = slot[i]
                        local class = slot_id[2].class
                        if class == "RocketFuelContainer" then
                            if json.decode(slot_id[1].getWidgetData()).percentage then
                                local Percentage=json.decode(slot_id[1].getWidgetData()).percentage
                                if ScreenUnit then FT_List[i]={class; Percentage} end
                                r_fuel_percent = r_fuel_percent + Percentage
                            end
                        end
                    end
                    r_fuel_percent_avg_hud = math.ceil(r_fuel_percent/rocketfueltank_size)
                else
                    r_fuel_percent_avg_hud = [[n/a]]
                end

                if ScreenUnit then
                 New_FT_List={}
                 local c=1
                 for i=1, 10 do
                  if FT_List[i]~=nil then
                   New_FT_List[c]={[1]=FT_List[i][1]; [2]=FT_List[i][2]}
                   c=c+1
                  end
                 end
                 FT_List=New_FT_List

                 ScreenSlot.setScriptInput(json.encode(FT_List))
                end
            end
            avg_fuel_percentage()

        --ATMO FUEL WARNING
            AFuelSpy = [[<span style=" color:#141fad">A Fuel</span>]]
            AFuelWrn = [[]]

            if atmofueltank_size > 0 then
                function atmo_fuel_percent()
                    local fuelpercent = 0
                    AFuelWrn = [[]]
                    AFuelSpy = [[<span style=" color:#141fad">A Fuel</span>]]
                    for i = 1, #slot do
                        local slot_id = slot[i]
                        local class = slot_id[2].class
                        if class == "AtmoFuelContainer" then
                            if json.decode(slot_id[1].getWidgetData()).percentage then
                                fuelpercent = json.decode(slot_id[1].getWidgetData()).percentage
                                if fuelpercent < 20 and fuelpercent > 0 then
                                    AFuelSpy = [[<span style=" color:orange">A Fuel</span>]] 
                                    AFuelWrn = AFuelWrn ..[[<span style=" color: orange">A Fuel Tank ]]..slot_id[2].number..[[ LO LVL</span><br>]]
                                elseif fuelpercent == 0 then
                                    AFuelSpy = [[<span style=" color:red">A Fuel</span>]]
                                    AFuelWrn = AFuelWrn.. [[<span style=" color: red">A Fuel Tank ]]..slot_id[2].number..[[ EMPTY</span><br>]]
                                end
                            end
                        end
                    end
                    return AFuelSpy, AFuelWrn
                end
                atmo_fuel_percent()
            end

        --SPACE FUEL WARNING
            SFuelSpy = [[<span style=" color:#141fad">S Fuel</span>]]
            SFuelWrn = [[]]

            if spacefueltank_size > 0 then
                function space_fuel_percent()
                    local fuelpercent = 0
                    SFuelWrn = [[]]
                    SFuelSpy = [[<span style=" color:#141fad">S Fuel</span>]]
                    for i = 1, #slot do
                        local slot_id = slot[i]
                        local class = slot_id[2].class
                        if class == "SpaceFuelContainer" then
                            if json.decode(slot_id[1].getWidgetData()).percentage then
                                fuelpercent = json.decode(slot_id[1].getWidgetData()).percentage
                                if fuelpercent < 20 and fuelpercent > 0 then
                                    SFuelSpy = [[<span style=" color:orange">S Fuel</span>]] 
                                    SFuelWrn = SFuelWrn ..[[<span style=" color: orange">S Fuel Tank ]]..slot_id[2].number..[[ LO LVL</span><br>]]
                                elseif fuelpercent == 0 then
                                    SFuelSpy = [[<span style=" color:red">S Fuel</span>]]
                                    SFuelWrn = SFuelWrn.. [[<span style=" color: red">S Fuel Tank ]]..slot_id[2].number..[[ EMPTY</span><br>]]
                                end
                            end
                        end
                    end
                    return SFuelSpy, SFuelWrn
                end
                space_fuel_percent()
            end

        --ROCKET FUEL WARNING
            RFuelSpy = [[<span style=" color:#141fad">R Fuel</span>]]
            RFuelWrn = [[]]
            RktAct = [[#141fad]]

            if rocketfueltank_size > 0 then
                function rocket_fuel_percent()
                    local fuelpercent = 0
                    RFuelWrn = [[]]
                    RFuelSpy = [[<span style=" color:#141fad">R Fuel</span>]]
                    for i = 1, #slot do
                        local slot_id = slot[i]
                        local class = slot_id[2].class
                        if class == "RocketFuelContainer" then
                            if json.decode(slot_id[1].getWidgetData()).percentage then
                                fuelpercent = json.decode(slot_id[1].getWidgetData()).percentage
                                if fuelpercent < 20 and fuelpercent > 0 then
                                    RFuelSpy = [[<span style=" color:orange">R Fuel</span>]] 
                                    RFuelWrn = RFuelWrn ..[[<span style=" color: orange">R Fuel Tank ]]..slot_id[2].number..[[ LO LVL</span><br>]]
                                elseif fuelpercent == 0 then
                                    RFuelSpy = [[<span style=" color:red">R Fuel</span>]]
                                    RFuelWrn = RFuelWrn.. [[<span style=" color: red">R Fuel Tank ]]..slot_id[2].number..[[ EMPTY</span><br>]]
                                end
                            end
                        end
                    end
                    return RFuelSpy, RFuelWrn
                end
                rocket_fuel_percent()

                function r_warning_light()
                    for i = 1, #slot do
                        local slot_id = slot[i]
                        local class = slot_id[2].class
                        if class == "RocketFuelContainer" then
                            RktAct = json.decode(slot_id[1].getWidgetData()).timeLeft
                            if RktAct == "n/a" then
                                RktAct = [[#141fad]]
                            else
                                RktAct = [[red]]
                            end
                        end
                    end
                    return RktAct
                end
                r_warning_light()
            end

        --ATMO FUEL MIN TIME
            a_t_h = 0
            a_t_m = 0
            a_t_s = 0

            if atmofueltank_size > 0 then
                function a_fuel_minimum_time()
                    for i=1, #slot do
                        local slot_id = slot[i]
                        local class = slot_id[2].class
                        if class == "AtmoFuelContainer" then
                            a_minutes_min = json.decode(slot_id[1].getWidgetData()).timeLeft
                            if a_minutes_min ~= "n/a" then
                                a_minutes_min = a_minutes_min
                                break
                            else
                                a_minutes_min = 0
                            end
                        end
                    end
                    for i=1, #slot do
                        local slot_id = slot[i]
                        local class = slot_id[2].class
                        if class == "AtmoFuelContainer" then
                            local timeleft = json.decode(slot_id[1].getWidgetData()).timeLeft
                            if timeleft ~= "n/a" and timeleft > 0 then
                                if timeleft < a_minutes_min then
                                    a_minutes_min = timeleft
                                end
                            end
                        end
                    end
                    a_t_h = a_minutes_min/3600
                    a_t_m = (a_t_h-(math.floor(a_t_h)))*60
                    a_t_s = (a_t_m-(math.floor(a_t_m)))*60
                    return a_t_h, a_t_m, a_t_s
                end
                a_fuel_minimum_time()
            end

        --SPACE FUEL MIN TIME
            s_t_h = 0
            s_t_m = 0
            s_t_s = 0

            if spacefueltank_size > 0 then
                function s_fuel_minimum_time()
                    for i=1, #slot do
                        local slot_id = slot[i]
                        local class = slot_id[2].class
                        if class == "SpaceFuelContainer" then
                            s_minutes_min = json.decode(slot_id[1].getWidgetData()).timeLeft
                            if s_minutes_min ~= "n/a" then
                                s_minutes_min = s_minutes_min
                                break
                            else
                                s_minutes_min = 0
                            end
                        end
                    end
                    for i=1, #slot do
                        local slot_id = slot[i]
                        local class = slot_id[2].class
                        if class == "SpaceFuelContainer" then
                            local timeleft = json.decode(slot_id[1].getWidgetData()).timeLeft
                            if timeleft ~= "n/a" and timeleft > 0 then
                                if timeleft < s_minutes_min then
                                    s_minutes_min = timeleft
                                end
                            end
                        end
                    end
                    s_t_h = s_minutes_min/3600
                    s_t_m = (s_t_h-(math.floor(s_t_h)))*60
                    s_t_s = (s_t_m-(math.floor(s_t_m)))*60
                    return s_t_h, s_t_m, s_t_s
                end
                s_fuel_minimum_time()
            end

        --ROCKET FUEL MIN TIME
            r_t_h = 0
            r_t_m = 0
            r_t_s = 0

            if rocketfueltank_size > 0 then
                function r_fuel_minimum_time()
                    for i=1, #slot do
                        local slot_id = slot[i]
                        local class = slot_id[2].class
                        if class == "RocketFuelContainer" then
                            r_minutes_min = json.decode(slot_id[1].getWidgetData()).timeLeft
                            if r_minutes_min ~= "n/a" then
                                r_minutes_min = r_minutes_min
                                break
                            else
                                r_minutes_min = 0
                            end
                        end
                    end
                    for i=1, #slot do
                        local slot_id = slot[i]
                        local class = slot_id[2].class
                        if class == "RocketFuelContainer" then
                            local timeleft = json.decode(slot_id[1].getWidgetData()).timeLeft
                            if timeleft ~= "n/a" and timeleft > 0 then
                                if timeleft < r_minutes_min then
                                    r_minutes_min = timeleft
                                end
                            end
                        end
                    end
                    r_t_h = r_minutes_min/3600
                    r_t_m = (r_t_h-(math.floor(r_t_h)))*60
                    r_t_s = (s_t_m-(math.floor(r_t_m)))*60
                    return r_t_h, r_t_m, r_t_s
                end
                r_fuel_minimum_time()
            end

        --DATA ASEMBLER
           if AtmoTank == "true" then
            local atmo_data = {
                ["t_a_fuel_mass"]=t_a_fuel_mass,
                ["a_fuel_percent_avg_hud"]=a_fuel_percent_avg_hud,
                ["AFuelSpy"]=AFuelSpy,
                ["AFuelWrn"]=AFuelWrn,
                ["a_t_h"]=math.floor(a_t_h),
                ["a_t_m"]=math.floor(a_t_m),
                ["a_t_s"]=math.floor(a_t_s)
            }
            atmo_data = json.encode(atmo_data)
            db.setStringValue("atmo_data", atmo_data:gsub("\"","@@@"))
           end
           if SpaceTank == "true" then
            local space_data = {
                ["t_s_fuel_mass"]=t_s_fuel_mass,
                ["s_fuel_percent_avg_hud"]=s_fuel_percent_avg_hud,
                ["SFuelSpy"]=SFuelSpy,
                ["SFuelWrn"]=SFuelWrn,
                ["s_t_h"]=math.floor(s_t_h),
                ["s_t_m"]=math.floor(s_t_m),
                ["s_t_s"]=math.floor(s_t_s)
            }
            space_data = json.encode(space_data)
            db.setStringValue("space_data", space_data:gsub("\"","@@@"))
           end
           if RocketTank == "true" then
            local rocket_data = {
                ["r_s_fuel_mass"]=t_r_fuel_mass,
                ["r_fuel_percent_avg_hud"]=r_fuel_percent_avg_hud,
                ["RFuelSpy"]=RFuelSpy,
                ["RFuelWrn"]=RFuelWrn,
                ["RktAct"]=RktAct,
                ["r_t_h"]=math.floor(r_t_h),
                ["r_t_m"]=math.floor(r_t_m),
                ["r_t_s"]=math.floor(r_t_s)
            }
            rocket_data = json.encode(rocket_data)
            db.setStringValue("rocket_data", rocket_data:gsub("\"","@@@"))
           end
        end
        fuel_data()

    --SCREEN
     --EXPORT
        local FontName="Montserrat-Light"--export
        FontName=[["]].. FontName ..[["]]
        local FontSize=30--export

        local Font_R=217--export
        Font_R=ColorConvert(Font_R)
        local Font_G=217--export
        Font_G=ColorConvert(Font_G)
        local Font_B=217--export
        Font_B=ColorConvert(Font_B)

        local Table_R=0--export
        Table_R=ColorConvert(Table_R)
        local Table_G=0--export
        Table_G=ColorConvert(Table_G)
        local Table_B=255--export
        Table_B=ColorConvert(Table_B)

        local AFcolor_R=ColorConvert(30)
        local AFcolor_G=ColorConvert(144)
        local AFcolor_B=ColorConvert(255)

        local SFcolor_R=ColorConvert(255)
        local SFcolor_G=ColorConvert(255)
        local SFcolor_B=ColorConvert(0)

        local RFcolor_R=ColorConvert(106)
        local RFcolor_G=ColorConvert(90)
        local RFcolor_B=ColorConvert(205)

     --SCREEN DATA
        function ScreenData()
            ScreenSlot.activate()
        --ScreenTable
            local ScreenTable={}
        --Parameters
            ScreenTable[1]=[[
            local FontName=]].. FontName ..[[
            local FontSize=]].. FontSize ..[[
            local FontColorR, FontColorG, FontColorB=]].. Font_R ..[[, ]].. Font_G ..[[, ]]..Font_B ..[[
            local TableR, TableG, TableB=]].. Table_R ..[[, ]].. Table_G ..[[, ]].. Table_B ..[[
            local AFcolor_R, AFcolor_G, AFcolor_B=]].. AFcolor_R ..[[, ]].. AFcolor_G ..[[, ]].. AFcolor_B ..[[
            local SFcolor_R, SFcolor_G, SFcolor_B=]].. SFcolor_R ..[[, ]].. SFcolor_G ..[[, ]].. SFcolor_B ..[[
            local RFcolor_R, RFcolor_G, RFcolor_B=]].. RFcolor_R ..[[, ]].. RFcolor_G ..[[, ]].. RFcolor_B ..[[
            ]]

        --Setup
            ScreenTable[2]=[[
            local json=require('dkjson')

         --Layers
            local L_AF=createLayer()
            local L_SF=createLayer()
            local L_RF=createLayer()
            local L_table=createLayer()
            local L_text=createLayer()

         --Default
            setDefaultFillColor(L_text, Shape_Text, FontColorR, FontColorG, FontColorB, 1)
            setDefaultFillColor(L_AF, Shape_Box, AFcolor_R, AFcolor_G, AFcolor_B, 1)
            setDefaultFillColor(L_SF, Shape_Box, SFcolor_R, SFcolor_G, SFcolor_B, 1)
            setDefaultFillColor(L_RF, Shape_Box, RFcolor_R, RFcolor_G, RFcolor_B, 1)
            setDefaultStrokeColor(L_table, Shape_Box, TableR, TableG, TableB, 1)
            setDefaultStrokeWidth(L_table, Shape_Box, 1)
            setDefaultFillColor(L_table, Shape_Box, TableR, TableG, TableB, 0.2)

         --Fonts
            local FontText=loadFont(FontName , FontSize)
            ]]

        --Fuel Gauges
            ScreenTable[3]=[[
             local TotalFuelTanks=]].. TotalFuelTanks ..[[
             local FT_List=json.decode(getInput()) or {}

             local ScrW,ScrH=getResolution()

             local x,y,w,h=0,100,100,400
             local sep=ScrW-(TotalFuelTanks*w)
             sep=sep/(TotalFuelTanks+1)

             for i=1, #FT_List do
                x=(sep*i)+((i-1)*w)
                addBox(L_table, x, y, w, h)

                setNextTextAlign(L_text, AlignH_Center, AlignV_Middle)
                addText(L_text, FontText, i, (x+w/2), (y-60))

                local Percent=FT_List[i][2]
                local hp=h/100*Percent

                setNextTextAlign(L_text, AlignH_Center, AlignV_Middle)
                addText(L_text, FontText, Percent.." %", (x+w/2), (y+h+50))

                local class=FT_List[i][1]
                if class=="AtmoFuelContainer" then
                 setNextTextAlign(L_text, AlignH_Center, AlignV_Middle)
                 addText(L_text, FontText, "A Fuel", (x+w/2), (y-25))
                 addBox(L_AF, x, y+h, w, -hp)
                elseif class=="SpaceFuelContainer" then
                 setNextTextAlign(L_text, AlignH_Center, AlignV_Middle)
                 addText(L_text, FontText, "S Fuel", (x+w/2), (y-25))
                 addBox(L_SF, x, y+h, w, -hp)
                elseif class=="RocketFuelContainer" then
                 setNextTextAlign(L_text, AlignH_Center, AlignV_Middle)
                 addText(L_text, FontText, "R Fuel", (x+w/2), (y-25))
                 addBox(L_RF, x, y+h, w, -hp)
                end

             end
            ]]

        --Animation
            ScreenTable[4]=[[requestAnimationFrame(1)]]

        --RENDER
            function ScreenRender()
             local UI=table.concat(ScreenTable)
             ScreenSlot.setRenderScript(UI)
            end
            ScreenRender()

        end
        if ScreenUnit then ScreenData() end

        unit.setTimer("update", 1)
--

--library.onStart()
    function ColorConvert(x)
        local y=tonumber(x)/255
        return y
    end
--

--unit.onTimer(update)
    fuel_data()
--

--unit.onStop()
    db.setStringValue("Fuel Module", "false")
    db.setStringValue("AtmoFuelContainer", "false")
    db.setStringValue("SpaceFuelContainer", "false")
    db.setStringValue("RocketFuelContainer", "false")

    if ScreenUnit then
     ScreenSlot.setCenteredText("FUEL MODULE")
    end
--