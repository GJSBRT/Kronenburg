LockPick = function(houseid)
    local housedata = Config.Houses[houseid]

    if Config.LockPicking and Config.LockPicking.Enabled and housedata and Config.LockPicking.RequiredPicks[housedata.ShellType] then
        local toreturn = nil
        ESX.TriggerServerCallback("loaf_housing:getCops", function(police)
            if police >= (Config.LockPicking.MinimumPolice or 0) then
                local locks = {}

                for i = 1, Config.LockPicking.RequiredPicks[housedata.ShellType] do
                    table.insert(locks, {"lock_closed", math.random(0, 359)})
                end
        
                local lockpicks, refresh_lockpicks = 0, 0
                for k, v in pairs(ESX.GetPlayerData().inventory) do
                    if v.name == "lockpick" then
                        lockpicks = v.count
                        break
                    end
                end
        
                local rotation, lockStart = 0.0, 0.5
                for i = 1, math.floor(#locks/2) do
                    lockStart = lockStart - 0.02375
                end
        
                RequestAmbientAudioBank("SAFE_CRACK")
                local currentLock, nextAudio = 1, 0
        
                if lockpicks > 0 then
                    local dict, anim = "missheistfbisetup1", "hassle_intro_loop_f"
                    while not HasAnimDictLoaded(dict) do 
                        Wait(0)
                        RequestAnimDict(dict)
                    end
            
                    TaskPlayAnim(PlayerPedId(), dict, anim, 8.0, -8.0, -1, 1, 0, false, false, false)
                    
                    while true do
                        Wait(0)
        
                        if refresh_lockpicks <= GetGameTimer() then
                            for k, v in pairs(ESX.GetPlayerData().inventory) do
                                if v.name == "lockpick" then
                                    lockpicks = v.count
                                    break
                                end
                            end
                            refresh_lockpicks = GetGameTimer() + 1000
                        end
        
                        local aspect_ratio = GetAspectRatio(true)
        
                        while not HasStreamedTextureDictLoaded("MPSafeCracking") do
                            Wait(5)
                            RequestStreamedTextureDict("MPSafeCracking", true)
                        end
        
                        DrawSprite("MPSafeCracking", "Dial_BG", 0.5, 0.3, 0.3, aspect_ratio * 0.3, 0, 255, 255, 255, 255)
                        DrawSprite("MPSafeCracking", "Dial", 0.5, 0.3, 0.3 * 0.5, 0.3 * aspect_ratio * 0.5, rotation, 255, 255, 255, 255)
                        
                        local offset = 0.0
                        for k, v in pairs(locks) do
                            DrawSprite("MPSafeCracking", v[1], lockStart + offset, 0.1, 0.03, aspect_ratio * 0.025, 0, 255, 255, 255, 255)
                            offset = offset + 0.025
                        end
        
                        local speed = 0.5
                        if math.abs(locks[currentLock][2] - rotation) <= 15.0 then
                            speed = 0.3
                        end
        
                        HelpText(string.format(Strings["lockpicking"], lockpicks), false)
        
                        if IsControlPressed(0, 175) or IsControlPressed(0, 174) then
                            if nextAudio <= GetGameTimer() then
                                PlaySoundFrontend(0, "TUMBLER_TURN", "SAFE_CRACK_SOUNDSET", 1)
                                nextAudio = GetGameTimer() + 100
                            end
                            if IsControlPressed(0, 175) then
                                if rotation <= 0.0 then rotation = 360.0 end
                                rotation = rotation - speed
                            elseif IsControlPressed(0, 174) then
                                rotation = rotation + speed
                                if rotation >= 360.0 then rotation = 0.0 end
                            end 
                        end
        
                        if IsControlJustPressed(0, 191) then
                            if math.abs(locks[currentLock][2] - rotation) <= 4.0 then
                                if locks[currentLock + 1] then
                                    locks[currentLock][1] = "lock_open"
                                    currentLock = currentLock + 1
                                    PlaySoundFrontend(0, "TUMBLER_PIN_FALL", "SAFE_CRACK_SOUNDSET", 1)
                                else
                                    toreturn = true
                                    return
                                end
                            else
                                PlaySoundFrontend(0, "TUMBLER_TURN", "SAFE_CRACK_SOUNDSET", 1)
                                lockpicks = lockpicks - 1
                                TriggerServerEvent("loaf_housing:removeLockpick")
                                if lockpicks <= 0 then
                                    ESX.ShowNotification(Strings["no_lockpicks"])
                                    toreturn = false
                                    return
                                end
                            end
                        elseif IsControlJustPressed(0, 194) then
                            toreturn = false
                            return
                        end
                    end
                else
                    ESX.ShowNotification(Strings["no_lockpicks"])
                    toreturn = false
                    return
                end
            else
                ESX.ShowNotification(Strings["not_enough_cops"])
                toreturn = false
                return
            end
        end)

        while toreturn == nil do Wait(250) end
        return toreturn
    else
        return false
    end
end