--[[ 
	Kronenburg Roleplay
	Copyright © GJSBRT <g@gijs.eu>

	This project is licensed under the terms of the Apache License 2.0 license.
	https://choosealicense.com/licenses/apache-2.0/
]]
 
 
---@diagnostic disable: undefined-global
local mode = "kick"

-- kick message (if 'mode' is set to 'kick')
local kickmessage = "Kicked \nReason: Ongepaste woorden in chat typen"

local chatlog = "https://discord.com/api/webhooks/939331022938574949/Wbzm5nybsDuIv9UmsOQq8Yokg1LIbQXJTopUAXptCtbAHRmpL9AZSZbk3FkMz8Pm8wlu"
local blacklistlog = "https://discord.com/api/webhooks/939331580982337536/VZoNaKdwHhEauX6o-pf5Ue80Jb4SEtshF1nIBDdljytilKwjD3CS5o180nvsFn0F6Slu"
local overheidslog = "https://discord.com/api/webhooks/939331693968523275/EQm4NSxidMZriNPrmzQVlf32ztcjG4e8H2k8sanq-Dc6NsDukkmrKY4xT9RtI8Jr_2YD"
local lastMessage = 0




-- blacklisted words (in lowercase)
local blacklist = {
    "kanker",
    "kkr",
    "kankel",
    "opgekankert",
    "opgekaneld",
    "kkjalla",
    "kankerhoer",
    "kkhoer",
    "kkrhoer",
    "nigger",
    "kkrnigger",
    "kankernigger",
    "kkslet",
    "kkrslet",
    "kankerslet",
    "nigga",
    "niggas",
    "kkrnigga",
    "kkrniggas",
    "kknigga",
    "kkniggas",
    "niggers",
    "kutnegers",
    "vibegames",
    "vibegame",
    "mcnode",
    "mc-node",
    "royalehosting",
    "royalhosting",
    "kutniggers",
    "kutnigger",
    "zuiderveen",
    "maarseveen",
    "groningen",
    "groningenrp"
}
-- END OF CONFIGURATION

