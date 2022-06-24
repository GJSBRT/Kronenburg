Citizen.CreateThread(function()
    while true do
        TriggerEvent("baseevents:tick", GetGameTimer())
        Citizen.Wait(10000)
    end
end)