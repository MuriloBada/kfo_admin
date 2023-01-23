RegisterCommand('dv', function(source, args, rawCommand)
    local _source = source
    TriggerClientEvent('kfo_admin:dv', _source)
end)

RegisterCommand('nc', function(source, args, rawCommand)
    local _source = source
    TriggerEvent('redemrp:getPlayerFromId', _source, function(user)
        if exports.kfo_permissions.checkPlayerJob(_source, 'Admin', user.getIdentifier(), user.getSessionVar('charid')) then
            TriggerClientEvent('kfo_admin:nc', _source)
            sendLogComandoAdminUsado(user.getIdentifier(), user.getSessionVar('charid'), '/nc', args)
        else
            sendLogComandoAdminTentado(user.getIdentifier(), user.getSessionVar('charid'), '/nc')
            TriggerClientEvent('redem_roleplay:Tip', _source, "Você não tem permissão para acessar este comando.", 7000)
        end
    end)
end)

RegisterCommand('setped', function(source, args, rawCommand)
    local _source = source
    TriggerEvent('redemrp:getPlayerFromId', _source, function(user)
        if exports.kfo_permissions.checkPlayerJob(_source, 'Admin', user.getIdentifier(), user.getSessionVar('charid')) then
            if args[1] and args[2] and args[3] then
                local skins = MySQL.Sync.fetchAll('SELECT * FROM SKINS WHERE identifier = @identifier and charid = @charid', {identifier = args[1], charid = tonumber(args[2])})
                local temp = json.decode(skins[1].skin)
                temp.model = args[3]
                temp.outfitPed = "0"
                MySQL.Sync.execute('UPDATE skins set skin = @fSkin WHERE identifier = @identifier and charid = @charid', {fSkin = json.encode(temp), identifier = args[1], charid = tonumber(args[2])})
                TriggerClientEvent('redem_roleplay:Tip', _source, "Setado com sucesso ped "..args[3]..' para '..args[1]..' [ '..args[2]..' ]', 7000)
                sendLogComandoAdminUsado(user.getIdentifier(), user.getSessionVar('charid'), '/setped', args)
            else
                TriggerClientEvent('redem_roleplay:Tip', _source, "Você deve usar /setped [steam hex] [charid] [modelo de ped].", 7000)
            end
        else
            sendLogComandoAdminTentado(user.getIdentifier(), user.getSessionVar('charid'), '/setped', args)
            TriggerClientEvent('redem_roleplay:Tip', _source, "Você não tem permissão para acessar este comando.", 7000)
        end
    end)
end)

RegisterCommand('removeped', function(source, args, rawCommand)
    local _source = source
    TriggerEvent('redemrp:getPlayerFromId', _source, function(user)
        if exports.kfo_permissions.checkPlayerJob(_source, 'Admin', user.getIdentifier(), user.getSessionVar('charid')) then
            if args[1] and args[2] then
                local skins = MySQL.Sync.fetchAll('SELECT * FROM SKINS WHERE identifier = @identifier and charid = @charid', {identifier = args[1], charid = tonumber(args[2])})
                local temp = json.decode(skins[1].skin)
                temp.model = nil
                temp.outfitPed = nil
                MySQL.Sync.execute('UPDATE skins set skin = @fSkin WHERE identifier = @identifier and charid = @charid', {fSkin = json.encode(temp), identifier = args[1], charid = tonumber(args[2])})
                TriggerClientEvent('redem_roleplay:Tip', _source, "Ped removido da hex "..args[1]..' [ '..args[2]..' ]', 7000)
                sendLogComandoAdminUsado(user.getIdentifier(), user.getSessionVar('charid'), '/removeped', args)
            else
                TriggerClientEvent('redem_roleplay:Tip', _source, "Você deve usar /removeped [steam hex] [charid]", 7000)
            end
        else
            sendLogComandoAdminTentado(user.getIdentifier(), user.getSessionVar('charid'), '/removeped',args)
            TriggerClientEvent('redem_roleplay:Tip', _source, "Você não tem permissão para acessar este comando.", 7000)
        end
    end)
end)

