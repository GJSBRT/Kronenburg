EnterIKEA = function()
    DoScreenFadeOut(750)
    while not IsScreenFadedOut() do Wait(0) end

    local cam = CreateCam("DEFAULT_SCRIPTED_Camera", 1)
    SetCamCoord(cam, Config.IKEA.CameraPosition)
    PointCamAtCoord(cam, Config.IKEA.ShellPosition)
    RenderScriptCams(1, 0, 0, 1, 1)
    SetCamActive(cam, true) 
    SetCamFov(cam, 50.0)
    FreezeEntityPosition(PlayerPedId(), true)
    SetFocusPosAndVel(Config.IKEA.ShellPosition, 0.0, 0.0, 0.0)

    Wait(500)
    DoScreenFadeIn(1500)
    
    local CategoryID, FurnitureName, FurnitureID, fov = 1, Furniture.Categories[1][1], 1, 50.0
    local PressDelay = GetGameTimer()
    
    local Model = LoadModel(Furniture[FurnitureName][FurnitureID][2])
    local FurnitureObject = 0
    local FurnitureAttachments = {}
    if Model.loaded then
        FurnitureObject = CreateObject(Model.model, Config.IKEA.ShellPosition, false, false, false)
        SetEntityHeading(FurnitureObject, Config.IKEA.Heading)
    end

    local function recreateFurniture()
        if DoesEntityExist(FurnitureObject) then
            DeleteEntity(FurnitureObject)
        end
        for _, attached in pairs(FurnitureAttachments) do
            DeleteEntity(attached)
        end
        Model = LoadModel(Furniture[FurnitureName][FurnitureID][2])
        if Model.loaded then
            FurnitureObject = CreateObject(Model.model, Config.IKEA.ShellPosition, false, false, false)
            SetEntityHeading(FurnitureObject, Config.IKEA.Heading)
        end
        local attachments = Furniture[FurnitureName][FurnitureID][6]
        if attachments then
            for k, v in pairs(attachments) do
                local model = LoadModel(v.object)
                if model.loaded then
                    local attached = CreateObject(model.model, GetEntityCoords(FurnitureObject), false, true)
                    FreezeEntityPosition(attached, true)
                    table.insert(FurnitureAttachments, attached)
            
                    AttachEntityToEntity(attached, FurnitureObject, 0, v.offset.xyz, vector3(0.0, 0.0, v.offset.w), false, false, false, false, 2, true)
                end
            end
        end
    end

    while true do
        Wait(0)
        DisableAllControlActions(0)
        DisableAllControlActions(1)
        DisableAllControlActions(2)

        if Furniture[FurnitureName][FurnitureID][4] then
            HelpText(string.format(Strings["viewing_furniture"], Furniture.Categories[CategoryID][2], Strings["storage"], Furniture[FurnitureName][FurnitureID][1], Furniture[FurnitureName][FurnitureID][3]), false)
        else
            HelpText(string.format(Strings["viewing_furniture"], Furniture.Categories[CategoryID][2], "", Furniture[FurnitureName][FurnitureID][1], Furniture[FurnitureName][FurnitureID][3]), false)
        end
        if PressDelay <= GetGameTimer() then
            SetCamFov(cam, fov)
            local oldCategory, oldFurnitureId = CategoryID, FurnitureID
            -- categories
            if IsDisabledControlPressed(0, 299) then
                PressDelay = GetGameTimer() + 200
                if Furniture.Categories[CategoryID - 1] then
                    CategoryID = CategoryID - 1
                else
                    CategoryID = #Furniture.Categories
                end
            elseif IsDisabledControlPressed(0, 300) then
                PressDelay = GetGameTimer() + 200
                if Furniture.Categories[CategoryID + 1] then
                    CategoryID = CategoryID + 1
                else
                    CategoryID = 1
                end
            -- furniture / item
            elseif IsDisabledControlPressed(0, 308) then
                PressDelay = GetGameTimer() + 200
                if Furniture[FurnitureName][FurnitureID - 1] then
                    FurnitureID = FurnitureID - 1
                else
                    FurnitureID = #Furniture[FurnitureName]
                end
            elseif IsDisabledControlPressed(0, 307) then
                PressDelay = GetGameTimer() + 200
                if Furniture[FurnitureName][FurnitureID + 1] then
                    FurnitureID = FurnitureID + 1
                else
                    FurnitureID = 1
                end
            end
            -- rotate object
            if IsDisabledControlPressed(0, 34) then
                if DoesEntityExist(FurnitureObject) then
                    SetEntityHeading(FurnitureObject, GetEntityHeading(FurnitureObject) - 1.0)
                end
            elseif IsDisabledControlPressed(0, 35) then
                if DoesEntityExist(FurnitureObject) then
                    SetEntityHeading(FurnitureObject, GetEntityHeading(FurnitureObject) + 1.0)
                end
            end

            -- zoom camera
            if IsDisabledControlPressed(0, 32) and fov > 20.0 then
                fov = fov - 0.1
            elseif IsDisabledControlPressed(0, 33) and fov < 70.0 then
                fov = fov + 0.1
            end

            if CategoryID ~= oldCategory then
                FurnitureID = 1
                FurnitureName = Furniture.Categories[CategoryID][1]
                
                recreateFurniture()
            elseif FurnitureID ~= oldFurnitureId then
                recreateFurniture()
            end
        end

        -- buy / enter
        if IsDisabledControlJustReleased(0, 191) then
            while true do
                Wait(0)
                DisableAllControlActions(0)
                DisableAllControlActions(1)
                DisableAllControlActions(2)

                HelpText(string.format(Strings["confirm_purchase"], Furniture[FurnitureName][FurnitureID][1], Furniture[FurnitureName][FurnitureID][3]), false)
                if IsDisabledControlJustReleased(0, 191) then
                    local purchashed = false
                    AddTextEntry("PURCHASING", Strings["purchasing"])
                    BeginTextCommandBusyspinnerOn("PURCHASING")
                    EndTextCommandBusyspinnerOn(3)

                    ESX.TriggerServerCallback("loaf_housing:purchaseFurniture", function(success)
                        purchashed = true
                        if success then
                            ESX.ShowNotification(string.format(Strings["purchased"], Furniture[FurnitureName][FurnitureID][1], Furniture[FurnitureName][FurnitureID][3]))
                        end
                    end, FurnitureName, FurnitureID)
                    
                    while not purchashed do 
                        Wait(50) 
                    end
                    BusyspinnerOff()
                end

                if IsDisabledControlJustReleased(0, 194) then
                    break
                end
            end

            Wait(50)
        end

        -- exit / backspace
        if IsDisabledControlJustReleased(0, 194) then
            break
        end
    end

    FreezeEntityPosition(PlayerPedId(), false)

    DoScreenFadeOut(750)
    while not IsScreenFadedOut() do Wait(0) end

    ClearFocus()
    RenderScriptCams(false, false, 0, true, false)
    DestroyCam(cam)
    if DoesEntityExist(FurnitureObject) then
        DeleteEntity(FurnitureObject)
    end
    for _, attached in pairs(FurnitureAttachments) do
        DeleteEntity(attached)
    end
    Wait(500)
    DoScreenFadeIn(1500)
