-- polo © License | Discord : https://discord.gg/czW6Jqj
ESX = nil
local PlayersHarvesting = {}
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local function Harvest30(source, zone)
    local xPlayer = ESX.GetPlayerFromId(source)
    local xItem1 = xPlayer.getInventoryItem('shovel') -- Item 1
    
    if xItem1.count > 0 then  -- Item 1  count 
            TriggerClientEvent('drug1:animation' , source) -- Play animation
            Citizen.Wait(10000) -- Time progress , in ms, 1 second = 1000 ms , the value is 10000 so , its 10 seconds
            xPlayer.addInventoryItem('cannabis', 5)    -- add the combination Items
        else 
            TriggerClientEvent('esx:showNotification', source, 'Je hebt geen ~g~Schep~w~.')
        end
	end

RegisterServerEvent('polo_cayo_drugs:startHarvest30')
AddEventHandler('polo_cayo_drugs:startHarvest30', function(zone)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(source)
  	
		PlayersHarvesting[_source]=true
		TriggerClientEvent('esx:showNotification', _source, 'Je bent ~g~Hasj ~w~aan het plukken')
		TriggerClientEvent('drugs1:animation' , source) -- Play animation 
		Harvest30(_source,zone)
end)

local function Harvest31(source, zone)
    local xPlayer = ESX.GetPlayerFromId(source)
    local xItem1 = xPlayer.getInventoryItem('cannabis') -- Item 1
    
    if xItem1.count > 0 then  -- Item 1  count
            TriggerClientEvent('drugs2:animation2' , source) -- Play animation 
            Citizen.Wait(10000) -- Time progress , in ms, 1 second = 1000 ms , the value is 10000 so , its 10 seconds
            xPlayer.addInventoryItem('cannabis_pooch', 1)    -- add the combination Items
            xPlayer.removeInventoryItem('cannabis', 5)
        else 
            TriggerClientEvent('esx:showNotification', source, 'Je hebt geen x5 ~b~Hasj.')
        end
	end

RegisterServerEvent('polo_cayo_drugs:startHarvest31')
AddEventHandler('polo_cayo_drugs:startHarvest31', function(zone)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(source)
  	
		PlayersHarvesting[_source]=true
		TriggerClientEvent('esx:showNotification', _source, '~g~Hasj ~w~verwerken')
		Harvest31(_source,zone)
end)

local function Harvest32(source, zone)
    local xPlayer = ESX.GetPlayerFromId(source)
    
            TriggerClientEvent('drug2:animation2' , source) -- Play animation
            Citizen.Wait(10000) -- Time progress , in ms, 1 second = 1000 ms , the value is 10000 so , its 10 seconds
            xPlayer.addInventoryItem('solvants', 5)    -- add the combination Items
    end

RegisterServerEvent('polo_cayo_drugs:startHarvest32')
AddEventHandler('polo_cayo_drugs:startHarvest32', function(zone)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    
        PlayersHarvesting[_source]=true
        TriggerClientEvent('esx:showNotification', _source, 'Je bent ~g~MDMA ~w~aan het verzamelen')
        TriggerClientEvent('drugs2:animation2' , source) -- Play animation 
        Harvest32(_source,zone)
end)

local function Harvest33(source, zone)
    local xPlayer = ESX.GetPlayerFromId(source)
    local xItem1 = xPlayer.getInventoryItem('solvants') -- Item 1
    
    if xItem1.count > 0 then  -- Item 1  count
            TriggerClientEvent('drugs2:animation2' , source) -- Play animation 
            Citizen.Wait(10000) -- Time progress , in ms, 1 second = 1000 ms , the value is 10000 so , its 10 seconds
            xPlayer.addInventoryItem('solvants_pooch', 3)    -- add the combination Items
            xPlayer.removeInventoryItem('solvants', 5)
        else 
            TriggerClientEvent('esx:showNotification', source, 'Je hebt niet x5 ~b~MDMA.')
        end
    end

RegisterServerEvent('polo_cayo_drugs:startHarvest33')
AddEventHandler('polo_cayo_drugs:startHarvest33', function(zone)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    
        PlayersHarvesting[_source]=true
        TriggerClientEvent('esx:showNotification', _source, 'Je bent ~b~MDMA ~w~aan het verwerken')
        Harvest33(_source,zone)
end)

local function Harvest34(source, zone)
    local xPlayer = ESX.GetPlayerFromId(source)
    
            TriggerClientEvent('drug2:animation2' , source) -- Play animation
            Citizen.Wait(10000) -- Time progress , in ms, 1 second = 1000 ms , the value is 10000 so , its 10 seconds
            xPlayer.addInventoryItem('cocaine', 5)    -- add the combination Items
    end

RegisterServerEvent('polo_cayo_drugs:startHarvest34')
AddEventHandler('polo_cayo_drugs:startHarvest34', function(zone)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    
        PlayersHarvesting[_source]=true
        TriggerClientEvent('esx:showNotification', _source, 'Je bent ~r~Opium ~w~aan het verzamelen')
        TriggerClientEvent('drugs2:animation2' , source) -- Play animation 
        Harvest34(_source,zone)
end)

local function Harvest35(source, zone)
    local xPlayer = ESX.GetPlayerFromId(source)
    local xItem1 = xPlayer.getInventoryItem('cocaine') -- Item 1
    
    if xItem1.count > 0 then  -- Item 1  count
            TriggerClientEvent('drugs2:animation2' , source) -- Play animation 
            Citizen.Wait(10000) -- Time progress , in ms, 1 second = 1000 ms , the value is 10000 so , its 10 seconds
            xPlayer.addInventoryItem('cocaine_pooch', 2)    -- add the combination Items
            xPlayer.removeInventoryItem('cocaine', 5)
        else 
            TriggerClientEvent('esx:showNotification', source, 'Je hebt niet x5 ~r~Opium~w~.')
        end
    end

RegisterServerEvent('polo_cayo_drugs:startHarvest35')
AddEventHandler('polo_cayo_drugs:startHarvest35', function(zone)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    
        PlayersHarvesting[_source]=true
        TriggerClientEvent('esx:showNotification', _source, 'Je bent ~r~Opium ~w~aan het verwerken')
        Harvest35(_source,zone)
end)