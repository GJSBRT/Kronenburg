--[[ 
	Kronenburg Roleplay
	Copyright © GJSBRT <g@gijs.eu>

	This project is licensed under the terms of the Apache License 2.0 license.
	https://choosealicense.com/licenses/apache-2.0/
]]
 
 
local spawn1 = false							-- Variable pour vérifier si déjà spawn

AddEventHandler("playerSpawned", function () 	-- Attendre que le joueur spawn
	if not spawn1 then
		ShutdownLoadingScreenNui()				-- Fermer la ressource d'écran de chargement
		spawn1 = true
	end
end)