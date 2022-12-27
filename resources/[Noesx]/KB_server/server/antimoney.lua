--[[ 
	Kronenburg Roleplay
	Copyright © GJSBRT <g@gijs.eu>

	This project is licensed under the terms of the Apache License 2.0 license.
	https://choosealicense.com/licenses/apache-2.0/
]]
 
 
local webhook = "https://discord.com/api/webhooks/945719217523671080/w_I-NliNL4xM-x7G-V5C9W5aK3YJSxSAIBiIYwapY5eAVTJjlADMVBNlDZy8tUNhpivH"

exports('CheckMoneyCheater', function(PID, accountname, amount, triggername)
    local xPlayer = ESX.GetPlayerFromId(PID)
    local usermoney = tonumber(xPlayer.getAccount(accountname).money)
    local checkmoney = tonumber(amount)
    
    
    if checkmoney > usermoney+1000 then
        local Desc = ''
        Desc = "Speler: **"..GetPlayerName(PID).."**\nID: **".. PID .."**\nTrigger: **"..triggername.."**\nProbeerde **"..amount.."** in te spawnen\n\nIdentifiers:\n"
        local Identifiers = GetPlayerIdentifiers(PID)
        if Identifiers ~= nil then
          for i, k in ipairs(Identifiers) do
            if string.find(k, 'ip:') then goto continue end
            if string.find(k, 'discord:') then k = "discord: <@"..string.gsub(k, "discord:", "")..">" end
            Desc = Desc .. "**"..k.."**".. '\n'
            ::continue::
          end 
        end
        exports['KB_Logger']:DiscordLog(webhook, "Geld inspawnen door diep in de min te gan", Desc, true)
        TriggerClientEvent('chat:addMessage', -1, {
            template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(168, 50, 50, 1); border-radius: 3px;"><img src="https://c.tenor.com/4ecK9Ai65ZkAAAAd/ban-banned.gif" width="50" height="50" style="vertical-align:middle;margin:0px 0px"> ^*[AntiCheat]^r » Speler ^*{0}^r met het ID ^*{1}^r is permanent gebanned</div>',
            args = { GetPlayerName(PID), PID}
            })
            print(PID)
        exports['KB_txApi']:txAdmin_banPlayer(PID, "Helaas, not your lucky day!. Cheats zijn voor noobs, Onterechte ban? > https://dsc.gg/kbsupport")
        return false    
    else
        return true
    end
end)