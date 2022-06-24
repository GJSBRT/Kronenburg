function AddTExtEntry(key, value)
    Citizen.InvokeNative(GetHashKey("ADD_TEXT_ENTRY"), key, value)
end

Citizen.CreateThread(function()
    AddTextEntry('0xFDF78B5D', 'Mobile Intensive Care Unit (MICU)')
end)