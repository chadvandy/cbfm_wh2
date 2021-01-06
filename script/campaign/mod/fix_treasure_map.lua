local pirate_factions = {
    "wh2_dlc11_cst_rogue_bleak_coast_buccaneers",
    "wh2_dlc11_cst_rogue_boyz_of_the_forbidden_coast",
    "wh2_dlc11_cst_rogue_freebooters_of_port_royale",
    "wh2_dlc11_cst_rogue_grey_point_scuttlers",
    "wh2_dlc11_cst_rogue_terrors_of_the_dark_straights",
    "wh2_dlc11_cst_rogue_the_churning_gulf_raiders",
    "wh2_dlc11_cst_rogue_tyrants_of_the_black_ocean",
    "wh2_dlc11_cst_shanty_dragon_spine_privateers",
    "wh2_dlc11_cst_shanty_middle_sea_brigands",
    "wh2_dlc11_cst_shanty_shark_straight_seadogs"
}

local vampire_coast_factions = {
    "wh2_dlc11_cst_pirates_of_sartosa",
    "wh2_dlc11_cst_noctilus",
    "wh2_dlc11_cst_the_drowned",
    "wh2_dlc11_cst_vampire_coast"
}

function fix_treasure_map()
    for j = 1, #vampire_coast_factions do	
		local faction = cm:get_faction(vampire_coast_factions[j]) 
		if faction and faction:is_human() then
            core:remove_listener("BattleCompleted_Treasure_Map")
            core:add_listener( 
                "BattleCompleted_Treasure_Map",
                "BattleCompleted",
                function(context) 
                    return cm:pending_battle_cache_human_is_involved();
                end,
                function(context) 
                    local main_defender_faction = cm:pending_battle_cache_get_defender_faction_name(1);
                    local main_attacker_faction = cm:pending_battle_cache_get_attacker_faction_name(1);
                    
                    for i = 1, #pirate_factions do
                        if main_attacker_faction == pirate_factions[i] then
                            if cm:pending_battle_cache_defender_victory() then
                                TriggerTreasureMapMission(main_defender_faction, 30);
                                return;
                            end
                        elseif main_defender_faction == pirate_factions[i] then
                            if cm:pending_battle_cache_attacker_victory() then
                                TriggerTreasureMapMission(main_attacker_faction, 30);
                                return;
                            end
                        end
                    end

                    local main_defender_faction_obj = cm:get_faction(main_defender_faction)
                    local main_attacker_faction_obj = cm:get_faction(main_attacker_faction)
                    
                    if main_attacker_faction_obj and main_attacker_faction_obj:is_human() and main_attacker_faction_obj:culture() == "wh2_dlc11_cst_vampire_coast" and cm:pending_battle_cache_attacker_victory() then
                        TriggerTreasureMapMission(main_attacker_faction, 0);
                    elseif main_defender_faction_obj and main_defender_faction_obj:is_human() and main_defender_faction_obj:culture() == "wh2_dlc11_cst_vampire_coast" and cm:pending_battle_cache_defender_victory() then
                        TriggerTreasureMapMission(main_defender_faction, 0);
                    end	
                end,
                true
            );
        end
    end
end