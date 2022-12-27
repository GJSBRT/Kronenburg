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

-- You probably shouldnt touch these.
local AnimationDuration = -1
local ChosenAnimation = ""
local ChosenDict = ""
local IsInAnimation = false
local MostRecentChosenAnimation = ""
local MostRecentChosenDict = ""
local MovementType = 0
local PlayerGender = "male"
local PlayerHasProp = false
local PlayerProps = {}
local PlayerParticles = {}
local SecondPropEmote = false
local lang = Config.MenuLanguage
local PtfxNotif = false
local PtfxPrompt = false
local PtfxWait = 500
local PtfxNoProp = false
local DisableKeybindings = false

Citizen.CreateThread(function()
  while true do

    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end

    if IsPedShooting(PlayerPedId()) and IsInAnimation then
      EmoteCancel()
      DestroyAllProps()
    end

    if PtfxPrompt then
      if not PtfxNotif then
          SimpleNotify(PtfxInfo)
          PtfxNotif = true
      end
      if IsControlPressed(0, 47) then
        PtfxStart()
        Wait(PtfxWait)
        PtfxStop()
      end
    end

    if Config.MenuKeybindEnabled then if IsControlPressed(0, Config.MenuKeybind) and GetLastInputMethod(2) then OpenEmoteMenu() end end
    if Config.EnableXtoCancel then if IsControlPressed(0, 73) then EmoteCancel() DestroyAllProps() end end
    Citizen.Wait(7)
  end
end)

-----------------------------------------------------------------------------------------------------
-- Commands / Events --------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------

Citizen.CreateThread(function()
    TriggerEvent('chat:addSuggestion', '/e', 'Speel een animatie.', {{ name="emotename", help="dance, camera, sit of een andere bestaande animatie."}})
    TriggerEvent('chat:addSuggestion', '/e', 'Speel een animatie.', {{ name="emotename", help="dance, camera, sit of een andere bestaande animatie."}})
    TriggerEvent('chat:addSuggestion', '/emote', 'Speel een animatie.', {{ name="emotename", help="dance, camera, sit of een andere bestaande animatie."}})
    if Config.SqlKeybinding then
      TriggerEvent('chat:addSuggestion', '/emotebind', 'Bind an emote', {{ name="key", help="num4, num5, num6, num7. num8, num9. Numpad 4-9!"}, { name="emotename", help="dance, camera, sit of een andere bestaande animatie."}})
      TriggerEvent('chat:addSuggestion', '/emotebinds', 'Check your currently bound emotes.')
    end
    TriggerEvent('chat:addSuggestion', '/emotemenu', 'Open het animatie menu (F3).')
    TriggerEvent('chat:addSuggestion', '/emotes', 'Lijst met beschikbare animaties.')
    TriggerEvent('chat:addSuggestion', '/walk', 'Kies je loopje.', {{ name="style", help="/walks for a list of valid styles"}})
    TriggerEvent('chat:addSuggestion', '/walks', 'Lijst met beschikbare loopjes.')
end)

RegisterCommand('e', function(source, args, raw) EmoteCommandStart(source, args, raw) end)
RegisterCommand('emote', function(source, args, raw) EmoteCommandStart(source, args, raw) end)
if Config.SqlKeybinding then
  RegisterCommand('emotebind', function(source, args, raw) EmoteBindStart(source, args, raw) end)
  RegisterCommand('emotebinds', function(source, args, raw) EmoteBindsStart(source, args, raw) end)
end
RegisterCommand('emotemenu', function(source, args, raw) OpenEmoteMenu() end)
RegisterCommand('emotes', function(source, args, raw) EmotesOnCommand() end)
RegisterCommand('walk', function(source, args, raw) WalkCommandStart(source, args, raw) end)
RegisterCommand('walks', function(source, args, raw) WalksOnCommand() end)

AddEventHandler('onResourceStop', function(resource)
  if resource == GetCurrentResourceName() then
    DestroyAllProps()
    ClearPedTasksImmediately(PlayerPedId())
    ResetPedMovementClipset(PlayerPedId())
  end
end)

