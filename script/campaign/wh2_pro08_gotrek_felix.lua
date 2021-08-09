--	IF THIS VALUE IS CHANGED NEED TO UPDATE INCIDENT PAYLOAD DURATION AS WELL
local gotrek_turns_available = 30;		-- Turns that Gotrek & Felix are available for the player after appearing 
local gotrek_turns_available_ai = 20;	-- Turns that Gotrek & Felix are available for the AI after appearing
local gotrek_cooldown_turns = 10;		-- Turns before Gotrek & Felix appear for the AI after the player has them
local gotrek_cooldown_turns_ai = 10;	-- Turns before Gotrek & Felix appear for the player after the AI has them
local gotrek_spawn_turn_ai = 10;			-- The turn on which Gotrek & Felix will spawn if the feature is in AI only mode
local gotrek_subculture_details = {
	{
		-- The key of this subculture
		subculture = "wh_main_sc_emp_empire",
		-- The buildings that can unlock the characters when playing as this subculture
		buildings = {"wh_main_emp_tavern_1"},
		-- The name of Gotrek when spawned for this subculture
		names = {"names_name_408896353", "names_name_2147358913", "names_name_2147358913", "names_name_2147358913"}
	},
	{
		subculture = "wh_main_sc_brt_bretonnia",
		buildings = {"wh_main_brt_tavern_1"},
		names = {"names_name_1636839537", "names_name_2147359018", "names_name_2147359018", "names_name_2147359018"}
	},
	{
		subculture = "wh_main_sc_dwf_dwarfs",
		buildings = {"wh_main_dwf_tavern_1"},
		names = {"names_name_2147354371", "names_name_2147358935", "names_name_2147358935", "names_name_2147358935"}
	},
	{
		subculture = "wh_main_sc_teb_teb",
		buildings = {"wh_main_emp_tavern_1"},
		names = {"names_name_408896353", "names_name_2147358913", "names_name_2147358913", "names_name_2147358913"}
	},
};
local gotrek_return_events = {"emp", "brt", "dwf", "teb", "misc"};

local gotrek_state = {
	building = 1,
	marker = 2,
	spawned = 3,
	spawned_ai = 4,
	cooldown = 5,
	cooldown_ai = 6
};
local gotrek_details = {
	owner = "",
	ai_only = false,
	state = gotrek_state.building,
	marker_pending = false,
	level = 0,
	cooldown = 0,
	spawn_turn = 0,
	gotrek_cqi = 0,
	felix_cqi = 0,
	spawn_cqi = 0,
	start_event = 0,
	current_event = 0
};

function add_gotrek_felix_listeners()
	out("#### Adding Gotrek & Felix Listeners ####");
	
	if cm:model():is_multiplayer() == false then
		if cm:is_new_game() == true then
			local gotrek_faction_key, gotrek_ai_owner = gotrek_find_available_faction(false);
			
			if gotrek_ai_owner == false then
				local masked = cm:is_dlc_flag_enabled("TW_WH2_GOTREK_FELIX");
				
				if masked == true then
					gotrek_details.owner = gotrek_faction_key;
					gotrek_details.ai_only = false;
					gotrek_details.state = gotrek_state.building;
					gotrek_details.cooldown = 0;
				else
					gotrek_faction_key, gotrek_ai_owner = gotrek_find_available_faction(true);
					gotrek_details.owner = gotrek_faction_key;
					gotrek_details.ai_only = true;
					gotrek_details.state = gotrek_state.cooldown;
					gotrek_details.cooldown = gotrek_spawn_turn_ai;
				end
			else
				gotrek_details.owner = gotrek_faction_key;
				gotrek_details.ai_only = true;
				gotrek_details.state = gotrek_state.cooldown;
				gotrek_details.cooldown = gotrek_spawn_turn_ai;
			end
			------------------------------------- CBF -------------------------------------
			gotrek_details.level = 1;
			------------------------------------- END -------------------------------------
			gotrek_details.spawn_turn = 0;
			gotrek_details.gotrek_cqi = 0;
			gotrek_details.felix_cqi = 0;
		end
		gotrek_setup();
	end
