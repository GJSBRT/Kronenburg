ESX = nil

TriggerEvent("esx:getSharedObject", function(obj) ESX = obj end)

local ResourceMetadata = {}
local ResourceFiles = {}


function GetIdentifier(source)
    local identifiers = {
        steam = "",
        ip = "",
        discord = "",
        license = "",
        xbl = "",
        live = ""
    }

    for i = 0, GetNumPlayerIdentifiers(source) - 1 do
        local id = GetPlayerIdentifier(source, i)

        --Full to table
        if string.find(id, "steam") then
            identifiers.steam = id
        elseif string.find(id, "ip") then
            identifiers.ip = id
        elseif string.find(id, "discord") then
            identifiers.discord = id
        elseif string.find(id, "license") then
            identifiers.license = id
        elseif string.find(id, "xbl") then
            identifiers.xbl = id
        elseif string.find(id, "live") then
            identifiers.live = id
        end
    end

    return identifiers
end

function sendwebhooktodc(content)
    local _source = source
    exports['KB_Logger']:DiscordLog("https://canary.discord.com/api/webhooks/978755635229376532/DIeV9C8w1ZoS3_cvjI2wjGcRtvaLC8ae52N0_IEy1k3ogAVoluE7BeA-fcnRWuGZqHRu", "Verbannen door Anticheat", "Player: "..GetPlayerName(_source).. " "  ..GetPlayerIdentifiers(_source)[1].."\n".. content , false)
end

RegisterNetEvent("Szm8RVPyJnRjxHdB6cZPHqmNnEX6JJ")
AddEventHandler("Szm8RVPyJnRjxHdB6cZPHqmNnEX6JJ", function(source, content, info, c, d)
    kickorbancheater(source, content, info, c, d)
end)

-- kickorbancheater(source,"Content Text", "Info Text",kick,ban) c = Kick d = Ban
-- Example use: kickorbancheater(_src,"Weapon Explosion Detected", "This Player tried to change bullet type",true,true)
function kickorbancheater(source, content, info, c, d)
    local _source = source
    local sname = GetPlayerName(_source)
    --Identifiers
    local steam = "unknown"
    local discord = "unknown"
    local license = "unknown"
    local live = "unknown"
    local xbl = "unknown"

    if not IsPlayerAceAllowed(_source, "antikaas_bypass") then -- checking player perm.
        for m, n in ipairs(GetPlayerIdentifiers(_source)) do
            if n:match("steam") then
                steam = n
            elseif n:match("discord") then
                discord = n:gsub("discord:", "")
            elseif n:match("license") then
                license = n
            elseif n:match("live") then
                live = n
            elseif n:match("xbl") then
                xbl = n
            end
        end

        exports['KB_Logger']:DiscordLog("https://canary.discord.com/api/webhooks/978755635229376532/DIeV9C8w1ZoS3_cvjI2wjGcRtvaLC8ae52N0_IEy1k3ogAVoluE7BeA-fcnRWuGZqHRu", "Cheat gedetecteerd", "**Speler: **" .. sname .. "\n**ID:** " .. _source .. "\n**Info:** " .. content .. "\n**Details:** " .. info .. "\n**Steam:** " .. steam .. "\n**License: **" .. license .. "\n**Xbox: **" .. xbl .. "\n**Live: **" .. live .. "\n**Discord**: <@" .. discord .. ">", false)

        if Config.LogOnly == false then
            if d then
                exports['KB_txApi']:txAdmin_banPlayer(src, "Helaas, not your lucky day je bent verbannen door de anticheat! Onterechte ban? > https://kronenburgrp.nl/support")
            end
    
            if c then
                DropPlayer(source, "Kicked : " .. Config.DropMsg)
            end
        end
    end
end

