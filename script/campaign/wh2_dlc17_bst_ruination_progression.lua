Ruination = {
	-- Marks of ruination
	marks_of_ruination_key = "bst_ruination",
	marks_of_ruination_factor = "wh2_dlc17_bst_ruination_gained_settlement",
	ruination_incident = "wh2_dlc17_incident_bst_ritual_of_ruin_performed",
	current_ruin_tier = 0,
	max_ruin_tier = 7,
	-- Herdstones
	herdstone_key = "bst_herdstone_shard",
	herdstone_factor = "wh2_dlc17_bst_herdstone_shard_ruination_tier_increase",
	herdstone_upgrade_ritual_key = "wh2_dlc17_bst_ritual_herdstone_upgrade_",
	herdstone_upgrade_ritual_progress = 1,
	herdstone_upgrade_ritual_cap = 4,
	-- Effect bundles
	army_cap = "wh2_dlc17_bst_ruination_army_capacity_",
	attrition_immunity = "wh2_dlc11_bundle_immune_all_attrition",
	unit_cost_modifiers_bundle_string = "wh2_dlc17_bundle_bst_unit_cap_ritual_cost_mods",
	cost_mod_effect_suffix = "_cost_mod",
	-- Rituals
	army_cap_ritual = "wh2_dlc17_bst_ritual_army_cap_upgrade",
	army_cap_ritual_unlock_tier = 6,
	unit_cap_ritual_category = "BEASTMEN_RITUAL_UNITS",
	unit_ritual_cost_mod_increment = 15, ----multiplier to a unit cap cost each time it is performed
	hero_cap_ritual_category = "BEASTMEN_RITUAL_LORDS",
	hero_cost_modifiers_bundle_string = "wh2_dlc17_bundle_bst_hero_cap_ritual_cost_mods",
	hero_cap_ritual_list = {
		["wh2_dlc17_bst_ritual_hero_capacity_bray_shaman"] = true,
		["wh2_dlc17_bst_ritual_hero_capacity_gorebull"] = true,
		["wh2_dlc17_bst_ritual_hero_capacity_wargor"] = true,
	},
	hero_ritual_cost_mod_increment = 10, ----percentage increase to a hero cap cost each time it is performed
	max_crafted_armies = 25,
	craft_armies_ritual_key = "wh2_dlc17_ritual_crafting_bst_army_capacity_",
	-- Tooltips
	building_lock_tooltip = "building_lock_mark_of_ruination",
	herdstone_building_lock_tooltip = "herdstone_building_lock_dread_upgrade",
	-- AI variables
	ai_unlock_cooldown = 25,
	ai_unit_cap_unlock_cooldown = 20,
	ai_unit_cap_increase_cooldown = 15,
	ai_unit_cap_ritual_tier_max = 4,
	ai_times_to_perform_unit_cap_ritual = 1,
	ai_dread_key = "bst_dread",
	ai_dread_factor = "wh2_dlc17_bst_dread_gain_missions_events",
	ai_dread_value = 2000,
	-- Final battles
	me_final_battle = "wh_dlc03_qb_bst_the_final_battle",
	vortex_taurox_final_battle = "wh2_dlc17_qb_bst_final_battle_taurox",
	movie_path = "warhammer2/silence/",

	-- Beastmen factions
	beastmen_factions_vortex = {
		"wh2_main_bst_skrinderkin",
		"wh2_main_bst_stone_horn",
	},
	beastmen_factions_me = {
		"wh_dlc03_bst_jagged_horn",
	},
	beastmen_factions = {
		"wh2_dlc17_bst_taurox",
		"wh2_dlc17_bst_malagor",
		"wh_dlc03_bst_beastmen",
		"wh_dlc05_bst_morghur_herd",
		"wh2_main_bst_blooded_axe",
		"wh2_main_bst_manblight",
		"wh2_main_bst_ripper_horn",
		"wh2_main_bst_shadowgor",
		"wh_dlc03_bst_redhorn",
	},

	beastmen_factions_set = {},
	beastmen_players = {},
	beastmen_ai = {},

	marks_of_ruin_tier_rewards = {
		25,		-- Level 2
		60,		-- Level 3
		100,	-- Level 4	-> HS: 1
		150,	-- Level 5	-> HS: 2
		220,	-- Level 6	-> HS: 2
		320,	-- Level 7	-> HS: 3
		500,	-- Level 8	-> HS: 5
	},

	-- Add herdstone shards at specified Levels
	-- Level links to marks_of_ruin_tier_rewards
	-- [level] = [amount]
	herdstone_shard_increases = {
		[3] = 1,	-- Level 4
		[4] = 1,	-- Level 5
		[6] = 1,	-- Level 7
		[7] = 2,	-- Level 8
	}
};

