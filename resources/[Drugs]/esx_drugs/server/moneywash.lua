RegisterServerEvent('esx_retropluk:Wash') --FAKE TRIGGER
AddEventHandler('esx_retropluk:Wash', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local playtime = exports['rp_Main']:GetPlayTimeFormatted(_source)
	local triggername = "esx_retropluk:Wash"
	TriggerClientEvent('chat:addMessage', -1, {
		template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(168, 50, 50, 1); border-radius: 3px;"><i class="fas fa-times-circle"></i> AntiCheat:<br> Speler ^*{0}^r met het ID ^*{1}^r is permanent gebanned voor het uigvoeren van triggers</div>',
		args = { GetPlayerName(_source), _source }
	  })

	sendtoDiscord(mogolenwebhook, "Fake trigger uitgevoerd (BANNED)", "Speler: **"..GetPlayerName(_source).."**\nSteamHex: **"..GetPlayerIdentifier(_source).."**\nIdentifier: **".. xPlayer.identifier .."**\nID: **".. _source .."**\nTrigger: **"..triggername.."**\nSpeeltijd: **"..playtime.."**", 11022898, true)
	TriggerEvent("el_bwh:ban", ESX.GetPlayerFromId(_source), ESX.GetPlayerFromId(_source), 'Helaas... Vandaag effe niet topper!', '6969/04/20 12:00', offline)
	DropPlayer(_source, "BWH Kick")
end)

ESX.RegisterServerCallback('esx_retropluk:GetBlackmoney', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local ammount = xPlayer.getAccount('black_money').money
	
	cb(ammount)
end)

ESX.RegisterServerCallback('esx_retropluk:CheckMoneyWashLicense', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local xMoneyWash = xPlayer.getInventoryItem('moneywash')

	if xMoneyWash.count == 1 then
		cb(true)
	else
		cb(false)
	end
end)

function sendtoDiscord(webhook, titel, bericht, kleur, mention)
    local WebHook = webhook

    
    local discordInfo = {
        ["color"] = kleur,
        ["title"] = titel,
        ["description"] = bericht,
        ["timestamp"] = os.date('%Y-%m-%d %H:%M', os.time() - 3600),
        ["footer"] = {
        ["text"] = "© RetroPolis roleplay 📆"
        }
    }
    if mention then
        PerformHttpRequest(WebHook, function(err, text, headers) end, 'POST', json.encode({ username = 'RetroPolis logs',avatar_url = "https://i.imgur.com/QHbhzWT.png", content = "@here" }), { ['Content-Type'] = 'application/json' })
        PerformHttpRequest(WebHook, function(err, text, headers) end, 'POST', json.encode({ username = 'RetroPolis logs', avatar_url = "https://i.imgur.com/QHbhzWT.png", embeds = { discordInfo } }), { ['Content-Type'] = 'application/json' })
    else
        PerformHttpRequest(WebHook, function(err, text, headers) end, 'POST', json.encode({ username = 'RetroPolis logs',avatar_url = "https://i.imgur.com/QHbhzWT.png", embeds = { discordInfo } }), { ['Content-Type'] = 'application/json' })
    end
end