-----------------------------------------------------------------------------------------------------
------ Functions and stuff --------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------

function EmoteCancel()

  if ChosenDict == "MaleScenario" and IsInAnimation then
    ClearPedTasksImmediately(PlayerPedId())
    IsInAnimation = false
    DebugPrint("Forced scenario exit")
  elseif ChosenDict == "Scenario" and IsInAnimation then
    ClearPedTasksImmediately(PlayerPedId())
    IsInAnimation = false
    DebugPrint("Forced scenario exit")
  end

  PtfxNotif = false
  PtfxPrompt = false

  if IsInAnimation then
    PtfxStop()
    ClearPedTasks(PlayerPedId())
    DestroyAllProps()
    IsInAnimation = false
  end
end

function EmoteChatMessage(args)
  if args == display then
    TriggerServerEvent('errormsgchat', '')
  elseif args then
    args = "'".. args .. "' is geen geldige animatie!"
    TriggerServerEvent('errormsgchat', args)
  elseif args == 'male' then
    TriggerServerEvent('errormsgchat', 'Dit is een mannelijke animatie!')
  elseif args == 'cancel' then
    TriggerServerEvent('errormsgchat', 'Er is geen animatie om te annuleren!')
  end
end

function DebugPrint(args)
  if Config.DebugDisplay then
    print(args)
  end
end

function PtfxStart()
    if PtfxNoProp then
      PtfxAt = PlayerPedId()
    else
      PtfxAt = prop
    end
    UseParticleFxAssetNextCall(PtfxAsset)
    Ptfx = StartNetworkedParticleFxLoopedOnEntityBone(PtfxName, PtfxAt, Ptfx1, Ptfx2, Ptfx3, Ptfx4, Ptfx5, Ptfx6, GetEntityBoneIndexByName(PtfxName, "VFX"), 1065353216, 0, 0, 0, 1065353216, 1065353216, 1065353216, 0)
    SetParticleFxLoopedColour(Ptfx, 1.0, 1.0, 1.0)
    table.insert(PlayerParticles, Ptfx)
end

function PtfxStop()
  for a,b in pairs(PlayerParticles) do
    DebugPrint("Stopped PTFX: "..b)
    StopParticleFxLooped(b, false)
    table.remove(PlayerParticles, a)
  end
end

function EmotesOnCommand(source, args, raw)
  local EmotesCommand = ""
  for a in pairsByKeys(DP.Emotes) do
    EmotesCommand = EmotesCommand .. ""..a..", "
  end
  -- EmoteChatMessage(EmotesCommand)
  -- EmoteChatMessage(Config.Languages[lang]['emotemenucmd'])
end

function pairsByKeys (t, f)
    local a = {}
    for n in pairs(t) do
        table.insert(a, n)
    end
    table.sort(a, f)
    local i = 0      -- iterator variable
    local iter = function ()   -- iterator function
        i = i + 1
        if a[i] == nil then
            return nil
        else
            return a[i], t[a[i]]
        end
    end
    return iter
end

function EmoteMenuStart(args, hard)
    local name = args
    local etype = hard

    if etype == "dances" then
        if DP.Dances[name] ~= nil then
          if OnEmotePlay(DP.Dances[name]) then end
        end
    elseif etype == "props" then
        if DP.PropEmotes[name] ~= nil then
          if OnEmotePlay(DP.PropEmotes[name]) then end
        end
        -- Dit hier zorgt samen met EmoteMenu ervoor dat je de animatie kan uitvoeren
    elseif etype == "sit" then   
        if DP.SitEmotes[name] ~= nil then
          if OnEmotePlay(DP.SitEmotes[name]) then end
        end   
    elseif etype == "wave" then   
        if DP.WaveEmotes[name] ~= nil then
          if OnEmotePlay(DP.WaveEmotes[name]) then end
        end
    elseif etype == "work" then   
        if DP.WorkEmotes[name] ~= nil then
          if OnEmotePlay(DP.WorkEmotes[name]) then end
        end    
    elseif etype == "food" then   
        if DP.FoodEmotes[name] ~= nil then
          if OnEmotePlay(DP.FoodEmotes[name]) then end
        end    
    elseif etype == "lean" then   
        if DP.LeanEmotes[name] ~= nil then
          if OnEmotePlay(DP.LeanEmotes[name]) then end
        end    
    elseif etype == "wait" then   
        if DP.WaitEmotes[name] ~= nil then
          if OnEmotePlay(DP.WaitEmotes[name]) then end
        end    
