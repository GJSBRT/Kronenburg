--[[ 
	Kronenburg Roleplay
	Copyright © GJSBRT <g@gijs.eu>

	This project is licensed under the terms of the Apache License 2.0 license.
	https://choosealicense.com/licenses/apache-2.0/
]]
 
 
ESX.RegisterCommand('setcoords', 'admin', function(xPlayer, args, showError)
	xPlayer.setCoords({x = args.x, y = args.y, z = args.z})
end, false, {help = _U('command_setcoords'), validate = true, arguments = {
	{name = 'x', help = _U('command_setcoords_x'), type = 'number'},
	{name = 'y', help = _U('command_setcoords_y'), type = 'number'},
	{name = 'z', help = _U('command_setcoords_z'), type = 'number'}
}})

ESX.RegisterCommand('setjob', 'staff_hoofdstaff', function(xPlayer, args, showError)
	if (xPlayer ~= nil or xPlayer ~= false) then
		exports['KB_Logger']:DiscordLog("https://discord.com/api/webhooks/942070213808123984/KAf7UhFf_vymp1h8shEmg9GgGeGLYoFRB9nLKsqXSHIpGY8_MZIt8y9r3Sy21Mw7IV64", "**Set Job (/setjob)**", "Speler: `"..GetPlayerName(xPlayer.source).."`\nJob: `"..args.job.."`", false)
	end

	if ESX.DoesJobExist(args.job, args.grade) then
		args.playerId.setJob(args.job, args.grade)
	else
		showError(_U('command_setjob_invalid'))
	end
end, true, {help = _U('command_setjob'), validate = true, arguments = {
	{name = 'playerId', help = _U('commandgeneric_playerid'), type = 'player'},
	{name = 'job', help = _U('command_setjob_job'), type = 'string'},
	{name = 'grade', help = _U('command_setjob_grade'), type = 'number'}
}})

ESX.RegisterCommand('setjob2', 'staff_hoofdstaff', function(xPlayer, args, showError)
	if (xPlayer ~= nil or xPlayer ~= false) then
		exports['KB_Logger']:DiscordLog("https://discord.com/api/webhooks/942070213808123984/KAf7UhFf_vymp1h8shEmg9GgGeGLYoFRB9nLKsqXSHIpGY8_MZIt8y9r3Sy21Mw7IV64", "**Set Job 2 (/setjob)**", "Speler: `"..GetPlayerName(xPlayer.source).."`\nJob: `"..args.job2.."`", false)
	end

	if ESX.DoesJobExist(args.job2, args.grade2) then
		args.playerId.setJob2(args.job2, args.grade2)
	else
		showError(_U('command_setjob_invalid'))
	end
end, true, {help = _U('command_setjob'), validate = true, arguments = {
	{name = 'playerId', help = _U('commandgeneric_playerid'), type = 'player'},
	{name = 'job2', help = _U('command_setjob_job'), type = 'string'},
	{name = 'grade2', help = _U('command_setjob_grade'), type = 'number'}
}})

ESX.RegisterCommand('car', 'staff_mod', function(xPlayer, args, showError)
	if not args.car then args.car = "urus" end
	if (xPlayer ~= nil or xPlayer ~= false) then
		exports['KB_Logger']:DiscordLog("https://discord.com/api/webhooks/942069557219184661/PqrCqigoBMjSsVfoGD0_cMyA7B-LjCsqAGjyzqdNYBkL1OsJMBr0NEfN5PbWmNnkB_Gs", "**Spawn auto (/car)**", "Speler: `"..GetPlayerName(xPlayer.source).."`\nAuto: `"..args.car.."`", false)
	end
	xPlayer.triggerEvent('esx:spawnVehicle', args.car)
end, false, {help = _U('command_car'), validate = false, arguments = {
	{name = 'car', help = _U('command_car_car'), type = 'any'}
}})

ESX.RegisterCommand({'cardel', 'dv'}, 'staff_mod', function(xPlayer, args, showError)
	if (xPlayer ~= nil or xPlayer ~= false) then
		exports['KB_Logger']:DiscordLog("https://canary.discord.com/api/webhooks/979690722578022410/C4mehzan8zywPtWinbV8bM-o954RogiGnlQwsfb_d2eStMI46R16o3q3xiOCCqziFz8e", "**Verwijder Auto (/dv)**", "Speler: `"..GetPlayerName(xPlayer.source).."`", false)
	end

	if not args.radius then args.radius = 4 end
	xPlayer.triggerEvent('esx:deleteVehicle', args.radius)
end, false, {help = _U('command_cardel'), validate = false, arguments = {
	{name = 'radius', help = _U('command_cardel_radius'), type = 'any'}
}})

