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

local PlayerData              = {}
local GUI                     = {}
local HasAlreadyEnteredMarker = false
local LastStation             = nil
local LastPart                = nil
local LastPartNum             = nil
local LastEntity              = nil
local CurrentAction           = nil
local CurrentActionMsg        = ''
local CurrentActionData       = {}
local IsDragged               = false

ESX      = nil
GUI.Time = 0

Citizen.CreateThread(function()
  while ESX == nil do
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    Citizen.Wait(0)
  end
end)

function SetVehicleMaxMods(vehicle)

  local props = {
    modEngine       = 2,
    modBrakes       = 2,
    modTransmission = 2,
    modSuspension   = 3,
    modTurbo        = true,
  }

  ESX.Game.SetVehicleProperties(vehicle, props)

end

function RespawnPed(ped, coords)
  SetEntityCoordsNoOffset(ped, coords.x, coords.y, coords.z, false, false, false, true)
  NetworkResurrectLocalPlayer(coords.x, coords.y, coords.z, coords.heading, true, false)
  SetPlayerInvincible(ped, false)
  TriggerEvent('playerSpawned', coords.x, coords.y, coords.z, coords.heading)
  ClearPedBloodDamage(ped)
  if RespawnToHospitalMenu ~= nil then
    RespawnToHospitalMenu.close()
    RespawnToHospitalMenu = nil
  end
  ESX.UI.Menu.CloseAll()
end

local vvestje = false
local bodyarmor = false
local geelvvestje = false
function OpenCloakroomMenu()

  local elements = {
    { label = _U('citizen_wear'), value = 'citizen_wear' },
    { label = 'Brandweer kleding', value = 'ambulance_wear' },
    { label = 'Brandpak', value = 'brandpak' },

    { label = '--- Extra\'s ---', value = '-' },

    { label = 'Motor helm', value = 'motorhelm' },
    { label = 'Kogelvrijvest (donker)', value = 'bodyarmor' },
    { label = 'Veiligheidvest (donker)', value = 'vestje' },
    { label = 'Veiligheidvest (geel)', value = 'vestjegeel' },
  }

  ESX.UI.Menu.CloseAll()

  if Config.EnableNonFreemodePeds then
    table.insert(elements, { label = _U('mems_clothes_ems'), value = 'mamb_wear' })
    table.insert(elements, { label = _U('fems_clothes_ems'), value = 'famb_wear' })
    table.insert(elements, { label = _U('fire_clothes'), value = 'fire_cloth' })

  end

  ESX.UI.Menu.Open(
    'default', GetCurrentResourceName(), 'cloakroom',
    {
      title    = _U('cloakroom'),
      align    = 'bottom-right',
      elements = elements,
    },

    function(data, menu)

      menu.close()
      if data.current.value == 'brandpak' then
        exports["rp-radio"]:SetRadio(true)
        exports["rp-radio"]:GivePlayerAccessToFrequencies(1, 2, 3, 7, 10)

        ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
          print(ESX.DumpTable(jobSkin))
          TriggerServerEvent('fireDispatch:registerPlayer', GetPlayerServerId(-1), true)
          if skin.sex == 0 then
            TriggerEvent('skinchanger:loadClothes', skin, Config.BrandweerActieKleding)
          else
            TriggerEvent('skinchanger:loadClothes', skin, Config.BrandweerActieKleding)
          end

        end)
      end
      if data.current.value == 'bodyarmor' then
        if not bodyarmor then
          TriggerEvent('skinchanger:loadSkin', {
            skin = 0,
            sex = 0,
            bproof_1 = 26
          })
          geelvvestje = true
          vvestje = true
          bodyarmor = true
        else
          TriggerEvent('skinchanger:loadSkin', {
            skin = 0,
            sex = 0,
            decals_1 = 0,
            decals_2 = 0,
            bproof_1 = 0
          })
          geelvvestje = false
          vvestje = false
          bodyarmor = false
        end
      end
      if data.current.value == 'vestje' then
        if not vvestje then
          TriggerEvent('skinchanger:loadSkin', {
            skin = 0,
            sex = 0,
            decals_1 = 45,
            decals_2 = 10,
          })

          geelvvestje = true
          vvestje = true
        else
          TriggerEvent('skinchanger:loadSkin', {
            skin = 0,
            sex = 0,
            decals_1 = 0,
            decals_2 = 0,
          })
          geelvvestje = false
          vvestje = false
        end
      end
      if data.current.value == 'motorhelm' then
        TriggerEvent('skinchanger:loadSkin', {
          skin = 0,
          sex = 0,
          helmet_1 = 17,
          helmet_2 = 3
        })
      end
      if data.current.value == 'vestjegeel' then
        if not geelvvestje then
          TriggerEvent('skinchanger:loadSkin', {
            skin = 0,
            sex = 0,
            decals_1 = 45,
            decals_2 = 0,
          })
          geelvvestje = true
          vvestje = true
        else
          TriggerEvent('skinchanger:loadSkin', {
            skin = 0,
            sex = 0,
            decals_1 = 0,
            decals_2 = 0,
          })
          geelvvestje = false
          vvestje = false
        end
      end



      if data.current.value == 'citizen_wear' then
        ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
          TriggerServerEvent('fireDispatch:registerPlayer', GetPlayerServerId(PlayerId()), false)
          local model = nil

          if skin.sex == 0 then
            model = GetHashKey("mp_m_freemode_01")
          else
            model = GetHashKey("mp_f_freemode_01")
          end

          RequestModel(model)
          while not HasModelLoaded(model) do
            RequestModel(model)
            Citizen.Wait(1)
          end

          SetPlayerModel(PlayerId(), model)
          SetModelAsNoLongerNeeded(model)

          TriggerEvent('skinchanger:loadSkin', skin)
          TriggerEvent('esx:restoreLoadout')
        end)
      end

      if data.current.value == 'ambulance_wear' then

        ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
          TriggerServerEvent('fireDispatch:registerPlayer', GetPlayerServerId(-1), true)
          if skin.sex == 0 then
            TriggerEvent('skinchanger:loadClothes', skin, jobSkin.skin_male)
          else
            TriggerEvent('skinchanger:loadClothes', skin, jobSkin.skin_female)
          end

        end)

      end



      if data.current.value == 'famb_wear' then

        ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)

          if skin.sex == 0 then

            local model = GetHashKey("s_f_y_scrubs_01")

            RequestModel(model)
            while not HasModelLoaded(model) do
              RequestModel(model)
              Citizen.Wait(0)
            end

            SetPlayerModel(PlayerId(), model)
            SetModelAsNoLongerNeeded(model)
          else
            local model = GetHashKey("s_f_y_scrubs_01")

            RequestModel(model)
            while not HasModelLoaded(model) do
              RequestModel(model)
              Citizen.Wait(0)
            end

            SetPlayerModel(PlayerId(), model)
            SetModelAsNoLongerNeeded(model)
          end

        end)
      end

      if data.current.value == 'mamb_wear' then

        ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)

          if skin.sex == 0 then

            local model = GetHashKey("S_M_M_Paramedic_01")

            RequestModel(model)
            while not HasModelLoaded(model) do
              RequestModel(model)
              Citizen.Wait(0)
            end

            SetPlayerModel(PlayerId(), model)
            SetModelAsNoLongerNeeded(model)
          else
            local model = GetHashKey("S_M_M_Paramedic_01")

            RequestModel(model)
            while not HasModelLoaded(model) do
              RequestModel(model)
              Citizen.Wait(0)
            end

            SetPlayerModel(PlayerId(), model)
            SetModelAsNoLongerNeeded(model)
          end

        end)
      end

      if data.current.value == 'fire_cloth' then

        ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)

          if skin.sex == 0 then

            local model = GetHashKey("s_m_y_fireman_01")

            RequestModel(model)
            while not HasModelLoaded(model) do
              RequestModel(model)
              Citizen.Wait(0)
            end

            SetPlayerModel(PlayerId(), model)
            SetModelAsNoLongerNeeded(model)
          else
            local model = GetHashKey("s_m_y_fireman_01")

            RequestModel(model)
            while not HasModelLoaded(model) do
              RequestModel(model)
              Citizen.Wait(0)
            end

            SetPlayerModel(PlayerId(), model)
            SetModelAsNoLongerNeeded(model)
          end
        end)
      end

      CurrentAction     = 'menu_cloakroom'
      CurrentActionMsg  = _U('open_cloackroom')
      CurrentActionData = {}

    end,
    function(data, menu)

      menu.close()

      CurrentAction     = 'menu_cloakroom'
      CurrentActionMsg  = _U('open_cloackroom')
      CurrentActionData = {}
    end
  )

