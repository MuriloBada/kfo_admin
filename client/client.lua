local noclip = false

--____________________________________[EVENTS]___________________________________
RegisterNetEvent("kfo_admin:spawnped")
AddEventHandler("kfo_admin:spawnped",function(pedModel, outfit)
    local _source = source
    local pedModelHash = GetHashKey(pedModel)
    if not IsModelValid(pedModelHash) then
        print("model is not valid")
        return
    end

    if not HasModelLoaded(pedModelHash) then
        RequestModel(pedModelHash)
        while not HasModelLoaded(pedModelHash) do
            Citizen.Wait(10)
        end
    end
    local x,y,z = table.unpack(GetEntityCoords(PlayerPedId()))
    x = x + (GetEntityForwardX(PlayerPedId()) * 2.0)
    local ped = CreatePed(pedModelHash, x,y,z, GetEntityHeading(PlayerPedId()), 1, 0)
    Citizen.InvokeNative(0x283978A15512B2FE, ped, true)
    Citizen.InvokeNative(0x58A850EAEE20FAA3, ped)

    SetEntityAsMissionEntity(ped)

    SetPedAsGroupMember(ped, GetDefaultRelationshipGroupHash(pedModelHash))

    Citizen.InvokeNative(0xC80A74AC829DDD92, ped, GetDefaultRelationshipGroupHash(pedModelHash))

    if outfit ~= nil then
        SetPedOutfitPreset(ped, tonumber(outfit))
        Citizen.InvokeNative(0x7528720101A807A5, ped, 2)
    end
end)



RegisterNetEvent("kfo_admin:tp")
AddEventHandler("kfo_admin:tp",function(playerID)
    local charid, identifier = exports.kfo_permissions.getPlayerVariables(playerID)
    local players = GetActivePlayers()

    for k, v in pairs(players) do 
        TriggerServerEvent('redemrp:getPlayerFromId', function(user)
            if (charid == user.getSessionVar('charid') and identifier == user.getIdentifier()) then
                TriggerServerEvent('kfo_adminS:tp', k)
            end
        end)
    end
end)

RegisterNetEvent('kfo_admin:outfitPreset')
AddEventHandler('kfo_admin:outfitPreset', function(outfit)
    SetPedOutfitPreset(PlayerPedId(), tonumber(outfit))
end)

RegisterNetEvent('kfo_admin:status')
AddEventHandler('kfo_admin:status', function(operator)
    if operator == '+' then
        TriggerServerEvent('redemrp_status:AddAmount', 100 , 100)
    else
        TriggerServerEvent('redemrp_status:AddAmount', -100 , -100)
    end
end)

RegisterNetEvent("kfo_admin:tpwayp")
AddEventHandler("kfo_admin:tpwayp",function()
    local ply = PlayerPedId()
    if DoesEntityExist(ply) then
        local WaypointV = GetWaypointCoords()

        for height = 1, 1000 do
            SetEntityCoords(ply, WaypointV.x, WaypointV.y, height + 0.0)

            local foundground, groundZ, normal = GetGroundZAndNormalFor_3dCoord(WaypointV.x, WaypointV.y, height + 0.0)
            if foundground then
                SetEntityCoords(ply, WaypointV.x, WaypointV.y, height + 0.0)
                break
            end
            Wait(25)
        end
    end
end)

RegisterNetEvent('kfo_admin:charID')
AddEventHandler('kfo_admin:charID', function(obj)
    print('======================= CHAR USUARIO ==============================')
    for k,v in ipairs(obj) do
        print(k..'# Hex:'..v.identifier..' charID: '..v.characterid..' '..v.firstname..' '..v.lastname)
    end
    print('===================================================================')
end)

RegisterNetEvent('kfo_admin:veh')
AddEventHandler('kfo_admin:veh', function(vehicle)
    local car = GetHashKey(vehicle)

    RequestModel(car)
    while not HasModelLoaded(car) do
        RequestModel(car)
        Citizen.Wait(0)
    end

    local rotate = GetEntityRotation(PlayerPedId())

    local x,y,z = table.unpack(GetEntityCoords(PlayerPedId()))
    vehicle2 = CreateVehicle(car, x, y, z, rotate[3], true, false)
    SetEntityAsMissionEntity(vehicle2, true, true)
    SetVehicleOnGroundProperly(vehicle2)
    SetModelAsNoLongerNeeded(car)
end)


