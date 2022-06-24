local Keys = {
  ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
  ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
  ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
  ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
  ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,["-"] = 84,
  ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
  ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
  ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
  ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}


ESX                           = nil
local GUI      = {}
local PlayerData                = {}
local lastVehicle = nil
local lastOpen = false
GUI.Time                      = 0
local vehiclePlate = {}
local arrayWeight = Config.localWeight
local CloseToVehicle = false
local entityWorld = nil
local globalplate = nil
local LastTime = 0
local kofferbakopen = false

function getItemyWeight(item)
	local weight = 0
	local itemWeight = 0
  
	if item ~= nil then
		itemWeight = Config.DefaultWeight
		if arrayWeight[item] ~= nil then
			itemWeight = arrayWeight[item]
		end
	end
	return itemWeight
end
  


function getItemWeight(item)
    local itemWeight = Config.DefaultWeight

    if item ~= nil then
 --       print(Items[item], Config.localWeight[item], Config.DefaultWeight)
        itemWeight = Config.localWeight[item] or Config.DefaultWeight
    end
    return itemWeight/1000
end


function getMaxTrunkWeight(vehFront)
	local vehFront = VehicleInFront()
	local x,y,z = table.unpack(GetEntityCoords(GetPlayerPed(-1),true))
	local closecar = GetClosestVehicle(x, y, z, 4.0, 0, 71)
	local typeVeh = GetVehicleClass(vehFront)

	local MaxVh = (tonumber(Config.ModelLimit[GetEntityModel(vehFront)]))

	if MaxVh == nil then
		  MaxVh = (tonumber(Config.VehicleLimit[typeVeh]))
	end

	return MaxVh

end


Citizen.CreateThread(function()
  while ESX == nil do
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    Citizen.Wait(0)
  end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
  	PlayerData = xPlayer
    -- TriggerServerEvent("esx_truck_inventory:getOwnedVehicule")
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
  PlayerData.job = job
end)

RegisterNetEvent('esx_truck_inventory:setOwnedVehicule')
AddEventHandler('esx_truck_inventory:setOwnedVehicule', function(vehicle)
    vehiclePlate = vehicle
end)

function VehicleInFront()
    local pos = GetEntityCoords(GetPlayerPed(-1))
    local entityWorld = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0.0, 4.0, 0.0)
    local rayHandle = CastRayPointToPoint(pos.x, pos.y, pos.z, entityWorld.x, entityWorld.y, entityWorld.z, 10, GetPlayerPed(-1), 0)
    local a, b, c, d, result = GetRaycastResult(rayHandle)
    return result
end

local equipment = {
	[`GADGET_PARACHUTE`] = true
}
function IsEquipment(weaponHash)
	return equipment[weaponHash] or false
end

RegisterCommand('getweaponhash', function()
	local ped = PlayerPedId()
	local currentWeaponHash = GetSelectedPedWeapon(ped)
	local message = ("CurrentWeaponHash: " .. currentWeaponHash .. "")

	print(message)

end)

RegisterCommand('getmaterial', function()
	local vehicle = GetVehiclePedIsIn(PlayerPedId())
	local materialIndex = GetVehicleWheelSurfaceMaterial(vehicle, 0)
	local material = materials[materialIndex]
	local boneIndex = GetEntityBoneIndexByName(vehicle, "wheel_lf")
	local coords
	if boneIndex ~= -1 then
		coords = GetWorldPositionOfEntityBone(vehicle, boneIndex)
	else
		coords = GetEntityCoords(vehicle)
	end
	local ray = StartShapeTestRay(coords.x, coords.y, coords.z + 2.0, coords.x, coords.y, coords.z - 2.0, 1, vehicle)
	local _, _, _, _, materialHash = GetShapeTestResultIncludingMaterial(ray)
	local materialOld = Materials[materialHash]

	local message = ("materialHash: %s; material: %s; materialIndex: %s; materialNew: %s"):format(materialHash, materialOld and materialOld.name or "not found", materialIndex, material and material.name or "not found")
	print(message)
	print("rainLevel: ", GetRainLevel())
	return message
end)

