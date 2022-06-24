RegisterCommand(Config.CommandName, function(source, args)

    if IsPlayerAceAllowed(source, Config.PermissionName) then
        local msg = table.concat(args, " ")
        local playerName = GetPlayerName(source)
            for _, playerId in ipairs(GetPlayers()) do

                if IsPlayerAceAllowed(playerId, Config.PermissionName) then
                    
                    TriggerClientEvent('chat:addMessage', playerId, {
                        template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(209, 71, 71 , 0.6); border-radius: 3px;"><img src="https://cdn.discordapp.com/attachments/939313618036588614/939313650106253412/logo.png" width="20" height="20" style="vertical-align:middle;margin:0px 0px">^r {0}^r^7 » {1}</div>',
                        args = { playerName, msg }
                    })
                end
            end
            exports['KB_Logger']:DiscordLog(Config.LogWebhook, "Staffchat", "[Staffchat] **"..GetPlayerName(source).."** » "..msg, false)
    else
        TriggerClientEvent('chat:addMessage', source, {
            template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(235, 64, 52, 0.6); border-radius: 10px;"><i class="fas fa-times"></i> {0}</div>',
            args = { Config.AccesDenied }
        })
    end


end, false)