function Ruination:add_ruination_listeners()
	out("#### Adding Beastmen progression Listeners ####");
	-- Add campaign specific beastmen factions
	if cm:model():campaign_name("main_warhammer") then
		for i = 1, #self.beastmen_factions_me do
			table.insert(self.beastmen_factions, self.beastmen_factions_me[i])
		end
	elseif cm:model():campaign_name("wh2_main_great_vortex") then
		for i = 1, #self.beastmen_factions_vortex do
			table.insert(self.beastmen_factions, self.beastmen_factions_vortex[i])
		end

			-- Not head to head
		if cm:model():campaign_type() ~= 2 then
			-- Apply army abilities in the Taurox Final Battle
			core:add_listener(
				"TauroxFinalBattle_PendingBattle",
				"PendingBattle",
				function()
					local pb = cm:model():pending_battle();
					return pb:set_piece_battle_key() == "wh2_dlc17_qb_bst_final_battle_taurox";
				end,
				function()
					local pb = cm:model():pending_battle();
					
					local attacker = pb:attacker();
					local attacker_cqi = attacker:military_force():command_queue_index();
						
					out.design("Granting army abilities to attacker belonging to " .. attacker:faction():name());					
					cm:apply_effect_bundle_to_force("wh2_dlc17_bundle_quest_battle_ghorgon_summon_qb_scripted", attacker_cqi, 0);
					
				end,
				true
			);
		end;
		
		-- player completes the quest battle
		core:add_listener(
			"TauroxFinalBattle_BattleCompleted",
			"BattleCompleted",
			function()
				local pb = cm:model():pending_battle();
				return pb:set_piece_battle_key() == "wh2_dlc17_qb_bst_final_battle_taurox";
			end,
			function()
				local pb = cm:model():pending_battle();
				
				local attacker = pb:attacker();
				local char_cqi = false;
				local mf_cqi = false;
				local faction_name = false;
				local has_been_fought = pb:has_been_fought();
				
				if has_been_fought then
					-- if the battle was fought, the attacker may have died, so get them from the pending battle cache
					char_cqi, mf_cqi, faction_name = cm:pending_battle_cache_get_attacker(1);
				else
					-- if the player retreated, the pending battle cache won't have stored the attacker, so get it from the attacker character (who should still be alive as they retreated!)
					faction_name = attacker:faction():name();
				end;

				-- player has completed Final Battle
				if attacker then
					-- remove army ability effect bundle
					cm:remove_effect_bundle_from_force("wh2_dlc17_bundle_quest_battle_ghorgon_summon_qb_scripted", attacker:military_force():command_queue_index());
				end;
			end,
			true
		);
	end

	for i = 1, #self.beastmen_factions do
		self.beastmen_factions_set[self.beastmen_factions[i]] = true
	end

	-- Lock beastmen military buildings at the start of a campaign
	if cm:is_new_game() == true then
		self:update_beastmen_faction_controllers()
		self:lock_herdstone_buildings()
		self:verify_herdstone_building_list()
	end

	self:turn_start_listener()
	self:narrative_movie_listeners()
	self:herdstone_upgrade_listener()
	self:unit_capacity_increased_listener()
	self:hero_capacity_increased_listener()
	self:setup_ai_beastmen_listeners()
	self:army_upgrade_ritual_listener()
end

function Ruination:turn_start_listener()
	core:add_listener(
		"mark_of_ruin_turn_start_check",
		"FactionTurnStart",
		function(context)
			return cm:is_new_game() == false and context:faction():is_human() and self.beastmen_factions_set[context:faction():name()]
		end,
		function(context)
			-- Checking for newly spawned beastmen factions
			self:update_beastmen_faction_controllers()
			local faction = context:faction():name()
			self:update_beastmen_progress(faction)
		end,
		true
	)
end

function Ruination:narrative_movie_listeners()
	core:add_listener(
		"TauroxMissionIssued",
		"MissionIssued",
		function(context)
			return context:mission():mission_record_key() == self.vortex_taurox_final_battle;
		end,
		function(context)
			core:svr_save_registry_bool("taurox_call_to_arms", true);
			cm:register_instant_movie(self.movie_path.."taurox_call_to_arms");
		end,
		false
	);
	core:add_listener(
		"TauroxMissionSucceeded",
		"MissionSucceeded",
		function(context)
			return context:mission():mission_record_key() == self.vortex_taurox_final_battle;
		end,
		function(context)
			core:svr_save_registry_bool("taurox_win", true);
			cm:register_instant_movie(self.movie_path.."taurox_win");
		end,
		false
	);
end