RegisterNetEvent('kfo_admin:nc')
AddEventHandler('kfo_admin:nc', function()
    local playerEntity = GetPlayerEntity()
    noclip = not noclip
    SetEntityInvincible(playerEntity, noclip)
    SetEntityVisible(playerEntity, not noclip)
    SetEntityCollision(playerEntity, not noclip, not noclip)

	while noclip do
        local playerPosition = GetEntityCoords(playerEntity)
        local x, y, z = playerPosition.x, playerPosition.y, playerPosition.z
        local dx, dy, dz = GetCamDirection()
        local speed = 1.0

        SetEntityVelocity(playerEntity, 0.0001, 0.0001, 0.0001)

        if IsControlPressed(0, 0xD9D0E1C0) then
            speed = speed + 10.0
        end

        if IsControlPressed(0, 0xDB096B85) then
            speed = speed - 0.9
        end

        if IsControlPressed(0, 0x8FFC75D6) then
            speed = speed + 3.0
        end

        if IsControlPressed(0, 0x8FD015D8) then
            x = x + speed * dx
            y = y + speed * dy
            z = z + speed * dz
        end

        if IsControlPressed(0, 0xD27782E3) then
            x = x - speed * dx
			y = y - speed * dy
			z = z - speed * dz
        end

        SetEntityCoordsNoOffset(playerEntity, x, y, z, true, true, true)
        Wait(0)
    end
end)

RegisterNetEvent('kfo_admin:dv')
AddEventHandler('kfo_admin:dv', function()
    local pedVector = GetEntityCoords(PlayerPedId())
    local cameraCoord = GetGameplayCamCoord()
    local direction = RotationToDirection(GetGameplayCamRot())
    local lastCoords = vec3(cameraCoord.x + direction.x * 10.0, cameraCoord.y + direction.y * 10.0, cameraCoord.z + direction.z * 10.0)

    local rayHandle = StartShapeTestRay(cameraCoord, lastCoords, -1, PlayerPedId(), 0)
    local _, hit, endCoords, _, entityHit = GetShapeTestResult(rayHandle)

    if hit == 1 and entityHit ~= 0 then
        SetEntityAsMissionEntity(entityHit, true, true)

        DeleteEntity(entityHit)
    end
end)
--______________________________________________________________________________


function RotationToDirection(rotation)
	local adjustedRotation = {
        x = (math.pi / 180) * rotation.x,
		y = (math.pi / 180) * rotation.y,
		z = (math.pi / 180) * rotation.z
	}
	local direction = {
        x = -math.sin(adjustedRotation.z) * math.abs(math.cos(adjustedRotation.x)),
		y = math.cos(adjustedRotation.z) * math.abs(math.cos(adjustedRotation.x)),
		z = math.sin(adjustedRotation.x)
	}
	return direction
end

function GetCamDirection()
    local heading = GetGameplayCamRelativeHeading() + GetEntityHeading(PlayerPedId())
	local pitch = GetGameplayCamRelativePitch()
	local x = -math.sin(heading * math.pi / 180.0)
	local y = math.cos(heading * math.pi / 180.0)
	local z = math.sin(pitch * math.pi / 180.0)
	local len = math.sqrt(x * x + y * y + z *z)
    
    if len ~= 0 then
		x = x / len
		y = y / len
		z = z / len
	end
    return x, y, z
end

function GetPlayerEntity()
    local playerEntity = PlayerPedId()
    
    if IsPedOnMount(playerEntity) then
		playerEntity = GetMount(playerEntity)
    else
        if IsPedInAnyVehicle(playerEntity) then
            playerEntity = GetVehiclePedIsUsing(playerEntity)
        end
    end
    return playerEntity
end

