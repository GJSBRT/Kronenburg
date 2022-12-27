--[[ 
	Kronenburg Roleplay
	Copyright © GJSBRT <g@gijs.eu>

	This project is licensed under the terms of the Apache License 2.0 license.
	https://choosealicense.com/licenses/apache-2.0/
]]
 
 
Doors = {}

Doors.Awake = function()
  while not ESX do Wait(0); end
  while not ESX.IsPlayerLoaded() do Wait(0); end

  Wait(500)
  TriggerServerEvent("Doors:Init")
  ESX.UI.Menu.CloseAll()
end

Doors.Init = function(doors)
  for door_index,door in ipairs(doors) do
    if not Config.Doors[door_index] then 
      Config.Doors[door_index] = door
    else
      Config.Doors[door_index].locked = door.locked
    end
  end
  Doors.RefreshBlips()
  Doors.Update()
end

Doors.RefreshBlips = function()
  for _,shop in ipairs(Config.Shops) do
    if shop.draw_blip then
      CreateBlip(shop.location,shop.blip_sprite,shop.blip_color,shop.blip_text,shop.blip_scale,shop.blip_display,shop.blip_short_range,shop.blip_high_detail)
    end
  end
end

Doors.Update = function()
  while true do
    local wait_time = 0

    if not Doors.Busy then
      local ply_ped = GetPlayerPed(-1)
      local ply_pos = GetEntityCoords(ply_ped)

      wait_time = Doors.HandleDoors(ply_pos)
      if wait_time >= 1 then
        wait_time = (Doors.HandleShops(ply_pos) or wait_time)
      else
        Doors.HandleShops(ply_pos)
      end
    end

    Wait(wait_time)
  end
end

Doors.HandleShops = function(ply_pos)
  local closest,closest_dist
  for shop_index,shop in ipairs(Config.Shops) do
    local dist = Vdist(ply_pos,shop.location)
    if not closest_dist or dist < closest_dist then
      closest = shop_index
      closest_dist = dist
    end
  end

  local shop = Config.Shops[closest]
  if closest_dist and closest_dist <= shop.render_dist then
    if closest_dist < shop.render_dist then
      if shop.draw_text then 
        DrawText3D(shop.location + shop.text_offset,shop.text_to_draw,20.0,closest_dist)
      end

      if shop.draw_marker then
        DrawMarker(shop.marker_type,shop.location.x + shop.marker_offset.x,shop.location.y + shop.marker_offset.y,shop.location.z + shop.marker_offset.z, 0.0,0.0,0.0,0.0,0.0,0.0, shop.marker_scale.x,shop.marker_scale.y,shop.marker_scale.z, shop.marker_color.r,shop.marker_color.g,shop.marker_color.b,shop.marker_color.a, false,true,2,false)
      end
    end
    if closest_dist <= shop.interact_dist then
      if shop.draw_help then
        ShowHelpNotification(shop.help_to_draw)
      end

      if IsControlJustPressed(0,38) then
        Doors.OpenKeyShop(closest)
      end
    end

    return 0
  else
    return 500
  end
end

Doors.OpenKeyShop = function(shop_index)
  local player_data = ESX.GetPlayerData()
  local shop = Config.Shops[shop_index]
  local player_accounts = player_data.accounts
  local bank_account
  for _,account in pairs(player_accounts) do
    if account.name == Config.BankAccountName then
      bank_account = account
    end
  end
  if bank_account then
    local elements = {}
    for _,item in ipairs(shop.content) do
      if item.restricted then
        if player_data.job and player_data.job.name and item.auth_jobs[player_data.job.name] then
          if not item.auth_jobs[player_data.job.name] or (player_data.job.grade and player_data.job.grade >= item.auth_jobs[player_data.job.name].min_rank) then
            if bank_account.money >= item.item_price then
              item.canBuy = true
            else
              item.canBuy = false
            end
            item.mayBuy = true
            table.insert(elements,item)
          else
            item.canBuy = false
            item.mayBuy = false
            table.insert(elements,item)
          end
        else
          item.canBuy = false
          item.mayBuy = false
          table.insert(elements,item)
        end
      else
        item.mayBuy = true
        if bank_account.money >= item.item_price then
          item.canBuy = true
        else
          item.canBuy = false
        end
        table.insert(elements,item)
      end
    end

    SendNUIMessage({
      func = "Open",
      args = {
        items = elements,
        onBuy = "https://doors/onbuy",
        onClose = "https://doors/onclose"
      }
    })
    SetNuiFocus(true,true)
  else
    ShowNotification(Labels.no_bank_acc)
  end
