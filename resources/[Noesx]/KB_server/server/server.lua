--[[ 
	Kronenburg Roleplay
	Copyright © GJSBRT <g@gijs.eu>

	This project is licensed under the terms of the Apache License 2.0 license.
	https://choosealicense.com/licenses/apache-2.0/
]]
 
 
RegisterCommand("speeltijd", function(source, args, rawCommand)
    if (source > 0) then
        local license  = false
    
        for k,v in pairs(GetPlayerIdentifiers(source))do
            if string.sub(v, 1, string.len("license:")) == "license:" then
                one = v
                license = one:gsub("license:", "")
                PerformHttpRequest("https://txadmin.kronenburgrp.nl/player/"..license, function(err, text, headers)
                    TriggerClientEvent('chat:addMessage', source, {
                        template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(41, 41, 41, 0.8); border-radius: 3px;"><i class="fas fa-cogs"></i> <b>^*Systeem^r:</b> Je speeltijd is: ^*^_{0}^r en je sessie tijd is ^*^_{1}^r</div>',
                        args = { json.decode(text)['playTime'], json.decode(text)['sessionTime'] }
                    })
                end, 'GET', '')
            end
        end
    else
        print("This command was executed by the server console, RCON client, or a resource.")
    end
end, false)