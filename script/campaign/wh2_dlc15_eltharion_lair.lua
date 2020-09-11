local yvresse_faction_key = "wh2_main_hef_yvresse";
local lair_mistwalker_level = 15;
local lair_max_prisoners = 1;
local lair_autoresolve_caputre_chance = 50;
local lair_base_escape_chance = 5;
local lair_escaping_prisoner = 0;
local lair_income_stolen = 0.05;
local lair_indoctrinated_characters = {};
local lair_execute_supply = 3;
local lair_indoctrinate_supply = 3;
local lair_max_yvresse_level = 2;
local lair_improved_interrogate = false;
local lair_grom_dilemma = false;
local lair_interrogated_prisoner = 0;
local lair_interrogated_effect = "";
local lair_rituals_to_points = {
	["wh2_dlc15_athel_tamarha_influence_2"] = 5,
	["wh2_dlc15_athel_tamarha_influence_3"] = 5,
	["wh2_dlc15_athel_tamarha_interrogation_2"] = 5,
	["wh2_dlc15_athel_tamarha_interrogation_3"] = 5,
	["wh2_dlc15_athel_tamarha_melee_mistwalkers_2"] = 5,
	["wh2_dlc15_athel_tamarha_melee_mistwalkers_3"] = 5,
	["wh2_dlc15_athel_tamarha_mist_2"] = 5,
	["wh2_dlc15_athel_tamarha_mist_3"] = 5,
	["wh2_dlc15_athel_tamarha_mistwalkers_recruitment_2"] = 5,
	["wh2_dlc15_athel_tamarha_mistwalkers_recruitment_3"] = 5,
	["wh2_dlc15_athel_tamarha_mistwalkers_upgrades_2"] = 5,
	["wh2_dlc15_athel_tamarha_mistwalkers_upgrades_3"] = 5,
	["wh2_dlc15_athel_tamarha_ranged_mistwalkers_2"] = 5,
	["wh2_dlc15_athel_tamarha_ranged_mistwalkers_3"] = 5
};
local lair_subculture_to_effects = {
	["wh_dlc03_sc_bst_beastmen"] = "wh2_dlc15_hef_eltharion_dungeon_reward_beastmen",
	["wh_main_sc_brt_bretonnia"] = "wh2_dlc15_hef_eltharion_dungeon_reward_bretonnia",
	["wh_main_sc_chs_chaos"] = "wh2_dlc15_hef_eltharion_dungeon_reward_chaos_Warriors",
	["wh2_main_sc_def_dark_elves"] = "wh2_dlc15_hef_eltharion_dungeon_reward_dark_elves",
	["wh_main_sc_dwf_dwarfs"] = "wh2_dlc15_hef_eltharion_dungeon_reward_dwarfs",
	["wh_main_sc_emp_empire"] = "wh2_dlc15_hef_eltharion_dungeon_reward_empire",
	["wh_main_sc_ksl_kislev"] = "wh2_dlc15_hef_eltharion_dungeon_reward_empire",
	["wh_main_sc_teb_teb"] = "wh2_dlc15_hef_eltharion_dungeon_reward_empire",
	["wh_main_sc_grn_greenskins"] = "wh2_dlc15_hef_eltharion_dungeon_reward_greenskins",
	["wh_main_sc_grn_savage_orcs"] = "wh2_dlc15_hef_eltharion_dungeon_reward_greenskins",
	["wh2_main_sc_hef_high_elves"] = "wh2_dlc15_hef_eltharion_dungeon_reward_high_elves",
	["wh2_main_sc_lzd_lizardmen"] = "wh2_dlc15_hef_eltharion_dungeon_reward_lizardmen",
	["wh_main_sc_nor_norsca"] = "wh2_dlc15_hef_eltharion_dungeon_reward_norsca",
	["wh2_main_sc_skv_skaven"] = "wh2_dlc15_hef_eltharion_dungeon_reward_skaven",
	["wh2_dlc09_sc_tmb_tomb_kings"] = "wh2_dlc15_hef_eltharion_dungeon_reward_tomb_kings",
	["wh2_dlc11_sc_cst_vampire_coast"] = "wh2_dlc15_hef_eltharion_dungeon_reward_vampire_coast",
	["wh_main_sc_vmp_vampire_counts"] = "wh2_dlc15_hef_eltharion_dungeon_reward_vampire_counts",
	["wh_dlc05_sc_wef_wood_elves"] = "wh2_dlc15_hef_eltharion_dungeon_reward_wood_elves"
};
local lair_action_effects = {
	"wh2_dlc15_hef_dungeon_mistwalker_upgrade_wood_elves",
	"wh2_dlc15_hef_dungeon_mistwalker_upgrade_vampire_counts",
	"wh2_dlc15_hef_dungeon_mistwalker_upgrade_vampire_coast",
	"wh2_dlc15_hef_dungeon_mistwalker_upgrade_tomb_kings",
	"wh2_dlc15_hef_dungeon_mistwalker_upgrade_skaven",
	"wh2_dlc15_hef_dungeon_mistwalker_upgrade_rogue_army",
	"wh2_dlc15_hef_dungeon_mistwalker_upgrade_norsca",
	"wh2_dlc15_hef_dungeon_mistwalker_upgrade_lizardmen",
	"wh2_dlc15_hef_dungeon_mistwalker_upgrade_high_elves",
	"wh2_dlc15_hef_dungeon_mistwalker_upgrade_greenskins",
	"wh2_dlc15_hef_dungeon_mistwalker_upgrade_empire",
	"wh2_dlc15_hef_dungeon_mistwalker_upgrade_dwarfs",
	"wh2_dlc15_hef_dungeon_mistwalker_upgrade_dark_elves",
	"wh2_dlc15_hef_dungeon_mistwalker_upgrade_chaos_warriors",
	"wh2_dlc15_hef_dungeon_mistwalker_upgrade_bretonnia",
	"wh2_dlc15_hef_dungeon_mistwalker_upgrade_beastmen"
};

