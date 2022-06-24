Config = {}

Config.Exercises = {
    ["boksbal"] = {
        ["idleDict"] = "move_m@jogger",
        ["idleAnim"] = "idle",
        ["actionDict"] = "anim@mp_player_intcelebrationmale@shadow_boxing",
        ["actionAnim"] = "shadow_boxing",
        ["actionTime"] = 2850,
        ["enterDict"] = "anim@mp_player_intuppershadow_boxing",
        ["enterAnim"] = "exit",
        ["enterTime"] = 1100,
        ["exitDict"] = "move_m@_idles@out_of_breath",
        ["exitAnim"] = "idle_a",
        ["exitTime"] = 3300,
        ["actionProcent"] = 1,
        ["actionProcentTimes"] = 3,
        ["freeze"] = true,

    },
    ["Situps"] = {
        ["idleDict"] = "amb@world_human_sit_ups@male@idle_a",
        ["idleAnim"] = "idle_a",
        ["actionDict"] = "amb@world_human_sit_ups@male@base",
        ["actionAnim"] = "base",
        ["actionTime"] = 3400,
        ["enterDict"] = "amb@world_human_sit_ups@male@enter",
        ["enterAnim"] = "enter",
        ["enterTime"] = 4200,
        ["exitDict"] = "amb@world_human_sit_ups@male@exit",
        ["exitAnim"] = "exit", 
        ["exitTime"] = 3700,
        ["actionProcent"] = 1,
        ["actionProcentTimes"] = 10,
        ["freeze"] = true
    },
    ["loopband"] = {
        ["idleDict"] = "move_m@jogger",
        ["idleAnim"] = "idle",
        ["actionDict"] = "move_m@jogger",
        ["actionAnim"] = "run",
        ["actionTime"] = 2500,
        ["enterDict"] = "move_m@jogger",
        ["enterAnim"] = "idle",
        ["enterTime"] = 2500,
        ["exitDict"] = "move_m@jogger",
        ["exitAnim"] = "rstop_l",
        ["exitTime"] = 2000,
        ["actionProcent"] = 1,
        ["actionProcentTimes"] = 4,
        ["freeze"] = true
    },

    ["Chins"] = {
        ["idleDict"] = "amb@prop_human_muscle_chin_ups@male@idle_a",
        ["idleAnim"] = "idle_a",
        ["actionDict"] = "amb@prop_human_muscle_chin_ups@male@base",
        ["actionAnim"] = "base",
        ["actionTime"] = 3000,
        ["enterDict"] = "amb@prop_human_muscle_chin_ups@male@enter",
        ["enterAnim"] = "enter",
        ["enterTime"] = 1600,
        ["exitDict"] = "amb@prop_human_muscle_chin_ups@male@exit",
        ["exitAnim"] = "exit",
        ["exitTime"] = 3700,
        ["actionProcent"] = 1,
        ["actionProcentTimes"] = 10,
        ["freeze"] = true
    },

    ["Pushups"] = {
        ["idleDict"] = "amb@world_human_push_ups@male@idle_a",
        ["idleAnim"] = "idle_c",
        ["actionDict"] = "amb@world_human_push_ups@male@base",
        ["actionAnim"] = "base",
        ["actionTime"] = 1100,
        ["enterDict"] = "amb@world_human_push_ups@male@enter",
        ["enterAnim"] = "enter",
        ["enterTime"] = 3050,
        ["exitDict"] = "amb@world_human_push_ups@male@exit",
        ["exitAnim"] = "exit",
        ["exitTime"] = 3400,
        ["actionProcent"] = 1,
        ["actionProcentTimes"] = 3,
        ["freeze"] = true
    },

    ["weight"] = {
        ["dpIdleAnim"] = "gewichtidle",
        ["dpActionAnim"] = "gewichtactie",
        ["actionTime"] = 3400,
        ["dpEnterAnim"] = "pickup",
        ["enterTime"] = 2000,
        ["dpExitAnim"] = "pickup", 
        ["exitTime"] = 2000,
        ["actionProcent"] = 1,
        ["actionProcentTimes"] = 10,
        ["freeze"] = true
    },
}

