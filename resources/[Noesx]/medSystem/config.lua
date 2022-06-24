Config = {}


Config.Declared = 'Burger doodverklaard!' -- This Msg appeared when the player died using /med [id] to display blood = 0 - 5% and Hurt area is Head

Config.Timer = 10   -- Timer to Remove Med Display after using MedSystem

Config.job = {

		names = {
		ambulance = true, 
		police =  true, 
		mechanic = false
			--ambulance = true,             
			--police = true,  --SET This to false so Police job cant use /med commands
			--mechanic = false,  --SET This to false so mech job cant use /med commands
			--unemployed = false, --Default to False so unemployed Player cant use /med
		}
	
}

	