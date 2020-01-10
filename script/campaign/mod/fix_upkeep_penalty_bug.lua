--- Overwriting a vanilla function located in `wh_campaign_setup`
-- This script loads AFTER the CA script, so it will overwrite the function call.

-- writ. by Vandy


-- loop through the player's armys and apply
function apply_upkeep_penalty(faction)
	local difficulty = cm:model():combined_difficulty_level();
	
	local effect_bundle = "wh_main_bundle_force_additional_army_upkeep_easy";				-- easy
	
	if difficulty == 0 then
		effect_bundle = "wh_main_bundle_force_additional_army_upkeep_normal";				-- normal
	elseif difficulty == -1 then
		effect_bundle = "wh_main_bundle_force_additional_army_upkeep_hard";					-- hard
	elseif difficulty == -2 then
		effect_bundle = "wh_main_bundle_force_additional_army_upkeep_very_hard";			-- very hard
	elseif difficulty == -3 then
		effect_bundle = "wh_main_bundle_force_additional_army_upkeep_legendary";			-- legendary
	end;
	
	local mf_list = faction:military_force_list();
	local army_list = {};
	
	-- clone the military force list, excluding any garrisons and black arks
	for i = 0, mf_list:num_items() - 1 do
		local current_mf = mf_list:item_at(i);
		
		if not current_mf:is_armed_citizenry() and current_mf:has_general() and not current_mf:general_character():character_subtype("wh2_main_def_black_ark") and not current_mf:general_character():character_subtype("wh2_pro08_neu_gotrek") then
			table.insert(army_list, current_mf);
		end;
	end;
	
	-- if there is more than one army, apply the effect bundle to the second army onwards
	if #army_list > 1 then
		for i = 2, #army_list do
			local current_mf = army_list[i];
			
			if not current_mf:has_effect_bundle(effect_bundle) then
				cm:apply_effect_bundle_to_characters_force(effect_bundle, army_list[i]:general_character():cqi(), 0, true);
			end;
		end;
    elseif #army_list == 1 then -- VANDY HIJACK HERE
        local current_mf = army_list[1]

        if current_mf:has_effect_bundle(effect_bundle) then
            cm:remove_effect_bundle_from_characters_force(effect_bundle, current_mf:general_character():command_queue_index())
        end
    end
end;