-- RegisterCommand('ooc', function(source, args, rawCommand)
-- 	local playerName = GetPlayerName(source)
--     local msg = rawCommand:sub(5)
--     local naampie = GetRealPlayerName(source)
--     local ids = ExtractIdentifiers(source)
--     local discord =  "<@" ..ids.discord:gsub("discord:", "")..">"
-- 	if(IsPlayerAceAllowed(source, "kronenburg:chatbypass"))  -- Checks for bypass permission
-- 		then
-- 			CancelEvent() -- Stops event
-- 		else

--         local finalmessage = msg:lower()
--         finalmessage = finalmessage:gsub(" ", "")
--         finalmessage = finalmessage:gsub("%-", "")
--         finalmessage = finalmessage:gsub("%.", "")
--         finalmessage = finalmessage:gsub("$", "s")
--         finalmessage = finalmessage:gsub("€", "e")
--         finalmessage = finalmessage:gsub(",", "")
--         finalmessage = finalmessage:gsub(";", "")
--         finalmessage = finalmessage:gsub(":", "")
--         finalmessage = finalmessage:gsub("*", "")
--         finalmessage = finalmessage:gsub("_", "")
--         finalmessage = finalmessage:gsub("|", "")
--         finalmessage = finalmessage:gsub("/", "")
--         finalmessage = finalmessage:gsub("<", "")
--         finalmessage = finalmessage:gsub(">", "")
--         finalmessage = finalmessage:gsub("ß", "ss")
--         finalmessage = finalmessage:gsub("&", "")
--         finalmessage = finalmessage:gsub("+", "")
--         finalmessage = finalmessage:gsub("¦", "")
--         finalmessage = finalmessage:gsub("§", "s")
--         finalmessage = finalmessage:gsub("°", "")
--         finalmessage = finalmessage:gsub("#", "")
--         finalmessage = finalmessage:gsub("@", "a")
--         finalmessage = finalmessage:gsub("\"", "")
--         finalmessage = finalmessage:gsub("%(", "")
--         finalmessage = finalmessage:gsub("%)", "")
--         finalmessage = finalmessage:gsub("=", "")
--         finalmessage = finalmessage:gsub("?", "")
--         finalmessage = finalmessage:gsub("!", "")
--         finalmessage = finalmessage:gsub("´", "")
--         finalmessage = finalmessage:gsub("`", "")
--         finalmessage = finalmessage:gsub("'", "")
--         finalmessage = finalmessage:gsub("%^", "")
--         finalmessage = finalmessage:gsub("~", "")
--         finalmessage = finalmessage:gsub("%[", "")
--         finalmessage = finalmessage:gsub("]", "")
--         finalmessage = finalmessage:gsub("{", "")
--         finalmessage = finalmessage:gsub("}", "")
--         finalmessage = finalmessage:gsub("£", "e")
--         finalmessage = finalmessage:gsub("¨", "")
--         finalmessage = finalmessage:gsub("ç", "c")
--         finalmessage = finalmessage:gsub("¬", "")
--         finalmessage = finalmessage:gsub("\\", "")
--         finalmessage = finalmessage:gsub("1", "i")
--         finalmessage = finalmessage:gsub("3", "e")
--         finalmessage = finalmessage:gsub("4", "a")
--         finalmessage = finalmessage:gsub("5", "s")
--         finalmessage = finalmessage:gsub("0", "o")        local lastchar = ""
--         local output = ""
--         for char in finalmessage:gmatch(".") do
--             if(char ~= lastchar) then
--                 output = output .. char
--             end
--             lastchar = char
--         end		local send = true
-- 		for i in pairs(blacklist) do -- Checks blacklist
-- 			if(output:find(blacklist[i])) then
-- 				-- Bad word detected
-- 				if(mode == "delete") then
-- 					-- Deletes message
-- 				elseif(mode == "kick") then
-- 					PerformHttpRequest(blacklistlog, function(err, text, headers) end, 'POST', json.encode({embeds={{title = "Blacklisted word kick", description = " "..playerName.."** probeerde **"..msg.."** te zeggen in ooc en is daarvoor gekickt\nIngame naam: **"..naampie.."**\nSpeler ID: **"..source.."**\nSteamHex: **"..GetPlayerIdentifier(source).."**\nDiscord: **"..discord.."", footer = { text = " © Kronenburg 📅 "..os.date("%d/%m/%Y - %X")}, color=0}}}),  { ['Content-Type'] = 'application/json' })
-- 					DropPlayer(source, kickmessage) -- Kicks player
-- 				end
-- 				send = false -- sets send to false so message doesnt get sent
-- 				break
-- 			end
-- 		end
-- 		if(send) then -- if true then message gets sent
--             if GetGameTimer() - lastMessage < 2000 then
--                 TriggerClientEvent('chat:addMessage', source, {
--                     template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(255, 0, 0, 0.6); border-radius: 3px;"><b>^*Chat^r:</b> Je verstuurd teveel berichten, probeer het over enkele seconden opnieuw!</div>',
--                 })
--                 return
--             end
--           lastMessage = GetGameTimer()
--             PerformHttpRequest(chatlog, function(err, text, headers) end, 'POST', json.encode({embeds={{title = "OOC", description = " "..naampie..": "..msg.."**\nSteamnaam: **"..GetPlayerName(source).."**\nSpeler ID: **"..source.."**\nSteamHex: **"..GetPlayerIdentifier(source).."**\nDiscord: **"..discord.."", footer = { text = " © Kronenburg 📅 "..os.date("%d/%m/%Y - %X")},  color=8359053}}}),  { ['Content-Type'] = 'application/json' })
--             TriggerClientEvent('chat:addMessage', -1, {
--                 template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(41, 41, 41, 0.6); border-radius: 3px;"><i class="fas fa-comment-dots"></i> {0}: {1}</div>',
--                 args = { playerName, msg }
--             })
-- 	    	end
--         end
-- end)

