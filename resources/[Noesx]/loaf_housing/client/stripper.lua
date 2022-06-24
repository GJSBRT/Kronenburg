CreateThread(function()
    while not NetworkIsSessionStarted() do
        Wait(250)
    end

    if Config.Options and Config.Options.Stripper and Config.Options.Stripper.Enabled then
        if Config.Options.Stripper.PoleDancing then
            CreateThread(function()
                while true do
                    Wait(1000)

                    while Cache.inshell do
                        Wait(500)

                        local stripping_pole = GetClosestObjectOfType(GetEntityCoords(PlayerPedId()), 2.0, GetHashKey("prop_strip_pole_01"), false, false, false)

                        if DoesEntityExist(stripping_pole) then
                            while #(GetEntityCoords(PlayerPedId()) - GetEntityCoords(stripping_pole)) <= 1.5 do
                                Wait(0)
                                DrawTxt3D(GetEntityCoords(stripping_pole) + vector3(0.0, 0.0, 1.0), Strings["pole_dance"])
                                if IsControlJustReleased(0, 51) then
                                    local dance = GetOffsetFromEntityInWorldCoords(stripping_pole, 0.0, 0.3, 1.0)
                                    local randomdance = tostring(math.random(1, 3))
                                    local scene = NetworkCreateSynchronisedScene(dance, vector3(0.0, 0.0, 0.0), 2, false, true, 1065353216, 0, 1.3)
                                    NetworkAddPedToSynchronisedScene(PlayerPedId(), scene, LoadDict("mini@strip_club@pole_dance@pole_dance" .. randomdance), "pd_dance_0" .. randomdance, 1.5, -4.0, 1, 1, 1148846080, 0)
                                    NetworkStartSynchronisedScene(scene)
                
                                    while true do
                                        Wait(0)
                                        
                                        HelpText(Strings["stop_dancing"], true)
                                        if IsControlJustReleased(0, 73) or IsDisabledControlJustReleased(0, 73) then
                                            break
                                        end
                                    end
                    
                                    NetworkStopSynchronisedScene(scene)
                                end
                            end
                        end

                    end
                end
            end)
        end

        if Config.Options.Stripper.LapDance then
            CreateThread(function()
                while true do
                    Wait(1000)

                    while Cache.inshell do
                        Wait(500)
                        local chair = GetClosestObjectOfType(GetEntityCoords(PlayerPedId()), 2.0, GetHashKey("apa_mp_h_stn_chairarm_01"), false, false, false)

                        if DoesEntityExist(chair) then
                            while #(GetEntityCoords(PlayerPedId()) - GetEntityCoords(chair)) <= 2.0 do
                                Wait(0)
                                DrawTxt3D(GetEntityCoords(chair) + vector3(0.0, 0.0, 1.0), Strings["lap_dance"])
                                if IsControlJustReleased(0, 51) then
                                    local dance_offset = GetOffsetFromEntityInWorldCoords(chair, 0.0, -1.25, 1.0)
                                    
                                    local scene = NetworkCreateSynchronisedScene(dance_offset, vector3(0.0, 0.0, GetEntityHeading(chair)), 2, false, true, 1065353216, 0, 1.3)
                                    NetworkAddPedToSynchronisedScene(PlayerPedId(), scene, LoadDict("mini@strip_club@private_dance@part2"), "priv_dance_p2", 1.5, -4.0, 1, 1, 1148846080, 0)
                                    NetworkStartSynchronisedScene(scene)

                                    while true do
                                        Wait(0)
                                        
                                        HelpText(Strings["stop_dancing"], true)
                                        if IsControlJustReleased(0, 73) or IsDisabledControlJustReleased(0, 73) then
                                            break
                                        end
                                    end
                    
                                    NetworkStopSynchronisedScene(scene)
                                elseif IsControlJustReleased(0, 75) then
                                    local sit_offset = GetOffsetFromEntityInWorldCoords(chair, 0.0, -0.25, 0.6)

                                    local heading = GetEntityHeading(chair)
                                    if heading >= 180.0 then
                                        heading = heading - 179.9
                                    else
                                        heading = heading + 179.9
                                    end

                                    local scene = NetworkCreateSynchronisedScene(sit_offset, vector3(0.0, 0.0, heading), 2, false, true, 1065353216, 0, 1.3)
                                    NetworkAddPedToSynchronisedScene(PlayerPedId(), scene, LoadDict("mini@strip_club@lap_dance_2g@ld_2g_reach"), "ld_2g_sit_idle", 1.5, -4.0, 1, 1, 1148846080, 0)
                                    NetworkStartSynchronisedScene(scene)

                                    while true do
                                        Wait(0)
                                        
                                        HelpText(Strings["stop_dancing"], true)
                                        if IsControlJustReleased(0, 73) or IsDisabledControlJustReleased(0, 73) then
                                            break
                                        end
                                    end
                    
                                    NetworkStopSynchronisedScene(scene)
                                end
                            end
                        end

                    end
                end
            end)
        end
    end
end)

LoadDict = function(Dict)
    while not HasAnimDictLoaded(Dict) do 
        Wait(0)
        RequestAnimDict(Dict)
    end

    return Dict
end