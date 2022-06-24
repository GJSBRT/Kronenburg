--Vehicle menu script KronenburgRP
local options = {
  x = 0.90,
  y = 0.30,
  width = 0.17,
  height = 0.04,
  scale = 0.4,
  font = 0,
  menu_title = "Voertuig menu",
  color_r = 255,
  color_g = 175,
  color_b = 0,
}

local elements = {}
local menuopen = false
local isInVehicle = false
local engineon = true
local limiteur = false
speed = 0
local regulateur = 70
local raamomhoog = true
local disableShuffle = true


Citizen.CreateThread(function()
while true do
  Citizen.Wait(7)
  if IsControlJustPressed(0, 48) and IsPedInAnyVehicle(GetPlayerPed(-1)) then
          MainMenu()
          Menu.hidden = not Menu.hidden
          menuopen = not menuopen
     end
      Menu.renderGUI(options)
  end
end)

--[[
function disableSeatShuffle(flag)
	disableShuffle = flag
end]]

function Notify(text)
  SetNotificationTextEntry('STRING')
  AddTextComponentString(text)
  DrawNotification(false, false)
end

function MainMenu()
  options.menu_subtitle = "Categorieën"  
  ClearMenu()
  Menu.addButton("Motor aan/uit", "onoffengine", nil)
  Menu.addButton("Neon aan/uit", "toggleneon", nil)
  Menu.addButton("Snelheidslimiet", "MenuSpeedo", 70)
  Menu.addButton("Deuren", "DoorMenu", nil)
  Menu.addButton("Ramen", "Menuraam", nil)
  Menu.addButton("Shuff", "Shuff", nil)
  Menu.addButton("Menu sluiten", "closemenu", nil)
end

function DoorMenu()
  options.menu_subtitle = "Categorieën"  
  ClearMenu()
  Menu.addButton("Motorkap", "capot", nil)
  Menu.addButton("Kofferbak", "coffre", nil)
  Menu.addButton("Links achter", "arrieregauche", nil)
  Menu.addButton("Rechts achter", "arrieredroite", nil)
  Menu.addButton("Links voor", "avantgauche", nil)
  Menu.addButton("Rechts voor", "avantdroite", nil)
  Menu.addButton("Alle deuren open", "toute", nil)    
  Menu.addButton("Terug", "MainMenu", nil)
end

function MenuSpeedo()
if regulateur == 70 then
  options.menu_subtitle = "Snelheidsbegrenzer :  UIT"  
else
  options.menu_subtitle = "Snelheidsbegrenzer : ~b~" ..regulateur..  "~s~ KM/U"
end
  ClearMenu()
  Menu.addButton("Snelheidslimiet verhogen", "uprregu", nil)
  Menu.addButton("Snelheidslimiet velagen", "downrregu", nil)
  if regulateur > 70 then
  Menu.addButton("Snelheidslimiet uitzetten", "suprregu", nil)
  end
  Menu.addButton("Terug", "MainMenu", nil)
end

function Menuraam()
 options.menu_subtitle = "Categorieën"  
  ClearMenu()
  Menu.addButton("Links voor", "Raam1", nil)
  Menu.addButton("Rechts voor", "Raam2", nil)
  Menu.addButton("Links achter", "Raam3", nil)
  Menu.addButton("Rechts achter", "Raam4", nil)   
  Menu.addButton("Terug", "MainMenu", nil)
end

function Raam1()
    local playerPed = GetPlayerPed(-1)
    if IsPedInAnyVehicle(playerPed, false) then
        local playerCar = GetVehiclePedIsIn(playerPed, false)
		if ( GetPedInVehicleSeat( playerCar, -1 ) == playerPed ) then 
			SetEntityAsMissionEntity( playerCar, true, true )
			if ( raamomhoog ) then
				RollDownWindow(playerCar, 0)
				raamomhoog = false
			else
				RollUpWindow(playerCar, 0)
				raamomhoog = true
            end
        end 
    end
end  

function Raam2()
    local playerPed = GetPlayerPed(-1)
    if IsPedInAnyVehicle(playerPed, false) then
        local playerCar = GetVehiclePedIsIn(playerPed, false)
		if ( GetPedInVehicleSeat( playerCar, -1 ) == playerPed ) then 
			SetEntityAsMissionEntity( playerCar, true, true )
			if ( raamomhoog ) then
				RollDownWindow(playerCar, 1)
				raamomhoog = false
			else
				RollUpWindow(playerCar, 1)
				raamomhoog = true
            end
        end 
    end