RegisterCommand('twt', function(source, args, rawCommand)
    local playerName = GetPlayerName(source)
    local msg = rawCommand:sub(5)
    local naampie = GetRealPlayerName(source)
    local ids = ExtractIdentifiers(source)
    local discord = "<@" .. ids.discord:gsub("discord:", "") .. ">"
    if (IsPlayerAceAllowed(source, "kronenburg:chatbypass")) -- Checks for bypass permission
    then
        CancelEvent() -- Stops event 
    else

        local finalmessage = msg:lower()
        finalmessage = finalmessage:gsub(" ", "")
        finalmessage = finalmessage:gsub("%-", "")
        finalmessage = finalmessage:gsub("%.", "")
        finalmessage = finalmessage:gsub("$", "s")
        finalmessage = finalmessage:gsub("€", "e")
        finalmessage = finalmessage:gsub(",", "")
        finalmessage = finalmessage:gsub(";", "")
        finalmessage = finalmessage:gsub(":", "")
        finalmessage = finalmessage:gsub("*", "")
        finalmessage = finalmessage:gsub("_", "")
        finalmessage = finalmessage:gsub("|", "")
        finalmessage = finalmessage:gsub("/", "")
        finalmessage = finalmessage:gsub("<", "")
        finalmessage = finalmessage:gsub(">", "")
        finalmessage = finalmessage:gsub("ß", "ss")
        finalmessage = finalmessage:gsub("&", "")
        finalmessage = finalmessage:gsub("+", "")
        finalmessage = finalmessage:gsub("¦", "")
        finalmessage = finalmessage:gsub("§", "s")
        finalmessage = finalmessage:gsub("°", "")
        finalmessage = finalmessage:gsub("#", "")
        finalmessage = finalmessage:gsub("@", "a")
        finalmessage = finalmessage:gsub("\"", "")
        finalmessage = finalmessage:gsub("%(", "")
        finalmessage = finalmessage:gsub("%)", "")
        finalmessage = finalmessage:gsub("=", "")
        finalmessage = finalmessage:gsub("?", "")
        finalmessage = finalmessage:gsub("!", "")
        finalmessage = finalmessage:gsub("´", "")
        finalmessage = finalmessage:gsub("`", "")
        finalmessage = finalmessage:gsub("'", "")
        finalmessage = finalmessage:gsub("%^", "")
        finalmessage = finalmessage:gsub("~", "")
        finalmessage = finalmessage:gsub("%[", "")
        finalmessage = finalmessage:gsub("]", "")
        finalmessage = finalmessage:gsub("{", "")
        finalmessage = finalmessage:gsub("}", "")
        finalmessage = finalmessage:gsub("£", "e")
        finalmessage = finalmessage:gsub("¨", "")
        finalmessage = finalmessage:gsub("ç", "c")
        finalmessage = finalmessage:gsub("¬", "")
        finalmessage = finalmessage:gsub("\\", "")
        finalmessage = finalmessage:gsub("1", "i")
        finalmessage = finalmessage:gsub("3", "e")
        finalmessage = finalmessage:gsub("4", "a")
        finalmessage = finalmessage:gsub("5", "s")
        finalmessage = finalmessage:gsub("0", "o")
        local lastchar = ""
        local output = ""
        for char in finalmessage:gmatch(".") do
            if (char ~= lastchar) then
                output = output .. char
            end
            lastchar = char
        end
        local send = true
        for i in pairs(blacklist) do -- Checks blacklist
            if (output:find(blacklist[i])) then
                -- Bad word detected
                if (mode == "delete") then
                    -- Deletes message
                elseif (mode == "kick") then
                    PerformHttpRequest(blacklistlog, function(err, text, headers) end, 'POST', json.encode({ embeds = { { title = "Blacklisted word kick", description = " " .. playerName .. "** probeerde **" .. msg .. "** te zeggen in ooc en is daarvoor gekickt\nIngame naam: **" .. naampie .. "**\nSpeler ID: **" .. source .. "**\nSteamHex: **" .. GetPlayerIdentifier(source) .. "**\nDiscord: **" .. discord .. "", footer = { text = " © Kronenburg 📅 " .. os.date("%d/%m/%Y - %X") }, color = 0 } } }), { ['Content-Type'] = 'application/json' })
                    DropPlayer(source, kickmessage) -- Kicks player
                end
                send = false -- sets send to false so message doesnt get sent
                break
            end
        end
        if (send) then -- if true then message gets sent
            if GetGameTimer() - lastMessage < 2000 then
                TriggerClientEvent('chat:addMessage', source, {
                    template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(255, 0, 0, 0.6); border-radius: 3px;"><b>^*Chat^r:</b> Je verstuurd teveel berichten, probeer het over enkele seconden opnieuw!</div>',
                })
                return
            end
            lastMessage = GetGameTimer()
            PerformHttpRequest(chatlog, function(err, text, headers) end, 'POST', json.encode({ embeds = { { title = "Twitter", description = " " .. naampie .. ": " .. msg .. "**\nSteamnaam: **" .. GetPlayerName(source) .. "**\nSpeler ID: **" .. source .. "**\nSteamHex: **" .. GetPlayerIdentifier(source) .. "**\nDiscord: **" .. discord .. "", footer = { text = " © KronenburgRP 📅 " .. os.date("%d/%m/%Y - %X") }, color = 1876210 } } }), { ['Content-Type'] = 'application/json' })
            TriggerClientEvent('chat:addMessage', -1, {
                template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(28, 160, 242, 0.6); border-radius: 3px;"><i class="fab fa-twitter"></i> @{0}: {1}</div>',
                args = { naampie, msg }
            })
        end
    end
end)


