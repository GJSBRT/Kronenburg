local staff = {}

-- Run this when a user enters a message in chat
AddEventHandler('chatMessage', function(source, name, msg)
	-- Sets variable 'player' to the players SteamId
	player = GetPlayerIdentifiers(source)[1]
	-- Fetches all rows from the database table 'users' where the column 'identifier' equals the players SteamId
	local result = MySQL.Sync.fetchAll(
	  'SELECT * FROM users WHERE identifier = @identifier',
	  {
		['@identifier'] = player
	  }
	)
	-- Loops through the result and allows you to call from the database results
	for i=1, #result, 1 do
	
		-- Variable sm is an array of the entered message where each entry is the next word after a space.
		local sm = stringsplit(msg, " ");
		-- If the first entry in variable sm is /sc do the following
		if sm[1] == "/sc" then
			-- If the count (#) of table staff is zero there is no staff and you are not staff therefore you cannot use this.
			if #staff == 0 then
				 TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "Insufficient Permissions!")
			-- If there is an entry in table staff do the following
			else
				-- If the resulted user is a admin then do the following
				if result[i].group == 'admin' then
					-- Loop through the table staff
					for _,id in ipairs(staff) do
						-- Sent a chat message to all id's in the table staff with the prefix "**STAFF**" and the message minus the first 4 characters (being '/sc ')
						TriggerClientEvent('chatMessage', id, "**STAFF** | "..name, {255, 0, 125}, string.sub(msg,4))
						CancelEvent()
					end
				-- If the resulted user is not a superadmin then do the following
				else
					TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "Insufficient Permissions!")
				end
			end
		end
	end
end)


-- Client triggers this event after they load in correctly

RegisterServerEvent('properload')
AddEventHandler('properload', function()
	-- Sets variable 'id' to the source 'id'
	local id = source
	-- Sets variable 'player' to the players SteamId
	local player = GetPlayerIdentifiers(id)[1]
	-- Fetches all rows from the database table 'users' where the column 'identifier' equals the players SteamId
	local result = MySQL.Sync.fetchAll(
	  'SELECT * FROM users WHERE identifier = @identifier',
	  {
		['@identifier'] = player
	  }
	)
	
	-- Loops through the results and if the users column 'group' equals superadmin it inserts the users id into the table 'staff'
	for i=1, #result, 1 do
		if result[i].group == 'admin' then
			table.insert(staff, id)
		end
	end
end)


-- RANDOM FUNCTION TO SPLIT STRINGS


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