end

Doors.HandleDoors = function(ply_pos)
  local now = GetGameTimer()
  if (not last_chunk or now - last_chunk > Config.Chunking.timer) or (not last_location or Vdist(last_location,ply_pos) > Config.Chunking.movement) or (Doors.ForceRechunk) then
    last_chunk = now
    last_location = ply_pos
    Doors.Chunk = Doors.ReChunk(ply_pos)
  end

  local closest,closest_dist
  for _,door_index in ipairs(Doors.Chunk) do
    local real_door = Config.Doors[door_index]
    local dist = Vdist(real_door.text_loc,ply_pos)
    if not closest_dist or dist < closest_dist then
      closest = door_index
      closest_dist = dist
    end
  end

  if closest_dist and closest_dist < Config.Doors[closest].draw then
    local text_pos = Config.Doors[closest].text_loc
    local door_text = (Config.Doors[closest].locked and (closest_dist < Config.Doors[closest].dist and Labels.do_unlock .. Labels.unlock or Labels.unlock) or (closest_dist < Config.Doors[closest].dist and Labels.do_lock .. Labels.lock or Labels.lock))

    if closest_dist < Config.Doors[closest].draw then
      for _,door in ipairs(Config.Doors[closest].objects) do
        if not door.last_check or now - door.last_check > 500 then
          door.last_check = now
          local object = GetClosestObjectOfType(door.door_loc.x,door.door_loc.y,door.door_loc.z,5.0,door.door_model,0,0,0)
          if not Config.Doors[closest].locked then
            FreezeEntityPosition(object,false)
          elseif Config.Doors[closest].locked then
			
            local rot = GetEntityRotation(object,2)
            if rot.z ~= door.door_rot.z then
              SetEntityRotation(object,door.door_rot.x,door.door_rot.y,door.door_rot.z,2)
            end
			
			
            if door.reposition then
              SetEntityCoordsNoOffset(object,door.door_loc.x,door.door_loc.y,door.door_loc.z)
            end
			
			FreezeEntityPosition(object,true)
          end
        end
      end
    end

    local in_vehicle = IsPedInAnyVehicle(GetPlayerPed(-1))
    if not in_vehicle or Config.Doors[closest].interact_in_veh then
      DrawText3D(text_pos, door_text, 20.0, closest_dist)
      if closest_dist < Config.Doors[closest].dist then
        if IsControlJustPressed(0,38) then
          local can_unlock,unlock_procedure,item_name = Doors.VerifyClient(closest)
          if can_unlock then
            if unlock_procedure == "house" then
              local _s = not Config.Doors[closest].locked
              Doors.SetLocked(closest,_s)
              TriggerServerEvent("Doors:HouseLocked",closest,_s)
              ShowNotification(Labels["access_granted"])
            elseif unlock_procedure == "job" then
              local _s = not Config.Doors[closest].locked
              Doors.SetLocked(closest,_s)
              TriggerServerEvent("Doors:JobLocked",closest,_s)
              ShowNotification(Labels["access_granted"])
            elseif unlock_procedure == "item" then
              local _s = not Config.Doors[closest].locked
              Doors.SetLocked(closest,_s)
              TriggerServerEvent("Doors:ItemLocked",closest,_s)
              ShowNotification(Labels["access_granted"])
            elseif unlock_procedure == "break" then
              Doors.MinigameHandler(closest,Config.Doors[closest].locked,item_name)
            end
          else
            ShowNotification(Labels["access_denied"])
          end
        end
      end
    end
    return 0
  else
    return 500
  end
end

Doors.MinigameCallback = function(door_index,door_state,item_name,did_win)
  if did_win then
    ShowNotification(Labels["access_granted"])
    local _s = not door_state
    Doors.SetLocked(door_index,_s)
    TriggerServerEvent("Doors:MinigameLocked",door_index,_s,item_name)
  else
    TriggerServerEvent("Doors:MinigameFailed",door_index,item_name)
    ShowNotification(Labels["access_denied"])
  end
  FreezeEntityPosition(GetPlayerPed(-1),false)
  Doors.Busy = false
