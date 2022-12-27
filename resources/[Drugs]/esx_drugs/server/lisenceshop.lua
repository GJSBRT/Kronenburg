--[[ 
	Kronenburg Roleplay
	Copyright © GJSBRT <g@gijs.eu>

	This project is licensed under the terms of the Apache License 2.0 license.
	https://choosealicense.com/licenses/apache-2.0/
]]
 
 

ESX.RegisterServerCallback('esx_retropluk:CheckJob', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local job = xPlayer.getJob()

	--[[if (job.name == 'cartel' and (xPlayer.job.grade == 4 or xPlayer.job.grade == 3)) or (job.name == 'tequi-la-la' and (xPlayer.job.grade == 4 or xPlayer.job.grade == 3)) or (job.name == 'unicorn' and (xPlayer.job.grade == 4 or xPlayer.job.grade == 3)) then
		cb(true)
	else
		cb(false)
	end
	--]]
	cb(true)
end)