function add_eltharion_lair_listeners()
	out("#### Adding Eltharion Lair Listeners ####");
	core:add_listener(
		"lair_FactionTurnStart",
		"FactionBeginTurnPhaseNormal",
		true,
		function(context)
			lair_FactionTurnStart(context);
		end,
		true
	);
	core:add_listener(
		"lair_CharacterRankUp",
		"CharacterRankUp",
		true,
		function(context)
			lair_CharacterRankUp(context);
		end,
		true
	);
	core:add_listener(
		"lair_RitualCompletedEvent",
		"RitualCompletedEvent",
		true,
		function(context)
			lair_RitualCompletedEvent(context);
		end,
		true
	);
	core:add_listener(
		"lair_PrisonActionTakenEvent",
		"PrisonActionTakenEvent",
		true,
		function(context)
			lair_PrisonActionTakenEvent(context);
		end,
		true
	);
	core:add_listener(
		"lair_BuildingCompleted",
		"BuildingCompleted",
		true,
		function(context)
			lair_BuildingCompleted(context);
		end,
		true
	);
	core:add_listener(
		"lair_BattleCompleted",
		"BattleCompleted",
		true,
		function(context)
			lair_BattleCompleted(context);
		end,
		true
	);
	core:add_listener(
		"lair_ComponentLClickUp",
		"ComponentLClickUp",
		function(context)
			return context.string == "grom_invasion" and lair_grom_dilemma == false;
		end,
		function(context)
			lair_grom_dilemma = true;
			
			local grom_button = find_uicomponent(core:get_ui_root(), "layout", "groms_invasion_holder", "groms_invasion_content", "grom_invasion");

			if grom_button then
				grom_button:SetDisabled(true);
			end
			
			if cm:is_multiplayer() == false then
				cm:trigger_dilemma(yvresse_faction_key, "wh2_dlc15_hef_grom_invasion_offer");
			else
				CampaignUI.TriggerCampaignScriptEvent(0, "grom_invasion_event");
			end
		end,
		true
	);
	core:add_listener(
		"lair_UITriggerScriptEvent",
		"UITriggerScriptEvent",
		function(context)
			return context:trigger() == "grom_invasion_event";
		end,
		function(context)
			cm:trigger_dilemma(yvresse_faction_key, "wh2_dlc15_hef_grom_invasion_offer");
		end,
		true
	);
	core:add_listener(
		"lair_DilemmaChoiceMadeEvent",
		"DilemmaChoiceMadeEvent",
		function(context)
			return context:dilemma() == "wh2_dlc15_hef_grom_invasion_offer";
		end,
		function(context)
			local choice = context:choice();

			if choice == 0 then
				--cm:trigger_mission(yvresse_faction_key, "wh2_dlc15_qb_hef_final_battle_eltharion", true);
				grom_timer_access(0);
			elseif choice == 1 then
				lair_grom_dilemma = false;
			end
			
			local grom_button = find_uicomponent(core:get_ui_root(), "layout", "groms_invasion_holder", "groms_invasion_content", "grom_invasion");

			if grom_button then
				grom_button:SetDisabled(lair_grom_dilemma);
			end
		end,
		true
	);
	
	if cm:is_new_game() == true then
		local warden = cm:model():world():faction_by_key(yvresse_faction_key);
		lair_UpdatePrisonAbility(warden);
		cm:add_event_restricted_building_record_for_faction("wh2_dlc15_hef_field_hq_1", yvresse_faction_key, "eltharion_building_lock_hq");
		cm:add_event_restricted_building_record_for_faction("wh2_dlc15_hef_field_hq_2", yvresse_faction_key, "eltharion_building_lock_hq");
		cm:add_event_restricted_building_record_for_faction("wh2_dlc15_hef_field_hq_3", yvresse_faction_key, "eltharion_building_lock_hq");

		---add pooled resource to account for fact you start with lvl 2 settlement
		cm:faction_add_pooled_resource(yvresse_faction_key, "yvresse_defence", "wh2_dlc15_resource_factor_yvresse_defence_settlement", 5);

		cm:callback(function()
			cm:perform_ritual(yvresse_faction_key, "", "wh2_dlc15_athel_tamarha_influence_1");
			cm:perform_ritual(yvresse_faction_key, "", "wh2_dlc15_athel_tamarha_interrogation_1");
			cm:perform_ritual(yvresse_faction_key, "", "wh2_dlc15_athel_tamarha_melee_mistwalkers_1");
			cm:perform_ritual(yvresse_faction_key, "", "wh2_dlc15_athel_tamarha_mist_1");
			cm:perform_ritual(yvresse_faction_key, "", "wh2_dlc15_athel_tamarha_mistwalkers_recruitment_1");
			cm:perform_ritual(yvresse_faction_key, "", "wh2_dlc15_athel_tamarha_mistwalkers_upgrades_1");
			cm:perform_ritual(yvresse_faction_key, "", "wh2_dlc15_athel_tamarha_prison_1");
			cm:perform_ritual(yvresse_faction_key, "", "wh2_dlc15_athel_tamarha_ranged_mistwalkers_1");
		end, 1);
	end

	if cm:is_multiplayer() == true then
		local grom_button = find_uicomponent(core:get_ui_root(), "layout", "groms_invasion_holder", "groms_invasion_content", "grom_invasion");

		if grom_button then
			grom_button:SetDisabled(true);
		end
	end
