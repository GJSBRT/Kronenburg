
-- ## 3dme : server side
local melogwebhook = "https://canary.discord.com/api/webhooks/940715936929947708/YEahsthj8QzYgDAe-Wb5XDYDGgOxcRIXONUmjmnqzGWCBJv1f1BAXfrwjPpQDY5uu1Ey"


-- Command
RegisterCommand('me', function(source, args)

    local playerid = source

    local text = "" .. table.concat(args, " ") .. ""
    TriggerClientEvent('3dme:shareDisplay', -1, text, source)
    TriggerClientEvent("esx-qalle-chat:me", -1, source, playerid, text)

    PerformHttpRequest(melogwebhook, function(err, text, headers) end, 'POST', json.encode({embeds={{title = "/Me log", description = " **"..GetPlayerName(source).."**:  "..table.concat(args, " ").."", footer = { text = "Kronenburg Roleplay"..os.date("%d/%m/%Y - %X")}, color=16625167}}}),  { ['Content-Type'] = 'application/json' })
end)