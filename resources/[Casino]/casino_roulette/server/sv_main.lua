ESX = nil

TriggerEvent(
    'esx:getSharedObject',
    function(obj)
        ESX = obj
    end
)

ESX.RegisterServerCallback('roulette:server:getVerifyToken', function(source, cb)
	local src = source
	local token, resourcename = exports['DRGNV_tokenizer']:generateToken(GetCurrentResourceName(), src)
	while token == nil do
		Wait(500)
	end
	cb(token, resourcename)
end)


local aktivRulettek = {}
Geschiedenis = {}
DiscordWebhook = "https://discord.com/api/webhooks/971711015572090940/a0Ri3OX7XPN5ye0y2cgwDzo-kSI6ONsrFc1hjumbg85A12A1M_SJT7qUN7MTpJxxPja1"
--//////////////////////////--//////////////////////////--//////////////////////////
-- EDIT THESE FOR YOUR SERVER
-- EDIT THESE FOR YOUR SERVER
function getPlayerChips(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer then
        local item = xPlayer.getInventoryItem("casino_chips")
        if item == nil or item == false then return 0 end 
        return item.count
    else
        return 0
    end
end

function giveChips(source, amount)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer then
        Geschiedenis[source].winst =  Geschiedenis[source].winst + amount
        xPlayer.addInventoryItem('casino_chips', amount)
        logMessage('Win', xPlayer.getName() .. ' [ID: '.. source..'] heeft **'.. amount .. '** casino chips gewonnen 🎇.  \n\nTotaal gewonnen/verloren: '..(Geschiedenis[source].winst - Geschiedenis[source].inzet), 2617968, source)
                                                    
    end


end

function removeChips(source, amount)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer then
        if Geschiedenis[source] == nil then 
            Geschiedenis[source] = {}
            Geschiedenis[source].winst = 0
            Geschiedenis[source].inzet = 0
            Geschiedenis[source].new = 0
        end
        Geschiedenis[source].inzet =  Geschiedenis[source].inzet + amount
        Geschiedenis[source].new = Geschiedenis[source].new + amount
        xPlayer.removeInventoryItem('casino_chips', amount)
    end

end
function r_showNotification(source, msg)
	
	TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = msg, length = 2500, style = { ['background-color'] = '#ffffff', ['color'] = '#000000' } })
    --TriggerClientEvent('rulett:showNotification', source, msg)
end
--//////////////////////////--//////////////////////////--//////////////////////////

function isPlayerExist(source)
    if GetPlayerName(source) ~= nil then
        return true
    else
        return false
    end
end

RegisterNetEvent('server_remote:rulett:taskSitDown')
AddEventHandler(
    'server_remote:rulett:taskSitDown',
    function(rulettIndex, chairData)
        local source = source
        local chairId = chairData.chairId

        if aktivRulettek[rulettIndex] ~= nil then
            if aktivRulettek[rulettIndex].chairsUsed[chairId] ~= nil then
                return r_showNotification(source, _U('chair_used'))
            else
                TriggerClientEvent('client_callback:rulett:taskSitDown', source, rulettIndex, chairData)
            end
        else
            TriggerClientEvent('client_callback:rulett:taskSitDown', source, rulettIndex, chairData)
        end
    end
)

RegisterNetEvent('casino:taskStartRoulette')
AddEventHandler(
    'casino:taskStartRoulette',
    function(rulettIndex, chairId)
        local source = source

        if aktivRulettek[rulettIndex] == nil then
            aktivRulettek[rulettIndex] = {
                statusz = false,
                ido = Config.RouletteStart,
                bets = {},
                chairsUsed = {}
            }

            Config.DebugMsg(string.format('created rulett on serverside. table: %s', rulettIndex))
        end

        if aktivRulettek[rulettIndex].chairsUsed[chairId] == nil then
            aktivRulettek[rulettIndex].chairsUsed[chairId] = source
            TriggerClientEvent('client:casino:openRulett', source, rulettIndex)
            TriggerClientEvent('casino:nui:updateChips', source, getPlayerChips(source))
        else
            r_showNotification(source, _U('chair_used'))
        end
    end
)

