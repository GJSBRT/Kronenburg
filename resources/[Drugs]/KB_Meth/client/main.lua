--[[ 
	Kronenburg Roleplay
	Copyright © GJSBRT <g@gijs.eu>

	This project is licensed under the terms of the Apache License 2.0 license.
	https://choosealicense.com/licenses/apache-2.0/
]]
 
 
local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}
local started = false
local displayed = false
local progress = 0
local CurrentVehicle 
local pause = false
local selection = 0
local quality = 0
ESX = nil

local LastCar

function DisplayHelpText(str)
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(7)
	end
end)

RegisterNetEvent('esx_methcar:stop')
AddEventHandler('esx_methcar:stop', function()
	started = false
	DisplayHelpText("Productie is gestopt")
	FreezeEntityPosition(LastCar, false)
end)
RegisterNetEvent('esx_methcar:stopfreeze')
AddEventHandler('esx_methcar:stopfreeze', function(id)
	FreezeEntityPosition(id, false)
end)
RegisterNetEvent('esx_methcar:notify')
AddEventHandler('esx_methcar:notify', function(message)
	ESX.ShowNotification(message)
end)

RegisterNetEvent('esx_methcar:startprod')
AddEventHandler('esx_methcar:startprod', function()
	DisplayHelpText("Meth productie is gestart")
	started = true
	FreezeEntityPosition(CurrentVehicle,true)
	displayed = false
	print('Meth productie gestart')
	ESX.ShowNotification("Meth Productie is gestart")	
	SetPedIntoVehicle(GetPlayerPed(-1), CurrentVehicle, 3)
	SetVehicleDoorOpen(CurrentVehicle, 2)
end)

RegisterNetEvent('esx_methcar:blowup')
AddEventHandler('esx_methcar:blowup', function(posx, posy, posz)
	
	if not HasNamedPtfxAssetLoaded("core") then
		RequestNamedPtfxAsset("core")
		while not HasNamedPtfxAssetLoaded("core") do
			Citizen.Wait(7)
		end
	end
	SetPtfxAssetNextCall("core")
	local fire = StartParticleFxLoopedAtCoord("ent_ray_heli_aprtmnt_l_fire", posx, posy, posz-0.8 , 0.0, 0.0, 0.0, 0.8, false, false, false, false)
	Citizen.Wait(6000)
	StopParticleFxLooped(fire, 0)
	
end)

RegisterNetEvent('esx_methcar:cops')
AddEventHandler('esx_methcar:cops', function()
	local myPos = GetEntityCoords(PlayerPedId())
	TriggerServerEvent('esx_phone:send', 'police', 'Ik zie een verdacht voertuig waar rode rook vandaan komt. Zouden jullie even langs kunnen komen?', false, {
		x = myPos.x,
		y = myPos.y
	})
	TriggerServerEvent('esx_phone:send', 'kmar', 'Ik zie een verdacht voertuig waar rode rook vandaan komt. Zouden jullie even langs kunnen komen?', false, {
		x = myPos.x,
		y = myPos.y
	})
end)


RegisterNetEvent('esx_methcar:smoke')
AddEventHandler('esx_methcar:smoke', function(posx, posy, posz, bool)

	if bool == 'a' then

		if not HasNamedPtfxAssetLoaded("core") then
			RequestNamedPtfxAsset("core")
			while not HasNamedPtfxAssetLoaded("core") do
				Citizen.Wait(7)
			end
		end
		SetPtfxAssetNextCall("core")
		local smoke = StartParticleFxLoopedAtCoord("exp_grd_flare", posx, posy, posz + 1.0, 0.0, 0.0, 0.0, 2.0, false, false, false, false)
		SetParticleFxLoopedAlpha(smoke, 0.8)
		SetParticleFxLoopedColour(smoke, 0.0, 0.0, 0.0, 0)
		Citizen.Wait(22000)
		StopParticleFxLooped(smoke, 0)
	else
		StopParticleFxLooped(smoke, 0)
	end

end)
RegisterNetEvent('esx_methcar:drugged')
AddEventHandler('esx_methcar:drugged', function()
	SetTimecycleModifier("drug_drive_blend01")
	SetPedMotionBlur(GetPlayerPed(-1), true)
	SetPedMovementClipset(GetPlayerPed(-1), "MOVE_M@DRUNK@SLIGHTLYDRUNK", true)
	SetPedIsDrunk(GetPlayerPed(-1), true)

	Citizen.Wait(300000)
	ClearTimecycleModifier()
end)