end

function Raam3()
    local playerPed = GetPlayerPed(-1)
    if IsPedInAnyVehicle(playerPed, false) then
        local playerCar = GetVehiclePedIsIn(playerPed, false)
		if ( GetPedInVehicleSeat( playerCar, -1 ) == playerPed ) then 
			SetEntityAsMissionEntity( playerCar, true, true )
			if ( raamomhoog ) then
				RollDownWindow(playerCar, 2)
				raamomhoog = false
			else
				RollUpWindow(playerCar, 2)
				raamomhoog = true
            end
        end 
    end
end  

function Raam4()
    local playerPed = GetPlayerPed(-1)
    if IsPedInAnyVehicle(playerPed, false) then
        local playerCar = GetVehiclePedIsIn(playerPed, false)
		if ( GetPedInVehicleSeat( playerCar, -1 ) == playerPed ) then 
			SetEntityAsMissionEntity( playerCar, true, true )
			if ( raamomhoog ) then
				RollDownWindow(playerCar, 3)
				raamomhoog = false
			else
				RollUpWindow(playerCar, 3)
				raamomhoog = true
            end
        end 
    end
end          


function Shuff()
  ExecuteCommand('shuff')
end


function capot()
 local playerPed = GetPlayerPed(-1)
 local playerVeh = GetVehiclePedIsIn(playerPed, false)
 if ( IsPedSittingInAnyVehicle( playerPed ) ) then
    if GetVehicleDoorAngleRatio(playerVeh, 4) > 0.0 then 
       SetVehicleDoorShut(playerVeh, 4, false)
     else
       SetVehicleDoorOpen(playerVeh, 4, false)
       frontleft = true        
    end
 end
end

function coffre()
 local playerPed = GetPlayerPed(-1)
 local playerVeh = GetVehiclePedIsIn(playerPed, false)
 if ( IsPedSittingInAnyVehicle( playerPed ) ) then
    if GetVehicleDoorAngleRatio(playerVeh, 5) > 0.0 then 
       SetVehicleDoorShut(playerVeh, 5, false)
     else
       SetVehicleDoorOpen(playerVeh, 5, false)
       frontleft = true        
    end
 end
end

function maxspeed()
 local playerPed = GetPlayerPed(-1)
 local playerVeh = GetVehiclePedIsIn(playerPed, false)
 enableCruise = not enableCruise -- inverts bool
 cruiseSpeed = GetEntitySpeed(veh)  
 GetEntitySpeed(playerVeh, 10)
end

function avantgauche()
 local playerPed = GetPlayerPed(-1)
 local playerVeh = GetVehiclePedIsIn(playerPed, false)
 if ( IsPedSittingInAnyVehicle( playerPed ) ) then
    if GetVehicleDoorAngleRatio(playerVeh, 0) > 0.0 then 
       SetVehicleDoorShut(playerVeh, 0, false)
     else
       SetVehicleDoorOpen(playerVeh, 0, false)
       frontleft = true        
    end
 end
end

function MyPed()
 return GetPlayerPed(-1)
end


function avantdroite()
 local playerPed = GetPlayerPed(-1)
 local playerVeh = GetVehiclePedIsIn(playerPed, false)
 if ( IsPedSittingInAnyVehicle( playerPed ) ) then
    if GetVehicleDoorAngleRatio(playerVeh, 1) > 0.0 then 
       SetVehicleDoorShut(playerVeh, 1, false)
     else
       SetVehicleDoorOpen(playerVeh, 1, false)
       frontleft = true        
    end
 end
end

function arrieredroite()
 local playerPed = GetPlayerPed(-1)
 local playerVeh = GetVehiclePedIsIn(playerPed, false)
 if ( IsPedSittingInAnyVehicle( playerPed ) ) then
    if GetVehicleDoorAngleRatio(playerVeh, 3) > 0.0 then 
       SetVehicleDoorShut(playerVeh, 3, false)
     else
       SetVehicleDoorOpen(playerVeh, 3, false)
       frontleft = true        
    end
 end
end