end

if Config.Options.FurnishCommand then
    RegisterCommand(Config.Options.FurnishCommand, function()
        if Cache.inshell and Cache.houseid ~= 0 then
            ESX.TriggerServerCallback("loaf_housing:getFurniture", function(furniture)
                local elements = {}
                for k, v in pairs(furniture) do
                    v.object = k
                    table.insert(elements, {
                        label = string.format(Strings["amount_furniture"], v.amount, v.label), data = v
                    })
                end

                ESX.UI.Menu.Open("default", GetCurrentResourceName(), "select_furniture_put", {
                    title = Strings["furnish"],
                    align = ((Config.Options and Config.Options.MenuAlign) or ("bottom-right")),
                    elements = elements
                }, function(data, menu)                    
                    Furnish(Cache.shell_object, data.current.data, tonumber(Cache.houseid))
                end, function(data, menu)
                    menu.close()
                end)
            end)
        else
            ESX.ShowNotification(Strings["not_in_house"])
        end
    end)
end

DrawEntityBox = function(entity, colour)
    local min, max = GetModelDimensions(GetEntityModel(entity))
    
    local pad = 0.001
    local box = {
        -- Bottom
        GetOffsetFromEntityInWorldCoords(entity, min.x - pad, min.y - pad, min.z - pad),
        GetOffsetFromEntityInWorldCoords(entity, max.x + pad, min.y - pad, min.z - pad),
        GetOffsetFromEntityInWorldCoords(entity, max.x + pad, max.y + pad, min.z - pad),
        GetOffsetFromEntityInWorldCoords(entity, min.x - pad, max.y + pad, min.z - pad),

        -- Top
        GetOffsetFromEntityInWorldCoords(entity, min.x - pad, min.y - pad, max.z + pad),
        GetOffsetFromEntityInWorldCoords(entity, max.x + pad, min.y - pad, max.z + pad),
        GetOffsetFromEntityInWorldCoords(entity, max.x + pad, max.y + pad, max.z + pad),
        GetOffsetFromEntityInWorldCoords(entity, min.x - pad, max.y + pad, max.z + pad)
    }

    local lines = {
        {box[1], box[2]},
        {box[2], box[3]},
        {box[3], box[4]},
        {box[4], box[1]},
        {box[5], box[6]},
        {box[6], box[7]},
        {box[7], box[8]},
        {box[8], box[5]},
        {box[1], box[5]},
        {box[2], box[6]},
        {box[3], box[7]},
        {box[4], box[8]}
    }

    for k, v in pairs(lines) do
		DrawLine(v[1].x, v[1].y, v[1].z, v[2].x, v[2].y, v[2].z, table.unpack(colour))
	end

    local polyMatrix = {
        -- BOTTOM
        {box[3], box[2], box[1]},
        {box[4], box[3], box[1]},

        -- TOP
        {box[5], box[6], box[7]},
        {box[5], box[7], box[8]},

        -- LEFT SIDE
        {box[3], box[4], box[7]},
        {box[8], box[7], box[4]},

        -- RIGHT SIDE
        {box[1], box[2], box[5]},
        {box[6], box[5], box[2]},

        -- FRONT SIDE
        {box[2], box[3], box[6]},
        {box[3], box[7], box[6]},

        -- BACK SIDE
        {box[5], box[8], box[4]},
        {box[5], box[4], box[1]}
    }

    for _, poly in pairs(polyMatrix) do
        DrawPoly(poly[1], poly[2], poly[3], 250, 92, 92, 75)
    end
end

