local knights_protection = {
    "wh_dlc07_trait_brt_knights_vow_knowledge_pledge", 
    "wh_dlc07_trait_brt_knights_vow_order_pledge",
    "wh_dlc07_trait_brt_knights_vow_chivalry_pledge",
    "wh_dlc07_trait_brt_protection_troth_knowledge_pledge",
    "wh_dlc07_trait_brt_protection_troth_order_pledge",
    "wh_dlc07_trait_brt_protection_troth_chivalry_pledge"
} --: vector<string>

local questing_wisdom = {
    "wh_dlc07_trait_brt_questing_vow_campaign_pledge",
    "wh_dlc07_trait_brt_questing_vow_heroism_pledge",
    "wh_dlc07_trait_brt_questing_vow_protect_pledge",
    "wh_dlc07_trait_brt_wisdom_troth_campaign_pledge",
    "wh_dlc07_trait_brt_wisdom_troth_heroism_pledge",
    "wh_dlc07_trait_brt_wisdom_troth_protect_pledge"
} --: vector<string>

local grail_virtue = {
    "wh_dlc07_trait_brt_grail_vow_untaint_pledge",
    "wh_dlc07_trait_brt_grail_vow_valour_pledge",
    "wh_dlc07_trait_brt_grail_vow_destroy_pledge",
    "wh_dlc07_trait_brt_virtue_troth_untaint_pledge",
    "wh_dlc07_trait_brt_virtue_troth_valour_pledge",
    "wh_dlc07_trait_brt_virtue_troth_destroy_pledge"
} --: vector<string>

--v function(character: CA_CHAR, pledge_table: vector<string>) --> boolean
local function has_pledge(character, pledge_table)
    for i = 1, #pledge_table do
        if character:has_trait(pledge_table[i]) then 
            return true
        end
    end  
    return false
end

function fix_multiple_vows()
    core:remove_listener("Vow_CharacterCreated")
    -- Allows player to skip the early Vows at high enough Chivalry
    core:add_listener(
        "fix_Vow_CharacterCreated",
        "CharacterCreated",
        true,
        function(context)
            local character = context:character()
            if character:character_type("general") == true then
                local faction = context:character():faction()
                if faction:is_human() == true and faction:culture() == "wh_main_brt_bretonnia" then
                    if faction:has_effect_bundle("wh_dlc07_bretonnia_chivalry_bar_801_1000") == true then
                        if not has_pledge(character, knights_protection) and not has_pledge(character, questing_wisdom) then
                            for i = 1, 6 do
                                add_vow_progress(character, "wh_dlc07_trait_brt_knights_vow_knowledge_pledge", true, false)
                            end
                            for i = 1, 6 do
                                add_vow_progress(character, "wh_dlc07_trait_brt_questing_vow_protect_pledge", true, false)
                            end
                        end
                    elseif faction:has_effect_bundle("wh_dlc07_bretonnia_chivalry_bar_601_800") == true then
                        if not has_pledge(character, knights_protection) then
                            for i = 1, 6 do
                                add_vow_progress(character, "wh_dlc07_trait_brt_knights_vow_knowledge_pledge", true, false)
                            end
                        end
                    elseif faction:has_effect_bundle("wh_dlc07_bretonnia_chivalry_bar_401_600") == true then
                        if not has_pledge(character, knights_protection) then
                            for i = 1, 6 do
                                add_vow_progress(character, "wh_dlc07_trait_brt_knights_vow_knowledge_pledge", true, false)
                            end
                        end
                    end
                end
            end
        end,
        true
    )
end