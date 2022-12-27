--[[ 
	Kronenburg Roleplay
	Copyright © GJSBRT <g@gijs.eu>

	This project is licensed under the terms of the Apache License 2.0 license.
	https://choosealicense.com/licenses/apache-2.0/
]]
 
 
GetIdentifier = function(source,identifier)
  for k,id in pairs(GetPlayerIdentifiers(source)) do
    if id:find(identifier) then
      return id
    end
  end
end

exports("GetIdentifier",GetIdentifier)