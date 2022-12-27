--[[ 
	Kronenburg Roleplay
	Copyright © GJSBRT <g@gijs.eu>

	This project is licensed under the terms of the Apache License 2.0 license.
	https://choosealicense.com/licenses/apache-2.0/
]]
 
 
Config = {
	roleList = {
		{981146692973903882, "group.serverbooster"},
		{900750584418795542, "group.serverbooster"}, -- Server booster
		{897747224665157635, "group.member"}, -- Burger
		{925533310053150840, "group.staff_mod"}, -- Moderator
		{925533484573917236, "group.staff_admin"}, -- Admin
		{935270859734671440, "group.staff_hoofdstaff"}, -- Hoofd Staff
		{935307683697930250, "group.admin"}, -- Management
		{935307683697930250, "group.admin"}, -- Hoofd Management
		{925532783688966215, "group.admin"}, -- Beheer
		{862138867926564904, "group.vliegbrevetje"}, -- VLIEGBREVET VOOR HELICIPOTTERSHOP
	},
}

function stringsplit(inputstr, sep)
    if sep == nil then
        sep = "%s"
    end
    local t={} ; i=1
    for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
        t[i] = str
        i = i + 1
    end
    return t
end
function ExtractIdentifiers(src)
    local identifiers = {
        steam = false,
        ip = "",
        discord = "",
        license = "",
        xbl = "",
        live = ""
    }

    --Loop over all identifiers
    for i = 0, GetNumPlayerIdentifiers(src) - 1 do
        local id = GetPlayerIdentifier(src, i)

        --Convert it to a nice table.
        if string.find(id, "steam") then
            identifiers.steam = id
        elseif string.find(id, "ip") then
            identifiers.ip = id
        elseif string.find(id, "discord") then
            identifiers.discord = id
        elseif string.find(id, "license") then
            identifiers.license = id
        elseif string.find(id, "xbl") then
            identifiers.xbl = id
        elseif string.find(id, "live") then
            identifiers.live = id
        end
    end

    return identifiers
end

DiscordDetector = {}
InDiscordDetector = {}
PermTracker = {}
roleList = Config.roleList;

AddEventHandler('playerDropped', function (reason) 
	local src = source;
	local discord = ExtractIdentifiers(src).discord:gsub("discord:", "");
	local license = ExtractIdentifiers(src).license;
	if PermTracker[discord] ~= nil then 
		-- They have perms that need to be removed:
		local list = PermTracker[discord];
		for i = 1, #list do 
			local permGroup = list[i];
			ExecuteCommand('remove_principal identifier.discord:' .. discord .. " " .. permGroup);
		end
		PermTracker[discord] = nil;
	end
	DiscordDetector[license] = nil;
end)
debugScript = false;

AddEventHandler('playerConnecting', function(name, setKickReason, deferrals)
	deferrals.defer();
	local src = source; 
	local identifierDiscord = "";
	local license = ExtractIdentifiers(src).license;

    if not ExtractIdentifiers(src).steam then
        print("[^3\x1b[1mWARN\x1b[0m^7] \x1b[46m\x1b[30m|Permissions|\x1b[0m\x1b[1m ^7"..name.."^3 could't connect because no steam account was found\x1b[0m^0")
        deferrals.done("Je hebt helaas geen Steam open staan! Open Steam om met Kronenburg te verbinden.")
    end

	local discord = ExtractIdentifiers(src).discord:gsub("discord:", "");
		for k, v in ipairs(GetPlayerIdentifiers(src)) do
				if string.sub(v, 1, string.len("discord:")) == "discord:" then
					identifierDiscord = v
				end
		end
		local permAdd = "add_principal identifier.discord:" .. discord .. " "
		if identifierDiscord then
				if debugScript then 
					print("Gets past identifierDiscord statement");
				end
				local roleIDs = exports.Badger_Discord_API:GetDiscordRoles(src)
				if debugScript then 
					print("Value of roleIDs == " .. tostring(roleIDs));
				end
				if not (roleIDs == false) then
					if debugScript then 
						print("Gets past (not [roleIDs == false]) statement");
					end
					for i = 1, #roleList do
						for j = 1, #roleIDs do
							if exports.Badger_Discord_API:CheckEqual(roleList[i][1], roleIDs[j]) then
								ExecuteCommand(permAdd .. roleList[i][2])
								print("[^2\x1b[1mINFO\x1b[0m^7] \x1b[46m\x1b[30m|Permissions|\x1b[0m\x1b[1m ^2Added ^7"..name.." ^2to ^7"..roleList[i][2].."\x1b[0m^0")
								-- Track the permission node given: 
								if PermTracker[discord] ~= nil then 
									-- Has them, we add to list 
									local list = PermTracker[discord];
									table.insert(list, roleList[i][2]);
									PermTracker[discord] = list;
								else 
									-- Doesn't have them, give them a list 
									local list = {};
									table.insert(list, roleList[i][2]);
									PermTracker[discord] = list;
								end
							end
						end
					end
				else
					if InDiscordDetector[license] == nil then 
						-- Notify them they are not in the Discord 
						InDiscordDetector[license] = true;
						local clicked = false;
						while not clicked do 
							deferrals.presentCard(card,
							function(data, rawData)
								if (data.submitId == 'played') then 
									clicked = true;
									deferrals.done()
								end
							end)
							Citizen.Wait((1000 * 13));
						end
						return;
					end
				end
		else 
			if DiscordDetector[license] == nil then 
				-- Kick with we couldn't find their discord, try to restart it whilst fivem is closed 
				DiscordDetector[license] = true;
				local clicked = false;
				while not clicked do 
					deferrals.presentCard(card,
					function(data, rawData)
						if (data.submitId == 'played') then 
							clicked = true;
							deferrals.done()
						end
					end)
					Citizen.Wait((1000 * 13));
				end
				return;
			end
		end
	deferrals.done();
end)
card = '{"type":"AdaptiveCard","$schema":"http://adaptivecards.io/schemas/adaptive-card.json","version":"1.2","body":[{"type":"Container","items":[{"type":"TextBlock","text":"Kronenburg Roleplay","wrap":true,"fontType":"Default","size":"ExtraLarge","weight":"Bolder","color":"Light"}],"style":"default","bleed":true,"height":"stretch","isVisible":true}]}'
