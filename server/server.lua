RegisterCommand('dv', function(source, args, rawCommand)
    local _source = source
    TriggerEvent('redemrp:getPlayerFromId', _source, function(user)
        if exports.kfo_permissions.checkPlayerJob(_source, 'Admin', user.getIdentifier(), user.getSessionVar('charid')) then
            TriggerClientEvent('kfo_admin:dv', _source)
        else
            TriggerClientEvent('redem_roleplay:Tip', _source, "Você não tem permissão para acessar este comando.", 7000)
        end
    end)
end)

RegisterCommand('nc', function(source, args, rawCommand)
    local _source = source
    TriggerEvent('redemrp:getPlayerFromId', _source, function(user)
        if exports.kfo_permissions.checkPlayerJob(_source, 'Admin', user.getIdentifier(), user.getSessionVar('charid')) then
            TriggerClientEvent('kfo_admin:nc', _source)
        else
            TriggerClientEvent('redem_roleplay:Tip', _source, "Você não tem permissão para acessar este comando.", 7000)
        end
    end)
end)

RegisterCommand('status+', function(source, args, rawCommand)
    local _source = source
    TriggerEvent('redemrp:getPlayerFromId', _source, function(user)
        if exports.kfo_permissions.checkPlayerJob(_source, 'Admin', user.getIdentifier(), user.getSessionVar('charid')) then
            TriggerClientEvent('kfo_admin:status', _source, '+')
        else
            TriggerClientEvent('redem_roleplay:Tip', _source, "Você não tem permissão para acessar este comando.", 7000)
        end
    end)
end)

RegisterCommand('status-', function(source, args, rawCommand)
    local _source = source
    TriggerEvent('redemrp:getPlayerFromId', _source, function(user)
        if exports.kfo_permissions.checkPlayerJob(_source, 'Admin', user.getIdentifier(), user.getSessionVar('charid')) then
            TriggerClientEvent('kfo_admin:status', _source, '-')
        else
            TriggerClientEvent('redem_roleplay:Tip', _source, "Você não tem permissão para acessar este comando.", 7000)
        end
    end)
end)

RegisterCommand('tpwayp', function(source, args, rawCommand)
    local _source = source
    TriggerEvent('redemrp:getPlayerFromId', _source, function(user)
        if exports.kfo_permissions.checkPlayerJob(_source, 'Admin', user.getIdentifier(), user.getSessionVar('charid')) then
            TriggerClientEvent('kfo_admin:tpwayp', _source)
        else
            TriggerClientEvent('redem_roleplay:Tip', _source, "Você não tem permissão para acessar este comando.", 7000)
        end
    end)
end)

RegisterCommand('veh', function(source, args, rawCommand)
    local _source = source
    TriggerEvent('redemrp:getPlayerFromId', _source, function(user)
        if exports.kfo_permissions.checkPlayerJob(_source, 'Admin', user.getIdentifier(), user.getSessionVar('charid')) then
            if args[1] then
                TriggerClientEvent('kfo_admin:veh', _source, args[1])
            else
                TriggerClientEvent('redem_roleplay:Tip', _source, "Use /veh [nome do veículo]", 7000)
            end
        else
            TriggerClientEvent('redem_roleplay:Tip', _source, "Você não tem permissão para acessar este comando.", 7000)
        end
    end)
end)

RegisterCommand('spawnped', function(source, args, rawCommand)
    local _source = source
    TriggerEvent('redemrp:getPlayerFromId', _source, function(user)
        if exports.kfo_permissions.checkPlayerJob(_source, 'Admin', user.getIdentifier(), user.getSessionVar('charid')) then
            if args[1] then
                TriggerClientEvent('kfo_admin:spawnped', _source, args[1], args[2] or nil)
            else
                TriggerClientEvent('redem_roleplay:Tip', _source, "Use /spawnped [ped] [*Outfit]", 7000)
            end
        else
            TriggerClientEvent('redem_roleplay:Tip', _source, "Você não tem permissão para acessar este comando.", 7000)
        end
    end)
end)

RegisterCommand('charusuario', function(source, args)
    local _source = source
    TriggerEvent('redemrp:getPlayerFromId', _source, function(user)
        if exports.kfo_permissions.checkPlayerJob(_source, 'Admin', user.getIdentifier(), user.getSessionVar('charid')) then
            if args[1] then
                MySQL.Async.fetchAll("SELECT * FROM characters WHERE identifier = @identifier", {identifier = args[1]}, function(result)
                    if result[1] then
                        TriggerClientEvent('redem_roleplay:Tip', _source, 'Verifique seu F8.', 7000)
                        TriggerClientEvent('kfo_admin:charID', _source, result)
                    end
                end)
            else
                TriggerClientEvent('redem_roleplay:Tip', _source, "Você deve usar /charusuario [hex]", 7000)
            end
        else
            TriggerClientEvent('redem_roleplay:Tip', _source, "Você não tem permissão para acessar este comando.", 7000)
        end
    end)
end)

RegisterCommand('tp', function(source, args)
    local _source = source
    TriggerEvent('redemrp:getPlayerFromId', _source, function(user)
        if exports.kfo_permissions.checkPlayerJob(_source, 'Admin', user.getIdentifier(), user.getSessionVar('charid')) then
            if args[1] then
                TriggerClientEvent('kfo_admin:tp', _source, args[1])
            else
                TriggerClientEvent('redem_roleplay:Tip', _source, "Você deve usar /tp [id].", 7000)
            end
        else
            TriggerClientEvent('redem_roleplay:Tip', _source, "Você não tem permissão para acessar este comando.", 7000)
        end
    end)
end)

RegisterNetEvent('kfo_adminS:tp')
AddEventHandler('kfo_adminS:tp', function(playerPed)
    print(source)
    local targetPed = GetPlayerPed(playerPed)
    local ped = GetPlayerPed(source)
    local x,y,z = GetEntityCoords(targetPed)
    SetEntityCoords(ped, x, y, z, false, false, false, false)
end)