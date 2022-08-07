ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end

    local PlayerPed = GetPlayerPed(-1)
    while true do 
        local Interval = 850
        local pos = GetEntityCoords(PlayerPed)
        local Distance = _zTeleportPad.Distance
        local DistanceToUse = _zTeleportPad.DistanceToUse

        for _,P in pairs(_zTeleportPad.Point) do
            local dist1 = #(P.P1.position - pos)
            local dist2 = #(P.P2.position - pos)

            if dist1 < Distance then
                Interval = 1
                DrawMarker(_zTeleportPad.DrawMarker.Type, P.P1.position, 0.0, 0.0, 0.0, 90.0, 180.0, 0.0, _zTeleportPad.DrawMarker.Size.x, _zTeleportPad.DrawMarker.Size.y, _zTeleportPad.DrawMarker.Size.z, 54, 120, 255, 200, false, true, p19, false, false, false, false)
            
                if dist1 < DistanceToUse then
                    ESX.ShowHelpNotification(P.P1.Indicatif)
                    if IsControlJustPressed(0, 51) then
                        print("Teleport to P2")
                        local pos1 = P.P2.position
                        local heading = GetEntityHeading(PlayerPed)
                        SetEntityCoords(PlayerPed, pos1.x, pos1.y, pos1.z)
                        SetEntityHeading(PlayerPed, heading)
                    end
                end
            end
            if dist2 < Distance then
                Interval = 1 
                DrawMarker(_zTeleportPad.DrawMarker.Type, P.P2.position, 0.0, 0.0, 0.0, 90.0, 180.0, 0.0, _zTeleportPad.DrawMarker.Size.x, _zTeleportPad.DrawMarker.Size.y, _zTeleportPad.DrawMarker.Size.z, 54, 120, 255, 200, false, true, p19, false, false, false, false)
            
                if dist2 < DistanceToUse then
                    ESX.ShowHelpNotification(P.P2.Indicatif)
                    if IsControlJustPressed(0, 51) then
                        print("Teleport to P1")
                        local pos2 = P.P1.position
                        local heading = GetEntityHeading(PlayerPed)
                        SetEntityCoords(PlayerPed, pos2.x, pos2.y, pos2.z)
                        SetEntityHeading(PlayerPed, heading)
                    end
                end
            end
        end 

        Wait(Interval)
    end
end)