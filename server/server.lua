RedEM = exports["redem_roleplay"]:RedEM()

RegisterCommand('dv', function(source, args, rawCommand)
    local _source = source
    TriggerClientEvent('kfo_admin:dv', _source)
end)

RegisterCommand('nc', function(source, args, rawCommand)
    local _source = source
    local Player = RedEM.GetPlayer(_source)
    if Player then
        if exports.kfo_permissions.checkPlayerJob(Player.source, 'Admin', Player.identifier, Player.charid) then
            TriggerClientEvent('kfo_admin:nc', Player.source)
            sendLogComandoAdminUsado(Player.identifier, Player.charid, '/nc', args)
        else
            sendLogComandoAdminTentado(Player.identifier, Player.charid, '/nc')
            TriggerClientEvent('redem_roleplay:Tip', Player.source, "Você não tem permissão para acessar este comando.", 7000)
        end
    end
end)

RegisterCommand('ped', function(source, args, rawCommand)
    local _source = source
    local Player = RedEM.GetPlayer(_source)
    if Player then
        if exports.kfo_permissions.checkPlayerJob(Player.source, 'Admin', Player.identifier, Player.charid) then
            if args[1] then
                TriggerClientEvent('kfo_admin:ped', Player.source, args)
                sendLogComandoAdminUsado(Player.identifier, Player.charid, '/ped', args)
            else
                TriggerClientEvent('redem_roleplay:Tip', Player.source, "Você deve usar /ped [modelo de ped].", 7000)
            end
        else
            sendLogComandoAdminTentado(Player.identifier, Player.charid, '/ped', args)
            TriggerClientEvent('redem_roleplay:Tip', Player.source, "Você não tem permissão para acessar este comando.", 7000)
        end
    end
end)

RegisterCommand('god', function(source, args, rawCommand)
    local _source = source
    local Player = RedEM.GetPlayer(_source)
    if Player then
        if exports.kfo_permissions.checkPlayerJob(Player.source, 'Admin', Player.identifier, Player.charid) then
            if not args[1] then
                TriggerClientEvent('kfo_admin:god', Player.source)
                sendLogComandoAdminUsado(Player.identifier, Player.charid, '/god', args)

            else
                TriggerClientEvent('redem_roleplay:Tip', Player.source, "Este comando não suporta god em outros players.", 7000)
            end
        else
            sendLogComandoAdminTentado(Player.identifier, Player.charid, '/god', args)
            TriggerClientEvent('redem_roleplay:Tip', Player.source, "Você não tem permissão para acessar este comando.", 7000)
        end
    end
end)
    

RegisterCommand('setped', function(source, args, rawCommand)
    local _source = source
    local Player = RedEM.GetPlayer(_source)
    if Player then
        if exports.kfo_permissions.checkPlayerJob(Player.source, 'Admin', Player.identifier, Player.charid) then
            if args[1] and args[2] and args[3] then
                local skins = MySQL.Sync.fetchAll('SELECT * FROM SKINS WHERE identifier = @identifier and charid = @charid', {identifier = args[1], charid = tonumber(args[2])})
                local temp = json.decode(skins[1].skin)
                temp.model = args[3]
                temp.outfitPed = "0"
                MySQL.Sync.execute('UPDATE skins set skin = @fSkin WHERE identifier = @identifier and charid = @charid', {fSkin = json.encode(temp), identifier = args[1], charid = tonumber(args[2])})
                TriggerClientEvent('redem_roleplay:Tip', Player.source, "Setado com sucesso ped "..args[3]..' para '..args[1]..' [ '..args[2]..' ]', 7000)
                sendLogComandoAdminUsado(Player.identifier, Player.charid, '/setped', args)
            else
                TriggerClientEvent('redem_roleplay:Tip', Player.source, "Você deve usar /setped [steam hex] [charid] [modelo de ped].", 7000)
            end
        else
            sendLogComandoAdminTentado(Player.identifier, Player.charid, '/setped', args)
            TriggerClientEvent('redem_roleplay:Tip', Player.source, "Você não tem permissão para acessar este comando.", 7000)
        end
    end
end)