ESX.RegisterCommand('setaccountmoney', 'staff_hoofdstaff', function(xPlayer, args, showError)
	if (xPlayer ~= nil or xPlayer ~= false) then
		exports['KB_Logger']:DiscordLog("https://discord.com/api/webhooks/942070701668581426/Py0NN6QoqskoxT13VlzK4bk6DV7XcSG44VvnhHPOd4jzv7zDD-v333xjzeKdPoZi4BfL", "**setAccountMoney**", "Speler: `"..GetPlayerName(xPlayer.source).."`\nBedrag: `"..args.amount.."`", false)
	end

	if args.playerId.getAccount(args.account) then
		args.playerId.setAccountMoney(args.account, args.amount)
	else
		showError(_U('command_giveaccountmoney_invalid'))
	end
end, true, {help = _U('command_setaccountmoney'), validate = true, arguments = {
	{name = 'playerId', help = _U('commandgeneric_playerid'), type = 'player'},
	{name = 'account', help = _U('command_giveaccountmoney_account'), type = 'string'},
	{name = 'amount', help = _U('command_setaccountmoney_amount'), type = 'number'}
}})

ESX.RegisterCommand('giveaccountmoney', 'staff_hoofdstaff', function(xPlayer, args, showError)
	if (xPlayer ~= nil or xPlayer ~= false) then
		exports['KB_Logger']:DiscordLog("https://discord.com/api/webhooks/942070701668581426/Py0NN6QoqskoxT13VlzK4bk6DV7XcSG44VvnhHPOd4jzv7zDD-v333xjzeKdPoZi4BfL", "**giveAccountMoney**", "Speler: `"..GetPlayerName(xPlayer.source).."`\nBedrag: `"..args.amount.."`", false)
	end

	if args.playerId.getAccount(args.account) then
		args.playerId.addAccountMoney(args.account, args.amount)
	else
		showError(_U('command_giveaccountmoney_invalid'))
	end
end, true, {help = _U('command_giveaccountmoney'), validate = true, arguments = {
	{name = 'playerId', help = _U('commandgeneric_playerid'), type = 'player'},
	{name = 'account', help = _U('command_giveaccountmoney_account'), type = 'string'},
	{name = 'amount', help = _U('command_giveaccountmoney_amount'), type = 'number'}
}})

ESX.RegisterCommand('giveitem', 'staff_admin', function(xPlayer, args, showError)
	if (xPlayer ~= nil or xPlayer ~= false) then
		exports['KB_Logger']:DiscordLog("https://discord.com/api/webhooks/942071093664055397/hWwztD-V0NY6rKQ2CoE2hctUDc6ssHbfBDKKJbXunzAKk4Q-X1euT573KDEIhmE7rzAZ", "**Geef Item (/giveitem)**", "Speler: `"..GetPlayerName(xPlayer.source).."`\nItem: `"..args.item.."("..args.count..")`", false)
	end

	args.playerId.addInventoryItem(args.item, args.count)
end, true, {help = _U('command_giveitem'), validate = true, arguments = {
	{name = 'playerId', help = _U('commandgeneric_playerid'), type = 'player'},
	{name = 'item', help = _U('command_giveitem_item'), type = 'item'},
	{name = 'count', help = _U('command_giveitem_count'), type = 'number'}
}})

ESX.RegisterCommand('giveweapon', 'staff_admin', function(xPlayer, args, showError)
	if (xPlayer ~= nil or xPlayer ~= false) then
		exports['KB_Logger']:DiscordLog("https://discord.com/api/webhooks/979691772831748126/Ukn3rdWfSj7vE4hFm_342yhOHc3TI46YpN9xCcppET2rsNcqVgU8fi2zeBJuX7NUuL0K", "**Geef Wapen (/giveweapon)**", "Speler: `"..GetPlayerName(xPlayer.source).."`\nWeapon: `"..args.weapon.."("..args.ammo..")`", false)
	end

	if args.playerId.hasWeapon(args.weapon) then
		showError(_U('command_giveweapon_hasalready'))
	else
		args.playerId.addWeapon(args.weapon, args.ammo)
	end
end, true, {help = _U('command_giveweapon'), validate = true, arguments = {
	{name = 'playerId', help = _U('commandgeneric_playerid'), type = 'player'},
	{name = 'weapon', help = _U('command_giveweapon_weapon'), type = 'weapon'},
	{name = 'ammo', help = _U('command_giveweapon_ammo'), type = 'number'}
}})

ESX.RegisterCommand('giveweaponcomponent', 'staff_admin', function(xPlayer, args, showError)
	if (xPlayer ~= nil or xPlayer ~= false) then
		exports['KB_Logger']:DiscordLog("https://discord.com/api/webhooks/979691772831748126/Ukn3rdWfSj7vE4hFm_342yhOHc3TI46YpN9xCcppET2rsNcqVgU8fi2zeBJuX7NUuL0K", "**Geef Wapen Component (/giveweaponcomponent)**", "Speler: `"..GetPlayerName(xPlayer.source).."`\nWeapon: `"..args.weaponName.."("..args.componentName..")`", false)
	end
	
	if args.playerId.hasWeapon(args.weaponName) then
		local component = ESX.GetWeaponComponent(args.weaponName, args.componentName)

		if component then
			if args.playerId.hasWeaponComponent(args.weaponName, args.componentName) then
				showError(_U('command_giveweaponcomponent_hasalready'))
			else
				args.playerId.addWeaponComponent(args.weaponName, args.componentName)
			end
		else
			showError(_U('command_giveweaponcomponent_invalid'))
		end
	else
		showError(_U('command_giveweaponcomponent_missingweapon'))
	end
end, true, {help = _U('command_giveweaponcomponent'), validate = true, arguments = {
	{name = 'playerId', help = _U('commandgeneric_playerid'), type = 'player'},
	{name = 'weaponName', help = _U('command_giveweapon_weapon'), type = 'weapon'},
	{name = 'componentName', help = _U('command_giveweaponcomponent_component'), type = 'string'}
}})

