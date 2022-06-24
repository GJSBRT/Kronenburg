Loaded = false
Cache = {}

CreateThread(function()
    while not NetworkIsSessionStarted() do 
        Wait(250)
    end

    while ESX == nil do 
        TriggerEvent('esx:getSharedObject', function(obj) 
            ESX = obj 
        end) 
        Wait(250) 
    end

    while ESX.GetPlayerData().job == nil do -- Wait for character (job) to load (support for kashacters, etc)
        Wait(250)
    end

    if Config.PoliceRaid and Config.PoliceRaid.Enabled then
        if ESX.GetPlayerData().job.name == Config.PoliceRaid.Job.Name then
            if (Config.PoliceRaid.OnlyBoss and ESX.GetPlayerData().job.grade_name == Config.PoliceRaid.Job.Boss) or not Config.PoliceRaid.OnlyBoss then
                Cache.IsPolice = true
            end
        end
    end

    TriggerServerEvent("loaf_housing:updateJoined")

    if Config.REA then
        TriggerServerEvent("loaf_housing:request_houses")
    else
        Loaded = true
    end
end)

RegisterNetEvent("loaf_housing:set_houses")
AddEventHandler("loaf_housing:set_houses", function(houses)
    if Loaded then
        for k, v in pairs(Config.Houses) do
            local sk = tostring(k) -- change it to a string
            if Cache["blip_house_" .. sk] then -- remove old blips
                RemoveBlip(Cache["blip_house_" .. sk])
                Cache["blip_house_" .. sk] = nil
            end
            Wait(5)
        end
    end

    Config.Houses = houses

    if Loaded then
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

    Loaded = true
end)

RegisterNetEvent("esx:setJob")
AddEventHandler("esx:setJob", function(job)
	if Config.PoliceRaid and Config.PoliceRaid.Enabled then
        if job.name == Config.PoliceRaid.Job.Name then
            if (Config.PoliceRaid.OnlyBoss and job.grade_name == Config.PoliceRaid.Job.Boss) or not Config.PoliceRaid.OnlyBoss then
                Cache.IsPolice = true
            else
                Cache.IsPolice = false
            end
        else
            Cache.IsPolice = false
        end
    else
        Cache.IsPolice = false
    end
end)

AddBlip = function(coords, sprite, colour, label, category, scale)
    local blip = AddBlipForCoord(coords)
    if category and Config.Blips.Categorize then
        SetBlipCategory(blip, category)
    end
    SetBlipSprite(blip, sprite)
    SetBlipColour(blip, colour)
    SetBlipScale(blip, scale or (Config.Blips.Scale or 0.5))
    SetBlipAsShortRange(blip, true)

    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(label)
    EndTextCommandSetBlipName(blip)

    return blip
end

LoadModel = function(model)
    local ogmodel = model
    if type(model) == "string" then model = GetHashKey(model) elseif type(model) ~= "number" then return {loaded = false, model = model} end
    local timer = GetGameTimer() + 10000 -- 10 seconds to load

    AddTextEntry("LOADING", Strings["loading_object"])
    BeginTextCommandBusyspinnerOn("LOADING")
    EndTextCommandBusyspinnerOn(3)

    if not HasModelLoaded(model) and IsModelInCdimage(model) then
        RequestModel(model)
        while not HasModelLoaded(model) and timer >= GetGameTimer() do -- give it time to load
            Wait(50)
        end
    end

    BusyspinnerOff()

    if HasModelLoaded(model) then
        if not Cache.RemoveModels then Cache.RemoveModels = {} end -- might help with ram
        table.insert(Cache.RemoveModels, {
            Model = model,
            Remove = GetGameTimer() + 5000,
        })

        return {loaded = true, model = model}
    else
        if not IsModelInCdimage(model) then
            ESX.ShowNotification("Model " .. ogmodel .. " is not in cd image")
        else
            ESX.ShowNotification("Contact your server owner, the model couldn't load (doesn't exist?): " .. ogmodel)
        end
        return {loaded = false, model = model}
    end
end

HelpText = function(text, sound)
    AddTextEntry(GetCurrentResourceName(), text)
    BeginTextCommandDisplayHelp(GetCurrentResourceName())
    EndTextCommandDisplayHelp(0, 0, (sound == true), -1)
end

DrawText3D = function(coords, text)
    SetDrawOrigin(coords)

    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextEntry('STRING')
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(0.0, 0.0)
    DrawRect(0.0, 0.0125, 0.015 + text:gsub("~.-~", ""):len() / 370, 0.03, 45, 45, 45, 150)

    ClearDrawOrigin()