end

function gotrek_find_available_faction(exclude_player)
	if exclude_player == false then
		local human_factions = cm:get_human_factions();
		if human_factions[1] ~= nil then
			local faction_key = human_factions[1];
			local human_faction = cm:model():world():faction_by_key(faction_key);
			
			if human_faction:is_null_interface() == false then
				local subculture = human_faction:subculture();
				
				for i = 1, #gotrek_subculture_details do
					if subculture == gotrek_subculture_details[i].subculture then
						return faction_key, false;
					end
				end
			end
		end
	end
	
	-- If the target faction isn't the player we need to find a suitable AI faction
	local faction_list = cm:model():world():faction_list();
	local possible_factions = {};
	
	for i = 0, faction_list:num_items() - 1 do
		local faction = faction_list:item_at(i);
		
		if faction:is_human() == false and faction:is_quest_battle_faction() == false and faction:is_dead() == false then
			local faction_key = faction:name();
			local subculture = faction:subculture();
			
			if faction_key ~= "wh_main_emp_empire_separatists" then
				for j = 1, #gotrek_subculture_details do
					if subculture == gotrek_subculture_details[j].subculture then
						table.insert(possible_factions, faction_key);
						break;
					end
				end
			end
		end
	end
	
	local rand = cm:random_number(#possible_factions);
	return possible_factions[rand], true;
end

function gotrek_setup()
	-- Building Completed
	core:add_listener(
		"gotrek_BuildingCompleted",
		"BuildingCompleted",
		function(context)
			return gotrek_details.state == gotrek_state.building;
		end,
		function(context)
			local building = context:building();
			local faction = building:faction();
			
			if faction:name() == gotrek_details.owner then
				local subculture = faction:subculture();
				
				for i = 1, #gotrek_subculture_details do
					if subculture == gotrek_subculture_details[i].subculture then
						for j = 1, #gotrek_subculture_details[i].buildings do
							if gotrek_subculture_details[i].buildings[j] == building:name() then
								local region_key = building:region():name();
								local pos_x, pos_y = cm:find_valid_spawn_location_for_character_from_settlement(gotrek_details.owner, region_key, false, true, 9);
								
								if pos_x > -1 then
									cm:add_interactable_campaign_marker("gotrek_marker", "gotrek_marker", pos_x, pos_y, 2, gotrek_details.owner, "");
									gotrek_details.state = gotrek_state.marker;
									
									cm:show_message_event_located(
										gotrek_details.owner,
										"event_feed_strings_text_wh2_pro08_event_feed_string_scripted_event_gotrek_felix_title",
										"event_feed_strings_text_wh2_pro08_event_feed_string_scripted_event_gotrek_felix_appear_primary_detail",
										"event_feed_strings_text_wh2_pro08_event_feed_string_scripted_event_gotrek_felix_appear_secondary_detail",
										pos_x, pos_y,
										false,
										1308
									);
									core:trigger_event("ScriptEventGotrekAndFelixPubBuilt");
								end
								break;
							end
						end
						break;
					end
				end
			end
		end,
		true
	);
	-- Marker Entered
	core:add_listener(
		"gotrek_AreaEntered",
		"AreaEntered",
		function(context)
			return context:area_key() == "gotrek_marker";
		end,
		function(context)
			local character = context:character();
			local faction_key = character:faction():name();
			gotrek_details.spawn_cqi = character:command_queue_index();
			gotrek_details.marker_pending = gotrek_details.marker_pending or false;

			if gotrek_details.marker_pending == false then
				gotrek_details.marker_pending = true;
				cm:trigger_dilemma(faction_key, "wh2_pro08_dilemma_gotrek_felix");
			end
		end,
		true
	);
	-- Dilemma Choice
	core:add_listener(
		"gotrek_DilemmaChoiceMadeEvent",
		"DilemmaChoiceMadeEvent",
		function(context)
			return context:dilemma() == "wh2_pro08_dilemma_gotrek_felix";
		end,
		function(context)
			local choice = context:choice();
			gotrek_details.marker_pending = false;

			if choice == 0 then
				if cm:model():has_character_command_queue_index(gotrek_details.spawn_cqi) then
					local character = cm:model():character_for_command_queue_index(gotrek_details.spawn_cqi);
					local region_key = character:region():name();
					local subculture = character:faction():subculture();
					local pos_x, pos_y = cm:find_valid_spawn_location_for_character_from_character(gotrek_details.owner, "character_cqi:"..gotrek_details.spawn_cqi, true, 2);
					
					if pos_x > 1 then

						cm:trigger_transient_intervention(
							"g_f_spawn_on_dilemma",
							function(intervention)

								-- Listen for Gotrek being spawned and then spawn Felix next to him
								core:add_listener(
									"gotrek_felix_CharacterCreated",
									"CharacterCreated",
									function(context)
										return context:character():character_subtype("wh2_pro08_neu_gotrek");
									end,
									function(context)
										local gotrek = context:character();
										local gotrek_cqi = gotrek:command_queue_index();
										local gorek_faction_cqi = gotrek:faction():command_queue_index();
										-- Spawn Felix
										cm:spawn_unique_agent_at_character(gorek_faction_cqi, "wh2_pro08_neu_felix", gotrek_cqi, true);
									end,
									false
								);
								for i = 1, #gotrek_subculture_details do
									if subculture == gotrek_subculture_details[i].subculture then
										-- Spawn Gotrek
										cm:create_force_with_general(
											gotrek_details.owner,
											"",
											region_key,	pos_x, pos_y,
											"general", "wh2_pro08_neu_gotrek",
											gotrek_subculture_details[i].names[1],
											gotrek_subculture_details[i].names[2],
											gotrek_subculture_details[i].names[3],
											gotrek_subculture_details[i].names[4],
											false,
											function()
												CampaignUI.ClearSelection();
											end
										);
										break;
									end
								end
								
								gotrek_details.state = gotrek_state.spawned;
								gotrek_details.level = gotrek_details.level + 1;
								gotrek_details.cooldown = gotrek_turns_available;
								
								cm:trigger_incident(gotrek_details.owner, "wh2_pro08_incident_neu_unlocking", true);
								--cm:trigger_campaign_vo("gotrek_felix_arrival", gotrek_details.gotrek_cqi, 0.0);
								F_and_G_camera("gotrek_felix_arrival", "character_cqi:"..gotrek_details.spawn_cqi, {pos_x, pos_y}, false, intervention);
								gotrek_debug("Marker Entered");
							end,
							BOOL_INTERVENTIONS_DEBUG,
							function(intervention)
								-- configure intervention here

								-- allow transient scripted event to be shown while intervention is active
								intervention:whitelist_events("faction_event_incidentevent_feed_target_incident_faction");
								intervention:whitelist_events("faction_event_character_incidentevent_feed_target_incident_faction");
								intervention:whitelist_events("faction_event_region_incidentevent_feed_target_incident_faction");
							end
						);
						cm:remove_interactable_campaign_marker("gotrek_marker");
					end
				end
			end
		end,
		true
	);
	-- Set Character CQI's
	core:add_listener(
		"gotrek_or_felix_CharacterCreated",
		"CharacterCreated",
		function(context)
			return context:character():character_subtype("wh2_pro08_neu_gotrek") or context:character():character_subtype("wh2_pro08_neu_felix");
		end,
		function(context)
			local char_cqi = context:character():command_queue_index();
			------------------------------------- CBF -------------------------------------
			if context:character():character_subtype("wh2_pro08_neu_gotrek") and not context:character():is_wounded() then
			------------------------------------- END -------------------------------------
				-- Gotrek has spawned
				gotrek_details.gotrek_cqi = char_cqi;
				out("Gotrek CQI : "..char_cqi);

				cm:callback(function()
					cm:replenish_action_points("character_cqi:"..char_cqi);
					cm:set_character_immortality("character_cqi:"..gotrek_details.gotrek_cqi, true);
					cm:apply_effect_bundle_to_characters_force("wh2_pro08_gotrek_xp_sharing", char_cqi, 30, true);
				end, 0.5);

				if gotrek_details.level == 2 then
					cm:force_add_trait("character_cqi:"..char_cqi, "wh2_pro08_trait_gotrek", true, 1)
				elseif gotrek_details.level == 3 then
					cm:force_add_trait("character_cqi:"..char_cqi, "wh2_pro08_trait_gotrek", true, 2)
				elseif gotrek_details.level >= 4 then
					cm:force_add_trait("character_cqi:"..char_cqi, "wh2_pro08_trait_gotrek", true, 3)
				end;
				
				-- F_and_G_camera(key, loc, delay) - WHEN THEY SPAWN - gotrek_details.gotrek_cqi can get you gotreks force from cqi
			------------------------------------- CBF -------------------------------------
			elseif context:character():character_subtype("wh2_pro08_neu_felix") and not context:character():is_wounded() then
			------------------------------------- END -------------------------------------
				-- Felix has spawned
				gotrek_details.felix_cqi = char_cqi;
				out("Felix CQI : "..char_cqi);

				cm:callback(function()
					local felix_char = cm:model():character_for_command_queue_index(gotrek_details.felix_cqi);

					-- check that Felix is still a valid char at this point
					if felix_char:is_null_interface() or felix_char:is_wounded() then
						return
					end

					local gotrek_char = cm:model():character_for_command_queue_index(gotrek_details.gotrek_cqi);
					local gotrek_force = gotrek_char:military_force();
					cm:embed_agent_in_force(felix_char, gotrek_force);
					cm:replenish_action_points("character_cqi:"..char_cqi);
					cm:set_character_immortality("character_cqi:"..gotrek_details.felix_cqi, true);
					
				end, 
				0.5);

				if gotrek_details.level == 2 then
					cm:force_add_trait("character_cqi:"..char_cqi, "wh2_pro08_trait_felix", true, 1)
				elseif gotrek_details.level == 3 then
					cm:force_add_trait("character_cqi:"..char_cqi, "wh2_pro08_trait_felix", true, 2)
				elseif gotrek_details.level >= 4 then
					cm:force_add_trait("character_cqi:"..char_cqi, "wh2_pro08_trait_felix", true, 3)
				end;
			end
		end,
		true
	);
	-- Turns Available
	core:add_listener(
		"gotrek_FactionBeginTurnPhaseNormal",
		"FactionBeginTurnPhaseNormal",
		function(context)
			return gotrek_details.state == gotrek_state.spawned or gotrek_details.state == gotrek_state.spawned_ai;
		end,
		function(context)
			if context:faction():name() == gotrek_details.owner then
				if gotrek_details.cooldown > 0 then
					gotrek_details.cooldown = gotrek_details.cooldown - 1;
					
					if gotrek_details.cooldown == 0 then
						
						if not cm:get_faction(gotrek_details.owner):is_human() or not cm:get_character_by_cqi(gotrek_details.gotrek_cqi) then
							kill_F_and_G(true);
							return;
						end
					
						-- wrap G + F leaving in an intervention, as it shows a cutscene
						cm:trigger_transient_intervention(
							"g_f_leave_faction_turn_start",
							function(intervention)
							
								-- verify that Gotrek exists on the map before proceeding
								if not cm:get_character_by_cqi(gotrek_details.gotrek_cqi) then
									kill_F_and_G(true);
									intervention:complete();
									return;
								end;
							
								cm:show_message_event(
									gotrek_details.owner,
									"event_feed_strings_text_wh2_pro08_event_feed_string_scripted_event_gotrek_felix_title",
									"event_feed_strings_text_wh2_pro08_event_feed_string_scripted_event_gotrek_felix_leave_primary_detail",
									"event_feed_strings_text_wh2_pro08_event_feed_string_scripted_event_gotrek_felix_leave_secondary_detail",
									false,
									1309
								);
								if cm:get_faction(gotrek_details.owner):is_human() then
									core:trigger_event("ScriptEventGotrekAndFelixDepart");
								end

								-- F_and_G_camera(key, loc, delay) - WHEN THEY LEAVE - gotrek_details.gotrek_cqi can get you gotreks force from cqi
								
								cm:disable_event_feed_events(true, "wh_event_category_character", "", "");
								
								-- Pass none, as we want this to default to the player's faction leader vo_actor
								-- as by the time the vo tracker will attempt to play this, they'll both be "dead"
								--cm:trigger_campaign_vo("gotrek_felix_departure", "none", 0.0);
								F_and_G_camera(
									"gotrek_felix_departure", 
									"character_cqi:"..gotrek_details.gotrek_cqi, 
									{cm:get_character_by_cqi(gotrek_details.gotrek_cqi):logical_position_x(), cm:get_character_by_cqi(gotrek_details.gotrek_cqi):logical_position_y()}, 
									true, 
									intervention
								);
							end,
							BOOL_INTERVENTIONS_DEBUG,
							function(intervention)
								-- configure intervention here
								
								-- allow transient scripted event to be shown while intervention is active
								intervention:whitelist_events("scripted_transient_eventevent_feed_target_faction");
							end
						);
					end
				end
			end
		end,
		true
	);
	-- Owner faction died
	core:add_listener(
		"gotrek_FactionBeginTurnPhaseNormalDead",
		"ScriptEventPlayerFactionTurnStart",
		function(context)
			return gotrek_details.state == gotrek_state.spawned_ai;
		end,
		function(context)
			local owner = cm:model():world():faction_by_key(gotrek_details.owner);
	
			if owner:is_null_interface() == true or owner:is_dead() == true then
				local gotrek_char = cm:model():character_for_command_queue_index(gotrek_details.gotrek_cqi);

				if gotrek_char:is_null_interface() == false and gotrek_char:character_subtype("wh2_pro08_neu_felix") == true then
					cm:disable_event_feed_events(true, "wh_event_category_character", "", "");

					-- Kill Gotrek
					cm:set_character_immortality("character_cqi:"..gotrek_details.gotrek_cqi, false);
					cm:kill_character(gotrek_details.gotrek_cqi, false, false);
					-- Kill Felix
					cm:set_character_immortality("character_cqi:"..gotrek_details.felix_cqi, false);
					cm:kill_character(gotrek_details.felix_cqi, false, false);
					
					cm:disable_event_feed_events(false, "wh_event_category_character", "", "");

					if gotrek_details.ai_only == true then
						-- A.I's turn to have them!
						local gotrek_faction_key, gotrek_ai_owner = gotrek_find_available_faction(true);
						gotrek_details.owner = gotrek_faction_key;
						gotrek_details.state = gotrek_state.cooldown;
						gotrek_details.cooldown = gotrek_cooldown_turns;
						gotrek_debug("AI Turn");
					else
						-- The Player's turn to have them!
						local gotrek_faction_key, gotrek_ai_owner = gotrek_find_available_faction(false);
						gotrek_details.owner = gotrek_faction_key;
						gotrek_details.state = gotrek_state.cooldown_ai;
						gotrek_details.cooldown = gotrek_cooldown_turns_ai;
						gotrek_debug("Players Turn");
					end
				end
			end
		end,
		true
	);
	-- Character spawning
	core:add_listener(
		"gotrek_AI_FactionBeginTurnPhaseNormal",
		"FactionBeginTurnPhaseNormal",
		function(context)
			return gotrek_details.state == gotrek_state.cooldown or gotrek_details.state == gotrek_state.cooldown_ai;
		end,
		function(context)
			local faction = context:faction();
			local subculture = faction:subculture();
			
			if faction:name() == gotrek_details.owner then
				if gotrek_details.cooldown > 0 then
					gotrek_details.cooldown = gotrek_details.cooldown - 1;
					
					if gotrek_details.cooldown == 0 then
						if gotrek_details.state == gotrek_state.cooldown then
							-- Spawn them for the AI
							if faction:has_home_region() == true then
								local home = faction:home_region();
								local region_key = home:name();
								local pos_x, pos_y = cm:find_valid_spawn_location_for_character_from_settlement(gotrek_details.owner, region_key, false, true, 3);
								
								if pos_x > 1 then
									for i = 1, #gotrek_subculture_details do
										if subculture == gotrek_subculture_details[i].subculture then
											
											-- Spawn Gotrek
											cm:create_force_with_general(
												gotrek_details.owner,
												"",
												region_key,	pos_x, pos_y,
												"general", "wh2_pro08_neu_gotrek",
												gotrek_subculture_details[i].names[1],
												gotrek_subculture_details[i].names[2],
												gotrek_subculture_details[i].names[3],
												gotrek_subculture_details[i].names[4],
												false,
												function(cqi)
													gotrek_cqi = cqi;
													-- Spawn Felix
													cm:spawn_unique_agent_at_character(cm:get_character_by_cqi(gotrek_cqi):faction():command_queue_index(), "wh2_pro08_neu_felix", gotrek_cqi, true);
												end
											);
											-- Set Character CQI's
											core:add_listener(
												"felix_created",
												"CharacterCreated",
												function(context)
													return gotrek_cqi and context:character():character_subtype("wh2_pro08_neu_felix");
												end,
												function(context)
													cm:embed_agent_in_force(context:character(), cm:get_character_by_cqi(gotrek_cqi):military_force());
												end,
												false
											);
											
											if gotrek_details.current_event == gotrek_details.start_event then
												gotrek_details.start_event = cm:random_number(#gotrek_return_events);
												gotrek_details.current_event = gotrek_details.start_event - 1;
											end
											gotrek_details.current_event = gotrek_details.current_event + 1;
											
											gotrek_debug("Spawned For AI");
											break;
										end
									end
								end
								
								gotrek_details.state = gotrek_state.spawned_ai;
								gotrek_details.cooldown = gotrek_turns_available_ai;
							end
						elseif gotrek_details.state == gotrek_state.cooldown_ai then
							-- Spawn them for the player
							local region_list = faction:region_list();
							local possible_regions = {};

							for i = 0, region_list:num_items() - 1 do
								local current_region = region_list:item_at(i);
								local adjacent_regions = current_region:adjacent_region_list();
								
								for j = 1, adjacent_regions:num_items() - 1 do
									local adj_region = adjacent_regions:item_at(j);
									
									if adj_region:is_abandoned() == false and adj_region:owning_faction():at_war_with(faction) == true then
										table.insert(possible_regions, current_region);
										break;
									end
								end
							end
							
							-- Backup spawn at the capital
							if #possible_regions == 0 and faction:has_home_region() == true then
								local home = faction:home_region();
								table.insert(possible_regions, home);
							end
							
							if #possible_regions > 0 then
								-- Spawn the marker
								local rand = cm:random_number(#possible_regions);
								local region = possible_regions[rand];
								local region_key = region:name();
								local pos_x, pos_y = cm:find_valid_spawn_location_for_character_from_settlement(gotrek_details.owner, region_key, false, true, 9);
								
								if pos_x > -1 then
									cm:add_interactable_campaign_marker("gotrek_marker", "gotrek_marker", pos_x, pos_y, 2, gotrek_details.owner, "");
									gotrek_details.state = gotrek_state.marker;
									local event_str = "wh2_pro08_event_feed_string_scripted_event_gotrek_felix_reappear_";
									local event_num = gotrek_details.current_event or 1;
									local event_apx = gotrek_return_events[event_num] or "misc";
									
									cm:show_message_event_located(
										gotrek_details.owner,
										"event_feed_strings_text_wh2_pro08_event_feed_string_scripted_event_gotrek_felix_title",
										"event_feed_strings_text_"..event_str..event_apx.."_primary_detail",
										"event_feed_strings_text_"..event_str..event_apx.."_secondary_detail",
										pos_x, pos_y,
										false,
										1308
									);
									
									gotrek_debug("Marker For Player");
								end
							else
								local gotrek_faction_key, gotrek_ai_owner = gotrek_find_available_faction(true);
								gotrek_details.owner = gotrek_faction_key;
								gotrek_details.state = gotrek_state.cooldown;
								gotrek_details.cooldown = gotrek_cooldown_turns;
								gotrek_debug("AI Backup");
							end
						end
					end
				end
			end
		end,
		true
	);
end

function gotrek_debug(o)
	out.design("###########################################");
	out.design("Script Event: "..tostring(o));
	out.design("Owner: "..tostring(gotrek_details.owner));
	out.design("State: "..tostring(gotrek_details.state).."  /  Level: "..tostring(gotrek_details.level).."  /  Cooldown: "..tostring(gotrek_details.cooldown));
	out.design("Gotrek CQI: "..tostring(gotrek_details.gotrek_cqi).."  /  Felix CQI: "..tostring(gotrek_details.felix_cqi));
	out.design("###########################################");
end

function kill_F_and_G(kill)
	if not (gotrek_details.state == gotrek_state.spawned or gotrek_details.state == gotrek_state.spawned_ai) or kill ~= true then
		return;
	end
	
	local gotrek_char = cm:model():character_for_command_queue_index(gotrek_details.gotrek_cqi);

	if gotrek_char:is_null_interface() == false and gotrek_char:character_subtype("wh2_pro08_neu_gotrek") == true then
		-- Kill Gotrek
		cm:set_character_immortality("character_cqi:"..gotrek_details.gotrek_cqi, false);
		cm:kill_character(gotrek_details.gotrek_cqi, false, false);
		-- Kill Felix
		cm:set_character_immortality("character_cqi:"..gotrek_details.felix_cqi, false);
		cm:kill_character(gotrek_details.felix_cqi, false, false);
									
		cm:disable_event_feed_events(false, "wh_event_category_character", "", "");
									
		if gotrek_details.state == gotrek_state.spawned or gotrek_details.ai_only == true then
			-- A.I's turn to have them!
			local gotrek_faction_key, gotrek_ai_owner = gotrek_find_available_faction(true);
			gotrek_details.owner = gotrek_faction_key;
			gotrek_details.state = gotrek_state.cooldown;
			gotrek_details.cooldown = gotrek_cooldown_turns;
			gotrek_debug("AI Turn");
		elseif gotrek_details.state == gotrek_state.spawned_ai then
			-- The Player's turn to have them!
			local gotrek_faction_key, gotrek_ai_owner = gotrek_find_available_faction(false);
			gotrek_details.owner = gotrek_faction_key;
			gotrek_details.state = gotrek_state.cooldown_ai;
			gotrek_details.cooldown = gotrek_cooldown_turns_ai;
			gotrek_debug("Players Turn");
		end
	end
end

-- this is play the camera span to loc, playing one of the randomized lines of gotrek and felix_char
-- use key to define if it's an arrival line or it's an exit line
-- the delay is to queue the line abit to fit with the camera movement
-- because the line is randomized, i asked John Burchell to make it also return the length of the due line when we call cm:trigger_campaign_vo() function, so this returned value should be used to control the length of the cutscene
-- the vo will be played regardless, i don't know if that's good or bad, but it smells like that's how it should work. 
function F_and_G_camera(key, cqi, loc, kill, intervention)
	if not cm:get_faction(gotrek_details.owner):is_human() then
		kill_F_and_G(kill);
		if intervention then
			intervention:complete();
		end;
		return;
	end
	local length = 20;
	local delay = 3;
	cm:trigger_campaign_vo(key, cqi, delay);
	--length = length + delay;
	
	--(14.979279 -0.000111 11.504411)
	local cam_skip_x, cam_skip_y, cam_skip_d, cam_skip_b, cam_skip_h = cm:get_camera_position();
	cm:take_shroud_snapshot();
	
	local F_and_G_scene = campaign_cutscene:new(
		"F_and_G_scene",
		length,
		function()
			cm:modify_advice(true);
			cutscene_nd(cam_skip_x, cam_skip_y, cam_skip_d, cam_skip_b, cam_skip_h, intervention);
		end
	);

	F_and_G_scene:set_skippable(true, function() cutscene_skipped(kill) end);
	F_and_G_scene:set_skip_camera(cam_skip_x, cam_skip_y, cam_skip_d, cam_skip_b, cam_skip_h);
	F_and_G_scene:set_disable_settlement_labels(false);
	F_and_G_scene:set_dismiss_advice_on_end(true);
	
	F_and_G_scene:action(
		function()
			cm:fade_scene(0, 2);
			cm:clear_infotext();
		end,
		0
	);
	
	F_and_G_scene:action(
		function()
			cm:show_shroud(false);
			
			
			local x_pos, y_pos = cm:log_to_dis(loc[1], loc[2]);
			cm:set_camera_position( x_pos, y_pos, cam_skip_d, cam_skip_b, cam_skip_h);
			cm:fade_scene(1, 2);
		end,
		2
	);
	
	F_and_G_scene:action(
		function()
			cm:fade_scene(0, 1);
		end,
		length - 1
	);
		
	F_and_G_scene:action(
		function()
			cm:set_camera_position(cam_skip_x, cam_skip_y, cam_skip_d, cam_skip_b, cam_skip_h);
			cm:fade_scene(1, 1);
			kill_F_and_G(kill);
		end,
		length
	);
	
	F_and_G_scene:start();
	
	--cm:callback(function() F_and_G_scene:skip(false) end, 10);
	
	core:add_listener(
		"skip_camera_after_vo_ended",
		"ScriptTriggeredVOFinished",
		function()
			return true;
		end,
		function()
			F_and_G_scene:skip(false);
			--kill_F_and_G();
		end,
		true
	);
	
	
end

function cutscene_skipped(kill)
	cm:override_ui("disable_advice_audio", true);
	
	effect.clear_advice_session_history();
	
	-- for i = 1, #advice_to_play do
		-- cm:trigger_campaign_vo(advice_to_play[i], gotrek_details.gotrek_cqi, 0);
	-- end;
	
	cm:callback(function() cm:override_ui("disable_advice_audio", false) end, 0.5);
	cm:restore_shroud_from_snapshot();
	kill_F_and_G(kill);
end;

function cutscene_nd(cam_skip_x, cam_skip_y, cam_skip_d, cam_skip_b, cam_skip_h, intervention)
	cm:set_camera_position(cam_skip_x, cam_skip_y, cam_skip_d, cam_skip_b, cam_skip_h);
	cm:restore_shroud_from_snapshot();
	cm:fade_scene(1, 1);

	-- complete supplied intervention
	if intervention then
		cm:callback(
			function()
				intervention:complete();
			end,
			1
		);
	end;
end


--------------------------------------------------------------
----------------------- SAVING / LOADING ---------------------
--------------------------------------------------------------
cm:add_saving_game_callback(
	function(context)
		cm:save_named_value("gotrek_details", gotrek_details, context);
	end
);

cm:add_loading_game_callback(
	function(context)
		gotrek_details = cm:load_named_value("gotrek_details", {}, context);
	end
);