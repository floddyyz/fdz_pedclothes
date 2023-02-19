CreateThread(function()
    NPC(FDZ.ModelNPC, FDZ.Position)
    while true do
        local ms = 1000
        local ped = PlayerPedId()
        local pedpos = GetEntityCoords(ped)
        if #(pedpos - FDZ.PositionText) < 2 then
            ms = 0
            text3D(FDZ.PositionText, '~y~E~w~ to change your clothes')
            if IsControlJustPressed(0, 38) then
                TriggerEvent(FDZ.Event)
            end
        end
        Citizen.Wait(ms)
    end
end)

function text3D(coords, text)
    local x, y, z = table.unpack(coords)
    local onScreen, _x, _y = World3dToScreen2d(x,y,z)
    local px,py,pz = table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px, py, pz, x,y,z, 1)

    local scale = (1 / dist) * 2
    local fov = (1 / GetGameplayCamFov()) * 100
    local scale = scale * fov
    if onScreen then
        SetTextScale(0.0 * scale, 0.55 * scale)
        SetTextFont(0)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 255)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(5)
        AddTextComponentString(text)
        DrawText(_x, _y)
    end
end

function NPC(model, x,y,z,h)
    hash = GetHashKey(model)
    RequestModel(hash)
    while not HasModelLoaded(hash) do
        Wait(1)
    end
    createNPC = CreatePed(5, hash, x,y,z,h, false, true)
    FreezeEntityPosition(createNPC, true)
    SetEntityInvincible(createNPC, true)
    SetBlockingOfNonTemporaryEvents(createNPC, true)
    TaskStartScenarioInPlace(createNPC, FDZ.Animation, 0, false)
end