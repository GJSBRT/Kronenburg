Config                            = {}
Config.Locale                     = 'en'

--- #### BASICS
Config.EnablePrice = true -- false = bikes for free
Config.EnableEffects = false
Config.EnableBlips = true


--- #### PRICES	
Config.PriceTriBike = 100
Config.PriceScorcher = 100
Config.PriceCruiser = 100
Config.PriceBmx = 100


--- #### MARKER EDITS
Config.TypeMarker = 20
Config.MarkerScale = { x = 0.75, y = 0.750, z = 0.350}
Config.MarkerColor = { r = 255, g = 157, b = 0}
	
Config.MarkerZones = { 
    {x = -516.980,y = -253.820,z = 35.640},
}


-- Edit blip titles
Config.BlipZones = { 

   {title="Fiets Verhuur", colour=2, id=376, x = -516.980,y = -253.820,z = 35.640},
}
