--[[ 
	Kronenburg Roleplay
	Copyright © GJSBRT <g@gijs.eu>

	This project is licensed under the terms of the Apache License 2.0 license.
	https://choosealicense.com/licenses/apache-2.0/
]]
 
 
HelpNotification = function(msg)
  AddTextEntry('mLibsHelp', msg)
  BeginTextCommandDisplayHelp('mLibsHelp')
  EndTextCommandDisplayHelp(0, false, true, -1)
end

ShowNotification = function(msg)
  AddTextEntry('mLibsNotify', msg)
  SetNotificationTextEntry('mLibsNotify')
  DrawNotification(false, true)
end

exports('ShowNotification',ShowNotification)
exports('HelpNotification',HelpNotification)