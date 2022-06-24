function AddTExtEntry(key, value)
    Citizen.InvokeNative(GetHashKey("ADD_TEXT_ENTRY"), key, value)
end

Citizen.CreateThread(function()
    AddTextEntry('0x950B25E3', '1987 Ferrari F40')
    AddTextEntry('0x25878CFF', '1987 Ferrari F40')
end)