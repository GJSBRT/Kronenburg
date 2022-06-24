local PlayerData              = {}
local HasAlreadyEnteredMarker = false
local LastZone                = nil
local CurrentAction           = nil
local CurrentActionMsg        = ''
local CurrentActionData       = {}
local Blips                   = {}
local isBarman                = false
local isInMarker              = false
local isInPublicMarker        = false
local hintIsShowed            = false
local hintToDisplay           = "no hint to display"
local IsManager = false
local IsSecurity = false
local IsHandcuffed              = false
local IsDragged                 = false
local IsDraggingSomeone = false
ESX                           = nil
local Identifier = nil
local InDuty = false

local firtSpawn = true
Citizen.CreateThread(function()
  while ESX == nil do
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    Citizen.Wait(0)

    while firtSpawn == true do Citizen.Wait(500) end
    PlayerData = ESX.GetPlayerData()
    ESX.TriggerServerCallback('casino_job::getId', function(id)
      Identifier = id
      if Config.DubbelWerkers ~= nil and Config.DubbelWerkers[Identifier] ~= nil then
        while true do 
          local sleep = 5000
          local Distance = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId(-1)), vector3(930.7982, 38.3696, 80.0958), false)
          if Distance < 10 then
            DrawMarker(24, vector3(930.7982, 38.3696, 81.0958), 0.0, 0.0, 0.0, 0, 0.0, 0.0, 2.0, 2.0, 2.0, 255, 82, 0, 100, false, false, 2, true, false, false, false)
            sleep = 5
  
            if Distance < 2.5 then
              ESX.ShowHelpNotification('Druk op [E]', 1, 0, -1)
              if IsControlJustPressed(0, 38) then
                TriggerServerEvent('casino_job::dubbelwerkers')
                ESX.ShowNotification('Je bent zojuist geswitched !')
                sleep = 10000
              end
            end
          elseif Distance > 70 then 
            sleep = 10000
          end
          Citizen.Wait(sleep)
        end
      end
    end)
  end
end)

function IsJobTrue() 
  local IsJobTrue = false
    if PlayerData ~= nil then   
        if InDuty then
            IsJobTrue = true
        end
    end
    return IsJobTrue
end

function HasJob()
  local HasTheJob = false
  if PlayerData ~= nil then
    if PlayerData.job ~= nil and (PlayerData.job.name == 'casino' or PlayerData.job.name == 'offcasino') then
        HasTheJob = true
    end
  else
    PlayerData = ESX.GetPlayerData()
  end
  return HasTheJob
end

AddEventHandler('playerSpawned', function()
  Citizen.CreateThread(function()
    if firtSpawn == false then
      PlayerData = ESX.GetPlayerData()    
    else
      firtSpawn = false
      InDuty = false
      TriggerServerEvent("casino_job::toggleDuty", false)
      ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
        TriggerEvent('skinchanger:loadSkin', skin)
      end)
      PlayerData = ESX.GetPlayerData()   
    end
  end)
end)

--- OnDuty // offduty
Citizen.CreateThread(function() 
  while true do 
    local sleepTime = 1000

    if HasJob() == true then
      local Distance = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId(-1)), vector3(1114.6926, 253.8161, -44.8310), false)
      if Distance < 10 then
        DrawMarker(24, vector3(1114.6926, 253.8161, -45.8310), 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.0, 1.0, 1.0, 255, 82, 0, 100, false, false, 2, true, false, false, false)
        sleepTime = 3

        if Distance < 1.5 then
          ESX.ShowHelpNotification('Druk op [E]', 1, 0, -1)
          if IsControlJustPressed(0, 38) then
            if InDuty then
              InDuty = false
              TriggerServerEvent("casino_job::toggleDuty", false)
              ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
                TriggerEvent('skinchanger:loadSkin', skin)
              end)
              ESX.ShowNotification('Je bent nu uit dienst.')
            else
              TriggerServerEvent("casino_job::toggleDuty", true)
              InDuty = true
              ESX.ShowNotification('Je bent nu in dienst!')
            end
            sleepTime = 10000
          end
        end
      end
    else 
      sleepTime = 5000
    end

    Citizen.Wait(sleepTime)
  end
end)

function IsGradeSecurityOrHigher()
  if PlayerData ~= nil then
      if PlayerData.job.name == 'casino' and PlayerData.job.grade_name ~= 'barstaff' then
          IsSecurity =  true
      end

      return IsSecurity
  end
end