RegisterCommand('outfit', function(source, args)
    local _source = source
    
    TriggerEvent('redemrp:getPlayerFromId', _source, function(user)
        if args[1] then
            local skins = MySQL.Sync.fetchAll('SELECT * FROM SKINS WHERE identifier = @identifier and charid = @charid', {identifier = user.getIdentifier(), charid = user.getSessionVar('charid')})
            local temp = json.decode(skins[1].skin)
            
            if temp.model then
                temp.outfitPed = args[1]
                MySQL.Sync.execute('UPDATE skins set skin = @fSkin WHERE identifier = @identifier and charid = @charid', {fSkin = json.encode(temp), identifier = user.getIdentifier(), charid = user.getSessionVar('charid')})
                TriggerClientEvent('kfo_admin:outfitPreset', source, args[1])
            else
                TriggerClientEvent('redem_roleplay:Tip', _source, "Esse comando só funciona para peds", 7000)
            end
        else
            TriggerClientEvent('redem_roleplay:Tip', _source, "Você deve usar /outfit [número]", 7000)
        end
    end)
end)

RegisterCommand('status+', function(source, args, rawCommand)
    local _source = source
    TriggerEvent('redemrp:getPlayerFromId', _source, function(user)
        if exports.kfo_permissions.checkPlayerJob(_source, 'Admin', user.getIdentifier(), user.getSessionVar('charid')) then
            TriggerClientEvent('kfo_admin:status', _source, '+')
            sendLogComandoAdminUsado(user.getIdentifier(), user.getSessionVar('charid'), '/status+', args)
        else
            sendLogComandoAdminTentado(user.getIdentifier(), user.getSessionVar('charid'), '/status+')
            TriggerClientEvent('redem_roleplay:Tip', _source, "Você não tem permissão para acessar este comando.", 7000)
        end
    end)
end)

RegisterCommand('status-', function(source, args, rawCommand)
    local _source = source
    TriggerEvent('redemrp:getPlayerFromId', _source, function(user)
        if exports.kfo_permissions.checkPlayerJob(_source, 'Admin', user.getIdentifier(), user.getSessionVar('charid')) then
            TriggerClientEvent('kfo_admin:status', _source, '-')
            sendLogComandoAdminUsado(user.getIdentifier(), user.getSessionVar('charid'), '/status-', args)
        else
            sendLogComandoAdminTentado(user.getIdentifier(), user.getSessionVar('charid'), '/status-')
            TriggerClientEvent('redem_roleplay:Tip', _source, "Você não tem permissão para acessar este comando.", 7000)
        end
    end)
end)

RegisterCommand('tpwayp', function(source, args, rawCommand)
    local _source = source
    TriggerEvent('redemrp:getPlayerFromId', _source, function(user)
        if exports.kfo_permissions.checkPlayerJob(_source, 'Admin', user.getIdentifier(), user.getSessionVar('charid')) then
            TriggerClientEvent('kfo_admin:tpwayp', _source)
            sendLogComandoAdminUsado(user.getIdentifier(), user.getSessionVar('charid'), '/tpwayp', args)
        else
            sendLogComandoAdminTentado(user.getIdentifier(), user.getSessionVar('charid'), '/tpwayp')
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
                sendLogComandoAdminUsado(user.getIdentifier(), user.getSessionVar('charid'), '/veh', args)
            else
                TriggerClientEvent('redem_roleplay:Tip', _source, "Use /veh [nome do veículo]", 7000)

            end
        else
            sendLogComandoAdminTentado(user.getIdentifier(), user.getSessionVar('charid'), '/veh',args)
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
                sendLogComandoAdminUsado(user.getIdentifier(), user.getSessionVar('charid'), '/spawnped', args)
            else
                TriggerClientEvent('redem_roleplay:Tip', _source, "Use /spawnped [ped] [*Outfit]", 7000)
            end
        else
            sendLogComandoAdminTentado(user.getIdentifier(), user.getSessionVar('charid'), '/spawnped',args)
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
                        sendLogComandoAdminUsado(user.getIdentifier(), user.getSessionVar('charid'), '/charusuario', args)
                        TriggerClientEvent('kfo_admin:charID', _source, result)
                    end
                end)
            else
                TriggerClientEvent('redem_roleplay:Tip', _source, "Você deve usar /charusuario [hex]", 7000)
            end
        else
            sendLogComandoAdminTentado(user.getIdentifier(), user.getSessionVar('charid'), '/charusuario',args)
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
                sendLogComandoAdminUsado(user.getIdentifier(), user.getSessionVar('charid'), '/tp', args)
            else
                TriggerClientEvent('redem_roleplay:Tip', _source, "Você deve usar /tp [id].", 7000)
            end
        else
            sendLogComandoAdminTentado(user.getIdentifier(), user.getSessionVar('charid'), '/tp',args)
            TriggerClientEvent('redem_roleplay:Tip', _source, "Você não tem permissão para acessar este comando.", 7000)
        end
    end)
