Config = {}

Config.HealDuration = 10000 -- Treatment time in milliseconds
Config.HealCost = 500 -- Price for treatment

Config.ProgressBar = {
    label = "U are getting cured...",
    duration = 10000, -- Time how long the progress bar itself will take
    useWhileDead = false,
    canCancel = false,
    disable = { move = false, car = false, combat = false }
}

Config.Beds = { -- Here you can set multiple beds where players will spawn after they check in
    {
        coords = vector3(330.6280, -584.8519, 44.1241),
        heading = 161.8664
    }
}

Config.NPC = {
    model = "s_m_m_doctor_01", -- NPC Model
    coords = vector4(310.5243, -585.8871, 43.2690, 109.0546), -- NPC and Target Coords
    targetLabel = "Check in"
}

Config.AfterHealCoords = vector3(325.0420, -579.0796, 43.2676) -- Where player should be teleported after treatment

Config.Messages = {
    healed = "You were treated for %s$",
    registered = "You have checked in.",
    notEnoughMoney = "You dont have enough money for treatment.",
}
