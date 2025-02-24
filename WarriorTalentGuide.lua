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
    [10] = {"Cruelty Rank 1", "Interface\\Icons\\ability_rogue_eviscerate"},
    [11] = {"Cruelty Rank 2", "Interface\\Icons\\ability_rogue_eviscerate"},
    [12] = {"Cruelty Rank 3", "Interface\\Icons\\ability_rogue_eviscerate"},
    [13] = {"Cruelty Rank 4", "Interface\\Icons\\ability_rogue_eviscerate"},
    [14] = {"Cruelty Rank 5", "Interface\\Icons\\ability_rogue_eviscerate"},
    [15] = {"Unbridled Wrath Rank 1", "Interface\\Icons\\spell_nature_stormreach"},
    [16] = {"Unbridled Wrath Rank 2", "Interface\\Icons\\spell_nature_stormreach"},
    [17] = {"Unbridled Wrath Rank 3", "Interface\\Icons\\spell_nature_stormreach"},
    [18] = {"Unbridled Wrath Rank 4", "Interface\\Icons\\spell_nature_stormreach"},
    [19] = {"Unbridled Wrath Rank 5", "Interface\\Icons\\spell_nature_stormreach"},
    [20] = {"Improved Battle Shout Rank 1", "Interface\\Icons\\ability_warrior_battleshout"},
    [21] = {"Improved Battle Shout Rank 2", "Interface\\Icons\\ability_warrior_battleshout"},
    [22] = {"Improved Battle Shout Rank 3", "Interface\\Icons\\ability_warrior_battleshout"},
    [23] = {"Improved Battle Shout Rank 4", "Interface\\Icons\\ability_warrior_battleshout"},
    [24] = {"Improved Battle Shout Rank 5", "Interface\\Icons\\ability_warrior_battleshout"},
    [25] = {"Piercing Howl", "Interface\\Icons\\spell_shadow_deathscream"},
    [26] = {"Enrage Rank 1", "Interface\\Icons\\spell_shadow_unholyfrenzy"},
    [27] = {"Enrage Rank 2", "Interface\\Icons\\spell_shadow_unholyfrenzy"},
    [28] = {"Enrage Rank 3", "Interface\\Icons\\spell_shadow_unholyfrenzy"},
    [29] = {"Enrage Rank 4", "Interface\\Icons\\spell_shadow_unholyfrenzy"},
    [30] = {"Enrage Rank 5", "Interface\\Icons\\spell_shadow_unholyfrenzy"},
    [31] = {"Death Wish", "Interface\\Icons\\spell_shadow_deathpact"},
    [32] = {"Dual Wield Specialization Rank 1", "Interface\\Icons\\ability_dualwieldspecialization"},
    [33] = {"Dual Wield Specialization Rank 2", "Interface\\Icons\\ability_dualwieldspecialization"},
    [34] = {"Dual Wield Specialization Rank 3", "Interface\\Icons\\ability_dualwieldspecialization"},
    [35] = {"Dual Wield Specialization Rank 4", "Interface\\Icons\\ability_dualwieldspecialization"},
    [36] = {"Dual Wield Specialization Rank 5", "Interface\\Icons\\ability_dualwieldspecialization"},
    [37] = {"Flurry Rank 1", "Interface\\Icons\\ability_ghoulfrenzy"},
    [38] = {"Flurry Rank 2", "Interface\\Icons\\ability_ghoulfrenzy"},
    [39] = {"Flurry Rank 3", "Interface\\Icons\\ability_ghoulfrenzy"},
    [40] = {"Flurry Rank 4", "Interface\\Icons\\ability_ghoulfrenzy"},
    [41] = {"Flurry Rank 5", "Interface\\Icons\\ability_ghoulfrenzy"},
    [42] = {"Bloodthirst", "Interface\\Icons\\spell_nature_bloodlust"},
    [43] = {"Improved Rend Rank 1", "Interface\\Icons\\ability_gouge"},
    [44] = {"Improved Rend Rank 2", "Interface\\Icons\\ability_gouge"},
    [45] = {"Improved Rend Rank 3", "Interface\\Icons\\ability_gouge"},
    [46] = {"Deflection Rank 1", "Interface\\Icons\\ability_parry"},
    [47] = {"Deflection Rank 2", "Interface\\Icons\\ability_parry"},
    [48] = {"Tactical Mastery Rank 1", "Interface\\Icons\\spell_nature_enchantarmor"},
    [49] = {"Tactical Mastery Rank 2", "Interface\\Icons\\spell_nature_enchantarmor"},
    [50] = {"Tactical Mastery Rank 3", "Interface\\Icons\\spell_nature_enchantarmor"},
    [51] = {"Tactical Mastery Rank 4", "Interface\\Icons\\spell_nature_enchantarmor"},
    [52] = {"Tactical Mastery Rank 5", "Interface\\Icons\\spell_nature_enchantarmor"},
    [53] = {"Anger Management", "Interface\\Icons\\spell_holy_blessingofstamina"},
    [54] = {"Deep Wounds Rank 1", "Interface\\Icons\\ability_backstab"},
    [55] = {"Deep Wounds Rank 2", "Interface\\Icons\\ability_backstab"},
    [56] = {"Deep Wounds Rank 3", "Interface\\Icons\\ability_backstab"},
    [57] = {"Improved Overpower Rank 1", "Interface\\Icons\\inv_sword_05"},
    [58] = {"Impale Rank 1", "Interface\\Icons\\ability_searingarrow"},
    [59] = {"Impale Rank 2", "Interface\\Icons\\ability_searingarrow"},
    [60] = {"Improved Overpower Rank 2", "Interface\\Icons\\inv_sword_05"},
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
