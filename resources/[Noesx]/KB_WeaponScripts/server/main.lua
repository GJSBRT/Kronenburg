ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


-- Onderwereld --


ESX.RegisterUsableItem('pistol_clip', function(source)
	TriggerClientEvent('esx_weaponscanner:checkweaponpistol', source)
end)
	
ESX.RegisterUsableItem('rifle_clip', function(source)
	TriggerClientEvent('esx_weaponscanner:checkweaponrifle', source)
end)

ESX.RegisterUsableItem('smg_clip', function(source)
	TriggerClientEvent('esx_weaponscanner:checkweaponsmg', source)
end)

ESX.RegisterUsableItem('shotgun_clip', function(source)
	TriggerClientEvent('esx_weaponscanner:checkweaponshotgun', source)
end)

RegisterServerEvent("esx_weaponscanner:GeefDePistolAmmo")
AddEventHandler("esx_weaponscanner:GeefDePistolAmmo", function(currentWeaponHash)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	xPlayer.removeInventoryItem('pistol_clip', 1)

	xPlayer.addWeaponAmmo(currentWeaponHash, 12)
end)


RegisterServerEvent("esx_weaponscanner:GeefDeRifleAmmo")
AddEventHandler("esx_weaponscanner:GeefDeRifleAmmo", function(currentWeaponHash)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	xPlayer.addWeaponAmmo(currentWeaponHash, 30)

	xPlayer.removeInventoryItem('rifle_clip', 1)
end)


RegisterServerEvent("esx_weaponscanner:GeefDeSMGAmmo")
AddEventHandler("esx_weaponscanner:GeefDeSMGAmmo", function(currentWeaponHash)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	xPlayer.addWeaponAmmo(currentWeaponHash, 20)

	xPlayer.removeInventoryItem('smg_clip', 1)
end)


RegisterServerEvent("esx_weaponscanner:GeefDeShotgunmmo")
AddEventHandler("esx_weaponscanner:GeefDeShotgunAmmo", function(currentWeaponHash)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	xPlayer.addWeaponAmmo(currentWeaponHash, 8)

	xPlayer.removeInventoryItem('shotgun_clip', 1)
end)



-- Politie --------

ESX.RegisterUsableItem('pistol_police_clip', function(source)
	TriggerClientEvent('esx_weaponscanner:checkpoliceweaponpistol', source)
end)

ESX.RegisterUsableItem('smg_police_clip', function(source)
	TriggerClientEvent('esx_weaponscanner:checkpoliceweaponsmg', source)
end)

ESX.RegisterUsableItem('rifle_police_clip', function(source)
	TriggerClientEvent('esx_weaponscanner:checkpoliceweaponrifle', source)
end)


RegisterServerEvent("esx_weaponscanner:GeefDePolicePistolAmmo")
AddEventHandler("esx_weaponscanner:GeefDePolicePistolAmmo", function(currentWeaponHash)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	xPlayer.removeInventoryItem('pistol_police_clip', 1)

	xPlayer.addWeaponAmmo(currentWeaponHash, 12)
end)

RegisterServerEvent("esx_weaponscanner:GeefDePoliceRifleAmmo")
AddEventHandler("esx_weaponscanner:GeefDePoliceRifleAmmo", function(currentWeaponHash)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	xPlayer.addWeaponAmmo(currentWeaponHash, 30)

	xPlayer.removeInventoryItem('rifle_police_clip', 1)
end)

RegisterServerEvent("esx_weaponscanner:GeefDePoliceSMGAmmo")
AddEventHandler("esx_weaponscanner:GeefDePoliceSMGAmmo", function(currentWeaponHash)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	xPlayer.addWeaponAmmo(currentWeaponHash, 20)

	xPlayer.removeInventoryItem('smg_police_clip', 1)
end)