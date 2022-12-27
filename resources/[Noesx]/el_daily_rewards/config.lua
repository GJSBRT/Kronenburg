--[[ 
	Kronenburg Roleplay
	Copyright © GJSBRT <g@gijs.eu>

	This project is licensed under the terms of the Apache License 2.0 license.
	https://choosealicense.com/licenses/apache-2.0/
]]
 
 
local type = {money=1,item=2,weapon=3} -- no touchey, thank you
Config = {}

Config.claimed = "~g~Je hebt je dagelijkse beloning geclaimed!"

--[[
Config.rewards = {
    {
        type = type.money,
        value = 1000
    },
    {
        type = type.item,
        item = "test",
        count = 3
    },
    {
        type = type.item,
        item = "test2",
        count = 5
    },
    {
        type = type.weapon,
        weapon = "WEAPON_PISTOL", -- if they already have the weapon, they'll only get the ammo
        ammo = 10
    }
}

Config.random_rewards_enabled = true
Config.random_rewards = {
    {
        chance = 90, -- this can be any whole number (higher = better chance)
        {
            type = type.money,
            value = 1000
        },
        {
            type = type.money,
            value = 2500
        },
        {
            type = type.money,
            value = 5000
        }
    },
    {
        chance = 10,
        {
            type = type.item,
            item = "test",
            count = 5
        },
        {
            type = type.weapon,
            weapon = "WEAPON_PISTOL", -- if they already have the weapon, they'll only get the ammo
            ammo = 100
        }
    }
}]]