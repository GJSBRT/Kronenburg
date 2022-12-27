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

ESX             				 = nil

local cardOpen 					= false
local playerData 				= {}
local windowavg					= false
local windowavd					= false
local windowarg					= false
local windoward					= false
local window 					= false
local engineOn 					= true
local speedkm 					= 0

local hasCasinoVIP = true

-- Servern callback
RegisterNetEvent('jsfour-legitimation:open')
AddEventHandler('jsfour-legitimation:open', function(playerData)
	cardOpen = true
	SendNUIMessage({
		action = "open",
		array = playerData
	})
end)

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)

RegisterNetEvent("idcard::updateToClientNewStatus", function()
  ESX.TriggerServerCallback("idcard:isCasinoVIP", function(letmeknow) 
    if letmeknow == true then hasCasinoVIP = true else hasCasinoVIP = false end
  end, {})
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
  PlayerData = xPlayer   

  -- ESX.TriggerServerCallback("idcard:isCasinoVIP", function(letmeknow) 
  --   if letmeknow == true then hasCasinoVIP = true else hasCasinoVIP = false end
  -- end, {})
end)

-- Giving ID Animation
function OpenGivingID()
  local pP = GetPlayerPed(-1)

  Citizen.CreateThread(function()
      TriggerServerEvent('esx_personmeny:give_id')
    end)
end

-- No one Near Animation
function OpenNoOneNear()
  local pP = GetPlayerPed(-1)

  Citizen.CreateThread(function()
      TriggerServerEvent('esx_personmeny:idnoonenear')
    end)
end

function OpenTrashCan()
  local pP = GetPlayerPed(-1)

  Citizen.CreateThread(function()

    local pP = GetPlayerPed(-1)
    TaskPlayAnim(pP, "mp_common", "givetake2_a", 3.5, -8, -1, 2, 0, 0, 0, 0, 0)
    TaskStartScenarioInPlace(pP, "mp_common", 0, true)
    Citizen.CreateThread(function()
      Citizen.Wait(2000)
      ClearPedTasksImmediately(pP)
      end)
    end)
end

function OpenAttansCan()
  local pP = GetPlayerPed(-1)

  Citizen.CreateThread(function()

    local pP = GetPlayerPed(-1)
    TaskPlayAnim(pP, "gestures@m@standing@casual", "gesture_damn", 3.5, -8, -1, 2, 0, 0, 0, 0, 0)
    TaskStartScenarioInPlace(pP, "gestures@m@standing@casual", 0, true)
    FreezeEntityPosition(playerPed, true)
    Citizen.CreateThread(function()
      Citizen.Wait(2000)
      FreezeEntityPosition(playerPed, false)
      ClearPedTasksImmediately(pP)
      end)
    end)
end

----------------------------------

function OpenShowCasinoVIP()
  local playerPed = PlayerPedId()
ESX.UI.Menu.Open(
	'default', GetCurrentResourceName(), 'id_card_menu',
	{
		title    = _U('id_menu'),
    align    = 'top-left',
		elements = {
			{label = _U('check_id'), value = 'check'},
			{label = _U('show_id'), value = 'show'}
		}
	},
	function(data2, menu2)
		if data2.current.value == 'check' then


      TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(PlayerId()), 'casinoVIP')

		elseif data2.current.value == 'show' then
      local playersNearby = ESX.Game.GetPlayersInArea(GetEntityCoords(playerPed), 3.0)

      if #playersNearby > 0 then
        local players = {}
        elements = {}

        for k,playerNearby in ipairs(playersNearby) do
          players[GetPlayerServerId(playerNearby)] = true
        end

        ESX.TriggerServerCallback('esx:getPlayerNames', function(returnedPlayers)
          for playerId,playerName in pairs(returnedPlayers) do
            table.insert(elements, {
              label = playerId,
              playerId = playerId
            })
          end

          ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'give_item_to', {
            title    = ('give_to'),
            align    = 'top-left',
            elements = elements
          }, function(data2, menu2)
            local selectedPlayer, selectedPlayerId = GetPlayerFromServerId(data2.current.playerId), data2.current.playerId
            playersNearby = ESX.Game.GetPlayersInArea(GetEntityCoords(playerPed), 3.0)
            playersNearby = ESX.Table.Set(playersNearby)

            if playersNearby[selectedPlayer] then
              local selectedPlayerPed = GetPlayerPed(selectedPlayer)

              if IsPedOnFoot(selectedPlayerPed) and not IsPedFalling(selectedPlayerPed) then
                TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), selectedPlayerId, 'casinoVIP')
              else
                ESX.ShowNotification(('in_vehicle'))
              end
              menu2.close()
            else
              ESX.ShowNotification(('players_nearby'))
              menu2.close()
            end
          end, function(data2, menu2)
            menu2.close()
          end)
        end, players)
      else
        ESX.ShowNotification(('players_nearby'))
      end
		end
	end,
	function(data2, menu2)
		menu2.close()
		OpenShowCasinoVIP()
	end
)