function IsGradeBoss()
    if PlayerData ~= nil then
        local IsGradeBoss = false
        if PlayerData.job.grade_name == 'boss' or PlayerData.job.grade_name == 'manager' or PlayerData.job.grade_name == 'management' then
            IsGradeBoss = true
            IsManager = true
        end

        return IsGradeBoss
    end
end

function SetVehicleMaxMods(vehicle)

  local props = {
    modEngine       = 0,
    modBrakes       = 0,
    modTransmission = 0,
    modSuspension   = 0,
    modTurbo        = false,
  }

  ESX.Game.SetVehicleProperties(vehicle, props)

end

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
  PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
  PlayerData.job = job
  if job.name == 'casino' then InDuty = true else InDuty = false end
end)


function cleanPlayer(playerPed)
  ClearPedBloodDamage(playerPed)
  ResetPedVisibleDamage(playerPed)
  ClearPedLastWeaponDamage(playerPed)
  ResetPedMovementClipset(playerPed, 0)
end

function setClipset(playerPed, clip)
  RequestAnimSet(clip)
  while not HasAnimSetLoaded(clip) do
    Citizen.Wait(0)
  end
  SetPedMovementClipset(playerPed, clip, true)
end

function setUniform(job, playerPed)
  TriggerEvent('skinchanger:getSkin', function(skin)

    if skin.sex == 0 then
      if Config.Uniforms[job].male ~= nil then
        TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms[job].male)
      else
        ESX.ShowNotification(_U('no_outfit'))
      end
      if job ~= 'citizen_wear' and job ~= 'barman_outfit' then
        setClipset(playerPed, "MOVE_M@POSH@")
      end
    else
      if Config.Uniforms[job].female ~= nil then
        TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms[job].female)
      else
        ESX.ShowNotification(_U('no_outfit'))
      end
      if job ~= 'citizen_wear' and job ~= 'barman_outfit' then
        setClipset(playerPed, "MOVE_F@POSH@")
      end
    end

  end)
end

function OpenCloakroomMenu()

  local playerPed = GetPlayerPed(-1)

  local elements = {
    { label = _U('citizen_wear'),     value = 'citizen_wear'},
    { label = 'Security',    value = 'security_outfit'},
    { label = _U('barman_outfit'),    value = 'barman_outfit'},
    { label = 'Management',    value = 'management_outfit'},
    { label = 'Baas',    value = 'baas_outfit'},
  }

  ESX.UI.Menu.CloseAll()

  ESX.UI.Menu.Open(
    'default', GetCurrentResourceName(), 'cloakroom',
    {
      title    = _U('cloakroom'),
      align    = 'top-left',
      elements = elements,
    },
    function(data, menu)

      isBarman = false
      cleanPlayer(playerPed)

      if data.current.value == 'citizen_wear' then
        ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
          TriggerEvent('skinchanger:loadSkin', skin)
        end)
      end

      if data.current.value == 'barman_outfit' then
        setUniform(data.current.value, playerPed)
        isBarman = true
      end

      if data.current.value == 'management_outfit' then
        setUniform(data.current.value, playerPed)
      end

      if data.current.value == 'baas_outfit' then
        setUniform(data.current.value, playerPed)
      end

      if data.current.value == 'security_outfit' then
        setUniform(data.current.value, playerPed)
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

function OpenVaultMenu()

  if Config.EnableVaultManagement then

    local elements = {
      {label = _U('get_weapon'), value = 'get_weapon'},
      {label = _U('put_weapon'), value = 'put_weapon'},
      {label = _U('get_object'), value = 'get_stock'},
      {label = _U('put_object'), value = 'put_stock'}
    }
    

    ESX.UI.Menu.CloseAll()

    ESX.UI.Menu.Open(
      'default', GetCurrentResourceName(), 'vault',
      {
        title    = _U('vault'),
        align    = 'top-left',
        elements = elements,
      },
      function(data, menu)

        if data.current.value == 'get_weapon' then
          OpenGetWeaponMenu()
        end

        if data.current.value == 'put_weapon' then
          OpenPutWeaponMenu()
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

        CurrentAction     = 'menu_vault'
        CurrentActionMsg  = _U('open_vault')
        CurrentActionData = {}
      end
    )

  end

end

function OpenFridgeMenu()

    local elements = {
      {label = _U('get_object'), value = 'get_stock'},
      {label = _U('put_object'), value = 'put_stock'}
    }
    

    ESX.UI.Menu.CloseAll()

    ESX.UI.Menu.Open(
      'default', GetCurrentResourceName(), 'fridge',
      {
        title    = _U('fridge'),
        align    = 'top-left',
        elements = elements,
      },
      function(data, menu)

        if data.current.value == 'put_stock' then
           OpenPutFridgeStocksMenu()
        end

        if data.current.value == 'get_stock' then
           OpenGetFridgeStocksMenu()
        end

      end,
      
      function(data, menu)

        menu.close()

        CurrentAction     = 'menu_fridge'
        CurrentActionMsg  = _U('open_fridge')
        CurrentActionData = {}
      end
    )

