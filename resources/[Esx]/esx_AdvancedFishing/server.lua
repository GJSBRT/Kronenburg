--[[ 
	Kronenburg Roleplay
	Copyright © GJSBRT <g@gijs.eu>

	This project is licensed under the terms of the Apache License 2.0 license.
	https://choosealicense.com/licenses/apache-2.0/
]]
 
 


ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('fishing:server:getVerifyToken', function(source, cb)
	local src = source
	local token, resourcename = exports['DRGNV_tokenizer']:generateToken(GetCurrentResourceName(), src)
	while token == nil do
		Wait(500)
	end
	cb(token, resourcename)
end)


ESX.RegisterUsableItem('turtlebait', function(source)

	local _source = source
	xPlayer = ESX.GetPlayerFromId(_source)
	if xPlayer.getInventoryItem('fishingrod').count > 0 then
		TriggerClientEvent('fishing:setbait', _source, "turtle")
		
		xPlayer.removeInventoryItem('turtlebait', 1)
		TriggerClientEvent('fishing:message', _source, "~g~Je hebt schildpadden-aas aan je hengel gedaan. ~r~ILLEGAAL")
	else
		TriggerClientEvent('fishing:message', _source, "~r~Je hebt geen vishengel.")
	end
	
end)

ESX.RegisterUsableItem('fishbait', function(source)

	local _source = source
	xPlayer = ESX.GetPlayerFromId(_source)
	if xPlayer.getInventoryItem('fishingrod').count > 0 then
		TriggerClientEvent('fishing:setbait', _source, "fish")
		
		xPlayer.removeInventoryItem('fishbait', 1)
		TriggerClientEvent('fishing:message', _source, "~g~Je hebt wat vissenvoer aan je hengel gedaan")
		
	else
		TriggerClientEvent('fishing:message', _source, "~r~Je hebt geen vishengel.")
	end
	
end)

ESX.RegisterUsableItem('turtle', function(source)

	local _source = source
	xPlayer = ESX.GetPlayerFromId(_source)
	if xPlayer.getInventoryItem('fishingrod').count > 0 then
		TriggerClientEvent('fishing:setbait', _source, "shark")
		
		xPlayer.removeInventoryItem('turtle', 1)
		TriggerClientEvent('fishing:message', _source, "~g~Je hebt een schildpad aan je hengel gedaan. ~r~ILLEGAAL")
	else
		TriggerClientEvent('fishing:message', _source, "~r~Je hebt geen vishengel.")
	end
	
end)