end

function OpenArmoryMenu(station)

  if Config.EnableArmoryManagement then

    local elements = {
      { label = _U('get_weapon'), value = 'get_weapon' },
      { label = _U('put_weapon'), value = 'put_weapon' },
      { label = _U('evidence_out'), value = 'get_stock' },
      { label = _U('evidence_in'), value = 'put_stock' }
    }

    if PlayerData.job.grade_name == 'boss' then
      table.insert(elements, { label = _U('buy_weapons'), value = 'buy_weapons' })
    end

    ESX.UI.Menu.CloseAll()

    ESX.UI.Menu.Open(
      'default', GetCurrentResourceName(), 'armory',
      {
        title    = _U('armory'),
        align    = 'bottom-right',
        elements = elements,
      },
      function(data, menu)

        if data.current.value == 'get_weapon' then
          OpenGetWeaponMenu()
        end

        if data.current.value == 'put_weapon' then
          OpenPutWeaponMenu()
        end

        if data.current.value == 'buy_weapons' then
          OpenBuyWeaponsMenu(station)
        end

        if data.current.value == 'put_stock' then
          OpenPutStocksMenu()
        end

        if data.current.value == 'get_stock' then
          OpenGetStocksMenu()
        end

      end,
      function(data, menu)

        menu.close()

        CurrentAction     = 'menu_armory'
        CurrentActionMsg  = _U('open_armory')
        CurrentActionData = { station = station }
      end
    )

  else

    local elements = {}

    for i = 1, #Config.FireStations[station].AuthorizedWeapons, 1 do
      local weapon = Config.FireStations[station].AuthorizedWeapons[i]
      table.insert(elements, { label = ESX.GetWeaponLabel(weapon.name), value = weapon.name })
    end

    ESX.UI.Menu.CloseAll()

    ESX.UI.Menu.Open(
      'default', GetCurrentResourceName(), 'armory',
      {
        title    = _U('armory'),
        align    = 'bottom-right',
        elements = elements,
      },
      function(data, menu)
        local weapon = data.current.value
        TriggerServerEvent('esx_firejob:giveWeapon', weapon, 1000)
      end,
      function(data, menu)

        menu.close()

        CurrentAction     = 'menu_armory'
        CurrentActionMsg  = _U('open_armory')
        CurrentActionData = { station = station }

      end
    )

  end

end