function countTablePlayers(rulettIndex)
    local count = 0

    if aktivRulettek[rulettIndex] ~= nil then
        for chairId, _ in pairs(aktivRulettek[rulettIndex].chairsUsed) do
            count = count + 1
        end

        return count
    else
        return count
    end
end

RegisterNetEvent('casino:rulett:notUsing')
AddEventHandler(
    'casino:rulett:notUsing',
    function(rulettIndex)
        local source = source
        if aktivRulettek[rulettIndex] ~= nil then
            for chairId, src in pairs(aktivRulettek[rulettIndex].chairsUsed) do
                if src == source then
                    aktivRulettek[rulettIndex].chairsUsed[chairId] = nil
                end
            end
        end
    end
)

AddEventHandler(
    'playerDropped',
    function(reason)
        local source = source
        for rulettIndex, v in pairs(aktivRulettek) do
            for chairId, src in pairs(v.chairsUsed) do
                if src == source then
                    aktivRulettek[rulettIndex].chairsUsed[chairId] = nil
                end
            end
        end
    end
)

Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(1000)

            for rulettIndex, v in pairs(aktivRulettek) do
                if v.statusz == false then
                    if v.ido > 0 then
                        aktivRulettek[rulettIndex].ido = v.ido - 1
                        TriggerClientEvent('client:rulett:updateStatusz', -1, rulettIndex, v.ido, v.statusz)
                    end

                    if v.ido < 1 then
                        local randomSpinNumber = math.random(1, 38) -- do not modify this you idiot
                        if Config.TestTicker ~= nil then
                            randomSpinNumber = Config.TestTicker
                        end
                        local WinningBetIndex = Config.rouletteSzamok[randomSpinNumber]

                        Config.DebugMsg(string.format('Rulett randomSpinNumber: %s, which is number: %s', randomSpinNumber, WinningBetIndex))

                        aktivRulettek[rulettIndex].statusz = true
                        aktivRulettek[rulettIndex].WinningBetIndex = WinningBetIndex
                        TriggerClientEvent('client:rulett:updateStatusz', -1, rulettIndex, v.ido, v.statusz)

                        Citizen.CreateThread(
                            function()
                                
                                Config.DebugMsg('time remaining 0, starting the spin events.')
                                TriggerClientEvent('casino:rulett:startSpin', -1, rulettIndex, randomSpinNumber)
                                Citizen.Wait(15500)
                               
                                
                                if #v.bets > 0 then
                                    CheckWinners(v.bets, aktivRulettek[rulettIndex].WinningBetIndex)
                                    aktivRulettek[rulettIndex].statusz = false
                                    aktivRulettek[rulettIndex].ido = Config.RouletteStart
                                    aktivRulettek[rulettIndex].WinningBetIndex = nil
                                    aktivRulettek[rulettIndex].bets = {} -- reset the bets on the table, very importante
                                    TriggerClientEvent('client:rulett:updateTableBets', -1, rulettIndex, aktivRulettek[rulettIndex].bets)
                                else
                                    if countTablePlayers(rulettIndex) < 1 then
                                        aktivRulettek[rulettIndex] = nil -- deleting the table from srv
                                        Config.DebugMsg(string.format('Rulett table id %s, stopped because no one using it.', rulettIndex))
                                        TriggerClientEvent('client:rulett:updateStatusz', -1, rulettIndex, nil, nil)
                                    else
                                        aktivRulettek[rulettIndex].statusz = false
                                        aktivRulettek[rulettIndex].ido = Config.RouletteStart
                                        aktivRulettek[rulettIndex].WinningBetIndex = nil
                                        aktivRulettek[rulettIndex].bets = {} -- reset the bets on the table, very importante
                                        TriggerClientEvent('client:rulett:updateTableBets', -1, rulettIndex, aktivRulettek[rulettIndex].bets)
                                    end
                                end
                            end
                        )
                    end
                end
            end
        end
    end
)

