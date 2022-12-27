--[[ 
	Kronenburg Roleplay
	Copyright © GJSBRT <g@gijs.eu>

	This project is licensed under the terms of the Apache License 2.0 license.
	https://choosealicense.com/licenses/apache-2.0/
]]
 
 
Migrant = {}

local isMigrantReady = false
local callbackDictionary = {}
local callbackConsumed = {}

local function isBothReady()
    return isMigrantReady and (MySQL and isMySQLReady or true)
end

local function checkReady()
    if isBothReady() then
        for i, cb in ipairs(callbackDictionary) do
            if not callbackConsumed[i] then
                callbackConsumed[i] = true
                cb()
            end
        end
    end
end

AddEventHandler('fxmigrant:resourceDone', function(resourceName, success)
    if resourceName == GetCurrentResourceName() then
        isMigrantReady = true

        checkReady()
    end
end)

function Migrant.ready (callback)
    if MySQL then
        MySQL.ready(function()
            isMySQLReady = true

            checkReady()
        end)

        if exports['fxmigrant']:hasTicked() then
            SetTimeout(150, function()
                isMySQLReady = true

                checkReady()
            end)
        end
    end

    if isBothReady() then
        callback()
    else
        table.insert(callbackDictionary, callback)
        table.insert(callbackConsumed, false)
    end
end