RegisterCommand('nieuws', function(source, args, rawCommand)
    local playerName = GetPlayerName(source)
    local msg = rawCommand:sub(5)
    local naampie = GetRealPlayerName(source)
    local ids = ExtractIdentifiers(source)
    local discord = "<@" .. ids.discord:gsub("discord:", "") .. ">"
    if (IsPlayerAceAllowed(source, "kronenburg:chatbypass")) -- Checks for bypass permission
    then
        CancelEvent() -- Stops event 
    else

        local finalmessage = msg:lower()
        finalmessage = finalmessage:gsub(" ", "")
        finalmessage = finalmessage:gsub("%-", "")
        finalmessage = finalmessage:gsub("%.", "")
        finalmessage = finalmessage:gsub("$", "s")
        finalmessage = finalmessage:gsub("€", "e")
        finalmessage = finalmessage:gsub(",", "")
        finalmessage = finalmessage:gsub(";", "")
        finalmessage = finalmessage:gsub(":", "")
        finalmessage = finalmessage:gsub("*", "")
        finalmessage = finalmessage:gsub("_", "")
        finalmessage = finalmessage:gsub("|", "")
        finalmessage = finalmessage:gsub("/", "")
        finalmessage = finalmessage:gsub("<", "")
        finalmessage = finalmessage:gsub(">", "")
        finalmessage = finalmessage:gsub("ß", "ss")
        finalmessage = finalmessage:gsub("&", "")
        finalmessage = finalmessage:gsub("+", "")
        finalmessage = finalmessage:gsub("¦", "")
        finalmessage = finalmessage:gsub("§", "s")
        finalmessage = finalmessage:gsub("°", "")
        finalmessage = finalmessage:gsub("#", "")
        finalmessage = finalmessage:gsub("@", "a")
        finalmessage = finalmessage:gsub("\"", "")
        finalmessage = finalmessage:gsub("%(", "")
        finalmessage = finalmessage:gsub("%)", "")
        finalmessage = finalmessage:gsub("=", "")
        finalmessage = finalmessage:gsub("?", "")
        finalmessage = finalmessage:gsub("!", "")
        finalmessage = finalmessage:gsub("´", "")
        finalmessage = finalmessage:gsub("`", "")
        finalmessage = finalmessage:gsub("'", "")
        finalmessage = finalmessage:gsub("%^", "")
        finalmessage = finalmessage:gsub("~", "")
        finalmessage = finalmessage:gsub("%[", "")
        finalmessage = finalmessage:gsub("]", "")
        finalmessage = finalmessage:gsub("{", "")
        finalmessage = finalmessage:gsub("}", "")
        finalmessage = finalmessage:gsub("£", "e")
        finalmessage = finalmessage:gsub("¨", "")
        finalmessage = finalmessage:gsub("ç", "c")
        finalmessage = finalmessage:gsub("¬", "")
        finalmessage = finalmessage:gsub("\\", "")
        finalmessage = finalmessage:gsub("1", "i")
        finalmessage = finalmessage:gsub("3", "e")
        finalmessage = finalmessage:gsub("4", "a")
        finalmessage = finalmessage:gsub("5", "s")
        finalmessage = finalmessage:gsub("0", "o")

        local lastchar = ""
        local output = ""
        for char in finalmessage:gmatch(".") do
            if (char ~= lastchar) then
                output = output .. char
            end
            lastchar = char
        end

        local send = true
        for i in pairs(blacklist) do -- Checks blacklist
            if (output:find(blacklist[i])) then
                -- Bad word detected
                if (mode == "delete") then
                    -- Deletes message
                elseif (mode == "kick") then
                    PerformHttpRequest(blacklistlog, function(err, text, headers) end, 'POST', json.encode({ embeds = { { title = "Blacklisted word kick", description = " " .. playerName .. "** probeerde **" .. msg .. "** te zeggen in ooc en is daarvoor gekickt\nIngame naam: **" .. naampie .. "**\nSpeler ID: **" .. source .. "**\nSteamHex: **" .. GetPlayerIdentifier(source) .. "**\nDiscord: **" .. discord .. "", footer = { text = " © KronenburgRP 📅 " .. os.date("%d/%m/%Y - %X") }, color = 0 } } }), { ['Content-Type'] = 'application/json' })
                    DropPlayer(source, kickmessage) -- Kicks player
                end
                send = false -- sets send to false so message doesnt get sent
                break
            end
        end
        if (send) then -- if true then message gets sent
            if GetGameTimer() - lastMessage < 2000 then
                TriggerClientEvent('chat:addMessage', source, {
                    template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(255, 0, 0, 0.6); border-radius: 3px;"><b>^*Chat^r:</b> Je verstuurd teveel berichten, probeer het over enkele seconden opnieuw!</div>',
                })
                return
            end
            lastMessage = GetGameTimer()
            PerformHttpRequest(chatlog, function(err, text, headers) end, 'POST', json.encode({ embeds = { { title = "Nieuws", description = " " .. naampie .. ": " .. msg .. "**\nSteamnaam: **" .. GetPlayerName(source) .. "**\nSpeler ID: **" .. source .. "**\nSteamHex: **" .. GetPlayerIdentifier(source) .. "**\nDiscord: **" .. discord .. "", footer = { text = " © KronenburgRP 📅 " .. os.date("%d/%m/%Y - %X") }, color = 15158332 } } }), { ['Content-Type'] = 'application/json' })
            TriggerClientEvent('chat:addMessage', -1, {
                template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(219, 23, 23, 0.6); border-radius: 3px;"><i class="fas fa-newspaper"></i> {0}: {1}</div>',
                args = { naampie, msg }
            })
        end
    end
end)