Furnish = function(shell, data, houseid)
    --[[
        local function recreateFurniture()
        if DoesEntityExist(FurnitureObject) then
            DeleteEntity(FurnitureObject)
        end
        for _, attached in pairs(FurnitureAttachments) do
            DeleteEntity(attached)
        end
        Model = LoadModel(Furniture[FurnitureName][FurnitureID][2])
        if Model.loaded then
            FurnitureObject = CreateObject(Model.model, Config.IKEA.ShellPosition, false, false, false)
            SetEntityHeading(FurnitureObject, Config.IKEA.Heading)
        end
        local attachments = Furniture[FurnitureName][FurnitureID][6]
        if attachments then
            for k, v in pairs(attachments) do
                local model = LoadModel(v.object)
                if model.loaded then
                    local attached = CreateObject(model.model, GetEntityCoords(FurnitureObject), false, true)
                    FreezeEntityPosition(attached, true)
                    table.insert(FurnitureAttachments, attached)
            
                    AttachEntityToEntity(attached, FurnitureObject, 0, v.offset.xyz, vector3(0.0, 0.0, v.offset.w), false, false, false, false, 2, true)
                end
            end
        end
    end
    ]]
    local furniture_data = FindFurnitureData(data.object)
    if not Cache.furnishing then
        ESX.UI.Menu.CloseAll()

        Wait(200)
        
        Cache.furnishing = true

        local Model = LoadModel(data.object)
        if Model.loaded then
            local object = CreateObject(Model.model, GetEntityCoords(PlayerPedId()), false, false, false)
            FreezeEntityPosition(object, true)

            local PressDelay = GetGameTimer()
            local speed = 1.0
            local attachedObjects = {}
            local attachments = furniture_data[6]
            if attachments then
                for k, v in pairs(attachments) do
                    local model = LoadModel(v.object)
                    if model.loaded then
                        local attached = CreateObject(model.model, GetEntityCoords(object), false, true)
                        FreezeEntityPosition(attached, true)
                        table.insert(attachedObjects, attached)
                
                        AttachEntityToEntity(attached, object, 0, v.offset.xyz, vector3(0.0, 0.0, v.offset.w), false, false, false, false, 2, true)
                    end
                end
            end

            while Cache.furnishing do
                Wait(0)                
                -- SetEntityNoCollisionEntity(object, PlayerPedId(), true)
                SetEntityCollision(object, false, true)
                HelpText(string.format(Strings["furnishing"], data.label, speed))
                
                DrawEntityBox(object, {255, 255, 255, 255})

                DisableControlAction(0, 24, true) -- Attack
                DisableControlAction(0, 257, true) -- Attack 2
                DisableControlAction(0, 25, true) -- Aim
                DisableControlAction(0, 263, true) -- Melee Attack 1
                DisableControlAction(0, 45, true) -- Reload
                DisableControlAction(0, ((Config.Options and Config.Options.SecondaryAction) or (47)), true)  -- Disable weapon
                DisableControlAction(0, 264, true) -- Disable melee
                DisableControlAction(0, 257, true) -- Disable melee
                DisableControlAction(0, 140, true) -- Disable melee
                DisableControlAction(0, 141, true) -- Disable melee
                DisableControlAction(0, 142, true) -- Disable melee
                DisableControlAction(0, 143, true) -- Disable melee
                DisableControlAction(0, 14, true) -- Disable weapon wheel
                DisableControlAction(0, 15, true) -- Disable weapon wheel
                DisableControlAction(0, 16, true) -- Disable weapon wheel
                DisableControlAction(0, 17, true)  -- Disable weapon wheel
                DisableControlAction(0, 261, true) -- Disable weapon wheel
                DisableControlAction(0, 262, true)  -- Disable weapon wheel
                DisableControlAction(0, 44, true) -- Cover

                if PressDelay <= GetGameTimer() then
                    -- Q (decrease speed)
                    if IsDisabledControlPressed(0, 44) then
                        if speed - 0.1 >= 0.1 then
                            speed = speed - 0.1
                            PressDelay = GetGameTimer() + 100
                        else
                            speed = 0.1
                        end
                    -- E (increase speed)
                    elseif IsControlPressed(0, 46) then
                        speed = speed + 0.1
                        PressDelay = GetGameTimer() + 100
                    end
                end

                -- scroll up
                if IsDisabledControlPressed(0, 15) then
                    SetEntityCoordsNoOffset(object, GetEntityCoords(object) + vec3(0.0, 0.0, 0.01 * speed))
                -- scroll down
                elseif IsDisabledControlPressed(0, 14) then
                    SetEntityCoordsNoOffset(object, GetEntityCoords(object) - vec3(0.0, 0.0, 0.01 * speed))
                end

                -- mouse left
                if IsDisabledControlPressed(0, 24) then
                    SetEntityHeading(object, GetEntityHeading(object) - speed)
                -- mouse right
                elseif IsDisabledControlPressed(0, 25) then
                    SetEntityHeading(object, GetEntityHeading(object) + speed)
                end

                -- arrow left
                if IsControlPressed(0, 174) then
                    local offset = GetOffsetFromEntityInWorldCoords(object, (-0.01) * speed, 0.0, 0.0)
                    SetEntityCoordsNoOffset(object, offset)
                -- arrow right
                elseif IsControlPressed(0, 175) then
                    local offset = GetOffsetFromEntityInWorldCoords(object, (0.01) * speed, 0.0, 0.0)
                    SetEntityCoordsNoOffset(object, offset)
                end
                -- arrow up
                if IsControlPressed(0, 172) then
                    local offset = GetOffsetFromEntityInWorldCoords(object, 0.0, (-0.01) * speed, 0.0)
                    SetEntityCoordsNoOffset(object, offset)
                -- arrow down
                elseif IsControlPressed(0, 173) then
                    local offset = GetOffsetFromEntityInWorldCoords(object, 0.0, (0.01) * speed, 0.0)
                    SetEntityCoordsNoOffset(object, offset)
                end

                if IsDisabledControlPressed(0, ((Config.Options and Config.Options.SecondaryAction) or (47))) then
                    SetEntityCoordsNoOffset(object, GetEntityCoords(PlayerPedId()))
                end

                DrawText3D(GetEntityCoords(object) + vec3(0.0, 0.0, 0.5), string.format(Strings["rotation"], RoundInt(GetEntityHeading(object))))

                if IsControlPressed(0, 191) then
                    local objCoords, houseCoords = GetEntityCoords(object), GetEntityCoords(shell)
                    local offset = vector3(objCoords.x, objCoords.y, objCoords.z) - houseCoords
                    local position = {x = offset.x, y = offset.y, z = offset.z, h = GetEntityHeading(object)}
                    TriggerServerEvent("loaf_housing:placeFurniture", data.object, position, houseid)

                    DeleteEntity(object)
                    for k, v in pairs(attachedObjects) do
                        DeleteEntity(v)
                    end
                    Cache.furnishing = false
                end

                if IsControlJustReleased(0, 194) then
                    DeleteEntity(object)
                    for k, v in pairs(attachedObjects) do
                        DeleteEntity(v)
                    end
                    Cache.furnishing = false
                end
            end
        else
            Cache.furnishing = false
        end
    end