end

DrawTxt3D = function(coords, text, sound, force)
    if not Config.Use3DText and not force then
        HelpText(text, (sound == true))
        return
    end

    local str = text

    local start, stop = string.find(text, "~([^~]+)~")
    if start then
        start = start - 2
        stop = stop + 2
        str = ""
        str = str .. string.sub(text, 0, start) .. "   " .. string.sub(text, start+2, stop-2) .. string.sub(text, stop, #text)
    end

    AddTextEntry(GetCurrentResourceName(), str)
    BeginTextCommandDisplayHelp(GetCurrentResourceName())
    EndTextCommandDisplayHelp(2, false, false, -1)

	SetFloatingHelpTextWorldPosition(1, coords)
	SetFloatingHelpTextStyle(1, 1, 2, -1, 3, 0)
end

FormatNumber = function(number)
    local toreturn = ""
    if number >= 1000 then
        local string_number = string.reverse(tostring(number))
        for i = 0, #string_number - 1 do
            if i % 3 == 0 then
                toreturn = toreturn .. " "
            end
            toreturn = toreturn .. string.sub(string_number, i + 1, i + 1)
        end
    else
        return tostring(number)
    end
    toreturn = string.reverse(toreturn)
    if string.sub(toreturn, #toreturn, #toreturn) == " " then
        toreturn = string.sub(toreturn, 0, #toreturn - 1)
    end
    return toreturn
end

Marker = function(position, text, control)
    DrawMarker(1, position - vec3(0.0, 0.0, 1.0), vec3(0.0, 0.0, 0.0), vec3(0.0, 0.0, 0.0), vec3(0.4, 0.4, 0.4), 255, 255, 0, 200)
    if #(GetEntityCoords(PlayerPedId()) - position) <= 1.0 and text then
        DrawTxt3D(position, text)
        if IsControlJustReleased(0, control or ((Config.Options and Config.Options.MainAction) or (51))) then
            return true
        end
    end
end

OpenPurchaseMenu = function(houseid)
    local housedata = Config.Houses[tonumber(houseid)]
    local elements = {
        {label = string.format(Strings["confirm_house_purchase"], housedata.Label, housedata.Price), value = "purchase"},
    }

    if Config.PreviewHouse and Config.PreviewHouse.Enabled then
        table.insert(elements, {label = Strings["preview"], value = "preview"})
    end

    ESX.UI.Menu.Open("default", GetCurrentResourceName(), "purchase_house", {
        title = housedata.Label,
        align = ((Config.Options and Config.Options.MenuAlign) or ("bottom-right")),
        elements = elements
    }, function(data, menu)
        if data.current.value == "purchase" then
            if not Config.RandomInterior then
                local interior_elements = {}
                local shells = Config.Shells[housedata.ShellType]
                for i = 1, #shells do
                    table.insert(interior_elements, {
                        label = Strings["interior_number"]:format(i),
                        value = i
                    })
                end
                ESX.UI.Menu.Open("default", GetCurrentResourceName(), "select_interior", {
                    title = Strings["what_interior"],
                    align = ((Config.Options and Config.Options.MenuAlign) or ("bottom-right")),
                    elements = interior_elements,
                }, function(data2, menu2)
                    ESX.UI.Menu.CloseAll()
                    local current = data2.current.value
                    AddTextEntry("PURCHASING", Strings["purchasing"])
                    BeginTextCommandBusyspinnerOn("PURCHASING")
                    EndTextCommandBusyspinnerOn(3)
                    local purchashed = false

                    ESX.TriggerServerCallback("loaf_housing:purchaseHouse", function()
                        purchashed = true
                    end, tonumber(houseid), data2.current.value)

                    while not purchashed do 
                        Wait(50) 
                    end
                    BusyspinnerOff()
                end, function(data2, menu2)
                    menu2.close()
                end)
            else
                ESX.UI.Menu.Open("default", GetCurrentResourceName(), "confirm_purchase_house", {
                    title = string.format(Strings["are_you_sure"], housedata.Label),
                    align = ((Config.Options and Config.Options.MenuAlign) or ("bottom-right")),
                    elements = {
                        {label = Strings["yes"], value = "yes"},
                        {label = Strings["no"], value = "no"},
                    }
                }, function(data2, menu2)
                    if data2.current.value == "yes" then
                        ESX.UI.Menu.CloseAll()
                        local current = data2.current.value
                        AddTextEntry("PURCHASING", Strings["purchasing"])
                        BeginTextCommandBusyspinnerOn("PURCHASING")
                        EndTextCommandBusyspinnerOn(3)
                        local purchashed = false
    
                        ESX.TriggerServerCallback("loaf_housing:purchaseHouse", function()
                            purchashed = true
                        end, tonumber(houseid))
    
                        while not purchashed do 
                            Wait(50) 
                        end
                        BusyspinnerOff()
                    else
                        menu2.close()
                    end
                end, function(data2, menu2)
                    menu2.close()
                end)
            end
        elseif data.current.value == "preview" then
            menu.close()
            ESX.UI.Menu.CloseAll()
            PreviewHouse(housedata)
        end
    end, function(data, menu)
        menu.close()
    end)
end

PreviewHouse = function(housedata)
    local shells = Config.Shells[housedata.ShellType]
    if shells and shells[1] then
        local current = 1
        if housedata.ShellId then
            current = housedata.ShellId
        end
        local current_shell = shells[current].object
        local model = LoadModel(current_shell)
        if model.loaded then
            Cache.shell_object = CreateObject(model.model, Config.PreviewHouse.Position, false, false, false)
            SetEntityHeading(Cache.shell_object, 0.0)
            FreezeEntityPosition(Cache.shell_object, true)

            DoScreenFadeOut(750)
            Cache.ManageTimeAndWeather = true
            while not IsScreenFadedOut() do Wait(0) end

            local entrance_coords = GetOffsetFromEntityInWorldCoords(Cache.shell_object, Config.ShellOffsets[current_shell])
            for i = 1, 25 do
                SetEntityCoords(PlayerPedId(), entrance_coords)
                Wait(50)
            end
            while IsEntityWaitingForWorldCollision(PlayerPedId()) do
                SetEntityCoords(PlayerPedId(), entrance_coords)
                Wait(50)
            end
            DoScreenFadeIn(1500)

            while true do
                Wait(0)
                SetEntityVisible(PlayerPedId(), false)
                SetEntityLocallyVisible(PlayerPedId())
                if not housedata.ShellId or Config.AllowCircle then
                    HelpText(string.format(Strings["previewing"], current, #shells))
                else
                    HelpText(string.format(Strings["previewing_nohelp"], current, #shells))
                end

                if (not housedata.ShellId or Config.AllowCircle) and (IsControlJustReleased(0, 174) or IsControlJustReleased(0, 175)) then
                    if IsControlJustReleased(0, 174) then -- left
                        if shells[current - 1] then
                            current = current - 1
                        else
                            current = #shells
                        end
                    elseif IsControlJustReleased(0, 175) then -- right
                        if shells[current + 1] then
                            current = current + 1
                        else
                            current = 1
                        end
                    end
                    
                    current_shell = shells[current].object
                    model = LoadModel(current_shell)

                    if model.loaded then
                        DeleteEntity(Cache.shell_object)
                        Cache.shell_object = CreateObject(model.model, Config.PreviewHouse.Position, false, false, false)
                        SetEntityHeading(Cache.shell_object, 0.0)
                        FreezeEntityPosition(Cache.shell_object, true)

                        entrance_coords = GetOffsetFromEntityInWorldCoords(Cache.shell_object, Config.ShellOffsets[current_shell])
                        SetEntityCoords(PlayerPedId(), entrance_coords)
                    end
                end

                if IsControlJustReleased(0, 194) then
                    break
                end
            end

            SetEntityVisible(PlayerPedId(), true)
            DoScreenFadeOut(750)
            Cache.ManageTimeAndWeather = false
            while not IsScreenFadedOut() do Wait(0) end
            DeleteEntity(Cache.shell_object)
            for i = 1, 25 do
                SetEntityCoords(PlayerPedId(), housedata.Entrance.xyz)
                Wait(50)
            end
            while IsEntityWaitingForWorldCollision(PlayerPedId()) do
                SetEntityCoords(PlayerPedId(), housedata.Entrance.xyz)
                Wait(50)
            end
            SetEntityHeading(PlayerPedId(), housedata.Entrance.w)
            Wait(500)
            DoScreenFadeIn(1500)
        end
    end
end

RoundInt = function(float)
    return math.floor(float + 0.5)
end

FindFurnitureData = function(item)
    for category, furniture in pairs(Furniture) do
        for _, data in pairs(furniture) do
            if data[2] == item then
                return data
            end
        end
    end
    return {}
end

StorageMenu = function(houseid, k, v) 
    if Config.Options.Inventory == "default" then
        ESX.TriggerServerCallback("loaf_housing:getInventory", function(inventory)    
            ESX.UI.Menu.Open("default", GetCurrentResourceName(), "manage_storage", {
                title = Strings["inventory"],
                align = ((Config.Options and Config.Options.MenuAlign) or ("bottom-right")),
                elements = {
                    {label = string.format(Strings["cash"], FormatNumber(v.storage.cash)), value = "cash", amount = v.storage.cash},
                    {label = string.format(Strings["black_money"], FormatNumber(v.storage.black_money)), value = "black_money", amount = v.storage.black_money},
                    {label = Strings["put"], value = "put"},
                    {label = Strings["get"], value = "get"},
                }
            }, function(data, menu)
                local current = data.current.value
        
                if current == "put" or current == "get" then
                    ESX.UI.Menu.Open("default", GetCurrentResourceName(), "manage_storage_select", {
                        title = Strings["inventory"],
                        align = ((Config.Options and Config.Options.MenuAlign) or ("bottom-right")),
                        elements = {
                            {label = Strings["items"], value = "items"},
                            {label = Strings["weapons"], value = "weapons"},
                        }
                    }, function(data2, menu2)

                        local elements = {}
                        if current == "put" then
                            if data2.current.value == "items" then
                                for k, v in pairs(inventory.items) do
                                    if v.count > 0 then
                                        table.insert(elements, {label = string.format("x%s %s", FormatNumber(v.count), v.label), value = v.name, item = v.name, data = v})
                                    end
                                end
                            else
                                for k, v in pairs(inventory.weapons) do
                                    table.insert(elements, {label = string.format("%s", v.label), value = v.name, item = v.name, data = v})
                                end
                            end
                        else
                            if data2.current.value == "items" then
                                for k, v in pairs(v.storage.items) do
                                    table.insert(elements, {label = string.format("x%s %s", FormatNumber(v.amount), v.label), item = v.item, data = v})
                                end
                            else
                                for k, v in pairs(v.storage.weapons) do
                                    table.insert(elements, {label = string.format("%s (%s)", v.label, v.ammo), item = k, data = v})
                                end
                            end
                        end

                        ESX.UI.Menu.Open("default", GetCurrentResourceName(), "manage_storage_select_item", {
                            title = Strings["inventory"],
                            align = ((Config.Options and Config.Options.MenuAlign) or ("bottom-right")),
                            elements = elements
                        }, function(data3, menu3)
                            if data2.current.value == "items" then
                                ESX.UI.Menu.Open("dialog", GetCurrentResourceName(), "amount_deposit_withdraw'", {
                                    title = string.format(Strings["amount_of"], data3.current.data.label)
                                }, function(data4, menu4)
                                    local amount = tonumber(data4.value)
            
                                    if amount ~= nil then
                                        if current == "put" then
                                            -- TriggerServerEvent("loaf_housing:store", houseid, itemid, itemtype, amount, itemname)
                                            TriggerServerEvent("loaf_housing:store", houseid, k, data2.current.value, amount, data3.current.item)
                                        elseif current == "get" then
                                            TriggerServerEvent("loaf_housing:withdraw", houseid, k, data2.current.value, amount, data3.current.item)
                                        end
            
                                        ESX.UI.Menu.CloseAll()
                                    else
                                        ESX.ShowNotification(Strings["must_be_number"])
                                    end
                                end, function(data4, menu4)
                                    menu4.close()
                                end)
                            else
                                if current == "put" then
                                    TriggerServerEvent("loaf_housing:store", houseid, k, data2.current.value, 1, data3.current.item)
                                elseif current == "get" then
                                    TriggerServerEvent("loaf_housing:withdraw", houseid, k, data2.current.value, 1, data3.current.item)
                                end
                                
                                ESX.UI.Menu.CloseAll()
                            end
                        end, function(data3, menu3)
                            menu3.close()
                        end)

                    end, function(data2, menu2)
                        menu2.close()
                    end)
                elseif current == "cash" or current == "black_money" then
                    ESX.UI.Menu.Open("default", GetCurrentResourceName(), "manage_storage_money", {
                        title = data.current.label,
                        align = ((Config.Options and Config.Options.MenuAlign) or ("bottom-right")),
                        elements = {
                            {label = Strings["deposit"], value = "deposit"},
                            {label = Strings["withdraw"], value = "withdraw"},
                        }
                    }, function(data2, menu2)
                        local current2 = data2.current.value
        
                        ESX.UI.Menu.Open("dialog", GetCurrentResourceName(), "amount_deposit_withdraw'", {
                            title = data2.current.label
                        }, function(data3, menu3)
                            local amount = tonumber(data3.value)

                            if amount ~= nil then
                                if current2 == "deposit" then
                                    if current == "cash" then
                                        if inventory.cash >= amount then
                                            TriggerServerEvent("loaf_housing:store", houseid, k, "cash", amount)
                                        else
                                            ESX.ShowNotification(Strings["dont_have"])
                                        end
                                    else
                                        if inventory.black_money.money >= amount then
                                            TriggerServerEvent("loaf_housing:store", houseid, k, "black_money", amount)
                                        else
                                            ESX.ShowNotification(Strings["dont_have"])
                                        end
                                    end
                                else
                                    if current == "cash" then
                                        if v.storage.cash >= amount then
                                            TriggerServerEvent("loaf_housing:withdraw", houseid, k, "cash", amount)
                                        else
                                            ESX.ShowNotification(Strings["not_enough"])
                                        end
                                    else
                                        if v.storage.black_money >= amount then
                                            TriggerServerEvent("loaf_housing:withdraw", houseid, k, "black_money", amount)
                                        else
                                            ESX.ShowNotification(Strings["not_enough"])
                                        end
                                    end
                                end

                                ESX.UI.Menu.CloseAll()
                            else
                                ESX.ShowNotification(Strings["must_be_number"])
                            end
                        end, function(data3, menu3)
                            menu3.close()
                        end)

                    end, function(data2, menu2)
                        menu2.close()
                    end)
                end
            end, function(data, menu)
                menu.close()
            end)

        end)

        while not ESX.UI.Menu.IsOpen("default", GetCurrentResourceName(), "manage_storage") do
            Wait(250)
        end
    elseif Config.Options.Inventory == "modfreakz" then
        ESX.UI.Menu.CloseAll()
        if not v.storage.identifier then
            ESX.TriggerServerCallback("loaf_housing:convert_storage", function(identifier)
                exports["mf-inventory"]:openOtherInventory(identifier)
            end, houseid, k)
        else
            exports["mf-inventory"]:openOtherInventory(v.storage.identifier)
        end
    elseif Config.Options.Inventory == "linden" then
        ESX.UI.Menu.CloseAll()
        local slots = 500
        local furniture_data = FindFurnitureData(v.item)
        if furniture_data and furniture_data[5] then
            slots = furniture_data[5]
        end

        if not v.storage.identifier then
            ESX.TriggerServerCallback("loaf_housing:convert_storage", function(identifier)
                exports['linden_inventory']:OpenStash({owner = Cache.CurrentHouseOwner, id = identifier, label = v.label, slots = slots})
            end, houseid, k)
        else
            exports['linden_inventory']:OpenStash({owner = Cache.CurrentHouseOwner, id = v.storage.identifier, label = v.label, slots = slots})
        end
    elseif Config.Options.Inventory == "ox_inventory" then
        ESX.UI.Menu.CloseAll()
        -- ESX.TriggerServerCallback("loaf_housing:openOxInventory", function(identifier)
        --     print("CREATED, SETSTASH " .. Cache.CurrentHouseOwner)
        --     exports["ox_inventory"]:setStashTarget(identifier, Cache.CurrentHouseOwner)
        -- end, houseid, k)
        if not v.storage.identifier then
            ESX.TriggerServerCallback("loaf_housing:convert_storage", function(identifier)
                exports["ox_inventory"]:setStashTarget(identifier, Cache.CurrentHouseOwner)
                ExecuteCommand("inv2")
            end, houseid, k)
        else
            ESX.TriggerServerCallback("loaf_housing:openOxInventory", function()
                exports["ox_inventory"]:setStashTarget(v.storage.identifier, Cache.CurrentHouseOwner)
                ExecuteCommand("inv2")
            end, v.storage.identifier, Cache.CurrentHouseOwner)
        end

        local real_word_position = GetOffsetFromEntityInWorldCoords(Cache.shell_object, v.offset.x, v.offset.y, v.offset.z + 0.75)
        while #(GetEntityCoords(PlayerPedId()) - real_word_position) <= 2.5 do
            Wait(50)
        end
        exports["ox_inventory"]:setStashTarget(nil)
    end
end

Wardrobe = function()
    ESX.TriggerServerCallback("loaf_housing:getOutfits", function(outfits)
        local elements = {}
        for k, v in pairs(outfits) do
            table.insert(elements, {label = v, id = k})
        end

        if #elements == 0 then
            table.insert(elements, {label = Strings["no_outfits"], id = false})
        end

        ESX.UI.Menu.Open("default", GetCurrentResourceName(), "select_outfit", {
            title = Strings["select_outfit"],
            align = ((Config.Options and Config.Options.MenuAlign) or ("bottom-right")),
            elements = elements
        }, function(data, menu)
            if data.current.id then
                ESX.UI.Menu.Open("default", GetCurrentResourceName(), "select_wardrobe_action", {
                    title = Strings["select_outfit"],
                    align = ((Config.Options and Config.Options.MenuAlign) or ("bottom-right")),
                    elements = {
                        {label = Strings["equip_outfit"], value = "equip"},
                        {label = Strings["delete_outfit"], value = "delete"},
                    }
                }, function(data2, menu2)
                    if data2.current.value == "equip" then
                        ESX.TriggerServerCallback("loaf_housing:getOutfit", function(outfit)
                            if outfit then
                                TriggerEvent("skinchanger:getSkin", function(skin)
                                    TriggerEvent("skinchanger:loadClothes", skin, outfit)
                                    TriggerEvent("esx_skin:setLastSkin", skin)
            
                                    TriggerEvent("skinchanger:getSkin", function(skin)
                                        TriggerServerEvent("esx_skin:save", skin)
                                    end)
                                end)
                            end
                        end, data.current.id)
                    elseif data2.current.value == "delete" then
                        ESX.UI.Menu.Open("default", GetCurrentResourceName(), "confirm_delete_outfit", {
                            title = (Strings["confirm_delete"]):format(data.current.label),
                            align = ((Config.Options and Config.Options.MenuAlign) or ("bottom-right")),
                            elements = {
                                {label = Strings["no"], value = "no"},
                                {label = Strings["yes"], value = "yes"},
                            }
                        }, function(data3, menu3)
                            menu3.close()
                            if data3.current.value == "yes" then
                                TriggerServerEvent("loaf_housing:delete_outfit", data.current.id)
                                ESX.UI.Menu.CloseAll()
                            end
                        end, function(data3, menu3)
                            menu3.close()
                        end)
                    end
                end, function(data2, menu2)
                    menu2.close()
                end)
            end
        end, function(data, menu)
            menu.close()
        end)
    end)
end

OpenStorage = function(houseid, k, v)
    ESX.UI.Menu.CloseAll()

    ESX.UI.Menu.Open("default", GetCurrentResourceName(), "select_storage_wardrobe", {
        title = Strings["storage_wardrobe"],
        align = ((Config.Options and Config.Options.MenuAlign) or ("bottom-right")),
        elements = {
            {label = Strings["storage_option"], value = "storage"},
            {label = Strings["wardrobe_option"], value = "wardrobe"},
        }
    }, function(data, menu)
        if data.current.value == "storage" then
            StorageMenu(houseid, k, v)
        elseif data.current.value == "wardrobe" then
            Wardrobe()
        end
    end, function(data, menu)
        menu.close()
    end)
end

ManageHouse = function(houseid)
    local housedata = Config.Houses[tonumber(houseid)]

    local shouldSell

    elements = {
        {label = Strings["make_key_copy"], value = "key"},
        {label = Strings["transfer_house"], value = "transfer"},
        {label = string.format(Strings["resell_house"], FormatNumber(RoundInt(housedata.Price * (Config.ResellHouse.ResellPercent / 100)))), value = "sell"},
    }

    if Config.Options.AllowChangeLock then
        table.insert(elements, {label = Strings["change_lock"], value = "change_lock"})
    end

    ESX.UI.Menu.Open("default", GetCurrentResourceName(), "select_option_house", {
        title = housedata.Label,
        align = ((Config.Options and Config.Options.MenuAlign) or ("bottom-right")),
        elements = elements
    }, function(data, menu)
        if data.current.value == "key" or data.current.value == "sell" or data.current.value == "change_lock" then
            ESX.UI.Menu.Open("default", GetCurrentResourceName(), "confirm_sell", {
                title = data.current.label,
                align = ((Config.Options and Config.Options.MenuAlign) or ("bottom-right")),
                elements = {
                    {label = Strings["yes"], value = "yes"},
                    {label = Strings["no"], value = "no"},
                }
            }, function(data2, menu2)
                if data.current.value == "sell" then
                    if data2.current.value == "yes" then
                        shouldSell = true
                        ESX.UI.Menu.CloseAll()
                    else
                        menu2.close()
                    end
                elseif data.current.value == "key" then
                    if data2.current.value == "yes" then
                        TriggerServerEvent("loaf_housing:copyKey", houseid)
                        menu2.close()
                    else
                        menu2.close()
                    end
                elseif data.current.value == "change_lock" then
                    if data2.current.value == "yes" then
                        TriggerServerEvent("loaf_housing:changeLock", houseid)
                        menu2.close()
                    else
                        menu2.close()
                    end
                end
            end, function(data2, menu2)
                menu2.close()
            end)
        elseif data.current.value == "transfer" then
            local elements = {}
            for k, v in pairs(GetActivePlayers()) do
                if v ~= PlayerId() then
                    local ped = GetPlayerPed(v)
                    if #(GetEntityCoords(PlayerPedId()) - GetEntityCoords(ped)) <= 5.0 then
                        local foundName, startedSearch, name = false, GetGameTimer(), GetPlayerName(v) .. " | " .. GetPlayerServerId(v)
                        
                        ESX.TriggerServerCallback("loaf_housing:getName", function(n)
                            if n then
                                name = n
                            end
                            foundName = true
                        end, GetPlayerServerId(v))

                        while not foundName do
                            if GetGameTimer() - startedSearch > 3000 then
                                break
                            end

                            Wait(50)
                        end

                        table.insert(elements, {
                            label = name,
                            value = GetPlayerServerId(v),
                            ped = ped,
                        })
                    end
                end
            end

            if #elements == 0 then
                table.insert(elements, {label = Strings["none_nearby"], value = "none"})
            end

            ESX.UI.Menu.Open("default", GetCurrentResourceName(), "select_player", {
                title = data.current.label,
                align = ((Config.Options and Config.Options.MenuAlign) or ("bottom-right")),
                elements = elements
            }, function(data2, menu2)
                local player = data2.current.value
                if player ~= "none" then
                    ESX.UI.Menu.Open("default", GetCurrentResourceName(), "confirm_transfer", {
                        title = string.format(Strings["transfer_property"], data2.current.label),
                        align = ((Config.Options and Config.Options.MenuAlign) or ("bottom-right")), 
                        elements = {
                            {label = Strings["yes"], value = "yes"},
                            {label = Strings["no"], value = "no"},
                        },
                    }, function(data3, menu3)
                        if #(GetEntityCoords(PlayerPedId()) - GetEntityCoords(data2.current.ped)) <= 5.0 then
                            if data3.current.value == "yes" then
                                ESX.TriggerServerCallback("loaf_housing:transferOwnership", function(success)
                                    if success then
                                        ESX.UI.Menu.CloseAll()
                                    end
                                end, player, houseid)
                            else
                                menu3.close()
                            end
                        else
                            ESX.ShowNotification(Strings["nolonger_nearby"])
                        end
                    end, function(data3, menu3)
                        menu3.close()
                    end)
                end
            end, function(data2, menu2)
                menu2.close()
            end)
        end
    end, function(data, menu)
        menu.close()
    end)

    -- wait for the menu to open (just in case)
    while not ESX.UI.Menu.IsOpen("default", GetCurrentResourceName(), "select_option_house") do
        Wait(50)
    end
    -- wait for the menu to close
    while ESX.UI.Menu.IsOpen("default", GetCurrentResourceName(), "select_option_house") do
        Wait(50)
    end

    -- selling house part, done here to prevent infinite money glitch
    if shouldSell then
        local selling = true
        AddTextEntry("LOADING", Strings["selling_house"])
        BeginTextCommandBusyspinnerOn("LOADING")
        EndTextCommandBusyspinnerOn(3)
        ESX.TriggerServerCallback("loaf_housing:sellHouse", function(sold)
            selling = false
            if sold then
                ESX.ShowNotification(Strings["sold_house"])
            else
                ESX.ShowNotification(Strings["couldnt_sell"])
            end
        end, houseid)
        while selling do
            Wait(50)
        end
        BusyspinnerOff()
    end
end

OpenSellMenuIKEA = function()
    local InMenu = true

    ESX.TriggerServerCallback("loaf_housing:getFurniture", function(furniture)
        local elements = {}
        for k, v in pairs(furniture) do
            table.insert(elements, {
                label = string.format("x%s %s ($%s)", v.amount, v.label, RoundInt(v.price * (Config.IKEA.ResellPercent / 100))),
                value = k,
            })
        end

        ESX.UI.Menu.Open("default", GetCurrentResourceName(), "select_furniture_sell", {
            title = Strings["ikea"],
            align = ((Config.Options and Config.Options.MenuAlign) or ("bottom-right")),
            elements = elements
        }, function(data, menu)
            local furniture_data = furniture[data.current.value]

            ESX.UI.Menu.Open("dialog", GetCurrentResourceName(), "amount_sell'", {
                title = string.format(Strings["amount_of"], furniture_data.label)
            }, function(data2, menu2)
                local amount = tonumber(data2.value)

                if amount ~= nil then
                    if amount > furniture_data.amount then
                        ESX.ShowNotification(Strings["dont_have"])
                    else
                        TriggerServerEvent("loaf_housing:sellFurniture", data.current.value, amount)
                        ESX.UI.Menu.CloseAll()
                    end
                else
                    ESX.ShowNotification(Strings["must_be_number"])
                end
            end, function(data2, menu2)
                menu2.close()
            end)
            
        end, function(data, menu)
            menu.close()
        end)

        while ESX.UI.Menu.IsOpen("default", GetCurrentResourceName(), "select_furniture_sell") do
            Wait(50)
        end

        InMenu = false
    end)

    Wait(1000) -- prevent ppl from spamming the request 

    while InMenu do 
        Wait(50) 
    end
end

local natives = {
    object   = {FindFirstObject,  FindNextObject,  EndFindObject},
    ped      = {FindFirstPed,     FindNextPed,     EndFindPed},
    vehicle  = {FindFirstVehicle, FindNextVehicle, EndFindVehicle}
}

GetEntities = function(type)
    local entities = {}
    local functions = natives[type]
    local handle, ent, success = functions[1]()

    repeat
        success, entity = functions[2](handle)
        if DoesEntityExist(entity) then
            table.insert(entities, entity)
        end
    until(not success)

    functions[3](handle)
    return entities
end

RegisterNetEvent("loaf_housing:alertPolice")
AddEventHandler("loaf_housing:alertPolice", function(houseInformation)
    if ESX.GetPlayerData() and ESX.GetPlayerData().job then
        if ESX.GetPlayerData().job.name == Config.LockPicking.Police then
            ESX.ShowNotification(Strings["robbery_progress"])
            local blip = AddBlip(houseInformation.Entrance.xyz, 1, 6, Strings["robbery"])
            SetBlipRoute(blip, true)
            Wait(5 * 60 * 1000) -- 5 min, then delete blip
            SetBlipRoute(blip, false)
            RemoveBlip(blip)
        end
    end
end) 

CreateThread(function()
    while true do
        Wait(3000)
        if Cache.RemoveModels then
            for k, v in pairs(Cache.RemoveModels) do
                if GetGameTimer() <= v.Remove then
                    SetModelAsNoLongerNeeded(v.Model)
                    table.remove(Cache.RemoveModels, k)
                end
            end
        end
    end
end)

CreateThread(function()
    while true do
        Wait(3000)

        if Cache.ManageTimeAndWeather then
            if GetResourceState("cd_easytime") == "started" then
                TriggerEvent("cd_easytime:PauseSync", true)
                while Cache.ManageTimeAndWeather do
                    Wait(50)
                end
                TriggerEvent("cd_easytime:PauseSync", false)
            else
                TriggerEvent("ToggleWeatherSync", false) -- toggles weather sync "off". You will have to implement this event to your weather sync resource.

                SetRainFxIntensity(0.0) -- trying to remove puddles but this doesn't seem to do it
                while Cache.ManageTimeAndWeather do
                    Wait(50)
                    NetworkOverrideClockTime(17, 0, 0)
                    ClearOverrideWeather()
                    ClearWeatherTypePersist()
                    SetWeatherTypePersist("EXTRASUNNY")
                    SetWeatherTypeNow("EXTRASUNNY")
                    SetWeatherTypeNowPersist("EXTRASUNNY")
                end

                TriggerEvent("ToggleWeatherSync", true) --  toggles weather sync "on". You will have to implement this event to your weather sync resource.
            end
        end
    end
end)

RegisterNetEvent("loaf_housing:get_shells")
AddEventHandler("loaf_housing:get_shells", function(cb)
    if cb then 
        cb(Config.Shells) 
    end
end)

RegisterNetEvent("loaf_housing:get_houses")
AddEventHandler("loaf_housing:get_houses", function(cb)
    if cb then 
        cb(Config.Houses) 
    end
end)

exports("InHouse", function(houseid)
    if houseid and tonumber(houseid) then
        return (Cache.InHouse and tonumber(Cache.houseid) == tonumber(houseid))
    else
        return Cache.inshell
    end
end)

exports("CurrentHouse", function()
    return Cache.houseid
end)