----------------------------------------------------------------------------
----------------------------------------------------------------------------
----------------------------------------------------------------------------

RegisterCommand('staff', function(source, args, rawCommand)
    local playerName = GetPlayerName(source)
    local msg = rawCommand:sub(6)
    local naampie = GetRealPlayerName(source)
    if (naampie == "GSBRT") then
        naampie = "blub"
    end
    local ids = ExtractIdentifiers(source)
    local discord = "<@" .. ids.discord:gsub("discord:", "") .. ">"
    if (IsPlayerAceAllowed(source, "kronenburg:chatbypass")) -- Checks for bypass permission
    then
        CancelEvent() -- Stops event 
    else

        local finalmessage = msg:lower()
        finalmessage = finalmessage:gsub(" ", "")
        finalmessage = finalmessage:gsub("%-", "")
        finalmessage = finalmessage:gsub("%.", "")
        finalmessage = finalmessage:gsub("$", "s")
        finalmessage = finalmessage:gsub("€", "e")
        finalmessage = finalmessage:gsub(",", "")
        finalmessage = finalmessage:gsub(";", "")
        finalmessage = finalmessage:gsub(":", "")
        finalmessage = finalmessage:gsub("*", "")
        finalmessage = finalmessage:gsub("_", "")
        finalmessage = finalmessage:gsub("|", "")
        finalmessage = finalmessage:gsub("/", "")
        finalmessage = finalmessage:gsub("<", "")
        finalmessage = finalmessage:gsub(">", "")
        finalmessage = finalmessage:gsub("ß", "ss")
        finalmessage = finalmessage:gsub("&", "")
        finalmessage = finalmessage:gsub("+", "")
        finalmessage = finalmessage:gsub("¦", "")
        finalmessage = finalmessage:gsub("§", "s")
        finalmessage = finalmessage:gsub("°", "")
        finalmessage = finalmessage:gsub("#", "")
        finalmessage = finalmessage:gsub("@", "a")
        finalmessage = finalmessage:gsub("\"", "")
        finalmessage = finalmessage:gsub("%(", "")
        finalmessage = finalmessage:gsub("%)", "")
        finalmessage = finalmessage:gsub("=", "")
        finalmessage = finalmessage:gsub("?", "")
        finalmessage = finalmessage:gsub("!", "")
        finalmessage = finalmessage:gsub("´", "")
        finalmessage = finalmessage:gsub("`", "")
        finalmessage = finalmessage:gsub("'", "")
        finalmessage = finalmessage:gsub("%^", "")
        finalmessage = finalmessage:gsub("~", "")
        finalmessage = finalmessage:gsub("%[", "")
        finalmessage = finalmessage:gsub("]", "")
        finalmessage = finalmessage:gsub("{", "")
        finalmessage = finalmessage:gsub("}", "")
        finalmessage = finalmessage:gsub("£", "e")
        finalmessage = finalmessage:gsub("¨", "")
        finalmessage = finalmessage:gsub("ç", "c")
        finalmessage = finalmessage:gsub("¬", "")
        finalmessage = finalmessage:gsub("\\", "")
        finalmessage = finalmessage:gsub("1", "i")
        finalmessage = finalmessage:gsub("3", "e")
        finalmessage = finalmessage:gsub("4", "a")
        finalmessage = finalmessage:gsub("5", "s")
        finalmessage = finalmessage:gsub("0", "o")

        local lastchar = ""
        local output = ""
        for char in finalmessage:gmatch(".") do
            if (char ~= lastchar) then
                output = output .. char
            end
            lastchar = char
        end

        local send = true
        for i in pairs(blacklist) do -- Checks blacklist
            if (output:find(blacklist[i])) then
                -- Bad word detected
                if (mode == "delete") then
                    -- Deletes message
                elseif (mode == "kick") then
                    PerformHttpRequest(blacklistlog, function(err, text, headers) end, 'POST', json.encode({ embeds = { { title = "Blacklisted word kick", description = " " .. playerName .. "** probeerde **" .. msg .. "** te zeggen in ooc en is daarvoor gekickt\nIngame naam: **" .. naampie .. "**\nSpeler ID: **" .. source .. "**\nSteamHex: **" .. GetPlayerIdentifier(source) .. "**\nDiscord: **" .. discord .. "", footer = { text = " © KronenburgRP 📅 " .. os.date("%d/%m/%Y - %X") }, color = 0 } } }), { ['Content-Type'] = 'application/json' })
                    DropPlayer(source, kickmessage) -- Kicks player
                end
                send = false -- sets send to false so message doesnt get sent
                break
            end
        end
        if (send) then -- if true then message gets sent
            if (IsPlayerAceAllowed(source, "command"))
            then
                PerformHttpRequest(chatlog, function(err, text, headers) end, 'POST', json.encode({ embeds = { { title = "Staff", description = " " .. GetPlayerName(source) .. ": " .. msg .. "**\nID: **" .. source .. "**\nSteamHex: **" .. GetPlayerIdentifier(source) .. "**\nDiscord: **" .. discord .. "", footer = { text = " © KronenburgRP 📅 " .. os.date("%d/%m/%Y - %X") }, color = 7419530 } } }), { ['Content-Type'] = 'application/json' })
                TriggerClientEvent('chat:addMessage', -1, {
                    template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(255, 175, 0, 0.6); border-radius: 3px;"><i class="fas fa-user-shield"></i> ^*Staff^r {0}: {1}</div>',
                    args = { playerName, msg }
                })
            else
            end
        end
    end
end)

