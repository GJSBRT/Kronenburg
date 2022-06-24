RegisterNetEvent("js:tnui")
AddEventHandler("js:tnui", function(display)
    SendNUIMessage({
    type = "ui",
    display = display
  })
end)