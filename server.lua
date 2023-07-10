RegisterNetEvent('ylean:restore_health_ss')
AddEventHandler('ylean:restore_health_ss', function(killer)
    TriggerClientEvent('ylean:restore_health_cl', killer)
end)