----------------------------------------------------------------------------
----------------------------------------------------------------------------
----------------------------------------------------------------------------
RegisterServerEvent('brandweerbericht')
AddEventHandler('brandweerbericht', function(args)
    local xPlayer = ESX.GetPlayerFromId(source)
    local ids = ExtractIdentifiers(source)
    local discord = "<@" .. ids.discord:gsub("discord:", "") .. ">"
    if args == nil then
        return
    end
    if GetGameTimer() - lastMessage < 3500 then
        TriggerClientEvent('chat:addMessage', source, {
            template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(255, 0, 0, 0.6); border-radius: 3px;"><b>^*Chat^r:</b> Je verstuurd teveel berichten, probeer het over enkele seconden opnieuw!</div>',
        })
        return
    end
    lastMessage = GetGameTimer()
    TriggerClientEvent('chat:addMessage', -1, {
        template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(0, 0, 0, 0.7);color:#FFF; border-radius: 3px;"><i class="fab fa-twitter"></i> <img src="https://cdn.dutchis.net/kbrp/hud/img/jobs/brandweer.png" height="15" style="display:inline;margin-right:8px">Brandweer: ' .. table.concat(args, " ") .. '</div>',
    })
    PerformHttpRequest(overheidslog, function(err, text, headers) end, 'POST', json.encode({ embeds = { { title = "Brandweer tweet", description = " **" .. GetPlayerName(source) .. "**: " .. table.concat(args, " ") .. "**\nSpeler ID: **" .. source .. "**\nSteamHex: **" .. GetPlayerIdentifier(source) .. "**\nRang: **" .. xPlayer.job.grade_label .. "**\nDiscord: **" .. discord .. "", footer = { text = " © KronenburgRP 📅 " .. os.date("%d/%m/%Y - %X") }, color = 1129100 } } }), { ['Content-Type'] = 'application/json' })
end)

