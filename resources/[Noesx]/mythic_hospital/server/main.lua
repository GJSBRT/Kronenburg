local beds = {
    { x = -448.32, y = -283.65, z = 35.83, h = 200.1, taken = false, model = 2117668672 },
    { x = -451.59, y = -284.79, z = 35.83, h = 200.1, taken = false, model = 2117668672 },
    { x = -454.92, y = -286.34, z = 35.83, h = 200.1, taken = false, model = 2117668672 },
    { x = -460.48, y = -288.5,  z = 35.83, h = 200.1, taken = false, model = 2117668672 },
    { x = -463.68, y = -290.01, z = 35.83, h = 200.1, taken = false, model = 2117668672 },
    { x = -467.02, y = -291.47, z = 35.83, h = 200.1, taken = false, model = 2117668672 },
    { x = -454.83, y = -278.85, z = 35.83, h = 20.0, taken = false, model = 2117668672 },
    { x = -458.69, y = -280.42, z = 35.83, h = 20.0, taken = false, model = 2117668672 },
    { x = -462.55, y = -281.82, z = 35.83, h = 20.0, taken = false, model = 2117668672 },
    { x = -466.26, y = -283.46, z = 35.83, h = 20.0, taken = false, model = 2117668672 },
    { x = -469.62, y = -284.91, z = 35.83, h = 20.0, taken = false, model = 2117668672 },
}


local bedsTaken = {}
local injuryBasePrice = 100
ESX             = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

AddEventHandler('playerDropped', function()
    if bedsTaken[source] ~= nil then
        beds[bedsTaken[source]].taken = false
    end
end)

AddEventHandler('playerDropped', function()
    if bedsTaken[source] ~= nil then
        beds[bedsTaken[source]].taken = false
    end
end)

RegisterServerEvent('mythic_hospital:server:RequestBed')
AddEventHandler('mythic_hospital:server:RequestBed', function()
    for k, v in pairs(beds) do
        if not v.taken then
            v.taken = true
            bedsTaken[source] = k
            TriggerClientEvent('mythic_hospital:client:SendToBed', source, k, v)
            return
        end
    end

    TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'No beds available.' })
end)

RegisterServerEvent('mythic_hospital:server:RPRequestBed')
AddEventHandler('mythic_hospital:server:RPRequestBed', function(plyCoords)
    local foundbed = false
    for k, v in pairs(beds) do
        local distance = #(vector3(v.x, v.y, v.z) - plyCoords)
        if distance < 3.0 then
            if not v.taken then
                v.taken = true
                foundbed = true
                TriggerClientEvent('mythic_hospital:client:RPSendToBed', source, k, v)
                return
            else
                TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'That bed is taken.' })
            end
        end
    end

    if not foundbed then
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'You are not near a hospital bed.' })
    end
end)

RegisterServerEvent('mythic_hospital:server:EnteredBed')
AddEventHandler('mythic_hospital:server:EnteredBed', function()
    local src = source
    Citizen.Wait(10)
    TriggerClientEvent('mythic_hospital:client:FinishServices', src)
end)

RegisterServerEvent('mythic_hospital:server:LeaveBed')
AddEventHandler('mythic_hospital:server:LeaveBed', function(id)
    beds[id].taken = false
end)