end

function lair_FactionTurnStart(context)
	local faction = context:faction();

	if faction:is_human() == true and faction:name() == yvresse_faction_key then
		lair_UpdatePrisonAbility(faction);
		lair_UpdatePrisonerEffects(faction);
		lair_UpdatePrisonerEscapes(faction);
		local dead_prisoners = {};

		for index = 1, #lair_indoctrinated_characters do
			local char_cqi = lair_indoctrinated_characters[index];
			local character = cm:model():character_for_command_queue_index(char_cqi);

			if character:is_null_interface() == true or character:faction():is_null_interface() == true or character:faction():is_dead() == true then
				table.insert(dead_prisoners, index);
			else
				lair_StealIncomeFromCharactersFaction(character);
				lair_MakeCharacterVisible(character);
			end
		end
		
		for i = 1, #dead_prisoners do
			table.remove(lair_indoctrinated_characters, dead_prisoners[i]);
		end
		
		cm:callback(function()
			cm:remove_effect_bundle("wh2_dlc15_bundle_executed_prisoner_influence", yvresse_faction_key);
			cm:remove_effect_bundle("wh2_dlc15_bundle_indoctrinated_prisoner_influence", yvresse_faction_key);
		end, 1);
		
		if cm:is_multiplayer() == true then
			local grom_button = find_uicomponent(core:get_ui_root(), "layout", "groms_invasion_holder", "groms_invasion_content", "grom_invasion");

			if grom_button then
				grom_button:SetDisabled(true);
			end
		end
	end