-- Get current value of Marks of Ruination pooled resource
function Ruination:get_current_mark_of_ruination_amount(faction_key)
	local faction = cm:get_faction(faction_key)
	local mark_amount = faction:pooled_resource(self.marks_of_ruination_key):value()
	return mark_amount
end

function Ruination:add_ruination(faction, amount)
	cm:faction_add_pooled_resource(faction, self.marks_of_ruination_key, self.marks_of_ruination_factor, amount)
end

function Ruination:add_herdstone_shard(faction, amount)
	cm:faction_add_pooled_resource(faction, self.herdstone_key, self.herdstone_factor, amount)
end

-- Find which beastmen factions are AI and which are players
function Ruination:update_beastmen_faction_controllers()
	for i = 1, #self.beastmen_factions do
		local faction = cm:get_faction(self.beastmen_factions[i])
		if faction then
			local faction_key = faction:name()
			out("\t\t"..faction_key..":");
			if faction:is_null_interface() == false and faction:is_human() then
				self.beastmen_players[faction_key] = true
			elseif faction:is_human() == false then
				if self.beastmen_ai[faction_key] == nil then
					self.beastmen_ai[faction_key] = {
						["herdstone"] = 1,
						["unit_cap_tier"] = 1,
					}
				end
			end
		end
	end
end

function Ruination:setup_ai_beastmen_listeners()
	for i = 1, #self.beastmen_factions do
		local faction = cm:get_faction(self.beastmen_factions[i])
		if faction then
			if not faction:is_human() then
				self:add_ai_turn_start_upgrade_listener_for_faction(self.beastmen_factions[i])
			end
		end
	end
end

-- Unlocks specified building for specified faction
function Ruination:unlock_building(building, faction)
	cm:remove_event_restricted_building_record_for_faction(building, faction)
end

-- Apply effect bundle to faction
function Ruination:apply_effect_bundle_to_faction(effect, faction_name)
	cm:apply_effect_bundle(effect, faction_name, 0);
end

-- Checks Marks of Ruination amount and applies tier rewards as required
function Ruination:update_beastmen_progress(faction, marks_added)
	local marks_added = marks_added or 0
	local current_marks_available = self:get_current_mark_of_ruination_amount(faction)
	local total_marks = current_marks_available + marks_added
	local next_ruin_tier = self.current_ruin_tier + 1
	if self.marks_of_ruin_tier_rewards[next_ruin_tier] ~= nil and total_marks >= self.marks_of_ruin_tier_rewards[next_ruin_tier] then
		if next_ruin_tier <= self.max_ruin_tier then
			self.current_ruin_tier = next_ruin_tier
			-- Unlock army cap upgrade ritual
			if next_ruin_tier == self.army_cap_ritual_unlock_tier then
				-- Unlock army cap ritual
				local primary_player_interface = cm:get_faction(faction)
				cm:unlock_ritual(primary_player_interface, self.army_cap_ritual, -1)				
			end

			-- Trigger final battle
			if next_ruin_tier == self.max_ruin_tier then
				if cm:model():campaign_name("main_warhammer") then
					cm:trigger_mission(faction, self.me_final_battle, true)
					-- Taurox's final battle in Vortex is triggered via DaVE
				end
				core:trigger_event("ScriptEventMarksofRuinationCompleted");
			end

			-- Add herdstone shards if at right tier
			if self.herdstone_shard_increases[next_ruin_tier] ~= nil then
				self:add_herdstone_shard(faction, self.herdstone_shard_increases[next_ruin_tier])
			end

			-- Display notification for next ruination tier reached
			self:notify_ruination_tier_increased(faction, next_ruin_tier)
			--trigger event, next ruination tier reached
			core:trigger_event("ScriptEventMarksofRuinationThreshold");
		end

		-- Check if marks obtained exceeds following tier requirements
		local following_ruin_tier = next_ruin_tier + 1
		if self.marks_of_ruin_tier_rewards[following_ruin_tier] ~= nil and total_marks >= self.marks_of_ruin_tier_rewards[following_ruin_tier] then
			Ruination:update_beastmen_progress(faction, marks_added)
		end
	end
end

function Ruination:notify_ruination_tier_increased(faction_name, tier_reached)
	local title = "event_feed_strings_text_wh2_dlc17_bst_ruination_tier_increased_title"
	local primary_detail = "factions_screen_name_" .. faction_name
	local secondary_detail = "event_feed_strings_text_wh2_dlc17_bst_ruination_tier_increased_"..tier_reached
	local pic = 1803

	cm:show_message_event(
		faction_name,
		title,
		primary_detail,
		secondary_detail,
		true,
		pic
	)
end