Config.Locations = {      -- REMINDER. If you want it to set coords+heading then enter heading, else put nil ( ["h"] )

-- ChinUps -- 
    {["x"] = -1105.15, ["y"] = -836.97, ["z"] = 26.85 - 0.98, ["h"] = 129.66, ["exercise"] = "Chins"}, -- Politie
    {["x"] = -1104.00, ["y"] = -838.37, ["z"] = 26.85 - 0.98, ["h"] = 130.66, ["exercise"] = "Chins"}, -- Politie
    {["x"] = 251.25, ["y"] = -266.90, ["z"] = 59.92 - 0.98, ["h"] = 69.25, ["exercise"] = "Chins"},
    {["x"] = 248.78, ["y"] = -268.32, ["z"] = 59.92 - 0.98, ["h"] = 252.17, ["exercise"] = "Chins"},
    {["x"] = 250.36, ["y"] = -264.02, ["z"] = 59.92 - 0.98, ["h"] = 246.99, ["exercise"] = "Chins"},

-- SitUps --    
{["x"] = -1109.03, ["y"] = -836.32, ["z"] = 26.85 - 0.98, ["h"] = 225.62, ["exercise"] = "Pushups"}, -- Politie
    {["x"] = -1110.43, ["y"] = -837.30, ["z"] = 26.85 - 0.98, ["h"] = 218.59, ["exercise"] = "Situps"}, -- Politie
    {["x"] = 256.58, ["y"] = -258.24, ["z"] = 59.93 - 0.98, ["h"] = 253.63, ["exercise"] = "Situps"},
    {["x"] = 253.61, ["y"] = -260.20, ["z"] = 59.93 - 0.98, ["h"] = 157.88, ["exercise"] = "Situps"},
    {["x"] = 256.71, ["y"] = -259.63, ["z"] = 59.93 - 0.98, ["h"] = 75.44, ["exercise"] = "Situps"},
-- PushUps --   
    {["x"] = 254.57, ["y"] = -257.77, ["z"] = 59.93 - 0.98, ["h"] = 150.14, ["exercise"] = "Pushups"},
    {["x"] = 255.84, ["y"] = -262.00, ["z"] = 59.93 - 0.98, ["h"] = 60.75, ["exercise"] = "Pushups"},
    {["x"] = 256.29, ["y"] = -260.87, ["z"] = 59.93 - 0.98, ["h"] = 60.75, ["exercise"] = "Pushups"},
    {["x"] = 1770.98, ["y"] = 2593.60, ["z"] = 45.80 - 0.98, ["h"] = 211.55, ["exercise"] = "Pushups"},
-- Loopband --    
    {["x"] = -1108.33, ["y"] = -839.45, ["z"] = 26.98 - 0.98, ["h"] = 124.11, ["exercise"] = "loopband"}, -- Politie
    {["x"] = -1107.48, ["y"] = -840.69, ["z"] = 26.98 - 0.98, ["h"] = 126.57, ["exercise"] = "loopband"}, -- Politie
    {["x"] = -1106.59, ["y"] = -841.93, ["z"] = 26.98 - 0.98, ["h"] = 124.11, ["exercise"] = "loopband"}, -- Politie
    {["x"] = -1105.71, ["y"] = -843.07, ["z"] = 26.98 - 0.98, ["h"] = 126.76, ["exercise"] = "loopband"}, -- Politie
    {["x"] = -1104.73, ["y"] = -844.27, ["z"] = 26.98 - 0.98, ["h"] = 134.60, ["exercise"] = "loopband"}, -- Politie
    {["x"] = 236.62, ["y"] = -261.73, ["z"] = 60.06 - 0.98, ["h"] = 65.57, ["exercise"] = "loopband"},
    {["x"] = 237.55, ["y"] = -259.26, ["z"] = 60.07 - 0.98, ["h"] = 56.38, ["exercise"] = "loopband"},
    {["x"] = 239.20, ["y"] = -257.51, ["z"] = 60.07 - 0.98, ["h"] = 46.07, ["exercise"] = "loopband"},
    {["x"] = 240.70, ["y"] = -256.51, ["z"] = 60.07 - 0.98, ["h"] = 32.50, ["exercise"] = "loopband"},
    {["x"] = 242.27, ["y"] = -255.61, ["z"] = 60.07 - 0.98, ["h"] = 18.49, ["exercise"] = "loopband"},
    {["x"] = 244.27, ["y"] = -255.21, ["z"] = 60.07 - 0.98, ["h"] = 5.28, ["exercise"] = "loopband"},
    {["x"] = 246.37, ["y"] = -255.33, ["z"] = 60.07 - 0.98, ["h"] = 355.91, ["exercise"] = "loopband"},
    {["x"] = 248.87, ["y"] = -255.96, ["z"] = 60.07 - 0.98, ["h"] = 335.63, ["exercise"] = "loopband"},
--Boksbal--
    {["x"] = -1099.76, ["y"] = -843.80, ["z"] = 26.83 - 0.98, ["h"] = 135.08, ["exercise"] = "boksbal"},  -- Politie
    {["x"] = 241.03, ["y"] = -269.48, ["z"] = 59.92 - 0.98, ["h"] = 177.59, ["exercise"] = "boksbal"},
    {["x"] = 251.50, ["y"] = -256.06, ["z"] = 59.92 - 0.98, ["h"] = 269.50, ["exercise"] = "boksbal"},

-- Weight --

    --{["x"] = -1206.76, ["y"] = -1572.93, ["z"] = 4.61 - 0.98, ["h"] = nil, ["exercise"] = "Pushups"},
    -- ^^ You can add more locations like this
}