end  

Doors.MinigameHandler = function(door_index,door_state,item_name)
  local door_data = Config.Doors[door_index]
  local minigame_type = Config.Doors[door_index].break_items[item_name].minigame

  if not minigame_type then return; end

  Doors.Busy = true
  FreezeEntityPosition(GetPlayerPed(-1),true)

  if minigame_type == "Lockpick" then
    TriggerEvent("lockpicking:StartMinigame",door_data.lockpick_preset.pins,function(did_win) Doors.MinigameCallback(door_index,door_state,item_name,did_win); end)
  elseif minigame_type == "LockpickV2" then
    exports["lockpick"]:Lockpick(function(did_win) Doors.MinigameCallback(door_index,door_state,item_name,did_win); end)
  elseif minigame_type == "Thermite" then
    TriggerEvent('thermite:start',function(did_win) Doors.MinigameCallback(door_index,door_state,item_name,did_win); end,door_data.thermite_preset.difficulty,door_data.thermite_preset.speed_scale,door_data.thermite_preset.score_inc)
  elseif minigame_type == "Hacking" then
    TriggerEvent("mhacking:show")
    TriggerEvent("mhacking:start",door_data.hacking_preset.letters,door_data.hacking_preset.time,function(did_win) Doors.MinigameCallback(door_index,door_state,item_name,did_win); TriggerEvent('mhacking:hide'); end)
  end
end

Doors.ReChunk = function(location)
  local in_range = {}
  for key,door in ipairs(Config.Doors) do
    local dist = Vdist(location,door.text_loc)
    if dist < Config.Chunking.range then
      table.insert(in_range,key)
    end
  end
  return in_range
end

Doors.SetLocked = function(door_index,lock_status)
  Config.Doors[door_index].locked = lock_status
end

Doors.VerifyClient = function(door_index)
  local door = Config.Doors[door_index]
  local player_data = ESX.GetPlayerData()
  local identifier = player_data.identifier

  if door.house then
    local ret,res = false,false
    TriggerEvent("Allhousing:GetHouseById",door.house,function(house,kash_id)
      if kash_id then identifier = kash_id end
      if house.Owner == identifier then
        res = true
      else
        for k,v in pairs(house.HouseKeys) do
          if v.identifier == identifier then
            res = true
            ret = true
            return
          end
        end
      end
      ret = true
    end)
    while not ret do Wait(0); end
    if res then
      return true,"house",identifier
    end
  end

  if player_data.job and player_data.job.name and door.auth_jobs[player_data.job.name] then
    if not door.auth_jobs[player_data.job.name].min_rank or (player_data.job.grade and player_data.job.grade >= door.auth_jobs[player_data.job.name].min_rank) then
      return true,"job",player_data.job
    end
  end

  if door.allow_raid then 
    if player_data.job and player_data.job.name and Config.RaidAccess[player_data.job.name] then
      if not Config.RaidAccess[player_data.job.name].min_rank or (player_data.job.grade and player_data.job.grade >= Config.RaidAccess[player_data.job.name].min_rank) then
        return true,"job",player_data.job
      end
    end
  end

  local inventory_data = player_data.inventory
  if door.auth_items then 
    for _,item in ipairs(inventory_data) do
      if door.auth_items[item.name] then
        if item.count and item.count >= 1 then
          return true,"item",item.name
        end
      end
    end
  end

  if door.can_break then
    for _,item in ipairs(inventory_data) do
      if door.break_items[item.name] then
        if item.count and item.count >= 1 then
          return true,"break",item.name
        end
      end
    end
  end

  return false,false,false
end

Doors.ClosedShop = function()
  SetNuiFocus(false,false)
end

Doors.BuyKey = function(data)
  SendNUIMessage({func = "Close"})
  TriggerServerEvent("Doors:PurchaseKey",data)
end

