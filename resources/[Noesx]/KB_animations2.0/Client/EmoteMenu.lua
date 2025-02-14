﻿--[[ 
	Kronenburg Roleplay
	Copyright © GJSBRT <g@gijs.eu>

	This project is licensed under the terms of the Apache License 2.0 license.
	https://choosealicense.com/licenses/apache-2.0/
]]
 
 
TriggerServerEvent("dp:CheckVersion")

rightPosition = {x = 1450, y = 100}
leftPosition = {x = 0, y = 100}
menuPosition = {x = 0, y = 200}

if Config.MenuPosition then
  if Config.MenuPosition == "left" then
    menuPosition = leftPosition
  elseif Config.MenuPosition == "right" then
    menuPosition = rightPosition
  end
end

if Config.CustomMenuEnabled then
  local RuntimeTXD = CreateRuntimeTxd('Custom_Menu_Head')
  local Object = CreateDui(Config.MenuImage, 512, 128)
  _G.Object = Object
  local TextureThing = GetDuiHandle(Object)
  local Texture = CreateRuntimeTextureFromDuiHandle(RuntimeTXD, 'Custom_Menu_Head', TextureThing)
  Menuthing = "Custom_Menu_Head"
else
  Menuthing = "shopui_title_sm_hangar"
end

_menuPool = NativeUI.CreatePool()
mainMenu = NativeUI.CreateMenu("KB Animaties", "", menuPosition["x"], menuPosition["y"], Menuthing, Menuthing)
_menuPool:Add(mainMenu)

function ShowNotification(text)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(text)
    DrawNotification(false, false)
end

local EmoteTable = {}
local FavEmoteTable = {}
local KeyEmoteTable = {}
local DanceTable = {}
local PropETable = {}
local SitTable = {}
local WaveTable = {}
local WorkTable = {}
local FoodTable = {}
local LeanTable = {}
local WaitTable = {}
local WalkTable = {}
local FaceTable = {}
local ShareTable = {}
local FavoriteEmote = ""

-- Citizen.CreateThread(function()
--   while true do
--     if Config.FavKeybindEnabled then
--       if IsControlPressed(0, Config.FavKeybind) and GetLastInputMethod(2) then
--         if not IsPedSittingInAnyVehicle(PlayerPedId()) then
--           if FavoriteEmote ~= "" then
--             EmoteCommandStart(nil,{FavoriteEmote, 0})
--             Wait(3000)
--           end
--         end
--       end
--     end
--     Citizen.Wait(7)
--   end
-- end)

lang = Config.MenuLanguage

