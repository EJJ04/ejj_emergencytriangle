lib.locale()

local ESX, QBCore

if GetResourceState('es_extended') == 'started' then
    ESX = exports['es_extended']:getSharedObject()
elseif GetResourceState('qb-core') == 'started' then
    QBCore = exports['qb-core']:GetCoreObject()
else
    -- Add your own framework here if needed
end

if ESX then
    ESX.RegisterUsableItem('emergencytriangle', function(playerId)
        TriggerClientEvent('ejj_emergencytriangle:addPropToPlayerAndAnim', playerId, Config.EmergencyTriangle.model, 57005, 0.10, -1.0, 0.0, -90.0, -250.0, 0.0)
    end)
end

if QBCore then
    QBCore.Functions.CreateUseableItem('emergencytriangle', function(source)
        TriggerClientEvent('ejj_emergencytriangle:addPropToPlayerAndAnim', source, Config.EmergencyTriangle.model, 57005, 0.10, -1.0, 0.0, -90.0, -250.0, 0.0)
    end)
end

RegisterNetEvent('ejj_emergencytriangle:giveitem')
AddEventHandler('ejj_emergencytriangle:giveitem', function()
    local xPlayer = ESX.GetPlayerFromId(source)

        exports.ox_inventory:AddItem(source, 'emergencytriangle', 1)
end)

RegisterNetEvent('ejj_emergencytriangle:removeitem')
AddEventHandler('ejj_emergencytriangle:removeitem', function(propModel)
    local playerId = source

    if 'emergencytriangle' then
        if ESX then
            local xPlayer = ESX.GetPlayerFromId(playerId)
            xPlayer.removeInventoryItem('emergencytriangle', 1) 
        elseif QBCore then
            local identifier = QBCore.Functions.GetIdentifier(playerId)
            exports['qb-inventory']:RemoveItem(identifier, 'emergencytriangle', 1) 
        end
    else
        print("Item name not found for prop model: " .. propModel)
    end
end)