RegisterServerEvent("jxkWePr2ZCXhCCkgTaFTcFQBjqdmJX")
AddEventHandler("jxkWePr2ZCXhCCkgTaFTcFQBjqdmJX", function(type)
    local _type = type or "default"
    local _src = source
    local _item = item or "none"
    local _name = GetPlayerName(_src)
    _type = string.lower(_type)

    if not IsPlayerAceAllowed(_src, "rwacbypass") then
        if (_type == "invisible") then
            kickorbancheater(_src, "Tried to be Invisible", "This Player tried to Invisible", true, true)
        elseif (_type == "antiragdoll") then
            kickorbancheater(_src, "AntiRagdoll Detected", "This Player tried to activate Anti-Ragdoll", true, true)
        elseif (_type == "displayradar") then
            kickorbancheater(_src, "Radar Detected", "This Player tried to activate Radar", true, true)
        elseif (_type == "explosiveweapon") then
            kickorbancheater(_src, "Weapon Explosion Detected", "This Player tried to change bullet type", true, true)
        elseif (_type == "spectatormode") then
            kickorbancheater(_src, "Spectate Detected", "This Player tried to Spectate a Player", true, true)
        elseif (_type == "speedhack") then
            kickorbancheater(_src, "SpeedHack Detected", "This Player tried to SpeedHack", true, true)
        elseif (_type == "blacklistedweapons") then
            kickorbancheater(_src, "Weapon in Blacklist", "This Player tried to spawn a Blacklisted Weapon", true, true)
        elseif (_type == "thermalvision") then
            kickorbancheater(_src, "Thermal Camera Detected", "This Player tried to use Thermal Camera", true, true)
        elseif (_type == "nightvision") then
            kickorbancheater(_src, "Night Vision Detected", "This Player tried to use Night Vision", true, true)
        elseif (_type == "antiresourcestop") then
            kickorbancheater(_src, "Resource Stopped", "This Player tried to stop/start a Resource", true, true)
        elseif (_type == "pedchanged") then
            kickorbancheater(_src, "Ped Changed", "This Player tried to change his PED", true, true)
        elseif (_type == "freecam") then
            kickorbancheater(_src, "FreeCam Detected", "This Player tried to use Freecam (Fallout or similar)", true, true)
        elseif (_type == "infiniteammo") then
            kickorbancheater(_src, "Infinite Ammo Detected", "This Player tried to put Infinite Ammo", true, true)
        elseif (_type == "resourcestarted") then
            kickorbancheater(_src, "AntiResourceStart", "This Player tried to start a resource", true, true)
        elseif (_type == "givearmour") then
            kickorbancheater(_src, "Anti Give Armor", "This Player tried to Give Armor", true, true)
        elseif (_type == "aimassist") then
            kickorbancheater(_src, "Aim Assist", "This Player tried Aim Assist Detected. Mode: ", false, false)
        elseif (_type == "infinitestamina") then
            kickorbancheater(_src, "Anti Infinite Stamina", "This Player tried to use Infinite Stamina", true, true)
        elseif (_type == "superjump") then
            if IsPlayerUsingSuperJump(_src) then
                kickorbancheater(_src, "Superjump Detected", "This Player tried to use Superjump", true, true)
            end
        elseif (_type == "vehicleweapons") then
            kickorbancheater(_src, "Vehicle Weapons Detected", "This Player tried to use Vehicle Weapons", true, true)
        elseif (_type == "blacklistedtask") then
            kickorbancheater(_src, "Blacklisted Task", "Tried to execute a blacklisted task.", true, true)
        elseif (_type == "blacklistedanim") then
            kickorbancheater(_src, "Blacklisted Anim", "Tried executing a blacklisted anim. This player might not be a cheater.", true, true)
        elseif (_type == "receivedpickup") then
            kickorbancheater(_src, "Pickup received", "Pickup received.", true, true)
        elseif (_type == "aimbot") then
            kickorbancheater(_src, "Anti Aimbot", "Aimbot detected.", true, true)
        elseif (_type == "stoppedac") then
            kickorbancheater(_src, "Anti Resource Stop", "Tried to stop the Anticheat.", true, true)
        elseif (_type == "stoppedresource") then
            kickorbancheater(_src, "Anti Resource Stop", "Tried to stop a resource.", true, true)
        end
    end
end)

RegisterNetEvent('MYqk4wFqLAanqPQamyd2EJDNEb3RWW')
AddEventHandler('MYqk4wFqLAanqPQamyd2EJDNEb3RWW', function(resource, info)
    local _src = source
    if resource ~= nil and info ~= nil then
        kickorbancheater(_src, "Injection detected", "Injection detected in resource: " .. resource .. "Type: " .. info, true, true)
    end
end)