-- AI turn start listeners
function Ruination:add_ai_turn_start_upgrade_listener_for_faction(faction_name)
	cm:add_faction_turn_start_listener_by_name(
		"ai_turn_start",
		faction_name,
		function(context)
			self:upgrade_ai_faction(faction_name)
		end,
		true
	)
end

function Ruination:upgrade_ai_faction(faction_name)
	if faction_name == nil then
		script_error("ERROR: Ruination AI Progression: Trying to upgrade a non-existent ai faction")
		return
	end

	local turn = cm:model():turn_number()
	local bst_faction_details = self.beastmen_ai[faction_name]
	-- after specified turns unlock buildings for the AI
	if bst_faction_details == nil then
		script_error("ERROR: Ruination AI Progression: Specified faction "..faction_name.." does not exist in beastmen ai list")
		return
	elseif bst_faction_details ~= nil then
		if turn % self.ai_unlock_cooldown == 0 then
			local bst_herdstone_tier = bst_faction_details["herdstone"]
			if bst_herdstone_tier <= self.herdstone_upgrade_ritual_cap then
				local b_list = self.herdstone_building_list
				for i = 1, #b_list[bst_herdstone_tier] do
					self:unlock_building(b_list[bst_herdstone_tier][i], faction_name)
				end
				self.beastmen_ai[faction_name]["herdstone"] = bst_herdstone_tier + 1
			end
		end

		-- Unlock unit cap rituals for AI faction
		if turn % self.ai_unit_cap_unlock_cooldown == 0 then
			local bst_unit_cap_tier = bst_faction_details.unit_cap_tier
			if bst_unit_cap_tier <= self.ai_unit_cap_ritual_tier_max then
				-- Only need to unlock rituals once
				if bst_unit_cap_tier ~= self.ai_unit_cap_ritual_tier_max then
					-- Unlock rituals of next tier
					local rituals_at_tier = self.unit_cap_rituals[bst_unit_cap_tier]
					local ai_player_interface = cm:get_faction(faction_name)
					for i = 1, #rituals_at_tier do
						cm:unlock_ritual(ai_player_interface, rituals_at_tier[i], -1)
					end
				end
				-- Increase unit cap tier if not reached max tier
				if bst_unit_cap_tier < self.ai_unit_cap_ritual_tier_max then
					self.beastmen_ai[faction_name].unit_cap_tier = bst_unit_cap_tier + 1
				end
			end
		end

		if turn % self.ai_unit_cap_increase_cooldown == 0 then
			local bst_unit_cap_tier = bst_faction_details.unit_cap_tier
			if bst_unit_cap_tier <= self.ai_unit_cap_ritual_tier_max then
				-- Increase unit caps for AI
				local target_faction = ""
				-- Give AI faction dread to be able to increase unit caps
				cm:faction_add_pooled_resource(faction_name, self.ai_dread_key, self.ai_dread_factor, self.ai_dread_value)
				for i = 1, bst_faction_details.unit_cap_tier - 1 do
					local rituals_at_tier = self.unit_cap_rituals[bst_unit_cap_tier]
					for p = 1, #rituals_at_tier do
						for _ = 1, self.ai_times_to_perform_unit_cap_ritual do
							cm:perform_ritual(faction_name, target_faction, rituals_at_tier[p])
						end
					end
				end
			end
		end
	end
end


function Ruination:unit_capacity_increased_listener()
	core:add_listener(
		"mark_of_ruin_unit_category_purchase",
		"RitualCompletedEvent",
		function(context)
			return context:ritual():ritual_category() == self.unit_cap_ritual_category
		end,
		function(context)
			local ritual_key = context:ritual():ritual_key()
			self:modify_ritual_cap_cost(ritual_key, context:performing_faction(), self.unit_cost_modifiers_bundle_string, self.unit_ritual_cost_mod_increment)
		end,
		true
	)
end

function Ruination:hero_capacity_increased_listener()
	core:add_listener(
		"mark_of_ruin_hero_category_purchase",
		"RitualCompletedEvent",
		function(context)
			return context:ritual():ritual_category() == self.hero_cap_ritual_category and self.hero_cap_ritual_list[context:ritual():ritual_key()]
		end,
		function(context)
			local ritual_key = context:ritual():ritual_key()
			self:modify_ritual_cap_cost(ritual_key, context:performing_faction(), self.hero_cost_modifiers_bundle_string, self.hero_ritual_cost_mod_increment)
		end,
		true
	)
end


