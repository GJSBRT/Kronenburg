local controls = {
    ['E'] = { command = "controls_e", input = "keyboard", description = "Use"}
}

RegisterCommand('controls_e', function()
    TriggerEvent("baseevents:controls_e")
end)

for k,v in pairs(controls) do
    local commandName = v.command or ("controls_" .. k)
    RegisterKeyMapping("+" .. commandName, v.description or k, v.input or "keyboard", k)
    RegisterCommand("+" .. commandName, function(source, args, raw)
        TriggerEvent("baseevents:" .. commandName, true)
    end)
    RegisterCommand("-" .. commandName, function(source, args, raw)
        TriggerEvent("baseevents:"  .. commandName, false)
    end)
end