function OpenVehicleSpawnerMenu(station, partNum)

  local vehicles = Config.FireStations[station].Vehicles

  ESX.UI.Menu.CloseAll()

  if Config.EnableSocietyOwnedVehicles then

    local elements = {}

    ESX.TriggerServerCallback('esx_society:getVehiclesInGarage', function(garageVehicles)

      for i = 1, #garageVehicles, 1 do
        table.insert(elements, { label = GetDisplayNameFromVehicleModel(garageVehicles[i].model) .. ' [' .. garageVehicles[i].plate .. ']', value = garageVehicles[i] })
      end

      ESX.UI.Menu.Open(
        'default', GetCurrentResourceName(), 'vehicle_spawner',
        {
          title    = _U('vehicle_menu'),
          align    = 'bottom-right',
          elements = elements,
        },
        function(data, menu)

          menu.close()

          local vehicleProps = data.current.value

          ESX.Game.SpawnVehicle(vehicleProps.model, vehicles[partNum].SpawnPoint, 270.0, function(vehicle)
            ESX.Game.SetVehicleProperties(vehicle, vehicleProps)
            TriggerServerEvent("pepperspray:addVehiclePlate", GetVehicleNumberPlateText(vehicle))
            Wait(200)
            local playerPed = GetPlayerPed(-1)
            TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
          end)

          TriggerServerEvent('esx_society:removeVehicleFromGarage', 'fire', vehicleProps)

        end,
        function(data, menu)

          menu.close()

          CurrentAction     = 'menu_vehicle_spawner'
          CurrentActionMsg  = _U('vehicle_spawner')
          CurrentActionData = { station = station, partNum = partNum }

        end
      )

    end, 'fire')

  else

    local elements = {}

    for i = 1, #Config.FireStations[station].AuthorizedVehicles, 1 do
      local vehicle = Config.FireStations[station].AuthorizedVehicles[i]
      table.insert(elements, { label = vehicle.label, value = vehicle.name })
    end

    ESX.UI.Menu.Open(
      'default', GetCurrentResourceName(), 'vehicle_spawner',
      {
        title    = _U('vehicle_menu'),
        align    = 'bottom-right',
        elements = elements,
      },
      function(data, menu)

        menu.close()

        local model = data.current.value

        local vehicle = GetClosestVehicle(vehicles[partNum].SpawnPoint.x, vehicles[partNum].SpawnPoint.y, vehicles[partNum].SpawnPoint.z, 3.0, 0, 71)

        if not DoesEntityExist(vehicle) then

          local playerPed = GetPlayerPed(-1)

          if Config.MaxInService == -1 then

            ESX.Game.SpawnVehicle(model, {
              x = vehicles[partNum].SpawnPoint.x,
              y = vehicles[partNum].SpawnPoint.y,
              z = vehicles[partNum].SpawnPoint.z
            }, vehicles[partNum].Heading, function(vehicle)
              TriggerServerEvent("pepperspray:addVehiclePlate", GetVehicleNumberPlateText(vehicle))
              Wait(200)
              TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
              SetVehicleMaxMods(vehicle)
            end)

          else

            ESX.TriggerServerCallback('esx_service:enableService', function(canTakeService, maxInService, inServiceCount)

              if canTakeService then

                ESX.Game.SpawnVehicle(model, {
                  x = vehicles[partNum].SpawnPoint.x,
                  y = vehicles[partNum].SpawnPoint.y,
                  z = vehicles[partNum].SpawnPoint.z
                }, vehicles[partNum].Heading, function(vehicle)
                  TriggerServerEvent("pepperspray:addVehiclePlate", GetVehicleNumberPlateText(vehicle))
                  Wait(200)
                  TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
                  SetVehicleMaxMods(vehicle)
                end)

              else
                ESX.ShowNotification(_U('service_max') .. inServiceCount .. '/' .. maxInService)
              end

            end, 'fire')

          end

        else
          ESX.ShowNotification(_U('vehicle_out'))
        end

      end,
      function(data, menu)

        menu.close()

        CurrentAction     = 'menu_vehicle_spawner'
        CurrentActionMsg  = _U('vehicle_spawner')
        CurrentActionData = { station = station, partNum = partNum }

      end
    )

  end

end