function CanTransferWeapon(weaponHash)
	if type(weaponHash) == "string" then
		weaponHash = GetHashKey(weaponHash)
	end

	local selectedWeapon = GetSelectedPedWeapon(PlayerPedId())
	if not IsEquipment(weaponHash) and selectedWeapon ~= weaponHash then
		return false
	end

    return true
end


function CanItemBePutInTrunk(itemName)
    if Config.BlockedItems[itemName] then
        return false
    end

    return true
end


function GetCountFromMenu()
    local p = promise.new()
    ESX.UI.Menu.Open(
    'dialog', GetCurrentResourceName(), 'inventory_item_count_give',
    {
        title = 'Aantal'
    },
    function(data4, menu4) -- Submit
        local quantity = tonumber(data4.value)
        if not quantity then
            ESX.ShowNotification("Vul AUB een geldig getal in")
            return
        end
        p:resolve(quantity)
    end,
    function(data4, menu4) -- Cancel
        menu4.close()
    end,
    function(data4, menu4) -- Change
    end,
    function(data4, menu4) -- Close
    end, true)

    return Citizen.Await(p)
end


function VehicleMaxSpeed(vehicle,weight,maxweight)
  local percent = (weight/maxweight)*100
  local hashk= GetEntityModel(vehicle)
  if percent > 80  then
    SetEntityMaxSpeed(vehFront,GetVehicleModelMaxSpeed(hashk)/1.4)
  elseif percent > 50 then
    SetEntityMaxSpeed(vehFront,GetVehicleModelMaxSpeed(hashk)/1.2)
  else
    SetEntityMaxSpeed(vehFront,GetVehicleModelMaxSpeed(hashk))
  end
end

function openmenuvehicle()
	local playerPed = GetPlayerPed(-1)
	local coords    = GetEntityCoords(playerPed)
	local vehicle   =VehicleInFront()
	globalplate  = ESX.Math.Trim(GetVehicleNumberPlateText(vehicle))

	if GetGameTimer() - LastTime < 2000 then
		exports['mythic_notify']:DoHudText('error', 'Probeer het over een aantal seconden opnieuw!')
        return
    end

	LastTime = GetGameTimer()

	if not IsPedInAnyVehicle(playerPed, false) then

		local dict, anim = 'weapons@first_person@aim_rng@generic@projectile@sticky_bomb@', 'plant_floor'
		ESX.Streaming.RequestAnimDict(dict)
		TaskPlayAnim(playerPed, dict, anim, 8.0, 1.0, 1000, 16, 0.0, false, false, false)
		RemoveAnimDict(dict)
	end

	if globalplate ~= nil or globalplate ~= "" or globalplate ~= " " then
		-- ESX.TriggerServerCallback('esx_truck:checkvehicle',function(valid)
		-- 	if (not valid) then
				-- CloseToVehicle = true
				-- TriggerServerEvent('esx_truck_inventory:AddVehicleList', globalplate)
				local vehFront = VehicleInFront()
				local x,y,z = table.unpack(GetEntityCoords(GetPlayerPed(-1),true))
				local closecar = GetClosestVehicle(x, y, z, 4.0, 0, 71)
			  if vehFront > 0 and closecar ~= nil and GetPedInVehicleSeat(closecar, -1) ~= GetPlayerPed(-1) and not IsPedDeadOrDying(playerPed) then
					lastVehicle = vehFront
						local model = GetDisplayNameFromVehicleModel(GetEntityModel(closecar))
					local class = GetVehicleClass(vehFront)
					  ESX.UI.Menu.CloseAll()
					if ESX.UI.Menu.IsOpen('default', GetCurrentResourceName(), 'inventory') then
					  SetVehicleDoorShut(vehFront, 5, false)
					else
					if IsTrunkUnlocked(vehFront) then
						  SetVehicleDoorOpen(vehFront, 5, false, false)
						  ESX.UI.Menu.CloseAll()
						  if globalplate ~= nil or globalplate ~= "" or globalplate ~= " " then
							kofferbakopen = true
							CloseToVehicle = true
							TriggerServerEvent('esx_truck_inventory:AddVehicleList', globalplate)
						  TriggerServerEvent("esx_truck_inventory:getInventory", globalplate)
						  end
						else
						   ESX.ShowNotification('De kofferbak zit op ~r~slot')
					  end
					end
				else
					ESX.ShowNotification('Geen ~r~voertuig ~w~in de buurt')
				end
				lastOpen = true
				GUI.Time  = GetGameTimer()
		-- 	else
		-- 		TriggerEvent('esx:showNotification', "Iemand kijkt al in de kofferbak")
		-- 	end
		-- end, globalplate)
	end