end

function lair_RitualCompletedEvent(context)
	if context:succeeded() == true then
		local ritual = context:ritual();
		local ritual_key = ritual:ritual_key();
		local ritual_category = ritual:ritual_category();
		
		if ritual_key == "wh2_dlc15_athel_tamarha_mistwalkers_recruitment_2" then
			cm:remove_event_restricted_building_record_for_faction("wh2_dlc15_hef_field_hq_1", yvresse_faction_key);
			cm:remove_event_restricted_building_record_for_faction("wh2_dlc15_hef_field_hq_2", yvresse_faction_key);
			cm:remove_event_restricted_building_record_for_faction("wh2_dlc15_hef_field_hq_3", yvresse_faction_key);
		elseif ritual_key == "wh2_dlc15_athel_tamarha_prison_2" then
			lair_max_prisoners = lair_max_prisoners + 1;
		elseif ritual_key == "wh2_dlc15_athel_tamarha_interrogation_3" then
			lair_improved_interrogate = true;
		end

		if ritual_category == "ATHEL_TAMARHA_RITUAL" then
			local upgrade_value = lair_rituals_to_points[ritual_key];

			if upgrade_value ~= nil then
				cm:faction_add_pooled_resource(yvresse_faction_key, "yvresse_defence", "wh2_dlc15_resource_factor_yvresse_defence_upgrade", upgrade_value);
			end
		end
	end
end

function lair_CharacterRankUp(context)
	local character = context:character();
	local faction = character:faction();
	
	if faction:is_human() == true and character:is_faction_leader() == false and faction:name() == yvresse_faction_key then
		if character:rank() >= lair_mistwalker_level then
			local trait_level = character:trait_points("wh2_dlc15_trait_mistwalker_sentinel");
			trait_level = trait_level + character:trait_points("wh2_dlc15_trait_mistwalker_shadow");
			trait_level = trait_level + character:trait_points("wh2_dlc15_trait_mistwalker_watcher");

			if trait_level < 1 then
				local faction_cqi = faction:command_queue_index();
				local char_cqi = character:command_queue_index();
				cm:trigger_dilemma_with_targets(faction_cqi, "wh2_dlc15_hef_mistwalker_recruitment", 0, 0, char_cqi, 0, 0, 0);
			end
		end
	end
end

