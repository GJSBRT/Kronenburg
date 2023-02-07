ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

function GetComponents(player, weapon)
    local xPlayer = ESX.GetPlayerFromId(player)

    if xPlayer.hasWeapon(weapon) then
        local _, weaponObject = ESX.GetWeapon(weapon)
        local weaponComponentList = weaponObject.components or {}

        local weaponComponents = {}

        for i = 1, #weaponComponentList do 
            local weaponComponent = weaponComponentList[i].name
            if xPlayer.hasWeaponComponent(weapon, weaponComponent) then 
                table.insert(weaponComponents, weaponComponent)
            end
        end

        return weaponComponents
    else
        return false
    end
end
exports("GetComponents", GetComponents)

function SetComponents(player, weapon, components)
    local xPlayer = ESX.GetPlayerFromId(player)

    if xPlayer.hasWeapon(weapon) then
        for i = 1, #components do
            xPlayer.addWeaponComponent(weapon, components[i])
        end
        return true
    else
        return false
    end
end
exports("SetComponents", SetComponents)

function MatchComponents(components1, components2)
    if #components1 == #components2 then
        local check1 = true
        for i = 1, #components1 do
            local hasComponent = false
            local checkComponent = components1[i]
            for j = 1, #components2 do
                local itemComponent = components2[i]
                if checkComponent == itemComponent then
                    hasComponent = true
                end
            end
            if hasComponent == false then
                check1 = false
            end
        end

        local check2 = true
        for i = 1, #components2 do
            local hasComponent = false
            local itemComponent = components2[i]
            for j = 1, #components1 do
                local checkComponent = components1[i]
                if checkComponent == itemComponent then
                    hasComponent = true
                end
            end
            if hasComponent == false then
                check2 = false
            end
        end

        if check1 and check2 then
            return true
        else
            return false
        end
    else
        return false
    end
end
exports("MatchComponents", MatchComponents)