function CheckWinners(bets, WinningBetIndex)
    local playersWon = {}
    local playersLoss = {}
    local Logged = {}
    for i = 1, #bets, 1 do
        local betData = bets[i]

        local targetSrc = betData.playerSrc
        if Logged[targetSrc] == nil then
            local xPlayer = ESX.GetPlayerFromId(targetSrc)
            logMessage('Inzet', xPlayer.getName() .. ' [ID: '.. targetSrc..'] heeft '.. Geschiedenis[targetSrc].new .. 'casino chips ingezet.  \n\nTotaal gewonnen/verloren: '..(Geschiedenis[targetSrc].winst - Geschiedenis[targetSrc].inzet), 14921392, targetSrc)
            Geschiedenis[targetSrc].new = 0
        end
        
        local PLAYER_HANDLE = isPlayerExist(targetSrc)
        if PLAYER_HANDLE then
            betData.betId = tostring(betData.betId)
            if (WinningBetIndex == '0' and betData.betId == '37') or (WinningBetIndex == '00' and betData.betId == '38') then -- dbl zero, and zero
                giveWinningChips(targetSrc, betData.betAmount, 35)
                playersWon[targetSrc] = true
                if playersLoss[targetSrc] then
                    playersWon[targetSrc] = nil
                end
            elseif
                (betData.betId == '39' and RULETT_NUMBERS.Pirosak[WinningBetIndex]) or (betData.betId == '40' and RULETT_NUMBERS.Feketek[WinningBetIndex]) or
                    (betData.betId == '41' and RULETT_NUMBERS.Parosak[WinningBetIndex]) or
                    (betData.betId == '42' and RULETT_NUMBERS.Paratlanok[WinningBetIndex]) or
                    (betData.betId == '43' and RULETT_NUMBERS.to18[WinningBetIndex]) or
                    (betData.betId == '44' and RULETT_NUMBERS.to36[WinningBetIndex])
             then
                giveWinningChips(targetSrc, betData.betAmount, 2)
                playersWon[targetSrc] = true
                if playersLoss[targetSrc] then
                    playersWon[targetSrc] = nil
                end
            elseif betData.betId <= '36' and WinningBetIndex == betData.betId then -- the numbers
                giveWinningChips(targetSrc, betData.betAmount, 35)
                playersWon[targetSrc] = true
                if playersLoss[targetSrc] then
                    playersWon[targetSrc] = nil
                end
            elseif
                (betData.betId == '45' and RULETT_NUMBERS.st12[WinningBetIndex]) or (betData.betId == '46' and RULETT_NUMBERS.sn12[WinningBetIndex]) or
                    (betData.betId == '47' and RULETT_NUMBERS.rd12[WinningBetIndex]) or
                    (betData.betId == '48' and RULETT_NUMBERS.ket_to_1[WinningBetIndex]) or
                    (betData.betId == '49' and RULETT_NUMBERS.ket_to_2[WinningBetIndex]) or
                    (betData.betId == '50' and RULETT_NUMBERS.ket_to_3[WinningBetIndex])
             then
                giveWinningChips(targetSrc, betData.betAmount, 3)
                playersWon[targetSrc] = true

                if playersLoss[targetSrc] then
                    playersWon[targetSrc] = nil
                end
            else -- LOSS
                if playersWon[targetSrc] == nil then
                    playersLoss[targetSrc] = true
                else
                    playersLoss[targetSrc] = nil
                end
            end
        end
    end

    for targetSrc, _ in pairs(playersLoss) do
        local chairId = getPlayerTableSeat(targetSrc)
        if chairId ~= nil then
            TriggerClientEvent('client:rulett:playWinAnim', targetSrc, chairId)
        end
    end

    for targetSrc, _ in pairs(playersWon) do
        local chairId = getPlayerTableSeat(targetSrc)
        if chairId ~= nil then
            TriggerClientEvent('client:rulett:playLossAnim', targetSrc, chairId)
        end
    end
