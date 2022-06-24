
--template for message
local formatOfMessage = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(253,174,15,0.6); border-radius: 3px;"><i class="fas fa-hands-helping"></i> {1}</div>'
local acceptmessage = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(80,220,100,0.6); border-radius: 3px;"><i class="fas fa-hands-helping"></i> {1}</div>'
local usergroup = 'user'

local ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) 
            ESX = obj 
        end)
        Citizen.Wait(0)
    end

    while ESX.GetPlayerData().job == nil do
        Citizen.Wait(100)
    end

    ESX.TriggerServerCallback("esx_report:fetchUserRank", function(group)
        usergroup = group
    end)

    TriggerEvent('chat:addSuggestion', '/report', 'Vraag een stafflid om hulp', {
        { name="bericht", help= 'Bericht word verzonden naar de staff' }
    })


    TriggerEvent('chat:addSuggestion', '/assist', 'Vraag een stafflid om hulp', {
        { name="bericht", help= 'Bericht word verzonden naar de staff' }
    })

    TriggerEvent('chat:addSuggestion', '/hulp', 'Vraag een stafflid om hulp', {
        { name="bericht", help= 'Bericht word verzonden naar de staff' }
    })


end)

RegisterNetEvent("esx_report:textmsg")
AddEventHandler('esx_report:textmsg', function(source, textmsg, names2, names3 )
    local message = names3 .."  "..": " .. textmsg
    local name = "Reply"
    TriggerEvent('chat:addMessage', {
        template = formatOfMessage, 
        args = { name, message }
    })
end)


RegisterNetEvent('esx_report:sendReply')
AddEventHandler('esx_report:sendReply', function(source, textmsg, names2, names3 ) 
    if usergroup ~= Config.defaultUserGroup then
        local message = names3 .." -> " .. names2 ..":  " .. textmsg
        local name = "Reply"
        
        TriggerEvent('chat:addMessage', {
            template = formatOfMessage, 
            args = { name, message }
        })
        
    end
end)

RegisterNetEvent('esx_report:accept')
AddEventHandler('esx_report:accept', function(source, textmsg, names2, names3 ) 
    if usergroup ~= Config.defaultUserGroup then
        local message = names3 .." Heeft de report van " .. names2 .." geaccepteerd"
        local name = "Geaccepteerd"
        
        TriggerEvent('chat:addMessage', {
            template = acceptmessage, 
            args = { name, message }
        })
        
    end
end)

RegisterNetEvent('esx_report:sendReport')
AddEventHandler('esx_report:sendReport', function(id, name, message)
    local myId = PlayerId()
    local pid = GetPlayerFromServerId(id)
    
    if pid == myId then
        local name = "Report"
        
        TriggerEvent('chat:addMessage', {
            template = formatOfMessage,
            args = { name, "Het bericht is verzonden naar het staffteam van Kronenburg!" }
        })
    end
    
    if usergroup ~= 'user' then
        local message =  "[".. id .."]" .. name .."  "..": " .. message
        local name = "Report"
        
        TriggerEvent('chat:addMessage', {
            template = formatOfMessage,
            args = { name, message }
        })
        
    end
end)

















local jailed = false
local jailProp1 = false
local jailProp2 = false
local jailProp3 = false
local jailProp4 = false
function JailMe()  
    local modelHash = 'prop_dog_cage_02'
    if not HasModelLoaded(modelHash) then
        -- If the model isnt loaded we request the loading of the model and wait that the model is loaded
        RequestModel(modelHash)

        while not HasModelLoaded(modelHash) do
            Citizen.Wait(1)
        end
    end
    FreezeEntityPosition(PlayerPedId(-1), true)
    local myCoords = GetEntityCoords(PlayerPedId(-1))
    local model = 'a_c_crow'
    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(0)
    end
    SetPlayerModel(PlayerId(), model)
    Citizen.Wait(50)
 
   -- jailProp1 = CreateObject(modelHash, myCoords.x, myCoords.y, myCoords.z, 1)
    jailCoord = GetEntityCoords(jailProp1)
    PlaceObjectOnGroundProperly(jailProp1)
    FreezeEntityPosition(jailProp1, true)
    SetEntityInvincible(PlayerPedId(-1), true)
    SetEntityHealth(PlayerId(), 200)
    --SetEntityCoords(PlayerPedId(-1), vector3(jailCoord.x, jailCoord.y, jailCoord.z-1.1))
end

function UnjailMe()
    --DeleteObject(jailProp1)
    
    SetEntityInvincible(PlayerPedId(-1), false)
    FreezeEntityPosition(PlayerPedId(-1), false)
    ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
        local model = nil
 
        if skin.sex == 0 then
          model = GetHashKey("mp_m_freemode_01")
        else
          model = GetHashKey("mp_f_freemode_01")
        end

        RequestModel(model)
        while not HasModelLoaded(model) do
          RequestModel(model)
          Citizen.Wait(1)
        end

        SetPlayerModel(PlayerId(), model)
        SetModelAsNoLongerNeeded(model)

        TriggerEvent('skinchanger:loadSkin', skin)
        TriggerEvent('esx:restoreLoadout')
        local playerPed = GetPlayerPed(-1)
        ClearPedBloodDamage(playerPed)
        ResetPedVisibleDamage(playerPed)
        ClearPedLastWeaponDamage(playerPed)
    end)
end
local function DrawText3D(x, y, z, text)
	SetTextScale(0.35, 0.35)
	SetTextFont(4)
	SetTextProportional(1)
	SetTextColour(255, 255, 255, 215)
	SetTextEntry("STRING")
	SetTextCentre(true)
	AddTextComponentString(text)
	SetDrawOrigin(x,y,z, 0)
	DrawText(0.0, 0.0)
	local factor = (string.len(text)) / 370
	DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
	ClearDrawOrigin()
end


RegisterNetEvent("zutphen::admin::jailed")
AddEventHandler("zutphen::admin::jailed", function(time)
    Citizen.CreateThread(function()
        print(time)
        time = tonumber(math.floor(time * 1000))
        
        print(time)
        JailMe()
        Citizen.Wait(time)
        print(time)
        UnjailMe()

    end)
end)