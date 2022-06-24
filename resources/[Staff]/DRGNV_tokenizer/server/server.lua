ESX = nil
local druganovisagod = "https://discord.com/api/webhooks/945719217523671080/w_I-NliNL4xM-x7G-V5C9W5aK3YJSxSAIBiIYwapY5eAVTJjlADMVBNlDZy8tUNhpivH"
local ac = {}
local tokens = {}
local restartedresources = {}
local banthisid = {}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


AddEventHandler('onResourceStart', function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then
        return
    end
    print('The resource ' .. resourceName .. ' has been started.')
end)


local charset = {}
do -- [0-9a-zA-Z]
    for c = 48, 57 do table.insert(charset, string.char(c)) end
    for c = 65, 90 do table.insert(charset, string.char(c)) end
    for c = 97, 122 do table.insert(charset, string.char(c)) end
end

local function randomString(length)
    if not length or length <= 0 then return '' end
    math.randomseed(os.clock() ^ 5)
    return randomString(length - 1) .. charset[math.random(1, #charset)]
end

exports('loadPlayer', function(id, identifier)
    tokens[id] = {}
    tokens[id]['identifier'] = identifier
    for i = 1, GetNumPlayerTokens(id) do
        table.insert(tokens[id], GetPlayerToken(id, i))
    end
end)





exports('getTokens', function(id)
    return tokens[id], tokens[id]['identifier']
end)

exports('wut', function()
    print("working")
end)

exports('generateToken', function(resourcename, id, triggername)
    if not ac[id] then
        ac[id] = {}
    end
    if not ac[id][resourcename] then
        ac[id][resourcename] = { ['token'] = randomString(16), ['eventname'] = randomString(32) }
        return ac[id][resourcename]['token'], ac[id][resourcename]['eventname']
    else
        if restartedresources[resourcename] then
            ac[id][resourcename] = { ['token'] = randomString(16), ['eventname'] = randomString(32) }
            return ac[id][resourcename], ac[id][resourcename]['eventname']
        else
            FalseToken2(id, resourcename)
        end
    end
end)

exports('verifyToken', function(resourcename, id, token, triggername)
    if ac[id][resourcename] then
        if ac[id][resourcename]['token'] == token then
            ac[id][resourcename]['token'] = randomString(16)
            TriggerClientEvent(ac[id][resourcename]['eventname'], id, ac[id][resourcename]['token'])
            return true
        else
            FalseToken(id, token, triggername, resourcename)
        end
    else
        FalseToken(id, token, triggername, resourcename)
    end
end)

AddEventHandler('onResourceStart', function(resourceName)
    Wait(5000)
    if restartedresources[resourceName] then
        restartedresources[resourceName] = nil
    end
end)

AddEventHandler('onResourceStop', function(resourceName)
    restartedresources[resourceName] = { true }
end)

AddEventHandler('playerDropped', function(reason)
    local src = source
    ac[src] = nil
end)




function FalseToken(PID, playertoken, triggername, resourcename)
    local xPlayer  = ESX.GetPlayerFromId(PID)
    local gettoken = nil
    local tname    = nil
    local steamhex = ''


    for k, v in pairs(GetPlayerIdentifiers(PID)) do
        if string.sub(v, 1, string.len("steam:")) == "steam:" then
            steamhex = v
            break
        end
    end


    if triggername ~= nil then
        tname = triggername
    else
        tname = "Niet opgegeven"
    end


    if playertoken ~= nil then
        gettoken = playertoken
    else
        gettoken = "Niet ingevoerd (NOOB)"
    end
    TriggerClientEvent("jumpscare:toggleNUI", PID, true) -- # rip hacker, krijgen izjen dikke jumpscare. - druganov

    Citizen.CreateThread(function()
        Citizen.Wait(10500)
        DropPlayer(PID, "hackuuuur")
    end)

    local Desc = ''
    Desc = "Speler: **" .. GetPlayerName(PID) .. "**\nID: **" .. PID .. "**\nTrigger: **" .. tname .. "**\n\nLegit token: **" .. ac[PID][resourcename]['token'] .. "**\n\nToken die de speler gebruikt heeft: **" .. gettoken .. "**\n\nIdentifiers:\n"
    local Identifiers = GetPlayerIdentifiers(PID)
    if Identifiers ~= nil then
        for i, k in ipairs(Identifiers) do
            if string.find(k, 'ip:') then goto continue end
            if string.find(k, 'discord:') then k = "discord: <@" .. string.gsub(k, "discord:", "") .. ">" end
            Desc = Desc .. "**" .. k .. "**" .. '\n'
            ::continue::
        end
    end
    exports['KB_Logger']:DiscordLog(druganovisagod, "False token op trigger (BANNED)", Desc, false, PID)
    banthisid[PID] = true


    AddEventHandler('playerDropped', function(reason) --Als speler de server verlaat krijgt hij een speciale verassing.
        if banthisid[source] then
--[[             TriggerClientEvent('chat:addMessage', -1, {
                template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(168, 50, 50, 1); border-radius: 3px;"><img src="https://c.tenor.com/4ecK9Ai65ZkAAAAd/ban-banned.gif" width="50" height="50" style="vertical-align:middle;margin:0px 0px"> ^*[AntiCheat]^r » Speler ^*{0}^r met het ID ^*{1}^r is permanent gebanned</div>',
                args = { GetPlayerName(PID), PID }
            }) ]]
            exports['KB_txApi']:txAdmin_banPlayer(source, "Helaas, not your lucky day! Cheats zijn voor noobs, Onterechte ban? > https://dsc.gg/kbsupport")
            banthisid[source] = nil
        end
    end)

end

function FalseToken2(PID, resourcename)
    local xPlayer  = ESX.GetPlayerFromId(PID)
    local gettoken = nil
    local tname    = nil
    local steamhex = 'Niet gevonden'


    for k, v in pairs(GetPlayerIdentifiers(PID)) do
        if string.sub(v, 1, string.len("steam:")) == "steam:" then
            steamhex = v
            break
        end
    end

    TriggerClientEvent("jumpscare:toggleNUI", PID, true) -- # rip hacker, krijgen izjen dikke jumpscare. - druganov
    Citizen.Wait(3500)

    TriggerClientEvent("jumpscare:toggleNUI", PID, false)
    Desc = "Speler: **" .. GetPlayerName(PID) .. "**\nSteamHex: **" .. steamhex .. "**\nIdentifier: **" .. xPlayer.identifier .. "**\nID: **" .. PID .. "**\nResourcename: **" .. resourcename .. "**"

    exports['KB_Logger']:DiscordLog(druganovisagod, "Probeerde nieuwe token op te vragen (BANNED)", Desc, false, PID)
--[[     TriggerClientEvent('chat:addMessage', -1, {
        template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(168, 50, 50, 1); border-radius: 3px;"><img src="https://c.tenor.com/tkJk3Ui_OBIAAAAM/ban-hammer.gif" width="50" height="50" style="vertical-align:middle;margin:0px 0px"> ^*[AntiCheat]^r » Speler ^*{0}^r met het ID ^*{1}^r is permanent gebanned</div>',
        args = { GetPlayerName(PID), PID }
    }) ]]

    exports['KB_txApi']:txAdmin_banPlayer(PID, "Helaas, not your lucky day! Cheats zijn voor noobs, Onterechte ban? > https://dsc.gg/kbsupport")

end