end

function OpenVehicleSpawnerMenu()

  local vehicles = Config.Zones.Vehicles

  ESX.UI.Menu.CloseAll()

  if Config.EnableSocietyOwnedVehicles then

    local elements = {}

    ESX.TriggerServerCallback('esx_society:getVehiclesInGarage', function(garageVehicles)

      for i=1, #garageVehicles, 1 do
        table.insert(elements, {label = GetDisplayNameFromVehicleModel(garageVehicles[i].model) .. ' [' .. garageVehicles[i].plate .. ']', value = garageVehicles[i]})
      end

      ESX.UI.Menu.Open(
        'default', GetCurrentResourceName(), 'vehicle_spawner',
        {
          title    = _U('vehicle_menu'),
          align    = 'top-left',
          elements = elements,
        },
        function(data, menu)

          menu.close()

          local vehicleProps = data.current.value
          ESX.Game.SpawnVehicle(vehicleProps.model, vehicles.SpawnPoint, vehicles.Heading, function(vehicle)
              ESX.Game.SetVehicleProperties(vehicle, vehicleProps)
              local playerPed = GetPlayerPed(-1)
              --TaskWarpPedIntoVehicle(playerPed,  vehicle,  -1)  -- teleport into vehicle
          end)            

          TriggerServerEvent('esx_society:removeVehicleFromGarage', 'casino', vehicleProps)

        end,
        function(data, menu)

          menu.close()

          CurrentAction     = 'menu_vehicle_spawner'
          CurrentActionMsg  = _U('vehicle_spawner')
          CurrentActionData = {}

        end
      )

    end, 'casino')

  else

    local elements = {}

    for i=1, #Config.AuthorizedVehicles, 1 do
      local vehicle = Config.AuthorizedVehicles[i]
      table.insert(elements, {label = vehicle.label, value = vehicle.name})
    end

    ESX.UI.Menu.Open(
      'default', GetCurrentResourceName(), 'vehicle_spawner',
      {
        title    = _U('vehicle_menu'),
        align    = 'top-left',
        elements = elements,
      },
      function(data, menu)

        menu.close()

        local model = data.current.value

        local vehicle = GetClosestVehicle(vehicles.SpawnPoint.x,  vehicles.SpawnPoint.y,  vehicles.SpawnPoint.z,  3.0,  0,  71)

        if not DoesEntityExist(vehicle) then

          local playerPed = GetPlayerPed(-1)

          if Config.MaxInService == -1 then

            ESX.Game.SpawnVehicle(model, {
              x = vehicles.SpawnPoint.x,
              y = vehicles.SpawnPoint.y,
              z = vehicles.SpawnPoint.z
            }, vehicles.Heading, function(vehicle)
              --TaskWarpPedIntoVehicle(playerPed,  vehicle,  -1) -- teleport into vehicle
              SetVehicleMaxMods(vehicle)
              SetVehicleDirtLevel(vehicle, 0)
            end)

          else

            ESX.TriggerServerCallback('esx_service:enableService', function(canTakeService, maxInService, inServiceCount)

              if canTakeService then

                ESX.Game.SpawnVehicle(model, {
                  x = vehicles[partNum].SpawnPoint.x,
                  y = vehicles[partNum].SpawnPoint.y,
                  z = vehicles[partNum].SpawnPoint.z
                }, vehicles[partNum].Heading, function(vehicle)
                  --TaskWarpPedIntoVehicle(playerPed,  vehicle,  -1)  -- teleport into vehicle
                  SetVehicleMaxMods(vehicle)
                  SetVehicleDirtLevel(vehicle, 0)
                end)

              else
                ESX.ShowNotification(_U('service_max') .. inServiceCount .. '/' .. maxInService)
              end

            end, 'etat')

          end

        else
          ESX.ShowNotification(_U('vehicle_out'))
        end

      end,
      function(data, menu)

        menu.close()

        CurrentAction     = 'menu_vehicle_spawner'
        CurrentActionMsg  = _U('vehicle_spawner')
        CurrentActionData = {}

      end
    )

  end

end