Config.Blips = {
    [1] = {["x"] = 245.44, ["y"] = -263.12, ["z"] = 59.92, ["id"] = 311, ["color"] = 45, ["scale"] = 1.0, ["text"] = "Sportschool"},
}




local Keys = {["E"] = 38, ["SPACE"] = 22, ["DELETE"] = 178}
local canExercise = false
local exercising = false
local procent = 0
local motionProcent = 0
local doingMotion = false
local motionTimesDone = 0

Citizen.CreateThread(function()
    while true do
        local sleep = 500
        local coords = GetEntityCoords(PlayerPedId())
            for i, v in pairs(Config.Locations) do
                local pos = Config.Locations[i]
                local dist = GetDistanceBetweenCoords(pos["x"], pos["y"], pos["z"] + 0.98, coords, true)
                if dist <= 0.5 and not exercising then
                    sleep = 0
                    DrawText3D(pos["x"], pos["y"], pos["z"] + 0.98, "[E] " .. pos["exercise"])
                    if IsControlJustPressed(0, Keys["E"]) then
                        startExercise(Config.Exercises[pos["exercise"]], pos)
                    end
                    else if dist <= 3.0 and not exercising then
                        sleep = 0
                        DrawText3D(pos["x"], pos["y"], pos["z"] + 0.98, pos["exercise"])
                    end
                end
            end
        Citizen.Wait(sleep)
    end
end)

local dpEmotes = {}
local currentAnim = nil
dpEmotes.StartEmote = function(name)
    if name == currentAnim then
        return
    end
    local result = exports['dpemotes']:emoteStart(name)
    currentAnim = name
    return result
end

dpEmotes.CancelEmote = function()
    return exports['dpemotes']:emoteCancel()
end

AddEventHandler("dpemotes:EmoteCancelled", function(anim)
    currentAnim = nil
end)