RegisterCommand('removeped', function(source, args, rawCommand)
    local _source = source
    local Player = RedEM.GetPlayer(_source)
    if Player then
        if exports.kfo_permissions.checkPlayerJob(Player.source, 'Admin', Player.identifier, Player.charid) then
            if args[1] and args[2] then
                local skins = MySQL.Sync.fetchAll('SELECT * FROM SKINS WHERE identifier = @identifier and charid = @charid', {identifier = args[1], charid = tonumber(args[2])})
                local temp = json.decode(skins[1].skin)
                temp.model = nil
                temp.outfitPed = nil
                MySQL.Sync.execute('UPDATE skins set skin = @fSkin WHERE identifier = @identifier and charid = @charid', {fSkin = json.encode(temp), identifier = args[1], charid = tonumber(args[2])})
                TriggerClientEvent('redem_roleplay:Tip', Player.source, "Ped removido da hex "..args[1]..' [ '..args[2]..' ]', 7000)
                sendLogComandoAdminUsado(Player.identifier, Player.charid, '/removeped', args)
            else
                TriggerClientEvent('redem_roleplay:Tip', Player.source, "Você deve usar /removeped [steam hex] [charid]", 7000)
            end
        else
            sendLogComandoAdminTentado(Player.identifier, Player.charid, '/removeped',args)
            TriggerClientEvent('redem_roleplay:Tip', Player.source, "Você não tem permissão para acessar este comando.", 7000)
        end
    end
end)

RegisterCommand('outfit', function(source, args)
    local _source = source
    local Player = RedEM.GetPlayer(_source)
    if Player then
        if exports.kfo_permissions.checkPlayerJob(Player.source, 'Admin', Player.identifier, Player.charid) then
            if args[1] then
                local skins = MySQL.Sync.fetchAll('SELECT * FROM SKINS WHERE identifier = @identifier and charid = @charid', {identifier = Player.identifier, charid = Player.charid})
                local temp = json.decode(skins[1].skin)
                
                if temp.model then
                    temp.outfitPed = args[1]
                    MySQL.Sync.execute('UPDATE skins set skin = @fSkin WHERE identifier = @identifier and charid = @charid', {fSkin = json.encode(temp), identifier = Player.identifier, charid = Player.charid})
                    TriggerClientEvent('kfo_admin:outfitPreset', Player.source, args[1])
                else
                    TriggerClientEvent('redem_roleplay:Tip', Player.source, "Esse comando só funciona para peds", 7000)
                end
            else
                TriggerClientEvent('redem_roleplay:Tip', Player.source, "Você deve usar /outfit [número]", 7000)
            end
        end
    end
end)

-- RegisterCommand('status+', function(source, args, rawCommand)
--     local _source = source
--     local Player = RedEM.GetPlayer(_source)
--     if Player then
--         if exports.kfo_permissions.checkPlayerJob(Player.source, 'Admin', Player.identifier, Player.charid) then
--             TriggerClientEvent('kfo_admin:status', Player.source, '+')
--             sendLogComandoAdminUsado(Player.identifier, Player.charid, '/status+', args)
--         else
--             sendLogComandoAdminTentado(Player.identifier, Player.charid, '/status+')
--             TriggerClientEvent('redem_roleplay:Tip', Player.source, "Você não tem permissão para acessar este comando.", 7000)
--         end
--     end
-- end)

-- RegisterCommand('status-', function(source, args, rawCommand)
--     local _source = source
--     local Player = RedEM.GetPlayer(_source)
--         if exports.kfo_permissions.checkPlayerJob(Player.source, 'Admin', Player.identifier, Player.charid) then
--             TriggerClientEvent('kfo_admin:status', _source, '-')
--             sendLogComandoAdminUsado(Player.identifier, Player.charid, '/status-', args)
--         else
--             sendLogComandoAdminTentado(Player.identifier, Player.charid, '/status-')
--             TriggerClientEvent('redem_roleplay:Tip', _source, "Você não tem permissão para acessar este comando.", 7000)
--         end
--     end)
-- end)