Citizen.CreateThread(function()
	while true do
		Citizen.Wait(7)
		
		playerPed = GetPlayerPed(-1)
		local pos = GetEntityCoords(GetPlayerPed(-1))
		if IsPedInAnyVehicle(playerPed) then
			
			
			CurrentVehicle = GetVehiclePedIsUsing(PlayerPedId())

			car = GetVehiclePedIsIn(playerPed, false)
			LastCar = GetVehiclePedIsUsing(playerPed)
	
			local model = GetEntityModel(CurrentVehicle)
			local modelName = GetDisplayNameFromVehicleModel(model)
			
			if modelName == 'SPEEDO2' and car then
				
					if GetPedInVehicleSeat(car, -1) == playerPed then
						if started == false then
							if displayed == false then
								DisplayHelpText("Druk op ~INPUT_INTERACTION_MENU~ om de Drugs te maken")
								displayed = true
							end
						end
						if IsControlJustReleased(0, Keys['M']) then
							if pos.y >= -3500 then
								if IsVehicleSeatFree(CurrentVehicle, 2) then
									TriggerServerEvent('esx_methcar:start')
									progress = 0
									pause = false
									selection = 0
									quality = 0
									
								else
									DisplayHelpText('Het busje is all bezet')
								end
							else
								ESX.ShowNotification('Je bent te dichtbij de stad ga Verder weg!')
							end
							
							
							
							
		
						end
					end
					
				
				
			
			end
			
		else

				
				if started then
					started = false
					displayed = false
					TriggerEvent('esx_methcar:stop')
					print('Stopped making drugs')
					FreezeEntityPosition(LastCar,false)
				end
		end
		
		if started == true then
			
			if progress < 96 then
				Citizen.Wait(6000)
				if not pause and IsPedInAnyVehicle(playerPed) then
					progress = progress +  1
					ESX.ShowNotification('Meth Productie: ~g~~h~' .. progress .. '%')
					Citizen.Wait(6000) 
				end

				--
				--   EVENT 1
				--
				if progress > 22 and progress < 24 then
					pause = true
					if selection == 0 then
						ESX.ShowNotification('~r~De propaanleiding lekt, wat doe je?')	
						ESX.ShowNotification('] = Maken met Ductape')
						ESX.ShowNotification('[ = Laat het zoals het is ')
						ESX.ShowNotification('V = Vervangen')
						ESX.ShowNotification('~r~Druk op het Nummer wat jij denkt dat het is')
					end
					if selection == 1 then
						print("Slected 1")
						ESX.ShowNotification('de Ductape heeft het Lek gestopt')
						quality = quality - 3
						pause = false
					end
					if selection == 2 then
						print("Slected 2")
						ESX.ShowNotification('De Tank is opgeblazen, je hebt het verprutst...')
						TriggerServerEvent('esx_methcar:blow', pos.x, pos.y, pos.z)
						SetVehicleEngineHealth(CurrentVehicle, 0.0)
						quality = 0
						started = false
						displayed = false
						ApplyDamageToPed(GetPlayerPed(-1), 10, false)
						print('Stopped making drugs')
					end
					if selection == 3 then
						print("Slected 3")
						ESX.ShowNotification('Goed werk, de buis was niet in goede staat')
						pause = false
						quality = quality + 5
					end
				end
				--
				--   EVENT 5
				--
				if progress > 30 and progress < 32 then
					pause = true
					if selection == 0 then
						ESX.ShowNotification('~r~Je hebt een fles aceton op de grond gemorst, wat doe je?')	
						ESX.ShowNotification('] = Open de ramen om de geur te verwijderen')
						ESX.ShowNotification('[ = Laat het zoals het is')
						ESX.ShowNotification('V = Zet een masker op met luchtfilter')
						ESX.ShowNotification('~r~Druk op het nummer van de optie die u wilt doen')
					end
					if selection == 1 then
						print("Slected 1")
						ESX.ShowNotification('Je hebt de ramen geopend om de geur te verwijderen')
						quality = quality - 1
						pause = false
					end
					if selection == 2 then
						print("Slected 2")
						ESX.ShowNotification('Je wordt high van het te veel inhaleren van aceton')
						pause = false
						TriggerEvent('esx_methcar:drugged')
					end
					if selection == 3 then
						print("Slected 3")
						ESX.ShowNotification('Dat is een makkelijke manier om het probleem op te lossen .. denk ik')
						SetPedPropIndex(playerPed, 1, 26, 7, true)
						pause = false
					end
				end
				--
				--   EVENT 2
				--
				if progress > 38 and progress < 40 then
					pause = true
					if selection == 0 then
						ESX.ShowNotification('~r~Meth wordt te snel solide, wat doe je? ')	
						ESX.ShowNotification('] = Verhoog de druk')
						ESX.ShowNotification('[ = Verhoog de temperatuur')
						ESX.ShowNotification('V = Verlaag de druk')
						ESX.ShowNotification('~r~Druk op het nummer van de optie die u wilt doen')
					end
					if selection == 1 then
						print("Slected 1")
						ESX.ShowNotification('Je verhoogde de druk en het propaan begon te ontsnappen, je verlaagde het en het is goed voor nu')
						pause = false
					end
					if selection == 2 then
						print("Slected 2")
						ESX.ShowNotification('Het verhogen van de temperatuur hielp ...')
						quality = quality + 5
						pause = false
					end
					if selection == 3 then
						print("Slected 3")
						ESX.ShowNotification('Het verlagen van de druk maakte het alleen maar erger ...')
						pause = false
						quality = quality -4
					end
				end
				--
				--   EVENT 8 - 3
				--
				if progress > 41 and progress < 43 then
					pause = true
					if selection == 0 then
						ESX.ShowNotification('~r~Je giet per ongeluk te veel aceton, wat doe je dan?')	
						ESX.ShowNotification('] = Niets doen')
						ESX.ShowNotification('[ = Probeer het eruit te zuigen met een spuit')
						ESX.ShowNotification('V = Voeg meer lithium toe om het uit te balanceren')
						ESX.ShowNotification('~r~Druk op het nummer van de optie die u wilt doen')
					end
					if selection == 1 then
						print("Slected 1")
						ESX.ShowNotification('De meth ruikt niet veel naar aceton')
						quality = quality - 3
						pause = false
					end
					if selection == 2 then
						print("Slected 2")
						ESX.ShowNotification('Het werkte een beetje, maar het is nog steeds te veel')
						pause = false
						quality = quality - 1
					end
					if selection == 3 then
						print("Slected 3")
						ESX.ShowNotification('Je hebt beide chemicaliën met succes uitgebalanceerd en het is weer goed')
						pause = false
						quality = quality + 3
					end
				end
				--
				--   EVENT 3
				--
				if progress > 46 and progress < 49 then
					pause = true
					if selection == 0 then
						ESX.ShowNotification('~r~Je hebt wat waterverf gevonden, wat doe je?')	
						ESX.ShowNotification('] = Voeg het toe')
						ESX.ShowNotification('[ = Doe het weg')
						ESX.ShowNotification('V = Drink het')
						ESX.ShowNotification('~r~Druk op het nummer van de optie die u wilt doen')
					end
					if selection == 1 then
						print("Slected 1")
						ESX.ShowNotification('Goed idee, mensen houden van kleuren')
						quality = quality + 4
						pause = false
					end
					if selection == 2 then
						print("Slected 2")
						ESX.ShowNotification('Ja, het kan de smaak van meth vernietigen')
						pause = false
					end
					if selection == 3 then
						print("Slected 3")
						ESX.ShowNotification('Je bent een beetje raar en je voelt je duizelig, maar het is allemaal goed')
						pause = false
					end
				end
				--
				--   EVENT 4
				--
				if progress > 55 and progress < 58 then
					pause = true
					if selection == 0 then
						ESX.ShowNotification('~r~Het filter is verstopt, wat doe je?')	
						ESX.ShowNotification('] = Reinig het met perslucht')
						ESX.ShowNotification('[ = Vervang het filter')
						ESX.ShowNotification('V = Maak het schoon met een tandenborstel')
						ESX.ShowNotification('~r~Druk op het nummer van de optie die u wilt doen')
					end
					if selection == 1 then
						print("Slected 1")
						ESX.ShowNotification('Perslucht spoot de vloeibare meth over je heen')
						quality = quality - 2
						pause = false
					end
					if selection == 2 then
						print("Slected 2")
						ESX.ShowNotification('Vervangen was waarschijnlijk de beste optie')
						pause = false
						quality = quality + 3
					end
					if selection == 3 then
						print("Slected 3")
						ESX.ShowNotification('Dit werkte redelijk goed, maar het is nog steeds een beetje vies')
						pause = false
						quality = quality - 1
					end
				end
				--
				--   EVENT 5
				--
				if progress > 58 and progress < 60 then
					pause = true
					if selection == 0 then
						ESX.ShowNotification('~r~Je hebt een fles aceton op de grond gemorst, wat doe je?')	
						ESX.ShowNotification('] = Open de ramen om de geur te verwijderen')
						ESX.ShowNotification('[ = Laat het zitten')
						ESX.ShowNotification('V = Zet een masker op met luchtfilter')
						ESX.ShowNotification('~r~Druk op het nummer van de optie die u wilt doen')
					end
					if selection == 1 then
						print("Slected 1")
						ESX.ShowNotification('Je hebt de ramen geopend om de geur te verwijderen')
						quality = quality - 1
						pause = false
					end
					if selection == 2 then
						print("Slected 2")
						ESX.ShowNotification('Je wordt high van het te veel inhaleren van aceton')
						pause = false
						TriggerEvent('esx_methcar:drugged')
					end
					if selection == 3 then
						print("Slected 3")
						ESX.ShowNotification('Dat is een makkelijke manier om het probleem op te lossen .. denk ik')
						SetPedPropIndex(playerPed, 1, 26, 7, true)
						pause = false
					end
				end
				--
				--   EVENT 1 - 6
				--
				if progress > 63 and progress < 65 then
					pause = true
					if selection == 0 then
						ESX.ShowNotification('~r~De propaanleiding lekt, wat doe je?')	
						ESX.ShowNotification('] = Bevestig met tape')
						ESX.ShowNotification('[ = Laat het zitten')
						ESX.ShowNotification('V = Vervang het')
						ESX.ShowNotification('~r~Druk op het nummer van de optie die u wilt doen')
					end
					if selection == 1 then
						print("Slected 1")
						ESX.ShowNotification('De tape stopte het lek een beetje')
						quality = quality - 3
						pause = false
					end
					if selection == 2 then
						print("Slected 2")
						ESX.ShowNotification('~r~De propaantank is opgeblazen, je hebt het verprutst ...')
						TriggerServerEvent('esx_methcar:blow', pos.x, pos.y, pos.z)
						SetVehicleEngineHealth(CurrentVehicle, 0.0)
						quality = 0
						started = false
						displayed = false
						ApplyDamageToPed(GetPlayerPed(-1), 10, false)
						print('Stopte met het maken van drugs')
					end
					if selection == 3 then
						print("Slected 3")
						ESX.ShowNotification('Goed gedaan, de pijp was niet in goede staat')
						pause = false
						quality = quality + 5
					end
				end
				--
				--   EVENT 4 - 7
				--
				if progress > 71 and progress < 73 then
					pause = true
					if selection == 0 then
						ESX.ShowNotification('~r~Het filter is verstopt, wat doe je?')	
						ESX.ShowNotification('] = Reinig het met perslucht')
						ESX.ShowNotification('[ = Vervang het filter')
						ESX.ShowNotification('V = Maak het schoon met een tandenborstel')
						ESX.ShowNotification('~r~Druk op het nummer van de optie die u wilt doen')
					end
					if selection == 1 then
						print("Slected 1")
						ESX.ShowNotification('Perslucht spoot de vloeibare meth over je heen')
						quality = quality - 2
						pause = false
					end
					if selection == 2 then
						print("Slected 2")
						ESX.ShowNotification('Vervangen was waarschijnlijk de beste optie')
						pause = false
						quality = quality + 3
					end
					if selection == 3 then
						print("Slected 3")
						ESX.ShowNotification('Dit werkte redelijk goed, maar het is nog steeds een beetje vies')
						pause = false
						quality = quality - 1
					end
				end
				--
				--   EVENT 8
				--
				if progress > 76 and progress < 78 then
					pause = true
					if selection == 0 then
						ESX.ShowNotification('~r~Je giet per ongeluk te veel aceton, wat doe je dan?')	
						ESX.ShowNotification('] = niks doen')
						ESX.ShowNotification('[ = Probeer het eruit te zuigen met een spuit')
						ESX.ShowNotification('V = Voeg meer lithium toe om het uit te balanceren')
						ESX.ShowNotification('~r~Druk op het nummer van de optie die u wilt doen')
					end
					if selection == 1 then
						print("Slected 1")
						ESX.ShowNotification('De meth ruikt niet veel naar aceton')
						quality = quality - 3
						pause = false
					end
					if selection == 2 then
						print("Slected 2")
						ESX.ShowNotification('Het werkte een beetje, maar het is nog steeds te veel')
						pause = false
						quality = quality - 1
					end
					if selection == 3 then
						print("Slected 3")
						ESX.ShowNotification('Je hebt beide chemicaliën met succes uitgebalanceerd en het is weer goed')
						pause = false
						quality = quality + 3
					end
				end
				--
				--   EVENT 9
				--
				if progress > 82 and progress < 84 then
					pause = true
					if selection == 0 then
						ESX.ShowNotification('~r~Probeer het vast te houden?')	
						ESX.ShowNotification('] = Probeer het vast te houden')
						ESX.ShowNotification('[ = Ga naar buiten en maak een rotzooi')
						ESX.ShowNotification('V = Poep er in')
						ESX.ShowNotification('~r~Druk op het nummer van de optie die u wilt doen')
					end
					if selection == 1 then
						print("Slected 1")
						ESX.ShowNotification('Goed gedaan, je moet eerst werken, shit later')
						quality = quality + 1
						pause = false
					end
					if selection == 2 then
						print("Slected 2")
						ESX.ShowNotification('Terwijl je buiten was viel het glas van de tafel en morste het over de vloer ...')
						pause = false
						quality = quality - 2
					end
					if selection == 3 then
						print("Slected 3")
						ESX.ShowNotification('De lucht ruikt nu naar stront, de meth ruikt nu naar stront')
						pause = false
						quality = quality - 1
					end
				end
				--
				--   EVENT 10
				--
				if progress > 88 and progress < 90 then
					pause = true
					if selection == 0 then
						ESX.ShowNotification('~r~Voeg je wat stukjes glas toe aan de meth zodat het lijkt alsof je er meer van hebt?')	
						ESX.ShowNotification('] = Ja!')
						ESX.ShowNotification('[ = Nee')
						ESX.ShowNotification('V = Wat als ik in plaats daarvan meth aan glas toevoeg?')
						ESX.ShowNotification('~r~Druk op het nummer van de optie die u wilt doen')
					end
					if selection == 1 then
						print("Slected 1")
						ESX.ShowNotification('Nu heb je er nog een paar zakjes meer uit')
						quality = quality + 1
						pause = false
					end
					if selection == 2 then
						print("Slected 2")
						ESX.ShowNotification('Je bent een goede medicijnmaker, je product is van hoge kwaliteit')
						pause = false
						quality = quality + 1
					end
					if selection == 3 then
						print("Slected 3")
						ESX.ShowNotification('Dat is een beetje te veel, het is meer glas dan meth, maar oké')
						pause = false
						quality = quality - 1
					end
				end
				
				
				
				
				
				
				
				if IsPedInAnyVehicle(playerPed) then
					TriggerServerEvent('esx_methcar:make', pos.x,pos.y,pos.z)
					if pause == false then
						selection = 0
						quality = quality + 1
						progress = progress +  math.random(1, 2)
						ESX.ShowNotification('Meth productie: ~g~~h~' .. progress .. '%')
					end
				else
					TriggerEvent('esx_methcar:stop')
				end

			else
				TriggerEvent('esx_methcar:stop')
				progress = 100
				ESX.ShowNotification('Meth productie: ~g~~h~' .. progress .. '%')
				ESX.ShowNotification('Productie is klaar')
				TriggerServerEvent('esx_methcar:finish', quality)
				FreezeEntityPosition(LastCar, false)
			end	
			
		end
		
	end
end)
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
			if IsPedInAnyVehicle(GetPlayerPed(-1)) then
			else
				if started then
					started = false
					displayed = false
					TriggerEvent('esx_methcar:stop')
					print('Stopped making drugs')
					FreezeEntityPosition(LastCar,false)
				end		
			end
	end

end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(7)		
		if pause == true then
			if IsControlJustReleased(0, Keys[']']) then
				selection = 1
				ESX.ShowNotification('Je hebt gekozen voor optie 1')
			end
			if IsControlJustReleased(0, Keys['[']) then
				selection = 2
				ESX.ShowNotification('Je hebt gekozen voor optie 2')
			end
			if IsControlJustReleased(0, Keys[';']) then
				selection = 3
				ESX.ShowNotification('Je hebt gekozen voor optie 3')
			end
		end

	end
end)