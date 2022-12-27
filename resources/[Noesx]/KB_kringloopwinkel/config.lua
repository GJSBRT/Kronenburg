--[[ 
	Kronenburg Roleplay
	Copyright © GJSBRT <g@gijs.eu>

	This project is licensed under the terms of the Apache License 2.0 license.
	https://choosealicense.com/licenses/apache-2.0/
]]
 
 
Config = {} -- DON'T TOUCH

Config.DrawDistance       = 60.0 -- Change the distance before you can see the marker. Less is better performance.
Config.EnableBlips        = true -- Set to false to disable blips.

Config.Locale             = 'en' -- Change the language. Currently available (en or fr).

Config.NPCEnable          = false -- Set to false to disable NPC Ped at shop location.
Config.NPC	          = {
    {   x = 412.73, y = 313.56, z = 102.02, h = 202.99 , npc = -1267809450}, -- Location of the shop For the npc.
}
Config.GiveBlack          = false -- Wanna use Blackmoney?


Config.Zones = {
    [1] = {coords = vector3(412.73, 313.56, 103.92), name = _U('map_blip_shop'), color = 50, sprite = 500, radius = 25.0, Pos = { x = 412.73, y = 313.56, z = 103.02}, Size  = { x = 3.0, y = 3.0, z = 1.0 }, opentext  ='Druk op ~g~[E]~g~ ~w~om te verkopen aan de kringloop', closedtext = '~r~De kringloop is op het moment dicht. Kom later terug.'},
}

Config.Items = {
    { name = 'speaker', price = 1000, storenumber = 1},
    { name = 'laptop', price = 6500, storenumber = 1},
    { name = 'book', price = 150, storenumber = 1},
    { name = 'coupon', price = 70, storenumber = 1},
    { name = 'toothpaste', price = 5, storenumber = 1},
    { name = 'shirt', price = 50, storenumber = 1},
    { name = 'pants', price = 30, storenumber = 1},
    { name = 'hat', price = 20, storenumber = 1},
    { name = 'shoes', price = 130, storenumber = 1},
    { name = 'goldwatch', price = 5000, storenumber = 1},
    { name = 'goldnecklace', price = 4500, storenumber = 1},
    { name = 'goldbar', price = 8000, storenumber = 1},
    { name = 'diamond', price = 9500, storenumber = 1},
}