RegisterCommand('tpwayp', function(source, args, rawCommand)
    local _source = source
    local Player = RedEM.GetPlayer(_source)
    if Player then
        if exports.kfo_permissions.checkPlayerJob(Player.source, 'Admin', Player.identifier, Player.charid) then
            TriggerClientEvent('kfo_admin:tpwayp', Player.source)
            sendLogComandoAdminUsado(Player.identifier, Player.charid, '/tpwayp', args)
        else
            sendLogComandoAdminTentado(Player.identifier, Player.charid, '/tpwayp')
            TriggerClientEvent('redem_roleplay:Tip', Player.source, "Você não tem permissão para acessar este comando.", 7000)
        end
    end
end)

RegisterCommand('veh', function(source, args, rawCommand)
    local _source = source
    local Player = RedEM.GetPlayer(_source)
    if Player then
        if exports.kfo_permissions.checkPlayerJob(Player.source, 'Admin', Player.identifier, Player.charid) then
            if args[1] then
                TriggerClientEvent('kfo_admin:veh', Player.source, args[1])
                sendLogComandoAdminUsado(Player.identifier, Player.charid, '/veh', args)
            else
                TriggerClientEvent('redem_roleplay:Tip', Player.source, "Use /veh [nome do veículo]", 7000)

            end
        else
            sendLogComandoAdminTentado(Player.identifier, Player.charid, '/veh',args)
            TriggerClientEvent('redem_roleplay:Tip', Player.source, "Você não tem permissão para acessar este comando.", 7000)
        end
    end
end)
    
    
RegisterCommand('spawnped', function(source, args, rawCommand)
    local _source = source
    local Player = RedEM.GetPlayer(_source)
    if Player then
        if exports.kfo_permissions.checkPlayerJob(Player.source, 'Admin', Player.identifier, Player.charid) then
            if args[1] then
                TriggerClientEvent('kfo_admin:spawnped', Player.source, args[1], args[2] or nil)
                sendLogComandoAdminUsado(Player.identifier, Player.charid, '/spawnped', args)
            else
                TriggerClientEvent('redem_roleplay:Tip', Player.source, "Use /spawnped [ped] [*Outfit]", 7000)
            end
        else
            sendLogComandoAdminTentado(Player.identifier, Player.charid, '/spawnped',args)
            TriggerClientEvent('redem_roleplay:Tip', Player.source, "Você não tem permissão para acessar este comando.", 7000)
        end
    end
end)
    
RegisterCommand('cavalo', function(source, args, rawCommand)
    local _source = source
    local Player = RedEM.GetPlayer(_source)
    if Player then
        if exports.kfo_permissions.checkPlayerJob(Player.source, 'Admin', Player.identifier, Player.charid) then
            if args[1] then
                TriggerClientEvent('kfo_admin:spawnped', Player.source, 'A_C_HORSE_MUSTANG_BLACKOVERO', args[2] or nil)
                sendLogComandoAdminUsado(Player.identifier, Player.charid, '/cavalo', args)
            else
                TriggerClientEvent('redem_roleplay:Tip', Player.source, "Use /cavalo [ped] [*Outfit]", 7000)
            end
        else
            sendLogComandoAdminTentado(Player.identifier, Player.charid, '/cavalo',args)
            TriggerClientEvent('redem_roleplay:Tip', Player.source, "Você não tem permissão para acessar este comando.", 7000)
        end
    end
end)

RegisterCommand('charusuario', function(source, args)
    local _source = source
    local Player = RedEM.GetPlayer(_source)
    if Player then
        if exports.kfo_permissions.checkPlayerJob(Player.source, 'Admin', Player.identifier, Player.charid) then
            if args[1] then
                MySQL.Async.fetchAll("SELECT * FROM characters WHERE identifier = @identifier", {identifier = args[1]}, function(result)
                    if result[1] then
                        TriggerClientEvent('redem_roleplay:Tip', Player.source, 'Verifique seu F8.', 7000)
                        sendLogComandoAdminUsado(Player.identifier, Player.charid, '/charusuario', args)
                        TriggerClientEvent('kfo_admin:charID', Player.source, result)
                    end
                end)
            else
                TriggerClientEvent('redem_roleplay:Tip', Player.source, "Você deve usar /charusuario [hex]", 7000)
            end
        else
            sendLogComandoAdminTentado(Player.identifier, Player.charid, '/charusuario',args)
            TriggerClientEvent('redem_roleplay:Tip', Player.source, "Você não tem permissão para acessar este comando.", 7000)
        end
    end
end)