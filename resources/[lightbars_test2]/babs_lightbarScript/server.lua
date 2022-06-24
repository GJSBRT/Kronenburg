-- Version 0.1
-- Devloped by Everett aka Mr. Yellow aka Munky aka De_verett
local lightbarCars = {}
local lightbarCars2 = {}

RegisterServerEvent('aapje:addLightbar')
AddEventHandler('aapje:addLightbar', function(hostVehPlate, lightbarNetworkID, hvp)
	local source = source
	for k,v in pairs(lightbarCars) do 
		if v["LP"] == hostVehPlate then
			table.insert(v.lights, lightbarNetworkID)
			return
		end
	end
	table.insert(lightbarCars, {["hostVehiclePointer"] = hvp, ["LP"] = hostVehPlate, ["lights"] = {lightbarNetworkID}, ["lightStatus"] = false, ["sirenStatus"] = false} )
end)			

RegisterServerEvent('aapje:toggleLights2')
AddEventHandler('aapje:toggleLights2', function(hostVehPlate)
	local source = source
	local veh = nil
	for k,v in pairs(lightbarCars) do 
		if v["LP"] == hostVehPlate then
			TriggerClientEvent("clientToggleLights", source, v.lights, v.lightStatus, v.hostVehiclePointer) 
			v.lightStatus = not v.lightStatus
		end
	end
end)

RegisterServerEvent("aapje:ToggleSound1Server")
AddEventHandler("aapje:ToggleSound1Server", function(plate)
	local source = source
	local toggle = nil
	for k,v in pairs(lightbarCars) do 
		if v["LP"] == plate then
			toggle = not v.sirenStatus
			v.sirenStatus = toggle
			TriggerClientEvent("sound1Client", -1, source, toggle)
		end
	end
end)

RegisterServerEvent('aapje:returnLightBarVehiclePlates')
AddEventHandler('aapje:returnLightBarVehiclePlates', function()
	local source = source
	local plates = {}
	for k,v in pairs(lightbarCars) do 
		table.insert(plates, v.LP)
	end
	TriggerClientEvent("sendLightBarVehiclePlates", source, plates) 
end)


RegisterServerEvent('aapje:returnLightbarsForMainVeh')
AddEventHandler('aapje:returnLightbarsForMainVeh', function(mainVehPlate)
	local source = source
	local plates = {}
	for k,v in pairs(lightbarCars) do 
		if v.LP == mainVehPlate then
			plates = v.lights
			lightbarCars[k] = nil -- removes main vehicle from arr
		end
	end
	--removeAllFromTable(mainVehPlate)
	TriggerClientEvent("updateLightbarArray", source, plates) 
end)

function removeKey(key)
	lightbarCars[key] = nil
end

function removeAllFromTable(mainVehPlate)
	for k,v in pairs(lightbarCars) do 
		if v.LP == mainVehPlate then
			table.remove(k)
			return
		end
	end
end