function OpenFireActionsMenu()

  ESX.UI.Menu.CloseAll()

  ESX.UI.Menu.Open(
    'default', GetCurrentResourceName(), 'fire_actions',
    {
      title    = '🚨 Brandweer',
      align    = 'bottom-right',
      elements = {
        { label = '🧔 Burger interacties', value = 'citizen_interaction' },
        { label = '🚗 Voertuig interacties', value = 'vehicle_interaction' },
        { label = '📦 Object spawn', value = 'object_spawner' },
      },
    },
    function(data, menu)
      if data.current.value == 'citizen_interaction' then

        ESX.UI.Menu.Open(
          'default', GetCurrentResourceName(), 'citizen_interaction',
          {
            title    = _U('citizen_interaction'),
            align    = 'bottom-right',
            elements = {
              { label = 'ID Kaart', value = 'identity_card' },
              { label = 'Brandslang uitpakken', value = 'brandslang' },
              { label = _U('drag'), value = 'drag' },
              { label = 'Plaats persoon in voertuig', value = 'put_in_vehicle' },
              { label = 'Haal persoon uit voertuig', value = 'out_the_vehicle' }
            },
          },
          function(data2, menu2)

            local player, distance = ESX.Game.GetClosestPlayer()

            if distance ~= -1 and distance <= 3.0 then
              if data2.current.value == 'identity_card' then
                OpenIdentityCardMenu(player)
              end

              if data2.current.value == 'brandslang' then
                TriggerEvent("Client:HoseCommand", true)
              end

              if data2.current.value == 'drag' then
                TriggerServerEvent('esx_firejob:drag', GetPlayerServerId(player))
              end

              if data2.current.value == 'put_in_vehicle' then
                TriggerServerEvent('esx_firejob:putInVehicle', GetPlayerServerId(player))
              end

              if data2.current.value == 'out_the_vehicle' then
                TriggerServerEvent('esx_firejob:OutVehicle', GetPlayerServerId(player))
              end

              if data2.current.value == 'revive' then
                menu.close()

                local ped    = GetPlayerPed(player)
                local health = GetEntityHealth(ped)

                if health == 0 then

                  local playerPed        = GetPlayerPed(-1)
                  local closestPlayerPed = GetPlayerPed(player)

                  Citizen.CreateThread(function()

                    ESX.ShowNotification(_U('revive_inprogress'))

                    TaskStartScenarioInPlace(playerPed, 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)
                    Citizen.Wait(10000)
                    ClearPedTasks(playerPed)

                    if GetEntityHealth(closestPlayerPed) == 0 then
                      TriggerServerEvent('esx_firejob:revive', GetPlayerServerId(player))
                      ESX.ShowNotification(_U('revive_complete') .. GetPlayerName(player))
                    else
                      ESX.ShowNotification(GetPlayerName(player) .. _U('isdead'))
                    end

                  end)

                else
                  ESX.ShowNotification(GetPlayerName(player) .. _U('unconscious'))
                end

              end

            else
              ESX.ShowNotification(_U('no_players_nearby'))
            end

          end,
          function(data2, menu2)
            menu2.close()
          end
        )

      end

      if data.current.value == 'vehicle_interaction' then

        ESX.UI.Menu.Open(
          'default', GetCurrentResourceName(), 'vehicle_interaction',
          {
            title    = _U('vehicle_interaction'),
            align    = 'bottom-right',
            elements = {
              { label = _U('vehicle_info'), value = 'vehicle_infos' },
              { label = _U('pick_lock'), value = 'hijack_vehicle' },
            },
          },
          function(data2, menu2)
            local playerPed = GetPlayerPed(-1)
            local coords    = GetEntityCoords(playerPed)
            local vehicle   = GetClosestVehicle(coords.x, coords.y, coords.z, 3.0, 0, 71)

            if DoesEntityExist(vehicle) then
              local vehicleData = ESX.Game.GetVehicleProperties(vehicle)

              if data2.current.value == 'vehicle_infos' then
                OpenVehicleInfosMenu(vehicleData)
              end

              if data2.current.value == 'hijack_vehicle' then
                local playerPed = GetPlayerPed(-1)
                local coords    = GetEntityCoords(playerPed)

                if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 3.0) then
                  local vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 3.0, 0, 71)
                  if DoesEntityExist(vehicle) then
                    Citizen.CreateThread(function()
                      TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_WELDING", 0, true)
                      Wait(20000)
                      ClearPedTasksImmediately(playerPed)
                      SetVehicleDoorsLocked(vehicle, 1)
                      SetVehicleDoorsLockedForAllPlayers(vehicle, false)
                      TriggerEvent('esx:showNotification', _U('vehicle_unlocked'))
                    end)
                  end
                end
              end
            else
              ESX.ShowNotification(_U('no_vehicles_nearby'))
            end
          end,
          function(data2, menu2)
            menu2.close()
          end
        )

      end

      if data.current.value == 'object_spawner' then

        ESX.UI.Menu.Open(
          'default', GetCurrentResourceName(), 'citizen_interaction',
          {
            title    = _U('traffic_interaction'),
            align    = 'bottom-right',
            elements = {
              { label = _U('cone'), value = 'prop_roadcone02a' },
              { label = _U('barrier'), value = 'prop_barrier_work06a' }
            },
          },
          function(data2, menu2)


            local model     = data2.current.value
            local playerPed = GetPlayerPed(-1)
            local coords    = GetEntityCoords(playerPed)
            local forward   = GetEntityForwardVector(playerPed)
            local x, y, z   = table.unpack(coords + forward * 1.0)

            if model == 'prop_roadcone02a' then
              z = z - 2.0
            end

            ESX.Game.SpawnObject(model, {
              x = x,
              y = y,
              z = z
            }, function(obj)
              SetEntityHeading(obj, GetEntityHeading(playerPed))
              PlaceObjectOnGroundProperly(obj)
            end)
          end,
          function(data2, menu2)
            menu2.close()
          end
        )
      end
    end,
    function(data, menu)
      menu.close()
    end
  )

end

function OpenIdentityCardMenu(player)

  if Config.EnableESXIdentity then

    ESX.TriggerServerCallback('esx_firejob:getOtherPlayerData', function(data)

      local jobLabel    = nil
      local sexLabel    = nil
      local sex         = nil
      local dobLabel    = nil
      local heightLabel = nil
      local idLabel     = nil

      if data.job.grade_label ~= nil and data.job.grade_label ~= '' then
        jobLabel = 'Baan : ' .. data.job.label .. ' - ' .. data.job.grade_label
      else
        jobLabel = 'Baan : ' .. data.job.label
      end

      if data.sex ~= nil then
        if (data.sex == 'm') or (data.sex == 'M') then
          sex = 'Man'
        else
          sex = 'Vrouw'
        end
        sexLabel = 'Geslacht : ' .. sex
      else
        sexLabel = 'Geslacht : Unknown'
      end

      if data.dob ~= nil then
        dobLabel = 'DOB : ' .. data.dob
      else
        dobLabel = 'DOB : Unknown'
      end

      if data.height ~= nil then
        heightLabel = 'Height : ' .. data.height
      else
        heightLabel = 'Height : Unknown'
      end

      if data.name ~= nil then
        idLabel = 'ID : ' .. data.name
      else
        idLabel = 'ID : Unknown'
      end

      local elements = {
        { label = _U('name') .. data.firstname .. " " .. data.lastname, value = nil },
        { label = sexLabel, value = nil },
        { label = dobLabel, value = nil },
        { label = heightLabel, value = nil },
        { label = jobLabel, value = nil },
        { label = idLabel, value = nil },
      }

      if data.drunk ~= nil then
        table.insert(elements, { label = _U('bac') .. data.drunk .. '%', value = nil })
      end

      if data.licenses ~= nil then

        table.insert(elements, { label = '--- Licenses ---', value = nil })

        for i = 1, #data.licenses, 1 do
          table.insert(elements, { label = data.licenses[i].label, value = nil })
        end

      end

      ESX.UI.Menu.Open(
        'default', GetCurrentResourceName(), 'citizen_interaction',
        {
          title    = _U('citizen_interaction'),
          align    = 'bottom-right',
          elements = elements,
        },
        function(data, menu)

        end,
        function(data, menu)
          menu.close()
        end
      )

    end, GetPlayerServerId(player))

  else

    ESX.TriggerServerCallback('esx_firejob:getOtherPlayerData', function(data)

      local jobLabel = nil

      if data.job.grade_label ~= nil and data.job.grade_label ~= '' then
        jobLabel = 'Job : ' .. data.job.label .. ' - ' .. data.job.grade_label
      else
        jobLabel = 'Job : ' .. data.job.label
      end

      local elements = {
        { label = _U('name') .. data.name, value = nil },
        { label = jobLabel, value = nil },
      }

      if data.drunk ~= nil then
        table.insert(elements, { label = _U('bac') .. data.drunk .. '%', value = nil })
      end

      if data.licenses ~= nil then

        table.insert(elements, { label = '--- Licenses ---', value = nil })

        for i = 1, #data.licenses, 1 do
          table.insert(elements, { label = data.licenses[i].label, value = nil })
        end

      end

      ESX.UI.Menu.Open(
        'default', GetCurrentResourceName(), 'citizen_interaction',
        {
          title    = _U('citizen_interaction'),
          align    = 'bottom-right',
          elements = elements,
        },
        function(data, menu)

        end,
        function(data, menu)
          menu.close()
        end
      )

    end, GetPlayerServerId(player))

  end