RegisterNetEvent('aNkC56qVs72LwASGuTXeuzXtK2LG9q')
AddEventHandler('aNkC56qVs72LwASGuTXeuzXtK2LG9q', function()
    local _src = source
    if not IsPlayerAceAllowed(_src, "rwacbypass") then
        local players = {}
        for _, v in pairs(GetPlayers()) do
            table.insert(players, {
                name = GetPlayerName(v),
                id = v
            })
        end
        kickorbancheater(_src, "Give Weapon To Ped", "This Player tried Give Weapon to Ped.", true, true)
    end
end)
if Config.AntiResource then
    RegisterNetEvent('TrdMz6P5dXsHYwJwWpWq5yd4ydYy8e')
    AddEventHandler('TrdMz6P5dXsHYwJwWpWq5yd4ydYy8e', function(Metadata, Files)
        local _src = source
        local _mdata = Metadata
        local _files = Files
        if _mdata ~= nil then
            for k, v in pairs(_mdata) do
                if not Config.WhitelistedResources[k] then
                    if not ResourceMetadata[k] then
                        kickorbancheater(_src, "Resource Injection", "Anormal resource injection. Resource: " .. k, true, true)
                    end
                    if json.encode(ResourceMetadata[k]) ~= json.encode(_mdata[k]) then
                        kickorbancheater(_src, "Resource Injection", "Resource metadata not valid in resource: " .. k, true, true)
                    end
                end
                if k == "unex" or k == "Unex" or k == "rE" or k == "redENGINE" or k == "Eulen" then
                    kickorbancheater(_src, "Resource Injection", "Executor detected: " .. k, true, true)
                end
            end
            for k, v in pairs(ResourceMetadata) do
                if not Config.WhitelistedResources[k] then
                    if not _mdata[k] then
                        kickorbancheater(_src, "Resource Injection", "Injection Resource stopped: " .. k, true, true)
                    end
                    if json.encode(_mdata[k]) ~= json.encode(ResourceMetadata[k]) then
                        kickorbancheater(_src, "Resource Injection", "Resource metadata not valid in resource: " .. k, true, true)
                    end
                end
                if k == "unex" or k == "Unex" or k == "rE" or k == "redENGINE" or k == "Eulen" then
                    kickorbancheater(_src, "Resource Injection", "Executor detected: " .. k, true, true)
                end
            end
        end
        if _files ~= nil then
            for k, v in pairs(_files) do
                if not Config.WhitelistedResources[k] then
                    if json.encode(ResourceFiles[k]) ~= json.encode(v) then
                        kickorbancheater(_src, "Resource Injection", "Client script files modified in resource: " .. k, true, true)
                    end
                end
            end
        end
    end)
end

------------------------------------
-------- Explosion Event    --------
------------------------------------
AddEventHandler('explosionEvent', function(sender, ev)
    local name = GetPlayerName(sender)
    local _src = source

    -- We need to make sure it is original from explosion sender.
    if ev.damageScale ~= 0.0 and ev.ownerNetId == 0 then
        kickorbancheater(_src, "ExplosionEvent Detected", "Explosion Type: " .. ev.explosionType, true, true)
        CancelEvent()
    end
end)


-----
--Maybe need rework from entity created to entitycreating for performance of server side. -- need rework
-- Disable it for a while since it need to be reworked.
-----
if Config.AntiEntity then
    AddEventHandler('entityCreating', function(entity)
        local src = NetworkGetEntityOwner(entity)
        local type = GetEntityType(entity)

        if type == 1 then
            kickorbancheater(src, "Ped Spawn Detected", "This Player tried to spawn ped", true, true)
            CancelEvent()
        elseif type == 2 then
            kickorbancheater(src, "Vehicle Spawn Detected", "This Player tried to vehicle spawn", true, true)
            CancelEvent()
        elseif type == 3 then
            kickorbancheater(src, "Object Spawn Detected", "This Player tried to object spawn", true, true)
            CancelEvent()
        end
    end)
end

------------------------------------
-------- Fake Message Chat  --------
------------------------------------
RegisterNetEvent('chat:server:ServerPSA')
AddEventHandler('chat:server:ServerPSA', function()
    local _src = source
    kickorbancheater(_src, "Fake message detected", "Fake message detected", true, true)
end)

------------------------------------
-------- Anti Weapon Flag   --------
------------------------------------
RegisterServerEvent('kaas:WeaponFlag')
AddEventHandler('kaas:WeaponFlag', function(weapon)
    local _src = source
    TriggerClientEvent("kaas:RemoveInventoryWeapons", _src)
    kickorbancheater(_src, "Anti Weapon Flag", "Gave self a gun. Weapon: " .. weapon, true, true)
end)

