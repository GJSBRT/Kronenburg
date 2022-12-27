--[[ 
	Kronenburg Roleplay
	Copyright © GJSBRT <g@gijs.eu>

	This project is licensed under the terms of the Apache License 2.0 license.
	https://choosealicense.com/licenses/apache-2.0/
]]
 
 
-- ================================================================================================--
-- ==                                VARIABLES - DO NOT EDIT                                     ==--
-- ================================================================================================--
ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

function sendToDiscord(name, message, color)
    local DiscordWebHook = "https://discord.com/api/webhooks/939333401759084594/kzy5VOn2t8b7P6yB3s8FXB_jQjFVfUwn0bJ-rka2a4YLQxGIOTdUEHwv3PTKFHg3RgEF"
    -- Modify here your discordWebHook username = name, content = message,embeds = embeds

    local embeds = {
        {
            ["title"] = message,
            ["type"] = "rich",
            ["color"] = color,
            ["footer"] = {
                ["text"] = "Kronenburg Roleplay ",
            },
        }
    }

    if message == nil or message == '' then return FALSE end
    PerformHttpRequest(DiscordWebHook, function(err, text, headers) end, 'POST', json.encode({ username = name, embeds = embeds }), { ['Content-Type'] = 'application/json' })
end
ESX.RegisterServerCallback('new_banking:server:getVerifyToken', function(source, cb)
	local src = source
	local token, resourcename = exports['DRGNV_tokenizer']:generateToken(GetCurrentResourceName(), src)
	while token == nil do
		Wait(500)
	end
	cb(token, resourcename)
end)

HackedATMS = {}


function CurrentPoliceCount()
	local policeCount = 0
	for _, playerId in ipairs(GetPlayers()) do
		local xPlayer = ESX.GetPlayerFromId(playerId)
		if xPlayer ~= nil and xPlayer.job ~= nil and xPlayer.job.name == 'police' then policeCount = policeCount + 1 end
	end
	return tonumber(policeCount)
end

ESX.RegisterServerCallback("new_banking::canPicklock", function(source, cb, ATMID)
	local xPlayer = ESX.GetPlayerFromId(source)

	if ATMID == nil or ATMID == false or HackedATMS[ATMID] ~= nil then
		xPlayer.showNotification('Deze pinautomaat is recent al gekraakt.')
		cb(false)
		return false
	end

	if tonumber(CurrentPoliceCount()) < tonumber(Config.MinPolice) then
		xPlayer.showNotification('Er moet minimaal '.. Config.MinPolice .. ' agent(en) aanwezig zijn.')
		cb(false)
		return false
	end

	if xPlayer then
		local Item = xPlayer.getInventoryItem('lockpick')
		if Item ~= nil and Item ~= false and Item.count > 0 then
			cb(true)
		else
			cb(false)
		end
	else
		cb(false)
	end
end)
RegisterServerEvent("new_banking::pickLockATM")
AddEventHandler("new_banking::pickLockATM", function(ATMID, Timing, PCoords, streetName)
	local xPlayer = ESX.GetPlayerFromId(source)
	if HackedATMS[ATMID] ~= nil then
		xPlayer.showNotification('Deze pinautomaat is recent al gekraakt.')
	end
	-- if not exports['DRGNV_tokenizer']:verifyToken(GetCurrentResourceName(), source, token, "new_banking::pickLockATM") then
	-- 	return
    -- end

	if xPlayer then
		local Item = xPlayer.getInventoryItem('lockpick')
		if Item ~= nil and Item ~= false and Item.count > 0 then
			HackedATMS[ATMID] = true
			
			TriggerClientEvent('3dme:shareDisplay', -1, "**Breekt pinautomaat open**", xPlayer.source)
			Citizen.CreateThread(function()
				Citizen.Wait(3500)
				TriggerEvent('esx_outlawalert:atmRobbery', PCoords, streetName, 1)
				Citizen.Wait(4500)
                TriggerClientEvent('3dme:shareDisplay', -1, "**Breekt pinautomaat open**", xPlayer.source)
				Citizen.Wait(900000)
				HackedATMS[ATMID] = nil
			end)
			xPlayer.showNotification('Beginnen met openbreken...')
			
			Wait(Timing + 3000)
			local WillBreak = tonumber(math.random(1,2))
			if WillBreak == 2 then
				xPlayer.showNotification('Je lockpick is zojuist kapot gegaan.')
				xPlayer.removeInventoryItem('lockpick', 1)
			end
			return true
		else
			return false
		end
	else
		return false
	end
end)