end

----------------------------------------------------------------
function OpenShowGiveID()
  local playerPed = PlayerPedId()
ESX.UI.Menu.Open(
	'default', GetCurrentResourceName(), 'id_card_menu',
	{
		title    = _U('id_menu'),
    align    = 'top-left',
		elements = {
			{label = _U('check_id'), value = 'check'},
			{label = _U('show_id'), value = 'show'}
		}
	},
	function(data2, menu2)
		if data2.current.value == 'check' then


      TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(PlayerId()))

		elseif data2.current.value == 'show' then
      local playersNearby = ESX.Game.GetPlayersInArea(GetEntityCoords(playerPed), 3.0)

      if #playersNearby > 0 then
        local players = {}
        elements = {}

        for k,playerNearby in ipairs(playersNearby) do
          players[GetPlayerServerId(playerNearby)] = true
        end

        ESX.TriggerServerCallback('esx:getPlayerNames', function(returnedPlayers)
          for playerId,playerName in pairs(returnedPlayers) do
            table.insert(elements, {
              label = playerId,
              playerId = playerId
            })
          end

          ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'give_item_to', {
            title    = ('give_to'),
            align    = 'top-left',
            elements = elements
          }, function(data2, menu2)
            local selectedPlayer, selectedPlayerId = GetPlayerFromServerId(data2.current.playerId), data2.current.playerId
            playersNearby = ESX.Game.GetPlayersInArea(GetEntityCoords(playerPed), 3.0)
            playersNearby = ESX.Table.Set(playersNearby)

            if playersNearby[selectedPlayer] then
              local selectedPlayerPed = GetPlayerPed(selectedPlayer)

              if IsPedOnFoot(selectedPlayerPed) and not IsPedFalling(selectedPlayerPed) then
                TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), selectedPlayerId)
              else
                ESX.ShowNotification(('in_vehicle'))
              end
            else
              ESX.ShowNotification(('players_nearby'))
              menu2.close()
            end
          end, function(data2, menu2)
            menu2.close()
          end)
        end, players)
      else
        ESX.ShowNotification(('players_nearby'))
      end
		end
	end,
	function(data2, menu2)
		menu2.close()
		OpenCivilianActionsMenu()
	end
)

end
----------------------------------------------
function OpenShowGiveDL()
  local playerPed = PlayerPedId()