function toute()
 local playerPed = GetPlayerPed(-1)
 local playerVeh = GetVehiclePedIsIn(playerPed, false)
 if ( IsPedSittingInAnyVehicle( playerPed ) ) then
    if GetVehicleDoorAngleRatio(playerVeh, 1) > 0.0 then 
       SetVehicleDoorShut(playerVeh, 5, false)        
       SetVehicleDoorShut(playerVeh, 4, false)
       SetVehicleDoorShut(playerVeh, 3, false)
       SetVehicleDoorShut(playerVeh, 2, false)
       SetVehicleDoorShut(playerVeh, 1, false)
       SetVehicleDoorShut(playerVeh, 0, false)         
     else
       SetVehicleDoorOpen(playerVeh, 5, false)        
       SetVehicleDoorOpen(playerVeh, 4, false)
       SetVehicleDoorOpen(playerVeh, 3, false)
       SetVehicleDoorOpen(playerVeh, 2, false)
       SetVehicleDoorOpen(playerVeh, 1, false)
       SetVehicleDoorOpen(playerVeh, 0, false)  
       frontleft = true        
    end
 end
end

function arrieregauche()
 local playerPed = GetPlayerPed(-1)
 local playerVeh = GetVehiclePedIsIn(playerPed, false)
 if ( IsPedSittingInAnyVehicle( playerPed ) ) then
    if GetVehicleDoorAngleRatio(playerVeh, 2) > 0.0 then 
       SetVehicleDoorShut(playerVeh, 2, false)
     else
       SetVehicleDoorOpen(playerVeh, 2, false)
       frontleft = true        
    end
 end
end

Citizen.CreateThread(function()
while true do
  Citizen.Wait(7) 
  if regulateur == 70 then
  else      
      speedo(regulateur)
    end
  end
end)

function setregul()
      local ped = GetPlayerPed(-1)
      local vehicle = GetVehiclePedIsIn(ped, false)  
      local currSpeed = GetEntitySpeed(vehicle)*3.6  
      DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "", "", "", "", "", 20)
      while (UpdateOnscreenKeyboard() == 0) do
          DisableAllControlActions(0);
          Wait(7);
      end
      if (GetOnscreenKeyboardResult()) then
          local vitesse = GetOnscreenKeyboardResult()
        if not vitesse ~= nil then
        Notify("NIL")
        else  
        local res = tonumber(vitesse)  
        if currSpeed > res then
          Notify("Je kan alleen de snelheidsbegrenzer instellen als je langzamer rijd dan ~b~70 KM/U")
      else             
          speedo(res)
          regulateur = res
          MainMenu()
          Wait(7)
          MenuSpeedo()  
          Menu.selection = 1    
          end      
        end
      end      
end

function suprregu()
print("1")
speedo(0)
regulateur = 70
MainMenu()
Wait(7)
MenuSpeedo()
Menu.selection = 2
end

function uprregu()
  local ped = GetPlayerPed(-1)
  local vehicle = GetVehiclePedIsIn(ped, false)  
  local currSpeed = GetEntitySpeed(vehicle)*3.6
  if currSpeed > regulateur then
    Notify("Je kan alleen de snelheidsbegrenzer instellen als je langzamer rijd dan ~b~70 KM/U")
  else  
regulateur = regulateur +10
MainMenu()
Wait(7)
MenuSpeedo()
end
end

function downrregu()
if regulateur < 60 then
  print('testtt')
  regulateur = 70
MainMenu()
Wait(7)
MenuSpeedo()      
else
if regulateur == 70 then
regulateur = 70
speedo(0)
else  
regulateur = regulateur -10
MainMenu()
Wait(7)
MenuSpeedo()  
Menu.selection = 1
end
end
end

function speedo(vit)
  local ped = GetPlayerPed(-1)
  local vehicle = GetVehiclePedIsIn(ped, false)  
  local currSpeed = GetEntitySpeed(vehicle)*3.6
  speed = vit/3.62
 
  local vehicleModel = GetEntityModel(vehicle)
  local float Max = GetVehicleMaxSpeed(vehicleModel)  
  if (vit == 0) then
  SetEntityMaxSpeed(vehicle, Max)
  end      
if currSpeed > vit then
else
 
  if (vit == 0) then
  SetEntityMaxSpeed(vehicle, Max)
  else
  if vit == 0 and currSpeed < 5 then  
  else
    SetEntityMaxSpeed(vehicle, speed)
end
  end
end
end

Citizen.CreateThread(function()
while true do
  Citizen.Wait(7)
      if limiteur then
        local ped = GetPlayerPed(-1)
        local vehicle = GetVehiclePedIsIn(ped, false)          
        SetEntityMaxSpeed(vehicle, speed) 
     end
  end
end)

