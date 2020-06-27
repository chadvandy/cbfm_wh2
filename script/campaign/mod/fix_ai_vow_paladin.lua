local knights_protection = {
    "wh_dlc07_trait_brt_knights_vow_knowledge_pledge_agent", 
    "wh_dlc07_trait_brt_knights_vow_order_pledge_agent",
    "wh_dlc07_trait_brt_knights_vow_chivalry_pledge_agent"
} --: vector<string>

local questing_wisdom = {
    "wh_dlc07_trait_brt_questing_vow_campaign_pledge_agent",
    "wh_dlc07_trait_brt_questing_vow_heroism_pledge_agent",
    "wh_dlc07_trait_brt_questing_vow_protect_pledge_agent"
} --: vector<string>

local grail_virtue = {
    "wh_dlc07_trait_brt_grail_vow_untaint_pledge_agent",
    "wh_dlc07_trait_brt_grail_vow_valour_pledge_agent",
    "wh_dlc07_trait_brt_grail_vow_destroy_pledge_agent"
} --: vector<string>

local vow_agents = {
	["brt_paladin"] = true,
	["wh2_dlc14_brt_henri_le_massif"] = true
} --: map<string, boolean>

--v function(character: CA_CHAR, pledge_table: vector<string>) --> boolean
local function has_pledge(character, pledge_table)
    for i = 1, #pledge_table do
        if character:has_trait(pledge_table[i]) then 
            return true
        end
    end  
    return false
end

function fix_ai_vow_paladin()
    -- AI Paladins get the Vows per level
    core:add_listener(
        "fix_paladin_rank_up_vows_per_level_ai",
        "CharacterRankUp",
        true,
        function(context)
            local character = context:character()
            if character:faction():is_human() == false and character:faction():culture() == "wh_main_brt_bretonnia" then
                if vow_agents[character:character_subtype_key()] then
                    if character:rank() >= 2 then
                        if not has_pledge(character, knights_protection) then
                            for i = 1, 6 do
                                add_vow_progress(character, "wh_dlc07_trait_brt_knights_vow_knowledge_pledge_agent", true, false)
                            end
                        end
                    end
                    if character:rank() >= 5 then
                        if not has_pledge(character, questing_wisdom) then
                            for i = 1, 6 do
                                add_vow_progress(character, "wh_dlc07_trait_brt_questing_vow_protect_pledge_agent", true, false)
                            end
                        end
                    end
                    if character:rank() >= 10 then
                        if not has_pledge(character, grail_virtue) then
                            for i = 1, 6 do
                                add_vow_progress(character, "wh_dlc07_trait_brt_grail_vow_valour_pledge_agent", true, false)
                            end
                        end
                    end
                end
            end
        end,
        true
    )
end