ESX.UI.Menu.Open(
	'default', GetCurrentResourceName(), 'id_card_menu',
	{
		title    = _U('dl_menu'),
    align    = 'top-left',
		elements = {
			{label = _U('check_id2'), value = 'check'},
			{label = _U('show_id2'), value = 'show'}
		}
	},
	function(data2, menu2)
		if data2.current.value == 'check' then

--[[
      local inventory = ESX.GetPlayerData().inventory
      local LockpickAmount = nil
      for i=1, #inventory, 1 do                          
          if inventory[i].name == 'drive_card' then
              LockpickAmount = inventory[i].count
          end
      end
      if LockpickAmount > 0 then
				TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(PlayerId()), 'driver')
      else
        ESX.ShowNotification(('Je hebt geen Rijbewijs'))
      end]]
      TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(PlayerId()), 'drive')
		elseif data2.current.value == 'show' then
      local playersNearby = ESX.Game.GetPlayersInArea(GetEntityCoords(playerPed), 3.0)

      if #playersNearby > 0 then
        local players = {}
        elements = {}

        for k,playerNearby in ipairs(playersNearby) do
          players[GetPlayerServerId(playerNearby)] = true
        end

        ESX.TriggerServerCallback('esx:getPlayerNames', function(returnedPlayers)
          for playerId,playerName in pairs(returnedPlayers) do
            table.insert(elements, {
              label = playerId,
              playerId = playerId
            })
          end

          ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'give_item_to', {
            title    = ('give_to'),
            align    = 'top-left',
            elements = elements
          }, function(data2, menu2)
            local selectedPlayer, selectedPlayerId = GetPlayerFromServerId(data2.current.playerId), data2.current.playerId
            playersNearby = ESX.Game.GetPlayersInArea(GetEntityCoords(playerPed), 3.0)
            playersNearby = ESX.Table.Set(playersNearby)

            if playersNearby[selectedPlayer] then
              local selectedPlayerPed = GetPlayerPed(selectedPlayer)

              if IsPedOnFoot(selectedPlayerPed) and not IsPedFalling(selectedPlayerPed) then
                TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), selectedPlayerId, 'driver')
              else
                ESX.ShowNotification(('in_vehicle'))
              end
            else
              ESX.ShowNotification(('players_nearby'))
              menu2.close()
            end
          end, function(data2, menu2)
            menu2.close()
          end)
        end, players)
      else
        ESX.ShowNotification(('players_nearby'))
      end
		end
	end,
	function(data2, menu2)
		menu2.close()
		OpenCivilianActionsMenu()
	end
)

end
----------------------------------------------
function OpenShowGiveGL()
  local playerPed = PlayerPedId()
ESX.UI.Menu.Open(
	'default', GetCurrentResourceName(), 'id_card_menu',
	{
		title    = _U('gl_menu'),
    align    = 'top-left',
		elements = {
			{label = _U('check_id3'), value = 'check'},
			{label = _U('show_id3'), value = 'show'}
		}
	},
	function(data2, menu2)
		if data2.current.value == 'check' then
				TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(PlayerId()), 'weapon')
		elseif data2.current.value == 'show' then
      local playersNearby = ESX.Game.GetPlayersInArea(GetEntityCoords(playerPed), 3.0)

      if #playersNearby > 0 then
        local players = {}
        elements = {}

        for k,playerNearby in ipairs(playersNearby) do
          players[GetPlayerServerId(playerNearby)] = true
        end

        ESX.TriggerServerCallback('esx:getPlayerNames', function(returnedPlayers)
          for playerId,playerName in pairs(returnedPlayers) do
            table.insert(elements, {
              label = playerId,
              playerId = playerId
            })
          end

          ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'give_item_to', {
            title    = ('give_to'),
            align    = 'top-left',
            elements = elements
          }, function(data2, menu2)
            local selectedPlayer, selectedPlayerId = GetPlayerFromServerId(data2.current.playerId), data2.current.playerId
            playersNearby = ESX.Game.GetPlayersInArea(GetEntityCoords(playerPed), 3.0)
            playersNearby = ESX.Table.Set(playersNearby)

            if playersNearby[selectedPlayer] then
              local selectedPlayerPed = GetPlayerPed(selectedPlayer)

              if IsPedOnFoot(selectedPlayerPed) and not IsPedFalling(selectedPlayerPed) then
                TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), selectedPlayerId, 'weapon')
              else
                ESX.ShowNotification(('in_vehicle'))
              end
            else
              ESX.ShowNotification(('players_nearby'))
              menu2.close()
            end
          end, function(data2, menu2)
            menu2.close()
          end)
        end, players)
      else
        ESX.ShowNotification(('players_nearby'))
      end
		end
	end,
	function(data2, menu2)
		menu2.close()
		OpenCivilianActionsMenu()
	end
)