end

EnterHouse = function(k, v)
    local houseid = v.houseid

    ESX.TriggerServerCallback("loaf_housing:spawnHouse", function(success) 

        if success then
            if type(success) == "table" then
                Cache.CurrentHouseOwner = success.owner -- thanks linden :p
                TriggerEvent("loaf_housing:entered_house", houseid)

                Cache.houseid = houseid
                Cache.furniture = success.data.furniture
                                                                    
                local shell_data = Config.Shells[success.data.shell.category][success.data.shell.id]
                local shell_model = LoadModel(shell_data.object)

                local pre_spawned_furniture = {}
                if shell_model.loaded then

                    shell_model = shell_model.model
                    Cache.shell_object = CreateObject(shell_model, success.coords.x, success.coords.y, success.coords.z, false, false, false)
                    SetEntityHeading(Cache.shell_object, 0.0)
                    FreezeEntityPosition(Cache.shell_object, true)

                    local DefaultFurniture = Config.DefaultFurniture[shell_data.object]
                    if DefaultFurniture then
                        for k, v in pairs(DefaultFurniture) do
                            local model = LoadModel(v.object)
                            if model.loaded then
                                model = model.model
                                local object = CreateObject(model, success.coords.x + v.offset.x, success.coords.y + v.offset.y, success.coords.z + v.offset.z, false, false, false)
                                FreezeEntityPosition(object, true)

                                table.insert(pre_spawned_furniture, object)
                            end
                        end
                    end

                    DoScreenFadeOut(750)
                    while not IsScreenFadedOut() do Wait(0) end
                    Cache.ManageTimeAndWeather = true

                    local entrance_coords = GetOffsetFromEntityInWorldCoords(Cache.shell_object, shell_data.entrance)
                    for i = 1, 25 do
                        SetEntityCoords(PlayerPedId(), entrance_coords)
                        Wait(50)
                    end
                    while IsEntityWaitingForWorldCollision(PlayerPedId()) do
                        SetEntityCoords(PlayerPedId(), entrance_coords)
                        Wait(50)
                    end
                    DoScreenFadeIn(1500)

                    Cache.reloadfurniture = true
                    local first_furniture_spawn = true

                    while Cache.inshell do
                        local sleep, selfCoords = 150, GetEntityCoords(PlayerPedId())
                        
                        if not DoesEntityExist(Cache.shell_object) then
                            Cache.inshell = false
                        end

                        if #(selfCoords - entrance_coords) <= 2.0 and not Cache.furnishing then
                            sleep = 0
                            if Cache.unlocked_doors[houseid] then
                                DrawTxt3D(entrance_coords + vec3(0.0, 0.0, 1.0), string.format(Strings["door"], Strings["unlocked"] .. " (" .. houseid .. ")"))
                            else
                                DrawTxt3D(entrance_coords + vec3(0.0, 0.0, 1.0), string.format(Strings["door"], Strings["locked"] .. " (" .. houseid .. ")"))
                            end
                            if IsControlJustReleased(0, ((Config.Options and Config.Options.MainAction) or (51))) then
                                local elements = {
                                    {label = Strings["toggle_lock"], value = "lock"},
                                }

                                if (not Config.Options.RequireKeyFurnish) or exports["loaf_keysystem"]:HasKey("house_"..success.data.id) then
                                    table.insert(elements, {label = Strings["furnish"], value = "furnish"})
                                end

                                if Cache.owned_houses[tostring(success.data.id)] then
                                    table.insert(elements, {label = Strings["kick_someone_out"], value = "kick_out"})
                                end

                                table.insert(elements, {label = Strings["exit"], value = "exit"})
                                
                                ESX.UI.Menu.Open("default", GetCurrentResourceName(), "door", {
                                    title = Strings["door_menu"],
                                    align = ((Config.Options and Config.Options.MenuAlign) or ("bottom-right")),
                                    elements = elements
                                }, function(data, menu)
                                    local current = data.current.value
                                    if current == "exit" then
                                        Cache.inshell = false
                                        ESX.UI.Menu.CloseAll()
                                    elseif current == "lock" then
                                        TriggerServerEvent("loaf_housing:toggleLocked", houseid)
                                    elseif current == "kick_out" then
                                        ESX.TriggerServerCallback("loaf_housing:getPlayers", function(players)
                                            if players then
                                                local elements = {}
                                                for k, v in pairs(players) do
                                                    table.insert(elements, {label = string.format(Strings["kick_out"], v.name), value = v.id})
                                                end

                                                ESX.UI.Menu.Open("default", GetCurrentResourceName(), "choose_kick", {
                                                    title = Strings["kick_someone_out"],
                                                    align = ((Config.Options and Config.Options.MenuAlign) or ("bottom-right")),
                                                    elements = elements
                                                }, function(data2, menu2)

                                                    ESX.UI.Menu.Open("default", GetCurrentResourceName(), "confirm_kick", {
                                                        title = string.format(Strings["kick_out?"], data2.current.label),
                                                        align = ((Config.Options and Config.Options.MenuAlign) or ("bottom-right")),
                                                        elements = {
                                                            {label = Strings["yes"], value = "yes"},
                                                            {label = Strings["no"], value = "no"},
                                                        }
                                                    }, function(data3, menu3)
                                                        local source = data2.current.value 
                                                        
                                                        if data3.current.value == "yes" then
                                                            TriggerServerEvent("loaf_housing:kickOut", tostring(houseid), source)
                                                        else
                                                            menu3.close()
                                                        end

                                                    end, function(data2, menu2)
                                                        menu2.close()
                                                    end)

                                                end, function(data2, menu2)
                                                    menu2.close()
                                                end)
                                            end
                                        end, tostring(houseid))
                                    elseif current == "furnish" then
                                        ESX.UI.Menu.Open("default", GetCurrentResourceName(), "furnish", {
                                            title = Strings["furnish"],
                                            align = ((Config.Options and Config.Options.MenuAlign) or ("bottom-right")),
                                            elements = {
                                                {label = Strings["put_furniture"], value = "put_furniture"},
                                                {label = Strings["manage_furniture"], value = "manage_furniture"},
                                            }
                                        }, function(data2, menu2)
                                            local current2 = data2.current.value
                                            if current2 == "put_furniture" then
                                                local elements, furniture = {}
                                                ESX.TriggerServerCallback("loaf_housing:getFurniture", function(f)
                                                    furniture = f
                                                    for k, v in pairs(furniture) do
                                                        v.object = k
                                                        table.insert(elements, {
                                                            label = string.format(Strings["amount_furniture"], v.amount, v.label), data = v
                                                        })
                                                    end
                                                end)

                                                while furniture == nil do Wait(50) end

                                                ESX.UI.Menu.Open("default", GetCurrentResourceName(), "select_furniture_put", {
                                                    title = Strings["furnish"],
                                                    align = ((Config.Options and Config.Options.MenuAlign) or ("bottom-right")),
                                                    elements = elements
                                                }, function(data3, menu3)
                                                    local current3 = data3.current.data
                                                    
                                                    Furnish(Cache.shell_object, current3, tonumber(v.houseid))
                                                end, function(data3, menu3)
                                                    menu3.close()
                                                end)
                                            elseif current2 == "manage_furniture" then
                                                local elements = {}
                                                for k, v in pairs(Cache.furniture) do
                                                    table.insert(elements, {
                                                        label = v.label .. " [" .. k .. "]",
                                                        id = k,
                                                        coords = GetOffsetFromEntityInWorldCoords(Cache.shell_object, v.offset.x, v.offset.y, v.offset.z),
                                                    })
                                                end

                                                ESX.UI.Menu.Open("default", GetCurrentResourceName(), "select_furniture_manage", {
                                                    title = Strings["furnish"],
                                                    align = ((Config.Options and Config.Options.MenuAlign) or ("bottom-right")),
                                                    elements = elements
                                                }, function(data3, menu3)
                                                    local current3 = data3.current

                                                    ESX.UI.Menu.Open("default", GetCurrentResourceName(), "remove_furniture_manage", {
                                                        title = string.format(Strings["remove_furniture"], current3.label),
                                                        align = ((Config.Options and Config.Options.MenuAlign) or ("bottom-right")),
                                                        elements = {
                                                            {label = Strings["yes"], value = "yes"},
                                                            {label = Strings["no"], value = "no"}
                                                        }
                                                    }, function(data4, menu4)
                                                        local current4 = data4.current.value

                                                        if current4 == "yes" then
                                                            local busy_spinner = true

                                                            AddTextEntry("REMOVING", Strings["removing_furniture"])
                                                            BeginTextCommandBusyspinnerOn("REMOVING")
                                                            EndTextCommandBusyspinnerOn(3)

                                                            ESX.UI.Menu.CloseAll()
                                                            ESX.TriggerServerCallback("loaf_housing:removeFurniture", function(success)
                                                                busy_spinner = false
                                                            end, tostring(v.houseid), current3.id)
                                                            
                                                            while busy_spinner do
                                                                Wait(50)
                                                            end
                                                            BusyspinnerOff()

                                                            TriggerServerEvent("loaf_housing:removeFurniture", tostring(v.houseid), current3.id)
                                                        else
                                                            menu4.close()
                                                        end
                                                    end, function(data4, menu4)
                                                        menu4.close()
                                                    end)
                                                end, function(data3, menu3)
                                                    menu3.close()
                                                end)

                                                while ESX.UI.Menu.IsOpen("default", GetCurrentResourceName(), "select_furniture_manage") do
                                                    Wait(0)

                                                    for k, v in pairs(elements) do
                                                        DrawText3D(v.coords + vec3(0.0, 0.0, 0.5), v.label)
                                                    end
                                                end
                                            end
                                        end, function(data2, menu2)
                                            menu2.close()
                                        end)
                                    end
                                end, function(data, menu)
                                    menu.close()
                                end)

                                while ESX.UI.Menu.IsOpen("default", GetCurrentResourceName(), "door") do
                                    Wait(50)
                                    if #(GetEntityCoords(PlayerPedId()) - entrance_coords) > 2.0 and not ESX.UI.Menu.IsOpen("default", GetCurrentResourceName(), "select_furniture_manage") then
                                        ESX.UI.Menu.CloseAll()
                                        break
                                    end
                                end
                            end
                        end

                        for k, v in pairs(Cache.furniture) do
                            if v.storage then
                                local real_word_position = GetOffsetFromEntityInWorldCoords(Cache.shell_object, v.offset.x, v.offset.y, v.offset.z + 0.75)
                                if #(selfCoords - real_word_position) <= 2.0 then
                                    sleep = 0
                                    DrawTxt3D(real_word_position, Strings["access_storage"], true)
                                    if IsControlJustReleased(0, ((Config.Options and Config.Options.SecondaryAction) or (47))) then
                                        local closest, dist = ESX.Game.GetClosestPlayer({
                                            x = real_word_position.x,
                                            y = real_word_position.y, 
                                            z = real_word_position.z
                                        })

                                        if (closest == -1 or closest == PlayerId()) or dist > 3.5 then
                                            OpenStorage(tostring(houseid), k, v)

                                            while ESX.UI.Menu.IsOpen("default", GetCurrentResourceName(), "manage_storage") or ESX.UI.Menu.IsOpen("default", GetCurrentResourceName(), "select_storage_wardrobe") or ESX.UI.Menu.IsOpen("default", GetCurrentResourceName(), "select_outfit") do
                                                Wait(50)
                                                if #(GetEntityCoords(PlayerPedId()) - real_word_position) > 2.0 then
                                                    ESX.UI.Menu.CloseAll()
                                                    break
                                                end
                                            end
                                        else
                                            ESX.ShowNotification(Strings["nearby_storage"] or "someone is nearby, you can not access the storage")
                                        end
                                    end
                                end
                            end
                        end

                        local heightDifference = selfCoords.z - entrance_coords.z
                        if heightDifference < 0.0 then
                            heightDifference = heightDifference * (-1)
                        end

                        if heightDifference >= 100.0 then
                            SetEntityCoords(PlayerPedId(), entrance_coords)
                        elseif #(GetEntityCoords(PlayerPedId()) - entrance_coords) >= 500.0 then
                            SetEntityCoords(PlayerPedId(), entrance_coords)
                        end

                        if Cache.reloadfurniture then
                            Cache.reloadfurniture = false
                            if first_furniture_spawn then
                                if not IsScreenFadedOut() then DoScreenFadeOut(0) end
                                SetFocusPosAndVel(Config.IKEA.ShellPosition, 0.0, 0.0, 0.0)
                                Wait(2500)
                            end

                            if Cache.spawned_furniture then
                                for k, v in pairs(Cache.spawned_furniture) do
                                    DeleteEntity(v.object)
                                    for _, attached in pairs(v.attached) do
                                        DeleteEntity(attached)
                                    end
                                end
                            end

                            Cache.spawned_furniture = {}

                            for k, v in pairs(Cache.furniture) do
                                local Model = LoadModel(v.item)
                                if Model.loaded then
                                    local object = CreateObject(Model.model, GetOffsetFromEntityInWorldCoords(Cache.shell_object, v.offset.x, v.offset.y, v.offset.z), false, false, false)
                                    
                                    local furniture_data = FindFurnitureData(v.item)
                                    local attachedObjects = {}
                                    local attachments = furniture_data[6]
                                    if attachments then
                                        for k, v in pairs(attachments) do
                                            local model = LoadModel(v.object)
                                            if model.loaded then
                                                local attached = CreateObject(model.model, GetEntityCoords(object), false, true)
                                                FreezeEntityPosition(attached, true)
                                                table.insert(attachedObjects, attached)
                                        
                                                AttachEntityToEntity(attached, object, 0, v.offset.xyz, vector3(0.0, 0.0, v.offset.w), false, false, false, false, 2, true)
                                            end
                                        end
                                    end

                                    FreezeEntityPosition(object, true)
                                    table.insert(Cache.spawned_furniture, {
                                        label = v.label,
                                        object = object,
                                        attached = attachedObjects
                                    })
                                    SetEntityCoordsNoOffset(object, GetOffsetFromEntityInWorldCoords(Cache.shell_object, v.offset.x, v.offset.y, v.offset.z))
                                    SetEntityHeading(object, v.offset.h)
                                    
                                end
                            end

                            if first_furniture_spawn then
                                ClearFocus()
                                first_furniture_spawn = false
                                Wait(1000)
                                DoScreenFadeIn(1500)
                            end
                        end

                        Wait(sleep)
                    end

                    TriggerServerEvent("loaf_housing:exitHouse", tostring(v.houseid))
                    DoScreenFadeOut(750)
                    while not IsScreenFadedOut() do Wait(0) end
                    Cache.ManageTimeAndWeather = false
                    DeleteEntity(Cache.shell_object)
                    for i = 1, 25 do
                        SetEntityCoords(PlayerPedId(), v.data.Entrance.xyz)
                        Wait(50)
                    end
                    while IsEntityWaitingForWorldCollision(PlayerPedId()) do
                        SetEntityCoords(PlayerPedId(), v.data.Entrance.xyz)
                        Wait(50)
                    end
                    SetEntityHeading(PlayerPedId(), v.data.Entrance.w)
                    Wait(500)
                    DoScreenFadeIn(1500)
                    
                    ESX.UI.Menu.CloseAll()

                    if Cache.spawned_furniture then
                        for k, v in pairs(Cache.spawned_furniture) do
                            DeleteEntity(v.object)
                            for _, attached in pairs(v.attached) do
                                DeleteEntity(attached)
                            end
                        end
                    end

                    for k, v in pairs(pre_spawned_furniture) do
                        DeleteEntity(v)
                    end
                end
            elseif success == "locked" then
                ESX.ShowNotification(Strings["error_locked"])
            end
        else
            ESX.ShowNotification(Strings["no_spawn"])
        end

        Cache.inshell = false
        Cache.houseid = 0
        Cache.ManageTimeAndWeather = false
    end, tostring(v.houseid))
