ESX = nil

letsleep = false

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end

    while ESX.GetPlayerData().job == nil do
        Citizen.Wait(10)
    end

    PlayerData = ESX.GetPlayerData()
end) 


RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
  PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
  PlayerData.job = job
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(5)
        local ped = PlayerPedId()
        local pos = GetEntityCoords(ped)
        local inRange = false
        for k,v in pairs(JS.Location) do
            local dist = #(vector3(JS.Location[k].x, JS.Location[k].y, JS.Location[k].z) - pos)
            if dist < 3 then
                inRange = true
                if PlayerData.job ~= nil and PlayerData.job.name == 'police' or PlayerData.job ~= nil and PlayerData.job.name == 'kmar' then
                    DrawScriptText(vector3(JS.Location[k].x, JS.Location[k].y, JS.Location[k].z), '~p~E~w~ - Werk spullen')
                    if IsControlJustPressed(0, 38) then
                        policemenu()
                    end
                end
            end
        end
        if not inRange then Citizen.Wait(500) end
    end
end)

function policemenu()
    elements = {}
    for k,v in pairs(JS.ItemTable) do
        table.insert(elements, {
            value = k, label = v.label
        })
    end
    
    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'Politie',
    {
        title = 'Politiemenutjeenzo',
        align = 'bottom-right',
        elements = elements
    }, function(data, menu)
        for k,v in pairs(JS.ItemTable) do
            if k == data.current.value then
                TriggerServerEvent('js-policenpc:server:pak', k)
                ESX.ShowNotification('Je hebt een: '.. v.label .. ' gepakt.')
                break
            end
        end

        menu.close()
    end, function(data,menu)
        menu.close()
    end)
end



local NPC = {
	{seller = true, model = "s_m_y_ranger_01", x = -1099.85,  y = -824.81,  z = 13.28, h = 218.34},
    {seller = true, model = "s_m_y_ranger_01", x = 1853.29,  y = 3689.31,  z = 33.26, h = 209.68},
}
Citizen.CreateThread(function()
    while ESX == nil do
	TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
	Citizen.Wait(0)
    end
    for _, v in pairs(NPC) do
        RequestModel(GetHashKey(v.model))
        while not HasModelLoaded(GetHashKey(v.model)) do
            Wait(1)
        end
        local npc = CreatePed(4, v.model, v.x, v.y, v.z, v.h,  false, true)
        SetPedFleeAttributes(npc, 0, 0)
        SetPedDropsWeaponsWhenDead(npc, false)
        SetPedDiesWhenInjured(npc, false)
        SetEntityInvincible(npc , true)
        FreezeEntityPosition(npc, true)
        SetBlockingOfNonTemporaryEvents(npc, true)
        if v.seller then 
            RequestAnimDict("missfbi_s4mop")
            while not HasAnimDictLoaded("missfbi_s4mop") do
                Wait(1)
            end
            TaskPlayAnim(npc, "missfbi_s4mop" ,"smoke" ,8.0, 1, -1, 49, 0, false, false, false)
        else
            GiveWeaponToPed(npc, GetHashKey("WEAPON_ADVANCEDRIFLE"), 2800, true, true)
        end
    end
end)

function DrawScriptText(coords, text)
    local onScreen, _x, _y = World3dToScreen2d(coords["x"], coords["y"], coords["z"])

    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(127, 3, 252, 255)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x, _y)

    local factor = string.len(text) / 370

    DrawRect(_x, _y + 0.0125, 0.015 + factor, 0.03, 0, 0, 0, 65)
end