function Ruination:modify_ritual_cap_cost(ritual_key, faction_interface, bundle_key, multiplier)
	local current_bundle = Ruination:get_faction_bundle_by_key(faction_interface, bundle_key)
	local effect_to_modify_key = ritual_key..self.cost_mod_effect_suffix
	local effects_to_new_values = {}

	if current_bundle then
		local active_effects = current_bundle:effects()
		for i = 0, active_effects:num_items() - 1 do
			local active_effect = active_effects:item_at(i)
			local old_value = active_effect:value()
			local active_effect_key = active_effect:key()
			if active_effect_key == effect_to_modify_key then
				if old_value == 0 then
					effects_to_new_values[active_effect_key] = old_value + multiplier
				else
					effects_to_new_values[active_effect_key] = old_value + (old_value/10 + multiplier)
				end
			else
				effects_to_new_values[active_effect_key] = old_value
			end
		end
	end

	local bundle_to_apply = cm:create_new_custom_effect_bundle(bundle_key)
	local new_effects = bundle_to_apply:effects()

	for i = 0, new_effects:num_items() - 1 do
		local new_effect = new_effects:item_at(i)
		local new_effect_key = new_effect:key()

		if effects_to_new_values[new_effect_key] then
			bundle_to_apply:set_effect_value(new_effect, effects_to_new_values[new_effect_key])
		end
	end

	bundle_to_apply:set_duration(0)

	cm:apply_custom_effect_bundle_to_faction(bundle_to_apply,faction_interface)

end

function Ruination:get_faction_bundle_by_key(faction_interface, bundle_key)
	local effect_bundle_list = faction_interface:effect_bundles()

	for i = 0, effect_bundle_list:num_items() - 1 do
		local effect_bundle = effect_bundle_list:item_at(i)

		if effect_bundle:key() == bundle_key then
			return effect_bundle
		end
	end
end


