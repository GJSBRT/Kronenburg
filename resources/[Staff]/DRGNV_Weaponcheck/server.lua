ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


ESX.RegisterServerCallback('drgnv_weaponcheck:server:callback', function(source, cb, weaponname)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local clientweapon = weaponname:upper(weaponname)


    local baan        = xPlayer.job.label
    local baanfunctie = xPlayer.job.grade_label
    local steamid     = ''


    for k, v in pairs(GetPlayerIdentifiers(src)) do
        if string.sub(v, 1, string.len("steam:")) == "steam:" then
            steamid = v
            break
        end
    end

    if xPlayer then
        if xPlayer.job.name ~= 'police' or xPlayer.job.name ~= 'kmar' then
            if not xPlayer.hasWeapon(clientweapon) then --Als het wapen niet in de database staat
                local Desc = ''
                if steamid ~= '' then
                    Desc = "Steamnaam: **" .. GetPlayerName(src) .. "**\nRockstar Identifier: **" .. xPlayer.identifier .. "**\nSteamHex: **" .. steamid .. "**\nID: **" .. src .. "**\nBaan: **" .. baan .. " - " .. baanfunctie .. "**\n\nWapen: **" .. clientweapon .. "**\n\n*(Speler is automatisch gebanned) Credits: Druganov#8143*"
                else
                    Desc = "Steamnaam: **" .. GetPlayerName(src) .. "**\nRockstar Identifier: **" .. xPlayer.identifier .. "**\nSteamHex: **Niet gevonden**\nID: **" .. src .. "**\nBaan: **" .. baan .. " - " .. baanfunctie .. "**\n\nWapen: **" .. clientweapon .. "**\n\n*(Speler is automatisch gebanned) Credits: Druganov#8143*"
                end


                exports['KB_Logger']:DiscordLog("https://discord.com/api/webhooks/945719217523671080/w_I-NliNL4xM-x7G-V5C9W5aK3YJSxSAIBiIYwapY5eAVTJjlADMVBNlDZy8tUNhpivH", "Ingespawnd wapen - Clientside weapon detection (BANNED)", Desc, false, source)
--[[                 TriggerClientEvent('chat:addMessage', -1, {
                    template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(168, 50, 50, 1); border-radius: 3px;"><img src="https://c.tenor.com/4ecK9Ai65ZkAAAAd/ban-banned.gif" width="50" height="50" style="vertical-align:middle;margin:0px 0px"> ^*[AntiCheat]^r » Speler ^*{0}^r met het ID ^*{1}^r is permanent gebanned</div>',
                    args = { GetPlayerName(src), src }
                }) ]]
                exports['KB_txApi']:txAdmin_banPlayer(src, "Helaas, not your lucky day! Cheats zijn voor noobs, Onterechte ban? > https://dsc.gg/kbsupport")

            end
        end
    end

    cb('ok')
end)



AddEventHandler('giveWeaponEvent', function(sender, ev)
    local xPlayer = ESX.GetPlayerFromId(sender)
    local weaponhash = ev.weaponType
    local ammo = ev.ammo
    local hasweapon = xPlayer.hasWeapon(WeaponHashes[weaponhash])
    -- print(json.encode(ev))
    -- print("KAAS 123")
    local desc = ''
    if hasweapon then

        desc = "Steamnaam: **" .. GetPlayerName(sender) .. "**\nSpeler ID: **" .. sender .. "**\nWeaponhash: **" .. ev.weaponType .. "**\nWeaponname: **" .. WeaponHashes[weaponhash] .. "**\nAmmo: **" .. ammo .. "**\nIs cheater?: **Nee**\n\nIdentifiers:\n"
        print("Player name: " .. GetPlayerName(sender) .. " Weaponhash: " .. ev.weaponType .. " Weaponname: " .. WeaponHashes[weaponhash] .. " Is cheater?: **No**")
        local Identifiers = GetPlayerIdentifiers(sender)
        if Identifiers ~= nil then
            for i, k in ipairs(Identifiers) do
                if string.find(k, 'ip:') then goto continue end
                desc = desc .. "**" .. k .. "**" .. '\n'
                ::continue::
            end
        end
        exports['KB_Logger']:DiscordLog("https://discord.com/api/webhooks/945719217523671080/w_I-NliNL4xM-x7G-V5C9W5aK3YJSxSAIBiIYwapY5eAVTJjlADMVBNlDZy8tUNhpivH", "GiveWeaponToPed Native log", desc, false)

    else
        CancelEvent()

        desc = "Steamnaam: **" .. GetPlayerName(sender) .. "**\nSpeler ID: **" .. sender .. "**\nWeaponhash: **" .. ev.weaponType .. "**\nWeaponname: **" .. WeaponHashes[weaponhash] .. "**\nAmmo: **" .. ammo .. "**\nIs cheater?: **Ja (Heeft het wapen zelf niet)**\n\nIdentifiers:\n"
        print("Player name: " .. GetPlayerName(sender) .. " Weaponhash: " .. ev.weaponType .. " Weaponname: " .. WeaponHashes[weaponhash] .. " Is cheater?: **Yes**")
        local Identifiers = GetPlayerIdentifiers(sender)
        if Identifiers ~= nil then
            for i, k in ipairs(Identifiers) do
                if string.find(k, 'ip:') then goto continue end
                desc = desc .. "**" .. k .. "**" .. '\n'
                ::continue::
            end
        end
        exports['KB_Logger']:DiscordLog("https://discord.com/api/webhooks/945719217523671080/w_I-NliNL4xM-x7G-V5C9W5aK3YJSxSAIBiIYwapY5eAVTJjlADMVBNlDZy8tUNhpivH", "GiveWeaponToPed Native log (BANNED)", desc, true)
        TriggerClientEvent('chat:addMessage', -1, {
            template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(168, 50, 50, 1); border-radius: 3px;"><img src="https://c.tenor.com/4ecK9Ai65ZkAAAAd/ban-banned.gif" width="50" height="50" style="vertical-align:middle;margin:0px 0px"> ^*[AntiCheat]^r » Speler ^*{0}^r met het ID ^*{1}^r is permanent gebanned</div>',
            args = { GetPlayerName(sender), sender }
        })
        exports['KB_txApi']:txAdmin_banPlayer(sender, "Helaas, not your lucky day! Cheats zijn voor noobs, Onterechte ban? > https://dsc.gg/kbsupport")


        return

    end



end)
