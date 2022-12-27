--[[ 
	Kronenburg Roleplay
	Copyright © GJSBRT <g@gijs.eu>

	This project is licensed under the terms of the Apache License 2.0 license.
	https://choosealicense.com/licenses/apache-2.0/
]]
 
 
lockpicking = {}
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj; end)

Citizen.CreateThread(function(...)
  while not ESX do
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj; end)
    Citizen.Wait(0)
  end
end)

lockpicking.Version = '1.0.11'

lockpicking.LockTolerance = 20.0
lockpicking.UsingLockpickItem = 1
lockpicking.TextureDict = "lockpicking"
lockpicking.AudioBank = "SAFE_CRACK"