end




function OpenShowGivePolCard()
  local playerPed = PlayerPedId()
  ESX.UI.Menu.Open(
    'default', GetCurrentResourceName(), 'id_card_menu',
    {
      title    = _U('gl_menu'),
      align    = 'top-left',
      elements = {
        {label = _U('check_id3'), value = 'check'},
        {label = _U('show_id3'), value = 'show'}
      }
    },
    function(data2, menu2)
      if data2.current.value == 'check' then
          TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(PlayerId()), 'weapon')
      elseif data2.current.value == 'show' then


        local playersNearby = ESX.Game.GetPlayersInArea(GetEntityCoords(playerPed), 3.0)

				if #playersNearby > 0 then
					local players = {}
					elements = {}

					for k,playerNearby in ipairs(playersNearby) do
						players[GetPlayerServerId(playerNearby)] = true
					end

					ESX.TriggerServerCallback('esx:getPlayerNames', function(returnedPlayers)
						for playerId,playerName in pairs(returnedPlayers) do
							table.insert(elements, {
								label = playerId,
								playerId = playerId
							})
						end

						ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'give_item_to', {
							title    = ('give_to'),
							align    = 'top-left',
							elements = elements
						}, function(data2, menu2)
							local selectedPlayer, selectedPlayerId = GetPlayerFromServerId(data2.current.playerId), data2.current.playerId
							playersNearby = ESX.Game.GetPlayersInArea(GetEntityCoords(playerPed), 3.0)
							playersNearby = ESX.Table.Set(playersNearby)

							if playersNearby[selectedPlayer] then
								local selectedPlayerPed = GetPlayerPed(selectedPlayer)

								if IsPedOnFoot(selectedPlayerPed) and not IsPedFalling(selectedPlayerPed) then
									TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), selectedPlayerId, 'police')
								else
									ESX.ShowNotification(('in_vehicle'))
								end
							else
								ESX.ShowNotification(('players_nearby'))
								menu2.close()
							end
						end, function(data2, menu2)
							menu2.close()
						end)
					end, players)
				else
					ESX.ShowNotification(('players_nearby'))
				end
  
 --         TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(player), 'police')
  --				OpenTrashCan()
      end
    end,
    function(data2, menu2)
      menu2.close()
      OpenCivilianActionsMenu()
    end
  )
  
  end




----------------------------------------------

function OpenCivilianActionsMenu()

  ESX.UI.Menu.CloseAll()

  local elems = {
    {label = _U('id_card'), value = 'id_kort'},
    {label = _U('id_card2'), value = 'id_kort2'},
    {label = _U('id_card3'), value = 'id_kort3'},	
  }

  if hasCasinoVIP then
    table.insert(elems, {label = 'Casino VIP Pas', value = 'id_casinoVIP'})
  end

  ESX.UI.Menu.Open(
  'default', GetCurrentResourceName(), 'civilian_actions',
  {
    title    = _U('citizen_interactions'),
    align    = 'top-left',
    elements = elems
  },
    
    function(data, menu)

      if data.current.value == 'id_kort' then
      	OpenShowGiveID()
      end 
      if data.current.value == 'id_casinoVIP' then
      	OpenShowCasinoVIP()
      end
	  
	  if data.current.value == 'id_kort2' then
      	OpenShowGiveDL()
      end
	  
	  if data.current.value == 'id_kort3' then
 --     	OpenShowGiveGL()
          OpenShowGivePolCard()
      end



    end,
    function(data, menu)
      menu.close()
    end
  )
end


Citizen.CreateThread(function()
	while true do
		Wait(0)
		if IsControlPressed(0, 322) or IsControlPressed(0, 177) and cardOpen then
			SendNUIMessage({
				action = "close"
			})
			cardOpen = false
		end
	end
end)

Citizen.CreateThread(function()
  while true do
    Wait(0)
    if IsControlPressed(0, Keys["F10"]) then
      OpenCivilianActionsMenu()
    end
  end
end)



