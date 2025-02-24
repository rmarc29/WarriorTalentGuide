local WarriorTalentGuide = CreateFrame("Frame", "WarriorTalentGuide", UIParent)
WarriorTalentGuide:SetWidth(220)  
WarriorTalentGuide:SetHeight(160)
WarriorTalentGuide:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
WarriorTalentGuide:SetBackdrop({
    bgFile = "Interface/Tooltips/UI-Tooltip-Background",  
    edgeFile = "Interface/Tooltips/UI-Tooltip-Border",    
    tile = true,                                         
    tileSize = 16,                                     
    edgeSize = 16,                                       
    insets = { left = 4, right = 4, top = 4, bottom = 4 } 
})
WarriorTalentGuide:SetBackdropColor(0, 0, 0, 0.8)
WarriorTalentGuide:SetBackdropBorderColor(1, 1, 1, 1)  
WarriorTalentGuide:EnableMouse(true)
WarriorTalentGuide:SetMovable(true)
WarriorTalentGuide:RegisterForDrag("LeftButton")
WarriorTalentGuide:SetScript("OnDragStart", function() WarriorTalentGuide:StartMoving() end)
WarriorTalentGuide:SetScript("OnDragStop", function() WarriorTalentGuide:StopMovingOrSizing() end)

-- Sample talent order (Level -> {Talent Name, Icon Path})
local talentOrder = {
    [10] = {"Improved Rend Rank 1", "Interface\\Icons\\ability_gouge"},
    [11] = {"Improved Rend Rank 2", "Interface\\Icons\\ability_gouge"},
    [12] = {"Improved Rend Rank 3", "Interface\\Icons\\ability_gouge"},
    [13] = {"Deflection Rank 1", "Interface\\Icons\\ability_parry"},
    [14] = {"Deflection Rank 2", "Interface\\Icons\\ability_parry"},
    [15] = {"Improved Charge Rank 1", "Interface\\Icons\\ability_warrior_charge"},
    [16] = {"Improved Charge Rank 2", "Interface\\Icons\\ability_warrior_charge"},
    [17] = {"Tactical Mastery Rank 1", "Interface\\Icons\\spell_nature_enchantarmor"},
    [18] = {"Tactical Mastery Rank 2", "Interface\\Icons\\spell_nature_enchantarmor"},
    [19] = {"Tactical Mastery Rank 3", "Interface\\Icons\\spell_nature_enchantarmor"},
    [20] = {"Improved Overpower Rank 1", "Interface\\Icons\\inv_sword_05"},
    [21] = {"Improved Overpower Rank 2", "Interface\\Icons\\inv_sword_05"},
    [22] = {"Deep Wounds Rank 1", "Interface\\Icons\\ability_backstab"},
    [23] = {"Deep Wounds Rank 2", "Interface\\Icons\\ability_backstab"},
    [24] = {"Deep Wounds Rank 3", "Interface\\Icons\\ability_backstab"},
    [25] = {"Two-Handed Weapon Specialization Rank 1", "Interface\\Icons\\inv_axe_09"},
    [26] = {"Two-Handed Weapon Specialization Rank 2", "Interface\\Icons\\inv_axe_09"},
    [27] = {"Two-Handed Weapon Specialization Rank 3", "Interface\\Icons\\inv_axe_09"},
    [28] = {"Two-Handed Weapon Specialization Rank 4", "Interface\\Icons\\inv_axe_09"},
    [29] = {"Two-Handed Weapon Specialization Rank 5", "Interface\\Icons\\inv_axe_09"},
    [30] = {"Sweeping Strikes", "Interface\\Icons\\ability_rogue_slicedice"},
    [31] = {"Axe Specialization Rank 1", "Interface\\Icons\\inv_axe_06"},
    [32] = {"Axe Specialization Rank 2", "Interface\\Icons\\inv_axe_06"},
    [33] = {"Axe Specialization Rank 3", "Interface\\Icons\\inv_axe_06"},
    [34] = {"Axe Specialization Rank 4", "Interface\\Icons\\inv_axe_06"},
    [35] = {"Axe Specialization Rank 5", "Interface\\Icons\\inv_axe_06"},
    [36] = {"Tactical Mastery Rank 4", "Interface\\Icons\\spell_nature_enchantarmor"},
    [37] = {"Tactical Mastery Rank 5", "Interface\\Icons\\spell_nature_enchantarmor"},
    [38] = {"Anger Management", "Interface\\Icons\\spell_holy_blessingofstamina"},
    [39] = {"Impale Rank 1", "Interface\\Icons\\ability_searingarrow"},
    [40] = {"Mortal Strike", "Interface\\Icons\\ability_warrior_savageblow"},
    [41] = {"Cruelty Rank 1", "Interface\\Icons\\ability_rogue_eviscerate"},
    [42] = {"Cruelty Rank 2", "Interface\\Icons\\ability_rogue_eviscerate"},
    [43] = {"Cruelty Rank 3", "Interface\\Icons\\ability_rogue_eviscerate"},
    [44] = {"Cruelty Rank 4", "Interface\\Icons\\ability_rogue_eviscerate"},
    [45] = {"Cruelty Rank 5", "Interface\\Icons\\ability_rogue_eviscerate"},
    [46] = {"Unbridled Wrath Rank 1", "Interface\\Icons\\spell_nature_stormreach"},
    [47] = {"Unbridled Wrath Rank 2", "Interface\\Icons\\spell_nature_stormreach"},
    [48] = {"Unbridled Wrath Rank 3", "Interface\\Icons\\spell_nature_stormreach"},
    [49] = {"Unbridled Wrath Rank 4", "Interface\\Icons\\spell_nature_stormreach"},
    [50] = {"Unbridled Wrath Rank 5", "Interface\\Icons\\spell_nature_stormreach"},
    [51] = {"Blood Craze Rank 1", "Interface\\Icons\\spell_shadow_summonimp"},
    [52] = {"Blood Craze Rank 2", "Interface\\Icons\\spell_shadow_summonimp"},
    [53] = {"Blood Craze Rank 3", "Interface\\Icons\\spell_shadow_summonimp"},
    [54] = {"Improved Battle Shout Rank 1", "Interface\\Icons\\ability_warrior_battleshout"},
    [55] = {"Improved Battle Shout Rank 2", "Interface\\Icons\\ability_warrior_battleshout"},
    [56] = {"Enrage Rank 1", "Interface\\Icons\\spell_shadow_unholyfrenzy"},
    [57] = {"Enrage Rank 2", "Interface\\Icons\\spell_shadow_unholyfrenzy"},
    [58] = {"Enrage Rank 3", "Interface\\Icons\\spell_shadow_unholyfrenzy"},
    [59] = {"Enrage Rank 4", "Interface\\Icons\\spell_shadow_unholyfrenzy"},
    [60] = {"Enrage Rank 5", "Interface\\Icons\\spell_shadow_unholyfrenzy"},
}