RegisterServerEvent("new_banking::pickLockATMStage2")
AddEventHandler("new_banking::pickLockATMStage2", function(ATMID, Timing, PCoords, streetName)
    local xPlayer = ESX.GetPlayerFromId(source)
	if HackedATMS[ATMID] == nil then
		xPlayer.showNotification('Er gaat iets mis hier. #003322')
        return false
    end
    
    TriggerEvent('esx_outlawalert:atmRobbery2', PCoords, streetName, 1)
    -- if not exports['DRGNV_tokenizer']:verifyToken(GetCurrentResourceName(), source, token, "new_banking::pickLockATM") then
	-- 	return
    -- end
    TriggerClientEvent('3dme:shareDisplay', -1, "** Heeft pinautomaat opengebroken **", xPlayer.source)
			
    -- Give Price
    local Price = 0
    local CanGetMoney = tonumber(math.random(1,2))
    if CanGetMoney == 1 then
        xPlayer.showNotification('Er zit geld in de pinautomaat, systeem haalt bedrag op.')
        Wait(1550) 
        
        TriggerClientEvent('3dme:shareDisplay', -1, "**Probeert geld te stelen**", xPlayer.source)
        Price = math.random(0, tonumber(Config.MaxPrice))
        xPlayer.showNotification('Er zit €'.. Price .. ',- in de automaat. Je pakt het eruit.')
        Wait(5700)
        
        TriggerClientEvent('3dme:shareDisplay', -1, "**Probeert geld te pakken**", xPlayer.source)
        Wait(4250)
        
        --Player.addMoney(Price)
        TriggerClientEvent('3dme:shareDisplay', -1, "**Pakt €"..Price.." uit automaat**", xPlayer.source)
        xPlayer.addAccountMoney('black_money', Price)
        xPlayer.showNotification('Je hebt deze pinautomaat gekraakt!')
    else
        TriggerClientEvent('3dme:shareDisplay', -1, "**Probeert geld te stelen**", xPlayer.source)
        Wait(4300)
        TriggerClientEvent('3dme:shareDisplay', -1, "**Pakt €0,- uit automaat**", xPlayer.source)
        xPlayer.showNotification('Er is geen geld in deze automaat.')
    end
end)
ESX.RegisterUsableItem('lockpick', function(source)
	TriggerClientEvent('new_banking:usedLockpick', source)
end)

RegisterServerEvent('bank:deposit')
AddEventHandler('bank:deposit', function(amount)
    local _source = source

    local xPlayer = ESX.GetPlayerFromId(_source)
    if amount == nil or amount <= 0 then
        TriggerClientEvent('chatMessage', _source, _U('invalid_amount'))
    else
        if amount > xPlayer.getMoney() then
            amount = xPlayer.getMoney()
        end
        xPlayer.removeMoney(amount)
        xPlayer.addAccountMoney('bank', tonumber(amount))
        if amount ~= 0 then
            addtransaction(_source, amount, "€" .. tostring(amount) .. " gestort op de rekening", 0)
        end
        sendToDiscord('Bank logs', "[Bank-storting]\nRekeninghouder " .. GetPlayerName(_source) .. "\nHeeft " .. amount .. " Euro gestort op zijn/haar rekening", 11750815)
    end
end)

