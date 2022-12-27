--[[ 
	Kronenburg Roleplay
	Copyright © GJSBRT <g@gijs.eu>

	This project is licensed under the terms of the Apache License 2.0 license.
	https://choosealicense.com/licenses/apache-2.0/
]]
 
 
laadbalk = function(text, time)
    SendNUIMessage({
        action = 'open',
        label = text,
        time = time
    })
end

laadbalksluit = function()
    SendNUIMessage({
        action = 'close'
    })
end