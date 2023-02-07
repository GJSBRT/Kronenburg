ESX = nil
local CannabisTraiter = 0
local CocaineTraiter = 0
local SolvantsTraiter = 0
local npcCooords = {coords = vector3(4836.26, -5177.27, 2.18)}

function RandomSpawnNPC()
    local index = GetRandomIntInRange(1, #NpcCannabisSpawn)
    return NpcCannabisSpawn[index]
end

function RandomSpawnNPC()
    local index = GetRandomIntInRange(1, #NpcCocaineSpawn)
    return NpcOpiumSpawn[index]
end

function RandomSpawnNPC()
    local index = GetRandomIntInRange(1, #NpcSolvantsSpawn)
    return NpcWeedSpawn[index]
end

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
	PlayerData = ESX.GetPlayerData()
end)

_menuPool3 = NativeUI.CreatePool()
NatveVehMenu = NativeUI.CreateMenu("VERKOOP", "~b~Drugs.")
_menuPool3:Add(NatveVehMenu)



function GetNPC(_npc)
    npc_ = _npc
end

function menuIllegal(menu)
    local Cocaine = NativeUI.CreateItem("Verkoop je Heroine", "")
    Cocaine:RightLabel("🧪")
    menu:AddItem(Cocaine)

    local Solvants = NativeUI.CreateItem("Verkoop je XTC", "")
    Solvants:RightLabel("💊")
    menu:AddItem(Solvants)

    local Cannabis = NativeUI.CreateItem("verkoop je Hasj zakjes", "")
    Cannabis:RightLabel("🌿")
    menu:AddItem(Cannabis)

    menu.OnItemSelect = function(sender, item, index)
        if item == Cocaine then
                PlaySoundFrontend(-1, "CHALLENGE_UNLOCKED", "HUD_AWARDS", 1)
                TriggerServerEvent("Illegal:Cocaine", CocaineTraiter)
                _menuPool3:CloseAllMenus()
                venteCocaine()
        end
    menu.OnItemSelect = function(sender, item, index)
        if item == Solvants then
                PlaySoundFrontend(-1, "CHALLENGE_UNLOCKED", "HUD_AWARDS", 1)
                TriggerServerEvent("Illegal:Solvants", SolvantsTraiter)
                _menuPool3:CloseAllMenus()
                venteSolvants()
        end
    menu.OnItemSelect = function(sender, item, index)
        if item == Cannabis then
                PlaySoundFrontend(-1, "CHALLENGE_UNLOCKED", "HUD_AWARDS", 1)
                TriggerServerEvent("Illegal:Cannabis", CannabisTraiter)
                _menuPool3:CloseAllMenus()
                venteCannabis()
        end
    end
    end
    end
end

local count = 0
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        while ESX == nil do
            Citizen.Wait(10)
        end
        _menuPool3:ProcessMenus()
        
        if count == 0 then
            menuIllegal(NatveVehMenu)
            count = 1
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        if not _menuPool3:IsAnyMenuOpen() then
            NatveVehMenu:Clear()
            menuIllegal(NatveVehMenu)
        end
        Wait(1000)
    end
end)


_menuPool3:RefreshIndex()
_menuPool3:MouseControlsEnabled (false);
_menuPool3:MouseEdgeEnabled (false);
_menuPool3:ControlDisablingEnabled(false);

function OuvrirMenuMission(station)
    NatveVehMenu:Visible(not NatveVehMenu:Visible())
end