end

CreateThread(function()
    DoScreenFadeIn(0)
    while not Loaded do 
        Wait(50) 
    end

    local loaded = false

    CreateThread(function()
        ESX.TriggerServerCallback("loaf_housing:getHouseData", function(data) 
            if data then
                Cache.bought_houses = {}
                Cache.owned_houses = data.owned_houses

                Cache.unlocked_doors = data.locked
                
                for k, v in pairs(data.purchased_houses) do
                    if not Cache.owned_houses[tostring(v.houseid)] then
                        Cache.bought_houses[tostring(v.houseid)] = true
                    end
                end

                if Config.Blips.IKEA then
                    AddBlip(Config.IKEA.EnterIKEA.xyz, 605, 0, Strings["ikea"], false, Config.Blips.IKEAScale)
                end

                ESX.TriggerServerCallback("loaf_keysystem:getKeys", function(keys)
                    local houseKeys = {}
                    for k, v in pairs(keys) do
                        if string.find(v.key_id, "house_") then
                            houseKeys[v.key_id] = true
                        end
                    end
                    Cache.houseKeys = houseKeys

                    for k, v in pairs(Config.Houses) do
                        local sk = tostring(k)
                        if Cache.owned_houses[sk] then
                            if Config.Blips.Owned then
                                Cache["blip_house_" .. sk] = AddBlip(v.Entrance.xyz, 40, 2, Strings["owned_" .. v.Type], 10)
                            end
                        elseif Cache.bought_houses[sk] then
                            if houseKeys["house_" .. sk] and Config.Blips.Access then
                                Cache["blip_house_" .. sk] = AddBlip(v.Entrance.xyz, 40, 7, Strings["access_" .. v.Type], 10)
                            elseif Config.Blips.Others then
                                Cache["blip_house_" .. sk] = AddBlip(v.Entrance.xyz, 40, 3, Strings["purchased_" .. v.Type], 10)
                            end
                        else
                            if Config.Blips.Buyable then
                                Cache["blip_house_" .. sk] = AddBlip(v.Entrance.xyz, 40, 0, Strings["purchasable_" .. v.Type], 10)
                            end
                        end
                        Wait(5)
                    end

                    loaded = true
                end)
            end
        end)
    end)

    while not loaded do Wait(50) end

    CreateThread(function()
        while true do
            if Cache.NearbyHouses and #Cache.NearbyHouses > 0 then
                Wait(0)
                for k, v in pairs(Cache.NearbyHouses) do
                    if not Cache.owned_houses[v.houseid] and not Cache.bought_houses[v.houseid] then
                        if (not Config.REA or Config.AllowCircle) and Marker(v.data.Entrance.xyz, string.format(Strings["buy_house"], v.data.Label, v.houseid, FormatNumber(v.data.Price))) then
                            OpenPurchaseMenu(v.houseid)
                            while #(GetEntityCoords(PlayerPedId()) - v.data.Entrance.xyz) <= 1.1 and ESX.UI.Menu.IsOpen("default", GetCurrentResourceName(), "purchase_house") do
                                Wait(50)
                            end
                            ESX.UI.Menu.CloseAll()
                        elseif Config.REA and not Config.AllowCircle then
                            if Config.PreviewHouse.Enabled then
                                if Marker(v.data.Entrance.xyz, Strings["contact_rea"]:format(v.data.Label, v.houseid)) then
                                    PreviewHouse(v.data)
                                end
                            else
                                Marker(v.data.Entrance.xyz, Strings["contact_rea_nopreview"]:format(v.data.Label, v.houseid))
                            end
                        end
                    else
                        if Config.EnableGarage and (Cache.owned_houses[v.houseid] or exports["loaf_keysystem"]:HasKey("house_" .. v.houseid) and Config.Options.Key.Garage) and v.data.Garage then
                            local vehicle = GetVehiclePedIsUsing(PlayerPedId())

                            if DoesEntityExist(vehicle) then
                                if Marker(v.data.Garage.Exit.xyz + vec3(0.0, 0.0, 0.5), Strings["store_garage"]) then
                                    TriggerEvent("loaf_garage:store", "Housing [" .. v.houseid .. "]")
                                end
                            else
                                if Marker(v.data.Garage.Entrance, Strings["enter_garage"]) then
                                    local viewing = true

                                    TriggerEvent("loaf_garage:viewVehicles", "Housing [" .. v.houseid .. "]", v.data.Garage.Exit.xyz, v.data.Garage.Exit.w, function()
                                        viewing = false
                                    end, v.data.Garage.Entrance)

                                    while viewing do 
                                        Wait(250)
                                    end
                                end
                            end
                        end

                        Marker(v.data.Entrance.xyz)
                        if #(v.data.Entrance.xyz - GetEntityCoords(PlayerPedId())) <= 2.0 then
                            local suffix = ""
                            if Cache.owned_houses[v.houseid] then
                                suffix = Strings["press_manage"]
                                if IsControlJustReleased(0, ((Config.Options and Config.Options.SecondaryAction) or (47))) then
                                    ManageHouse(v.houseid)
                                end
                            elseif Cache.IsPolice then
                                suffix = Strings["breach_door"]
                            elseif Config.LockPicking and Config.LockPicking.Enabled then
                                suffix = Strings["lockpick_door"]
                            end

                            if Cache.unlocked_doors[v.houseid] then
                                DrawTxt3D(v.data.Entrance.xyz, Strings["unlocked"] .. " (" .. v.houseid .. ")", true, true)
                                if #(v.data.Entrance.xyz - GetEntityCoords(PlayerPedId())) <= 1.0 then
                                    if suffix == Strings["press_manage"] then
                                        HelpText(Strings["enter"] .. suffix, true)
                                    else
                                        HelpText(Strings["enter"], true)
                                    end
                                    if IsControlJustReleased(0, ((Config.Options and Config.Options.MainAction) or (51))) then
                                        Cache.inshell = true
                                        EnterHouse(k, v)
                                        while Cache.inshell do
                                            Wait(500)
                                        end
                                    end
                                end
                            else
                                DrawTxt3D(v.data.Entrance.xyz, Strings["locked"]  .. " (" .. v.houseid .. ")" .. suffix, true, true)

                                if Cache.IsPolice and suffix == Strings["breach_door"] and IsControlJustReleased(0, ((Config.Options and Config.Options.SecondaryAction) or (47))) then
                                    TriggerServerEvent("loaf_housing:breachDoor", v.houseid)
                                elseif IsControlJustReleased(0, ((Config.Options and Config.Options.SecondaryAction) or (47))) and suffix == Strings["lockpick_door"] then
                                    local success = LockPick(tonumber(v.houseid))

                                    ClearPedTasks(PlayerPedId())
                                    if success then
                                        TriggerServerEvent("loaf_housing:successfulLockpick", v.houseid)
                                    end
                                end
                            end
                        end
                    end
                end
            else
                while #(GetEntityCoords(PlayerPedId()) - Config.IKEA.EnterIKEA.xyz) <= 25.0 do
                    Wait(0)

                    if Marker(Config.IKEA.EnterIKEA.xyz, Strings["enter_ikea"]) then
                        EnterIKEA()
                    elseif #(GetEntityCoords(PlayerPedId()) - Config.IKEA.EnterIKEA.xyz) <= 1.0 and IsControlJustReleased(0, ((Config.Options and Config.Options.SecondaryAction) or (47))) then
                        OpenSellMenuIKEA()
                    end
                end
                Wait(500)
            end
        end
    end)

    CreateThread(function()
        while true do
            Wait(500)
            Cache.NearbyHouses = {}
            for k, v in pairs(Config.Houses) do
                if #(GetEntityCoords(PlayerPedId()) - v.Entrance.xyz) <= 50.0 then
                    table.insert(Cache.NearbyHouses, {
                        houseid = tostring(k),
                        data = v
                    })
                end
            end
        end
    end)
end)