RegisterServerEvent('politiebericht')
AddEventHandler('politiebericht', function(args)
    local xPlayer = ESX.GetPlayerFromId(source)
    local ids = ExtractIdentifiers(source)
    local discord = "<@" .. ids.discord:gsub("discord:", "") .. ">"
    if args == nil then
        return
    end
    if GetGameTimer() - lastMessage < 3500 then
        TriggerClientEvent('chat:addMessage', source, {
            template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(255, 0, 0, 0.6); border-radius: 3px;"><b>^*Chat^r:</b> Je verstuurd teveel berichten, probeer het over enkele seconden opnieuw!</div>',
        })
        return
    end
    lastMessage = GetGameTimer()
    TriggerClientEvent('chat:addMessage', -1, {
        template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(17, 58, 140, 0.7); border-radius: 3px;"><i class="fab fa-twitter"></i> Politie: ' .. table.concat(args, " ") .. '</div>',
    })
    PerformHttpRequest(overheidslog, function(err, text, headers) end, 'POST', json.encode({ embeds = { { title = "Politie tweet", description = " **" .. GetPlayerName(source) .. "**: " .. table.concat(args, " ") .. "**\nSpeler ID: **" .. source .. "**\nSteamHex: **" .. GetPlayerIdentifier(source) .. "**\nRang: **" .. xPlayer.job.grade_label .. "**\nDiscord: **" .. discord .. "", footer = { text = " © KronenburgRP 📅 " .. os.date("%d/%m/%Y - %X") }, color = 1129100 } } }), { ['Content-Type'] = 'application/json' })
end)

RegisterServerEvent('kmarbericht')
AddEventHandler('kmarbericht', function(args)
    local xPlayer = ESX.GetPlayerFromId(source)
    local ids = ExtractIdentifiers(source)
    local discord = "<@" .. ids.discord:gsub("discord:", "") .. ">"
    if args == nil then
        return
    end
    if GetGameTimer() - lastMessage < 3500 then
        TriggerClientEvent('chat:addMessage', source, {
            template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(255, 0, 0, 0.6); border-radius: 3px;"><b>^*Chat^r:</b> Je verstuurd teveel berichten, probeer het over enkele seconden opnieuw!</div>',
        })
        return
    end
    lastMessage = GetGameTimer()
    TriggerClientEvent('chat:addMessage', -1, {
        template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(17, 58, 140, 0.7); border-radius: 3px;"><i class="fab fa-twitter"></i> KMAR: ' .. table.concat(args, " ") .. '</div>',
    })
    PerformHttpRequest(overheidslog, function(err, text, headers) end, 'POST', json.encode({ embeds = { { title = "KMAR tweet", description = " **" .. GetPlayerName(source) .. "**: " .. table.concat(args, " ") .. "**\nSpeler ID: **" .. source .. "**\nSteamHex: **" .. GetPlayerIdentifier(source) .. "**\nRang: **" .. xPlayer.job.grade_label .. "**\nDiscord: **" .. discord .. "", footer = { text = " © KronenburgRP 📅 " .. os.date("%d/%m/%Y - %X") }, color = 2123412 } } }), { ['Content-Type'] = 'application/json' })
end)

RegisterServerEvent('anwbbericht')
AddEventHandler('anwbbericht', function(args)
    local xPlayer = ESX.GetPlayerFromId(source)
    local ids = ExtractIdentifiers(source)
    local discord = "<@" .. ids.discord:gsub("discord:", "") .. ">"
    if args == nil then
        return
    end
    if GetGameTimer() - lastMessage < 3500 then
        TriggerClientEvent('chat:addMessage', source, {
            template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(255, 0, 0, 0.6); border-radius: 3px;"><b>^*Chat^r:</b> Je verstuurd teveel berichten, probeer het over enkele seconden opnieuw!</div>',
        })
        return
    end
    lastMessage = GetGameTimer()
    TriggerClientEvent('chat:addMessage', -1, {
        template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(135, 90, 7, 0.7); border-radius: 3px;"><i class="fab fa-twitter"></i> ANWB: ' .. table.concat(args, " ") .. '</div>',
    })
    PerformHttpRequest(overheidslog, function(err, text, headers) end, 'POST', json.encode({ embeds = { { title = "ANWB tweet", description = " **" .. GetPlayerName(source) .. "**: " .. table.concat(args, " ") .. "**\nSpeler ID: **" .. source .. "**\nSteamHex: **" .. GetPlayerIdentifier(source) .. "**\nRang: **" .. xPlayer.job.grade_label .. "**\nDiscord: **" .. discord .. "", footer = { text = " © KronenburgRP 📅 " .. os.date("%d/%m/%Y - %X") }, color = 8870407 } } }), { ['Content-Type'] = 'application/json' })
end)

