core:add_listener(
    "fix_norscan_gods_FactionTurnEnd",
    "FactionTurnEnd",
    function(context)
        return context:faction():subculture() == "wh_main_sc_nor_norsca"
    end,
    function(context) 
        local faction_key = context:faction():name()
		if NORSCAN_GODS[faction_key] then 
			for key, value in pairs(NORSCAN_GODS[faction_key]) do
				Check_God_Favour_Win_Conditions(faction_key, key)
			end
		end
    end,
    true
)

function Check_God_Favour_Win_Conditions(faction_key, god_key)
	local current_favour = NORSCAN_GODS[faction_key][god_key].favour;

	if current_favour >= CHAPTER_3_FAVOUR_REQUIREMENT and not cm:get_saved_value("Give_Final_God_Reward_"..faction_key) then
		cm:complete_scripted_mission_objective("wh_dlc08_objective_03_"..faction_key, "gain_chapter_favour_"..faction_key, true);
		Give_Final_God_Reward(faction_key, god_key);
        cm:set_saved_value("Give_Final_God_Reward_"..faction_key, true)
	end
	if current_favour >= CHAPTER_2_FAVOUR_REQUIREMENT then
		cm:complete_scripted_mission_objective("wh_dlc08_objective_02_"..faction_key, "gain_chapter_favour_"..faction_key, true);
	end
	if current_favour >= CHAPTER_1_FAVOUR_REQUIREMENT then
		cm:complete_scripted_mission_objective("wh_dlc08_objective_01_"..faction_key, "gain_chapter_favour_"..faction_key, true);
	end
	if current_favour >= MAX_NORSCAN_GOD_FAVOUR then
		Trigger_God_Challengers(faction_key, god_key);
		return true;
	end
	return false;
end