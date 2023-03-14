local QBCore = exports['qb-core']:GetCoreObject()
local PlayerJob = QBCore.Functions.GetPlayerData().job
local menu = MenuV:CreateMenu(false, 'Boss Menu', 'topright', 255, 255, 0, 'size-100', 'template', 'menuv', 'default')

-- Option to change stash coordinates
local changeStashCoords = menu:AddButton({ icon = '💼', label = 'Change Stash Coords' })
changeStashCoords:On('select', function()
    local newCoords = {} -- Update with new coordinates

    -- Set new coordinates here, for example:
    newCoords.x = GetEntityCoords(PlayerPedId()).x
    newCoords.y = GetEntityCoords(PlayerPedId()).y
    newCoords.z = GetEntityCoords(PlayerPedId()).z

    -- Send new coordinates to server
    TriggerServerEvent('saveCoords', 'stash', newCoords)

    QBCore.Functions.Notify('Stash coordinates updated', 'primary')

end)

-- Option to change garage coordinates
local changeGarageCoords = menu:AddButton({ icon = '🚗', label = 'Change Garage Coords' })
changeGarageCoords:On('select', function()
    local newCoords = {} -- Update with new coordinates

    -- Set new coordinates here, for example:
    newCoords.x = GetEntityCoords(PlayerPedId()).x
    newCoords.y = GetEntityCoords(PlayerPedId()).y
    newCoords.z = GetEntityCoords(PlayerPedId()).z

    -- Send new coordinates to server
    TriggerServerEvent('saveCoords', 'garage', newCoords)

    QBCore.Functions.Notify('Garage coordinates updated', 'primary')

end)


RegisterCommand('ojp', function()
    MenuV:OpenMenu(menu)
end)

-- Draw stash marker
-- Draw stash marker
CreateThread(function()
    while true do
        Wait(1)

        local pos = GetEntityCoords(PlayerPedId())
         local PlayerJob = QBCore.Functions.GetPlayerData().job
            -- Get job's coordinates from server using TriggerCallback
            QBCore.Functions.TriggerCallback('GetCurrentJobStashCoords', function(stashCoords)
                        DrawText3Ds(stashCoords.x, stashCoords.y, stashCoords.z, "~g~E~w~ - stash ")

                        if IsControlJustReleased(0, 38) then
                            print('Opening stash for ' .. PlayerJob.name)
                            TriggerServerEvent("inventory:server:OpenInventory", "stash", PlayerJob.name, {
                                maxweight = 4000000,
                                slots = 500,
                            })
                            TriggerEvent("inventory:client:SetCurrentStash", PlayerJob.name)
                        end
                
            end, PlayerJob.name)       

    end
end)

function DrawText3Ds(x, y, z, text)
	SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end