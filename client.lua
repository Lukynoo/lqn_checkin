local isHealing = false

local function startHealing()

    isHealing = true
	
    local bed = Config.Beds[math.random(#Config.Beds)]
    DoScreenFadeOut(500)
    Wait(500)
    lib.requestAnimDict("anim@gangops@morgue@table@")
    SetEntityCoords(cache.ped, bed.coords.x, bed.coords.y, bed.coords.z)
    SetEntityHeading(cache.ped, bed.heading)
	SetEntityHealth(ped, 200)
    TaskPlayAnim(cache.ped, "anim@gangops@morgue@table@", "ko_front", 8.0, -8.0, -1, 1, 0, false, false, false)
    DoScreenFadeIn(500)

    lib.progressBar(Config.ProgressBar)

    TriggerServerEvent("lqn_checkin:finishHealing")
end

CreateThread(function()
    lib.requestModel(Config.NPC.model)
    local ped = CreatePed(0, Config.NPC.model, Config.NPC.coords.x, Config.NPC.coords.y, Config.NPC.coords.z - 1.0, Config.NPC.coords.w, false, true)
    SetEntityInvincible(ped, true)
    FreezeEntityPosition(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
	
    exports.ox_target:addBoxZone({
        coords = vec3(Config.NPC.coords.x, Config.NPC.coords.y, Config.NPC.coords.z),
        size = vec3(1, 1, 2),
        rotation = Config.NPC.coords.w,
        debug = false,
        options = {
            {
                name = 'checkin_npc',
                icon = 'fa-solid fa-user-doctor',
                label = Config.NPC.targetLabel,
                onSelect = function()
                    TriggerServerEvent("lqn_checkin:tryStartHeal")
                end
            }
        }
    })
	
end)

RegisterNetEvent("lqn_checkin:startHealing", startHealing)

RegisterNetEvent('lqn_checkin:teleportAfterHeal', function(coords)
    DoScreenFadeOut(500)
    Wait(500)
    SetEntityCoords(cache.ped, coords.x, coords.y, coords.z)
    ClearPedTasks(cache.ped)
    DoScreenFadeIn(500)
	
	local ped = PlayerPedId()
    ClearPedBloodDamage(ped)
    ResetPedVisibleDamage(ped)
    ClearPedLastWeaponDamage(ped)
    SetEntityHealth(ped, 200)
	
end)