function DoActionAnim(animInfo)
    local playerPed = PlayerPedId()
    if animInfo.actionDict and animInfo.actionAnim then
        TaskPlayAnim(playerPed, animInfo.actionDict, animInfo.actionAnim, 8.0, -8.0, animInfo.actionTime, 0, 0.0, 0, 0, 0)
    end
    if animInfo.dpActionAnim then
        dpEmotes.StartEmote(animInfo.dpActionAnim)
    end
end

function DoEnterAnim(animInfo)
    if animInfo.dpEnterAnim then
        dpEmotes.StartEmote(animInfo.dpEnterAnim)
    end
    if animInfo.enterDict and animInfo.enterAnim then
        TaskPlayAnim(playerPed, animInfo.enterDict, animInfo.enterAnim, 8.0, -8.0, animInfo.enterTime, 0, 0.0, 0, 0, 0)
    end
    if animInfo.enterTime then
        Citizen.Wait(animInfo.enterTime)
    end
end

function ExitTraining(animInfo)
    local playerPed = PlayerPedId()
    if animInfo.exitDict and animInfo.exitAnim then
        TaskPlayAnim(playerPed, animInfo.exitDict, animInfo.exitAnim, 8.0, -8.0, animInfo.exitTime, 0, 0.0, 0, 0, 0)
    end
    if currentAnim then
        dpEmotes.CancelEmote()
    end
    if animInfo.dpExitAnim then
        dpEmotes.StartEmote(animInfo.dpExitAnim)
    end
    if animInfo.exitTime then
        Citizen.Wait(animInfo.exitTime)
    end
    currentAnim = nil
    FreezeEntityPosition(playerPed, false)
    canExercise = false
    exercising = false
    procent = 0
end

function RestartAnimIfNeeded(animInfo)
    local playerPed = PlayerPedId()
    if animInfo.idleAnim and animInfo.idleDict then
        if not IsEntityPlayingAnim(playerPed, animInfo.idleDict, animInfo.idleAnim, 3) then
            TaskPlayAnim(playerPed, animInfo.idleDict, animInfo.idleAnim, 8.0, -8.0, -1, 0, 0.0, 0, 0, 0)
        end
    end
    if animInfo.dpIdleAnim then
        dpEmotes.StartEmote(animInfo.dpIdleAnim)
    end
end

function startExercise(animInfo, pos)
    local playerPed = PlayerPedId()

    LoadDict(animInfo.idleDict)
    LoadDict(animInfo.enterDict)
    LoadDict(animInfo.exitDict)
    LoadDict(animInfo.actionDict)

    if pos.h ~= nil then
        SetEntityHeading(playerPed, pos.h)
    end
    if pos.x ~= nil then
        SetEntityCoords(playerPed, pos.x, pos.y, pos.z)
    end
    if animInfo["freeze"] then
        FreezeEntityPosition(playerPed, true)
    end

    DoEnterAnim(animInfo)

    canExercise = true
    exercising = true

    Citizen.CreateThread(function()
        while exercising do
            Citizen.Wait(0)
            local color
            if procent <= 24.99 then
                color = "~r~"
            elseif procent <= 49.99 then
                color = "~o~"
            elseif procent <= 74.99 then
                color = "~b~"
            else
                color = "~g~"
            end
            DrawText2D(0.505, 0.925, 1.0,1.0,0.33, "Percentage: " .. color .. procent .. "%", 255, 255, 255, 255)
            DrawText2D(0.505, 0.95, 1.0,1.0,0.33, "Druk ~g~[SPACE]~w~ om te trainen", 255, 255, 255, 255)
            DrawText2D(0.505, 0.975, 1.0,1.0,0.33, "Druk ~r~[DELETE]~w~ om te stoppen met trainen", 255, 255, 255, 255)
        end
    end)

    Citizen.CreateThread(function()
        while canExercise do
            Citizen.Wait(0)
            local playerCoords = GetEntityCoords(playerPed)
            if procent <= 99 then
                RestartAnimIfNeeded(animInfo)
                if IsControlJustPressed(0, Keys["SPACE"]) then -- press space to exit training
                    canExercise = false
                    DoActionAnim(animInfo)
                    AddProcent(animInfo.actionProcent, animInfo.actionProcentTimes, animInfo.actionTime - 70)
                    canExercise = true
                end
                if IsControlJustPressed(0, Keys["DELETE"]) then -- press delete to exit training
                    ExitTraining(animInfo)
                end
            else
                ExitTraining(animInfo)
                TriggerServerEvent('stadus_skills:addStrength', GetPlayerServerId(PlayerId()), (math.random() + 0))
                TriggerServerEvent('stadus_skills:addStamina', GetPlayerServerId(PlayerId()), (math.random() + 0))
                -- Here u can put a event to update some sort of skill or something.
                -- this is when u finished your exercise
            end
        end
    end)
