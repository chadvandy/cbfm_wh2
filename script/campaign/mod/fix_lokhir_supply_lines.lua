local leader_subtype_upkeep_exclusions = {
	["wh2_main_def_black_ark"] = true,
	["wh2_pro08_neu_gotrek"] = true,
    ["wh2_main_def_black_ark_blessed_dread"] = true
};

-- loop through the player's armys and apply
function apply_upkeep_penalty(faction)
	local difficulty = cm:model():combined_difficulty_level();
	
	local effect_bundle = "wh_main_bundle_force_additional_army_upkeep_easy";				-- easy
	
	if(cm:is_multiplayer()) then
		-- In multiplayer we force everyone's upkeep difficulty to 2% (normal) to avoid desyncs
		effect_bundle = "wh_main_bundle_force_additional_army_upkeep_normal";
	else
		if difficulty == 0 then
			effect_bundle = "wh_main_bundle_force_additional_army_upkeep_normal";				-- normal
		elseif difficulty == -1 then
			effect_bundle = "wh_main_bundle_force_additional_army_upkeep_hard";					-- hard
		elseif difficulty == -2 then
			effect_bundle = "wh_main_bundle_force_additional_army_upkeep_very_hard";			-- very hard
		elseif difficulty == -3 then
			effect_bundle = "wh_main_bundle_force_additional_army_upkeep_legendary";			-- legendary
		end
	end
	
	local mf_list = faction:military_force_list();
	local army_list = {};
	
	for i = 0, mf_list:num_items() - 1 do
		local current_mf = mf_list:item_at(i);
		local force_type = current_mf:force_type():key()
		
		if current_mf:is_armed_citizenry() == false and current_mf:has_general() == true and force_type ~= "SUPPORT_ARMY"  then
			local general = current_mf:general_character();
			local character_subtype_key = general:character_subtype_key();
			local cqi = general:command_queue_index();

			if leader_subtype_upkeep_exclusions[character_subtype_key] == nil then
				table.insert(army_list, current_mf);
				cm:remove_effect_bundle_from_characters_force(effect_bundle, cqi);
			end
		end
	end
	
	if #army_list > 1 then
		for i = 1, #army_list - 1 do
			local current_mf = army_list[i];
			
			if not current_mf:has_effect_bundle(effect_bundle) then
				cm:apply_effect_bundle_to_characters_force(effect_bundle, army_list[i]:general_character():cqi(), 0, true);
			end
		end
	end
end