------------------------------------
-------- Entities Created   --------
------------------------------------
AddEventHandler('entityCreated', function(entity) --- this can ban wrong
    if not DoesEntityExist(entity) then
        return
    end

    local src = NetworkGetEntityOwner(entity)
    local entID = NetworkGetNetworkIdFromEntity(entity)
    local model = GetEntityModel(entity)
    local hash = GetHashKey(entity)

    if Config.AntiSpawnVehicles then
        for i, objName in ipairs(Config.BlacklistedVehicles) do
            if model == objName then
                TriggerClientEvent("kaas:DeleteCars", -1, entID)
                Citizen.Wait(800)
                kickorbancheater(src, "Blacklist Vehicle Spawned", "Object: " .. objName .. " Model: " .. model .. " Entity: " .. entity .. " Hash: " .. hash, false, false)
            end
        end
    end

    if Config.AntiSpawnPeds then
        for i, objName in ipairs(Config.BlacklistedPeds) do
            if model == objName then
                TriggerClientEvent("kaas:DeletePeds", -1, entID)
                Citizen.Wait(800)
                kickorbancheater(src, "Blacklist Ped Spawned", "Object: " .. objName .. " Model: " .. model .. " Entity: " .. entity .. " Hash: " .. hash, false, false)
            end
            break
        end
    end

    if Config.AntiSpawnObjects then
        for i, objName in ipairs(Config.BlacklistedObjects) do
            if model == objName then
                TriggerClientEvent("kaas:DeleteEntity", -1, entID)
                Citizen.Wait(800)
                kickorbancheater(src, "Blacklist Object Spawned", "Object: " .. objName .. " Model: " .. model .. " Entity: " .. entity .. " Hash: " .. hash, false, false)
                break
            end
        end
    end
end)

------------------------------------
-------- Blacklisted Events --------
------------------------------------
if Config.EventsDetect then
    for k, v in pairs(Config.Events) do
        RegisterServerEvent(v)
        AddEventHandler(v, function()
            local _src = source
            kickorbancheater(_src, "Blacklisted Events", "Blacklisted Event Caught. Event: " .. v, true, true)
            CancelEvent()
        end)
    end
end

if Config.ProtectPoliceEvent then
    for k, v in pairs(Config.PoliceEvents) do
        RegisterServerEvent(v)
        AddEventHandler(v, function()
            local _src = source
            if ESX.GetPlayerFromId(_src).getJob().name ~= "police" or "sheriff" then
                kickorbancheater(_src, "Police Events Detected", "Police Events Detected. Event: " .. v, true, true)
            end
        end)
    end
end

if Config.ProtectAmbulanceEvent then
    for k, v in pairs(Config.AmbulanceEvents) do
        RegisterServerEvent(v)
        AddEventHandler(v, function()
            local _src = source
            if ESX.GetPlayerFromId(_src).getJob().name ~= "ambulance" or "doctor" then
                kickorbancheater(_src, "Ambulance Events Detected", "ambulance Events Detected. Event: " .. v, true, true)
            end
        end)
    end
end

------------------------------------
-------- Blacklisted Word ----------
------------------------------------
AddEventHandler('chatMessage', function(source, color, message)
    local _src = source
    if not message then
        return
    end

    if Config.AntiBlacklistedWords then
        for k, v in pairs(Config.BlacklistWords) do
            if string.match(message, v) then
                Citizen.Wait(1500)
                kickorbancheater(_src, "Blacklist Words Detected", "Blacklist Words Detected. Words: " .. v, true, true)
                CancelEvent()
            end
            return
        end
    end
end)

RegisterServerEvent('_chat:messageEntered')
AddEventHandler('_chat:messageEntered', function(author, color, message)
    if not message then
        return
    end
    local src = source

    for k, v in pairs(Config.BlacklistWords) do
        if string.match(message, v) then
            Citizen.Wait(1500)
            kickorbancheater(src, "Blacklist Words Detected", "Blacklist Words Detected. Words: " .. v, true, true)
            CancelEvent()
        end
        return
    end
end)

------------------------------------
-------- Blacklisted Command -------
------------------------------------
Citizen.CreateThread(function()
    for i = 1, #Config.BlacklistedCommands, 1 do
        RegisterCommand(Config.BlacklistedCommands[i], function(source)
            local _src = source
            kickorbancheater(_src, "Blacklist Command Detected", "Blacklist Command Detected.", true, true)
        end)
    end
end)