end

function OpenVehicleInfosMenu(vehicleData)

  ESX.TriggerServerCallback('esx_firejob:getVehicleInfos', function(infos)

    local elements = {}

    table.insert(elements, { label = _U('plate') .. infos.plate, value = nil })

    if infos.owner == nil then
      table.insert(elements, { label = _U('owner_unknown'), value = nil })
    else
      table.insert(elements, { label = _U('owner') .. infos.owner, value = nil })
    end

    ESX.UI.Menu.Open(
      'default', GetCurrentResourceName(), 'vehicle_infos',
      {
        title    = _U('vehicle_info'),
        align    = 'bottom-right',
        elements = elements,
      },
      nil,
      function(data, menu)
        menu.close()
      end
    )

  end, vehicleData.plate)

end

function OpenGetWeaponMenu()

  ESX.TriggerServerCallback('esx_firejob:getArmoryWeapons', function(weapons)

    local elements = {}

    for i = 1, #weapons, 1 do
      if weapons[i].count > 0 then
        table.insert(elements, { label = 'x' .. weapons[i].count .. ' ' .. ESX.GetWeaponLabel(weapons[i].name), value = weapons[i].name })
      end
    end

    ESX.UI.Menu.Open(
      'default', GetCurrentResourceName(), 'armory_get_weapon',
      {
        title    = _U('get_weapon_menu'),
        align    = 'bottom-right',
        elements = elements,
      },
      function(data, menu)

        menu.close()

        ESX.TriggerServerCallback('esx_firejob:removeArmoryWeapon', function()
          OpenGetWeaponMenu()
        end, data.current.value)

      end,
      function(data, menu)
        menu.close()
      end
    )

  end)

end

function OpenPutWeaponMenu()

  local elements   = {}
  local playerPed  = GetPlayerPed(-1)
  local weaponList = ESX.GetWeaponList()

  for i = 1, #weaponList, 1 do

    local weaponHash = GetHashKey(weaponList[i].name)

    if HasPedGotWeapon(playerPed, weaponHash, false) and weaponList[i].name ~= 'WEAPON_UNARMED' then
      local ammo = GetAmmoInPedWeapon(playerPed, weaponHash)
      table.insert(elements, { label = weaponList[i].label, value = weaponList[i].name })
    end

  end

  ESX.UI.Menu.Open(
    'default', GetCurrentResourceName(), 'armory_put_weapon',
    {
      title    = _U('put_weapon_menu'),
      align    = 'bottom-right',
      elements = elements,
    },
    function(data, menu)

      menu.close()

      ESX.TriggerServerCallback('esx_firejob:addArmoryWeapon', function()
        OpenPutWeaponMenu()
      end, data.current.value)

    end,
    function(data, menu)
      menu.close()
    end
  )

end

function OpenBuyWeaponsMenu(station)

  ESX.TriggerServerCallback('esx_firejob:getArmoryWeapons', function(weapons)

    local elements = {}

    for i = 1, #Config.FireStations[station].AuthorizedWeapons, 1 do

      local weapon = Config.FireStations[station].AuthorizedWeapons[i]
      local count  = 0

      for i = 1, #weapons, 1 do
        if weapons[i].name == weapon.name then
          count = weapons[i].count
          break
        end
      end

      table.insert(elements, { label = 'x' .. count .. ' ' .. ESX.GetWeaponLabel(weapon.name) .. ' $' .. weapon.price, value = weapon.name, price = weapon.price })

    end

    ESX.UI.Menu.Open(
      'default', GetCurrentResourceName(), 'armory_buy_weapons',
      {
        title    = _U('buy_weapon_menu'),
        align    = 'bottom-right',
        elements = elements,
      },
      function(data, menu)

        ESX.TriggerServerCallback('esx_firejob:buy', function(hasEnoughMoney)

          if hasEnoughMoney then
            ESX.TriggerServerCallback('esx_firejob:addArmoryWeapon', function()
              OpenBuyWeaponsMenu(station)
            end, data.current.value)
          else
            ESX.ShowNotification(_U('not_enough_money'))
          end

        end, data.current.price)

      end,
      function(data, menu)
        menu.close()
      end
    )

  end)

end

function OpenGetStocksMenu()

  ESX.TriggerServerCallback('esx_firejob:getStockItems', function(items)

    print(json.encode(items))

    local elements = {}

    for i = 1, #items, 1 do
      table.insert(elements, { label = 'x' .. items[i].count .. ' ' .. items[i].label, value = items[i].name })
    end

    ESX.UI.Menu.Open(
      'default', GetCurrentResourceName(), 'stocks_menu',
      {
        title    = _U('fire_stock'),
        elements = elements
      },
      function(data, menu)

        local itemName = data.current.value

        ESX.UI.Menu.Open(
          'dialog', GetCurrentResourceName(), 'stocks_menu_get_item_count',
          {
            title = _U('quantity')
          },
          function(data2, menu2)

            local count = tonumber(data2.value)

            if count == nil then
              ESX.ShowNotification(_U('quantity_invalid'))
            else
              menu2.close()
              menu.close()
              OpenGetStocksMenu()

              TriggerServerEvent('esx_firejob:getStockItem', itemName, count)
            end

          end,
          function(data2, menu2)
            menu2.close()
          end
        )

      end,
      function(data, menu)
        menu.close()
      end
    )

  end)

end