end

function giveWinningChips(source, amount, szorzo)
    amount = math.floor(amount * szorzo)

    if amount > 0 then
       -- local Desc = GetPlayerName(_source).." **heeft** " .. amount .. " ** chips gewonnen.\n\n  License:** "..xPlayer.identifier
        --PerformHttpRequest(Config.webhook, function(err, text, headers) end, 'POST', json.encode({embeds={{title = "Uitbetaling", description = Desc, footer = { text = " © ZwanenBurgRP - Cannabclaus "}, color=16711680}}}),  { ['Content-Type'] = 'application/json' })

        r_showNotification(source, _('won_chips', amount, szorzo))
        giveChips(source, amount)
    end
end

RegisterNetEvent('casino:taskBetRulett')
AddEventHandler('casino:taskBetRulett',function(rulettIndex, betId, betAmount)
        local source = source

        if aktivRulettek[rulettIndex] ~= nil then
            if aktivRulettek[rulettIndex].statusz then
                return r_showNotification(source, _U('can_not_bet_because_started'))
            end

            local chipsAmount = getPlayerChips(source)
            if chipsAmount >= betAmount then
                removeChips(source, betAmount)
                r_showNotification(source, _('placed_bet', betAmount))
                TriggerClientEvent('casino:nui:updateChips', source, getPlayerChips(source))
                
                if(betAmount > 49999) then
                    r_showNotification(source, "~r~Het inzet bedrag ligt te hoog!")
                    return
                end

                --local Desc = GetPlayerName(_source).." **heeft** " .. betAmount .. " ** chips ingezet.\n\n  License:** "..xPlayer.identifier
                --PerformHttpRequest(Config.webhook, function(err, text, headers) end, 'POST', json.encode({embeds={{title = "Inzet", description = Desc, footer = { text = " © ZwanenBurgRP - Cannabclaus "}, color=16711680}}}),  { ['Content-Type'] = 'application/json' })


                Config.DebugMsg(string.format('player %s betted %s chips on betId: %s', GetPlayerName(source), betAmount, betId))

                local exist = false
                for i = 1, #aktivRulettek[rulettIndex].bets, 1 do
                    local d = aktivRulettek[rulettIndex].bets[i]
                    if d.betId == betId and d.playerSrc == source then
                        exist = true
                        aktivRulettek[rulettIndex].bets[i].betAmount = aktivRulettek[rulettIndex].bets[i].betAmount + betAmount
                    end
                end

                if not exist then
                    table.insert(
                        aktivRulettek[rulettIndex].bets,
                        {
                            betId = betId,
                            playerSrc = source,
                            betAmount = betAmount
                        }
                    )
                end

                TriggerClientEvent('client:rulett:updateTableBets', -1, rulettIndex, aktivRulettek[rulettIndex].bets)
                local chairId = getPlayerTableSeat(source)
                if chairId ~= nil then
                    Config.DebugMsg(string.format('%s chair betanim play', chairId))
                    TriggerClientEvent('client:rulett:playBetAnim', source, chairId)
                end
            else
                r_showNotification(source, _U('not_enough_chips'))
            end
        else -- the table not existing on the serverside? error
            TriggerClientEvent('Notify', source, 'error', 'Hiba történt, nem létező rulettasztal szerveroldalon?')
        end
    end
)

function getPlayerTableSeat(source)
    for rulettIndex, v in pairs(aktivRulettek) do
        for chairId, src in pairs(v.chairsUsed) do
            if src == source then
                return chairId
            end
        end
    end
end
 
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