RegisterServerEvent('ambubericht')
AddEventHandler('ambubericht', function(args)
    local xPlayer = ESX.GetPlayerFromId(source)
    local ids = ExtractIdentifiers(source)
    local discord = "<@" .. ids.discord:gsub("discord:", "") .. ">"
    if args == nil then
        return
    end
    if GetGameTimer() - lastMessage < 3500 then
        TriggerClientEvent('chat:addMessage', source, {
            template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(255, 0, 0, 0.6); border-radius: 8px;"><b>^*Chat^r:</b> Je verstuurd teveel berichten, probeer het over enkele seconden opnieuw!</div>',
        })
        return
    end
    lastMessage = GetGameTimer()
    TriggerClientEvent('chat:addMessage', -1, {
        template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(229, 190, 1, 0.7); border-radius: 3px;"><i class="fab fa-twitter"></i> Ambulance: ' .. table.concat(args, " ") .. '</div>',
    })
    PerformHttpRequest(overheidslog, function(err, text, headers) end, 'POST', json.encode({ embeds = { { title = "Ambulance tweet", description = " **" .. GetPlayerName(source) .. "**: " .. table.concat(args, " ") .. "**\nSpeler ID: **" .. source .. "**\nSteamHex: **" .. GetPlayerIdentifier(source) .. "**\nRang: **" .. xPlayer.job.grade_label .. "**\nDiscord: **" .. discord .. "", footer = { text = " © KronenburgRP 📅 " .. os.date("%d/%m/%Y - %X") }, color = 15158332 } } }), { ['Content-Type'] = 'application/json' })
end)

RegisterServerEvent('taxibericht')
AddEventHandler('taxibericht', function(args)
    local xPlayer = ESX.GetPlayerFromId(source)
    local ids = ExtractIdentifiers(source)
    local discord = "<@" .. ids.discord:gsub("discord:", "") .. ">"
    if args == nil then
        return
    end
    if GetGameTimer() - lastMessage < 3500 then
        TriggerClientEvent('chat:addMessage', source, {
            template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(255, 0, 0, 0.6); border-radius: 8px;"><b>^*Chat^r:</b> Je verstuurd teveel berichten, probeer het over enkele seconden opnieuw!</div>',
        })
        return
    end
    lastMessage = GetGameTimer()
    TriggerClientEvent('chat:addMessage', -1, {
        template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(179, 143, 0, 0.7); border-radius: 3px;"><i class="fab fa-twitter"></i> Taxi: ' .. table.concat(args, " ") .. '</div>',
    })
    PerformHttpRequest(overheidslog, function(err, text, headers) end, 'POST', json.encode({ embeds = { { title = "Taxi tweet", description = " **" .. GetPlayerName(source) .. "**: " .. table.concat(args, " ") .. "**\nSpeler ID: **" .. source .. "**\nSteamHex: **" .. GetPlayerIdentifier(source) .. "**\nRang: **" .. xPlayer.job.grade_label .. "**\nDiscord: **" .. discord .. "", footer = { text = " © KronenburgRP 📅 " .. os.date("%d/%m/%Y - %X") }, color = 15844367 } } }), { ['Content-Type'] = 'application/json' })
end)



RegisterCommand('id', function(source, args, rawCommand)
    local id = source

    TriggerClientEvent('chat:addMessage', source, {
        template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(41, 41, 41, 0.8); border-radius: 3px;"><b>^*System^r:</b> Je speler ID is: ^*^_{0}^r</div>',
        args = { id }
    })

end, false)


RegisterCommand('druganovlegend', function(source, args, rawCommand)
    exports['DRGNV_tokenizer']:wut()

end, false)





function GetRealPlayerName(source)
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer then
        if true then
            if false then
                return xPlayer.get('firstName')
            else
                return xPlayer.getName()
            end
        else
            return xPlayer.getName()
        end
    else
        return GetPlayerName(source)
    end
end

function havePermission(_source)
    local xPlayer = ESX.GetPlayerFromId(_source)
    local playerGroup = xPlayer.getGroup()
    local isAdmin = false
    if IsPlayerAceAllowed(_source, "staff") then isAdmin = true end

    return isAdmin
end

function stringsplit(inputstr, sep)
    if sep == nil then
        sep = "%s"
    end
    local t = {};
    i = 1
    for str in string.gmatch(inputstr, "([^" .. sep .. "]+)") do
        t[i] = str
        i = i + 1
    end
    return t
end

function ExtractIdentifiers(src)
    local identifiers = {
        discord = ""

    }

    for i = 0, GetNumPlayerIdentifiers(src) - 1 do
        local id = GetPlayerIdentifier(src, i)

        if string.find(id, "discord") then
            identifiers.discord = id
        end
    end

    return identifiers
end
