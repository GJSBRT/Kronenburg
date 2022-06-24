ESX = nil
local isUiOpen    = false
local speedBuffer = {}
local velBuffer   = {}
local beltOn      = false
local wasInCar    = false

Citizen.CreateThread(function()
  while ESX == nil do
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    Citizen.Wait(7)
  end
end)

IsCar = function(veh)
  local vc = GetVehicleClass(veh)
  return (vc >= 0 and vc <= 7) or (vc >= 9 and vc <= 12) or (vc >= 15 and vc <= 20)
end

Fwv = function(entity)
  local hr = GetEntityHeading(entity) + 90.0
  if hr < 0.0 then hr = 360.0 + hr end
  hr = hr * 0.0174533
  return { x = math.cos(hr) * 2.0, y = math.sin(hr) * 2.0 }
end

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(7)

    local ped = GetPlayerPed(-1)
    local car = GetVehiclePedIsIn(ped)

    if car ~= 0 and (wasInCar or IsCar(car)) then
      wasInCar = true
      if isUiOpen == false and not IsPlayerDead(PlayerId()) then
        SendNUIMessage({
          displayWindow = 'true'
        })
        isUiOpen = true
      end

      if beltOn then DisableControlAction(0, 75) end

      speedBuffer[2] = speedBuffer[1]
      speedBuffer[1] = GetEntitySpeed(car)

      if speedBuffer[2] ~= nil
          and not beltOn
          and GetEntitySpeedVector(car, true).y > 1.0
          and speedBuffer[1] > 19.25
          and (speedBuffer[2] - speedBuffer[1]) > (speedBuffer[1] * 0.255) then

        local co = GetEntityCoords(ped)
        local fw = Fwv(ped)
        SetEntityCoords(ped, co.x + fw.x, co.y + fw.y, co.z - 0.47, true, true, true)
        SetEntityVelocity(ped, velBuffer[2].x, velBuffer[2].y, velBuffer[2].z)
        Citizen.Wait(7)
        SetPedToRagdoll(ped, 1000, 1000, 0, 0, 0, 0)
      end

      velBuffer[2] = velBuffer[1]
      velBuffer[1] = GetEntityVelocity(car)

      if IsControlJustReleased(0, 183) and GetLastInputMethod(0) then
        beltOn = not beltOn
        if beltOn then
          ESX.ShowNotification('~g~Gordel Omgedaan', 100)

          SendNUIMessage({
            displayWindow = 'false'
          })
          isUiOpen = true
        else
          ESX.ShowNotification('~r~Gordel Afgedaan', 100)

          SendNUIMessage({
            displayWindow = 'true'
          })
          isUiOpen = true
        end
      end

    elseif wasInCar then
      wasInCar = false
      beltOn = false
      speedBuffer[1], speedBuffer[2] = 0.0, 0.0
      if isUiOpen == true and not IsPlayerDead(PlayerId()) then
        SendNUIMessage({
          displayWindow = 'false'
        })
        isUiOpen = false
      end
    end

  end
end)

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(100)
    if IsPlayerDead(PlayerId()) and isUiOpen == true then
      SendNUIMessage({
        displayWindow = 'false'
      })
      isUiOpen = false
    end
  end
end)

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(250)
    if not beltOn and wasInCar == true then
      TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 0.5, 'seatbelt', 0.05)
      Citizen.Wait(2000)
    end
  end
end)
