--[[ 
	Kronenburg Roleplay
	Copyright © GJSBRT <g@gijs.eu>

	This project is licensed under the terms of the Apache License 2.0 license.
	https://choosealicense.com/licenses/apache-2.0/
]]
 
 
Citizen.CreateThread(function()
  SetMapZoomDataLevel(0, 0.96, 0.9, 0.08, 0.0, 0.0)
  SetMapZoomDataLevel(1, 1.6, 0.9, 0.08, 0.0, 0.0)
  SetMapZoomDataLevel(2, 8.6, 0.9, 0.08, 0.0, 0.0)
  SetMapZoomDataLevel(3, 12.3, 0.9, 0.08, 0.0, 0.0)
  SetMapZoomDataLevel(4, 22.3, 0.9, 0.08, 0.0, 0.0)
end)

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(1)
    if IsPedOnFoot(GetPlayerPed(-1)) then
      SetRadarZoom(1100)
    elseif IsPedInAnyVehicle(GetPlayerPed(-1), true) then
      SetRadarZoom(1100)
    end
  end
end)