events.ImprisonmentEvent[#events.ImprisonmentEvent+1] =
function (context)
	local warden = context:faction();

	if warden:is_human() == true and warden:name() == yvresse_faction_key then
		local warden_cqi = warden:command_queue_index();
		local prisoner = context:prisoner_family_member();
		local character = prisoner:character();
		local faction = character:faction();
		local prisoner_cqi = character:command_queue_index();
		local faction_cqi = faction:command_queue_index();

		lair_UpdatePrisonAbility(warden);
		lair_UpdatePrisonerEffects(warden);
		cm:trigger_incident_with_targets(warden_cqi, "wh2_dlc15_incident_hef_prisoner_captured", 0, faction_cqi, prisoner_cqi, 0, 0, 0);
	end
end
events.ImprisonmenRejectiontEvent[#events.ImprisonmenRejectiontEvent+1] =
function (context)
	local warden = context:faction();

	if warden:is_human() == true and warden:name() == yvresse_faction_key then
		local rejection_reasons = context:rejection_reasons();
		local garrison_char = rejection_reasons:is_member_of_garrison();
		local rebel_char = rejection_reasons:is_from_rebel_faction();
		local waaagh_char = rejection_reasons:is_from_companion_faction();
		-- is_from_dead_faction
		-- is_placeholder_character

		if garrison_char == true or rebel_char == true or waaagh_char == true then
			local warden_cqi = warden:command_queue_index();
			local prisoner = context:prisoner_family_member();

			if prisoner:is_null_interface() == false then
				local character = prisoner:character();
				local faction = character:faction();
				local prisoner_cqi = character:command_queue_index();
				local faction_cqi = faction:command_queue_index();
				
				cm:trigger_incident_with_targets(warden_cqi, "wh2_dlc15_incident_hef_prisoner_failed_capture", 0, faction_cqi, prisoner_cqi, 0, 0, 0);
			end
		end
	end
end

function lair_BuildingCompleted(context)
	local building = context:building();
	local region_key = context:garrison_residence():region():name();
	local building_chain = building:chain();
	local building_level = building:building_level();

	if building:faction():name() == yvresse_faction_key then
		if region_key == "wh2_main_vor_northern_yvresse_tor_yvresse" or region_key == "wh2_main_yvresse_tor_yvresse" then
			if building_chain == "wh2_dlc15_special_settlement_tor_yvresse_eltharion" then
				if lair_max_yvresse_level == 4 and building_level == 5 then
					lair_max_yvresse_level = lair_max_yvresse_level + 1;
					cm:faction_add_pooled_resource(yvresse_faction_key, "yvresse_defence", "wh2_dlc15_resource_factor_yvresse_defence_settlement", 10);
				elseif lair_max_yvresse_level == 3 and building_level == 4 then
					lair_max_yvresse_level = lair_max_yvresse_level + 1;
					cm:faction_add_pooled_resource(yvresse_faction_key, "yvresse_defence", "wh2_dlc15_resource_factor_yvresse_defence_settlement", 10);
				elseif lair_max_yvresse_level == 2 and building_level == 3 then
					lair_max_yvresse_level = lair_max_yvresse_level + 1;
					cm:faction_add_pooled_resource(yvresse_faction_key, "yvresse_defence", "wh2_dlc15_resource_factor_yvresse_defence_settlement", 5);
				end
			end
		end
	end
end

function lair_BattleCompleted(context)
	local pending_battle = cm:model():pending_battle();
	
	if pending_battle:is_auto_resolved() == true then
		local warden = cm:model():world():faction_by_key(yvresse_faction_key);

		if warden:is_human() == true then
			local prison_system = cm:model():prison_system();
			local prisoners = prison_system:get_faction_prisoners(warden);
			if prisoners:num_items() < lair_max_prisoners then
				if cm:pending_battle_cache_faction_is_attacker(yvresse_faction_key) then
					local fought = pending_battle:has_been_fought();
					local attacker_battle_result = pending_battle:attacker_battle_result();
					local defender_battle_result = pending_battle:defender_battle_result();
					local retreat = attacker_battle_result == defender_battle_result;
					if fought == true and retreat == false then
						if cm:model():random_percent(lair_autoresolve_caputre_chance) then
							local num_defenders = cm:pending_battle_cache_num_defenders()
                            if pending_battle:night_battle() == true then 
                                num_defenders = 1
							end
                            for i = 1, num_defenders do
								local defender_cqi, defender_force_cqi, defender_name = cm:pending_battle_cache_get_defender(i);
								local enemy = cm:model():character_for_command_queue_index(defender_cqi);

								if enemy:is_null_interface() == false and enemy:has_military_force() == true and enemy:military_force():is_armed_citizenry() == false then
									cm:faction_imprison_character(warden, enemy);
								end
							end
						end
					end
				end
			end
		end
	end
end

function lair_UpdatePrisonAbility(faction)
	local prison_system = cm:model():prison_system();
	local prisoners = prison_system:get_faction_prisoners(faction);

	if prisoners:num_items() < lair_max_prisoners then
		if faction:has_effect_bundle("wh2_dlc15_bundle_wardens_cage") == false then
			cm:apply_effect_bundle("wh2_dlc15_bundle_wardens_cage", yvresse_faction_key, 0);
		end
	else
		cm:remove_effect_bundle("wh2_dlc15_bundle_wardens_cage", yvresse_faction_key);
	end
end

function lair_UpdatePrisonerEffects(faction)
	local effect_bundles = faction:effect_bundles();

	for i = 0, effect_bundles:num_items() - 1 do
		local effect_bundle = effect_bundles:item_at(i);
		local effect = effect_bundle:key();

		if effect:starts_with("wh2_dlc15_hef_eltharion_dungeon_reward") then
			cm:remove_effect_bundle(effect, yvresse_faction_key);
		end
	end
	
	local prison_system = cm:model():prison_system();
	local prisoners = prison_system:get_faction_prisoners(faction);
	local found_interrogated_cqi = false;

	for i = 0, prisoners:num_items() - 1 do
		local prisoner_f = prisoners:item_at(i);
		local prisoner = prisoner_f:character();
		local prisoner_cqi = prisoner:command_queue_index();
		local prisoner_faction = prisoner:faction();
		local culture = prisoner_faction:culture();

		if culture == "wh2_main_rogue" then
			cm:apply_effect_bundle("wh2_dlc15_hef_eltharion_dungeon_reward_rogue_armies", yvresse_faction_key, 0);
		else
			local subculture = prisoner_faction:subculture();
			local effect = lair_subculture_to_effects[subculture];

			if effect ~= nil then
				cm:apply_effect_bundle(effect, yvresse_faction_key, 0);
			end
		end

		if lair_interrogated_prisoner == prisoner_cqi then
			found_interrogated_cqi = true;
		end
	end

	if found_interrogated_cqi == false then
		lair_RemoveMistwalkerAbilities(faction);
		lair_interrogated_prisoner = 0;
	end
end

function lair_PrisonActionTakenEvent(context)
	local warden = context:faction();
	local warden_cqi = warden:command_queue_index();

	local prisoner = context:prisoner_family_member();
	local prisoner_cqi = 0;
	local faction_cqi = 0;
	local is_grom = false;

	if prisoner:is_null_interface() == false then
		local character = prisoner:character();

		if character:is_null_interface() == false then
			prisoner_cqi = character:command_queue_index();
			local faction = character:faction();
			faction_cqi = faction:command_queue_index();
			is_grom = character:character_subtype("wh2_dlc15_grn_grom_the_paunch");
		end
	end

	local action = context:action_key();
	out("Prison Action: "..action);

	if action == "wh2_dlc15_prison_action_indoctrinate" then
		cm:faction_add_pooled_resource(yvresse_faction_key, "wardens_supply", "wh2_dlc15_resource_factor_wardens_supply_indoctrinated_prisoners", lair_indoctrinate_supply);
		cm:apply_effect_bundle("wh2_dlc15_bundle_indoctrinated_prisoner_influence", yvresse_faction_key, 0);
		cm:trigger_incident_with_targets(warden_cqi, "wh2_dlc15_incident_hef_prisoner_indoctrinated", 0, faction_cqi, prisoner_cqi, 0, 0, 0);
		cm:remove_effect_bundle("wh2_dlc15_hef_dungeon_indoctrinate", yvresse_faction_key);
		table.insert(lair_indoctrinated_characters, prisoner_cqi);
		
		if prisoner:is_null_interface() == false then
			local character = prisoner:character();
			lair_MakeCharacterVisible(character);
		end

		if prisoner_cqi == lair_interrogated_prisoner then
			lair_RemoveMistwalkerAbilities(warden);
			lair_interrogated_prisoner = 0;
		end
	elseif action == "wh2_dlc15_prison_action_execute" then
		cm:faction_add_pooled_resource(yvresse_faction_key, "wardens_supply", "wh2_dlc15_resource_factor_wardens_supply_executed_prisoners", lair_execute_supply);
		cm:apply_effect_bundle("wh2_dlc15_bundle_executed_prisoner_influence", yvresse_faction_key, 0);
		cm:trigger_incident_with_targets(warden_cqi, "wh2_dlc15_incident_hef_prisoner_executed", 0, faction_cqi, prisoner_cqi, 0, 0, 0);
		cm:remove_effect_bundle("wh2_dlc15_hef_dungeon_execute", yvresse_faction_key);

		local eltharion = warden:faction_leader();
		cm:add_agent_experience("character_cqi:"..eltharion:command_queue_index(), 500);

		if prisoner_cqi == lair_interrogated_prisoner then
			lair_RemoveMistwalkerAbilities(warden);
			lair_interrogated_prisoner = 0;
		end
	elseif action:starts_with("wh2_dlc15_prison_action_interrogate") then
		local current_effect = lair_interrogated_effect;
		for i = 1, #lair_action_effects do
			if lair_action_effects[i] ~= current_effect and warden:has_effect_bundle(lair_action_effects[i]) == true then
				lair_interrogated_effect = lair_action_effects[i];
			end
		end

		lair_RemoveMistwalkerAbilities(warden, lair_interrogated_effect);
		lair_interrogated_prisoner = prisoner_cqi;

		if lair_improved_interrogate == true then
			local mf_list = warden:military_force_list();
			
			for i = 0, mf_list:num_items() - 1 do
				local current_mf = mf_list:item_at(i);
				
				if current_mf:is_armed_citizenry() == false and current_mf:has_general() == true then
					local general = current_mf:general_character();
					cm:add_agent_experience("character_cqi:"..general:command_queue_index(), 250);
				end
			end
		end

		if is_grom == true then
			cm:apply_effect_bundle("wh2_dlc15_hef_dungeon_mistwalker_upgrade_greenskins_grom", yvresse_faction_key, 0);
		end
	end
	lair_UpdatePrisonAbility(warden);
	lair_UpdatePrisonerEffects(warden);
end

function lair_RemoveMistwalkerAbilities(warden, exclude)
	exclude = exclude or "";
	for i = 1, #lair_action_effects do
		if lair_action_effects[i] ~= exclude and warden:has_effect_bundle(lair_action_effects[i]) == true then
			cm:remove_effect_bundle(lair_action_effects[i], yvresse_faction_key);
		end
	end
end

function lair_StealIncomeFromCharactersFaction(character)
	local faction = character:faction();
	local treasury = faction:treasury();
	local stolen = treasury * lair_income_stolen;
	cm:treasury_mod(yvresse_faction_key, stolen);
end

function lair_MakeCharacterVisible(character)
	if character:has_region() == true then
		local region_key = character:region():name();
		cm:make_region_visible_in_shroud(yvresse_faction_key, region_key);
	else
		local faction = character:faction();

		if faction:has_home_region() == true then
			local home = faction:home_region():name();
			cm:make_region_visible_in_shroud(yvresse_faction_key, home);
		end
	end
end

function lair_UpdatePrisonerEscapes(faction)
	local prison_system = cm:model():prison_system();
	local prisoners = prison_system:get_faction_prisoners(faction);

	for i = 0, prisoners:num_items() - 1 do
		local prisoner = prisoners:item_at(i):character();
		local escape_chance = lair_base_escape_chance;

		if cm:model():random_percent(escape_chance) then
			lair_TriggerEscapeBattle(prisoner);
			break;
		end
	end
end

function lair_TriggerEscapeBattle(prisoner)
	lair_escaping_prisoner = prisoner:command_queue_index();
end

--------------------------------------------------------------
----------------------- SAVING / LOADING ---------------------
--------------------------------------------------------------
cm:add_saving_game_callback(
	function(context)
		cm:save_named_value("lair_escaping_prisoner", lair_escaping_prisoner, context);
		cm:save_named_value("lair_indoctrinated_characters", lair_indoctrinated_characters, context);
		cm:save_named_value("lair_improved_interrogate", lair_improved_interrogate, context);
		cm:save_named_value("lair_max_yvresse_level", lair_max_yvresse_level, context);
		cm:save_named_value("lair_max_prisoners", lair_max_prisoners, context);
		cm:save_named_value("lair_grom_dilemma", lair_grom_dilemma, context);
		cm:save_named_value("lair_interrogated_prisoner", lair_interrogated_prisoner, context);
		cm:save_named_value("lair_interrogated_effect", lair_interrogated_effect, context);
	end
);
cm:add_loading_game_callback(
	function(context)
		if cm:is_new_game() == false then
			lair_escaping_prisoner = cm:load_named_value("lair_escaping_prisoner", lair_escaping_prisoner, context);
			lair_indoctrinated_characters = cm:load_named_value("lair_indoctrinated_characters", lair_indoctrinated_characters, context);
			lair_improved_interrogate = cm:load_named_value("lair_improved_interrogate", lair_improved_interrogate, context);
			lair_max_yvresse_level = cm:load_named_value("lair_max_yvresse_level", lair_max_yvresse_level, context);
			lair_max_prisoners = cm:load_named_value("lair_max_prisoners", lair_max_prisoners, context);
			lair_grom_dilemma = cm:load_named_value("lair_grom_dilemma", lair_grom_dilemma, context);
			lair_interrogated_prisoner = cm:load_named_value("lair_interrogated_prisoner", lair_interrogated_prisoner, context);
			lair_interrogated_effect = cm:load_named_value("lair_interrogated_effect", lair_interrogated_effect, context);
		end
	end
);