Ruination.herdstone_building_list = {
	-- Herdstone building chain
	[1] = {
		"wh2_dlc17_bst_settlement_major_2_coast",
		"wh2_dlc17_bst_settlement_major_2",
		"wh2_dlc17_bst_settlement_minor_2_coast",
		"wh2_dlc17_bst_settlement_minor_2",
		"wh2_dlc17_bst_special_settlement_altdorf_2",
		"wh2_dlc17_bst_special_settlement_athel_loren_2",
		"wh2_dlc17_bst_special_settlement_black_crag_2",
		"wh2_dlc17_bst_special_settlement_castle_drakenhof_2",
		"wh2_dlc17_bst_special_settlement_couronne_2",
		"wh2_dlc17_bst_special_settlement_eagle_gate_2",
		"wh2_dlc17_bst_special_settlement_eight_peaks_2",
		"wh2_dlc17_bst_special_settlement_elven_colony_major_2",
		"wh2_dlc17_bst_special_settlement_elven_colony_minor_2",
		"wh2_dlc17_bst_special_settlement_empire_fort_2",
		"wh2_dlc17_bst_special_settlement_gaean_vale_2",
		"wh2_dlc17_bst_special_settlement_galleons_graveyard_2",
		"wh2_dlc17_bst_special_settlement_gryphon_gate_2",
		"wh2_dlc17_bst_special_settlement_hellpit_2",
		"wh2_dlc17_bst_special_settlement_hexoatl_2",
		"wh2_dlc17_bst_special_settlement_itza_2",
		"wh2_dlc17_bst_special_settlement_karaz_a_karak_2",
		"wh2_dlc17_bst_special_settlement_khemri_2",
		"wh2_dlc17_bst_special_settlement_kislev_2",
		"wh2_dlc17_bst_special_settlement_lahmia_2",
		"wh2_dlc17_bst_special_settlement_lothern_2",
		"wh2_dlc17_bst_special_settlement_massif_orcal_2",
		"wh2_dlc17_bst_special_settlement_miragliano_2",
		"wh2_dlc17_bst_special_settlement_naggarond_2",
		"wh2_dlc17_bst_special_settlement_norsca_major_2",
		"wh2_dlc17_bst_special_settlement_norsca_major_coast_2",
		"wh2_dlc17_bst_special_settlement_norsca_minor_2",
		"wh2_dlc17_bst_special_settlement_norsca_minor_coast_2",
		"wh2_dlc17_bst_special_settlement_oak_of_ages_2",
		"wh2_dlc17_bst_special_settlement_phoenix_gate_2",
		"wh2_dlc17_bst_special_settlement_pyramid_of_nagash_2",
		"wh2_dlc17_bst_special_settlement_sartosa_2",
		"wh2_dlc17_bst_special_settlement_skavenblight_2",
		"wh2_dlc17_bst_special_settlement_the_awakening_2",
		"wh2_dlc17_bst_special_settlement_tor_yvresse_2",
		"wh2_dlc17_bst_special_settlement_unicorn_gate_2",
		"wh2_dlc17_bst_special_settlement_konquata_2"
	},
	[2] = {
		"wh2_dlc17_bst_settlement_major_3_coast",
		"wh2_dlc17_bst_settlement_major_3",
		"wh2_dlc17_bst_settlement_minor_3_coast",
		"wh2_dlc17_bst_settlement_minor_3",
		"wh2_dlc17_bst_special_settlement_altdorf_3",
		"wh2_dlc17_bst_special_settlement_athel_loren_3",
		"wh2_dlc17_bst_special_settlement_black_crag_3",
		"wh2_dlc17_bst_special_settlement_castle_drakenhof_3",
		"wh2_dlc17_bst_special_settlement_couronne_3",
		"wh2_dlc17_bst_special_settlement_eagle_gate_3",
		"wh2_dlc17_bst_special_settlement_eight_peaks_3",
		"wh2_dlc17_bst_special_settlement_elven_colony_major_3",
		"wh2_dlc17_bst_special_settlement_elven_colony_minor_3",
		"wh2_dlc17_bst_special_settlement_empire_fort_3",
		"wh2_dlc17_bst_special_settlement_gaean_vale_3",
		"wh2_dlc17_bst_special_settlement_galleons_graveyard_3",
		"wh2_dlc17_bst_special_settlement_gryphon_gate_3",
		"wh2_dlc17_bst_special_settlement_hellpit_3",
		"wh2_dlc17_bst_special_settlement_hexoatl_3",
		"wh2_dlc17_bst_special_settlement_itza_3",
		"wh2_dlc17_bst_special_settlement_karaz_a_karak_3",
		"wh2_dlc17_bst_special_settlement_khemri_3",
		"wh2_dlc17_bst_special_settlement_kislev_3",
		"wh2_dlc17_bst_special_settlement_lahmia_3",
		"wh2_dlc17_bst_special_settlement_lothern_3",
		"wh2_dlc17_bst_special_settlement_massif_orcal_3",
		"wh2_dlc17_bst_special_settlement_miragliano_3",
		"wh2_dlc17_bst_special_settlement_naggarond_3",
		"wh2_dlc17_bst_special_settlement_norsca_major_3",
		"wh2_dlc17_bst_special_settlement_norsca_major_coast_3",
		"wh2_dlc17_bst_special_settlement_norsca_minor_3",
		"wh2_dlc17_bst_special_settlement_norsca_minor_coast_3",
		"wh2_dlc17_bst_special_settlement_oak_of_ages_3",
		"wh2_dlc17_bst_special_settlement_phoenix_gate_3",
		"wh2_dlc17_bst_special_settlement_pyramid_of_nagash_3",
		"wh2_dlc17_bst_special_settlement_sartosa_3",
		"wh2_dlc17_bst_special_settlement_skavenblight_3",
		"wh2_dlc17_bst_special_settlement_the_awakening_3",
		"wh2_dlc17_bst_special_settlement_tor_yvresse_3",
		"wh2_dlc17_bst_special_settlement_unicorn_gate_3",
		"wh2_dlc17_bst_special_settlement_konquata_3"
	},
	[3] = {
		"wh2_dlc17_bst_settlement_major_4_coast",
		"wh2_dlc17_bst_settlement_major_4",
		"wh2_dlc17_bst_settlement_minor_4_coast",
		"wh2_dlc17_bst_settlement_minor_4",
		"wh2_dlc17_bst_special_settlement_altdorf_4",
		"wh2_dlc17_bst_special_settlement_athel_loren_4",
		"wh2_dlc17_bst_special_settlement_black_crag_4",
		"wh2_dlc17_bst_special_settlement_castle_drakenhof_4",
		"wh2_dlc17_bst_special_settlement_couronne_4",
		"wh2_dlc17_bst_special_settlement_eagle_gate_4",
		"wh2_dlc17_bst_special_settlement_eight_peaks_4",
		"wh2_dlc17_bst_special_settlement_elven_colony_major_4",
		"wh2_dlc17_bst_special_settlement_elven_colony_minor_4",
		"wh2_dlc17_bst_special_settlement_empire_fort_4",
		"wh2_dlc17_bst_special_settlement_gaean_vale_4",
		"wh2_dlc17_bst_special_settlement_galleons_graveyard_4",
		"wh2_dlc17_bst_special_settlement_gryphon_gate_4",
		"wh2_dlc17_bst_special_settlement_hellpit_4",
		"wh2_dlc17_bst_special_settlement_hexoatl_4",
		"wh2_dlc17_bst_special_settlement_itza_4",
		"wh2_dlc17_bst_special_settlement_karaz_a_karak_4",
		"wh2_dlc17_bst_special_settlement_khemri_4",
		"wh2_dlc17_bst_special_settlement_kislev_4",
		"wh2_dlc17_bst_special_settlement_lahmia_4",
		"wh2_dlc17_bst_special_settlement_lothern_4",
		"wh2_dlc17_bst_special_settlement_massif_orcal_4",
		"wh2_dlc17_bst_special_settlement_miragliano_4",
		"wh2_dlc17_bst_special_settlement_naggarond_4",
		"wh2_dlc17_bst_special_settlement_norsca_major_4",
		"wh2_dlc17_bst_special_settlement_norsca_major_coast_4",
		"wh2_dlc17_bst_special_settlement_norsca_minor_4",
		"wh2_dlc17_bst_special_settlement_norsca_minor_coast_4",
		"wh2_dlc17_bst_special_settlement_oak_of_ages_4",
		"wh2_dlc17_bst_special_settlement_phoenix_gate_4",
		"wh2_dlc17_bst_special_settlement_pyramid_of_nagash_4",
		"wh2_dlc17_bst_special_settlement_sartosa_4",
		"wh2_dlc17_bst_special_settlement_skavenblight_4",
		"wh2_dlc17_bst_special_settlement_the_awakening_4",
		"wh2_dlc17_bst_special_settlement_tor_yvresse_4",
		"wh2_dlc17_bst_special_settlement_unicorn_gate_4",
		"wh2_dlc17_bst_special_settlement_konquata_4"
	},
	[4] = {
		"wh2_dlc17_bst_settlement_major_5_coast",
		"wh2_dlc17_bst_settlement_major_5",
		"wh2_dlc17_bst_settlement_minor_5_coast",
		"wh2_dlc17_bst_settlement_minor_5",
		"wh2_dlc17_bst_special_settlement_altdorf_5",
		"wh2_dlc17_bst_special_settlement_athel_loren_5",
		"wh2_dlc17_bst_special_settlement_black_crag_5",
		"wh2_dlc17_bst_special_settlement_castle_drakenhof_5",
		"wh2_dlc17_bst_special_settlement_couronne_5",
		"wh2_dlc17_bst_special_settlement_eagle_gate_5",
		"wh2_dlc17_bst_special_settlement_eight_peaks_5",
		"wh2_dlc17_bst_special_settlement_elven_colony_major_5",
		"wh2_dlc17_bst_special_settlement_elven_colony_minor_5",
		"wh2_dlc17_bst_special_settlement_empire_fort_5",
		"wh2_dlc17_bst_special_settlement_gaean_vale_5",
		"wh2_dlc17_bst_special_settlement_galleons_graveyard_5",
		"wh2_dlc17_bst_special_settlement_gryphon_gate_5",
		"wh2_dlc17_bst_special_settlement_hellpit_5",
		"wh2_dlc17_bst_special_settlement_hexoatl_5",
		"wh2_dlc17_bst_special_settlement_itza_5",
		"wh2_dlc17_bst_special_settlement_karaz_a_karak_5",
		"wh2_dlc17_bst_special_settlement_khemri_5",
		"wh2_dlc17_bst_special_settlement_kislev_5",
		"wh2_dlc17_bst_special_settlement_lahmia_5",
		"wh2_dlc17_bst_special_settlement_lothern_5",
		"wh2_dlc17_bst_special_settlement_massif_orcal_5",
		"wh2_dlc17_bst_special_settlement_miragliano_5",
		"wh2_dlc17_bst_special_settlement_naggarond_5",
		"wh2_dlc17_bst_special_settlement_norsca_major_5",
		"wh2_dlc17_bst_special_settlement_norsca_major_coast_5",
		"wh2_dlc17_bst_special_settlement_norsca_minor_5",
		"wh2_dlc17_bst_special_settlement_norsca_minor_coast_5",
		"wh2_dlc17_bst_special_settlement_oak_of_ages_5",
		"wh2_dlc17_bst_special_settlement_phoenix_gate_5",
		"wh2_dlc17_bst_special_settlement_pyramid_of_nagash_5",
		"wh2_dlc17_bst_special_settlement_sartosa_5",
		"wh2_dlc17_bst_special_settlement_skavenblight_5",
		"wh2_dlc17_bst_special_settlement_the_awakening_5",
		"wh2_dlc17_bst_special_settlement_tor_yvresse_5",
		"wh2_dlc17_bst_special_settlement_unicorn_gate_5",
		"wh2_dlc17_bst_special_settlement_konquata_5"
	},
}

