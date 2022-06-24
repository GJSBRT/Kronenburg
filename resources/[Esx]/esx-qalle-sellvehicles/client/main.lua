ESX = nil

PlayerData = {}



Citizen.CreateThread(function()
    while ESX == nil do
        Citizen.Wait(10)

        TriggerEvent("esx:getSharedObject", function(response)
            ESX = response
        end)
    end

    if ESX.IsPlayerLoaded() then
		PlayerData = ESX.GetPlayerData()

		RemoveVehicles()

		Citizen.Wait(500)

		LoadSellPlace()

		SpawnVehicles()
    end
end)

RegisterNetEvent("esx:playerLoaded")
AddEventHandler("esx:playerLoaded", function(response)
	PlayerData = response
	
	LoadSellPlace()

	SpawnVehicles()
end)

RegisterNetEvent("esx-qalle-sellvehicles:refreshVehicles")
AddEventHandler("esx-qalle-sellvehicles:refreshVehicles", function()
	RemoveVehicles()

	Citizen.Wait(500)

	SpawnVehicles()
end)

AddTextEntry("STRING5", "~a~~a~~a~~a~~a~")
local function DrawText3D(coords, text)
	local camCoords = GetGameplayCamCoords()
	local distance = #(coords - camCoords)

	local scale = (1 / distance) * 2
	local fov = (1 / GetGameplayCamFov()) * 100
	scale = scale * fov

	SetTextScale(0.0 * scale, 0.55 * scale)
	SetTextFont(0)
	SetTextColour(255, 255, 255, 255)
	SetTextDropshadow(0, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()
	SetTextCentre(true)

	SetDrawOrigin(coords, 0)
	if string.len(text) > 90 then
		BeginTextCommandDisplayText('STRING5')
		while string.len(text) > 90 do
			AddTextComponentSubstringPlayerName(text:sub(1, 90))
			text = text:sub(91, -1)
		end
		AddTextComponentSubstringPlayerName(text)
	else
		BeginTextCommandDisplayText('STRING')
		AddTextComponentSubstringPlayerName(text)
	end
	EndTextCommandDisplayText(0.0, 0.0)
	ClearDrawOrigin()
end

function LoadSellPlace()
	Citizen.CreateThread(function()

		local SellPos = Config.SellPosition

		local Blip = AddBlipForCoord(SellPos["x"], SellPos["y"], SellPos["z"])
		SetBlipSprite (Blip, 227)
		SetBlipDisplay(Blip, 4)
		SetBlipScale  (Blip, 0.8)
		SetBlipColour (Blip, 5)
		SetBlipAsShortRange(Blip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("Tweedehands")
		EndTextCommandSetBlipName(Blip)

		while true do
			local sleepThread = 500

			local ped = PlayerPedId()
			local pedCoords = GetEntityCoords(ped)

			local dstCheck = GetDistanceBetweenCoords(pedCoords, SellPos["x"], SellPos["y"], SellPos["z"], true)

			if dstCheck <= 10.0 then
				sleepThread = 5

				if dstCheck <= 10.2 then
					DrawMarker(36, -143.194881439209, -2032.4233398438, 22.991722106934+0.6, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 2.0, 2.0, 2.0, 0, 255, 0, 250, false, true, 2, nil, nil, false)
					ESX.Game.Utils.DrawText3D(SellPos, "[E] Om je voertuig tekoop te zetten!", 0.9)
					if IsControlJustPressed(0, 38) then
						if IsPedInAnyVehicle(ped, false) then
							OpenSellMenu(GetVehiclePedIsUsing(ped))
						else
							ESX.ShowNotification("Je moet in een ~r~voertuig~w~ zitten")
						end
					end
				end
			end

			for i = 1, #Config.VehiclePositions, 1 do
				if Config.VehiclePositions[i]["entityId"] ~= nil then
					local pedCoords = GetEntityCoords(ped)
					local vehCoords = GetEntityCoords(Config.VehiclePositions[i]["entityId"])
					local dstCheck = GetDistanceBetweenCoords(pedCoords, vehCoords, true)
					local veh = Config.VehiclePositions[i]["entityId"]


					if dstCheck <= 2.0 then
						sleepThread = 5
						if Config.VehiclePositions[i]["VehicleNieuwprijs"] == 'Onbekend' then
							text = (_U('mods2', ESX.Math.GroupDigits(Config.VehiclePositions[i]["price"]), Config.VehiclePositions[i]["VehicleNieuwprijs"], Config.VehiclePositions[i]["TellieNummer"], Config.VehiclePositions[i]["voertuigmotor"]+2, GetNumVehicleMods(veh, 11)+1, Config.VehiclePositions[i]["voertuigturbo"] and 'Ja' or 'Nee', Config.VehiclePositions[i]["voertuigophanging"]+2, GetNumVehicleMods(veh, 16)+1, Config.VehiclePositions[i]["voertuigtransmissie"]+2, GetNumVehicleMods(veh, 13)+1, Config.VehiclePositions[i]["voertuigremmen"]+2, GetNumVehicleMods(veh, 12)+1, Config.VehiclePositions[i]["voertuigarmor"]+2, GetNumVehicleMods(veh, 16)+1))
						else
							text = (_U('mods', ESX.Math.GroupDigits(Config.VehiclePositions[i]["price"]), ESX.Math.GroupDigits(Config.VehiclePositions[i]["VehicleNieuwprijs"]), Config.VehiclePositions[i]["TellieNummer"], Config.VehiclePositions[i]["voertuigmotor"]+2, GetNumVehicleMods(veh, 11)+1, Config.VehiclePositions[i]["voertuigturbo"] and 'Ja' or 'Nee', Config.VehiclePositions[i]["voertuigophanging"]+2, GetNumVehicleMods(veh, 16)+1, Config.VehiclePositions[i]["voertuigtransmissie"]+2, GetNumVehicleMods(veh, 13)+1, Config.VehiclePositions[i]["voertuigremmen"]+2, GetNumVehicleMods(veh, 12)+1, Config.VehiclePositions[i]["voertuigarmor"]+2, GetNumVehicleMods(veh, 16)+1))
						end

						DrawText3D(vehCoords + vector3(0.0, 0.0, 1.5), text, 1.3)

						if IsControlJustPressed(0, 38) then
							if IsPedInVehicle(ped, Config.VehiclePositions[i]["entityId"], false) then
								OpenSellMenu(Config.VehiclePositions[i]["entityId"], Config.VehiclePositions[i]["price"], true, Config.VehiclePositions[i]["owner"])
							else
								ESX.ShowNotification("Je moet in het voertuig zitten om het voertuig te kopen")
							end
						end
					end
				end
			end
			Citizen.Wait(sleepThread)
		end
	end)
end

function GetVehicleLabel(model)
	local vehicleName = GetDisplayNameFromVehicleModel(model)
	local name = GetLabelText(vehicleName)
	if name ~= 'NULL' then
		vehicleName = name
	end

	return vehicleName
end

function ConfirmMenu(vehicleName, price, message)
	vehicleName = tostring(vehicleName)
	message = message or 'Type de naam van het voertuig (%s) om voertuig te koop te zetten voor €%s'
	local p = promise.new()
	ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'shop_confirm', {
		title = (message):format(vehicleName, ESX.Math.GroupDigits(price))
	},
	function (confirmData, confirmMenu)
		confirmMenu.close()
		if confirmData.value and confirmData.value:lower():gsub("%W", "") == vehicleName:lower():gsub("%W", "") then
			LastTime = GetGameTimer() + 5000
			p:resolve(true)
		else
			p:resolve(false)
		end
	end, function (confirmData, confirmMenu)
		confirmMenu.close()
		p:resolve(false)
	end)

	return Citizen.Await(p)
end



function OpenSellMenu(veh, price, buyVehicle, owner)
	local elements = {}

	if not buyVehicle then
		if price ~= nil then
			table.insert(elements, { ["label"] = "Verander prijs - " .. price .. " :-", ["value"] = "price" })
			table.insert(elements, { ["label"] = "Zet te koop", ["value"] = "sell" })
		else
			table.insert(elements, { ["label"] = "Prijs - :-", ["value"] = "price" })
		end
	else
		table.insert(elements, { ["label"] = "Koop voor: " .. price .. "", ["value"] = "buy" })

		if owner then
			table.insert(elements, { ["label"] = "Haal voertuig er af", ["value"] = "remove" })
		end
	end

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'sell_veh',
		{
			title    = "Vehicle Menu",
			align    = 'top-right',
			elements = elements
		},
	function(data, menu)
		local action = data.current.value

		if action == "price" then
			ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'sell_veh_price',
				{
					title = "Vehicle Price"
				},
			function(data2, menu2)

				local vehPrice = tonumber(data2.value)

				menu2.close()
				menu.close()

				OpenSellMenu(veh, vehPrice)
			end, function(data2, menu2)
				menu2.close()
			end)
		elseif action == "sell" then
			local vehProps = ESX.Game.GetVehicleProperties(veh)
			local hoertje = vehProps.model
			local voertuignaampie = GetDisplayNameFromVehicleModel(hoertje)
			
			ESX.TriggerServerCallback("esx-qalle-sellvehicles:isVehicleValid", function(valid)

				if valid then
					DeleteVehicle(veh)
					ESX.ShowNotification("Je hebt je ~g~voertuig~s~ tekoop gezet voor €" .. price .. ",-")
					menu.close()
				else
					ESX.ShowNotification("Dit voertuig is niet van jou!")
				end
	
			end, vehProps, price, voertuignaampie)
		elseif action == "buy" then

			local plate = plate or ESX.Game.GetVehicleProperties(veh).plate
			local vehicleName = GetVehicleLabel(GetEntityModel(veh))
			local message = 'Type (%s) om het voertuig te kopen voor €%s'
			if ConfirmMenu(vehicleName, price, message) then
				ESX.TriggerServerCallback("esx-qalle-sellvehicles:buyVehicle", function(isPurchasable, totalMoney)
					if isPurchasable then
						DeleteVehicle(veh)
						ESX.ShowNotification("Je hebt het voertuig ~g~gekocht~s~ voor €" .. price .. ",-")
						menu.close()
					else
						ESX.ShowNotification("Je hebt neit genoeg geld je mist €" .. price - totalMoney .. ",-")
					end
				end, ESX.Game.GetVehicleProperties(veh), price)
			else
				ESX.ShowNotification("Naam is niet correct overgetypt, verkoop is geannuleerd")
			end

		elseif action == "remove" then
			ESX.TriggerServerCallback("esx-qalle-sellvehicles:buyVehicle", function(isPurchasable, totalMoney)
				if isPurchasable then
					DeleteVehicle(veh)
					ESX.ShowNotification("Je hebt het voertuig er af gehaald, Hij staat terug in je garage")
					menu.close()
				end
			end, ESX.Game.GetVehicleProperties(veh), 0)
		end
		
	end, function(data, menu)
		menu.close()
	end)