Doors.NotifyPolice = function(door_index)
  local door = Config.Doors[door_index]
  if door and door.text_loc then
    local player_data = ESX.GetPlayerData()
    if player_data.job and player_data.job.name and Config.PoliceJobs[player_data.job.name] then
      if not Config.PoliceJobs[player_data.job.name].min_rank or (player_data.job.grade and player_data.job.grade >= Config.PoliceJobs[player_data.job.name].min_rank) then
        local start_time = GetGameTimer()
        local zone_name = GetLabelText(GetNameOfZone(door.text_loc.x,door.text_loc.y,door.text_loc.z))
        while (GetGameTimer() - start_time) < (Config.PoliceNotifyTimer * 1000) do
          ShowHelpNotification(string.format(Labels.police_warning,zone_name))
          if IsControlJustPressed(0,38) then
            SetNewWaypoint(door.text_loc.x,door.text_loc.y)
            return
          end
          Wait(0)
        end
      end
    end
  end
end

Doors.SetDoors = function(callback)
  local doors = Doors.GetDoors()
  local i,door = next(doors)
  if door ~= nil then
    local creation = {
      text_loc = Doors.GetTextLocation(doors),
      dist = 5.0,
      draw = 10.0,
      objects = doors
    }
    Doors.CreationOptions(creation,callback)
  else
    ShowNotification("Door creation canceled.")
  end
end

Doors.RotationToDirection = function(rot)   
  if (rot == nil) then 
    rot = GetGameplayCamRot(2);  
  end   

  local  rotZ = rot.z  * ( 3.141593 / 180.0 )   
  local  rotX = rot.x  * ( 3.141593 / 180.0 )   
  local  c = math.cos(rotX);   
  local  multXY = math.abs(c)   
  local  res = vector3( ( math.sin(rotZ) * -1 )*multXY, math.cos(rotZ)*multXY, math.sin(rotX) ) 

  return res 
end  

