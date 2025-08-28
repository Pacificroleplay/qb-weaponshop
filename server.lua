local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent("qb-weaponshop:server:buyWeapon", function(weaponModel, weaponLabel, price)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end

    -- Check if the player has enough money
    if Player.Functions.GetMoney(Config.PaymentAccount) < price then
        TriggerClientEvent('QBCore:Notify', src, "Not enough money!", "error")
        return
    end

    -- Remove money
    Player.Functions.RemoveMoney(Config.PaymentAccount, price, "weapon-purchase")

    -- Give the weapon normally (QB-Core auto-generates internal serial)
    Player.Functions.AddItem(weaponModel, 1)

    -- Short wait to ensure the item exists in inventory
    Citizen.Wait(50)

    -- Get the weapon from inventory
    local weaponItem = Player.Functions.GetItemByName(weaponModel)

    if weaponItem then
        -- Generate MDT serial
        local mdt_serial = tostring(math.random(10000000, 99999999))

        -- Inject MDT serial into the weapon's info
        weaponItem.info.mdt_serial = mdt_serial

        -- Update the inventory to save the change
        Player.Functions.SetInventoryItem(weaponItem.slot, weaponItem)

        -- Register weapon in MDT using the same serial
        exports.drx_mdt:CreateWeapon(mdt_serial, { source = src }, weaponModel, weaponLabel)

        -- Notify the player
        TriggerClientEvent('QBCore:Notify', src, weaponLabel .. " purchased & registered in MDT!", "success")
    else
        TriggerClientEvent('QBCore:Notify', src, "Error: Weapon not found in inventory", "error")
    end
end)