function AddEmoteMenu(menu)
    local submenu = _menuPool:AddSubMenu(menu, Config.Languages[lang]['emotes'], "", "", Menuthing, Menuthing)
    local dancemenu = _menuPool:AddSubMenu(submenu, Config.Languages[lang]['danceemotes'], "", "", Menuthing, Menuthing)
    local propmenu = _menuPool:AddSubMenu(submenu, Config.Languages[lang]['propemotes'], "", "", Menuthing, Menuthing)
    local sitmenu = _menuPool:AddSubMenu(submenu, Config.Languages[lang]['sitemotes'], "", "", Menuthing, Menuthing)
    local leanmenu = _menuPool:AddSubMenu(submenu, Config.Languages[lang]['leanemotes'], "", "", Menuthing, Menuthing)
    local waitmenu = _menuPool:AddSubMenu(submenu, Config.Languages[lang]['waitemotes'], "", "", Menuthing, Menuthing)
    local wavemenu = _menuPool:AddSubMenu(submenu, Config.Languages[lang]['waveemotes'], "", "", Menuthing, Menuthing)
    local workmenu = _menuPool:AddSubMenu(submenu, Config.Languages[lang]['workemotes'], "", "", Menuthing, Menuthing)
    local foodmenu = _menuPool:AddSubMenu(submenu, Config.Languages[lang]['foodemotes'], "", "", Menuthing, Menuthing)
    table.insert(EmoteTable, Config.Languages[lang]['danceemotes'])
    table.insert(EmoteTable, Config.Languages[lang]['danceemotes'])
    table.insert(EmoteTable, Config.Languages[lang]['danceemotes'])
    table.insert(EmoteTable, Config.Languages[lang]['danceemotes'])
    table.insert(EmoteTable, Config.Languages[lang]['danceemotes'])
    table.insert(EmoteTable, Config.Languages[lang]['danceemotes'])
    table.insert(EmoteTable, Config.Languages[lang]['danceemotes'])
    table.insert(EmoteTable, Config.Languages[lang]['danceemotes'])

    if Config.SharedEmotesEnabled then
      sharemenu = _menuPool:AddSubMenu(submenu, Config.Languages[lang]['shareemotes'], Config.Languages[lang]['shareemotesinfo'], "", Menuthing, Menuthing)
      shareddancemenu = _menuPool:AddSubMenu(sharemenu, Config.Languages[lang]['sharedanceemotes'], "", "", Menuthing, Menuthing)
      table.insert(ShareTable, 'none')
      table.insert(EmoteTable, Config.Languages[lang]['shareemotes'])
    end

    -- if not Config.SqlKeybinding then
    --   unbind2item = NativeUI.CreateItem(Config.Languages[lang]['rfavorite'], Config.Languages[lang]['rfavorite'])
    --   unbinditem = NativeUI.CreateItem(Config.Languages[lang]['prop2info'], "")
    --   favmenu = _menuPool:AddSubMenu(submenu, Config.Languages[lang]['favoriteemotes'], Config.Languages[lang]['favoriteinfo'], "", Menuthing, Menuthing)
    --   favmenu:AddItem(unbinditem)
    --   favmenu:AddItem(unbind2item)
    --   table.insert(FavEmoteTable, Config.Languages[lang]['rfavorite'])
    --   table.insert(FavEmoteTable, Config.Languages[lang]['rfavorite'])
    --   table.insert(EmoteTable, Config.Languages[lang]['favoriteemotes'])
    -- else
    --   table.insert(EmoteTable, "keybinds")
    --   keyinfo =  NativeUI.CreateItem(Config.Languages[lang]['keybinds'], Config.Languages[lang]['keybindsinfo'].." /emotebind [~y~num4-9~w~] [~g~emotename~w~]")
    --   submenu:AddItem(keyinfo)
    -- end

    for a,b in pairsByKeys(DP.Emotes) do
      x,y,z = table.unpack(b)
      emoteitem = NativeUI.CreateItem(z, "/e ("..a..")")
      submenu:AddItem(emoteitem)
      table.insert(EmoteTable, a)
      -- if not Config.SqlKeybinding then
      --   favemoteitem = NativeUI.CreateItem(z, Config.Languages[lang]['set']..z..Config.Languages[lang]['setboundemote'])
      --   favmenu:AddItem(favemoteitem)
      --   table.insert(FavEmoteTable, a)
      -- end
    end

    for a,b in pairsByKeys(DP.Dances) do
      x,y,z = table.unpack(b)
      danceitem = NativeUI.CreateItem(z, "/e ("..a..")")
      sharedanceitem = NativeUI.CreateItem(z, "")
      dancemenu:AddItem(danceitem)
      if Config.SharedEmotesEnabled then
        shareddancemenu:AddItem(sharedanceitem)
      end
      table.insert(DanceTable, a)
    end

    if Config.SharedEmotesEnabled then
      for a,b in pairsByKeys(DP.Shared) do
        x,y,z,otheremotename = table.unpack(b)
        if otheremotename == nil then
          shareitem = NativeUI.CreateItem(z, "/nearby (~g~"..a.."~w~)")
        else 
          shareitem = NativeUI.CreateItem(z, "/nearby (~g~"..a.."~w~) "..Config.Languages[lang]['makenearby'].." (~y~"..otheremotename.."~w~)")
        end
        sharemenu:AddItem(shareitem)
        table.insert(ShareTable, a)
      end
    end

    for a,b in pairsByKeys(DP.PropEmotes) do
      x,y,z = table.unpack(b)
      propitem = NativeUI.CreateItem(z, "/e ("..a..")")
      propmenu:AddItem(propitem)
      table.insert(PropETable, a)

    end

    -- Hierzo zorg je ervoor dat je de animaties daadwerkelijk kan zien
    for a,b in pairsByKeys(DP.SitEmotes) do
      x,y,z = table.unpack(b)
      sititem = NativeUI.CreateItem(z, "/e ("..a..")")
      sitmenu:AddItem(sititem)
      table.insert(SitTable, a)

    end

    for a,b in pairsByKeys(DP.WaveEmotes) do
      x,y,z = table.unpack(b)
      waveitem = NativeUI.CreateItem(z, "/e ("..a..")")
      wavemenu:AddItem(waveitem)
      table.insert(WaveTable, a)

    end

    for a,b in pairsByKeys(DP.WorkEmotes) do
      x,y,z = table.unpack(b)
      workitem = NativeUI.CreateItem(z, "/e ("..a..")")
      workmenu:AddItem(workitem)
      table.insert(WorkTable, a)

    end

    for a,b in pairsByKeys(DP.FoodEmotes) do
      x,y,z = table.unpack(b)
      fooditem = NativeUI.CreateItem(z, "/e ("..a..")")
      foodmenu:AddItem(fooditem)
      table.insert(FoodTable, a)

    end

    for a,b in pairsByKeys(DP.LeanEmotes) do
      x,y,z = table.unpack(b)
      leanitem = NativeUI.CreateItem(z, "/e ("..a..")")
      leanmenu:AddItem(leanitem)
      table.insert(LeanTable, a)

    end

    for a,b in pairsByKeys(DP.WaitEmotes) do
      x,y,z = table.unpack(b)
      waititem = NativeUI.CreateItem(z, "/e ("..a..")")
      waitmenu:AddItem(waititem)
      table.insert(WaitTable, a)

    end
