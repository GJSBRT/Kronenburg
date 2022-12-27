--[[ 
	Kronenburg Roleplay
	Copyright © GJSBRT <g@gijs.eu>

	This project is licensed under the terms of the Apache License 2.0 license.
	https://choosealicense.com/licenses/apache-2.0/
]]
 
 
function WalkMenuStart(name)

  if name == "move_lester_caneup" or name == "move_heist_lester" then
    RequestWalking(name)
    SetPedMovementClipset(PlayerPedId(), name, 0.2)
    AddPropToPlayer("prop_cs_walking_stick", 57005, 0.09, 0.035, 0.0, 0.0, 276.0, 160.0)
                                                        -- 0.39, 0.0, 0.0, 0.0, 266.0, 10.0
  elseif name == "move_lester_caneup_kruk" then
    RequestWalking('move_lester_caneup')
    TriggerEvent("crouchprone:client:SetWalkSet", 'move_lester_caneup')
    SetPedMovementClipset(PlayerPedId(), 'move_lester_caneup', 0.2)
    AddPropToPlayer("r4lle_krycka", 57005, 0.12, -0.03, -0.03, 7.0, 276.0, 160.0)
  else
    RequestWalking(name)
    -- print(name)
    SetPedMovementClipset(PlayerPedId(), name, 0.2)
  end
  RemoveAnimSet(name)
end

function RequestWalking(set)
  RequestAnimSet(set)
  while not HasAnimSetLoaded(set) do
    Citizen.Wait(1)
  end 
end

function WalksOnCommand(source, args, raw)
  local WalksCommand = ""
  for a in pairsByKeys(DP.Walks) do
    WalksCommand = WalksCommand .. ""..string.lower(a)..", "
  end
  EmoteChatMessage(WalksCommand)
  EmoteChatMessage("Type /walk reset om te resetten.")
end

function WalkCommandStart(source, args, raw)
  if args[1] ~= nil then
    local name = firstToUpper(args[1])

    if name == "Reset" then
        ResetPedMovementClipset(PlayerPedId())
        DestroyAllProps()
        return
    end
    if DP.Walks[name] ~= nil then
      local name2 = table.unpack(DP.Walks[name])
      if name2 ~= nil then
        WalkMenuStart(name2)
      else
        EmoteChatMessage("'"..name.."' is geen geldig loopje.")
      end
    end
  end
end