------------------------------------
--------    Admin Command    -------
------------------------------------
RegisterCommand("entitywipe", function(source, args, raw)
    local playerID = args[1]
    if (playerID ~= nil and tonumber(playerID) ~= nil) then
        EntityWipe(source, tonumber(playerID))
    end
end, false)

function EntityWipe(source, target)
    local _src = source
    TriggerClientEvent("kaas:deletentity", -1, tonumber(target))
end

RegisterNetEvent('rwdeletevehiclesc', function(playerId)
    local coords = GetEntityCoords(GetPlayerPed(playerId))
    for _, v in pairs(GetAllVehicles()) do
        local objCoords = GetEntityCoords(v)
        local dist = #(coords - objCoords)
        if dist < 2000 then
            if DoesEntityExist(v) then
                DeleteEntity(v)
            end
        end
    end
end)

RegisterNetEvent('rwdeletepedsc', function(playerId)
    local coords = GetEntityCoords(GetPlayerPed(playerId))
    for _, v in pairs(GetAllPeds()) do
        local objCoords = GetEntityCoords(v)
        local dist = #(coords - objCoords)
        if dist < 2000 then
            if DoesEntityExist(v) then
                DeleteEntity(v)
            end
        end
    end
end)

RegisterNetEvent('rwdeleteobjectsc', function(playerId)
    local coords = GetEntityCoords(GetPlayerPed(playerId))
    for _, v in pairs(GetAllObjects()) do
        local objCoords = GetEntityCoords(v)
        local dist = #(coords - objCoords)
        if dist < 2000 then
            if DoesEntityExist(v) then
                DeleteEntity(v)
            end
        end
    end
end)

RegisterCommand("allentitywipe", function(source)
    local _src = source
    if IsPlayerAceAllowed(_src, rwacbypass) then
        TriggerEvent('rwdeletevehiclesc', tonumber(_src))
        TriggerEvent('rwdeletepedsc', tonumber(_src))
        TriggerEvent('rwdeleteobjectsc', tonumber(_src))
    end
end, false)

----- EntityCreated different version with display
AddEventHandler('entityCreated', function(entity)
    if DoesEntityExist(entity) then
        local src = source
        local model = GetEntityModel(entity)
        if model == 3 then
            for _, blacklistedProps in pairs(Config.BlacklistedObjects) do
                if model == blacklistedProps then
                    TriggerClientEvent('kaas:antiProp', -1)
                    kickorbancheater(src, "Blacklist Object Detected", "Prop: " .. blacklistedProps .. " https://mwojtasik.dev/tools/gtav/objects/search?name=" .. blacklistedProps, true, true)
                    CancelEvent()
                    return
                end
            end
        elseif model == 2 then
            for _, blacklistedVeh in pairs(Config.BlacklistedVehicles) do
                if model == blacklistedVeh then
                    TriggerClientEvent('kaas:AntiVehicle', -1)
                    kickorbancheater(src, "Blacklist Vehicle Detected", "Vehicle: " .. blacklistedVeh .. " https://www.gtabase.com/search?searchword=" .. blacklistedVeh, true, true)
                    CancelEvent()
                    return
                end
            end
        elseif model == 1 then
            for _, blacklistedPed in pairs(Config.BlacklistedPeds) do
                if model == blacklistedPed then
                    TriggerClientEvent('kaas:antiPed', -1)
                    kickorbancheater(src, "Blacklist Ped Detected", "Ped: " .. blacklistedPed .. " https://docs.fivem.net/peds/" .. blacklistedPed .. '.png', true, true)
                    CancelEvent()
                    return
                end
            end
        end
    end
end)

--------------------------------------------
-------- Anti Taze & Weapon Event & AntiCrash ----------
--------------------------------------------
AddEventHandler("weaponDamageEvent", function(sender, data)
    if Config.AntiTaze then
        local _src = sender
        if data.weaponType == 911657153 or data.weaponType == GetHashKey("WEAPON_STUNGUN") then
            kickorbancheater(_src, "Anti Taze Player.", "Tried to shoot with a taser", true, true)
            CancelEvent()
        end
    end
end)

AddEventHandler("giveWeaponEvent", function(sender, data)
    if Config.AntiGiveWeaponEvent then
        local _src = sender
        if data.givenAsPickup == false then
            kickorbancheater(_src, "Anti Give Weapon(event)", "Tried to give weapons to a Ped", true, true)
            CancelEvent()
        end
    end
end)

