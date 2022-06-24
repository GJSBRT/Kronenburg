ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('duty:onoff')
AddEventHandler('duty:onoff', function(job)

    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local job = xPlayer.job.name
    local grade = xPlayer.job.grade

    if job == 'police' or job == 'ambulance' or job == 'mechanic' or job == 'brandweer' then
        xPlayer.setJob('off' .. job, grade)
        TriggerClientEvent('esx:showNotification', _source, _U('offduty'))
    elseif job == 'offpolice' then
        xPlayer.setJob('police', grade)
        TriggerClientEvent('esx:showNotification', _source, _U('onduty'))
    elseif job == 'offmechanic' then
        xPlayer.setJob('mechanic', grade)
        TriggerClientEvent('esx:showNotification', _source, _U('onduty'))
    elseif job == 'offambulance' then
        xPlayer.setJob('ambulance', grade)
        TriggerClientEvent('esx:showNotification', _source, _U('onduty'))
    elseif job == 'offbrandweer' then
        xPlayer.setJob('brandweer', grade)
        TriggerClientEvent('esx:showNotification', _source, _U('onduty'))
    end

end)

local firstSpawn = {}
AddEventHandler('playerSpawned', function()
    if firstSpawn[source] == nil then
        local xPlayer = ESX.GetPlayerFromId(source)
        if xPlayer ~= nil then
            local job = xPlayer.job.name
            local grade = xPlayer.job.grade
            xPlayer.setJob('off' .. job, grade)
        end
        firstSpawn[source] = true
    end
end)
