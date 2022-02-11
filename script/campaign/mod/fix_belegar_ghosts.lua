
-- CBF: kill_if_AI should be false for all characters!
local belegar_characters = {
	-- Belegar Ironhammer [Lord]
	{forename = "names_name_2147358029", surname = "names_name_2147358036", start_xp = 0, kill_if_AI = false, start_skills = {}},
	-- King Lunn Ironhammer [Thane]
	{forename = "names_name_2147358979", surname = "names_name_2147358036", start_xp = 4200, kill_if_AI = false, start_skills = {"wh_main_skill_all_all_self_blade_master_starter", "wh_main_skill_all_all_self_devastating_charge", "wh_main_skill_all_all_self_hard_to_hit", "wh_main_skill_all_all_self_deadly_blade"}},
	-- Throni Ironbrow [Runesmith]
	{forename = "names_name_2147358988", surname = "names_name_2147358994", start_xp = 4200, kill_if_AI = false, start_skills = {"wh2_dlc17_skill_dwf_runesmith_self_rune_of_speed", "wh_main_skill_dwf_runesmith_self_rune_of_wrath_&_ruin", "wh_main_skill_dwf_runesmith_self_rune_of_oath_&_steel", "wh_main_skill_dwf_runesmith_self_damping"}},
	-- Halkenhaf Stonebeard [Thane]
	{forename = "names_name_2147358982", surname = "names_name_2147358985", start_xp = 4200, kill_if_AI = false, start_skills = {"wh_main_skill_all_all_self_blade_master_starter", "wh_main_skill_all_all_self_devastating_charge", "wh_main_skill_all_all_self_hard_to_hit", "wh_main_skill_all_all_self_deadly_blade"}},
	-- Dramar Hammerfist [Engineer]
	{forename = "names_name_2147359003", surname = "names_name_2147359010", start_xp = 4200, kill_if_AI = false, start_skills = {"wh2_dlc17_skill_dwf_master_engineer_restock","wh2_main_skill_all_hero_assist_army_increase_mobility", "wh_main_skill_dwf_engineer_self_dead_eye", "wh2_main_skill_all_hero_passive_boost_income"}}
};

function belegar_start_experience()	
	local faction = cm:get_faction("wh_main_dwf_karak_izor");
	
	if faction then
		cm:disable_event_feed_events(true, "wh_event_category_traits_ancillaries", "", "");
		cm:disable_event_feed_events(true, "wh_event_category_character", "", "");
		
		local is_human = faction:is_human();
		local character_list = faction:character_list();
		
		for i = 0, character_list:num_items() - 1 do
			local current_char = character_list:item_at(i);
			local char_index = find_belegar_character(current_char);
			
			if char_index > 0 then
				belegar_give_start_experience(current_char, belegar_characters[char_index].start_xp);
				belegar_give_skills(current_char, belegar_characters[char_index].start_skills);
				belegar_kill_start_character(current_char, is_human, belegar_characters[char_index].kill_if_AI);
			end;
		end;
		
		cm:callback(function() cm:disable_event_feed_events(false, "wh_event_category_traits_ancillaries", "", "") end, 1);
		cm:callback(function() cm:disable_event_feed_events(false, "wh_event_category_character", "", "") end, 1);
	end;
end;