ESX = nil
local timecache,collecting = {},{}

Citizen.CreateThread(function()
	TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    while ESX==nil do Wait(0) end
end)

Citizen.CreateThread(function()
	MySQL.ready(function()
		MySQL.Async.fetchAll("SELECT identifier,next_collect FROM `daily_free`",{},function(data)
			for k,v in ipairs(data) do
				timecache[v.identifier]=v.next_collect
			end
		end)
	end)
end)

function getSteamIdentifier(identifiers)
	for k,v in ipairs(identifiers) do
		if v:find("steam") then return v end
	end
	return nil
end

function copyTbl(obj) -- why? because lua is kinda cancer with table copying
	if type(obj) ~= 'table' then return obj end
	local res = {}
	for k, v in pairs(obj) do res[copyTbl(k)] = copyTbl(v) end
	return res
end

RegisterServerEvent("free:updateTimeout")
AddEventHandler("free:updateTimeout", function()
	local _source = source
	local identifier = getSteamIdentifier(GetPlayerIdentifiers(_source))
	if not identifier then return end
	local now = os.time()




	if timecache[identifier] then
		TriggerClientEvent("free:setTimeout", _source, timecache[identifier])
	else
		MySQL.Async.fetchAll('SELECT `next_collect` FROM `daily_free` WHERE `identifier`=@identifier;', {['@identifier'] = identifier}, function(collect)
			if collect[1] then
				TriggerClientEvent("free:setTimeout", _source, collect[1].next_collect)
				timecache[identifier] = collect[1].next_collect
			else
				TriggerClientEvent("free:setTimeout", _source, 0)
				timecache[identifier] = 0
			end
		end)
	end
end)

function giveItem(it,xPlayer)
	if not it or not xPlayer then return end
	if it.type==1 and it.value then
		xPlayer.addMoney(it.value)
	elseif it.type==2 and it.item and it.count then
		xPlayer.addInventoryItem(it.item,it.count)
	elseif it.type==3 and it.weapon and it.ammo then
		TriggerClientEvent("free:giveWpn",xPlayer.source,it.weapon,it.ammo)
	end
end

function claimRewards(xPlayer, _source)

	local _randomPrice = math.random(1, 10)
	if _randomPrice == 1 then
		-- ticket
		local _subRan = math.random(1,3)
		if _subRan <= 1 then
			xPlayer.addInventoryItem('luckyticket', 1)
			print(xPlayer)
			TriggerClientEvent('esx:showNotification', _source, ("Je hebt ~g~Luckywheel Ticket ~w~gekregen uit je daily!"))
		else
			xPlayer.addMoney(1250)
			TriggerClientEvent('esx:showNotification', _source, ("Je hebt ~g~" .. ESX.Math.GroupDigits(1250) .. "€ ~w~gekregen uit je daily!"))
		end
	elseif _randomPrice > 1 and _randomPrice <= 5 then
			-- 5K
		local _subRan = math.random(1,10)
		if _subRan <= 1 then
			xPlayer.addMoney(5000)
			TriggerClientEvent('esx:showNotification', _source, ("Je hebt ~g~" .. ESX.Math.GroupDigits(5000) .. "€ ~w~gekregen uit je daily!"))
		else
			xPlayer.addMoney(1000)
			TriggerClientEvent('esx:showNotification', _source, ("Je hebt ~g~" .. ESX.Math.GroupDigits(1000) .. "€ ~w~gekregen uit je daily!"))
		end
	elseif _randomPrice > 5 and _randomPrice <= 10 then
		-- 5K
		local _subRan = math.random(1,10)
		if _subRan <= 1 then
			xPlayer.addMoney(2000)
			TriggerClientEvent('esx:showNotification', _source, ("Je hebt ~g~" .. ESX.Math.GroupDigits(2000) .. "€ ~w~gekregen uit je daily!"))
		else
			xPlayer.addMoney(2500)
			TriggerClientEvent('esx:showNotification', _source, ("Je hebt ~g~" .. ESX.Math.GroupDigits(2500) .. "€ ~w~gekregen uit je daily!"))
		end	
	end


--[[
	if Config.random_rewards_enabled then
		local weighedlist = {}
		for k,v in ipairs(copyTbl(Config.random_rewards)) do
			local chance = v.chance; v.chance = nil
			for i=1,chance do
				table.insert(weighedlist,v)
			end
		end
		for k,v in ipairs(weighedlist[math.random(0,#weighedlist)]) do
			giveItem(v,xPlayer)
		end
	else
		for k,v in ipairs(Config.rewards) do
			giveItem(v,xPlayer)
		end
	end]]
end

RegisterServerEvent("free:collect")
AddEventHandler("free:collect", function(t)
	local _source = source
	if collecting[_source] then return end
	collecting[_source]=true -- small cache, this fixes dupe bug
	local xPlayer = ESX.GetPlayerFromId(_source)
	local identifier = xPlayer.identifier
	local now = os.time()
	local nextcollect = os.time() + 86399


	if timecache[identifier] then -- if the time is cached just check that first to make things faster
		if timecache[identifier] > now then
			TriggerClientEvent("free:setTimeout", _source, timecache[identifier])
			TriggerClientEvent("chat:addMessage", _source, {color={255,0,0}, multiline=false, args={"Daily Free", "It's still not time..."}})
			collecting[_source]=nil
			return
		end
	end
	MySQL.Async.fetchAll('SELECT * FROM `daily_free` WHERE `identifier`=@identifier;', {['@identifier'] = identifier}, function(collect)
		if collect[1] then
			if collect[1].next_collect < now then
				claimRewards(xPlayer, _source)
--				TriggerClientEvent("esx:showNotification",_source,Config.claimed)
				TriggerClientEvent("free:toggleFreeMenu", _source, false)
				MySQL.Async.execute('UPDATE `daily_free` SET `next_collect`=@nextcollect,`times_collected`=@timescollected WHERE `identifier`=@identifier', {["@identifier"] = identifier, ["@nextcollect"] = nextcollect, ["@timescollected"] = collect[1].times_collected+1}, nil)
				TriggerClientEvent("free:setTimeout", _source, nextcollect)
			else
				TriggerClientEvent("free:setTimeout", _source, collect[1].next_collect)
				TriggerClientEvent("chat:addMessage", _source, {color={255,0,0}, multiline=false, args={"Daily Free", "It's still not time..."}})
			end
		else
			claimRewards(xPlayer, _source)
--			TriggerClientEvent("esx:showNotification",_source,Config.claimed)
			TriggerClientEvent("free:setTimeout", _source, nextcollect)
			TriggerClientEvent("free:toggleFreeMenu", _source, false)
			MySQL.Async.execute('INSERT INTO `daily_free` (`identifier`, `next_collect`, `times_collected`) VALUES (@identifier, @nextcollect, 1);', {['@identifier'] = identifier, ['@nextcollect'] = nextcollect}, nil)
		end
	end)
	collecting[_source]=nil
end)

RegisterCommand("daily", function(source)
	TriggerClientEvent("free:toggleFreeMenu", source, true)
end)


function sendtoDiscord(webhook, titel, bericht, kleur, mention)
    local WebHook = 'https://discord.com/api/webhooks/924101070853115946/ojy0nUcckANjycm0iOME368jNzU2Lw_jyth5u-AuShqndWHQdPHoUvo596yBLjVGE9LV'

    
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