end
local count = 0
-- Key controls
Citizen.CreateThread(function()
  while true do

    Wait(0)
    if IsControlPressed(0, Keys["-"]) and (GetGameTimer() - GUI.Time) > 1000 then
		if count == 0 then
			openmenuvehicle()
			count = count +1
		else
			Wait(2000)
			count = 0
		end
    elseif lastVehicle ~= 0 and lastVehicle ~= nil and #(GetEntityCoords(lastVehicle) - GetEntityCoords(PlayerPedId())) > 10.0 or lastVehicle ~= 0 and lastVehicle ~= nil and IsControlPressed(0, Keys["BACKSPACE"]) then
	  CloseToVehicle = false
      lastOpen = false
	  kofferbakopen = false
      if lastVehicle > 0 then
      	SetVehicleDoorShut(lastVehicle, 5, false)
		local lastvehicleplatetext = ESX.Math.Trim(GetVehicleNumberPlateText(lastVehicle))
		TriggerServerEvent('esx_truck_inventory:RemoveVehicleList', lastvehicleplatetext)
      	lastVehicle = 0
      end
      GUI.Time  = GetGameTimer()
    end
  end
end)

-- CloseToVehicle
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local pos = GetEntityCoords(PlayerPedId())
        if CloseToVehicle then
            local vehicle, distance = ESX.Game.GetClosestVehicle(pos)
            if DoesEntityExist(vehicle) and distance < 7.0 then
                CloseToVehicle = true
            else
                ESX.UI.Menu.CloseAll()
                CloseToVehicle = false
                LastVehicle = 0
                GlobalPlate = nil
            end
        else
            Citizen.Wait(1000)
        end
    end
end)

function GetGunAmmo(weaponHash)
	local playerPed = GetPlayerPed(-1)
	local ammo = GetAmmoInPedWeapon(playerPed, weaponHash)

	if ammo < 1 then
		ammo = 1
	end
	return ammo
end


