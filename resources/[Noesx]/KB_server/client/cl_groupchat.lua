--[[ 
	Kronenburg Roleplay
	Copyright © GJSBRT <g@gijs.eu>

	This project is licensed under the terms of the Apache License 2.0 license.
	https://choosealicense.com/licenses/apache-2.0/
]]
 
 

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