function OpenPutStocksMenu()

  ESX.TriggerServerCallback('esx_firejob:getPlayerInventory', function(inventory)

    local elements = {}

    for i = 1, #inventory.items, 1 do

      local item = inventory.items[i]

      if item.count > 0 then
        table.insert(elements, { label = item.label .. ' x' .. item.count, type = 'item_standard', value = item.name })
      end

    end

    ESX.UI.Menu.Open(
      'default', GetCurrentResourceName(), 'stocks_menu',
      {
        title    = _U('inventory'),
        elements = elements
      },
      function(data, menu)

        local itemName = data.current.value

        ESX.UI.Menu.Open(
          'dialog', GetCurrentResourceName(), 'stocks_menu_put_item_count',
          {
            title = _U('quantity')
          },
          function(data2, menu2)

            local count = tonumber(data2.value)

            if count == nil then
              ESX.ShowNotification(_U('quantity_invalid'))
            else
              menu2.close()
              menu.close()
              OpenPutStocksMenu()

              TriggerServerEvent('esx_firejob:putStockItems', itemName, count)
            end

          end,
          function(data2, menu2)
            menu2.close()
          end
        )

      end,
      function(data, menu)
        menu.close()
      end
    )

  end)

end

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
  PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
  PlayerData.job = job
end)

AddEventHandler('esx_firejob:hasEnteredMarker', function(station, part, partNum)
  if part == 'Cloakroom' then
    CurrentAction     = 'menu_cloakroom'
    CurrentActionMsg  = _U('open_cloackroom')
    CurrentActionData = {}
  end

  if part == 'Armory' then
    CurrentAction     = 'menu_armory'
    CurrentActionMsg  = _U('open_armory')
    CurrentActionData = { station = station }
  end

  if part == 'VehicleSpawner' then
    CurrentAction     = 'menu_vehicle_spawner'
    CurrentActionMsg  = _U('vehicle_spawner')
    CurrentActionData = { station = station, partNum = partNum }
  end

  if part == 'VehicleDeleter' then

    local playerPed = GetPlayerPed(-1)
    local coords    = GetEntityCoords(playerPed)

    if IsPedInAnyVehicle(playerPed, false) then

      local vehicle = GetVehiclePedIsIn(playerPed, false)

      if DoesEntityExist(vehicle) then
        CurrentAction     = 'delete_vehicle'
        CurrentActionMsg  = _U('store_vehicle')
        CurrentActionData = { vehicle = vehicle }
      end

    end

  end

  if part == 'BossActions' then
    CurrentAction     = 'menu_boss_actions'
    CurrentActionMsg  = _U('open_bossmenu')
    CurrentActionData = {}
  end

end)

AddEventHandler('esx_firejob:hasExitedMarker', function(station, part, partNum)
  ESX.UI.Menu.CloseAll()
  CurrentAction = nil
end)

AddEventHandler('esx_firejob:hasEnteredEntityZone', function(entity)

  local playerPed = GetPlayerPed(-1)

  if PlayerData.job ~= nil and PlayerData.job.name == 'brandweer' and not IsPedInAnyVehicle(playerPed, false) then
    CurrentAction     = 'remove_entity'
    CurrentActionMsg  = _U('remove_object')
    CurrentActionData = { entity = entity }
  end

  if GetEntityModel(entity) == GetHashKey('p_ld_stinger_s') then

    local playerPed = GetPlayerPed(-1)
    local coords    = GetEntityCoords(playerPed)

    if IsPedInAnyVehicle(playerPed, false) then

      local vehicle = GetVehiclePedIsIn(playerPed)

      for i = 0, 7, 1 do
        SetVehicleTyreBurst(vehicle, i, true, 1000)
      end

    end

  end

end)

AddEventHandler('esx_firejob:hasExitedEntityZone', function(entity)

  if CurrentAction == 'remove_entity' then
    CurrentAction = nil
  end

end)

RegisterNetEvent('esx_firejob:drag')
AddEventHandler('esx_firejob:drag', function(cop)
  TriggerServerEvent('esx:clientLog', 'starting dragging')
  IsDragged = not IsDragged
  CopPed = tonumber(cop)
end)

RegisterNetEvent('esx_firejob:putInVehicle')
AddEventHandler('esx_firejob:putInVehicle', function()

  local playerPed = GetPlayerPed(-1)
  local coords    = GetEntityCoords(playerPed)

  if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then

    local vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)

    if DoesEntityExist(vehicle) then

      local maxSeats = GetVehicleMaxNumberOfPassengers(vehicle)
      local freeSeat = nil

      for i = maxSeats - 1, 0, -1 do
        if IsVehicleSeatFree(vehicle, i) then
          freeSeat = i
          break
        end
      end

      if freeSeat ~= nil then
        TaskWarpPedIntoVehicle(playerPed, vehicle, freeSeat)
      end

    end
  end
end)

RegisterNetEvent('esx_firejob:OutVehicle')
AddEventHandler('esx_firejob:OutVehicle', function(t)
  local ped = GetPlayerPed(t)
  ClearPedTasksImmediately(ped)
  plyPos = GetEntityCoords(GetPlayerPed(-1), true)
  local xnew = plyPos.x + 2
  local ynew = plyPos.y + 2

  SetEntityCoords(GetPlayerPed(-1), xnew, ynew, plyPos.z)
end)

RegisterNetEvent('esx_firejob:revive')
AddEventHandler('esx_firejob:revive', function()
  local playerPed = GetPlayerPed(-1)
  local coords    = GetEntityCoords(playerPed)

  Citizen.CreateThread(function()
    DoScreenFadeOut(800)

    while not IsScreenFadedOut() do
      Citizen.Wait(0)
    end

    ESX.SetPlayerData('lastPosition', {
      x = coords.x,
      y = coords.y,
      z = coords.z
    })

    TriggerServerEvent('esx:updateLastPosition', {
      x = coords.x,
      y = coords.y,
      z = coords.z
    })

    RespawnPed(playerPed, {
      x = coords.x,
      y = coords.y,
      z = coords.z
    })

    StopScreenEffect('DeathFailOut')
    DoScreenFadeIn(800)

  end)
end)


