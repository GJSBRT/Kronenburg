--[[ 
	Kronenburg Roleplay
	Copyright © GJSBRT <g@gijs.eu>

	This project is licensed under the terms of the Apache License 2.0 license.
	https://choosealicense.com/licenses/apache-2.0/
]]
 
 


ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local health
local multi
local pulse = 70
local area = "Onbekend"
local lastHit
local blood = 100
local bleeding = 0
local dead = false
local timer = 0

local cPulse = -1
local cBlood = -1
local cNameF = ""
local cNameL = ""
local cArea = ""
local cBleeding = "GEEN"

RegisterCommand('getpulse', function(source, args)
	local health = GetEntityHealth(GetPlayerPed(-1))
	if health > 0 then
		pulse = (health / 4 + math.random(19, 28)) 
	end
	
	print(pulse)
	local hit, bone = GetPedLastDamageBone(GetPlayerPed(-1))
	print(bone)
	
end, false)

AddEventHandler('esx:onPlayerDeath', function(data)

	multi = 2.0
	blood = 100
	health = GetEntityHealth(GetPlayerPed(-1))
	area = "BENEN/ARMEN"
	local hit, bone = GetPedLastDamageBone(GetPlayerPed(-1))
	bleeding = 1
	if (bone == 31086) then
		multi = 0.0
		print('HEADSHOT')
		bleeding = 5
		area = "HOOFD"
	end
	if bone == 24817 or bone == 24818 or bone == 10706 or bone == 24816 or bone == 11816 then
		multi = 1.0
		print('BODYSHOT')
		bleeding = 2
		area = "ROMP"
	end
	
	pulse = ((health / 4 + 20) * multi) + math.random(0, 4)
	dead = true
end)

Citizen.CreateThread( function()
while true do
	Wait(5000)
	local hp = GetEntityHealth(GetPlayerPed(-1))
	if hp >= 1 and dead then
		dead = false
		bleeding = 0
		blood = 100
	end
	if dead and blood > 0 then
	blood = blood - bleeding
	end
end
end)

function DrawAdvancedText(x,y ,w,h,sc, text, r,g,b,a,font,jus)
    SetTextFont(font)
    SetTextProportional(0)
    SetTextScale(sc, sc)
	N_0x4e096588b13ffeca(jus)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,100)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
	DrawText(x - 0.1+w, y - 0.02+h)
end

RegisterNetEvent('medSystem:near')
AddEventHandler('medSystem:near', function(x,y,z, pulse, blood, nameF, nameL, area, bldn)
		
	
	local a,b,c = GetEntityCoords(GetPlayerPed(-1))
	
	if GetDistanceBetweenCoords(x,y,z,a,b,c,false) < 5 then
		timer = 10
		cBlood = blood
		cPulse = pulse
		cNameF = nameF
		cNameL = nameL
		cArea = area
		
		if bldn <= 0 then
			cBleeding = "Geen"
		elseif bldn <= 1 then
			cBleeding = "Weinig"
		elseif bldn < 5 then
			cBleeding = "Gemiddeld"
		elseif bldn >= 5 then
			cBleeding = "Veel"
		end
		
	else
		timer = 0
		cBlood = -1
		cPulse = -1
		cNameF = ""
		cNameL = ""
		cArea = ""
		cBleeding = "Weinig"
	end
	

end)

Citizen.CreateThread( function()
	while true do
		Wait(1)
			while timer >= 1 do
				Wait(1)
				if cPulse ~= -1 and cBlood ~= -1 then
					DrawAdvancedText(0.7, 0.8, 0.005, 0.0028, 0.6, cNameF .. " " .. cNameL .. "\n~r~Hartslag: ~w~" .. cPulse .. "BPM\n~r~Bloed: ~w~" .. cBlood .. "%~r~\nGebied: ~w~" .. cArea .. "\n~r~Bloeding: ~w~" .. cBleeding, 255, 255, 255, 255, 4, 1)
					
				end
			end
	end
end)

Citizen.CreateThread( function()
	while true do
		Wait(1000)
		if timer >= 1 then
			timer = timer - 1
		end	
	end
end)

RegisterNetEvent('medSystem:send')
AddEventHandler('medSystem:send', function(req)
		
	
	local health = GetEntityHealth(GetPlayerPed(-1))
	if health > 0 then
		pulse = (health / 4 + math.random(19, 28)) 
	end
	local a, b, c = table.unpack(GetEntityCoords(GetPlayerPed(-1)))

	print(a)
	TriggerServerEvent('medSystem:print', req, math.floor(pulse * (blood / 90)), area, blood, a, b, c, bleeding)

end)