RegisterNetEvent("loaf_housing:setFurnitureCurrentHouse")
AddEventHandler("loaf_housing:setFurnitureCurrentHouse", function(houseid, furniture, disablereload)
    Cache.furniture = furniture
    if not disablereload then
        Cache.reloadfurniture = true
    end
end)

RegisterNetEvent("loaf_housing:leaveHouse")
AddEventHandler("loaf_housing:leaveHouse", function(houseid)
    Cache.inshell = false
    Cache.furniture = {}
    Cache.reloadfurniture = false
    Cache.ManageTimeAndWeather = false

    local v = Config.Houses[houseid]

    DoScreenFadeOut(750)
    while not IsScreenFadedOut() do Wait(0) end
    DeleteEntity(Cache.shell_object)
    for i = 1, 25 do
        SetEntityCoords(PlayerPedId(), v.data.Entrance.xyz)
        Wait(50)
    end
    while IsEntityWaitingForWorldCollision(PlayerPedId()) do
        SetEntityCoords(PlayerPedId(), v.data.Entrance.xyz)
        Wait(50)
    end
    SetEntityHeading(PlayerPedId(), v.data.Entrance.w)
    Wait(500)
    DoScreenFadeIn(1500)

    if Cache.spawned_furniture then
        for k, v in pairs(Cache.spawned_furniture) do
            DeleteEntity(v.object)
            for _, attached in pairs(v.attached) do
                DeleteEntity(attached)
            end
        end
    end
    
    ESX.UI.Menu.CloseAll()
end)