end

function RemoveVehicles()
	local VehPos = Config.VehiclePositions

	for i = 1, #VehPos, 1 do
		local veh, distance = ESX.Game.GetClosestVehicle(VehPos[i])

		if DoesEntityExist(veh) and distance <= 1.0 then
			DeleteEntity(veh)
		end
	end
end

function SpawnVehicles()
	local VehPos = Config.VehiclePositions

	ESX.TriggerServerCallback("esx-qalle-sellvehicles:retrieveVehicles", function(vehicles)
		for i = 1, #vehicles, 1 do

			local vehicleProps = vehicles[i]["vehProps"]

			LoadModel(vehicleProps["model"])

			VehPos[i]["entityId"] = CreateVehicle(vehicleProps["model"], VehPos[i]["x"], VehPos[i]["y"], VehPos[i]["z"] - 0.975, VehPos[i]["h"], false)
			VehPos[i]["price"] = vehicles[i]["price"]
			VehPos[i]["TellieNummer"] = vehicles[i]["TelefoonNummer"]

			VehPos[i]["VehicleNieuwprijs"] = vehicles[i]["VoertuigNieuwprijs"]

			VehPos[i]["voertuigarmor"] = vehicleProps["modArmor"]

			VehPos[i]["voertuigturbo"] = vehicleProps["modTurbo"]

			VehPos[i]["voertuigremmen"] = vehicleProps["modBrakes"]

			VehPos[i]["voertuigophanging"] = vehicleProps["modSuspension"]

			VehPos[i]["voertuigtransmissie"] = vehicleProps["modTransmission"]

			VehPos[i]["voertuigmotor"] = vehicleProps["modEngine"]

			VehPos[i]["owner"] = vehicles[i]["owner"]

			ESX.Game.SetVehicleProperties(VehPos[i]["entityId"], vehicleProps)

			FreezeEntityPosition(VehPos[i]["entityId"], true)

			--SetEntityAsMissionEntity(VehPos[i]["entityId"], true, true)
			--SetModelAsNoLongerNeeded(vehicleProps["model"])

		end
	end)

end

LoadModel = function(model)
	while not HasModelLoaded(model) do
		RequestModel(model)

		Citizen.Wait(1)
	end
end
