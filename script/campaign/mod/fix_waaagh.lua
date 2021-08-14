--function to apply and remove the LL versions of the Big Waaagh! battle army abilities
local function Battle_Big_Waaagh_Upgrade(faction, waaagh_turns)
	
	local mf_list = faction:military_force_list()

	--loop through list to find any GS LL
	for i = 0, mf_list:num_items() - 1 do
		local force = mf_list:item_at(i)
		local character = force:general_character()
		local character_cqi = 0

		if character:character_subtype("grn_azhag_the_slaughterer") then
			character_cqi = character:command_queue_index()
			cm:remove_effect_bundle_from_characters_force("wh2_dlc15_bundle_azhags_big_waaagh_army_ability", character_cqi)
            if waaagh_turns > 0 then
			    cm:apply_effect_bundle_to_characters_force("wh2_dlc15_bundle_azhags_big_waaagh_army_ability", character_cqi, waaagh_turns, false)
            end
			cm:remove_effect_bundle_from_characters_force("wh2_dlc15_bundle_grimgors_big_waaagh_army_ability", character_cqi)
			cm:remove_effect_bundle_from_characters_force("wh2_dlc15_bundle_groms_big_waaagh_army_ability", character_cqi)
			cm:remove_effect_bundle_from_characters_force("wh2_dlc15_bundle_skarsniks_big_waaagh_army_ability", character_cqi)
			cm:remove_effect_bundle_from_characters_force("wh2_dlc15_bundle_wurrzags_big_waaagh_army_ability", character_cqi)
		end
		if character:character_subtype("grn_grimgor_ironhide") then
			character_cqi = character:command_queue_index()
			cm:remove_effect_bundle_from_characters_force("wh2_dlc15_bundle_grimgors_big_waaagh_army_ability", character_cqi)
            if waaagh_turns > 0 then
			    cm:apply_effect_bundle_to_characters_force("wh2_dlc15_bundle_grimgors_big_waaagh_army_ability", character_cqi, waaagh_turns, false)
            end
			cm:remove_effect_bundle_from_characters_force("wh2_dlc15_bundle_azhags_big_waaagh_army_ability", character_cqi)
			cm:remove_effect_bundle_from_characters_force("wh2_dlc15_bundle_groms_big_waaagh_army_ability", character_cqi)
			cm:remove_effect_bundle_from_characters_force("wh2_dlc15_bundle_skarsniks_big_waaagh_army_ability", character_cqi)
			cm:remove_effect_bundle_from_characters_force("wh2_dlc15_bundle_wurrzags_big_waaagh_army_ability", character_cqi)
		end
		if character:character_subtype("wh2_dlc15_grn_grom_the_paunch") then
			character_cqi = character:command_queue_index()
            if waaagh_turns > 0 then
			    cm:apply_effect_bundle_to_characters_force("wh2_dlc15_bundle_groms_big_waaagh_army_ability", character_cqi, waaagh_turns, false)
            else
                cm:remove_effect_bundle_from_characters_force("wh2_dlc15_bundle_groms_big_waaagh_army_ability", character_cqi)
            end
			cm:remove_effect_bundle_from_characters_force("wh2_dlc15_bundle_azhags_big_waaagh_army_ability", character_cqi)
			cm:remove_effect_bundle_from_characters_force("wh2_dlc15_bundle_grimgors_big_waaagh_army_ability", character_cqi)
			cm:remove_effect_bundle_from_characters_force("wh2_dlc15_bundle_skarsniks_big_waaagh_army_ability", character_cqi)
			cm:remove_effect_bundle_from_characters_force("wh2_dlc15_bundle_wurrzags_big_waaagh_army_ability", character_cqi)
		end
		if character:character_subtype("dlc06_grn_skarsnik") then
			character_cqi = character:command_queue_index()
			cm:remove_effect_bundle_from_characters_force("wh2_dlc15_bundle_skarsniks_big_waaagh_army_ability", character_cqi)
            if waaagh_turns > 0 then
			    cm:apply_effect_bundle_to_characters_force("wh2_dlc15_bundle_skarsniks_big_waaagh_army_ability", character_cqi, waaagh_turns, false)
            end
			cm:remove_effect_bundle_from_characters_force("wh2_dlc15_bundle_azhags_big_waaagh_army_ability", character_cqi)
			cm:remove_effect_bundle_from_characters_force("wh2_dlc15_bundle_grimgors_big_waaagh_army_ability", character_cqi)
			cm:remove_effect_bundle_from_characters_force("wh2_dlc15_bundle_groms_big_waaagh_army_ability", character_cqi)
			cm:remove_effect_bundle_from_characters_force("wh2_dlc15_bundle_wurrzags_big_waaagh_army_ability", character_cqi)
		end
		if character:character_subtype("dlc06_grn_wurrzag_da_great_prophet") then
			character_cqi = character:command_queue_index()
			cm:remove_effect_bundle_from_characters_force("wh2_dlc15_bundle_wurrzags_big_waaagh_army_ability", character_cqi)
            if waaagh_turns > 0 then
			    cm:apply_effect_bundle_to_characters_force("wh2_dlc15_bundle_wurrzags_big_waaagh_army_ability", character_cqi, waaagh_turns, false)
            end
			cm:remove_effect_bundle_from_characters_force("wh2_dlc15_bundle_azhags_big_waaagh_army_ability", character_cqi)
			cm:remove_effect_bundle_from_characters_force("wh2_dlc15_bundle_grimgors_big_waaagh_army_ability", character_cqi)
			cm:remove_effect_bundle_from_characters_force("wh2_dlc15_bundle_groms_big_waaagh_army_ability", character_cqi)
			cm:remove_effect_bundle_from_characters_force("wh2_dlc15_bundle_skarsniks_big_waaagh_army_ability", character_cqi)
		end

		--this step is important in case a character replaces a LL, the effect bundle would stay on the force - this removes that possibility
		if character:character_subtype_key() ~= "grn_azhag_the_slaughterer" and character:character_subtype_key() ~= "grn_grimgor_ironhide" and character:character_subtype_key() ~= "wh2_dlc15_grn_grom_the_paunch" 
				and character:character_subtype_key() ~= "dlc06_grn_skarsnik" and character:character_subtype_key() ~= "dlc06_grn_wurrzag_da_great_prophet" then
			
			character_cqi = character:command_queue_index()
			cm:remove_effect_bundle_from_characters_force("wh2_dlc15_bundle_azhags_big_waaagh_army_ability", character_cqi)
			cm:remove_effect_bundle_from_characters_force("wh2_dlc15_bundle_grimgors_big_waaagh_army_ability", character_cqi)
			cm:remove_effect_bundle_from_characters_force("wh2_dlc15_bundle_groms_big_waaagh_army_ability", character_cqi)
			cm:remove_effect_bundle_from_characters_force("wh2_dlc15_bundle_skarsniks_big_waaagh_army_ability", character_cqi)
			cm:remove_effect_bundle_from_characters_force("wh2_dlc15_bundle_wurrzags_big_waaagh_army_ability", character_cqi)
		end
	end
	
