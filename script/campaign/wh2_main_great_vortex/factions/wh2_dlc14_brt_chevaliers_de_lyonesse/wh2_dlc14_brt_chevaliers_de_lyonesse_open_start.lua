


-----------------------------------------------------------------------------------
-----------------------------------------------------------------------------------
--
--	OPEN CAMPAIGN INTRO SCRIPT
--
--	Script for the intro to the main open campaign - loaded if the player hasn't
--	selected to play the intro first turn on the frontend, or if they have and
--	they've completed it
--
-----------------------------------------------------------------------------------
-----------------------------------------------------------------------------------

---------------------------------------------------------------
--	Start the open campaign from the intro cutscene (first-turn skipped)
---------------------------------------------------------------

function start_open_campaign_from_intro_cutscene()

	-- show advisor dismiss button
	cm:modify_advice(true);

	start_open_campaign(false);
end;



---------------------------------------------------------------
--	Start the open campaign (shared)
---------------------------------------------------------------

function start_open_campaign(from_intro_first_turn)
	out("start_open_campaign() called, from intro first turn: " .. tostring(from_intro_first_turn));
	
	-- start interventions
	start_interventions();
	
	-- kicks off mission proceedings
	start_early_game_missions(from_intro_first_turn, true);
end;



---------------------------------------------------------------
--	Start all faction-specific interventions
---------------------------------------------------------------

function start_interventions()

	out.interventions("* start_interventions() called");
	out("* start_interventions() called");
	
	--[[
	in_empire_technology_requirements:start();
	in_empire_technologies:start();
	in_empire_racial_advice:start();
	in_offices_advice:start();
	]]
			
	-- global
	start_global_interventions(true);
end;


---------------------------------------------------------------
--	Early-game missions
--	Start the listeners that trigger the early-game missions.
--	the underlying functions are found in wh2_early_game.lua
---------------------------------------------------------------