end

RegisterCommand("motion", function()
    motionProcent = 0
    doingMotion = not doingMotion  

    Citizen.CreateThread(function()
        while doingMotion do
            Citizen.Wait(0) 
            if IsPedSprinting(PlayerPedId()) then
                motionProcent = motionProcent + 9
            elseif IsPedRunning(PlayerPedId()) then
                motionProcent = motionProcent + 6
            elseif IsPedWalking(PlayerPedId()) then
                motionProcent = motionProcent + 3
            end
            
            DrawText2D(0.505, 0.95, 1.0,1.0,0.4, "~b~Percentage:~w~ " .. tonumber(string.format("%.1f", motionProcent/1000)) .. "%", 255, 255, 255, 255)
            if motionProcent >= 100000 then
                doingMotion = false
                motionProcent = 0
                Notify("Je hebt de hele trainingsessie ~g~gecomplete~w~.")
            end
        end
    end)

    if doingMotion then
        motionTimesDone = motionTimesDone + 1
        if motionTimesDone <= 2 then
            Notify("You ~y~started~w~ your motion session.")
            print(motionTimesDone)
        else
            Notify("You're too ~r~tired~w~ to do this!")
            doingMotion = false
        end
    else
        Notify("You ~r~stopped~w~ your motion session.")
    end
end)

function AddProcent(amount, amountTimes, time)
    for i=1, amountTimes do
        Citizen.Wait(time/amountTimes)
        procent = procent + amount
    end
end

function LoadDict(dict)
    if not dict then
        return
    end
    if not DoesAnimDictExist(dict) then
        error(("Anim dict %s doesn't exist!"):format(dict))
    end
    RequestAnimDict(dict)
	while not HasAnimDictLoaded(dict) do
	  	Citizen.Wait(500)
    end
end

function DrawText3D(x, y, z, text)
    local onScreen,_x,_y=World3dToScreen2d(x, y, z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 90)
end
      
function DrawText2D(x, y, width, height, scale, text, r, g, b, a, outline)
	SetTextFont(0)
	SetTextProportional(0)
	SetTextScale(scale, scale)
	SetTextColour(r, g, b, a)
	SetTextDropShadow(0, 0, 0, 0,255)
	SetTextEdge(1, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x - width/2, y - height/2 + 0.005)
end

Citizen.CreateThread(function()
    for i=1, #Config.Blips, 1 do
        local Blip = Config.Blips[i]
        blip = AddBlipForCoord(Blip["x"], Blip["y"], Blip["z"])
        SetBlipSprite(blip, Blip["id"])
        SetBlipDisplay(blip, 4)
        SetBlipScale(blip, Blip["scale"])
        SetBlipColour(blip, Blip["color"])
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(Blip["text"])
        EndTextCommandSetBlipName(blip)
    end
end)

function Notify(msg)
    SetNotificationTextEntry('STRING')
	AddTextComponentSubstringPlayerName(msg)
	DrawNotification(false, true)
end