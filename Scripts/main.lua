print(" --- STAT MOD ENABLED ---")
print(" Each command will set the game mode to offline to promote offline play")
print(" --- Commands: ---")
print(" --- F2: Lots of vigor ---")
print(" --- F3: Super health, stamina, magic and item discovery ---")
print(" --- F4: Max level all weapons in inventory ---")
print(" --- F5: Toggle infinite consumable use for items that are considered usable in your inventory ---")



local function has_playerChar(attributeSet)
    return string.find(attributeSet:GetFullName(), "AnathemaPlayerCharacter_BP_C")
end

local setOfflineMode = function()
    local hexUserGameSettings = FindAllOf("HexGameUserSettings")
    if hexUserGameSettings then
        for _, hexUserGameSetting in ipairs(hexUserGameSettings) do
            hexUserGameSetting:SetOnlineModeEnabled(false)
        end
    end
end

-- Lots of vigor
RegisterKeyBind(Key.F2, {}, function()
    setOfflineMode()

    local vigorAttributeSet = FindAllOf("VigorAttributeSet")
    if vigorAttributeSet then
        for _, attributeSet in pairs(vigorAttributeSet) do
            if has_playerChar(attributeSet) then
                attributeSet.Vigor.BaseValue = 99999999
                attributeSet.Vigor.CurrentValue = 99999999
                print("Vigor set to 99999999")
            end
        end
    end
end)

-- Super health, stamina, magic and item discovery
RegisterKeyBind(Key.F3, {}, function()
    setOfflineMode()

    local basicAttributeSet = FindAllOf("BasicAttributeSet")
    if basicAttributeSet then
        for _, attributeSet in pairs(basicAttributeSet) do
            if has_playerChar(attributeSet) then
                attributeSet.MaxHealth.BaseValue = 99999999
                attributeSet.MaxHealth.CurrentValue = 99999999
                attributeSet.Health.BaseValue = 99999999
                attributeSet.Health.CurrentValue = 99999999
                attributeSet.MaxStamina.BaseValue = 99999999
                attributeSet.MaxStamina.CurrentValue = 99999999
                attributeSet.Stamina.BaseValue = 99999999
                attributeSet.Stamina.CurrentValue = 99999999
                attributeSet.MaxMagic.BaseValue = 99999999
                attributeSet.MaxMagic.CurrentValue = 99999999
                attributeSet.Magic.BaseValue = 99999999
                attributeSet.Magic.CurrentValue = 99999999
                attributeSet.ItemDiscovery.BaseValue = 99999999
                attributeSet.ItemDiscovery.CurrentValue = 99999999
                print("Super Health, Stamina, Magic and Item Discovery set to 99999999")
            end
        end
    end
end)

-- Max level all weapons in inventory
RegisterKeyBind(Key.F4, {}, function()
    setOfflineMode()

    local EquippableInventoryWeapons = FindAllOf("EquipableInventoryWeapon")
    if EquippableInventoryWeapons then
        for _, equippableInventoryWeapon in pairs(EquippableInventoryWeapons) do
            equippableInventoryWeapon.ItemLevel = equippableInventoryWeapon:GetMaxItemLevel()
        end
    end
    local RangedInventoryWeapons = FindAllOf("EquipableInventoryRangedWeapon")
    if RangedInventoryWeapons then
        for _, equippableInventoryWeapon in pairs(RangedInventoryWeapons) do
            equippableInventoryWeapon.ItemLevel = equippableInventoryWeapon:GetMaxItemLevel()
        end
    end
    local SoulsLanterns = FindAllOf("EquipableInventorySoulsLantern")
    if SoulsLanterns then
        for _, lantern in pairs(SoulsLanterns) do
            lantern.ItemLevel = lantern:GetMaxItemLevel()
        end
    end

    print("Max level all weapons in inventory set")
end)


-- toggle infinite consumable use for items that are considered usable in your inventory
local consume_on_usage = true
RegisterKeyBind(Key.F5, {}, function()
    setOfflineMode()

    local InventoryItems = FindAllOf("InventoryItem")
    local itemNames = {}
    if InventoryItems then
        consume_on_usage = not consume_on_usage

        for _, inventoryItem in pairs(InventoryItems) do
            if inventoryItem:IsUsable() then
                table.insert(itemNames, inventoryItem:GetItemName():ToString())
                local itemData = inventoryItem:GetItemData()
                itemData.bConsumedOnUsage = consume_on_usage
            end
        end
        local consume_on_usage_text = consume_on_usage and "ON" or "OFF"
        print("Consume on usage set to " ..
            consume_on_usage_text .. " for the following items: \n " .. table.concat(itemNames, "\n "))
    end
end)