-- do this immediately upon load of this file
do
	-- how they play event message that appears at the start of the open campaign
	start_early_game_how_they_play_listener();
	
	
	local difficulty_level = cm:model():difficulty_level();
	
	local difficulty_level = cm:model():difficulty_level();
	
	do
		local personality_key = "wh2_lizardmen_early_internally_hostile_aggressive_easy";
		
		if difficulty_level == 0 or difficulty_level == -1 then
			personality_key = "wh2_lizardmen_early_internally_hostile_aggressive";								-- normal/hard
		elseif difficulty_level == -2 or difficulty_level == -3 then
			personality_key = "wh2_lizardmen_early_internally_hostile_aggressive_less_diplomatic_hard";		-- v.hard/legendary
		end;
		
		-- prevents the supplied principal enemy faction from being able to request peace, sets them into the supplied personality, and prevents anyone from arranging a NAP or a trade agreement with the player until a message is received
		-- also prevents anyone declaring war with the player for the specified number of turns from the start of the game
		-- enemy_faction_key, enemy_personality_key, num_turns_before_war
		start_early_game_diplomacy_setup_listener(
			"wh2_main_lzd_tlaxtlan",
			personality_key,
			3
		);
	end;
	
	-- set the first turn count modifier - this tells early-game scripts that the first-turn turn should not be counted towards missions that trigger on certain turns
	if not cm:get_saved_value("first_turn_count_modifier") then
		cm:set_saved_value("first_turn_count_modifier", 0);
	end;
	
	
	-- get/cache the cqi of the initial enemy lord that we pan the camera to
	enemy_initial_lord_char_cqi = cm:get_cached_value(
		"enemy_initial_lord_char_cqi",
		function()
			local character = cm:get_closest_general_to_position_from_faction(cm:get_faction("wh2_main_lzd_tlaxtlan"), 191, 320, false);
			if character then
				return character:cqi();
			end;
		end
	);
	
	
	-- prevent specific nearby enemy character from moving too far at start of game, so the player can chase them down
	-- lord_cqi, [list of effect bundles to be applied per-turn]
	start_early_game_character_lockdown_listener(
		enemy_initial_lord_char_cqi, 
		"wh_main_reduced_movement_range_90",
		"wh_main_reduced_movement_range_60",
		"wh_main_reduced_movement_range_30"
	);
	
	
	-- capture enemy settlement mission that triggers on the first turn of the open campaign
	-- advice_key, infotext (nil for default), mission_key, enemy_region_name (OR char cqi), enemy_faction_name, mission_rewards
	start_early_game_capture_enemy_settlement_mission_listener(
		-- The beasts of this land must be removed if our colonies are to flourish. The first blow must be swift and lethal; it is vital we deal a crippling blow to these monsters before they can move against us.
		"wh2_dlc14.camp.vortex.repanse_de_lyonesse.early_game.001",
		nil, 
		"wh2_dlc14_brt_repanse_early_game_capture_settlement",
		"CHRISTOPH",
		"wh2_main_vor_coast_of_araby_martek",
		"wh2_main_vmp_strygos_empire",
		{
			"money 500"
		},
		true,
		nil,
		nil,
		true
	);
	
	
	-- capture province listener - triggers on completion of the capture enemy settlement mission (see above), or when the player 
	-- captures a settlement not in their starting province
	-- advice_key, infotext, mission_key, mission_rewards
	start_early_game_capture_province_mission_listener(
		-- If our people are to thrive, we will need a solid foundation. We must gain control over this entire territory and fortify it. The monsters of this land will learn not to cross our borders. 
		"wh2_dlc14.camp.vortex.repanse_de_lyonesse.early_game.002",
		nil,
		"wh2_dlc14_brt_repanse_early_game_capture_province",
		"CHRISTOPH",
		{
			"money 500"
		},
		"1",
		true
	);
	
	
	-- enact commandment listener - triggers when the player captures a province
	-- advice_key, infotext, mission_key, mission_rewards
	start_early_game_enact_commandment_mission_listener(
		-- Your armed forces have secured the province, my Lord. Any contesting claim to this territory has been eliminated. Now that your rule is unquestioned, you may consider issuing a commandment to rouse the populace, so that they may better serve your ends.
		"wh2.camp.vortex.advice.early_game.commandments.001",
		nil,
		"wh2_dlc14_brt_repanse_early_game_enact_commandment",
		"CHRISTOPH",
		{
			"money 500"
		}
	);
	
	
	-- search ruins listener
	-- triggers at the start of turn two
	-- advice_key, infotext, region_key, trigger_turn, mission_key, mission_issuer, mission_rewards, factions_personalities_mapping
	start_early_game_search_ruins_mission_listener(		
		-- If our colonies are to prosper we must know what dangers this land harbours. Abandoned ruins may contain useful information about threats of the past that may yet return in the future.
		"wh2_dlc14.camp.vortex.repanse_de_lyonesse.early_game.003",
		nil,
		"wh2_main_vor_the_great_desert_bel_aliad",
		6,
		"wh2_dlc14_brt_repanse_early_game_search_ruins",
		"CHRISTOPH",
		{
			"money 500"
		},
		nil,
		true
	);
	
	
	-- rogue armies listener
	-- spawns a rogue army the turn after the player searches ruins
	-- advice_key, infotext, mission_key, rogue_army_faction_name, rogue_army_position_list, rogue_army_unit_list, rogue_army_home_region, mission_rewards
	start_early_game_rogue_army_mission_listener(
		-- A wandering host approaches! Beware of such 'rogue armies', my lord - they must not be allowed to threaten your realm. Do not tolerate their incursions on your soil!
		"wh2.camp.vortex.advice.early_game.rogue_armies.001", 
		nil,
		"wh2_dlc14_brt_repanse_early_game_rogue_armies",
		"CHRISTOPH",
		"wh2_main_rogue_the_wandering_dead",
		{
			{v(458, 325), "wh2_main_vor_coast_of_araby_copher"},
			{v(499, 344), "wh2_main_vor_coast_of_araby_copher"},
			{v(488, 324), "wh2_main_vor_coast_of_araby_copher"}
		},
		"wh_main_vmp_cha_banshee,wh_main_vmp_inf_cairn_wraiths,wh_main_vmp_inf_crypt_ghouls,wh_main_vmp_inf_skeleton_warriors_0,wh_main_vmp_inf_skeleton_warriors_1,wh_main_vmp_inf_zombie,wh_main_vmp_inf_zombie,wh_main_vmp_inf_zombie,wh_main_vmp_inf_zombie",
		"wh2_main_vor_coast_of_araby_copher",
		{
			"money 500"
		}
	);
	
	
	
	-- research tech mission
	-- triggers once the player has built a tech-capable building
	-- advice_key, infotext, mission_key, mission_rewards
	start_early_game_research_tech_mission_listener(
		-- You now have the facilities to begin technological research, my Lord. It only remains for you to choose the direction of development.
		"wh2.camp.vortex.advice.early_game.tech_research.001",
		nil,
		"wh2_dlc14_brt_repanse_early_game_research_tech",
		"CHRISTOPH",
		{
			"money 500"
		},
		false,
		true,
		5
	);
	
	
	-- eliminate faction mission
	-- triggers once the principal enemy faction is down to a small number of settlements
	-- advice_key, infotext, mission_key, faction_key, number_settlements_threshold, max_turn_threshold, mission_rewards
	start_early_game_eliminate_faction_mission_listener(
		-- If our people are to thrive, we will need a solid foundation. We must gain control over this entire territory and fortify it. The monsters of this land will learn not to cross our borders. 
		"wh2.camp.vortex.advice.early_game.eliminate_faction.010",
		nil,
		"wh2_dlc14_brt_repanse_early_game_eliminate_faction",
		"CHRISTOPH",
		"wh2_main_vmp_strygos_empire",
		1,
		25,
		{
			"money 500"
		}
	);
	
	core:add_listener(
		"spawn_horde_post_strygos",
		"MissionSucceeded",
		function(context)
			return context:mission():mission_record_key() == "wh2_dlc14_brt_repanse_early_game_eliminate_faction";
		end,
		function()
			core:trigger_event("SpawnHorde","wh2_main_bst_blooded_axe");
		end,
		true
	);

	
	-- growth point mission
	-- this is a mission for the player to upgrade their settlement (again)
	-- this triggers once the player receives their first growth point in a region with the supplied building, informs the player about growth points, and tasks them to upgrade their settlement further
	-- advice_key, infotext, mission_key, region_key, required_building_key, upgrade_building_key, mission_rewards
	start_early_game_growth_point_mission_listener(
		-- The population of your province grows, mighty Lord. See that the expansion continues, so that you may further develop your realm.
		"wh2.camp.vortex.advice.early_game.growth.001",
		nil,
		"wh2_dlc14_brt_repanse_early_game_upgrade_settlement_part_two",
		"CHRISTOPH",
		"wh2_main_vor_coast_of_araby_al_haikk",
		{
			"wh_main_brt_settlement_major_2_coast"
		},
		{
			"wh_main_brt_settlement_major_3_coast"
		},
		{
			"money 500"
		}
	);
	
	
	-- hero building mission
	-- triggers if the player completes one of the supplied trigger buildings
	-- issues the supplied advice, and a mission to construct one of the target buildings
	-- optional turn delay introduces a turn countdown delay between the completion of the building and the issuing of the mission
	-- advice_key, infotext, mission_key, trigger_building_list, turn_delay, target_building_list, mission_rewards
	start_early_game_hero_building_mission_listener(
		-- The wars to come will be fought using guile as well as brawn. Consider expanding your facilities to permit the recruitment of Heroes, my Lord. Heroes can be hired to support your forces, or to strike against the enemy.
		"wh2.camp.vortex.advice.early_game.hero_buildings.001",
		nil,
		"wh2_dlc14_brt_repanse_early_game_hero_building_mission",
		"CHRISTOPH",
		{		
			"wh_main_brt_outpostnorsca_major_3",
			"wh_main_brt_outpostnorsca_major_3_coast",
			"wh_main_brt_outpostnorsca_minor_3",
			"wh_main_brt_outpostnorsca_minor_3_coast",
			"wh_main_brt_settlement_major_3",
			"wh_main_brt_settlement_major_3_coast",
			"wh_main_brt_settlement_minor_3",
			"wh_main_brt_settlement_minor_3_coast",
			"wh2_main_special_settlement_hexoatl_brt_3",
			"wh2_main_special_settlement_gaean_vale_brt_3",
			"wh2_dlc09_special_settlement_pyramid_of_nagash_brt_3",
			"wh2_main_special_settlement_itza_brt_3",
			"wh2_main_special_settlement_khemri_brt_3",
			"wh2_main_special_settlement_lahmia_brt_3",
			"wh2_main_special_settlement_lothern_brt_3",
			"wh2_main_special_settlement_naggarond_brt_3",
			"wh2_main_special_settlement_sartosa_brt_3",
			"wh2_main_special_settlement_the_awakening_brt_3"
		},
		1,
		{
			"wh_main_brt_stables_2",
			"wh_main_brt_worship_2"
		},
		{
			"money 500"
			
		}
	);
	
	
	-- hero recruitment mission
	-- triggers if the player completes one of the supplied trigger buildings
	-- issues the supplied advice, and a mission to recruit a hero
	-- advice_key, infotext, mission_key, mission_rewards
	start_early_game_hero_recruitment_mission_listener(
		-- Facilities are now in place to recruit a Hero, my Lord. Such operatives may move behind enemy lines and strike independently of your armies.
		"wh2.camp.vortex.advice.early_game.recruit_hero.001",
		nil,
		"wh2_dlc14_brt_repanse_early_game_hero_recruitment_mission",
		"CHRISTOPH",
		{
			"money 500"
		}
	);
	
	
	-- hero action mission
	-- triggers when the player gains their first hero
	-- issues the supplied advice, and a mission to use a hero action
	-- advice_key, infotext, mission_key, mission_rewards
	start_early_game_hero_action_mission_listener(
		-- A hero has enrolled in your service, my Lord. Be sure to put them to work - their unique skills may solve problems that no amount of money or effort would otherwise be able to crack.
		"wh2.camp.vortex.advice.early_game.hero_actions.001",
		nil,
		"wh2_dlc14_brt_repanse_early_game_hero_action_mission",
		"CHRISTOPH",
		{
			"money 500"
		}
	);
	
	
	-- raise army mission
	-- triggers when the player is at war with two armies, is outnumbered and can afford a second army
	-- advice_key, infotext, mission_key, mission_rewards
	start_early_game_raise_army_mission_listener(
		-- Your war efforts would be strengthened by the raising of a new army. Appoint another command, and you can open a second front against your foes.
		"war.camp.advice.raise_forces.001",
		nil,
		"wh2_dlc14_brt_repanse_early_game_raise_army_mission",
		"CHRISTOPH",
		{
			"money 500"
		}
	);

end;