function onoffengine()
if engineon then
 local playerPed = GetPlayerPed(-1)
 local playerVeh = GetVehiclePedIsIn(playerPed, false)
 SetVehicleEngineOn(GetVehiclePedIsIn(GetPlayerPed(-1), false), false, false)    
 engineon = false
else
 local playerPed = GetPlayerPed(-1)
 local playerVeh = GetVehiclePedIsIn(playerPed, false)
 SetVehicleEngineOn(GetVehiclePedIsIn(GetPlayerPed(-1), false), true, false)   
 engineon = true 
end
end

Citizen.CreateThread(function()
while true do
  Citizen.Wait(7)
      if not engineon then
        SetVehicleEngineOn(GetVehiclePedIsIn(GetPlayerPed(-1), false), false, false)     
     end
  end
end)

function toggleneon()
    local ped = PlayerPedId()
    local veh = GetVehiclePedIsIn(ped, false)
    if veh ~= nil and veh ~= 0 and veh ~= 1 then
		--left
        if isOn then
            SetVehicleNeonLightEnabled(veh, 0, false)
            SetVehicleNeonLightEnabled(veh, 1, false)
            SetVehicleNeonLightEnabled(veh, 2, false)
            SetVehicleNeonLightEnabled(veh, 3, false)
			
			isOn = false
        else
            SetVehicleNeonLightEnabled(veh, 0, true)
            SetVehicleNeonLightEnabled(veh, 1, true)
            SetVehicleNeonLightEnabled(veh, 2, true)
            SetVehicleNeonLightEnabled(veh, 3, true)
			
			isOn = true
        end
    end
end    

function closemenu()
  Menu.hidden = not Menu.hidden
  menuopen = not menuopen
end
--[[
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(7)
		if IsPedInAnyVehicle(GetPlayerPed(-1), false) and disableShuffle then
			if GetPedInVehicleSeat(GetVehiclePedIsIn(GetPlayerPed(-1), false), 0) == GetPlayerPed(-1) then
				if GetIsTaskActive(GetPlayerPed(-1), 165) then
					SetPedIntoVehicle(GetPlayerPed(-1), GetVehiclePedIsIn(GetPlayerPed(-1), false), 0)
				end
			end
		end
	end
end)]]

Citizen.CreateThread(function()
while true do
  Citizen.Wait(7)
  if IsControlJustPressed(1, 177) and menuopen then
          closemenu()
     end
  end
end)

local actionkey=21 --Lshift (or whatever your sprint key is bound to)
local allowshuffle = false
local playerped=nil
local currentvehicle=nil

--getting vars
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(100)
		--constantly getting the current 
		playerped=PlayerPedId()
		--constantly get player vehicle
		currentvehicle=GetVehiclePedIsIn(playerped, false)
	end
end)


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(100)
		if IsPedInAnyVehicle(playerped, false) and allowshuffle == false then
			--if they're trying to shuffle for whatever reason
			SetPedConfigFlag(playerped, 184, true)
			if GetIsTaskActive(playerped, 165) then
				--getting seat player is in 
				seat=0
				if GetPedInVehicleSeat(currentvehicle, -1) == playerped then
					seat=-1
				end
				--if the passenger doesn't shut the door, shut it manually
				--if GetVehicleDoorAngleRatio(currentvehicle,1) > 0.0 and seat == 0 then
					--SetVehicleDoorShut(currentvehicle,1,false)
				--end
				--move ped back into the seat right as the animation starts
				SetPedIntoVehicle(playerped, currentvehicle, seat)
			end
		elseif IsPedInAnyVehicle(playerped, false) and allowshuffle == true then
			SetPedConfigFlag(playerped, 184, false)
		end
	end
end)


RegisterNetEvent("SeatShuffle")
AddEventHandler("SeatShuffle", function()
	if IsPedInAnyVehicle(playerped, false) then
		--getting seat
		seat=0
		if GetPedInVehicleSeat(currentvehicle, -1) == playerped then
			seat=-1
		end
		--if they're a driver
		if GetPedInVehicleSeat(currentvehicle,-1) == playerped then
			TaskShuffleToNextVehicleSeat(playerped,currentvehicle)
		end
		--if they're a passenger
		--adding a block until they are actually in their new seat
		allowshuffle=true
		while GetPedInVehicleSeat(currentvehicle,seat) == playerped do
			Citizen.Wait(0)
		end
		allowshuffle=false
	else
		allowshuffle=false
		CancelEvent('SeatShuffle')
	end
end)




RegisterCommand("shuff", function(source, args, raw) --change command here
    TriggerEvent("SeatShuffle")
end, false)