-- Create blips
Citizen.CreateThread(function()
  for k, v in pairs(Config.FireStations) do
    local blip = AddBlipForCoord(v.Blip.Pos.x, v.Blip.Pos.y, v.Blip.Pos.z)
    SetBlipSprite(blip, v.Blip.Sprite)
    SetBlipDisplay(blip, v.Blip.Display)
    SetBlipScale(blip, v.Blip.Scale)
    SetBlipColour(blip, v.Blip.Colour)
    SetBlipAsShortRange(blip, true)

    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(_U('map_blip'))
    EndTextCommandSetBlipName(blip)
  end
end)

-- Display markers
Citizen.CreateThread(function()
  while true do
    Wait(7)
    if PlayerData.job ~= nil and PlayerData.job.name == 'brandweer' then

      local playerPed = GetPlayerPed(-1)
      local coords    = GetEntityCoords(playerPed)

      for k, v in pairs(Config.FireStations) do

        for i = 1, #v.Cloakrooms, 1 do
          if GetDistanceBetweenCoords(coords, v.Cloakrooms[i].x, v.Cloakrooms[i].y, v.Cloakrooms[i].z, true) < Config.DrawDistance then
            DrawMarker(Config.MarkerType, v.Cloakrooms[i].x, v.Cloakrooms[i].y, v.Cloakrooms[i].z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, false, false, false, false)
          end
        end

        for i = 1, #v.Armories, 1 do
          if GetDistanceBetweenCoords(coords, v.Armories[i].x, v.Armories[i].y, v.Armories[i].z, true) < Config.DrawDistance then
            DrawMarker(Config.MarkerType, v.Armories[i].x, v.Armories[i].y, v.Armories[i].z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, false, false, false, false)
          end
        end

        for i = 1, #v.Vehicles, 1 do
          if GetDistanceBetweenCoords(coords, v.Vehicles[i].Spawner.x, v.Vehicles[i].Spawner.y, v.Vehicles[i].Spawner.z, true) < Config.DrawDistance then
            DrawMarker(Config.MarkerType, v.Vehicles[i].Spawner.x, v.Vehicles[i].Spawner.y, v.Vehicles[i].Spawner.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, false, false, false, false)
          end
        end

        for i = 1, #v.VehicleDeleters, 1 do
          if GetDistanceBetweenCoords(coords, v.VehicleDeleters[i].x, v.VehicleDeleters[i].y, v.VehicleDeleters[i].z, true) < Config.DrawDistance then
            DrawMarker(Config.MarkerType, v.VehicleDeleters[i].x, v.VehicleDeleters[i].y, v.VehicleDeleters[i].z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, false, false, false, false)
          end
        end

        if Config.EnablePlayerManagement and PlayerData.job ~= nil and PlayerData.job.name == 'brandweer' and PlayerData.job.grade_name == 'boss' then

          for i = 1, #v.BossActions, 1 do
            if not v.BossActions[i].disabled and GetDistanceBetweenCoords(coords, v.BossActions[i].x, v.BossActions[i].y, v.BossActions[i].z, true) < Config.DrawDistance then
              DrawMarker(Config.MarkerType, v.BossActions[i].x, v.BossActions[i].y, v.BossActions[i].z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, false, false, false, false)
            end
          end
        end
        
      end
    end
  end
end)

-- Enter / Exit marker events
Citizen.CreateThread(function()
  while true do
    Wait(100)

    if PlayerData.job ~= nil and PlayerData.job.name == 'brandweer' then

      local playerPed      = GetPlayerPed(-1)
      local coords         = GetEntityCoords(playerPed)
      local isInMarker     = false
      local currentStation = nil
      local currentPart    = nil
      local currentPartNum = nil

      for k, v in pairs(Config.FireStations) do

        for i = 1, #v.Cloakrooms, 1 do
          if GetDistanceBetweenCoords(coords, v.Cloakrooms[i].x, v.Cloakrooms[i].y, v.Cloakrooms[i].z, true) < Config.MarkerSize.x then
            isInMarker     = true
            currentStation = k
            currentPart    = 'Cloakroom'
            currentPartNum = i
          end
        end

        for i = 1, #v.Armories, 1 do
          if GetDistanceBetweenCoords(coords, v.Armories[i].x, v.Armories[i].y, v.Armories[i].z, true) < Config.MarkerSize.x then
            isInMarker     = true
            currentStation = k
            currentPart    = 'Armory'
            currentPartNum = i
          end
        end

        for i = 1, #v.Vehicles, 1 do

          if GetDistanceBetweenCoords(coords, v.Vehicles[i].Spawner.x, v.Vehicles[i].Spawner.y, v.Vehicles[i].Spawner.z, true) < Config.MarkerSize.x then
            isInMarker     = true
            currentStation = k
            currentPart    = 'VehicleSpawner'
            currentPartNum = i
          end

          if GetDistanceBetweenCoords(coords, v.Vehicles[i].SpawnPoint.x, v.Vehicles[i].SpawnPoint.y, v.Vehicles[i].SpawnPoint.z, true) < Config.MarkerSize.x then
            isInMarker     = true
            currentStation = k
            currentPart    = 'VehicleSpawnPoint'
            currentPartNum = i
          end

        end

        for i = 1, #v.VehicleDeleters, 1 do
          if GetDistanceBetweenCoords(coords, v.VehicleDeleters[i].x, v.VehicleDeleters[i].y, v.VehicleDeleters[i].z, true) < 3.5 then
            isInMarker     = true
            currentStation = k
            currentPart    = 'VehicleDeleter'
            currentPartNum = i
          end
        end

        if Config.EnablePlayerManagement and PlayerData.job ~= nil and PlayerData.job.name == 'brandweer' and PlayerData.job.grade_name == 'boss' then

          for i = 1, #v.BossActions, 1 do
            if GetDistanceBetweenCoords(coords, v.BossActions[i].x, v.BossActions[i].y, v.BossActions[i].z, true) < Config.MarkerSize.x then
              isInMarker     = true
              currentStation = k
              currentPart    = 'BossActions'
              currentPartNum = i
            end
          end
        end
      end

      local hasExited = false

      if isInMarker and not HasAlreadyEnteredMarker or (isInMarker and (LastStation ~= currentStation or LastPart ~= currentPart or LastPartNum ~= currentPartNum)) then

        if (LastStation ~= nil and LastPart ~= nil and LastPartNum ~= nil) and
            (LastStation ~= currentStation or LastPart ~= currentPart or LastPartNum ~= currentPartNum)
        then
          TriggerEvent('esx_firejob:hasExitedMarker', LastStation, LastPart, LastPartNum)
          hasExited = true
        end

        HasAlreadyEnteredMarker = true
        LastStation             = currentStation
        LastPart                = currentPart
        LastPartNum             = currentPartNum

        TriggerEvent('esx_firejob:hasEnteredMarker', currentStation, currentPart, currentPartNum)
      end

      if not hasExited and not isInMarker and HasAlreadyEnteredMarker then
        HasAlreadyEnteredMarker = false
        TriggerEvent('esx_firejob:hasExitedMarker', LastStation, LastPart, LastPartNum)
      end
    end
  end
end)

