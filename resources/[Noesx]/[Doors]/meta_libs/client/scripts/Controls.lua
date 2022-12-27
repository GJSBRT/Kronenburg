--[[ 
	Kronenburg Roleplay
	Copyright © GJSBRT <g@gijs.eu>

	This project is licensed under the terms of the Apache License 2.0 license.
	https://choosealicense.com/licenses/apache-2.0/
]]
 
 
GetKeyHeld = function(key)
  return (IsControlPressed(0,key) or IsDisabledControlPressed(0,key))
end

GetKeyDown = function(key)
  return (IsControlJustPressed(0,key) or IsDisabledControlJustPressed(0,key))
end

GetKeyUp = function(key)
  return (IsControlJustReleased(0,key) or IsDisabledControlJustReleased(0,key))
end

exports("GetKeyHeld",GetKeyHeld)
exports("GetKeyDown",GetKeyDown)
exports("GetKeyUp",GetKeyUp)