----------------------------------------------------------------------------------------------------
    elseif etype == "emotes" then
        if DP.Emotes[name] ~= nil then
          if OnEmotePlay(DP.Emotes[name]) then end
        else
          if name ~= "🕺 Dans Animaties" then end
        end
    elseif etype == "expression" then
        if DP.Expressions[name] ~= nil then
          if OnEmotePlay(DP.Expressions[name]) then end
        end
    end
end

function EmoteCommandStart(source, args, raw)
    if #args > 0 then
    local name = string.lower(args[1])
    if name == "c" then
        if IsInAnimation then
            EmoteCancel()
        else
            EmoteChatMessage('cancel')
        end
      return
    elseif name == "help" then
      EmotesOnCommand()
    return end
    if DP.Emotes[name] ~= nil then
      if OnEmotePlay(DP.Emotes[name]) then end return
    elseif DP.Dances[name] ~= nil then
      if OnEmotePlay(DP.Dances[name]) then end return
    elseif DP.PropEmotes[name] ~= nil then
      if OnEmotePlay(DP.PropEmotes[name]) then end return    
    elseif DP.SitEmotes[name] ~= nil then
        if OnEmotePlay(DP.SitEmotes[name]) then end return    
    elseif DP.WaveEmotes[name] ~= nil then
        if OnEmotePlay(DP.WaveEmotes[name]) then end return    
    elseif DP.LeanEmotes[name] ~= nil then
        if OnEmotePlay(DP.LeanEmotes[name]) then end return    
    elseif DP.WaitEmotes[name] ~= nil then
        if OnEmotePlay(DP.WaitEmotes[name]) then end return 
    elseif DP.FoodEmotes[name] ~= nil then
        if OnEmotePlay(DP.FoodEmotes[name]) then end return
    elseif DP.WorkEmotes[name] ~= nil then
        if OnEmotePlay(DP.WorkEmotes[name]) then end return
    else
      EmoteChatMessage(name)
    end
  end
end

function LoadAnim(dict)
  while not HasAnimDictLoaded(dict) do
    RequestAnimDict(dict)
    Wait(10)
  end
end

function LoadPropDict(model)
  while not HasModelLoaded(GetHashKey(model)) do
    RequestModel(GetHashKey(model))
    Wait(10)
  end
end

function PtfxThis(asset)
  while not HasNamedPtfxAssetLoaded(asset) do
    RequestNamedPtfxAsset(asset)
    Wait(10)
  end
  UseParticleFxAssetNextCall(asset)
end

function DestroyAllProps()
  for _,v in pairs(PlayerProps) do
    DeleteEntity(v)
  end
  PlayerHasProp = false
  DebugPrint("Destroyed Props")
end

function AddPropToPlayer(prop1, bone, off1, off2, off3, rot1, rot2, rot3)
  local Player = PlayerPedId()
  local x,y,z = table.unpack(GetEntityCoords(Player))

  if not HasModelLoaded(prop1) then
    LoadPropDict(prop1)
  end

  prop = CreateObject(GetHashKey(prop1), x, y, z+0.2,  true,  true, true)
  AttachEntityToEntity(prop, Player, GetPedBoneIndex(Player, bone), off1, off2, off3, rot1, rot2, rot3, true, true, false, true, 1, true)
  table.insert(PlayerProps, prop)
  PlayerHasProp = true
  SetModelAsNoLongerNeeded(prop1)
end