ESX.RegisterUsableItem('fishingrod', function(source)

	local _source = source
	TriggerClientEvent('fishing:fishstart', _source)
	
	

end)


				
RegisterNetEvent('fishing:catch')
AddEventHandler('fishing:catch', function(bait)
	
	_source = source
	local weight = 2
	local rnd = math.random(1,100)
	xPlayer = ESX.GetPlayerFromId(_source)
	if bait == "turtle" then
		if rnd >= 78 then
			if rnd >= 94 then
				TriggerClientEvent('fishing:setbait', _source, "none")
				TriggerClientEvent('fishing:message', _source, "~r~Het was zo groot, het brak je vishengel")
				TriggerClientEvent('fishing:break', _source)
				xPlayer.removeInventoryItem('fishingrod', 1)
			else
				TriggerClientEvent('fishing:setbait', _source, "none")
				if xPlayer.getInventoryItem('turtle').count > 4 then
					TriggerClientEvent('fishing:message', _source, "~r~Je hebt teveel schildpadden")
				else
					TriggerClientEvent('fishing:message', _source, "~g~Je hebt een schildpad gevangen\n~r~Het is een bedreigde diersoort en is dus illegaal.")
					xPlayer.addInventoryItem('turtle', 1)
				end
			end
		else
			if rnd >= 75 then
				if xPlayer.getInventoryItem('fish').count > 100 then
					TriggerClientEvent('fishing:message', _source, "~r~Je kan geen vis meer bijhouden.")
				else
					weight = math.random(4,9)
					TriggerClientEvent('fishing:message', _source, "~g~Je hebt een vis gevangen: ~y~~h~" .. weight .. "kg")
					xPlayer.addInventoryItem('fish', weight)
				end
				
			else
				if xPlayer.getInventoryItem('fish').count > 100 then
					TriggerClientEvent('fishing:message', _source, "~r~Je kan geen vis meer bijhouden")
				else
					weight = math.random(2,6)
					TriggerClientEvent('fishing:message', _source, "~g~Je hebt een vis gevangen: ~y~~h~" .. weight .. "kg")
					xPlayer.addInventoryItem('fish', weight)
				end
			end
		end
	else
		if bait == "fish" then
			if rnd >= 75 then
				TriggerClientEvent('fishing:setbait', _source, "none")
				if xPlayer.getInventoryItem('fish').count > 100 then
					TriggerClientEvent('fishing:message', _source, "~r~Je kan geen vis meer bijhouden")
				else
					weight = math.random(4,11)
					TriggerClientEvent('fishing:message', _source, "~g~Je hebt vis gevangen: ~y~~h~" .. weight .. "kg")
					xPlayer.addInventoryItem('fish', weight)
				end
				
			else
				if xPlayer.getInventoryItem('fish').count > 100 then
					TriggerClientEvent('fishing:message', _source, "~r~Je kan geen vis meer bijhouden")
				else
					weight = math.random(1,6)
					TriggerClientEvent('fishing:message', _source, "~g~Je hebt vis gevangen: ~y~~h~" .. weight .. "kg")
					xPlayer.addInventoryItem('fish', weight)
				end
			end
		end
		if bait == "none" then
			
			if rnd >= 70 then
			TriggerClientEvent('fishing:message', _source, "~y~Je vist zonder aas op het moment...")
				if  xPlayer.getInventoryItem('fish').count > 100 then
						TriggerClientEvent('fishing:message', _source, "~r~Je kan geen vis meer bijhouden")
					else
						weight = math.random(2,4)
						TriggerClientEvent('fishing:message', _source, "~g~Je hebt vis gevangen: ~y~~h~" .. weight .. "kg")
						xPlayer.addInventoryItem('fish', weight)
					end
					
				else
				TriggerClientEvent('fishing:message', _source, "~y~Je vist zonder aas op het moment...")
					if xPlayer.getInventoryItem('fish').count > 100 then
						TriggerClientEvent('fishing:message', _source, "~r~Je kan geen vis meer bijhouden")
					else
						weight = math.random(1,2)
						TriggerClientEvent('fishing:message', _source, "~g~Je hebt vis gevangen: ~y~~h~" .. weight .. "kg")
						xPlayer.addInventoryItem('fish', weight)
					end
				end
		end
		if bait == "shark" then
			if rnd >= 82 then
			
						if rnd >= 91 then
							TriggerClientEvent('fishing:setbait', _source, "none")
							TriggerClientEvent('fishing:message', _source, "~r~Het was een grote vis en brak je hengel.")
							TriggerClientEvent('fishing:break', _source)
							xPlayer.removeInventoryItem('fishingrod', 1)
						else
							if xPlayer.getInventoryItem('shark').count > 0  then
									TriggerClientEvent('fishing:setbait', _source, "none")
									TriggerClientEvent('fishing:message', _source, "~r~Je hebt teveel haaien.")
							else
									TriggerClientEvent('fishing:message', _source, "~g~Je hebt een haai gevangen!\n~r~Het is een bedreigde diersoort en is dus illegaal.")
									TriggerClientEvent('fishing:spawnPed', _source)
									xPlayer.addInventoryItem('shark', 1)
							end
						end	
							else
									if xPlayer.getInventoryItem('fish').count > 100 then
										TriggerClientEvent('fishing:message', _source, "~r~Je kan geen vis meer bijhouden")
									else
										weight = math.random(4,8)
										TriggerClientEvent('fishing:message', _source, "~g~Je hebt vis gevangen: ~y~~h~" .. weight .. "kg")
										xPlayer.addInventoryItem('fish', weight)
									end
								
							end
			end
			
		end
	
	
end)

RegisterServerEvent("fishing:lowmoney")
AddEventHandler("fishing:lowmoney", function(money, token)
    local _source = source	
	if not exports['DRGNV_tokenizer']:verifyToken(GetCurrentResourceName(), _source, token, "fishing:lowmoney") then
        return
    end
	local xPlayer = ESX.GetPlayerFromId(_source)
	xPlayer.removeMoney(money)
end)

RegisterServerEvent('fishing:startSelling')
AddEventHandler('fishing:startSelling', function(item)

	local _source = source
	
	local xPlayer  = ESX.GetPlayerFromId(_source)
			if item == "fish" then
					local FishQuantity = xPlayer.getInventoryItem('fish').count
						if FishQuantity <= 4 then
						TriggerClientEvent('esx:showNotification', source, '~r~Je hebt niet genoeg~s~ vis')			
					else   
						xPlayer.removeInventoryItem('fish', 5)
						local payment = Config.FishPrice.a
						payment = math.random(Config.FishPrice.a, Config.FishPrice.b) 
						xPlayer.addMoney(payment)
						
						
			end
				

				

				
			end
			if item == "turtle" then
				local FishQuantity = xPlayer.getInventoryItem('turtle').count

				if FishQuantity <= 0 then
					TriggerClientEvent('esx:showNotification', source, '~r~Je hebt niet genoeg~s~ schildpadden')			
				else   
					xPlayer.removeInventoryItem('turtle', 1)
					local payment = Config.TurtlePrice.a
					payment = math.random(Config.TurtlePrice.a, Config.TurtlePrice.b) 
					xPlayer.addAccountMoney('black_money', payment)
					
					
				end
			end
			if item == "shark" then
				local FishQuantity = xPlayer.getInventoryItem('shark').count

				if FishQuantity <= 0 then
					TriggerClientEvent('esx:showNotification', source, '~r~Je hebt niet genoeg~s~ haaien')			
				else   
					xPlayer.removeInventoryItem('shark', 1)
					local payment = Config.SharkPrice.a
					payment = math.random(Config.SharkPrice.a, Config.SharkPrice.b)
					xPlayer.addAccountMoney('black_money', payment)
					
					
				end
			end
			
	
end)