---------------------------------------------------------------------------------------------------------------------------------------------------
    dancemenu.OnItemSelect = function(sender, item, index)
      EmoteMenuStart(DanceTable[index], "dances")
    end

    if Config.SharedEmotesEnabled then
      sharemenu.OnItemSelect = function(sender, item, index)
        if ShareTable[index] ~= 'none' then
          target, distance = GetClosestPlayer()
          if(distance ~= -1 and distance < 3) then
            _,_,rename = table.unpack(DP.Shared[ShareTable[index]])
            TriggerServerEvent("ServerEmoteRequest", GetPlayerServerId(target), ShareTable[index])
            SimpleNotify(Config.Languages[lang]['sentrequestto']..GetPlayerName(target))
          else
            SimpleNotify(Config.Languages[lang]['nobodyclose'])
          end
        end
      end

      shareddancemenu.OnItemSelect = function(sender, item, index)
        target, distance = GetClosestPlayer()
        if(distance ~= -1 and distance < 3) then
          _,_,rename = table.unpack(DP.Dances[DanceTable[index]])
          TriggerServerEvent("ServerEmoteRequest", GetPlayerServerId(target), DanceTable[index], 'Dances')
          SimpleNotify(Config.Languages[lang]['sentrequestto']..GetPlayerName(target)) 
        else
          SimpleNotify(Config.Languages[lang]['nobodyclose'])
        end
      end
    end

    propmenu.OnItemSelect = function(sender, item, index)
      EmoteMenuStart(PropETable[index], "props")
    end


    -- Dit zorgt ervoor dat je ook daadwerkelijk de animation kan uitvoeren
    sitmenu.OnItemSelect = function(sender, item, index)
      EmoteMenuStart(SitTable[index], "sit")
    end

    wavemenu.OnItemSelect = function(sender, item, index)
      EmoteMenuStart(WaveTable[index], "wave")
    end

    workmenu.OnItemSelect = function(sender, item, index)
      EmoteMenuStart(WorkTable[index], "work")
    end

    foodmenu.OnItemSelect = function(sender, item, index)
      EmoteMenuStart(FoodTable[index], "food")
    end

    leanmenu.OnItemSelect = function(sender, item, index)
      EmoteMenuStart(LeanTable[index], "lean")
    end

    waitmenu.OnItemSelect = function(sender, item, index)
      EmoteMenuStart(WaitTable[index], "wait")
    end


















    submenu.OnItemSelect = function(sender, item, index)
      if EmoteTable[index] ~= Config.Languages[lang]['favoriteemotes'] then
       EmoteMenuStart(EmoteTable[index], "emotes")
     end
  end
end

