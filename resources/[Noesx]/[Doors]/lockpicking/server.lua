function lockpicking:GetLockpickCount(source)
  local xPlayer = ESX.GetPlayerFromId(source)
  while not xPlayer do Citizen.Wait(0); xPlayer = ESX.GetPlayerFromId(source); end
  local item = xPlayer.getInventoryItem('lockpick')
  return item.count or 0
end

function lockpicking:MinigameComplete(source,didWin)
  if not didWin and self.UsingLockpickItem then
    local xPlayer = ESX.GetPlayerFromId(source)
    while not xPlayer do Citizen.Wait(0); xPlayer = ESX.GetPlayerFromId(source); end
    xPlayer.removeInventoryItem('lockpick',1)
  end
end

RegisterNetEvent('lockpicking:MinigameComplete')
AddEventHandler('lockpicking:MinigameComplete', function(didWin) lockpicking:MinigameComplete(source,didWin); end)

ESX.RegisterServerCallback('lockpicking:GetLockpickCount', function(source,cb) cb(lockpicking:GetLockpickCount(source)); end)