RegisterServerEvent('bank:withdraw')
AddEventHandler('bank:withdraw', function(amount)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local base = 0
    amount = tonumber(amount)
    base = xPlayer.getAccount('bank').money
    if amount == nil or amount <= 0 then
        TriggerClientEvent('chatMessage', _source, _U('invalid_amount'))
    else
        if amount > base then
            amount = base
        end
        xPlayer.removeAccountMoney('bank', amount)
        xPlayer.addMoney(amount)
        addtransaction(_source, amount, "€" .. tostring(amount) .. " opgenomen van rekening", 1)
        sendToDiscord('Bank logs', "[Bank-opname]\nRekeninghouder " .. GetPlayerName(_source) .. "\nHeeft " .. amount .. " Euro opgenomen van zijn/haar rekening", 11750815)
    end
end)

RegisterServerEvent('bank:balance')
AddEventHandler('bank:balance', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local balance = xPlayer.getAccount('bank').money
    local zakelijkBalance = 0
    if (xPlayer.job.grade_name == "boss") then
        MySQL.Async.fetchAll('SELECT money FROM addon_account_data WHERE account_name = @accountname LIMIT 1', { ['@accountname'] = "society_" .. xPlayer.job.name }, function(result)
            if result[1] ~= nil and result[1]['money'] ~= nil then zakelijkBalance = result[1]['money'] end
            TriggerClientEvent('currentbalance1', _source, balance, true, zakelijkBalance)
        end)
    else
        TriggerClientEvent('currentbalance1', _source, balance, false, 0)
    end

    
end)

RegisterServerEvent('bank:transfer')
AddEventHandler('bank:transfer', function(to, amountt)
    local overmaak = "https://discord.com/api/webhooks/939333696991932416/m7NmLqFsrYmryKTAdEoJWFILe99JjOy3MWIegi0b6ZqPNc_epK2Ud0YKZ8gtjbOh-CJr"
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local zPlayer = ESX.GetPlayerFromId(to)
    local balance = 0
    if zPlayer ~= nil and GetPlayerEndpoint(to) ~= nil then
        balance = xPlayer.getAccount('bank').money
        zbalance = zPlayer.getAccount('bank').money
        if tonumber(_source) == tonumber(to) then
            -- advanced notification with bank icon
            TriggerClientEvent('esx:showAdvancedNotification', _source, 'Bank',
                'Geld overmaken',
                'U kunt geen geld overmaken naar uw zelf',
                'CHAR_BANK_MAZE', 9)
        else
            if balance <= 0 or balance < tonumber(amountt) or tonumber(amountt) <=
                0 then
                -- advanced notification with bank icon
                TriggerClientEvent('esx:showAdvancedNotification', _source,
                    'ABN AMRO', 'Geld Versturen',
                    'Je hebt niet genoeg geld!',
                    'CHAR_BANK_MAZE', 9)
            else
                xPlayer.removeAccountMoney('bank', tonumber(amountt))
                zPlayer.addAccountMoney('bank', tonumber(amountt))
                -- advanced notification with bank icon
                TriggerClientEvent('esx:showAdvancedNotification', _source,
                    'ABN AMRO', 'Geld Versturen',
                    'Je hebt ~r~€' .. amountt ..
                    '~s~ naar ~r~' .. to .. ' verstuurd.',
                    'CHAR_BANK_MAZE', 9)
                TriggerClientEvent('esx:showAdvancedNotification', to, 'ABN AMRO',
                    'Geld Versturen', 'Je hebt ~r~€' ..
                    amountt .. '~s~ ontvangen van ~r~' .. _source ..
                    ' .', 'CHAR_BANK_MAZE', 9)
                addtransaction(_source, amountt, "€" .. tostring(amountt) .. " overgemaakt naar: " .. zPlayer.getName(), 1)
                PerformHttpRequest(overmaak, function(err, text, headers) end, 'POST', json.encode({ embeds = { { title = "Bank transactie", description = "**Speler **" .. GetPlayerName(source) .. "** Heeft **" .. amountt .. "** Euro overgemaakt naar **" .. GetPlayerName(to) .. "", footer = { text = " © KronenburgRP " }, color = 3066993 } } }), { ['Content-Type'] = 'application/json' })

            end

        end
    end

end)





