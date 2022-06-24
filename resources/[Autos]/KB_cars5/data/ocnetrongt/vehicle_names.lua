function AddTextEntry(key, value)
	Citizen.InvokeNative(GetHashKey("ADD_TEXT_ENTRY"), key, value)
end

Citizen.CreateThread(function()
	AddTextEntry('0x206DD983', 'e-tron GT')
	AddTextEntry('0x406DC176', 'Audi')
end)