-- Separate table as we don't want this information to also be displayed on the progression bar
Ruination.unit_cap_rituals = {
	[1] = {
		"wh2_dlc17_bst_ritual_unit_cap_centigors_all",
		"wh2_dlc17_bst_ritual_unit_cap_chaos_warhounds_poison_razorgor_herd",
		"wh2_dlc17_bst_ritual_unit_cap_gor_herd_all",
		"wh2_dlc17_bst_ritual_unit_cap_harpies_feral_manticore",
		"wh2_dlc17_bst_ritual_unit_cap_tuskgor_chariots_razorgor_chariot",
		"wh2_dlc17_bst_ritual_unit_cap_ungor_herd_spearmen_herd",
	},
	[2] = {
		"wh2_dlc17_bst_ritual_unit_cap_bestigor_herd",
		"wh2_dlc17_bst_ritual_unit_cap_chaos_spawn_giants",
	},
	[3] = {
		"wh2_dlc17_bst_ritual_unit_cap_minotaurs_great_weapons",
		"wh2_dlc17_bst_ritual_unit_cap_minotaurs_shield",
		"wh2_dlc17_bst_ritual_unit_cap_minotaurs",
	},
	[4] = {
		"wh2_dlc17_bst_ritual_unit_cap_cygor",
		"wh2_dlc17_bst_ritual_unit_cap_ghorgon",
		"wh2_dlc17_bst_ritual_unit_cap_jabberslythe",
	},
}