end

function fix_waaagh()
    local greenskin = "wh_main_sc_grn_greenskins"
	-- the following listener is triggered after the original Wagh_FactionTurnStart_PlayerGreenskin_listener and corrects its mistakes
	core:add_listener(
		"cbf_Wagh_FactionTurnStart_PlayerGreenskin_listener",
		"ScriptEventPlayerFactionTurnStart",
		function(context)
			return context:faction():subculture() == greenskin
		end,
		function(context)
			local faction = context:faction()
			local bundles = faction:effect_bundles()
			local waaagh_turns = 0
			for i = 0, bundles:num_items() - 1 do
				if bundles:item_at(i):key() == "wh2_main_faction_boost_gork" or bundles:item_at(i):key() == "wh2_main_faction_boost_mork" then
					waaagh_turns = bundles:item_at(i):duration()
				end
			end
			Battle_Big_Waaagh_Upgrade(faction, waaagh_turns)
		end,
		true
	)
    -- if Greenskins are confederated during an active Waaagh, check if LL and apply Waaagh bundle for LL
    core:remove_listener("Wagh_FactionJoinsConfederation_listener")
	core:add_listener(
		"Wagh_FactionJoinsConfederation_listener",
		"FactionJoinsConfederation",
		function(context)
			return context:confederation():is_human() and context:confederation():subculture() == greenskin
		end,
		function(context)
			local faction = context:confederation()
			local bundles = faction:effect_bundles()
			local waaagh_turns = 0
			for i = 0, bundles:num_items() - 1 do
				if bundles:item_at(i):key() == "wh2_main_faction_boost_gork" or bundles:item_at(i):key() == "wh2_main_faction_boost_mork" then
					waaagh_turns = bundles:item_at(i):duration()
				end
			end
			Battle_Big_Waaagh_Upgrade(faction, waaagh_turns)
		end,
		true
	)
	-- if during an active Waaagh and LL is recruited, make sure to apply Waaagh bundle for LL
    core:remove_listener("Wagh_MilitaryForceCreated_listener")
	core:add_listener(
		"Wagh_MilitaryForceCreated_listener",
		"MilitaryForceCreated",
		function(context)
			return context:military_force_created():faction():is_human() and context:military_force_created():faction():subculture() == greenskin
		end,
		function(context)
			local faction = context:military_force_created():faction()
			local bundles = faction:effect_bundles()
			local waaagh_turns = 0
			for i = 0, bundles:num_items() - 1 do
				if bundles:item_at(i):key() == "wh2_main_faction_boost_gork" or bundles:item_at(i):key() == "wh2_main_faction_boost_mork" then
					waaagh_turns = bundles:item_at(i):duration()
				end
			end

			Battle_Big_Waaagh_Upgrade(faction, waaagh_turns)
		end,
		true
	)
	-- if during an active Waaagh and LL replaces general of existing military force, make sure to apply Waaagh bundle for LL
    core:remove_listener("Wagh_CharacterReplacingGeneral")
    core:add_listener(
		"Wagh_CharacterReplacingGeneral",
		"CharacterReplacingGeneral",
		function(context)
			return context:character():faction():is_human() and context:character():faction():subculture() == greenskin
		end,
		function(context)
			local faction = context:character():faction()
			local bundles = faction:effect_bundles()
			local waaagh_turns = 0
			for i = 0, bundles:num_items() - 1 do
				if bundles:item_at(i):key() == "wh2_main_faction_boost_gork" or bundles:item_at(i):key() == "wh2_main_faction_boost_mork" then
					waaagh_turns = bundles:item_at(i):duration()
				end
			end

			Battle_Big_Waaagh_Upgrade(faction, waaagh_turns)
		end,
		true
	)
end