--[[ Transactions ]]
--[[ Example: TriggerEvent("bank:addtransaction", source, 100, "Geld overgemaakt", 0) ]]
RegisterNetEvent("bank:addtransaction")
AddEventHandler("bank:addtransaction", function(source, amount, reason, taken)
    if reason == "" then
        reason = "Anders"
    end

    local license = false
    for k, v in pairs(GetPlayerIdentifiers(source)) do
        if string.sub(v, 1, string.len("license:")) == "license:" then
            license = v
        end
    end

    MySQL.Async.execute('INSERT INTO bank_transactions (license, amount, reason, taken) VALUES (@license, @amount, @reason, @taken)',
        { ['license'] = license, ['amount'] = amount, ['reason'] = reason, ['taken'] = taken },
        function(affectedRows)
    end
    )
end)

function addtransaction(source, amount, reason, taken)
    if reason == "" then
        reason = "Anders"
    end

    local license = false
    for k, v in pairs(GetPlayerIdentifiers(source)) do
        if string.sub(v, 1, string.len("license:")) == "license:" then
            license = v
        end
    end

    MySQL.Async.execute('INSERT INTO bank_transactions (license, amount, reason, taken) VALUES (@license, @amount, @reason, @taken)',
        { ['license'] = license, ['amount'] = amount, ['reason'] = reason, ['taken'] = taken },
        function(affectedRows)
    end
    )
end

RegisterNetEvent("bank:gettransactions")
AddEventHandler("bank:gettransactions", function()
    _source = source

    local license = false
    for k, v in pairs(GetPlayerIdentifiers(_source)) do
        if string.sub(v, 1, string.len("license:")) == "license:" then
            license = v
        end
    end

    MySQL.Async.fetchAll('SELECT amount, reason, taken, date FROM bank_transactions WHERE license = @license ORDER BY date DESC LIMIT 20', { ['@license'] = license }, function(result)
        local output = json.encode(result) 
        TriggerClientEvent("bank:showtransactions", _source, output)
    end)
end)




--[[ Transactions Zakelijk ]]
--[[ Example: TriggerEvent("bank:addtransaction_zakelijk", source, 100, "Geld overgemaakt", 0) ]]
RegisterNetEvent("bank:addtransaction_zakelijk")
AddEventHandler("bank:addtransaction_zakelijk", function(source, amount, reason, taken)
    if reason == "" then
        reason = "Anders"
    end

    local license = false
    for k, v in pairs(GetPlayerIdentifiers(source)) do
        if string.sub(v, 1, string.len("license:")) == "license:" then
            license = v
        end
    end

    MySQL.Async.execute('INSERT INTO bank_transactions (license, amount, reason, taken) VALUES (@license, @amount, @reason, @taken)',
        { ['license'] = license, ['amount'] = amount, ['reason'] = reason, ['taken'] = taken },
        function(affectedRows)
    end
    )
end)

function addtransaction_zakelijk(source, amount, reason, taken)
    if reason == "" then
        reason = "Anders"
    end

    local license = false
    for k, v in pairs(GetPlayerIdentifiers(source)) do
        if string.sub(v, 1, string.len("license:")) == "license:" then
            license = v
        end
    end

    MySQL.Async.execute('INSERT INTO bank_transactions (license, amount, reason, taken) VALUES (@license, @amount, @reason, @taken)',
        { ['license'] = license, ['amount'] = amount, ['reason'] = reason, ['taken'] = taken },
        function(affectedRows)
    end
    )
end

RegisterNetEvent("bank:gettransactions_zakelijk")
AddEventHandler("bank:gettransactions_zakelijk", function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    if (xPlayer.getJob().grade_name == "boss") then
        MySQL.Async.fetchAll('SELECT amount, reason, taken, date FROM society_bank_transactions WHERE job = @jobname ORDER BY created_at DESC LIMIT 20', { ['@jobname'] = xPlayer.getJob().name }, function(result)
            local output = json.encode(result)
            TriggerClientEvent("bank:showtransactions_zakelijk", _source, output)
        end)
    end
end)
