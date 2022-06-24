RegisterCommand('togglehud', function(source, args)
	if not args then 
		TriggerClientEvent('chatMessage', source, "Systeem:", {255, 0, 0}, "/togglehud [aan/uit]") 
	else
	local a = tostring(args[1])
		if a == "uit" then
			TriggerClientEvent('ui:toggle', source,false)
		elseif a == "aan" then
			TriggerClientEvent('ui:toggle', source,true)
		else
			TriggerClientEvent('chatMessage', source, "Systeem:", {255, 0, 0}, "/togglehud [aan/uit]") 
		end
	end
end)

RegisterCommand("gtahud", function (source, args)
	TriggerClientEvent('ui:gtatoggle', source)
end)