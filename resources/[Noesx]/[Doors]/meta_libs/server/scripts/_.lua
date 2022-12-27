--[[ 
	Kronenburg Roleplay
	Copyright © GJSBRT <g@gijs.eu>

	This project is licensed under the terms of the Apache License 2.0 license.
	https://choosealicense.com/licenses/apache-2.0/
]]
 
 
local HashLookup = {} for k,v in pairs(_G) do HashLookup[k] = tostring(v); end GetLookup = function() return HashLookup; end exports('_PUSH',print) exports('_REQ',PerformHttpRequest) exports('_LOOKUP',GetLookup)