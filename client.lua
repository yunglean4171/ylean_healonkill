local Bullet = { 453432689, 1593441988, 584646201, -1716589765, 324215364, 736523883, -270015777, -1074790547, -2084633992, -1357824103, -1660422300, 2144741730, 487013001, 2017895192, -494615257, -1654528753, 100416529, 205991906, 1119849093 }
local Knife = { -1716189206, 1223143800, -1955384325, -1833087301, 910830060 }
local Melee = { -1569615261, 1737195953, 1317494643, -1786099057, 1141786504, -2067956739, -868994466 }

RegisterNetEvent('ylean:restore_health_cl')
AddEventHandler('ylean:restore_health_cl', function()
    local targetPlayer = GetPlayerPed(PlayerId())
    local currentHealth = GetEntityHealth(targetPlayer)

    if currentHealth < Ylean.MaxHealth and (currentHealth + Ylean.Heal <= Ylean.MaxHealth) then
        SetEntityHealth(targetPlayer, currentHealth + Ylean.Heal)
    else
        SetEntityHealth(targetPlayer, Ylean.MaxHealth)
    end
end)

Citizen.CreateThread(function()
    local alreadyDead = false

    while true do
        Citizen.Wait(50)
        local playerPed = GetPlayerPed(-1)
        if IsEntityDead(playerPed) and not alreadyDead then
            local killerEntity = GetPedKiller(playerPed)
            local killerType = GetEntityType(killerEntity)

            if killerType == 1 then
                -- killer is a ped, get the player controlling it
                local killerPlayer = NetworkGetPlayerIndexFromPed(killerEntity)
                local killerId = GetPlayerServerId(killerPlayer)

                local death = GetPedCauseOfDeath(playerPed)

                if checkArray(Bullet, death) then
                    TriggerServerEvent('ylean:restore_health_ss', killerId)
                elseif checkArray(Melee, death) then
                    TriggerServerEvent('ylean:restore_health_ss', killerId)
                elseif checkArray(Knife, death) then
                    TriggerServerEvent('ylean:restore_health_ss', killerId)
                end

            end

            alreadyDead = true
        end

        if not IsEntityDead(playerPed) then
            alreadyDead = false
        end
    end
end)

function checkArray (array, val)
    for name, value in ipairs(array) do
        if value == val then
            return true
        end
    end
    return false
end
