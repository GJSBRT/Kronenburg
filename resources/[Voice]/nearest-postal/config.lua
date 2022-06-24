config = {
	versionCheck = true,-- enables version checking (if this is enabled and there is no new version it won't display a message anyways) 
	text = {
		format = '~y~Nearest Postal~w~: %s (~g~%.2fm~w~)',
		-- ScriptHook PLD Position
		--posX = 0.225,
		--posY = 0.963,
		-- vMenu PLD Position
		posX = 0.22,
		posY = 0.963
	},
	blip = {
		blipText = 'GPS Route %s',
		sprite = 8,
		color = 81, -- default 3 (light blue)
		distToDelete = 100.0, -- in meters
		deleteText = 'Route verwijderd',
		drawRouteText = 'GPS locatie ingesteld op postcode %s',
		notExistText = "Postcode %s bestaat niet!"
	},
}