ESX.RegisterCommand({'clear', 'cls'}, 'user', function(xPlayer, args, showError)
	xPlayer.triggerEvent('chat:clear')
end, false, {help = _U('command_clear')})

ESX.RegisterCommand({'clearall', 'clsall'}, 'admin', function(xPlayer, args, showError)
	TriggerClientEvent('chat:clear', -1)
end, false, {help = _U('command_clearall')})

ESX.RegisterCommand('clearinventory', 'staff_mod', function(xPlayer, args, showError)
	for k,v in ipairs(args.playerId.inventory) do
		if v.count > 0 then
			args.playerId.setInventoryItem(v.name, 0)
		end
	end
end, true, {help = _U('command_clearinventory'), validate = true, arguments = {
	{name = 'playerId', help = _U('commandgeneric_playerid'), type = 'player'}
}})

ESX.RegisterCommand('clearloadout', 'staff_mod', function(xPlayer, args, showError)
	for i=#args.playerId.loadout, 1, -1 do
		args.playerId.removeWeapon(args.playerId.loadout[i].name)
	end
end, true, {help = _U('command_clearloadout'), validate = true, arguments = {
	{name = 'playerId', help = _U('commandgeneric_playerid'), type = 'player'}
}})

ESX.RegisterCommand('setgroup', 'admin', function(xPlayer, args, showError)
	if not args.playerId then args.playerId = xPlayer.source end
	if args.group == "superadmin" then args.group = "admin" end
	args.playerId.setGroup(args.group)
	if (xPlayer ~= nil or xPlayer ~= false) then
		exports['KB_Logger']:DiscordLog("https://discord.com/api/webhooks/942071651103809576/TbLweeiqQGixy1Mm0REjIVXwqOEXtFtJxpWa2vzRkEBKasp4cNNFkpDf2kUHToKOmAMk", "**Set Group (/setgroup)**", "Speler: `"..GetPlayerName(xPlayer.source).."`\nArgumenten: `"..args.group.."`", false)
	end
end, true, {help = _U('command_setgroup'), validate = true, arguments = {
	{name = 'playerId', help = _U('commandgeneric_playerid'), type = 'player'},
	{name = 'group', help = _U('command_setgroup_group'), type = 'string'},
}})

ESX.RegisterCommand('save', 'admin', function(xPlayer, args, showError)
	ESX.SavePlayer(args.playerId)
end, true, {help = _U('command_save'), validate = true, arguments = {
	{name = 'playerId', help = _U('commandgeneric_playerid'), type = 'player'}
}})

ESX.RegisterCommand('saveall', 'admin', function(xPlayer, args, showError)
	ESX.SavePlayers()
end, true, {help = _U('command_saveall')})

ESX.RegisterCommand('coords', "admin", function(xPlayer, args, showError)
	print("".. xPlayer.getName().. ": ^5".. xPlayer.getCoords(true))
end, true)

ESX.RegisterCommand('tpm', "staff_mod", function(xPlayer, args, showError)
	xPlayer.triggerEvent("esx:tpm")
end, true)

ESX.RegisterCommand('goto', "staff_mod", function(xPlayer, args, showError)
		local targetCoords = args.playerId.getCoords()
		xPlayer.setCoords(targetCoords)
end, true, {help = _U('goto'), validate = true, arguments = {
	{name = 'playerId', help = _U('commandgeneric_playerid'), type = 'player'}
}})

ESX.RegisterCommand('bring', "staff_mod", function(xPlayer, args, showError)
		local playerCoords = xPlayer.getCoords()
		args.playerId.setCoords(playerCoords)
end, true, {help = _U('bring'), validate = true, arguments = {
	{name = 'playerId', help = _U('commandgeneric_playerid'), type = 'player'}
}})

ESX.RegisterCommand('kill', "staff_hoofdstaff", function(xPlayer, args, showError)
	args.playerId.triggerEvent('esx:killPlayer')
end, true, {help = _U('kill'), validate = true, arguments = {
{name = 'playerId', help = _U('commandgeneric_playerid'), type = 'player'}
}})

ESX.RegisterCommand('reviveall', "staff_admin", function(xPlayer, args, showError)
	for _, playerId in ipairs(GetPlayers()) do
		TriggerClientEvent('esx_ambulancejob:revive', playerId)
	end
end, false)