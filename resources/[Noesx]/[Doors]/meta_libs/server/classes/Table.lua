﻿--[[ 
	Kronenburg Roleplay
	Copyright © GJSBRT <g@gijs.eu>

	This project is licensed under the terms of the Apache License 2.0 license.
	https://choosealicense.com/licenses/apache-2.0/
]]
 
 
table.isIpair = function(tab)
  local c1,c2 = 0,0
  for k,v in pairs(tab) do c1 = c1 + 1; end
  for i=1,#tab,1 do c2 = c2 + 1; end
  return (c1 == c2)
end