function AddCancelEmote(menu)
    local newitem = NativeUI.CreateItem(Config.Languages[lang]['cancelemote'], Config.Languages[lang]['cancelemoteinfo'])
    menu:AddItem(newitem)
    menu.OnItemSelect = function(sender, item, checked_)
        if item == newitem then
          EmoteCancel()
          DestroyAllProps()
        end
    end
end

function AddWalkMenu(menu)
    local submenu = _menuPool:AddSubMenu(menu, Config.Languages[lang]['walkingstyles'], "", "", Menuthing, Menuthing)

    walkreset = NativeUI.CreateItem(Config.Languages[lang]['normalreset'], Config.Languages[lang]['resetdef'])
    submenu:AddItem(walkreset)
    table.insert(WalkTable, Config.Languages[lang]['resetdef'])

    WalkInjured = NativeUI.CreateItem("Injured", "")
    submenu:AddItem(WalkInjured)
    table.insert(WalkTable, "move_m@injured")

    for a,b in pairsByKeys(DP.Walks) do
      x = table.unpack(b)
      walkitem = NativeUI.CreateItem(a, "")
      submenu:AddItem(walkitem)
      table.insert(WalkTable, x)
    end

    submenu.OnItemSelect = function(sender, item, index)
      if item ~= walkreset then
        WalkMenuStart(WalkTable[index])
      else
        ResetPedMovementClipset(PlayerPedId())
      end
    end
end

function AddFaceMenu(menu)
    local submenu = _menuPool:AddSubMenu(menu, Config.Languages[lang]['moods'], "", "", Menuthing, Menuthing)

    facereset = NativeUI.CreateItem(Config.Languages[lang]['normalreset'], Config.Languages[lang]['resetdef'])
    submenu:AddItem(facereset)
    table.insert(FaceTable, "")

    for a,b in pairsByKeys(DP.Expressions) do
      x,y,z = table.unpack(b)
      faceitem = NativeUI.CreateItem(a, "")
      submenu:AddItem(faceitem)
      table.insert(FaceTable, a)
    end

    submenu.OnItemSelect = function(sender, item, index)
      if item ~= facereset then
        EmoteMenuStart(FaceTable[index], "expression")
      else
        ClearFacialIdleAnimOverride(PlayerPedId())
      end
    end
end

function AddInfoMenu(menu)
    if not UpdateAvailable then
      infomenu = _menuPool:AddSubMenu(menu, Config.Languages[lang]['infoupdate'], "(1.7.3)", "", Menuthing, Menuthing)
    else
      infomenu = _menuPool:AddSubMenu(menu, Config.Languages[lang]['infoupdateav'], Config.Languages[lang]['infoupdateavtext'], "", Menuthing, Menuthing)
    end
    contact = NativeUI.CreateItem(Config.Languages[lang]['suggestions'], Config.Languages[lang]['suggestionsinfo'])
    u170 = NativeUI.CreateItem("1.7.0", "Added /emotebind [key] [emote]!")
    u165 = NativeUI.CreateItem("1.6.5", "Updated camera/phone/pee/beg, added makeitrain/dance(glowstick/horse).")
    u160 = NativeUI.CreateItem("1.6.0", "Added shared emotes /nearby, or in menu, also fixed some emotes!")
    u151 = NativeUI.CreateItem("1.5.1", "Added /walk and /walks, for walking styles without menu")
    u150 = NativeUI.CreateItem("1.5.0", "Added Facial Expressions menu (if enabled by server owner)")
    infomenu:AddItem(contact)
    infomenu:AddItem(u170)
    infomenu:AddItem(u165)
    infomenu:AddItem(u160)
    infomenu:AddItem(u151)
    infomenu:AddItem(u150)
end

function OpenEmoteMenu()
    mainMenu:Visible(not mainMenu:Visible())
end

function firstToUpper(str)
    return (str:gsub("^%l", string.upper))
end

AddEmoteMenu(mainMenu)
if Config.WalkingStylesEnabled then
  AddWalkMenu(mainMenu)
end
if Config.ExpressionsEnabled then
  AddFaceMenu(mainMenu)
end
AddCancelEmote(mainMenu)

_menuPool:RefreshIndex()

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(7)
        _menuPool:ProcessMenus()
    end
end)

RegisterNetEvent("dp:RecieveMenu") -- For opening the emote menu from another resource.
AddEventHandler("dp:RecieveMenu", function()
    OpenEmoteMenu() 
end)