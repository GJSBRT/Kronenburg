ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)



ESX.RegisterServerCallback("inbeslagname::check", function(src, cb, param)
    local xPlayer = ESX.GetPlayerFromId(src)
    if xPlayer ~= nil then
        local count = 0
        MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE owner = @owner AND pound = 1', {
            ['@owner'] = xPlayer.identifier
        }, function(pounds)
            if pounds ~= nil then
                for i, pounded in pairs(pounds) do
                    count = count + 1
                end
            end

            cb(count)
        end)
    else
        cb(0)
    end
 end)
ESX.RegisterServerCallback("inbeslagname::getBills", function(src, cb, param)
    local xPlayer = ESX.GetPlayerFromId(src)
    if xPlayer ~= nil then
        local count = 0
        MySQL.Async.fetchAll("SELECT * FROM blub_billing WHERE receiver_identifier = @owner and status = 'unpaid'", {
            ['@owner'] = xPlayer.identifier
        }, function(bills)
            if bills ~= nil and bills[1] ~= nil then
                cb(bills)
            else
                cb({})
            end
        end)
    else
        cb({})
    end
end)

ESX.RegisterServerCallback("inbeslagname::f", function(src, cb, param)
    local hasBills = false
    local xPlayer = ESX.GetPlayerFromId(src)
    if xPlayer ~= nil then
        MySQL.Async.fetchAll("SELECT * FROM blub_billing WHERE receiver_identifier = @owner and status = 'unpaid'", {
            ['@owner'] = xPlayer.identifier
        }, function(bills)
            if bills ~= nil and bills[1] ~= nil then
                hasBills = true
                cb(false)
            else
                hasBills = false
                xPlayer.removeAccountMoney('bank', 500)
                MySQL.Async.execute('UPDATE owned_vehicles SET pound = 0, stored = 1 WHERE owner = @owner', {
                ['@owner'] = xPlayer.identifier
                }, function(rows)
                    cb(rows)
                end)
            end
        end)
    else
        cb(false)
    end
end)