local QBCore = exports['qb-core']:GetCoreObject()

-- Simple command to open shop menu
RegisterCommand("weaponshop", function()
    local menu = {}
    for _, weapon in pairs(Config.Weapons) do
        menu[#menu+1] = {
            header = weapon.label .. " - $" .. weapon.price,
            txt = "Buy this weapon",
            params = {
                event = "qb-weaponshop:client:buyWeapon",
                args = { model = weapon.model, label = weapon.label, price = weapon.price }
            }
        }
    end
    exports['qb-menu']:openMenu(menu)
end)

RegisterNetEvent("qb-weaponshop:client:buyWeapon", function(data)
    TriggerServerEvent("qb-weaponshop:server:buyWeapon", data.model, data.label, data.price)
end)
