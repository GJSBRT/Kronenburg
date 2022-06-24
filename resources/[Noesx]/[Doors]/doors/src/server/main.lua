RegisterNetEvent("Doors:Init")

AddEventHandler("Doors:Init",function(...)

  local _source = source

  while not Doors       do Wait(0); end

  while not Doors.Ready do Wait(0); end

  Doors.Init(_source)

end)



RegisterNetEvent("Doors:Remove")

AddEventHandler("Doors:Remove",function(door_index)

  Doors.Remove(door_index)

end)



RegisterCommand('doors:make',function(source,args)

  TriggerClientEvent("Doors:CreateDoors",source)

end,true)



RegisterCommand('doors:remove',function(source,args)

  TriggerClientEvent("Doors:Remove",source)

end,true)



error = function(...) end



Doors = {}



Doors.Saved = {}



Doors.SetLocked = function(door_index,lock_state)

  Config.Doors[door_index].locked = lock_state

  TriggerClientEvent("Doors:SetLocked",-1,door_index,lock_state)

end



Doors.JobLocked = function(door_index,door_state)

  if Doors.Crashing then return; end

  local door = Config.Doors[door_index]

  local player_data = ESX.GetPlayerFromId(source)

  local job = player_data.getJob()



  if job and job.name and door.auth_jobs[job.name] then

    if not door.auth_jobs[job.name].min_rank or (job.grade and job.grade >= door.auth_jobs[job.name].min_rank) then      

      Doors.SetLocked(door_index,door_state)

      return

    end

  end



  if door.allow_raid then 

    if job and job.name and Config.RaidAccess[player_data.job.name] then

      if not Config.RaidAccess[player_data.job.name].min_rank or (job.grade and job.grade >= Config.RaidAccess[player_data.job.name].min_rank) then      

        Doors.SetLocked(door_index,door_state)

        return

      end

    end

  end

end



Doors.ItemLocked = function(door_index,door_state)

  if Doors.Crashing then return; end

  local door = Config.Doors[door_index]

  local player_data = ESX.GetPlayerFromId(source)

  local inventory = player_data.getInventory()

  for _,item in ipairs(inventory) do

    if door.auth_items[item.name] then

      if item.count and item.count >= 1 then

        if door.auth_items[item.name].take_item then

          player_data.removeInventoryItem(item.name,1)

        end

        Doors.SetLocked(door_index,door_state)

        return

      end

    end

  end

end



Doors.HouseLocked = function(door_index,door_state)

  if Doors.Crashing then return; end

  local door = Config.Doors[door_index]

  local player_data = ESX.GetPlayerFromId(source)

  local identifier = player_data.getIdentifier()

  TriggerEvent("Allhousing:GetHouseById",door.house,function(house,kashId)

    if kashId then identifier = kashId; end

    if house.Owner == (identifier) then

      Doors.SetLocked(door_index,door_state)

    else

      for k,v in pairs(house.HouseKeys) do

        if v.identifier == (identifier) then

          Doors.SetLocked(door_index,door_state)

          return

        end

      end

    end

  end,source)

end



Doors.MinigameLocked = function(door_index,door_state,item_name)

  if Doors.Crashing then return; end

  local door = Config.Doors[door_index]

  local player_data = ESX.GetPlayerFromId(source)

  local inventory = player_data.getInventory()



  if Config.WarnPoliceOnSuccess then

    TriggerClientEvent("Doors:NotifyPolice",-1,door_index)

  end



  for _,item in ipairs(inventory) do

    if item_name == item.name and door.break_items[item_name] then

      if item.count and item.count >= 1 then

        if door.break_items[item_name].take_item then

          player_data.removeInventoryItem(item_name,1)

        end

        Doors.SetLocked(door_index,door_state)

        return

      end

    end

  end

end



Doors.MinigameFailed = function(door_index,item_name)

  if Doors.Crashing then return; end

  local door = Config.Doors[door_index]

  

  if Config.WarnPoliceOnFail then

    TriggerClientEvent("Doors:NotifyPolice",-1,door_index)

  end



  if door.break_items[item_name].take_on_fail then

    local player_data = ESX.GetPlayerFromId(source)

    player_data.removeInventoryItem(item_name,1)

  end

end



Doors.Init = function(source)

  if Doors.Crashing then return; end

  while not Doors.Ready do Wait(0); end

  TriggerClientEvent("Doors:Init",source,Config.Doors)

end



Doors.PurchaseKey = function(item_data)

  local player_data = ESX.GetPlayerFromId(source)

  local bank_account = player_data.getAccount('bank')

  if bank_account and bank_account.money >= item_data.item_price then

    player_data.removeAccountMoney('bank',item_data.item_price)

    player_data.addInventoryItem(item_data.item_name,1)

  end

end  



Doors.Remove = function(door_index)

  if Doors.Crashing then return; end

  local index = Doors.Saved[door_index]



  if not index or not Doors.Saved[door_index] then return; end



  TriggerClientEvent("Doors:Removed",-1,door_index)

  MySQL.Async.execute("DELETE FROM `doors` WHERE `index`=@index",{['@index'] = index})



  table.remove(Config.Doors,door_index)

  Doors.Saved[door_index] = nil

end



RegisterNetEvent("Doors:JobLocked")

AddEventHandler("Doors:JobLocked",Doors.JobLocked)



RegisterNetEvent("Doors:ItemLocked")

AddEventHandler("Doors:ItemLocked",Doors.ItemLocked)



RegisterNetEvent("Doors:HouseLocked")

AddEventHandler("Doors:HouseLocked",Doors.HouseLocked)



RegisterNetEvent("Doors:PurchaseKey")

AddEventHandler("Doors:PurchaseKey",Doors.PurchaseKey)



RegisterNetEvent("Doors:MinigameLocked")

AddEventHandler("Doors:MinigameLocked",Doors.MinigameLocked)



RegisterNetEvent("Doors:MinigameFailed")

AddEventHandler("Doors:MinigameFailed",Doors.MinigameFailed)



ESX.RegisterServerCallback("Doors:GetJobs",function(source,callback)

  if ESX.GetJobs then

    callback(ESX.GetJobs())

  else

    print("You have not added the ESX.GetJobs function, making this highly unlikely to return a proper list of jobs.")

    callback(ESX.Jobs)

  end

end)



RegisterNetEvent("Doors:Save")

AddEventHandler("Doors:Save",function(data)

  cleanse = function(d)

    local ret = {}

    for k,v in pairs(d) do

      local t = type(v)

      if t == "table" then

        ret[k] = cleanse(v)

      elseif t == "vector3" then

        ret[k] = {x = v.x, y = v.y, z = v.z}

      else

        ret[k] = v

      end

    end

    return ret

  end

  count = function()

    local n = 1

    for k,v in pairs(Doors.Saved) do

      n = n + 1

    end

    return n

  end

  local cleansed  = cleanse(data)

  local id        = #Config.Doors+1

  local index     = count()



  MySQL.Async.execute("INSERT INTO doors SET door=@door",{['@door'] = json.encode(cleansed)})



  Config.Doors[id]  = data

  Doors.Saved[id]   = index



  TriggerClientEvent("Doors:Saved",-1,data)

end)



MySQL.ready(function() 

  MySQL.Async.fetchAll('SELECT * FROM doors',{},function(data)

    for k,v in pairs(data) do

      local d = json.decode(v.door)

      local i = #Config.Doors+1

      Config.Doors[i] = d

      Doors.Saved[i]  = v.index

    end

    Doors.Ready = true

  end)

end)