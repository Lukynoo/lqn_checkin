ESX = exports["es_extended"]:getSharedObject()

RegisterServerEvent("lqn_checkin:tryStartHeal")
AddEventHandler("lqn_checkin:tryStartHeal", function()
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)

    if not xPlayer then return end

    -- Get a player position
    local playerPed = GetPlayerPed(src)
    if not playerPed or playerPed == 0 then return end

    local playerCoords = GetEntityCoords(playerPed)
    local npcCoords = Config.NPC.coords
	
    -- Count distance
    local dist = #(playerCoords - vector3(npcCoords.x, npcCoords.y, npcCoords.z))

    if dist > 20.0 then
        -- If a player attempts to perform a function outside the specified distance, it kicks him for cheating
        DropPlayer(src, "Trying to cheat huh?")
        return
    end

    if xPlayer.getMoney() >= Config.HealCost then
        xPlayer.removeMoney(Config.HealCost)
        TriggerClientEvent("lqn_checkin:startHealing", src)
        TriggerClientEvent('ox_lib:notify', src, { type = 'success', description = (Config.Messages.registered or "") })
    else
        TriggerClientEvent('ox_lib:notify', src, { type = 'error', description = (Config.Messages.notEnoughMoney or "") })
    end
end)


RegisterServerEvent("lqn_checkin:finishHealing")
AddEventHandler("lqn_checkin:finishHealing", function()
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    if not xPlayer then return end

    TriggerClientEvent('ox_lib:notify', src, {
        type = 'success',
        description = string.format(Config.Messages.healed, Config.HealCost)
    })
    TriggerClientEvent('lqn_checkin:teleportAfterHeal', src, Config.AfterHealCoords)
end)