local god = false
RegisterNetEvent('kfo_admin:god')
AddEventHandler('kfo_admin:god', function()
    god = not god
    Citizen.InvokeNative(0xC6258F41D86676E0, PlayerPedId(), 0, 100)

    Citizen.InvokeNative(0xC6258F41D86676E0, PlayerPedId(), 1, 100)

    Citizen.InvokeNative(0xC6258F41D86676E0, PlayerPedId(), 2, 100)
    if god then
        TriggerEvent('redem_roleplay:Tip', "God Ativado", 7000)
        Citizen.InvokeNative(0x4AF5A4C7B9157D14, PlayerPedId(), 0, 1000, true)
        Citizen.InvokeNative(0xF6A7C08DF2E28B28, PlayerPedId(), 0, 1000, true)

        Citizen.InvokeNative(0x4AF5A4C7B9157D14, PlayerPedId(), 1, 1000, true)
        Citizen.InvokeNative(0xF6A7C08DF2E28B28, PlayerPedId(), 1, 1000, true)

        Citizen.InvokeNative(0x4AF5A4C7B9157D14, PlayerPedId(), 2, 1000, true)
        Citizen.InvokeNative(0xF6A7C08DF2E28B28, PlayerPedId(), 2, 1000, true)
    else
        TriggerEvent('redem_roleplay:Tip', "God Desativado", 7000)
    end
    SetPlayerInvincible(GetPlayerIndex(), god)
end)


RegisterNetEvent('kfo_admin:ped')
AddEventHandler('kfo_admin:ped', function(args)
    local modelHash = GetHashKey(args[1])

    if IsModelValid(modelHash) then
        if not HasModelLoaded(modelHash) then
            RequestModel(modelHash)
            while not HasModelLoaded(modelHash) do
                Citizen.Wait(0)
            end
        end
    end

    local oldHealth = GetEntityHealth(PlayerPedId())

    SetPlayerModel(PlayerId(), modelHash, true)

    while not Citizen.InvokeNative(0xA0BC8FAED8CFEB3C, PlayerPedId()) do
        Wait(0)
    end
    SetEntityHealth(PlayerPedId(), oldHealth)
    SetModelAsNoLongerNeeded(args[1])

    Citizen.Wait(200)
    if args[2] ~= nil then
        SetPedOutfitPreset(PlayerPedId(), tonumber(args[2]))
    end
end)

Citizen.CreateThread(function ()
    Wait(1000)
    TriggerEvent('chat:addSuggestion','/dv', 'Deleta a entidade mais próxima (cuidado ao usar)', {})

    TriggerEvent('chat:addSuggestion','/setped', 'Seta um ped em alguém.', {
        {name = "SteamHex", help = "Steam hex da pessoa"},
        {name = "CharID", help = "CharID do personagem (usar /charusuario)"},
        {name = "Ped", help = "Modelo do Ped a ser setado"},
    })
    
    TriggerEvent('chat:addSuggestion','/removeped', 'Remove o ped de alguém.', {
        {name = "SteamHex", help = "Steam hex da pessoa"},
        {name = "CharID", help = "CharID do personagem (usar /charusuario)"},
    })

    TriggerEvent('chat:addSuggestion','/outfit', 'Troca a Outfit do ped', {
        {name = "Número", help = "Número do outfit desejado."},
    })

    TriggerEvent('chat:addSuggestion','/god', 'Torna uma entidade invencível', {
        {name = "ID", help = "ID da pessoa, não é obrigatorio."},
    })
    
    TriggerEvent('chat:addSuggestion','/status+', 'Enche fome e sede', {})
    
    TriggerEvent('chat:addSuggestion','/status-', 'Esvazia fome e sede', {})
    
    TriggerEvent('chat:addSuggestion','/tpwayp', 'Teleporta para o local marcado em seu mapa', {})

    TriggerEvent('chat:addSuggestion','/veh', 'Spawna um veículo', {
        {name = "Veículo", help = "Modelo do veículo (cuidado pra não spawnar trens.)"},
    })

    TriggerEvent('chat:addSuggestion','/ped', 'Se transforma em um Ped', {
        {name = "Ped", help = "Modelo do ped"},
    })

    TriggerEvent('chat:addSuggestion','/spawnped', 'Spawna um ped', {
        {name = "Ped", help = "Modelo do ped"},
    })

    TriggerEvent('chat:addSuggestion','/charusuario', 'Mostra os charID de uma Hex', {
        {name = "SteamHex", help = "Steam hex da pessoa"},
    })

    TriggerEvent('chat:addSuggestion','/tp', 'Teleporta até alguém', {
        {name = "ID", help = "ID da pessoa"},
    })
end)