Doors.GetCoordsInFrontOfCam = function(...)   
  local unpack = table.unpack   
  local coords,direction = GetGameplayCamCoord(), Doors.RotationToDirection()   
  local inTable  = {...}   
  local retTable = {}    

  if (#inTable == 0) or (inTable[1] < 0.000001) then 
    inTable[1] = 0.000001
  end    

  for k,distance in pairs(inTable) do     
    if (type(distance) == "number") then       
      if (distance == 0) then         
        retTable[k] = coords       
      else         
        retTable[k] = vector3(coords.x + (distance*direction.x),coords.y + (distance*direction.y),coords.z + (distance*direction.z))       
      end     
    end   
  end   

  return unpack(retTable) 
end

Doors.GetDoors = function()
  local ents  = {}
  local doors = {}
  while true do
    local ped = GetPlayerPed(-1)
    local start,fin = Doors.GetCoordsInFrontOfCam(0,5000)
    local ray = StartShapeTestRay(start.x,start.y,start.z,fin.x,fin.y,fin.z,16,ped,5000)
    local _ray,hit,pos,norm,ent = GetShapeTestResult(ray)

    local rayB = StartShapeTestRay(start.x,start.y,start.z,fin.x,fin.y,fin.z,1,ped,5000)
    local _rayB,hitB,posB,normB,entB = GetShapeTestResult(rayB)

    if hit and ent > 0 then   
      DrawSphere(pos, 0.25, 0,255,0, 0.5)

      DisableControlAction(0,24,true)
      DisableControlAction(0,25,true)
      DisableControlAction(0,142,true)

      if (ents[ent]) then
        ShowHelpNotification("~INPUT_AIM~ Finished\n~INPUT_ATTACK~ Remove door entry")
        if IsDisabledControlJustReleased(0,24) then
          ents[ent] = false
        elseif IsDisabledControlJustReleased(0,25) then
          break
        end
        DrawEntityBoundingBox(ent,100,0,0,80)
      else
        ShowHelpNotification("~INPUT_AIM~ Finished\n~INPUT_ATTACK~ Add door entry")
        if IsDisabledControlJustReleased(0,24) then
          if Doors.CheckDoor(ent) then
            ents[ent] = true
            table.insert(doors,{
              door_loc    = GetEntityCoords(ent),
              door_rot    = GetEntityRotation(ent,2),
              door_model  = GetEntityModel(ent),
              reposition  = false
            })
          else
            ShowNotification("This door is already defined elsewhere.")
          end
        elseif IsDisabledControlJustReleased(0,25) then
          break
        end
        DrawEntityBoundingBox(ent,0,100,0,80)
      end
    else
      DrawSphere(posB, 0.25, 255,0,0, 0.5)
      ShowHelpNotification("~INPUT_AIM~ Finished")
      if IsDisabledControlJustReleased(0,25) then
        break
      end
    end
    Wait(0)
  end
  return doors
end

Doors.RotateVectorFlat = function(vec,heading) 
  heading = heading / 57.2958
  local cos = math.cos(heading)
  local sin = math.sin(heading)
  return vector3(cos*vec.x-sin*vec.y,sin*vec.x+cos*vec.y,vec.z)
end

Doors.GetTextLocation = function(doors)
  local move_offset = vector3(0.0,0.0,0.0)  
  local modifier = 1.0 * GetFrameTime()
  local controls = Controls["TextOffset"]
  local scaleform = Instructional.Create(controls)

  local text_pos

  if #doors > 1 then
    local count = 0
    local x,y,z = 0,0,0
    for k,v in pairs(doors) do
      x = x + v.door_loc.x
      y = y + v.door_loc.y
      z = z + v.door_loc.z

      count = count + 1
    end

    text_pos = vector3(x / count, y / count, z / count)
  else
    local pos = doors[1].door_loc
    local min,max = GetModelDimensions(doors[1].door_model)
    local head = doors[1].door_rot.z
    local offset = Doors.RotateVectorFlat(vector3((min.x + max.x)/2,(min.y + max.y)/2,0),head)
    text_pos = pos + offset
  end

  Wait(500)

  while true do
    ShowHelpNotification("Set Text Location")

    if IsDisabledControlJustReleased(0,controls.done.codes[1]) then
      break
    end

    if IsControlPressed(0,controls.height.codes[2]) then
      move_offset = move_offset + (vector3(0.0,0.0,1.0) * modifier)
    elseif IsControlPressed(0,controls.height.codes[1]) then
      move_offset = move_offset - (vector3(0.0,0.0,1.0) * modifier)
    end

    if IsControlPressed(0,controls.forward.codes[1]) then
      move_offset = move_offset + (vector3(1.0,0.0,0.0) * modifier)
    elseif IsControlPressed(0,controls.forward.codes[2]) then
      move_offset = move_offset - (vector3(1.0,0.0,0.0) * modifier)
    end

    if IsControlPressed(0,controls.right.codes[1]) then
      move_offset = move_offset + (vector3(0.0,1.0,0.0) * modifier)
    elseif IsControlPressed(0,controls.right.codes[2]) then
      move_offset = move_offset - (vector3(0.0,1.0,0.0) * modifier)
    end

    DrawText3D(text_pos + move_offset,"TEXT EXAMPLE",20.0,1.0)

    DrawScaleformMovieFullscreen(scaleform,255,255,255,255,0)
    Wait(0)
  end

  return (text_pos + move_offset)
end

Doors.CheckDoor = function(object)
  local pos = GetEntityCoords(object)
  for k,v in pairs(Config.Doors) do
    for _,door in ipairs(v.objects) do
      if Vdist(door.door_loc,pos) < 0.2 then
        return false
      end
    end
  end
  return true
end

Doors.CreationOptions = function(creation,callback)
  local elements = {
    {
      label = string.format("Locked: %s",tostring( (creation.locked or false) )),
      value = (creation.locked or false),
      index = 'locked',
      prefix = "Locked",
    },
    {
      label = string.format("Reposition: %s",tostring( (creation.reposition or false) )),
      value = (creation.reposition or false),
      index = 'reposition',
      prefix = "Reposition",
    },
    {
      label = string.format("Interact In Veh: %s",tostring( (creation.interact_in_veh or false) )),
      value = (creation.interact_in_veh or false),
      index = 'interact_in_veh',
      prefix = "Interact In Veh",
    },
    {
      label = string.format("Allow Raiding: %s",tostring( (creation.allow_raid or false) )),
      value = (creation.allow_raid or false),
      index = 'allow_raid',
      prefix = "Allow Raiding",
    },
    {
      label = string.format("Allow Break In: %s",tostring( (creation.can_break or false) )),
      value = (creation.can_break or false),
      index = 'can_break',
      prefix = "Allow Break In",
    },
    {
      label = string.format("Interact Dist: %s",tostring((creation.dist or 2.5))),
      value = (creation.dist or 2.5),
      index = 'dist',
      prefix = "Interact Dist",
    },
    {
      label = string.format("Render Dist: %s",tostring((creation.draw or 5.0))),
      value = (creation.draw or 5.0),
      index = 'draw',
      prefix = "Render Dist",
    },
    {
      label = "Done"
    }
  }

  ESX.UI.Menu.Open('default', GetCurrentResourceName(), "door_creation", {
      title    = "Doors",
      align    = 'left',
      elements = elements,
    }, 
    function(data,menu)
      if data.current.index then
        local _v
        if (type(data.current.value) == "boolean") then
          _v = not data.current.value
        else
          if data.current.value >= 20.0 then
            _v = 2.5
          elseif data.current.value == 2.5 then
            _v = 5.0
          elseif data.current.value == 5.0 then
            _v = 10.0
          elseif data.current.value == 10.0 then
            _v = 20.0
          end
        end

        creation[data.current.index] = _v

        for k,v in pairs(menu.data.elements) do
          if v.index == data.current.index then
            menu.setElement(k,'label',string.format("%s: %s",data.current.prefix,tostring(_v)))
            menu.setElement(k,'value',_v)
            menu.refresh()
          end
        end
      else
        menu.close()
      end
    end,
    function(data,menu)
      menu.close()
    end,
    function(data,menu)
    end,
    function(data,menu)
      Doors.CreationJobs(creation,callback)
    end
  )
end

Doors.CreationJobs = function(creation,callback)
  creation.auth_jobs = (creation.auth_jobs or {})
  ESX.TriggerServerCallback("Doors:GetJobs",function(jobs)
    local elements  = {}
    local _jobs     = {}
    for k,v in pairs(jobs) do
      _jobs[v.name] = v
      table.insert(elements,{
        label = string.format("%s: %s",v.label,(creation.auth_jobs[v.name] and tostring(creation.auth_jobs[v.name].min_rank) or tostring(false))),
        index = v.name,
        value = (creation.auth_jobs[v.name] or false)
      })
    end
    table.insert(elements,{label = "Done",value = "Done"})

    ESX.UI.Menu.Open('default', GetCurrentResourceName(), "door_creation_jobs", {
        title    = "Authorized Jobs",
        align    = 'left',
        elements = elements,
      }, 
      function(data,menu)
        if data.current.value == "Done" then
          menu.close()
        else
          local elements = {}
          for k,v in pairs(_jobs[data.current.index].grades) do
            table.insert(elements,{label = string.format("[%i] %s",k,v.label),value = k})
          end
          table.insert(elements,{label = "Unauthorize",value = "Unauthorize"})

          ESX.UI.Menu.Open('default',GetCurrentResourceName(),"door_creation_grade",{
              title    = "Job Rank",
              align    = 'left',
              elements = elements,          
            },
            function(d,m)
              m.close()

              if d.current.value == "Unauthorize" then              
                creation.auth_jobs[data.current.index] = nil
              else
                creation.auth_jobs[data.current.index] = {min_rank = tonumber(d.current.value)}
              end
              Doors.CreationJobs(creation,callback)
            end
          )
        end
      end,
      function(data,menu)
        menu.close()
      end,
      function(data,menu)
      end,
      function(data,menu)
        Doors.CreationMinigames(creation,callback)
      end
    )
  end)
end

Doors.CreationMinigames = function(creation,callback)
  creation.break_items = (creation.break_items or {})
  if creation.can_break then
    local elements = {}
    for k,v in pairs(Minigames) do
      creation.break_items[v.item] = (creation.break_items[v.item] or false)
      table.insert(elements,{
        label = k,
        index = k,
        value = v
      })
    end
    table.insert(elements,{
      label = "Done",
      value = "Done",
    })

    ESX.UI.Menu.Open('default',GetCurrentResourceName(),"door_creation_games",{
        title    = "Minigames",
        align    = 'left',
        elements = elements,          
      },
      function(d,m)
        m.close()

        if (d.current.value ~= "Done") then             
          local elements = {
            [1] = {label = d.current.label},
            [2] = {prefix = "Use",          label = string.format("Use: %s",tostring( (creation.break_items[d.current.value.item] and true or false) )),                                                              value = (creation.break_items[d.current.value.item] and true or false),                                                    index="use"},
            [3] = {prefix = "Take Item",    label = string.format("Take Item: %s",tostring( (creation.break_items[d.current.value.item] and creation.break_items[d.current.value.item].take_item or false) )),        value = (creation.break_items[d.current.value.item] and creation.break_items[d.current.value.item].take_item or false),    index="take_item"},
            [4] = {prefix = "Take On Fail", label = string.format("Take On Fail: %s",tostring( (creation.break_items[d.current.value.item] and creation.break_items[d.current.value.item].take_on_fail or false) )),  value = (creation.break_items[d.current.value.item] and creation.break_items[d.current.value.item].take_on_fail or false), index="take_on_fail" }
          }
          if d.current.value.options then
            table.insert(elements,{
              label = "Options",
              value = "Options"
            })
          end
          table.insert(elements,{
            label = "Back",
            value = "Back",
          })
          ESX.UI.Menu.Open('default',GetCurrentResourceName(),"door_creation_games",{
              title    = "Minigames",
              align    = 'left',
              elements = elements,          
            },
            function(data,menu)
              if data.current.value ~= nil then
                if (data.current.value == "Back") then
                  menu.close()
                  Doors.CreationMinigames(creation,callback)
                elseif (data.current.value == "Options") then
                  menu.close()
                  Doors.SetMinigameOptions(creation,d.current.index,callback)
                elseif data.current.index == "use" then
                  if data.current.value == true then
                    creation.break_items[d.current.value.item] = false
                  else 
                    creation.break_items[d.current.value.item] = {
                      minigame = d.current.index,
                      take_item = false,
                      take_on_fail = false,
                    }               
                    Doors.SetupMinigameOptions(creation,d.current.index,callback)
                  end

                  for k,v in pairs(menu.data.elements) do
                    if v.label == data.current.label then
                      menu.setElement(k,'label',string.format("%s: %s",data.current.prefix,tostring( (creation.break_items[d.current.value.item] and true or false) )))
                      menu.setElement(k,'value',(creation.break_items[d.current.value.item] and true or false))
                      menu.refresh()
                      break
                    end
                  end
                elseif creation.break_items[d.current.value.item] then
                  creation.break_items[d.current.value.item][data.current.index] = (not creation.break_items[d.current.value.item][data.current.index])

                  for k,v in pairs(menu.data.elements) do
                    if v.label == data.current.label then
                      menu.setElement(k,'label',string.format("%s: %s",data.current.prefix,tostring(creation.break_items[d.current.value.item][data.current.index])))
                      menu.setElement(k,'value',creation.break_items[d.current.value.item][data.current.index])
                      menu.refresh()
                      break
                    end
                  end
                end
              end
            end
          )
        else
          Doors.SetItemOptions(creation,callback)
        end
      end
    )
  else
    Doors.SetItemOptions(creation,callback)
  end
end

Doors.SetupMinigameOptions = function(creation,minigame,callback)
  if Minigames[minigame].options then
    for k,v in pairs(Minigames[minigame].options) do
      creation[string.format("%s_preset",minigame:lower())]      = (creation[string.format("%s_preset",minigame:lower())] or {})
      creation[string.format("%s_preset",minigame:lower())][k]   = v.min
    end
  end
end

Doors.SetMinigameOptions = function(creation,minigame,callback)
  creation[string.format("%s_preset",minigame:lower())] = (creation[string.format("%s_preset",minigame:lower())] or {})
  local elements = {}
  for k,v in pairs(Minigames[minigame].options) do
    creation[string.format("%s_preset",minigame:lower())][k] = (creation[string.format("%s_preset",minigame:lower())][k] or v.min)
    table.insert(elements,{
      label = string.format("%s: %s",k,creation[string.format("%s_preset",minigame:lower())][k]),
      value = creation[string.format("%s_preset",minigame:lower())][k],
      index = k
    })
  end
  table.insert(elements,{
    label = "Done",
    value = "Done"
  })
  ESX.UI.Menu.Open('default',GetCurrentResourceName(),"door_creation_options",{
      title    = "Options",
      align    = 'left',
      elements = elements,          
    },
    function(data,menu)
      menu.close()

      if data.current.value == "Done" then
        Doors.CreationMinigames(creation,callback)
      else
        local options = Minigames[minigame].options[data.current.index]
        local eles = {}
        for i=options.min,options.max,options.step do
          table.insert(eles,{
            label = i,
            value = i
          })
        end
        ESX.UI.Menu.Open('default',GetCurrentResourceName(),"option_"..data.current.index,{
            title    = data.current.index,
            align    = 'left',
            elements = eles,          
          },
          function(d,m)
            m.close()

            creation[string.format("%s_preset",minigame:lower())][data.current.index] = d.current.value 
            Doors.SetMinigameOptions(creation,minigame,callback)
          end
        )
      end
    end
  )
end

Doors.SetItemOptions = function(creation,callback)
  local elements = {}
  creation.auth_items = (creation.auth_items or {})

  for k,v in pairs(AuthorizedItems) do
    creation.auth_items[v] = false
    table.insert(elements,{
      label = string.format("%s: %s",v, ( creation.auth_items[k] and tostring(true) or tostring(false) ) ),
      value = creation.auth_items[k],
      index = k
    })
  end
  table.insert(elements,{
    label = "Done",
    value = "done"
  })

  ESX.UI.Menu.Open('default',GetCurrentResourceName(),"door_authed_items",{
      title    = "Items",
      align    = 'left',
      elements = elements,          
    },
    function(data,menu)
      menu.close()

      if data.current.value == "done" then
        if creation.reposition then
          for k,v in pairs(creation.objects) do
            v.reposition = true
          end
        end
        for k,v in pairs(creation.auth_items) do
          if v == true then
            creation.auth_items[k] = {take_item = false}
          else
            creation.auth_items[k] = nil
          end
        end
        creation.reposition = nil
        if callback then
          callback(creation)
        else
          TriggerServerEvent("Doors:Save",creation)
        end
      else
        creation.auth_items[data.current.index] = not creation.auth_items[data.current.index]
        Doors.SetItemOptions(creation,callback)
      end
    end
  )
end

Doors.Saved = function(data)
  table.insert(Config.Doors,data)
  Doors.ForceRechunk = true
end

Doors.Removed = function(door_index)
  table.remove(Config.Doors,door_index)
  Doors.ForceRechunk = true
end

Doors.Remove = function()
  local ply_pos = GetEntityCoords(GetPlayerPed(-1))
  local closest,closest_dist
  for _,door_index in ipairs(Doors.Chunk) do
    local real_door = Config.Doors[door_index]
    local dist = Vdist(real_door.text_loc,ply_pos)
    if not closest_dist or dist < closest_dist then
      closest = door_index
      closest_dist = dist
    end
  end

  if closest and closest_dist <= 10.0 then
    TriggerServerEvent("Doors:Remove",closest)
  else
    Doors.ShowNotification("Unable to find door nearby.")
  end
end

RegisterNetEvent("Doors:Remove")
AddEventHandler("Doors:Remove",Doors.Remove)

RegisterNetEvent("Doors:Removed")
AddEventHandler("Doors:Removed",Doors.Removed)

RegisterNetEvent("Doors:Init")
AddEventHandler("Doors:Init",Doors.Init)

RegisterNetEvent("Doors:SetLocked")
AddEventHandler("Doors:SetLocked",Doors.SetLocked)

RegisterNetEvent("Doors:NotifyPolice")
AddEventHandler("Doors:NotifyPolice",Doors.NotifyPolice)

RegisterNetEvent("Doors:Saved")
AddEventHandler("Doors:Saved",Doors.Saved)

RegisterNetEvent("Doors:CreateDoors")
AddEventHandler("Doors:CreateDoors",Doors.SetDoors)

RegisterNUICallback('onclose', Doors.ClosedShop)
RegisterNUICallback('onbuy',Doors.BuyKey)

Citizen.CreateThread(Doors.Awake)