local function UpdateTalentDisplay()
    local level = UnitLevel("player")
    
    for i = 1, 3 do
        local talentLevel = level + (i - 1)
        local talentInfo = talentOrder[talentLevel]
        
        if talentInfo then
            local talentName, iconPath = unpack(talentInfo)
            
            if not WarriorTalentGuide["Talent" .. i] then
                local talentFrame = CreateFrame("Frame", nil, WarriorTalentGuide)
                talentFrame:SetWidth(190)
                talentFrame:SetHeight(30)
                talentFrame:SetPoint("TOP", WarriorTalentGuide, "TOP", 0, -((i - 1) * 35))

                local levelText = talentFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
                levelText:SetPoint("LEFT", talentFrame, "LEFT", 0, -20)
                levelText:SetText("lvl " .. talentLevel .. " :")

                local icon = talentFrame:CreateTexture(nil, "ARTWORK")
                icon:SetWidth(30)
                icon:SetHeight(30)
                icon:SetPoint("LEFT", levelText, "RIGHT", 5, -5)
                icon:SetTexture(iconPath)

                local text = talentFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
                text:SetPoint("LEFT", icon, "RIGHT", 8, 0)  
                text:SetWidth(120)  
                text:SetJustifyH("LEFT")
                text:SetText(talentName)

                talentFrame.levelText = levelText
                talentFrame.icon = icon
                talentFrame.text = text
                WarriorTalentGuide["Talent" .. i] = talentFrame
            else
                local talentFrame = WarriorTalentGuide["Talent" .. i]
                talentFrame.levelText:SetText("lvl " .. talentLevel .. " :")
                talentFrame.icon:SetTexture(iconPath)
                talentFrame.text:SetText(talentName)
            end
        end
    end
end

-- Event handling for level-up updates
WarriorTalentGuide:RegisterEvent("PLAYER_LEVEL_UP")
WarriorTalentGuide:RegisterEvent("PLAYER_ENTERING_WORLD")
WarriorTalentGuide:SetScript("OnEvent", function(self, event, ...) 
    UpdateTalentDisplay()
    if event == "PLAYER_LEVEL_UP" or event == "PLAYER_ENTERING_WORLD" then
        UpdateTalentDisplay()
    end 
end)

-- Initial update
UpdateTalentDisplay()
