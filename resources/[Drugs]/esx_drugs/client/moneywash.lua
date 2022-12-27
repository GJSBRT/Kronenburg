--[[ 
	Kronenburg Roleplay
	Copyright © GJSBRT <g@gijs.eu>

	This project is licensed under the terms of the Apache License 2.0 license.
	https://choosealicense.com/licenses/apache-2.0/
]]
 
 
local menuOpen = false
local wasOpen = false


function CheckMoneyWashLicense()

	ESX.TriggerServerCallback('esx_retropluk:CheckMoneyWashLicense', function(cb)
		if cb then
			wasOpen = true
			OpenMoneyWash()
		else
			ESX.ShowNotification(_U('need_license'))
		end
	end)
end

function OpenMoneyWash()
	ESX.UI.Menu.CloseAll()
	local elements = {
		{label = _U('moneywash_wash'), value = 'moneywash_wash'}
	}
	menuOpen = true

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'drug_shop', {
		title    = _U('moneywash_title'),
		align    = 'top-left',
		elements = elements
	}, function(data, menu)
		if data.current.value == 'moneywash_wash' then
			TriggerServerEvent('esx_retropluk:Wash')
		end
	end, function(data, menu)
		menu.close()
		menuOpen = false
	end)
end

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		if menuOpen then
			ESX.UI.Menu.CloseAll()
		end
	end
end)