-- Verify herdstone building list is correct
function Ruination:verify_herdstone_building_list()
	local initial_tier = 1
	for i = 2, #self.herdstone_building_list do
		if #self.herdstone_building_list[initial_tier] ~= #self.herdstone_building_list[i] then
			script_error("ERROR: Ruination Herdstone building list: Herdsone building list does not match at tier "..i)
		end
	end
end

-- Locks herdstone buildings for beastmen factions
function Ruination:lock_herdstone_buildings()
	local b_list = self.herdstone_building_list
	for i = 1, #b_list do
		for j = 1, #b_list[i] do
			for p = 1, #self.beastmen_factions do
				cm:add_event_restricted_building_record_for_faction(b_list[i][j], self.beastmen_factions[p], self.herdstone_building_lock_tooltip)
			end
		end
	end
end

function Ruination:herdstone_upgrade_listener()
	core:add_listener(
		"herdstone_building_upgrade",
		"RitualCompletedEvent",
		function(context)
			local ritual_succeeded = context:succeeded()
			if ritual_succeeded and context:performing_faction():is_human() and self.beastmen_factions_set[context:performing_faction():name()] then
				local ritual_key = context:ritual():ritual_key()
				local current_tier_ritual_key = self.herdstone_upgrade_ritual_key..self.herdstone_upgrade_ritual_progress
				return ritual_key == current_tier_ritual_key and self.herdstone_upgrade_ritual_progress <= self.herdstone_upgrade_ritual_cap
			end
			return false
		end,
		function(context)
			-- unlock herdstone building
			local herdstone_tier = self.herdstone_upgrade_ritual_progress
			local b_list = self.herdstone_building_list
			local faction_name = context:performing_faction():name()

			for i = 1, #b_list[herdstone_tier] do
				self:unlock_building(b_list[herdstone_tier][i], faction_name)
			end
			self.herdstone_upgrade_ritual_progress = self.herdstone_upgrade_ritual_progress + 1
		end,
		true
	)
end

-- Beastmen Panel army crafting
function Ruination:army_upgrade_ritual_listener()
	core:add_listener(
		"Bst_RitualCompletedEvent",
		"RitualCompletedEvent",
		function(context)
			return context:succeeded() and context:ritual():ritual_key() == self.army_cap_ritual;
		end,
		function(context)
			self:beastmen_army_crafted(context:performing_faction():name());
		end,
		true
	)
end

function Ruination:beastmen_army_crafted(faction_name)
	local count = cm:get_saved_value(faction_name.."_craft_number") or 1;

	if count > self.max_crafted_armies then
		return;
	end

	cm:apply_effect_bundle(self.craft_armies_ritual_key..count, faction_name, 0);
	cm:set_saved_value(faction_name.."_craft_number", count + 1);
end

----------------------
------save/load-------
----------------------

cm:add_saving_game_callback(
	function(context)
		cm:save_named_value("BeastmenAIProgression", Ruination.beastmen_ai, context)
		cm:save_named_value("BeastmenHerdstoneProgress", Ruination.herdstone_upgrade_ritual_progress, context)
		cm:save_named_value("BeastmenCurrentRuinTier", Ruination.current_ruin_tier, context)
	end
);

cm:add_loading_game_callback(
	function(context)
		Ruination.beastmen_ai = cm:load_named_value("BeastmenAIProgression", Ruination.beastmen_ai, context)
		Ruination.herdstone_upgrade_ritual_progress = cm:load_named_value("BeastmenHerdstoneProgress", Ruination.herdstone_upgrade_ritual_progress, context)
		Ruination.current_ruin_tier = cm:load_named_value("BeastmenCurrentRuinTier", Ruination.current_ruin_tier, context)
	end
);