-----------------------------------------------------------------------------------------------------
-- V -- This could be a whole lot better, i tried messing around with "IsPedMale(ped)"
-- V -- But i never really figured it out, if anyone has a better way of gender checking let me know.
-- V -- Since this way doesnt work for ped models.
-- V -- in most cases its better to replace the scenario with an animation bundled with prop instead.
-----------------------------------------------------------------------------------------------------

function CheckGender()
  local hashSkinMale = GetHashKey("mp_m_freemode_01")
  local hashSkinFemale = GetHashKey("mp_f_freemode_01")

  if GetEntityModel(PlayerPedId()) == hashSkinMale then
    PlayerGender = "male"
  elseif GetEntityModel(PlayerPedId()) == hashSkinFemale then
    PlayerGender = "female"
  end
  DebugPrint("Set gender as = ("..PlayerGender..")")
end

-----------------------------------------------------------------------------------------------------
------ This is the major function for playing emotes! -----------------------------------------------
-----------------------------------------------------------------------------------------------------

function OnEmotePlay(EmoteName)

  if not IsPedRagdoll(PlayerPedId()) then
    DisableControlAction(0, 303, true)

    InVehicle = IsPedInAnyVehicle(PlayerPedId(), true)
    if not Config.AllowedInCars and InVehicle == 1 then
      return
    end

    if not DoesEntityExist(PlayerPedId()) then
      return false
    end

    if EmoteName.AnimationOptions == nil or EmoteName.AnimationOptions.RemoveWeapon == nil or EmoteName.AnimationOptions.RemoveWeapon then
      if Config.DisarmPlayer then
        if IsPedArmed(PlayerPedId(), 7) then
          SetCurrentPedWeapon(PlayerPedId(), GetHashKey('WEAPON_UNARMED'), true)
        end
      end
    end

    ChosenDict,ChosenAnimation,ename = table.unpack(EmoteName)
    AnimationDuration = -1

    if PlayerHasProp then
      DestroyAllProps()
    end

    if ChosenDict == "Expression" then
      SetFacialIdleAnimOverride(PlayerPedId(), ChosenAnimation, 0)
      return
    end

    if ChosenDict == "MaleScenario" or "Scenario" then 
      CheckGender()
      if ChosenDict == "MaleScenario" then if InVehicle then return end
        if PlayerGender == "male" then
          ClearPedTasks(PlayerPedId())
          TaskStartScenarioInPlace(PlayerPedId(), ChosenAnimation, 0, true)
          DebugPrint("Playing scenario = ("..ChosenAnimation..")")
          IsInAnimation = true
        else
          EmoteChatMessage('male')
        end return
      elseif ChosenDict == "ScenarioObject" then if InVehicle then return end
        BehindPlayer = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 0 - 0.5, -0.5);
        ClearPedTasks(PlayerPedId())
        TaskStartScenarioAtPosition(PlayerPedId(), ChosenAnimation, BehindPlayer['x'], BehindPlayer['y'], BehindPlayer['z'], GetEntityHeading(PlayerPedId()), 0, 1, false)
        DebugPrint("Playing scenario = ("..ChosenAnimation..")")
        IsInAnimation = true
        return
      elseif ChosenDict == "Scenario" then if InVehicle then return end
        ClearPedTasks(PlayerPedId())
        TaskStartScenarioInPlace(PlayerPedId(), ChosenAnimation, 0, true)
        DebugPrint("Playing scenario = ("..ChosenAnimation..")")
        IsInAnimation = true
      return end 
    end

    LoadAnim(ChosenDict)

    if EmoteName.AnimationOptions then
      if EmoteName.AnimationOptions.EmoteLoop then
        MovementType = 1
      if EmoteName.AnimationOptions.EmoteMoving then
        MovementType = 51
    end

    elseif EmoteName.AnimationOptions.EmoteMoving then
      MovementType = 51
    elseif EmoteName.AnimationOptions.EmoteMoving == false then
      MovementType = 0
    elseif EmoteName.AnimationOptions.EmoteStuck then
      MovementType = 50
    end

    else
      MovementType = 0
    end

    if InVehicle == 1 then
      MovementType = 51
    end

    if EmoteName.AnimationOptions then
      if EmoteName.AnimationOptions.EmoteDuration == nil then 
        EmoteName.AnimationOptions.EmoteDuration = -1
        AttachWait = 0
      else
        AnimationDuration = EmoteName.AnimationOptions.EmoteDuration
        AttachWait = EmoteName.AnimationOptions.EmoteDuration
      end

      if EmoteName.AnimationOptions.PtfxAsset then
        PtfxAsset = EmoteName.AnimationOptions.PtfxAsset
        PtfxName = EmoteName.AnimationOptions.PtfxName
        if EmoteName.AnimationOptions.PtfxNoProp then
          PtfxNoProp = EmoteName.AnimationOptions.PtfxNoProp
        else
          PtfxNoProp = false
        end
        Ptfx1, Ptfx2, Ptfx3, Ptfx4, Ptfx5, Ptfx6, PtfxScale = table.unpack(EmoteName.AnimationOptions.PtfxPlacement)
        PtfxInfo = EmoteName.AnimationOptions.PtfxInfo
        PtfxWait = EmoteName.AnimationOptions.PtfxWait
        PtfxNotif = false
        PtfxPrompt = true
        PtfxThis(PtfxAsset)
      else
        DebugPrint("Ptfx = none")
        PtfxPrompt = false
      end
    end

    TaskPlayAnim(PlayerPedId(), ChosenDict, ChosenAnimation, 2.0, 2.0, AnimationDuration, MovementType, 0, false, false, false)
    RemoveAnimDict(ChosenDict)
    IsInAnimation = true
    DisableKeybindings = true
    MostRecentDict = ChosenDict
    MostRecentAnimation = ChosenAnimation

    if EmoteName.AnimationOptions then
      if EmoteName.AnimationOptions.Prop then
          PropName = EmoteName.AnimationOptions.Prop
          PropBone = EmoteName.AnimationOptions.PropBone
          PropPl1, PropPl2, PropPl3, PropPl4, PropPl5, PropPl6 = table.unpack(EmoteName.AnimationOptions.PropPlacement)
          if EmoteName.AnimationOptions.SecondProp then
            SecondPropName = EmoteName.AnimationOptions.SecondProp
            SecondPropBone = EmoteName.AnimationOptions.SecondPropBone
            SecondPropPl1, SecondPropPl2, SecondPropPl3, SecondPropPl4, SecondPropPl5, SecondPropPl6 = table.unpack(EmoteName.AnimationOptions.SecondPropPlacement)
            SecondPropEmote = true
          else
            SecondPropEmote = false
          end
          Wait(AttachWait)
          AddPropToPlayer(PropName, PropBone, PropPl1, PropPl2, PropPl3, PropPl4, PropPl5, PropPl6) 
          if SecondPropEmote then
            AddPropToPlayer(SecondPropName, SecondPropBone, SecondPropPl1, SecondPropPl2, SecondPropPl3, SecondPropPl4, SecondPropPl5, SecondPropPl6)
          end
      end
    end
    return true
  end
end

Citizen.CreateThread(function()
  while true do
    Wait(7)
    if DisableKeybindings then
      local playerPed = PlayerPedId()
      DisableControlAction(0, Keys["U"], true) -- U
      if IsDisabledControlJustPressed(0, Keys["U"]) then
        ESX.ShowNotification("Je zit nog in een animatie, druk op ~b~X~s~ om uit de animatie te gaan!")
      end
    end
  end
end) -- Werkt niet goed icm andere scripts die emotes triggeren via Execute Command.

-- Key Controls
Citizen.CreateThread(function()
  while true do
  Citizen.Wait(7)
	  if IsControlJustReleased(0, 73) and GetLastInputMethod(2) then
      ClearPedTasks(PlayerPedId())
      Wait(1250)
      DisableKeybindings = false
	  end
  end
end)