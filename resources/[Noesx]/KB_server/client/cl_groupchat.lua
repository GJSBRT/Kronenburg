
----- CLIENT EVENT -----

AddEventHandler("properload", function()
	-- Let the server know that the player has joined properly.
	TriggerServerEvent( "properload")
end)

Citizen.CreateThread(function()
	while true do
		-- Wait 5 seconds after player has loaded in and trigger the event.
		Citizen.Wait( 5000 )

		if NetworkIsSessionStarted() then
			TriggerEvent('properload')
			return
		end
	end
end )