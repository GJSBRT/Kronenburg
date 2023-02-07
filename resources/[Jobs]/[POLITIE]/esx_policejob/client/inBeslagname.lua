ESX   = nil
local PlayerData = {}
local AmountOfPoundVehicles = 0
local alreadyRunning = false
local ReturnVehiclePosition = vector3(-1099.1078, -800.1552, 18.566)

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(7)
    end
    Citizen.Wait(5000)
    PlayerData = ESX.GetPlayerData()

    while true do
        ESX.TriggerServerCallback("inbeslagname::check", function(res)
            if res ~= false then
                AmountOfPoundVehicles = res
                if not alreadyRunning and AmountOfPoundVehicles > 0 then runReturnVehicleFunction() end
            end
        end, {})
        Citizen.Wait(5000)
    end
end)

local Markers = {}
function DrawText3Dd(x, y, z, text)
	SetTextScale(0.35, 0.35)
	SetTextFont(4)
	SetTextProportional(1)
	SetTextColour(255, 255, 255, 215)
	SetTextEntry("STRING")
	SetTextCentre(true)
	AddTextComponentString(text)
	SetDrawOrigin(x,y,z, 0)
	DrawText(0.0, 0.0)
	local factor = (string.len(text)) / 370 
	DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
	ClearDrawOrigin()
end 

function runReturnVehicleFunction()
    alreadyRunning = true
    Citizen.CreateThread(function()
        local sleepTime = 1000
        while AmountOfPoundVehicles > 0 do
            local pCoords = GetEntityCoords(PlayerPedId(-1))
            local DistanceToMarker = GetDistanceBetweenCoords(pCoords, ReturnVehiclePosition)
            if DistanceToMarker < 15 then
                Markers.ReturnVehicle = DrawMarker(21, ReturnVehiclePosition.x, ReturnVehiclePosition.y, ReturnVehiclePosition.z+1, 0, 0, 0, 0, 180.0, 0, 1.5, 1.5, 1.5, 249, 38, 114, 150, true, false)
                DrawText3Dd(ReturnVehiclePosition.x, ReturnVehiclePosition.y, ReturnVehiclePosition.z  + 1.5, 'Druk op [E] om je voertuigen terug te krijgen.')
                sleepTime = 5


                if DistanceToMarker < 3 and IsControlJustPressed(0, 38) then
                    openPaymentMenu()
                    sleepTime = 5000
                end
            end

            Citizen.Wait(sleepTime)
        end
        alreadyRunning = false
    end)
end
-- Player check

function openPaymentMenu()
    local elements = {} 
    local noInvoices = true
    table.insert(elements, {
        label = 'Betaal de onderstaande facturen eerst!',
        value = '-',
    })
    ESX.TriggerServerCallback("inbeslagname::getBills", function(bills) 
        if bills ~= nil and bills ~= {} then
           
            for i, bill in ipairs(bills) do
                table.insert(elements, {
                    label = '€'.. bill.invoice_value ..',- '.. bill.item,
                    value = bill.id,
                })
                noInvoices = false
            end

            if noInvoices then
                table.insert(elements, {
                    label = 'Al je facturen zijn betaald!',
                    value = '-',
                })
                table.insert(elements, {
                    label = '✔ Voertuigen terug claimen',
                    value = 'claim',
                })
            end

            ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'voertuigreturnen',
            {
                title = 'Voertuig terugclaimen',
                align = 'bottom-right',
                elements = elements
            }, function(data, menu)
                if data.current.value == 'claim' then
                    if noInvoices then
                        ESX.TriggerServerCallback("inbeslagname::f", function(res) 
                            if res ~= false then
                                ESX.ShowNotification('Je voertuigen zijn weer beschikbaar in de garages!', 1, 1)
                            end
                        end, {0})
                    end
                end
            end, function(data, menu)
                menu.close()
            end)
        end
    end, {})
end
