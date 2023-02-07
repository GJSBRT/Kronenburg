ESX = nil
Citizen.CreateThread(function()
	Citizen.Wait(5000)

	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
        	Citizen.Wait(1000)
   	end

	while ESX.GetPlayerData().faction == nil do
		Citizen.Wait(100)
	end
	
	PlayerData = ESX.GetPlayerData()
end)

VenteCocaine = {
    vector3(5269.63, -5413.93, 65.49),
    vector3(5147.79, -5197.2, 2.78)
}

function RandomVente()
    local index = GetRandomIntInRange(1, #VenteCocaine)
    return VenteCocaine[index]
end

VenteSolvants = {
    vector3(4994.39, -5182.04, 2.45),
    vector3(4913.77, -5319.89, 8.59)
}

function RandomVenteSolvants()
    local index = GetRandomIntInRange(1, #VenteSolvants)
    return VenteSolvants[index]
end

VenteCannabis = {
    vector3(4829.95, -5430.81, 16.49),
    vector3(5250.83, -5380.33, 59.53)
}

function RandomVenteCannabis()
    local index = GetRandomIntInRange(1, #VenteCannabis)
    return VenteCannabis[index]
end

function venteCocaine()
    local ped = GetPlayerPed(-1)
    RequestModel(GetHashKey("a_m_o_tramp_01"))
    while not HasModelLoaded(GetHashKey("a_m_o_tramp_01")) do
        Wait(1)
    end
    NpcSpawnCoords = RandomVente()
    npc = CreatePed(4, GetHashKey("a_m_o_tramp_01"), NpcSpawnCoords.x, NpcSpawnCoords.y, NpcSpawnCoords.z-1, 143.21, false, false)	
    TaskWanderStandard(npc, 10.0, 10)
    SetEntityInvincible(npc, true)
    local blip = AddBlipForEntity(npc)
    SetBlipSprite(blip, 66)
    SetBlipColour(blip, 1)
    SetBlipScale(blip, 0.85)
    SetBlipRoute(blip, true)
    ESX.ShowNotification("Het is goed dat ik een contactpersoon heb aan wie je je ~y~Heroine ~w~kunt verkopen, ik heb dat op je GPS gezet!")
    close = false
    while close == false do
        PedCoord = GetEntityCoords(npc)
        PlayerCoord = GetEntityCoords(ped)

        local distanceNPC = GetDistanceBetweenCoords(PedCoord, PlayerCoord, true)
        if distanceNPC <= 2.5 then
            ESX.ShowHelpNotification("Serieus, ben je mijn dope? Verdomme je redt het wel bro!")
            TaskWanderStandard(npc, 10.0, 10)
            RemoveBlip(blip)
            TriggerServerEvent("Illegal:VenteCocaine")
            SetPedAsNoLongerNeeded(npc)
            SetEntityAsNoLongerNeeded(npc)
            close = true
        end
        Wait(100)
    end
    _menuPool3:CloseAllMenus()
end

function venteSolvants()
    local ped = GetPlayerPed(-1)
    RequestModel(GetHashKey("a_m_y_business_03"))
    while not HasModelLoaded(GetHashKey("a_m_y_business_03")) do
        Wait(1)
    end
    NpcSpawnCoords = RandomVenteSolvants()
    npc = CreatePed(4, GetHashKey("a_m_y_business_03"), NpcSpawnCoords.x, NpcSpawnCoords.y, NpcSpawnCoords.z-1, 143.21, false, false)	
    TaskWanderStandard(npc, 10.0, 10)
    SetEntityInvincible(npc, true)
    local blip = AddBlipForEntity(npc)
    SetBlipSprite(blip, 66)
    SetBlipColour(blip, 1)
    SetBlipScale(blip, 0.85)
    SetBlipRoute(blip, true)
    ESX.ShowNotification("Hier is een zakenman aan wie je je ~y~XTC ~w~kunt verkopen, dat heb ik op je GPS gezet!")
    close = false
    while close == false do
        PedCoord = GetEntityCoords(npc)
        PlayerCoord = GetEntityCoords(ped)

        local distanceNPC = GetDistanceBetweenCoords(PedCoord, PlayerCoord, true)
        if distanceNPC <= 2.5 then
            ESX.ShowHelpNotification("Zoals afgesproken, hier is je geld!")
            TaskWanderStandard(npc, 10.0, 10)
            RemoveBlip(blip)
            TriggerServerEvent("Illegal:VenteSolvants")
            SetPedAsNoLongerNeeded(npc)
            SetEntityAsNoLongerNeeded(npc)
            close = true
        end
        Wait(100)
    end
    _menuPool3:CloseAllMenus()
end

function venteCannabis()
    local ped = GetPlayerPed(-1)
    RequestModel(GetHashKey("a_m_o_soucent_03"))
    while not HasModelLoaded(GetHashKey("a_m_o_soucent_03")) do
        Wait(1)
    end
    NpcSpawnCoords = RandomVenteCannabis()
    npc = CreatePed(4, GetHashKey("a_m_o_soucent_03"), NpcSpawnCoords.x, NpcSpawnCoords.y, NpcSpawnCoords.z-1, 143.21, false, false)	
    TaskWanderStandard(npc, 10.0, 10)
    SetEntityInvincible(npc, true)
    local blip = AddBlipForEntity(npc)
    SetBlipSprite(blip, 66)
    SetBlipColour(blip, 1)
    SetBlipScale(blip, 0.85)
    SetBlipRoute(blip, true)
    ESX.ShowNotification("Fijn dat ik een contactpersoon heb aan wie je je ~y~Hasj zakjes ~w~kunt verkopen, check je GPS!")
    close = false
    while close == false do
        PedCoord = GetEntityCoords(npc)
        PlayerCoord = GetEntityCoords(ped)

        local distanceNPC = GetDistanceBetweenCoords(PedCoord, PlayerCoord, true)
        if distanceNPC <= 2.5 then
            ESX.ShowHelpNotification("Ik hoop dat het goed zebi!")
            TaskWanderStandard(npc, 10.0, 10)
            RemoveBlip(blip)
            TriggerServerEvent("Illegal:VenteCannabis")
            SetPedAsNoLongerNeeded(npc)
            SetEntityAsNoLongerNeeded(npc)
            close = true
        end
        Wait(100)
    end
    _menuPool3:CloseAllMenus()
end

RegisterNetEvent("Illegal:VenteNotifCocaine")
AddEventHandler("Illegal:VenteNotifCocaine", function(nombre, prix)
    PlayMissionCompleteAudio("TREVOR_SMALL_01")
    ESX.Scaleform.ShowFreemodeMessage("~o~Verkoop van Heroine", "~y~Je verkocht "..nombre.." voor "..prix.."$", 5)
end)

RegisterNetEvent("Illegal:VenteNotifolvants")
AddEventHandler("Illegal:VenteNotifSolvants", function(nombre, prix)
    PlayMissionCompleteAudio("TREVOR_SMALL_01")
    ESX.Scaleform.ShowFreemodeMessage("~o~Verkoop van XTC", "~y~Je verkocht "..nombre.." voor "..prix.."$", 5)
end)

RegisterNetEvent("Illegal:VenteNotifCannabis")
AddEventHandler("Illegal:VenteNotifCannabis", function(nombre, prix)
    PlayMissionCompleteAudio("TREVOR_SMALL_01")
    ESX.Scaleform.ShowFreemodeMessage("~o~Verkoop van Hasj zakjes", "~y~Je verkocht "..nombre.." voor "..prix.."$", 5)
end)