-- Enter / Exit entity zone events
Citizen.CreateThread(function()

  local trackedEntities = {
    'prop_roadcone02a',
    'prop_barrier_work06a',
    'p_ld_stinger_s',
    'prop_boxpile_07d',
    'hei_prop_cash_crate_half_full'
  }

  while true do
    Citizen.Wait(200)

    local playerPed = GetPlayerPed(-1)
    local coords    = GetEntityCoords(playerPed)

    local closestDistance = -1
    local closestEntity   = nil

    for i = 1, #trackedEntities, 1 do
      local object = GetClosestObjectOfType(coords.x, coords.y, coords.z, 3.0, GetHashKey(trackedEntities[i]), false, false, false)

      if DoesEntityExist(object) then

        local objCoords = GetEntityCoords(object)
        local distance  = GetDistanceBetweenCoords(coords.x, coords.y, coords.z, objCoords.x, objCoords.y, objCoords.z, true)

        if closestDistance == -1 or closestDistance > distance then
          closestDistance = distance
          closestEntity   = object
        end
      end
    end

    if closestDistance ~= -1 and closestDistance <= 3.0 then
      if LastEntity ~= closestEntity then
        TriggerEvent('esx_firejob:hasEnteredEntityZone', closestEntity)
        LastEntity = closestEntity
      end
    else
      if LastEntity ~= nil then
        TriggerEvent('esx_firejob:hasExitedEntityZone', LastEntity)
        LastEntity = nil
      end
    end
  end
end)

-- Key Controls
Citizen.CreateThread(function()
  while true do
    Citizen.Wait(5)

    if CurrentAction ~= nil then

      SetTextComponentFormat('STRING')
      AddTextComponentString(CurrentActionMsg)
      DisplayHelpTextFromStringLabel(0, 0, 1, -1)

      if IsControlPressed(0, Keys['E']) and PlayerData.job ~= nil and PlayerData.job.name == 'brandweer' and (GetGameTimer() - GUI.Time) > 150 then

        if CurrentAction == 'menu_cloakroom' then
          OpenCloakroomMenu()
        end

        if CurrentAction == 'menu_armory' then
          OpenArmoryMenu(CurrentActionData.station)
        end

        if CurrentAction == 'menu_vehicle_spawner' then
          OpenVehicleSpawnerMenu(CurrentActionData.station, CurrentActionData.partNum)
        end

        if CurrentAction == 'delete_vehicle' then

          if Config.EnableSocietyOwnedVehicles then

            local vehicleProps = ESX.Game.GetVehicleProperties(CurrentActionData.vehicle)
            TriggerServerEvent('esx_society:putVehicleInGarage', 'fire', vehicleProps)

          else

            if GetEntityModel(vehicle) == GetHashKey('fire') or
                GetEntityModel(vehicle) == GetHashKey('brandweer') or
                GetEntityModel(vehicle) == GetHashKey('brandweer2') or
                GetEntityModel(vehicle) == GetHashKey('brandweer4') or
                GetEntityModel(vehicle) == GetHashKey('brandmotor') or
                GetEntityModel(vehicle) == GetHashKey('brandweer5') or
                GetEntityModel(vehicle) == GetHashKey('br1') or
                GetEntityModel(vehicle) == GetHashKey('br10') or
                GetEntityModel(vehicle) == GetHashKey('firetruk') or
                GetEntityModel(vehicle) == GetHashKey('firet')
            then
              TriggerServerEvent('esx_service:disableService', 'fire')
            end
          end

          ESX.Game.DeleteVehicle(CurrentActionData.vehicle)
        end

        if CurrentAction == 'menu_boss_actions' then
          ESX.UI.Menu.CloseAll()

          TriggerEvent('esx_society:openBossMenu', 'fire', function(data, menu)
            menu.close()
            CurrentAction     = 'menu_boss_actions'
            CurrentActionMsg  = _U('open_bossmenu')
            CurrentActionData = {}
          end)
        end

        if CurrentAction == 'remove_entity' then
          DeleteEntity(CurrentActionData.entity)
        end

        CurrentAction = nil
        GUI.Time      = GetGameTimer()
      end
    end

    if IsControlPressed(0, Keys['F6']) and PlayerData.job ~= nil and PlayerData.job.name == 'brandweer' and not ESX.UI.Menu.IsOpen('default', GetCurrentResourceName(), 'fire_actions') and (GetGameTimer() - GUI.Time) > 150 then
      OpenFireActionsMenu()
      GUI.Time = GetGameTimer()
    end

  end
end)

function openFire()
  if PlayerData.job ~= nil and PlayerData.job.name == 'brandweer' and not ESX.UI.Menu.IsOpen('default', GetCurrentResourceName(), 'fire_actions') and (GetGameTimer() - GUI.Time) > 150 then
    OpenFireActionsMenu()
    GUI.Time = GetGameTimer()
  end
end

function getJob()
  if PlayerData.job ~= nil then
    return PlayerData.job.name
  end
end