RegisterNetEvent('casino_job:handcuff')
AddEventHandler('casino_job:handcuff', function()

  IsHandcuffed    = not IsHandcuffed;
  local playerPed = GetPlayerPed(-1)

  Citizen.CreateThread(function()

    if IsHandcuffed then

      RequestAnimDict('mp_arresting')

      while not HasAnimDictLoaded('mp_arresting') do
        Wait(100)
      end

      DisableControlAction(0, 73, true) 
      FreezeEntityPosition(playerPed,  true)
      TaskPlayAnim(playerPed, 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0, 0, 0, 0)
      SetEnableHandcuffs(playerPed, true)
      SetPedCanPlayGestureAnims(playerPed, false)
      Citizen.Wait(1000)
      
      
    else
      
      DisableControlAction(0, 73, false)
      ClearPedSecondaryTask(playerPed)
      SetEnableHandcuffs(playerPed, false)
      SetPedCanPlayGestureAnims(playerPed,  true)
      FreezeEntityPosition(playerPed, false)

    end

  end)
end)

RegisterNetEvent('casino_job:drag')
AddEventHandler('casino_job:drag', function(cop)
  IsDragged = not IsDragged
  CopPed = tonumber(cop)
end)

Citizen.CreateThread(function()
  while true do
    Wait(7)
    if IsHandcuffed then
      if IsDragged then
        local ped = GetPlayerPed(GetPlayerFromServerId(CopPed))
        local myped = GetPlayerPed(-1)
        AttachEntityToEntity(myped, ped, 11816, 0.54, 0.54, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
      else
        DetachEntity(GetPlayerPed(-1), true, false)
      end
    end
  end
end)

function OpenSocietyActionsMenu()

  local elements = {}
  if(IsGradeSecurityOrHigher()) then
    table.insert(elements,  {label = '🚨 Handboeien (Geen abuse!)',    value = 'handcuff'})

    if not IsDraggingSomeone then
      table.insert(elements,   {label = '⬅ Escorteren',      value = 'drag'})
    else
      table.insert(elements,   {label = '⬅ Stop het escorteren',      value = 'drag'})
    end
  end
  table.insert(elements, {label = _U('billing'),    value = 'billing'})
  if (isBarman or IsGradeBoss()) then
    table.insert(elements, {label = _U('crafting'),    value = 'menu_crafting'})
  end

  ESX.UI.Menu.CloseAll()

  ESX.UI.Menu.Open(
    'default', GetCurrentResourceName(), 'casino_actions',
    {
      title    = _U('casino'),
      align    = 'top-left',
      elements = elements
    },
    function(data, menu)
      if data.current.value == 'handcuff' then
        local player, distance = ESX.Game.GetClosestPlayer()

        if distance ~= -1 and distance <= 3.0 then
          TriggerServerEvent('casino_job:handcuff', GetPlayerServerId(player))
        end
      end

      if data.current.value == 'drag' then
        local player, distance = ESX.Game.GetClosestPlayer()

        if distance ~= -1 and distance <= 3.0 then
          TriggerServerEvent('casino_job:drag', GetPlayerServerId(player))
          Citizen.Wait(800)
          if IsDraggingSomeone then
            StopAnimTask(GetPlayerPed(-1), 'switch@trevor@escorted_out', '001215_02_trvs_12_escorted_out_idle_guard2', 1.0)
            IsDraggingSomeone = false
          else
            LoadAnimDict('switch@trevor@escorted_out')
            Citizen.Wait(50)
            TaskPlayAnim(GetPlayerPed(-1), 'switch@trevor@escorted_out', '001215_02_trvs_12_escorted_out_idle_guard2', 8.0, 1.0, -1, 49, 0, 0, 0, 0)
            IsDraggingSomeone = true
          end
        end
      end

      if data.current.value == 'billing' then
        OpenBillingMenu()
      end

      if data.current.value == 'menu_crafting' then
        
          ESX.UI.Menu.Open(
              'default', GetCurrentResourceName(), 'menu_crafting',
              {
                  title = _U('crafting'),
                  align = 'top-left',
                  elements = {
                      {label = _U('jagerbomb'),     value = 'jagerbomb'},
                      {label = _U('golem'),         value = 'golem'},
                      {label = _U('whiskycoca'),    value = 'whiskycoca'},
                      {label = _U('vodkaenergy'),   value = 'vodkaenergy'},
                      {label = _U('vodkafruit'),    value = 'vodkafruit'},
                      {label = _U('rhumfruit'),     value = 'rhumfruit'},
                      {label = _U('teqpaf'),        value = 'teqpaf'},
                      {label = _U('rhumcoca'),      value = 'rhumcoca'},
                      {label = _U('mojito'),        value = 'mojito'},
                      {label = _U('mixapero'),      value = 'mixapero'},
                      {label = _U('metreshooter'),  value = 'metreshooter'},
                      {label = _U('jagercerbere'),  value = 'jagercerbere'},
                  }
              },
              function(data2, menu2)
            
                TriggerServerEvent('casino_job:craftingCoktails', data2.current.value)
                animsAction({ lib = "mini@drinking", anim = "shots_barman_b" })
      
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

function OpenBillingMenu()

  ESX.UI.Menu.Open(
    'dialog', GetCurrentResourceName(), 'billing',
    {
      title = _U('billing_amount')
    },
    function(data, menu)
    
      local amount = tonumber(data.value)
      local player, distance = ESX.Game.GetClosestPlayer()

      if player ~= -1 and distance <= 3.0 then

        menu.close()
        if amount == nil then
            ESX.ShowNotification(_U('amount_invalid'))
        else
            TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(player), 'society_casino', _U('billing'), amount)
        end

      else
        ESX.ShowNotification(_U('no_players_nearby'))
      end

    end,
    function(data, menu)
        menu.close()
    end
  )
end

function OpenGetStocksMenu()

  ESX.TriggerServerCallback('casino_job:getStockItems', function(items)
    local elements = {}

    for i=1, #items, 1 do
      table.insert(elements, {label = 'x' .. items[i].count .. ' ' .. items[i].label, value = items[i].name})
    end

    ESX.UI.Menu.Open(
      'default', GetCurrentResourceName(), 'stocks_menu',
      {
        title    = _U('casino_stock'),
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
              ESX.ShowNotification(_U('invalid_quantity'))
            else
              menu2.close()
              menu.close()
              OpenGetStocksMenu()

              TriggerServerEvent('casino_job:getStockItem', itemName, count)
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

ESX.TriggerServerCallback('casino_job:getPlayerInventory', function(inventory)

    local elements = {}

    for i=1, #inventory.items, 1 do

      local item = inventory.items[i]

      if item.count > 0 then
        table.insert(elements, {label = item.label .. ' x' .. item.count, type = 'item_standard', value = item.name})
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
              ESX.ShowNotification(_U('invalid_quantity'))
            else
              menu2.close()
              menu.close()
              OpenPutStocksMenu()

              TriggerServerEvent('casino_job:putStockItems', itemName, count)
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

function OpenGetFridgeStocksMenu()

  ESX.TriggerServerCallback('casino_job:getFridgeStockItems', function(items)


    local elements = {}

    for i=1, #items, 1 do
      table.insert(elements, {label = 'x' .. items[i].count .. ' ' .. items[i].label, value = items[i].name})
    end

    ESX.UI.Menu.Open(
      'default', GetCurrentResourceName(), 'fridge_menu',
      {
        title    = _U('casino_fridge_stock'),
        elements = elements
      },
      function(data, menu)

        local itemName = data.current.value

        ESX.UI.Menu.Open(
          'dialog', GetCurrentResourceName(), 'fridge_menu_get_item_count',
          {
            title = _U('quantity')
          },
          function(data2, menu2)

            local count = tonumber(data2.value)

            if count == nil then
              ESX.ShowNotification(_U('invalid_quantity'))
            else
              menu2.close()
              menu.close()
              OpenGetStocksMenu()

              TriggerServerEvent('casino_job:getFridgeStockItem', itemName, count)
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

function OpenPutFridgeStocksMenu()

ESX.TriggerServerCallback('casino_job:getPlayerInventory', function(inventory)

    local elements = {}

    for i=1, #inventory.items, 1 do

      local item = inventory.items[i]

      if item.count > 0 then
        table.insert(elements, {label = item.label .. ' x' .. item.count, type = 'item_standard', value = item.name})
      end

    end

    ESX.UI.Menu.Open(
      'default', GetCurrentResourceName(), 'fridge_menu',
      {
        title    = _U('fridge_inventory'),
        elements = elements
      },
      function(data, menu)

        local itemName = data.current.value

        ESX.UI.Menu.Open(
          'dialog', GetCurrentResourceName(), 'fridge_menu_put_item_count',
          {
            title = _U('quantity')
          },
          function(data2, menu2)

            local count = tonumber(data2.value)

            if count == nil then
              ESX.ShowNotification(_U('invalid_quantity'))
            else
              menu2.close()
              menu.close()
              OpenPutFridgeStocksMenu()

              TriggerServerEvent('casino_job:putFridgeStockItems', itemName, count)
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

function OpenGetWeaponMenu()

  ESX.TriggerServerCallback('casino_job:getVaultWeapons', function(weapons)

    local elements = {}

    for i=1, #weapons, 1 do
      if weapons[i].count > 0 then
        table.insert(elements, {label = 'x' .. weapons[i].count .. ' ' .. ESX.GetWeaponLabel(weapons[i].name), value = weapons[i].name})
      end
    end

    ESX.UI.Menu.Open(
      'default', GetCurrentResourceName(), 'vault_get_weapon',
      {
        title    = _U('get_weapon_menu'),
        align    = 'top-left',
        elements = elements,
      },
      function(data, menu)

        menu.close()

        ESX.TriggerServerCallback('casino_job:removeVaultWeapon', function()
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

  for i=1, #weaponList, 1 do

    local weaponHash = GetHashKey(weaponList[i].name)

    if HasPedGotWeapon(playerPed,  weaponHash,  false) and weaponList[i].name ~= 'WEAPON_UNARMED' then
      local ammo = GetAmmoInPedWeapon(playerPed, weaponHash)
      table.insert(elements, {label = weaponList[i].label, value = weaponList[i].name})
    end

  end

  ESX.UI.Menu.Open(
    'default', GetCurrentResourceName(), 'vault_put_weapon',
    {
      title    = _U('put_weapon_menu'),
      align    = 'top-left',
      elements = elements,
    },
    function(data, menu)

      menu.close()

      ESX.TriggerServerCallback('casino_job:addVaultWeapon', function()
        OpenPutWeaponMenu()
      end, data.current.value)

    end,
    function(data, menu)
      menu.close()
    end)
end

function OpenShopMenu(zone)
    local elements = {}

    for i=1, #Config.Zones[zone].Items, 1 do

        local item = Config.Zones[zone].Items[i]

        table.insert(elements, {
            label     = item.label .. ' - <span style="color:red;">$' .. item.price .. ' </span>',
            realLabel = item.label,
            value     = item.name,
            price     = item.price
        })
    end

    ESX.UI.Menu.CloseAll()

    ESX.UI.Menu.Open(
        'default', GetCurrentResourceName(), 'casino_shop',
        {
            title    = _U('shop'),
            elements = elements
        },
        function(data, menu)
            TriggerServerEvent('casino_job:buyItem', data.current.value, data.current.price, data.current.realLabel)
        end,
        function(data, menu)
            menu.close()
        end
    )

end

function animsAction(animObj)
    Citizen.CreateThread(function()
        if not playAnim then
            local playerPed = GetPlayerPed(-1);
            if DoesEntityExist(playerPed) then -- Check if ped exist
                dataAnim = animObj

                -- Play Animation
                RequestAnimDict(dataAnim.lib)
                while not HasAnimDictLoaded(dataAnim.lib) do
                    Citizen.Wait(0)
                end
                if HasAnimDictLoaded(dataAnim.lib) then
                    local flag = 0
                    if dataAnim.loop ~= nil and dataAnim.loop then
                        flag = 1
                    elseif dataAnim.move ~= nil and dataAnim.move then
                        flag = 49
                    end

                    TaskPlayAnim(playerPed, dataAnim.lib, dataAnim.anim, 8.0, -8.0, -1, flag, 0, 0, 0, 0)
                    playAnimation = true
                end

                -- Wait end animation
                while true do
                    Citizen.Wait(0)
                    if not IsEntityPlayingAnim(playerPed, dataAnim.lib, dataAnim.anim, 3) then
                        playAnim = false
                        TriggerEvent('ft_animation:ClFinish')
                        break
                    end
                end
            end -- end ped exist
        end
    end)
end


AddEventHandler('casino_job:hasEnteredMarker', function(zone)
 
    if zone == 'BossActions' and IsGradeBoss() then
      CurrentAction     = 'menu_boss_actions'
      CurrentActionMsg  = _U('open_bossmenu')
      CurrentActionData = {}
    end

    if zone == 'Cloakrooms' then
      CurrentAction     = 'menu_cloakroom'
      CurrentActionMsg  = _U('open_cloackroom')
      CurrentActionData = {}
    end

    if Config.EnableVaultManagement then
      if zone == 'Vaults' then
        CurrentAction     = 'menu_vault'
        CurrentActionMsg  = _U('open_vault')
        CurrentActionData = {}
      end
    end

    if zone == 'Fridge' then
      CurrentAction     = 'menu_fridge'
      CurrentActionMsg  = _U('open_fridge')
      CurrentActionData = {}
    end

    if zone == 'MainBar1' or zone == 'MainBar2' then
      CurrentAction     = 'menu_shop'
      CurrentActionMsg  = _U('shop_menu')
      CurrentActionData = {zone = zone}
    end
    
    if zone == 'Vehicles' then
        CurrentAction     = 'menu_vehicle_spawner'
        CurrentActionMsg  = _U('vehicle_spawner')
        CurrentActionData = {}
    end

    if zone == 'VehicleDeleters' then

      local playerPed = GetPlayerPed(-1)

      if IsPedInAnyVehicle(playerPed,  false) then

        local vehicle = GetVehiclePedIsIn(playerPed,  false)

        CurrentAction     = 'delete_vehicle'
        CurrentActionMsg  = _U('store_vehicle')
        CurrentActionData = {vehicle = vehicle}
      end

    end

    if Config.EnableHelicopters then
        if zone == 'Helicopters' then

          local helicopters = Config.Zones.Helicopters

          if not IsAnyVehicleNearPoint(helicopters.SpawnPoint.x, helicopters.SpawnPoint.y, helicopters.SpawnPoint.z,  3.0) then

            ESX.Game.SpawnVehicle('supervolito', {
              x = helicopters.SpawnPoint.x,
              y = helicopters.SpawnPoint.y,
              z = helicopters.SpawnPoint.z
            }, helicopters.Heading, function(vehicle)
              SetVehicleModKit(vehicle, 0)
              SetVehicleLivery(vehicle, 0)
            end)

          end

        end

        if zone == 'HelicopterDeleters' then

          local playerPed = GetPlayerPed(-1)

          if IsPedInAnyVehicle(playerPed,  false) then

            local vehicle = GetVehiclePedIsIn(playerPed,  false)

            CurrentAction     = 'delete_vehicle'
            CurrentActionMsg  = _U('store_vehicle')
            CurrentActionData = {vehicle = vehicle}
          end

        end
    end


end)

AddEventHandler('casino_job:hasExitedMarker', function(zone)

    CurrentAction = nil
    ESX.UI.Menu.CloseAll()

end)

RegisterNetEvent('esx_phone:loaded')
AddEventHandler('esx_phone:loaded', function(phoneNumber, contacts)
  local specialContact = {
    name       = _U('casino_phone'),
    number     = 'casino',
    base64Icon = 'data:image/png;base64,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'
  }
  TriggerEvent('esx_phone:addSpecialContact', specialContact.name, specialContact.number, specialContact.base64Icon)
end)

-- Create blips
Citizen.CreateThread(function()

    local blipMarker = Config.Blips.Blip
    local blipCoord = AddBlipForCoord(blipMarker.Pos.x, blipMarker.Pos.y, blipMarker.Pos.z)

    SetBlipSprite (blipCoord, blipMarker.Sprite)
    SetBlipDisplay(blipCoord, blipMarker.Display)
    SetBlipScale  (blipCoord, blipMarker.Scale)
    SetBlipColour (blipCoord, blipMarker.Colour)
    SetBlipAsShortRange(blipCoord, true)

    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(_U('map_blip'))
    EndTextCommandSetBlipName(blipCoord)


end)

-- Display markers
Citizen.CreateThread(function()
    while true do
        Wait(2)
        if IsJobTrue() then

            local coords = GetEntityCoords(GetPlayerPed(-1))

            for k,v in pairs(Config.Zones) do
                if(v.Type ~= -1 and GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < Config.DrawDistance) then
                    DrawMarker(v.Type, v.Pos.x, v.Pos.y, v.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, v.Size.x, v.Size.y, v.Size.z, v.Color.r, v.Color.g, v.Color.b, 100, false, false, 2, true, false, false, false)
                end
            end
        else
          Citizen.Wait(2500)
        end

    end
end)

-- Enter / Exit marker events
Citizen.CreateThread(function()
    while true do

        Wait(0)
        if IsJobTrue() then

            local coords      = GetEntityCoords(GetPlayerPed(-1))
            local isInMarker  = false
            local currentZone = nil

            for k,v in pairs(Config.Zones) do
                if(GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < v.Size.x) then
                    isInMarker  = true
                    currentZone = k
                end
            end

            if (isInMarker and not HasAlreadyEnteredMarker) or (isInMarker and LastZone ~= currentZone) then
                HasAlreadyEnteredMarker = true
                LastZone                = currentZone
                TriggerEvent('casino_job:hasEnteredMarker', currentZone)
            end

            if not isInMarker and HasAlreadyEnteredMarker then
                HasAlreadyEnteredMarker = false
                TriggerEvent('casino_job:hasExitedMarker', LastZone)
            end
        else
          Citizen.Wait(900)
        end

    end
end)

-- Key Controls
Citizen.CreateThread(function()
  while true do

    Citizen.Wait(0)

    if CurrentAction ~= nil then

      SetTextComponentFormat('STRING')
      AddTextComponentString(CurrentActionMsg)
      DisplayHelpTextFromStringLabel(0, 0, 1, -1)

      if IsControlJustReleased(0,  38) and IsJobTrue() then

        if CurrentAction == 'menu_cloakroom' then
            OpenCloakroomMenu()
        end

        if CurrentAction == 'menu_vault' and IsGradeBoss() then
            OpenVaultMenu()
        end

        if CurrentAction == 'menu_fridge' then
            OpenFridgeMenu()
        end

        if CurrentAction == 'menu_shop' then
            OpenShopMenu(CurrentActionData.zone)
        end
        
        if CurrentAction == 'menu_vehicle_spawner' then
            OpenVehicleSpawnerMenu()
        end

        if CurrentAction == 'delete_vehicle' then

          if Config.EnableSocietyOwnedVehicles then

            local vehicleProps = ESX.Game.GetVehicleProperties(CurrentActionData.vehicle)
            TriggerServerEvent('esx_society:putVehicleInGarage', 'casino', vehicleProps)

          else

            if
              GetEntityModel(vehicle) == GetHashKey('rentalbus')
            then
              TriggerServerEvent('esx_service:disableService', 'casino')
            end

          end

          ESX.Game.DeleteVehicle(CurrentActionData.vehicle)
        end


        if CurrentAction == 'menu_boss_actions' and IsGradeBoss() then

          local options = {
            wash      = Config.EnableMoneyWash,
          }

          ESX.UI.Menu.CloseAll()
          ESX.TriggerServerCallback('esx_society:getSocietyMoney', function(money)
            print('Je hebt '.. money)
          end, 'casino')	

          TriggerEvent('esx_society:openBossMenu', 'casino', function(data, menu)

            menu.close()
            CurrentAction     = 'menu_boss_actions'
            CurrentActionMsg  = _U('open_bossmenu')
            CurrentActionData = {}
          end,options)
        end

        
        CurrentAction = nil
      end
    end


    if IsControlJustReleased(0,  167) and IsJobTrue() and not ESX.UI.Menu.IsOpen('default', GetCurrentResourceName(), 'casino_actions') then
        OpenSocietyActionsMenu()
    end


  end
end)


-----------------------
----- TELEPORTERS -----

AddEventHandler('casino_job:teleportMarkers', function(position)
  SetEntityCoords(GetPlayerPed(-1), position.x, position.y, position.z)
end)

-- Show top left hint
Citizen.CreateThread(function()
  while true do
    Wait(0)
    if hintIsShowed == true then
      SetTextComponentFormat("STRING")
      AddTextComponentString(hintToDisplay)
      DisplayHelpTextFromStringLabel(0, 0, 1, -1)
    end
  end
end)

-- Display teleport markers
Citizen.CreateThread(function()
  while true do
    Wait(0)

    if IsJobTrue() then

        local coords = GetEntityCoords(GetPlayerPed(-1))
        for k,v in pairs(Config.TeleportZones) do
          if(v.Marker ~= -1 and GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < Config.DrawDistance) then
            DrawMarker(v.Marker, v.Pos.x, v.Pos.y, v.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, v.Size.x, v.Size.y, v.Size.z, v.Color.r, v.Color.g, v.Color.b, 100, false, true, 2, true, false, false, false)
          end
        end

    end

  end
end)

-- Activate teleport marker
Citizen.CreateThread(function()
  while true do
    Wait(0)
    local coords      = GetEntityCoords(GetPlayerPed(-1))
    local position    = nil
    local zone        = nil

    if IsJobTrue() then

        for k,v in pairs(Config.TeleportZones) do
          if(GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < v.Size.x) then
            isInPublicMarker = true
            position = v.Teleport
            zone = v
            break
          else
            isInPublicMarker  = false
          end
        end

        if IsControlJustReleased(0, 38) and isInPublicMarker then
          TriggerEvent('casino_job:teleportMarkers', position)
        end

        -- hide or show top left zone hints
        if isInPublicMarker then
          hintToDisplay = zone.Hint
          hintIsShowed = true
        else
          if not isInMarker then
            hintToDisplay = "no hint to display"
            hintIsShowed = false
          end
        end
    end
  end
end)