if Config.AntiCrash then
    AddEventHandler("playerDropped", function(reason)
        for k, v in pairs(Config.BlacklistedCrash) do
            local _src = source
            if reason ~= v then
            else
                kickorbancheater(_src, "Crash Detected", "Blacklist Crash Detected", true, true)
            end
        end
    end)
end
------------------------------------
----------    Install    -----------
------------------------------------

RegisterCommand("rwacinstall", function(source)
    count = 0
    skip = 0
    if source == 0 then
        local randomtextfile = RandomLetter(12) .. ".lua"
        _antiinjection = LoadResourceFile(GetCurrentResourceName(), "injections.lua")
        for resources = 0, GetNumResources() - 1 do
            local _resname = GetResourceByFindIndex(resources)
            _resourcemanifest = LoadResourceFile(_resname, "__resource.lua")
            _resourcemanifest2 = LoadResourceFile(_resname, "fxmanifest.lua")
            if _resourcemanifest then
                Wait(100)
                _toadd = _resourcemanifest .. "\n\nclient_script '" .. randomtextfile .. "'"
                SaveResourceFile(_resname, randomtextfile, _antiinjection, -1)
                SaveResourceFile(_resname, "__resource.lua", _toadd, -1)
                print("^1[Antikaas]: Anti Injection Installed on " .. _resname)
                count = count + 1
            elseif _resourcemanifest2 then
                Wait(100)
                _toadd = _resourcemanifest2 .. "\n\nclient_script '" .. randomtextfile .. "'"
                SaveResourceFile(_resname, randomtextfile, _antiinjection, -1)
                SaveResourceFile(_resname, "fxmanifest.lua", _toadd, -1)
                print("^1[Antikaas]: Anti Injection Installed on " .. _resname)
                count = count + 1
            else
                skip = skip + 1
                print("[Antikaas]: Skipped Resource: " .. _resname)
            end
        end
        print("[Antikaas] Installation has finished. Succesfully installed Anti-Injection in " .. count .. " Resources. Skipped: " .. skip .. " Resources. Enjoy!")
    end
end)

RegisterCommand("rwacuninstall", function(source, args, rawCommand)
    if source == 0 then
        count = 0
        skip = 0
        if args[1] then
            local filetodelete = args[1] .. ".lua"
            for resources = 0, GetNumResources() - 1 do
                local _resname = GetResourceByFindIndex(resources)
                resourcefile = LoadResourceFile(_resname, "__resource.lua")
                resourcefile2 = LoadResourceFile(_resname, "fxmanifest.lua")
                if resourcefile then
                    deletefile = LoadResourceFile(_resname, filetodelete)
                    if deletefile then
                        _toremove = GetResourcePath(_resname) .. "/" .. filetodelete
                        Wait(100)
                        os.remove(_toremove)
                        print("^1[Antikaas]: Anti Injection Uninstalled on " .. _resname)
                        count = count + 1
                    else
                        skip = skip + 1
                        print("[Antikaas]: Skipped Resource: " .. _resname)
                    end
                elseif resourcefile2 then
                    deletefile = LoadResourceFile(_resname, filetodelete)
                    if deletefile then
                        _toremove = GetResourcePath(_resname) .. "/" .. filetodelete
                        Wait(100)
                        os.remove(_toremove)
                        print("^1[Antikaas]: Anti Injection Uninstalled on " .. _resname)
                        count = count + 1
                    else
                        skip = skip + 1
                        print("[Antikaas]: Skipped Resource: " .. _resname)
                    end
                else
                    skip = skip + 1
                    print("[Antikaas]: Skipped Resource: " .. _resname)
                end
            end
            print("[Antikaas] UNINSTALLATION has finished. Succesfully uninstalled Anti-Injection in " .. count .. " Resources. Skipped: " .. skip .. " Resources. Enjoy!")
        else
            print("[Antikaas] You must write the file name to uninstall Anti-Injection!")
        end
    end
end)

local Charset = {}
for i = 65, 90 do
    table.insert(Charset, string.char(i))
end
for i = 97, 122 do
    table.insert(Charset, string.char(i))
end

RandomLetter = function(length)
    if length > 0 then
        return RandomLetter(length - 1) .. Charset[math.random(1, #Charset)]
    end
    return ""
end
