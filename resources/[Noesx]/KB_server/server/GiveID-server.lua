local eyeColours = {
	"Green",
	"Emerald",
	"Light Blue",
	"Ocean Blue",
	"Light Brown",
	"Dark Brown",
	"Hazel",
	"Dark Gray",
	"Light Gray",
	"Pink",
	"Yellow",
	"Purple",
	"Blackout",
	"Shades of Gray",
	"Tequila Sunrise",
	"Atomic",
	"Warp",
	"ECola",
	"Space Ranger",
	"Ying Yang",
	"Bullseye",
	"Lizard",
	"Dragon",
	"Extra Terrestrial",
	"Goat",
	"Smiley",
	"Possessed",
	"Demon",
	"Infected",
	"Alien",
	"Undead",
	"Zombie"
}

RegisterNetEvent("esx_giveid:GiveIdToPlayer")
AddEventHandler("esx_giveid:GiveIdToPlayer", function(targetPlayer)
    local requestingPly = source
    local characterInfo = GetCharacterInfo(source)
    if characterInfo then
        TriggerClientEvent("esx_giveid:GiveIdResponse", requestingPly, GetPlayerName(targetPlayer))
        TriggerClientEvent("esx_giveid:DisplayPlayerId", targetPlayer, characterInfo, requestingPly)
    else
        TriggerClientEvent("esx_giveid:GiveIdResponse", requestingPly, false)
        TriggerClientEvent("esx_giveid:DisplayPlayerId", targetPlayer, false, false)
    end
end)

function GetCharacterInfo(source)
	local result = MySQL.Sync.fetchAll('SELECT firstname, lastname, dateofbirth, sex FROM users WHERE identifier = @identifier', {
		['@identifier'] = GetPlayerIdentifiers(source)[1]
	})
	if result[1] and result[1].firstname and result[1].lastname and result[1].dateofbirth and result[1].sex then
		--if result[1].skin ~= nil then
		--	local playerSkin = json.decode(result[1].skin)
		--	local eyeColor = eyeColours[playerSkin["eye_color"] + 1]
		--end
		--local feet, inches = tostring(result[1].height / 30.48):match("([^.]+).([^.]+)")
		--local properinches = math.ceil((tonumber(string.sub(inches, 1, 2)) / 100) * 12)
		local gender = ""
		if result[1].sex == "M" then
			gender = "Male"
		elseif result[1].sex == "F" then
			gender = "Female"
		end
		--return ("Name: %s %s\nDOB: %s\nGender: %s\nEye Color: %s"):format(result[1].firstname, result[1].lastname, result[1].dateofbirth, gender, eyeColor)
		return ("Name: %s %s\nDOB: %s\nGender: %s"):format(result[1].firstname, result[1].lastname, result[1].dateofbirth, gender)
	else
		return GetPlayerName(source)
	end
end