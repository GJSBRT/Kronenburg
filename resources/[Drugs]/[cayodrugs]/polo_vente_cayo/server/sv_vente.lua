-- Vente Heroïne + Policier

ESX = nil
--policeCount = 0
--local CopsConnected = 0

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterServerEvent("Illegal:Cocaine")
AddEventHandler("Illegal:Cocaine", function(nombre)
    local xPlayer = ESX.GetPlayerFromId(source)
    TriggerClientEvent("Illegal:SetItemTraiter", -1)
end)

RegisterServerEvent("Illegal:VenteCocaine")
AddEventHandler("Illegal:VenteCocaine", function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local nombre = xPlayer.getInventoryItem("cocaine_pooch")
    local count = 1
    local price = nombre.count * 1550
    xPlayer.addAccountMoney('black_money', price)
    xPlayer.removeInventoryItem("cocaine_pooch", nombre.count)
    TriggerClientEvent("Illegal:VenteNotifCocaine", source, nombre.count, price)
end)

RegisterServerEvent("Illegal:Solvants")
AddEventHandler("Illegal:Solvants", function(nombre)
    local xPlayer = ESX.GetPlayerFromId(source)
    TriggerClientEvent("Illegal:SetItemTraiter", -1)
end)

RegisterServerEvent("Illegal:VenteSolvants")
AddEventHandler("Illegal:VenteSolvants", function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local nombre = xPlayer.getInventoryItem("solvants_pooch")
    local count = 1
    local price = nombre.count * 900
    xPlayer.addAccountMoney('black_money', price)
    xPlayer.removeInventoryItem("solvants_pooch", nombre.count)
    TriggerClientEvent("Illegal:VenteNotifSolvants", source, nombre.count, price)
end)

RegisterServerEvent("Illegal:Cannabis")
AddEventHandler("Illegal:Cannabis", function(nombre)
    local xPlayer = ESX.GetPlayerFromId(source)
    TriggerClientEvent("Illegal:SetItemTraiter", -1)
end)

RegisterServerEvent("Illegal:VenteCannabis")
AddEventHandler("Illegal:VenteCannabis", function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local nombre = xPlayer.getInventoryItem("cannabis_pooch")
    local count = 1
    local price = nombre.count * 750
    xPlayer.addAccountMoney('black_money', price)
    xPlayer.removeInventoryItem("cannabis_pooch", nombre.count)
    TriggerClientEvent("Illegal:VenteNotifCannabis", source, nombre.count, price)
end)