RegisterNetEvent('esx_truck_inventory:getInventoryLoaded')
AddEventHandler('esx_truck_inventory:getInventoryLoaded', function(inventory,weight)
	local elements = {}
	local vehFrontBack = VehicleInFront()
--   TriggerServerEvent("esx_truck_inventory:getOwnedVehicule")

	table.insert(elements, {
      label     = 'Voorwerpen Inladen',
      count     = 0,
      value     = 'deposit',
    })

	if inventory ~= nil and #inventory > 0 then
		for i=1, #inventory, 1 do
		if inventory[i].type == 'item_standard' then
		      table.insert(elements, {
		        label     = inventory[i].label .. ' x' .. inventory[i].count,
		        count     = inventory[i].count,
		        value     = inventory[i].name,
				type	  = inventory[i].type
		      })			
			elseif inventory[i].type == 'item_weapon' then
				table.insert(elements, {
				  label     = inventory[i].label,
				  count     = inventory[i].count,
				  value     = inventory[i].name,
				  type	  = inventory[i].type
				})
			elseif inventory[i].type == 'item_account' then
			  table.insert(elements, {
				label     = inventory[i].label .. ' [ €' .. inventory[i].count..' ]',
				count     = inventory[i].count,
				value     = inventory[i].name,
				type	  = inventory[i].type
			  })	

			end
		end
	end
	
	

	ESX.UI.Menu.Open(
	  'default', GetCurrentResourceName(), 'inventory_deposit',
	  {
	    title    = 'Kofferbak Inventaris',
	    align    = 'bottom-right',
	    elements = elements,
	  },
	  function(data, menu)
	  	if data.current.value == 'deposit' then
	  		local elem = {}
			-- xPlayer.getAccount('black_money').money
			-- table.insert(elements, {label = 'Argent sale: ' .. inventory.blackMoney, type = 'item_account', value = 'black_money'})
			
	  		PlayerData = ESX.GetPlayerData()
			for i=1, #PlayerData.accounts, 1 do
				if PlayerData.accounts[i].name == 'black_money' then
				  -- if PlayerData.accounts[i].money > 0 then
				    table.insert(elem, {
				      label     = PlayerData.accounts[i].label .. ' [ €'.. math.floor(PlayerData.accounts[i].money+0.5) ..' ]',
				      count     = PlayerData.accounts[i].money,
				      value     = PlayerData.accounts[i].name,
				      name      = PlayerData.accounts[i].label,
					  limit     = PlayerData.accounts[i].limit,
					  type		= 'item_account',
				    })
				  -- end
				end
			end
			
			for i=1, #PlayerData.inventory, 1 do
				if PlayerData.inventory[i].count > 0 then
				    table.insert(elem, {
				      label     = PlayerData.inventory[i].label .. ' x' .. PlayerData.inventory[i].count,
				      count     = PlayerData.inventory[i].count,
				      value     = PlayerData.inventory[i].name,
				      name      = PlayerData.inventory[i].label,
					  limit     = PlayerData.inventory[i].limit,
					  type		= 'item_standard',
				    })
				end
			end

--			for i=1, #PlayerData.loadout do
 --               local ammo = PlayerData.loadout[i].ammo
 --               if not ammo then
--                    ammo = 0
--                end
--                table.insert(elem, {
--                    label = PlayerData.loadout[i].label .. ' [' .. ammo .. ']',
--                    name = 	PlayerData.loadout[i].label,
 --                   type = 	'item_weapon',
--                    value = PlayerData.loadout[i].name,
--                    count = ammo
--                })
--            end
			
		local playerPed  = GetPlayerPed(-1)

		local weaponList = ESX.GetWeaponList()

		for i=1, #weaponList, 1 do

		  local weaponHash = GetHashKey(weaponList[i].name)

		  if HasPedGotWeapon(playerPed,  weaponHash,  false) and weaponList[i].name ~= 'WEAPON_UNARMED' then
			local ammo = GetGunAmmo(weaponHash)
			table.insert(elem, {label = weaponList[i].label .. ' | Munitie : ' .. ammo .. '',name = weaponList[i].label, type = 'item_weapon', value = weaponList[i].name, count = ammo})
		  end

		end


			ESX.UI.Menu.Open(
			  'default', GetCurrentResourceName(), 'inventory_player',
			  {
			    title    = 'Inventaris',
			    align    = 'bottom-right',
			    elements = elem,
			  },function(data3, menu3)





				if data3.current.type == 'item_weapon' then
					local quantity = 1
					local Itemweight = 1
					local totalweight = weight + Itemweight
					vehFront = VehicleInFront()

					local typeVeh = GetVehicleClass(vehFront)

		--			local MaxVh = (tonumber(Config.ModelLimit[GetEntityModel(vehFront)]))
					local MaxVh = (getMaxTrunkWeight(vehFront))


					if MaxVh == nil then
						MaxVh = (tonumber(Config.VehicleLimit[typeVeh]))
					end

					local max = totalweight > MaxVh

					ownedV = 0
					while vehiclePlate == '' do
					Wait(1000)
					end
					for i=1, #vehiclePlate do
					if vehiclePlate[i].plate == ESX.Math.Trim(GetVehicleNumberPlateText(vehFront)) then
						ownedV = 1
						break
					else
						ownedV = 0
					end
					end

					--fin test

					if data3.current.type == 'item_weapon' then
						if not CanTransferWeapon(data3.current.value) then
							ESX.ShowNotification("Je kunt alleen wapens welke je vast hebt in een kofferbak stoppen!")
							ESX.UI.Menu.CloseAll()
							SetVehicleDoorShut(vehFrontBack, 5, false)
							return
						end
					end

					local Blocked = {
						"WEAPON_PISTOL_MK2",
						"WEAPON_PISTOL"
					}



					if quantity > 0 and quantity <= tonumber(data3.current.count) and vehFront > 0 then
						MaxVh = MaxVh / 1000
					local Kgweight =  totalweight/1000
					if not max then
						if data3.current.value == 'WEAPON_COMBATPISTOL' then
							ESX.ShowNotification('Dit wapen kan je niet in kofferbak')
						else
							local x,y,z = table.unpack(GetEntityCoords(GetPlayerPed(-1),true))
							local closecar = GetClosestVehicle(x, y, z, 4.0, 0, 71)
							local ped = PlayerPedId()
							local currentWeaponHash = GetSelectedPedWeapon(ped)
							local ammo = GetAmmoInPedWeapon(ped, currentWeaponHash)
							print(ammo)

							TriggerServerEvent('esx_truck_inventory:addInventoryItem', GetVehicleClass(closecar), GetDisplayNameFromVehicleModel(GetEntityModel(closecar)),  ESX.Math.Trim(GetVehicleNumberPlateText(vehFront)), data3.current.value, quantity, data3.current.name, data3.current.type, ownedV, ammo)
							ESX.ShowNotification('- Gebruikte Ruimte : ~g~'.. Kgweight .. ' Kg\n~w~- Totale Ruimte -  ~g~'.. MaxVh ..' Kg')
							Citizen.Wait(500)
							TriggerServerEvent("esx_truck_inventory:getInventory", ESX.Math.Trim(GetVehicleNumberPlateText(vehFront)))

							Wait(500)

							SetCurrentPedWeapon(PlayerPedId(), `WEAPON_UNARMED`)

						end
					else
						ESX.ShowNotification('Je hebt het limiet bereikt van ~r~ '..MaxVh..' Kg')
					end
					else
						ESX.ShowNotification('~r~ Ongeldig aantal')
					end

				    ESX.UI.Menu.CloseAll()




				else

					ESX.UI.Menu.Open(
					'dialog', GetCurrentResourceName(), 'inventory_item_count_give',
					{
						title = 'Hoeveel?'
					},
					function(data4, menu4)
					local quantity = tonumber(data4.value)
					local Itemweight = getItemyWeight(data3.current.value) * quantity
					local totalweight = weight + Itemweight
					vehFront = VehicleInFront()

					local typeVeh = GetVehicleClass(vehFront)

		--			local MaxVh = (tonumber(Config.ModelLimit[GetEntityModel(vehFront)]))
					local MaxVh = (getMaxTrunkWeight(vehFront))


					if MaxVh == nil then
						MaxVh = (tonumber(Config.VehicleLimit[typeVeh]))
					end

					local max = totalweight > MaxVh

					ownedV = 0
					while vehiclePlate == '' do
					Wait(1000)
					end
					for i=1, #vehiclePlate do
					if vehiclePlate[i].plate == ESX.Math.Trim(GetVehicleNumberPlateText(vehFront)) then
						ownedV = 1
						break
					else
						ownedV = 0
					end
					end

					--fin test

					if data3.current.type == 'item_weapon' then
						if not CanTransferWeapon(data3.current.value) then
							ESX.ShowNotification("Je kunt alleen wapens welke je vast hebt in een kofferbak stoppen!")
							ESX.UI.Menu.CloseAll()
							SetVehicleDoorShut(vehFrontBack, 5, false)
							return
						end
					end

					local Blocked = {
						"WEAPON_PISTOL_MK2",
						"WEAPON_PISTOL"
					}
			

					if quantity > 0 and quantity <= tonumber(data3.current.count) and vehFront > 0 then
						MaxVh = MaxVh / 1000
					local Kgweight =  totalweight/1000
					if not max then
						if data3.current.value == 'WEAPON_PISTOL' or data3.current.value == 'WEAPON_COMBATPISTOL' or data3.current.value == 'WEAPON_COMPACTRIFLE' then
							ESX.ShowNotification('Dit wapen kan je niet in kofferbak')
						else
							local x,y,z = table.unpack(GetEntityCoords(GetPlayerPed(-1),true))
							local closecar = GetClosestVehicle(x, y, z, 4.0, 0, 71)
					--  	VehicleMaxSpeed(closecar,totalweight,Config.VehicleLimit[GetVehicleClass(closecar)])
							if data3.current.type == 'item_weapon' then
								SetCurrentPedWeapon(PlayerPedId(), `WEAPON_UNARMED`)
							end
							TriggerServerEvent('esx_truck_inventory:addInventoryItem', GetVehicleClass(closecar), GetDisplayNameFromVehicleModel(GetEntityModel(closecar)),  ESX.Math.Trim(GetVehicleNumberPlateText(vehFront)), data3.current.value, quantity, data3.current.name, data3.current.type, ownedV)
		--                	ESX.ShowNotification('Kofferbak : ~g~'.. Kgweight .. ' Kg / '..MaxVh..' Kg')
		--						print(data3.current.value)
							ESX.ShowNotification('- Gebruikte Ruimte : ~g~'.. Kgweight .. ' Kg\n~w~- Totale Ruimte -  ~g~'.. MaxVh ..' Kg')
							Citizen.Wait(500)
							TriggerServerEvent("esx_truck_inventory:getInventory", ESX.Math.Trim(GetVehicleNumberPlateText(vehFront)))
						end
					else
						ESX.ShowNotification('Je hebt het limiet bereikt van ~r~ '..MaxVh..' Kg')
					end
					else
						ESX.ShowNotification('~r~ Ongeldig aantal')
					end

				    ESX.UI.Menu.CloseAll()


				  end,
				  function(data4, menu4)
		            SetVehicleDoorShut(vehFrontBack, 5, false)
				    ESX.UI.Menu.CloseAll()
					local lastvehicleplatetext = ESX.Math.Trim(GetVehicleNumberPlateText(vehFrontBack))
					TriggerServerEvent('esx_truck_inventory:RemoveVehicleList', lastvehicleplatetext)
				  end)
				end
			end,
				function(data, menu)
					menu.close()
				end)
		elseif data.current.type == 'cancel' then
			menu.close()
	  	else


			if data.current.type == 'item_weapon' then

					local quantity = 1
					PlayerData = ESX.GetPlayerData()
					vehFront = VehicleInFront()

			--test
				local Itemweight =tonumber(getItemyWeight(data.current.value)) * quantity
				local poid = weight - Itemweight

				


				if quantity > 0 and quantity <= tonumber(data.current.count) and vehFront > 0 then
					TriggerServerEvent('esx_truck_inventory:removeInventoryItem', ESX.Math.Trim(GetVehicleNumberPlateText(vehFront)), data.current.value, data.current.type, quantity)
					local typeVeh = GetVehicleClass(vehFront)

	--			    local MaxVh = (tonumber(Config.ModelLimit[GetEntityModel(vehFront)])/1000)
					local MaxVh = (tonumber(getMaxTrunkWeight(vehFront))/1000)

	--				if MaxVh == nil then
	--					MaxVh = (tonumber(Config.VehicleLimit[typeVeh])/1000)
	--				end

					local Itemweight =tonumber(getItemyWeight(data.current.value)) * quantity
					local totalweight = tonumber(weight) - Itemweight
					local Kgweight =  totalweight/1000
					ESX.ShowNotification('- Gebruikte Ruimte : ~g~'.. Kgweight .. ' Kg\n~w~-Totale Ruimte : ~g~'.. MaxVh ..' Kg')
				else
					ESX.ShowNotification('~r~ Ongeldig aantal')
				end

				ESX.UI.Menu.CloseAll()

				local vehFront = VehicleInFront()
				if vehFront > 0 then
					ESX.SetTimeout(1500, function()
						TriggerServerEvent("esx_truck_inventory:getInventory", ESX.Math.Trim(GetVehicleNumberPlateText(vehFront)))
					end)
				else
				SetVehicleDoorShut(vehFrontBack, 5, false)
				end

			else
				ESX.UI.Menu.Open(
				'dialog', GetCurrentResourceName(), 'inventory_item_count_give',
				{
					title = 'Hoeveelheid'
				},
				function(data2, menu2)

					local quantity = tonumber(data2.value)
					PlayerData = ESX.GetPlayerData()
					vehFront = VehicleInFront()

			--test
				local Itemweight =tonumber(getItemyWeight(data.current.value)) * quantity
				local poid = weight - Itemweight

				
				local max = true
				if data.current.type == 'item_standard'then
					local currentWeight = 0
					local maxWeight = PlayerData.maxWeight
					local itemWeight = nil
					for k,v in ipairs(PlayerData.inventory) do
						if v.count > 0 then
							currentWeight = currentWeight + (getItemWeight(v.name) * v.count)
						end
						if v.name == data.current.value then
							itemWeight = getItemWeight(v.name)
						end
					end
					
					print(("[esx_truck_inventory] currentWeight: %s; maxWeight: %s; itemWeight: %s; count: %s;"):format(tostring(currentWeight), tostring(maxWeight), tostring(itemWeight), tostring(quantity)))
					
					local newWeight = currentWeight + (itemWeight * quantity)
					
					if newWeight <= maxWeight then
						max = false
					else
						max = true
					end
				elseif data.current.type == 'item_weapon' then
					max = false
				elseif data.current.type == 'item_account' then
					max = false
				else
					max = true
				end


				if quantity > 0 and quantity <= tonumber(data.current.count) and vehFront > 0 then
					if not max then
						TriggerServerEvent('esx_truck_inventory:removeInventoryItem', ESX.Math.Trim(GetVehicleNumberPlateText(vehFront)), data.current.value, data.current.type, quantity)
						local typeVeh = GetVehicleClass(vehFront)

		--			    local MaxVh = (tonumber(Config.ModelLimit[GetEntityModel(vehFront)])/1000)
						local MaxVh = (tonumber(getMaxTrunkWeight(vehFront))/1000)

		--				if MaxVh == nil then
		--					MaxVh = (tonumber(Config.VehicleLimit[typeVeh])/1000)
		--				end

						local Itemweight =tonumber(getItemyWeight(data.current.value)) * quantity
						local totalweight = tonumber(weight) - Itemweight
						local Kgweight =  totalweight/1000
						ESX.ShowNotification('- Gebruikte Ruimte : ~g~'.. Kgweight .. ' Kg\n~w~-Totale Ruimte : ~g~'.. MaxVh ..' Kg')
					else
						ESX.ShowNotification('~r~ Je draagt te veel')
					end
				else
					ESX.ShowNotification('~r~ Ongeldig aantal')
				end

					ESX.UI.Menu.CloseAll()

					local vehFront = VehicleInFront()
					if vehFront > 0 then
						ESX.SetTimeout(1500, function()
							TriggerServerEvent("esx_truck_inventory:getInventory", ESX.Math.Trim(GetVehicleNumberPlateText(vehFront)))
						end)
					else
					SetVehicleDoorShut(vehFrontBack, 5, false)
					end
				end,
				function(data2, menu2)
							--SetVehicleDoorShut(vehFrontBack, 5, false)
							ESX.UI.Menu.CloseAll()
							local lastvehicleplatetext = ESX.Math.Trim(GetVehicleNumberPlateText(vehFrontBack))
							TriggerServerEvent('esx_truck_inventory:RemoveVehicleList', lastvehicleplatetext)
						end
					)
				end
			end
        end,
		function(data, menu)
			menu.close()
		end
	)
end)


function dump(o)
   if type(o) == 'table' then
      local s = '{ '
      for k,v in pairs(o) do
         if type(k) ~= 'number' then k = '"'..k..'"' end
         s = s .. '['..k..'] = ' .. dump(v) .. ','
      end
      return s .. '} '
   else
      return tostring(o)
   end
end

function IsTrunkUnlocked(vehicle)
	return (GetVehicleDoorLockStatus(vehicle) == 1 and not DecorGetBool(vehicle, "_VEHICLE_LOCKED")) or DecorGetBool(vehicle, "_TRUNK_UNLOCKED")
end

function all_trim(s)
	if s then
		return s:match"^%s*(.*)":match"(.-)%s*$"
	else
		return 'noTagProvided'
	end
end

exports("KofferBakOpen", function()
	return kofferbakopen
end)