ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
DiscordWebhook = "https://discord.com/api/webhooks/971711502069411871/tsNT4fTRbZMipqpmN0Bluy7I7nGcay8zershkbzCTtqTzcDZ2jASsjF_XOZbPJsIwisc"
Geschiedenis = {}

ESX.RegisterServerCallback('insidetrack:server:getVerifyToken', function(source, cb)
	local src = source
	local token, resourcename = exports['DRGNV_tokenizer']:generateToken(GetCurrentResourceName(), src)
	while token == nil do
		Wait(500)
	end
	cb(token, resourcename)
end)

RegisterServerEvent("insidetrack:server:winnings")
AddEventHandler("insidetrack:server:winnings", function(amount, token)
    local src = source
    if not exports['DRGNV_tokenizer']:verifyToken(GetCurrentResourceName(), src, token, "insidetrack:server:winnings") then
		return
    end
    local xPlayer = ESX.GetPlayerFromId(src)

    if xPlayer ~= nil then
        
        Geschiedenis[src].winst = Geschiedenis[src].winst + amount
        xPlayer.addInventoryItem("casino_chips", amount)
        logMessage('Gewonnen', xPlayer.getName() .. ' [ID: '.. xPlayer.source..'] heeft '.. amount .. ' casino chips gewonnen bij InsideTrack.\n\nTotaal ingezet: **'..Geschiedenis[src].inzet..'**\nTotaal gewonnen/verloren: **'.. (Geschiedenis[src].winst - Geschiedenis[src].inzet) .. '**' , 3124876, src)
        --print("Added item")
    end
end)

RegisterServerEvent("insidetrack:server:placebet")
AddEventHandler("insidetrack:server:placebet", function(bet, token)
    local src = source
    if not exports['DRGNV_tokenizer']:verifyToken(GetCurrentResourceName(), src, token, "insidetrack:server:placebet") then
		return
    end
    local xPlayer = ESX.GetPlayerFromId(src)
     if Geschiedenis[src] == nil then 
        Geschiedenis[src] = {}
        Geschiedenis[src].inzet = 0
        Geschiedenis[src].winst = 0
    end
    if Player ~= nil then
        Geschiedenis[src].inzet = Geschiedenis[src].inzet + bet
        
        xPlayer.removeInventoryItem("casino_chips", bet)
        logMessage('Inzet', xPlayer.getName() .. ' [ID: '.. xPlayer.source..'] heeft '.. bet .. ' casino chips ingezet bij InsideTrack.\n\nTotaal ingezet: **'..Geschiedenis[src].inzet..'**\nTotaal gewonnen/verloren: **'.. (Geschiedenis[src].winst - Geschiedenis[src].inzet) .. '**' , 14921392, src)
        --print("removed items")
    end
end)

ESX.RegisterServerCallback("insidetrack:server:getbalance", function(source, cb)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    
    if xPlayer ~= nil then
        chips = xPlayer.getInventoryItem('casino_chips').count
		--print(chips)
        if chips ~= nil then
            cb(chips)
        else
            cb(0)
        end
    else
        cb(0)
    end
end)

function logMessage(title, message, color, src)
	color = color or '16711680'
	message = message or ''
	_source = src or false
	message = message .. '\n\nIdentifiers:\n'
	if _source then
	  local Identifiers = GetPlayerIdentifiers(_source)
	  if Identifiers ~= nil then
		for i, k in ipairs(Identifiers) do
		  if string.find(k, 'ip:') then goto continue end
	  if string.find(k, 'discord:') then k = "discord: <@"..k:gsub("discord:", "")..">" end
		  message = message .. k .. '\n'
		  ::continue::
		end 
	  end
	end
	PerformHttpRequest(DiscordWebhook, function(err, text, headers) end, 'POST', json.encode({embeds={{title = title, description = message, footer = { text = " Kronenburgertje RP "}, color=color}}}),  { ['Content-Type'] = 'application/json' })

end