end)

-- RegisterCommand('wl', function(source, args)
--     local _source = source
--     TriggerEvent('redemrp:getPlayerFromId', _source, function(user)
--         if exports.kfo_permissions.checkPlayerJob(_source, 'Admin', user.getIdentifier(), user.getSessionVar('charid')) then
--             if args[1] then
--                 local result = MySQL.Sync.fetchAll('SELECT * FROM users where identifier = @identifier', {identifier = args[1]})

--                 if result[1] then
--                     MySQL.Sync.execute('UPDATE users set whitelisted = 1 where identifier = @identifier', {identifier = args[1]})
--                     TriggerClientEvent('redem_roleplay:Tip', _source, "Whitelist concedida ao "..args[1], 7000)
--                 else
--                     TriggerClientEvent('redem_roleplay:Tip', _source, "Essa steam hex não existe no banco de dados.", 7000)
--                 end
--             else
--                 TriggerClientEvent('redem_roleplay:Tip', _source, "Você deve usar /wl [Steam Hex].", 7000)
--             end
--         else
--             TriggerClientEvent('redem_roleplay:Tip', _source, "Você não tem permissão para acessar este comando.", 7000)
--         end
--     end)
-- end)

-- RegisterCommand('unwl', function(source, args)
--     local _source = source
--     TriggerEvent('redemrp:getPlayerFromId', _source, function(user)
--         if exports.kfo_permissions.checkPlayerJob(_source, 'Admin', user.getIdentifier(), user.getSessionVar('charid')) then
--             if args[1] then
--                 local result = MySQL.Sync.fetchAll('SELECT * FROM users where identifier = @identifier', {identifier = args[1]})

--                 if result[1] then
--                     MySQL.Sync.execute('UPDATE users set whitelisted = 0 where identifier = @identifier', {identifier = args[1]})
--                     TriggerClientEvent('redem_roleplay:Tip', _source, "Whitelist removida do "..args[1], 7000)
--                 else
--                     TriggerClientEvent('redem_roleplay:Tip', _source, "Essa steam hex não existe no banco de dados.", 7000)
--                 end
--             else
--                 TriggerClientEvent('redem_roleplay:Tip', _source, "Você deve usar /unwl [Steam Hex].", 7000)
--             end
--         else
--             TriggerClientEvent('redem_roleplay:Tip', _source, "Você não tem permissão para acessar este comando.", 7000)
--         end
--     end)
-- end)

RegisterNetEvent('kfo_adminS:tp')
AddEventHandler('kfo_adminS:tp', function(playerPed)
    print(source)
    local targetPed = GetPlayerPed(playerPed)
    local ped = GetPlayerPed(source)
    local x,y,z = GetEntityCoords(targetPed)
    SetEntityCoords(ped, x, y, z, false, false, false, false)
end)