RegisterNetEvent("loaf_housing:forceLeave")
AddEventHandler("loaf_housing:forceLeave", function()
    Cache.inshell = false
    ESX.UI.Menu.CloseAll()
end)

RegisterNetEvent("loaf_housing:setUnlockedDoors")
AddEventHandler("loaf_housing:setUnlockedDoors", function(unlocked_doors)
    Cache.unlocked_doors = unlocked_doors
end)

RegisterNetEvent("loaf_housing:updateHouseData")
AddEventHandler("loaf_housing:updateHouseData", function(data)
    if Cache.bought_houses then -- if the script has already loaded (otherwise - no point in updating something that will be updated by itself)
        Cache.bought_houses = {}
        if data.owned_houses then
            Cache.owned_houses = data.owned_houses
        end
        
        for k, v in pairs(data.purchased_houses) do
            if not Cache.owned_houses[tostring(v.houseid)] then
                Cache.bought_houses[tostring(v.houseid)] = true
            end
        end

        ESX.TriggerServerCallback("loaf_keysystem:getKeys", function(keys)
            local houseKeys = {}
            for k, v in pairs(keys) do
                if string.find(v.key_id, "house_") then
                    houseKeys[v.key_id] = true
                end
            end
            Cache.houseKeys = houseKeys

            for k, v in pairs(Config.Houses) do
                local sk = tostring(k)
                if Cache["blip_house_" .. sk] then -- remove old blips
                    RemoveBlip(Cache["blip_house_" .. sk])
                    Cache["blip_house_" .. sk] = nil
                end

                if Cache.owned_houses[sk] then
                    if Config.Blips.Owned then
                        Cache["blip_house_" .. sk] = AddBlip(v.Entrance.xyz, 40, 2, Strings["owned_" .. v.Type], 10)
                    end
                elseif Cache.bought_houses[sk] then
                    if houseKeys["house_" .. sk] and Config.Blips.Access then
                        Cache["blip_house_" .. sk] = AddBlip(v.Entrance.xyz, 40, 7, Strings["access_" .. v.Type], 10)
                    elseif Config.Blips.Others then
                        Cache["blip_house_" .. sk] = AddBlip(v.Entrance.xyz, 40, 3, Strings["purchased_" .. v.Type], 10)
                    end
                else
                    if Config.Blips.Buyable then
                        Cache["blip_house_" .. sk] = AddBlip(v.Entrance.xyz, 40, 0, Strings["purchasable_" .. v.Type], 10)
                    end
                end
                Wait(5)
            end

            loaded = true
        end)
    end
end)

AddEventHandler("onResourceStop", function(resourceName)
    if resourceName == GetCurrentResourceName() then
        if Cache.inshell then
            Cache.inshell = false
            ESX.UI.Menu.CloseAll()
        end
        
        Wait(5000)
    end
end)