--[[ 
	Kronenburg Roleplay
	Copyright © GJSBRT <g@gijs.eu>

	This project is licensed under the terms of the Apache License 2.0 license.
	https://choosealicense.com/licenses/apache-2.0/
]]
 
 
RegisterServerEvent('Tackle:Server:TacklePlayer')
AddEventHandler('Tackle:Server:TacklePlayer', function(Tackled, ForwardVectorX, ForwardVectorY, ForwardVectorZ, Tackler)
	TriggerClientEvent("Tackle:Client:TacklePlayer", Tackled, ForwardVectorX, ForwardVectorY, ForwardVectorZ, Tackler)
end)
