--[[--- WORLDROOTS ----]]--

local wef_subc = "wh_dlc05_sc_wef_wood_elves";
local cooldown = 10;
--------------
----VARIABLES--
--------------
Worldroots = {
	primary_player_key = "",
	secondary_player_key = false, 
	playable_wood_elf_factions = {"wh_dlc05_wef_wood_elves", "wh_dlc05_wef_argwylon","wh2_dlc16_wef_drycha","wh2_dlc16_wef_sisters_of_twilight"},

	---POOLED RESOURCE VALUES
	---adjacent regions--
	pacified_value = 1,
	hostile_value = -1,
	razing_value = 5, -- needs to match dummy display in db
	razing_tech_bonus = 5, -- needs to match dummy display in db
	battle_value = 2,
	battle_value_tech_bonus = 1, -- needs to match dummy display in db
	battle_value_skill_bonus = 1, -- for Sisters skill. needs to match dummy display in db
	battle_value_skill_key = "wh2_dlc16_wef_sisters_unique_3",
	---corruption
	corruption_threshold = 0.5,
	corruption_penalty = -1,
	--rites completed
	rite_completed_value = 100,
	---special buidlings
	worldroots_building_value = 1, -- needs to match with value in the db
	---technology value
	technology_value = 1,  -- needs to match dummy display in db
	--markers
	unresolved_marker_value = -1,
	peaceful_resolution_value = 10, ---needs to match dummy display in db
	battle_resolution_value = 10, --needs to match dummy display in db
	

	---CAMPAIGN VARIABLES
	primary_forest = "athel_loren", --- used in various places e.g. to define central glade for vfx
	primary_forest_vortex = "witchwood",
	deeproots_unlock_turn = 10, -- turn teleportation unlocks
	marker_cooldown = 5, --- cooldown between markers. note this will tick twice as fast in MP
	turns_since_last_marker = 5,
	debug_ignore_marker_cooldown = false, -- set to true to cause a marker to spawn every turn, ignorning first-turn restrictions
	avelorn_invasion_turn = 45,
	avelorn_invasion_duration = 5, --- after this many turns the game will release control of the spawned Avelorn invasion and re-allow CAI targeting of the ruins
	debug_ariel_unlock = false, -- set to true to spawn Ariel/Coeddil on turn 1 for easy testing
	ariel_unlocked = false,
	coeddil_unlocked = false,
	ai_ariel_spawn_turn = 20, --- turn after which ariel can appear for either the Sisters or Orion
	ai_ariel_spawn_chance = 50,  --- chance on each turn that ariel will spawn (chance is per faction, with Sisters prioritised)
	ritual_resource_required_default = 100, -- standard amount of pooled resource required to trigger the Ritual of Rebirth. Used to check if we should fire an incident saying it's ready.


	--INVASION VARIABLES
	invasion_power_modifier = 1, -- modfier for calculating composition of spawned armies. will update as campaign goes on.
	invasion_force_strength = 20, --- how big the forces that spawn are
	invasion_force_interruption_modifiers =  {["invasion_marker_3"]= -10,["invasion_marker_2"] = -5,["invasion_marker_1"] = -3}, --- modifier to army size if invasion interrupted before spawning
	invasion_force_effect_bundle = "wh2_dlc16_bundle_military_upkeep_free_force_immune_to_regionless_attrition", --- effect bundle to apply to spawned forces
	invasion_force_interrupted_effect_bundle  = "wh2_dlc16_bundle_scripted_wood_elf_encounter", -- effect bundle to apply to interrupted invasion spawns

	---VFX VARIABLES
	ritual_vfx_key = "wh2_dlc16_wef_healing_ritual",
	teleport_vfx_key = "wh2_dlc16_wef_worldroots_teleport",
	ritual_finished_vfx_key = "wh2_dlc16_wef_worldroots_teleport",
	worldroots_vfx_beam_key = "campaign_worldroots_beam", -- composite scene used to construct the beams between settlements.  points to db entry in campaign_composite_scenes
	worldroots_vfx_beam_length = 90, -- assumed length of beam. Used to calculate how many composite scenes required to connect two regions.
	worldroots_vfx_beam_end_key = "campaign_worldroots_beam_end", -- composite scene to display on settlements at end of beam. points to db entry in campaign_composite_scenes
	worldroot_vfx_cooldown = 4, 
	worldroot_vfx_active = false
	}


---------------------
-----FORESTS DATA------
----------------------
---we use ME data as the baseline, then override specific bits if we're in vortex
Worldroots.forests = {
	["athel_loren"] = {
		key = "athel_loren",
		pooled_resource = "wef_worldroots_athel_loren",
		glade_region_key = "wh_main_yn_edri_eternos_the_oak_of_ages",
		additional_regions = { --- optional -  if we have extra regions we want to check for the presence of buildings etc.
			"wh_main_athel_loren_crag_halls",
			"wh_main_athel_loren_yn_edryl_korian",
			"wh_main_athel_loren_vauls_anvil",
			"wh_main_athel_loren_waterfall_palace",
		},
		rite_key = "wh2_dlc16_ritual_rebirth_athel_loren",
		invasion_faction = "wh2_dlc13_bst_beastmen_invasion",
		invasion_force_key  = "athel_loren_beastmen_invasion",
		invasion_spawn_coords = {{461,320},{423,325},{427,395},{522,326}},
		rite_completed = false,
		rite_active = false,
		locked_building = "wh_dlc05_wef_oak_of_ages_5",
		adjacent_regions_override = { 
			"wh_main_southern_grey_mountains_karak_azgaraz",
			"wh_main_southern_grey_mountains_karak_norn",
			"wh_main_southern_grey_mountains_grimhold",
			"wh_main_the_vaults_karak_bhufdar",
			"wh_main_carcassone_et_brionne_castle_carcassonne",
			"wh_main_parravon_et_quenelles_parravon",
			"wh_main_parravon_et_quenelles_quenelles",
		},
		custom_ritual_completion_callback =				 ---- optional
			function()
				cm:trigger_mission(Worldroots.primary_player_key, "wh_dlc05_qb_wef_grand_defense_of_the_oak" , true, true)
			end,
		unresolved_markers = 0,
		ritual_resource_required_override = 500
	},


	["laurelorn"] = {
		key = "laurelorn",
		pooled_resource = "wef_worldroots_laurelorn",
		glade_region_key = "wh2_main_laurelorn_forest_laurelorn_forest",
		rite_key = "wh2_dlc16_ritual_rebirth_laurelorn",
		invasion_faction = "wh2_dlc13_nor_norsca_invasion",
		invasion_force_key = "laurelorn_norscan_invasion",
		invasion_spawn_coords = {{460,559},{484,562},{538,574}},
		locked_building = "wh2_main_special_salzenmund_laurelorn_wef_1",
		rite_completed = false,
		rite_active = false,
		adjacent_regions_override = { 
			"wh2_main_misty_hills_the_black_pit",
			"wh2_main_misty_hills_wreckers_point",
			"wh_main_middenland_middenheim",
			"wh_main_nordland_dietershafen",
			"wh_main_nordland_salzenmund"
		},
		unresolved_markers = 0
	},
	["gaean_vale"] = {
		key = "gaean_vale",
		pooled_resource = "wef_worldroots_gaean_vale",
		glade_region_key = "wh2_main_avelorn_gaean_vale",
		rite_key = "wh2_dlc16_ritual_rebirth_gaean_vale",
		invasion_faction = "wh2_dlc16_chs_acolytes_of_the_keeper",
		invasion_force_key = "gaean_vale_chaos_invasion",
		invasion_spawn_coords = {{208,409},{175,349},{261,350}}, 
		locked_building = "wh2_main_special_everqueen_court_wef",
		rite_completed = false,
		rite_active = false,
		adjacent_regions_override = { 
			"wh2_main_avelorn_tor_saroir",
			"wh2_main_avelorn_evershale",
			"wh2_main_phoenix_gate",
			"wh2_main_unicorn_gate"
		},
		unresolved_markers = 0
	},

	["heart_of_the_jungle"] = {
		key = "heart_of_the_jungle",
		pooled_resource = "wef_worldroots_heart_of_the_jungle", 
		glade_region_key = "wh2_main_heart_of_the_jungle_oreons_camp",
		rite_key = "wh2_dlc16_ritual_rebirth_heart_of_the_jungle", 
		invasion_faction = "wh2_dlc16_grn_savage_invasion",
		invasion_force_key = "heart_of_the_jungle_greenskins_invasion",
		invasion_spawn_coords = {{674,9},{686,33},{725,39}}, 
		locked_building = "wh_dlc05_wef_temple_kurnous_1",
		rite_completed = false,
		rite_active = false,
		adjacent_regions_override = {
			"wh2_main_southlands_worlds_edge_mountains_karak_zorn",
			"wh2_main_shifting_sands_ka-sabar",
			"wh2_main_shifting_sands_antoch",
			"wh2_main_southlands_worlds_edge_mountains_lost_plateau"
		},
		unresolved_markers = 0
	},
	
	["gryphon_wood"] = {
		key = "gryphon_wood",
		pooled_resource = "wef_worldroots_gryphon_wood",
		glade_region_key = "wh2_main_old_world_glade",
		rite_key = "wh2_dlc16_ritual_rebirth_gryphon_wood",
		invasion_faction = "wh2_dlc16_wef_drycha",
		invasion_faction_alternate = "wh2_dlc16_emp_empire_invasion",
		invasion_force_key = "gryphon_wood_invasion",
		invasion_spawn_coords = {{665,508},{615,474},{677,468}},
		locked_building = "wh_dlc05_wef_temple_ereth_khial_1",
		rite_completed = false,
		rite_active = false,
		adjacent_regions_override = { 
			"wh_main_ostermark_mordheim",
			"wh_main_ostermark_bechafen",
			"wh_main_ostermark_essen",
			"wh_main_ostermark_nagenhof",
			"wh_main_talabecland_kappelburg",
			"wh_main_talabecland_krugenheim",		
		},
		unresolved_markers = 0
	},


	["forest_of_gloom"] = {
		key = "forest_of_gloom",
		pooled_resource = "wef_worldroots_vale_of_webs",
		glade_region_key = "wh2_main_badlands_glade",
		rite_key = "wh2_dlc16_ritual_rebirth_vale_of_webs",
		invasion_faction = "wh2_dlc13_grn_greenskins_invasion",
		invasion_force_key = "vale_of_webs_forest_goblin_invasion",
		invasion_spawn_coords = {{692,341},{666,347},{644,361}},
		locked_building = "wh2_dlc16_special_forest_of_gloom_shadow_groves_of_loec",
		rite_completed = false,
		rite_active = false,
		adjacent_regions_override = { 
			"wh_main_zhufbar_oakenhammer",
			"wh_main_zhufbar_karag_dromar",
			"wh_main_eastern_border_princes_akendorf",
			"wh_main_blood_river_valley_varenka_hills",
			"wh_main_the_silver_road_karaz_a_karak"
		},
		unresolved_markers = 0
	},

	["witchwood"] = {
		key = "witchwood",
		pooled_resource = "wef_worldroots_naggarond_glade",
		glade_region_key = "wh2_main_naggaroth_glade",
		rite_key = "wh2_dlc16_ritual_rebirth_naggarond_glade",
		invasion_faction = "wh2_main_skv_clan_moulder",
		invasion_faction_alternate = "wh2_dlc13_skv_skaven_invasion",
		invasion_force_key = "naggaroth_glade_skaven_invasion",
		invasion_spawn_coords = {{52,487},{59,462},{13,459}},
		locked_building = "wh_dlc05_wef_temple_anath_raema_1",
		rite_completed = false,
		rite_active = false,
		adjacent_regions_override = { 
			"wh2_main_doom_glades_ice_rock_gorge",
			"wh2_main_doom_glades_vauls_anvil",
			"wh2_main_doom_glades_hag_hall",
			"wh2_main_doom_glades_temple_of_addaioth",
			"wh2_main_blackspine_mountains_plain_of_spiders"
		},
		unresolved_markers = 0,
		ritual_resource_required_override = 300
	},

	["emerald_pools"] = {
		key = "emerald_pools",
		pooled_resource = "wef_worldroots_emerald_pools",
		glade_region_key = "wh2_main_lustria_glade",
		rite_key = "wh2_dlc16_ritual_rebirth_emerald_pools",
		invasion_faction = "wh2_dlc16_emp_colonist_invasion",
		invasion_force_key = "emerald_pools_colonists_invasion",
		invasion_spawn_coords = {{132,68},{151,86},{127,91}},
		locked_building = "wh2_dlc16_special_sacred_pools_wef",
		rite_completed = false,
		rite_active = false,
		adjacent_regions_override = { 
			"wh2_main_northern_great_jungle_chaqua",
			"wh2_main_northern_great_jungle_xlanhuapec",
			"wh2_main_southern_great_jungle_itza",
			"wh2_main_southern_great_jungle_axlotl",
		},
		unresolved_markers = 0
	},
}

--- overrides the specified variables in the main table with new ones. Variables not mentioned will remain the same.
--- if a forest is in the main table but NOT in this one it will be removed.
Worldroots.vortex_forest_overrides = {
	["gaean_vale"] = {
		glade_region_key = "wh2_main_vor_avelorn_gaean_vale",
		invasion_spawn_coords = {{453,565},{502,597},{591,549}}, 
		adjacent_regions_override = {
			"wh2_main_vor_avelorn_tor_saroir",
			"wh2_main_vor_avelorn_evershale",
			"wh2_main_vor_phoenix_gate",
			"wh2_main_vor_unicorn_gate",
			"wh2_main_vor_ellyrion_reavers_mark"
		},
	},

	["heart_of_the_jungle"] = {
		glade_region_key = "wh2_main_vor_heart_of_the_jungle_oreons_camp",
		invasion_spawn_coords = {{579,143},{550,155},{551,188}}, 
		adjacent_regions_override = {
			"wh2_main_vor_shifting_sands_ka-sabar",
			"wh2_main_vor_southlands_world_edge_mountains_karak_zorn",
			"wh2_main_vor_shifting_sands_antoch",
			"wh2_main_vor_the_red_rivers_cuexotl",
			"wh2_main_vor_the_red_rivers_sun-tree_glades",
			"wh2_main_vor_the_red_rivers_golden_tower_of_the_gods"
		},
		
	},

	["emerald_pools"] = {
		glade_region_key = "wh2_main_vor_lustria_glade",
		invasion_spawn_coords = {{182,268},{173,301},{205,304}}, 
		adjacent_regions_override = {
			"wh2_main_vor_mosquito_swamps_xahutec",
			"wh2_main_vor_mosquito_swamps_tlax",
			"wh2_main_vor_mosquito_swamps_xlanhuapec",
			"wh2_main_vor_the_creeping_jungle_tlaxtlan",
			"wh2_main_vor_scorpion_coast_chotec",
			"wh2_main_vor_scorpion_coast_temple_of_tlencan"
		},
	},

	["witchwood"] = {
		glade_region_key = "wh2_main_vor_naggaroth_glade",
		invasion_spawn_coords = {{142,578},{108,577},{113,538},{125,538}},
		adjacent_regions_override = {
			"wh2_main_vor_obsidian_peaks_temple_of_addaioth",
			"wh2_main_vor_obsidian_peaks_ice_spire",
			"wh2_main_vor_ashen_coast_tyrant_peak",
			"wh2_main_vor_iron_peaks_ancient_city_of_quintex",
		},
		pooled_resource = "wef_worldroots_naggarond_glade_vortex",
		rite_key = "wh2_dlc16_ritual_rebirth_naggarond_glade_vortex",
	},
}

Worldroots.completed_encounters = {}
Worldroots.encounters = {
	["kings_glade_beastmen_invaders_intro"] = 
		{spawn_turn = 1,
		forest = "athel_loren",
		spawn_incident = "wh2_dlc16_incident_wef_beastmen_threaten_kings_glade",
		faction_filter = "wh_dlc05_wef_wood_elves",
		region = "wh_main_athel_loren_yn_edryl_korian",
		setup =
		function() 
			local glade_owner = cm:get_region("wh_main_athel_loren_yn_edryl_korian"):owning_faction():name()
			local countdown_markers = Interactive_Marker_Manager:create_countdown("kings_glade_beastmen_invaders_intro","ScriptEventWEFIntroMarkerBattleTriggered","ScriptEventWEFEncounterMarkerExpired",{"invasion_marker_3","invasion_marker_2","invasion_marker_1"},Worldroots.primary_player_key)
			countdown_markers[1]:add_spawn_event_feed_event("event_feed_strings_text_wh2_dlc16_event_feed_string_scripted_event_forest_encounter_title",
			"incidents_localised_title_wh2_dlc16_incident_wef_beastmen_threaten_kings_glade",
			"incidents_localised_description_wh2_dlc16_incident_wef_beastmen_threaten_kings_glade",
			555,
			glade_owner)
			countdown_markers[1]:spawn_at_location(496,328)
			countdown_markers[3]:add_spawn_event_feed_event(
			"event_feed_strings_text_wh2_dlc16_event_feed_string_scripted_event_invasion_title",
			"event_feed_strings_text_wh2_dlc16_event_feed_string_scripted_event_invasion_imminent_primary_detail",
			"event_feed_strings_text_wh2_dlc16_event_feed_string_scripted_event_invasion_imminent_secondary_detail", 
			555,
			glade_owner)
			countdown_markers[3]:add_despawn_event_feed_event(
			"event_feed_strings_text_wh2_dlc16_event_feed_string_scripted_event_invasion_title",
			"event_feed_strings_text_wh2_dlc16_event_feed_string_scripted_event_invasion_spawned_primary_detail",
			"event_feed_strings_text_wh2_dlc16_event_feed_string_scripted_event_invasion_spawned_secondary_detail", 
			555,
			glade_owner)
		end,
		on_battle_trigger_callback =
		function(self, character, marker_info) 
			Worldroots:set_up_generic_encounter_forced_battle(character, "wh2_dlc13_bst_beastmen_invasion", "wh_dlc03_sc_bst_beastmen", true,10 + cm:turn_number(),"dlc03_bst_beastlord" )		
		end,
		on_expiry_callback = 
		function(self, marker_info) 
			local athel_loren = Worldroots:get_forest_by_string("athel_loren")
			local instance_ref = marker_info.instance_ref
			local x,y = Interactive_Marker_Manager:get_coords_from_instance_ref(instance_ref)
			Worldroots:trigger_invasion(athel_loren, x, y, 16)
		end
	},

	["argwylon_dwarf_invaders_intro"] = 
		{spawn_turn = 1,
		forest = "athel_loren",
		spawn_incident = "wh2_dlc16_incident_wef_dwarfs_threaten_waterfall_palace",
		faction_filter = "wh_dlc05_wef_argwylon",
		region = "wh_main_athel_loren_waterfall_palace",
		setup = 
		function() 
			local glade_owner = cm:get_region("wh_main_athel_loren_waterfall_palace"):owning_faction():name()
			local countdown_markers = Interactive_Marker_Manager:create_countdown("argwylon_dwarf_invaders_intro","ScriptEventWEFIntroMarkerBattleTriggered","ScriptEventWEFEncounterMarkerExpired",{"invasion_marker_3","invasion_marker_2","invasion_marker_1"},Worldroots.primary_player_key)
			countdown_markers[1]:add_spawn_event_feed_event("event_feed_strings_text_wh2_dlc16_event_feed_string_scripted_event_forest_encounter_title",
			"incidents_localised_title_wh2_dlc16_incident_wef_dwarfs_threaten_waterfall_palace",
			"incidents_localised_description_wh2_dlc16_incident_wef_dwarfs_threaten_waterfall_palace",
			555,
			glade_owner)
			countdown_markers[3]:add_spawn_event_feed_event(
			"event_feed_strings_text_wh2_dlc16_event_feed_string_scripted_event_invasion_title",
			"event_feed_strings_text_wh2_dlc16_event_feed_string_scripted_event_invasion_imminent_primary_detail",
			"event_feed_strings_text_wh2_dlc16_event_feed_string_scripted_event_invasion_imminent_secondary_detail", 
			555,
			glade_owner)
			countdown_markers[3]:add_despawn_event_feed_event(
			"event_feed_strings_text_wh2_dlc16_event_feed_string_scripted_event_invasion_title",
			"event_feed_strings_text_wh2_dlc16_event_feed_string_scripted_event_invasion_spawned_primary_detail",
			"event_feed_strings_text_wh2_dlc16_event_feed_string_scripted_event_invasion_spawned_secondary_detail", 
			555,
			glade_owner)
			countdown_markers[1]:spawn_at_location(461,379)
		end,
		on_battle_trigger_callback =
			function(self, character, marker_info)
				Worldroots:set_up_generic_encounter_forced_battle(character, "wh_main_dwf_karak_norn", "wh_main_sc_dwf_dwarfs", true, 8 + cm:turn_number())
			end,
		on_expiry_callback = 
			function(self, marker_info) 
				local athel_loren = Worldroots:get_forest_by_string("athel_loren")
				local instance_ref = marker_info.instance_ref
				local x,y = Interactive_Marker_Manager:get_coords_from_instance_ref(instance_ref)
				Worldroots:trigger_invasion(athel_loren, x, y, 14, "wh_main_dwf_karak_norn", "wh_main_sc_dwf_dwarfs")
			end
	},

	

	["sisters_skaven_invaders_intro_me"] = 
		{spawn_turn = 6,
		forest = "witchwood",
		spawn_incident = "wh2_dlc16_incident_wef_sisters_intro_invasion",
		faction_filter = "wh2_dlc16_wef_sisters_of_twilight",
		region = "wh2_main_naggaroth_glade",
		setup =
		function() 
			local glade_owner = cm:get_region("wh2_main_naggaroth_glade"):owning_faction():name()
			local countdown_markers = Interactive_Marker_Manager:create_countdown("sisters_skaven_invaders_intro_me","ScriptEventWEFIntroMarkerBattleTriggered","ScriptEventWEFEncounterMarkerExpired",{"invasion_marker_3","invasion_marker_2","invasion_marker_1"},Worldroots.primary_player_key)
			countdown_markers[1]:add_spawn_event_feed_event("event_feed_strings_text_wh2_dlc16_event_feed_string_scripted_event_forest_encounter_title",
			"incidents_localised_title_wh2_dlc16_incident_wef_sisters_intro_invasion",
			"incidents_localised_description_wh2_dlc16_incident_wef_sisters_intro_invasion",
			555,
			glade_owner)
			countdown_markers[3]:add_spawn_event_feed_event(
			"event_feed_strings_text_wh2_dlc16_event_feed_string_scripted_event_invasion_title",
			"event_feed_strings_text_wh2_dlc16_event_feed_string_scripted_event_invasion_imminent_primary_detail",
			"event_feed_strings_text_wh2_dlc16_event_feed_string_scripted_event_invasion_imminent_secondary_detail", 
			555,
			glade_owner)
			countdown_markers[3]:add_despawn_event_feed_event(
			"event_feed_strings_text_wh2_dlc16_event_feed_string_scripted_event_invasion_title",
			"event_feed_strings_text_wh2_dlc16_event_feed_string_scripted_event_invasion_spawned_primary_detail",
			"event_feed_strings_text_wh2_dlc16_event_feed_string_scripted_event_invasion_spawned_secondary_detail", 
			555,
			glade_owner)
			countdown_markers[1]:spawn_at_location(66,457)
		end,
		on_battle_trigger_callback =
		function(self, character, marker_info) 
			Worldroots:set_up_generic_encounter_forced_battle(character, "wh2_dlc13_skv_skaven_invasion", "wh2_main_sc_skv_skaven", true, 8 + cm:turn_number(),"wh2_main_skv_grey_seer_plague")		
		end,
		on_expiry_callback = 
		function(self, marker_info) 
			local naggaroth_glade = Worldroots:get_forest_by_string("witchwood")
			local instance_ref = marker_info.instance_ref
			local x,y = Interactive_Marker_Manager:get_coords_from_instance_ref(instance_ref)
			Worldroots:trigger_invasion(naggaroth_glade, x, y, 16)
		end
	},

	
	["drycha_human_invaders_intro"] = 
		{spawn_turn = 2,
		forest = "gryphon_wood",
		spawn_incident = "wh2_dlc16_incident_wef_drycha_intro_invasion",
		faction_filter = "wh2_dlc16_wef_drycha",
		region = "wh2_main_old_world_glade",
		setup = 
		function()
			local glade_owner = cm:get_region("wh2_main_old_world_glade"):owning_faction():name()
			local countdown_markers = Interactive_Marker_Manager:create_countdown("drycha_human_invaders_intro","ScriptEventWEFIntroMarkerBattleTriggered","ScriptEventWEFEncounterMarkerExpired",{"invasion_marker_3","invasion_marker_2","invasion_marker_1"},Worldroots.primary_player_key)
			countdown_markers[1]:add_spawn_event_feed_event("event_feed_strings_text_wh2_dlc16_event_feed_string_scripted_event_forest_encounter_title",
			"incidents_localised_title_wh2_dlc16_incident_wef_drycha_intro_invasion",
			"incidents_localised_description_wh2_dlc16_incident_wef_drycha_intro_invasion",
			555,
			glade_owner)
			countdown_markers[3]:add_spawn_event_feed_event(
			"event_feed_strings_text_wh2_dlc16_event_feed_string_scripted_event_invasion_title",
			"event_feed_strings_text_wh2_dlc16_event_feed_string_scripted_event_invasion_imminent_primary_detail",
			"event_feed_strings_text_wh2_dlc16_event_feed_string_scripted_event_invasion_imminent_secondary_detail", 
			555,
			glade_owner)
			countdown_markers[3]:add_despawn_event_feed_event(
			"event_feed_strings_text_wh2_dlc16_event_feed_string_scripted_event_invasion_title",
			"event_feed_strings_text_wh2_dlc16_event_feed_string_scripted_event_invasion_spawned_primary_detail",
			"event_feed_strings_text_wh2_dlc16_event_feed_string_scripted_event_invasion_spawned_secondary_detail", 
			555,
			glade_owner)
			countdown_markers[1]:spawn_at_location(625,491)
		end,
		on_battle_trigger_callback =
			function(self, character, marker_info)
				Worldroots:set_up_generic_encounter_forced_battle(character, "wh2_dlc16_emp_empire_invasion", "wh_main_sc_emp_empire", true, 6 + cm:turn_number())
			end,
		on_expiry_callback = 
			function(self, marker_info) 
				local gryphon_wood = Worldroots:get_forest_by_string("gryphon_wood")
				local instance_ref = marker_info.instance_ref
				local x,y = Interactive_Marker_Manager:get_coords_from_instance_ref(instance_ref)
				Worldroots:trigger_invasion(gryphon_wood, x, y, 14)
			end
	},

	["wydrioth_greenskin_invaders"] = 
		{spawn_turn = 8,
		forest = "athel_loren",
		spawn_incident = "wh2_dlc16_incident_wef_new_encounter_available",
		region = "wh_main_athel_loren_crag_halls",
		setup = 
			function()
				Worldroots:set_up_generic_encounter_marker("wydrioth_greenskin_invaders", "wh2_dlc16_dilemma_wef_encounter_athel_loren_greenskins", 496, 364,"athel_loren")
			end,
		on_battle_trigger_callback =
			function(self, character, marker_info)
				Worldroots:set_up_generic_encounter_forced_battle(character, "wh2_dlc13_grn_greenskins_invasion", "wh_main_sc_grn_greenskins", true)
			end,
	},

	["torgovann_bretonnian_invaders"] = 
		{spawn_turn = 8,
		forest = "athel_loren",
		spawn_incident = "wh2_dlc16_incident_wef_new_encounter_available",
		region = "wh_main_athel_loren_vauls_anvil",
		setup = 
		function()
			Worldroots:set_up_generic_encounter_marker("torgovann_bretonnian_invaders", "wh2_dlc16_dilemma_wef_encounter_athel_loren_bretonnians", 472, 345,"athel_loren")
		end,
		on_battle_trigger_callback =
		function(self, character, marker_info) 
			Worldroots:set_up_generic_encounter_forced_battle(character, "wh_main_brt_bretonnia_qb1", "wh_main_sc_brt_bretonnia", true)
		end,
	},

	["argwylon_dwarf_invaders"] = 
		{spawn_turn = 12,
		forest = "athel_loren",
		spawn_incident = "wh2_dlc16_incident_wef_new_encounter_available",
		region = "wh_main_athel_loren_waterfall_palace",
		setup = 
		function()
			Worldroots:set_up_generic_encounter_marker("argwylon_dwarf_invaders", "wh2_dlc16_dilemma_wef_encounter_athel_loren_dwarfs", 473, 380,"athel_loren")
		end,
		on_battle_trigger_callback =
		function(self, character, marker_info) 
			Worldroots:set_up_generic_encounter_forced_battle(character, "wh_main_dwf_dwarfs_qb1", "wh_main_sc_dwf_dwarfs", false)
		end,
	},

	["talsyn_tree_spirit_invaders"] = 
		{spawn_turn = 12,
		forest = "athel_loren",
		spawn_incident = "wh2_dlc16_incident_wef_new_encounter_available",
		region = "wh_main_athel_loren_yn_edryl_korian",
		setup = 
		function()
			Worldroots:set_up_generic_encounter_marker("talsyn_tree_spirit_invaders", "wh2_dlc16_dilemma_wef_encounter_athel_loren_tree_spirits", 492, 337,"athel_loren")
		end,
		on_battle_trigger_callback =
		function(self, character, marker_info) 
			Worldroots:set_up_generic_encounter_forced_battle(character, "wh_dlc05_wef_wood_elves_qb2", "wef_forest_spirits", false, nil, "dlc05_wef_ancient_treeman")
		end,
	},
	["laurelorn_empire_invaders"] = 
		{spawn_turn = 12,
		forest = "laurelorn",
		spawn_incident = "wh2_dlc16_incident_wef_new_encounter_available",
		region = "wh2_main_laurelorn_forest_laurelorn_forest",
		setup = 
			function() 
				Worldroots:set_up_generic_encounter_marker("laurelorn_empire_invaders", "wh2_dlc16_dilemma_wef_encounter_laurelorn_empire", 511, 531, "laurelorn")
			end,
		on_battle_trigger_callback =
			function(self, character, marker_info)
				Worldroots:set_up_generic_encounter_forced_battle(character, "wh_main_emp_empire_qb1", "wh_main_sc_emp_empire", false)
			end		
	},
	["heart_of_the_jungle_tomb_king_invaders_me"] = 
		{spawn_turn = 12,
		forest = "heart_of_the_jungle",
		spawn_incident = "wh2_dlc16_incident_wef_new_encounter_available",
		region = "wh2_main_heart_of_the_jungle_oreons_camp",
		setup = 
			function() 
				Worldroots:set_up_generic_encounter_marker("heart_of_the_jungle_tomb_king_invaders_me", "wh2_dlc16_dilemma_wef_encounter_heart_of_the_jungle_tomb_kings", 690, 27, "heart_of_the_jungle")
			end,
		on_battle_trigger_callback =
			function(self, character, marker_info)
				Worldroots:set_up_generic_encounter_forced_battle(character, "wh2_dlc09_tmb_tombking_qb1", "wh2_dlc09_sc_tmb_tomb_kings", false)
			end		
	},

	["gaean_vale_high_elf_invaders_me"] = 
		{spawn_turn = 12,
		forest = "gaean_vale",
		spawn_incident = "wh2_dlc16_incident_wef_new_encounter_available",
		custom_condition = 
			function()
				return not cm:get_faction("wh2_main_hef_avelorn"):is_dead()
			end,
		region = "wh2_main_avelorn_gaean_vale",
		setup = 
			function() 
				Worldroots:set_up_generic_encounter_marker("gaean_vale_high_elf_invaders_me", "wh2_dlc16_dilemma_wef_encounter_gaean_vale_high_elves", 252, 366, "gaean_vale")
			end,
		on_battle_trigger_callback =
			function(self, character, marker_info)
				Worldroots:set_up_generic_encounter_forced_battle(character, "wh2_main_hef_high_elves_qb1", "wh2_main_sc_hef_high_elves", false)
			end,
		second_option_callback = 
			function(self, character, marker_info)
				local faction_to_gain = "wh2_main_hef_avelorn"
				if cm:get_faction("wh2_main_hef_avelorn"):is_dead() then
					faction_to_gain = "wh2_main_hef_eataine"
				end
				cm:transfer_region_to_faction("wh2_main_avelorn_gaean_vale", faction_to_gain)
			end,
	},

	["naggaroth_glade_dark_elf_invaders_me"] = 
		{spawn_turn = 12,
		forest = "witchwood",
		spawn_incident = "wh2_dlc16_incident_wef_new_encounter_available",
		region = "wh2_main_naggaroth_glade",
		setup = 
			function() 
				Worldroots:set_up_generic_encounter_marker("naggaroth_glade_dark_elf_invaders_me", "wh2_dlc16_dilemma_wef_encounter_naggarond_dark_elves", 61, 451, "witchwood")
			end,
		on_battle_trigger_callback =
			function(self, character, marker_info)
				Worldroots:set_up_generic_encounter_forced_battle(character, "wh2_main_def_dark_elves_qb1", "wh2_main_sc_def_dark_elves", false, nil, "wh2_dlc10_def_supreme_sorceress_dark")
			end,
	},

	["gryphon_wood_vampire_invaders"] = 
		{spawn_turn = 8,
		forest = "gryphon_wood",
		spawn_incident = "wh2_dlc16_incident_wef_new_encounter_available",
		region = "wh2_main_old_world_glade",
		setup = 
			function() 
				Worldroots:set_up_generic_encounter_marker("gryphon_wood_vampire_invaders", "wh2_dlc16_dilemma_wef_encounter_gryphon_wood_vampires", 656, 499, "gryphon_wood")
			end,
		on_battle_trigger_callback =
			function(self, character, marker_info)
				Worldroots:set_up_generic_encounter_forced_battle(character, "wh_main_vmp_vampire_counts_qb1", "vmp_ghoul_horde", false, nil, "dlc04_vmp_strigoi_ghoul_king")
			end,
	},

	["emerald_pools_lizardmen_invaders_me"] = 
		{spawn_turn = 12,
		forest = "emerald_pools",
		spawn_incident = "wh2_dlc16_incident_wef_new_encounter_available",
		region = "wh2_main_lustria_glade",
		setup = 
			function() 
				Worldroots:set_up_generic_encounter_marker("emerald_pools_lizardmen_invaders_me", "wh2_dlc16_dilemma_wef_encounter_lustria_lizardmen", 130, 64, "emerald_pools")
			end,
		on_battle_trigger_callback =
			function(self, character, marker_info)
				Worldroots:set_up_generic_encounter_forced_battle(character, "wh2_main_lzd_lizardmen_qb1", "wh2_main_sc_lzd_lizardmen", false)
			end,
	},

	["vale_of_webs_goblin_invaders"] = 
		{spawn_turn = 12,
		forest = "forest_of_gloom",
		spawn_incident = "wh2_dlc16_incident_wef_new_encounter_available",
		region = "wh2_main_badlands_glade",
		setup = 
			function() 
				Worldroots:set_up_generic_encounter_marker("vale_of_webs_goblin_invaders", "wh2_dlc16_dilemma_wef_encounter_vale_of_webs_spiders", 667, 350, "forest_of_gloom")
			end,
		on_battle_trigger_callback =
			function(self, character, marker_info)
				Worldroots:set_up_generic_encounter_forced_battle(character, "wh2_dlc13_grn_greenskins_invasion", "grn_spider_cult", false)
			end,
	},

	

	["laurelorn_norsca"] = 
	{
		spawn_turn = 15,
		spawn_incident = "wh2_dlc16_incident_wef_new_confed_encounter_available",
		region = "wh2_main_laurelorn_forest_laurelorn_forest",
		custom_condition = 
			function()
				return not cm:get_faction("wh2_dlc16_wef_drycha"):is_human()
			end,
		setup = 
			function() 
				Worldroots:set_up_generic_encounter_marker("laurelorn_norsca", "wh2_dlc16_dilemma_wef_encounter_laurelorn_norsca", 481, 533, "laurelorn")
				cm:make_region_seen_in_shroud(Worldroots.primary_player_key, "wh2_main_laurelorn_forest_laurelorn_forest")
				cm:make_region_seen_in_shroud(Worldroots.primary_player_key, "wh_main_nordland_dietershafen")
				cm:make_diplomacy_available(Worldroots.primary_player_key, "wh2_dlc13_wef_laurelorn_forest")
				
				cm:callback(
					function()
						if confed_missions:is_mission_valid_for_faction(Worldroots.primary_player_key, "wood_elves_laurelorn") then
							confed_missions:trigger_mission(Worldroots.primary_player_key, "wood_elves_laurelorn")
						end
					end,
				1)
				
			end,
		on_battle_trigger_callback =
			function(self, character, marker_info)
				Worldroots:set_up_generic_encounter_forced_battle(character, "wh2_dlc13_nor_norsca_invasion", "wh_main_sc_nor_norsca", false, 20, nil, 2)
				Worldroots.forests["laurelorn"].unresolved_markers = Worldroots.forests["laurelorn"].unresolved_markers - 1
			end,
		second_option_callback =
			function(self, character, marker_info)
				Worldroots:set_up_generic_encounter_forced_battle(character, "wh2_dlc13_nor_norsca_invasion", "nor_fimir", false, 10)
				Worldroots.forests["laurelorn"].unresolved_markers = Worldroots.forests["laurelorn"].unresolved_markers - 1
			end,
	},

	
	["special_the_blood_fane"] = 
	{
		spawn_turn = 1,
		spawn_incident = "wh2_dlc16_incident_wef_new_encounter_available",
		region = "wh2_main_old_world_glade",
		custom_condition = 
		function()
			return #Worldroots.completed_encounters > 7
		end,
		setup = 
			function() 
				Worldroots:set_up_generic_encounter_marker("special_the_blood_fane", "wh2_dlc16_dilemma_wef_encounter_special_the_blood_fane", 622, 533, false)
			end,
		second_option_callback =
			function(self, character, marker_info)
				Worldroots:set_up_generic_encounter_forced_battle(character, "wh2_dlc13_bst_beastmen_invasion", "wh_dlc03_sc_bst_beastmen", false, 20, nil, 5)
				Worldroots:add_pooled_resource_to_all_wood_elves(Worldroots.forests["athel_loren"], "wh2_dlc16_resource_factor_worldroots_healed", Worldroots.battle_resolution_value, character:faction():name(), true)
				Worldroots:add_pooled_resource_to_all_wood_elves(Worldroots.forests["laurelorn"], "wh2_dlc16_resource_factor_worldroots_healed", Worldroots.battle_resolution_value, character:faction():name(), true)
				Worldroots:add_pooled_resource_to_all_wood_elves(Worldroots.forests["gryphon_wood"], "wh2_dlc16_resource_factor_worldroots_healed", Worldroots.battle_resolution_value, character:faction():name(), true)
			end,
	},

	["witchwood_greenskins_v_druchii_me"] = 
	{
		spawn_turn = 15,
		forest = "witchwood",
		spawn_incident = "wh2_dlc16_incident_wef_new_encounter_available",
		region = "wh2_main_naggarond_glade",
		setup = 
			function() 
				Worldroots:set_up_generic_encounter_marker("witchwood_greenskins_v_druchii_me", "wh2_dlc16_dilemma_wef_encounter_witchwood_greenskins_v_druchii", 63, 493, "witchwood")
			end,
		on_battle_trigger_callback =
			function(self, character, marker_info)
				Worldroots:set_up_generic_encounter_forced_battle(character, "wh2_main_def_dark_elves_qb1", "wh2_main_sc_def_dark_elves", false, 18, "wh2_dlc14_def_high_beastmaster", 1)
			end,
		second_option_callback =
			function(self, character, marker_info)
				Worldroots:set_up_generic_encounter_forced_battle(character, "wh2_dlc13_grn_greenskins_invasion", "grn_greenskins_orcs_only", false, nil, "grn_orc_warboss")
			end,
	},

	["sacred_pools_pestilens_me"] = 
	{
		spawn_turn = 1,
		forest = "emerald_pools",
		spawn_incident = "wh2_dlc16_incident_wef_new_encounter_available",
		region = "wh2_main_lustria_glade",
		setup = 
			function() 
				Worldroots:set_up_generic_encounter_marker("sacred_pools_pestilens_me", "wh2_dlc16_dilemma_wef_encounter_sacred_pools_pestilens", 145, 62, "emerald_pools")
			end,
		on_battle_trigger_callback =
			function(self, character, marker_info)
				Worldroots:set_up_generic_encounter_forced_battle(character, "wh2_dlc13_skv_skaven_invasion", "skv_pestilens_and_rats", false, nil, "wh2_main_skv_grey_seer_plague")
			end,
		second_option_callback =
			function(self, character, marker_info)
				Worldroots:set_up_generic_encounter_forced_battle(character, "wh2_dlc13_skv_skaven_invasion", "skv_pestilens_and_rats", false, nil, "wh2_main_skv_grey_seer_plague")
			end,
	},

	["gaean_vale_druchii_vs_moulder_me"] = 
	{
		spawn_turn = 1,
		forest = "gaean_vale",
		spawn_incident = "wh2_dlc16_incident_wef_new_encounter_available",
		region = "wh2_main_avelorn_gaean_vale",
		setup = 
			function() 
				Worldroots:set_up_generic_encounter_marker("gaean_vale_druchii_vs_moulder_me", "wh2_dlc16_dilemma_wef_encounter_gaean_vale_druchii_v_moulder", 212, 429, "gaean_vale")
			end,
		on_battle_trigger_callback =
			function(self, character, marker_info)
				Worldroots:set_up_generic_encounter_forced_battle(character, "wh2_main_def_dark_elves_qb1", "def_corsairs", false, 18, "wh2_main_def_dreadlord", 1)
			end,
		second_option_callback =
			function(self, character, marker_info)
				Worldroots:set_up_generic_encounter_forced_battle(character, "wh2_dlc13_skv_skaven_invasion", "skv_moulder", false, 12, "wh2_main_skv_grey_seer_plague")
			end,
	},

	["heart_of_the_jungle_bowmen_v_dinosaurs_me"] = 
	{
		spawn_turn = 15,
		spawn_incident = "wh2_dlc16_incident_wef_new_confed_encounter_available",
		region = "wh2_main_heart_of_the_jungle_oreons_camp",
		custom_condition = 
			function()
				return not cm:get_faction("wh2_dlc16_wef_drycha"):is_human()
			end,
		setup = 
			function() 
				Worldroots:set_up_generic_encounter_marker("heart_of_the_jungle_bowmen_v_dinosaurs_me", "wh2_dlc16_dilemma_wef_encounter_heart_of_the_jungle_bowmen_v_dinosaurs", 690, 22, "heart_of_the_jungle")
				cm:make_region_seen_in_shroud(Worldroots.primary_player_key, "wh2_main_heart_of_the_jungle_oreons_camp")
				cm:make_diplomacy_available(Worldroots.primary_player_key, "wh2_main_wef_bowmen_of_oreon")

				cm:callback(
				function()				
					if confed_missions:is_mission_valid_for_faction(Worldroots.primary_player_key, "wood_elves_oreons_camp") then
						confed_missions:trigger_mission(Worldroots.primary_player_key, "wood_elves_oreons_camp")
					end
				end,
				1)
			end,
		on_battle_trigger_callback =
			function(self, character, marker_info)
				Worldroots:set_up_generic_encounter_forced_battle(character, "wh2_main_wef_bowmen_of_oreon", "wh_dlc05_sc_wef_wood_elves", false, nil, "dlc05_wef_glade_lord", 1,true)
				Worldroots.forests["heart_of_the_jungle"].unresolved_markers = Worldroots.forests["heart_of_the_jungle"].unresolved_markers - 1
			end,
		second_option_callback =
			function(self, character, marker_info)
				cm:force_confederation(character:faction():name(), "wh2_main_wef_bowmen_of_oreon")
				Worldroots.forests["heart_of_the_jungle"].unresolved_markers = Worldroots.forests["heart_of_the_jungle"].unresolved_markers - 1
			end,
	},



	---VORTEX---
	["sisters_skaven_invaders_intro_vortex"] = 
		{spawn_turn = 4,
		forest = "witchwood",
		spawn_incident = "wh2_dlc16_incident_wef_sisters_intro_invasion",
		faction_filter = "wh2_dlc16_wef_sisters_of_twilight",
		region = "wh2_main_vor_naggaroth_glade",
		setup =
		function() 
			local countdown_markers = Interactive_Marker_Manager:create_countdown("sisters_skaven_invaders_intro_vortex","ScriptEventWEFIntroMarkerBattleTriggered","ScriptEventWEFEncounterMarkerExpired",{"invasion_marker_3","invasion_marker_2","invasion_marker_1"},Worldroots.primary_player_key)
			countdown_markers[1]:add_spawn_event_feed_event("event_feed_strings_text_wh2_dlc16_event_feed_string_scripted_event_forest_encounter_title",
			"incidents_localised_title_wh2_dlc16_incident_wef_sisters_intro_invasion",
			"incidents_localised_description_wh2_dlc16_incident_wef_sisters_intro_invasion",
			555,
			"wh2_dlc16_wef_sisters_of_twilight")
			countdown_markers[3]:add_spawn_event_feed_event(
			"event_feed_strings_text_wh2_dlc16_event_feed_string_scripted_event_invasion_title",
			"event_feed_strings_text_wh2_dlc16_event_feed_string_scripted_event_invasion_imminent_primary_detail",
			"event_feed_strings_text_wh2_dlc16_event_feed_string_scripted_event_invasion_imminent_secondary_detail", 
			555,
			"wh2_dlc16_wef_sisters_of_twilight")
			countdown_markers[3]:add_despawn_event_feed_event(
			"event_feed_strings_text_wh2_dlc16_event_feed_string_scripted_event_invasion_title",
			"event_feed_strings_text_wh2_dlc16_event_feed_string_scripted_event_invasion_spawned_primary_detail",
			"event_feed_strings_text_wh2_dlc16_event_feed_string_scripted_event_invasion_spawned_secondary_detail", 
			555,
			"wh2_dlc16_wef_sisters_of_twilight")
			countdown_markers[1]:spawn_at_location(149,569)
		end,
		on_battle_trigger_callback =
		function(self, character, marker_info) 
			Worldroots:set_up_generic_encounter_forced_battle(character, "wh2_dlc13_skv_skaven_invasion", "wh2_main_sc_skv_skaven", true,8 + cm:turn_number(),"wh2_main_skv_grey_seer_plague")		
		end,
		on_expiry_callback = 
		function(self, marker_info) 
			local naggaroth_glade = Worldroots:get_forest_by_string("witchwood")
			local instance_ref = marker_info.instance_ref
			local x,y = Interactive_Marker_Manager:get_coords_from_instance_ref(instance_ref)
			Worldroots:trigger_invasion(naggaroth_glade, x, y, 20)
		end
	},
	["naggaroth_glade_dark_elf_invaders_vortex"] = 
		{spawn_turn = 12,
		forest = "witchwood",
		spawn_incident = "wh2_dlc16_incident_wef_new_encounter_available",
		region = "wh2_main_vor_naggaroth_glade",
		setup = 
			function() 
				Worldroots:set_up_generic_encounter_marker("naggaroth_glade_dark_elf_invaders_vortex", "wh2_dlc16_dilemma_wef_encounter_naggarond_dark_elves_vortex", 124, 540, "witchwood")
			end,
		on_battle_trigger_callback =
			function(self, character, marker_info)
				Worldroots:set_up_generic_encounter_forced_battle(character, "wh2_main_def_dark_elves_qb1", "wh2_main_sc_def_dark_elves", false, nil, "wh2_dlc10_def_supreme_sorceress_dark")
			end,
	},

	["heart_of_the_jungle_tomb_king_invaders_vortex"] = 
		{spawn_turn = 1,
		forest = "heart_of_the_jungle",
		spawn_incident = "wh2_dlc16_incident_wef_new_encounter_available",
		region = "wh2_main_vor_heart_of_the_jungle_oreons_camp",
		setup = 
			function() 
				Worldroots:set_up_generic_encounter_marker("heart_of_the_jungle_tomb_king_invaders_vortex", "wh2_dlc16_dilemma_wef_encounter_heart_of_the_jungle_tomb_kings", 623, 175, "heart_of_the_jungle")
			end,
		on_battle_trigger_callback =
			function(self, character, marker_info)
				Worldroots:set_up_generic_encounter_forced_battle(character, "wh2_dlc09_tmb_tombking_qb1", "wh2_dlc09_sc_tmb_tomb_kings", false)
			end		
	},

	["gaean_vale_high_elf_invaders_vortex"] = 
		{spawn_turn = 1,
		forest = "gaean_vale",
		spawn_incident = "wh2_dlc16_incident_wef_new_encounter_available",
		custom_condition = 
			function()
				return not cm:get_faction("wh2_main_hef_avelorn"):is_dead()
			end,
		region = "wh2_main_vor_avelorn_gaean_vale",
		setup = 
			function() 
				Worldroots:set_up_generic_encounter_marker("gaean_vale_high_elf_invaders_vortex", "wh2_dlc16_dilemma_wef_encounter_gaean_vale_high_elves", 533, 543, "gaean_vale")
			end,
		on_battle_trigger_callback =
			function(self, character, marker_info)
				Worldroots:set_up_generic_encounter_forced_battle(character, "wh2_main_hef_high_elves_qb1", "wh2_main_sc_hef_high_elves", false)
			end,
		second_option_callback = 
			function(self, character, marker_info)
				local faction_to_gain = "wh2_main_hef_avelorn"
				if cm:get_faction("wh2_main_hef_avelorn"):is_dead() then
					faction_to_gain = "wh2_main_hef_eataine"
				end
				cm:transfer_region_to_faction("wh2_main_vor_avelorn_gaean_vale", faction_to_gain)
			end,
	},

	["emerald_pools_lizardmen_invaders_vortex"] = 
		{spawn_turn = 1,
		forest = "emerald_pools",
		spawn_incident = "wh2_dlc16_incident_wef_new_encounter_available",
		region = "wh2_main_vor_lustria_glade",
		setup = 
			function() 
				Worldroots:set_up_generic_encounter_marker("emerald_pools_lizardmen_invaders_vortex", "wh2_dlc16_dilemma_wef_encounter_lustria_lizardmen", 191, 283, "emerald_pools")
			end,
		on_battle_trigger_callback =
			function(self, character, marker_info)
				Worldroots:set_up_generic_encounter_forced_battle(character, "wh2_main_lzd_lizardmen_qb1", "wh2_main_sc_lzd_lizardmen", false)
			end,
	},

	["witchwood_greenskins_v_druchii_vortex"] = 
	{
		spawn_turn = 12,
		forest = "witchwood",
		spawn_incident = "wh2_dlc16_incident_wef_new_encounter_available",
		region = "wh2_main_vor_naggaroth_glade",
		setup = 
			function() 
				Worldroots:set_up_generic_encounter_marker("witchwood_greenskins_v_druchii_vortex", "wh2_dlc16_dilemma_wef_encounter_witchwood_greenskins_v_druchii", 141, 582, "witchwood")
			end,
		on_battle_trigger_callback =
			function(self, character, marker_info)
				Worldroots:set_up_generic_encounter_forced_battle(character, "wh2_main_def_dark_elves_qb1", "wh2_main_sc_def_dark_elves", false, 18, "wh2_dlc14_def_high_beastmaster", 1)
			end,
		second_option_callback =
			function(self, character, marker_info)
				Worldroots:set_up_generic_encounter_forced_battle(character, "wh2_dlc13_grn_greenskins_invasion", "grn_greenskins_orcs_only", false, nil, "grn_orc_warboss")
			end,
	},

	["witchwood_moulder_v_skryre_vortex"] = 
	{
		spawn_turn = 12,
		forest = "witchwood",
		spawn_incident = "wh2_dlc16_incident_wef_new_encounter_available",
		region = "wh2_main_vor_naggaroth_glade",
		setup = 
			function() 
				Worldroots:set_up_generic_encounter_marker("witchwood_moulder_v_skryre_vortex", "wh2_dlc16_dilemma_wef_encounter_witchwood_skryre_v_moulder", 107, 576, "witchwood")
			end,
		on_battle_trigger_callback =
			function(self, character, marker_info)
				Worldroots:set_up_generic_encounter_forced_battle(character, "wh2_dlc13_skv_skaven_invasion", "skv_moulder", false, 18, "wh2_main_skv_grey_seer_plague", 1)
			end,
		second_option_callback =
			function(self, character, marker_info)
				Worldroots:set_up_generic_encounter_forced_battle(character, "wh2_dlc13_skv_skaven_invasion", "skv_skryre_drill_team", false, nil, "wh2_dlc12_skv_warlock_master")
			end,
	},

	["sacred_pools_pestilens_vortex"] = 
	{
		spawn_turn = 1,
		forest = "emerald_pools",
		spawn_incident = "wh2_dlc16_incident_wef_new_encounter_available",
		region = "wh2_main_vor_lustria_glade",
		setup = 
			function() 
				Worldroots:set_up_generic_encounter_marker("sacred_pools_pestilens_vortex", "wh2_dlc16_dilemma_wef_encounter_sacred_pools_pestilens", 202, 263, "emerald_pools")
			end,
		on_battle_trigger_callback =
			function(self, character, marker_info)
				Worldroots:set_up_generic_encounter_forced_battle(character, "wh2_dlc13_skv_skaven_invasion", "skv_pestilens_and_rats", false, nil, "wh2_main_skv_grey_seer_plague")
			end,
		second_option_callback =
			function(self, character, marker_info)
				Worldroots:set_up_generic_encounter_forced_battle(character, "wh2_dlc13_skv_skaven_invasion", "skv_pestilens_and_rats", false, nil, "wh2_main_skv_grey_seer_plague")
			end,
	},

	["gaean_vale_druchii_vs_moulder_vortex"] = 
	{
		spawn_turn = 1,
		forest = "gaean_vale",
		spawn_incident = "wh2_dlc16_incident_wef_new_encounter_available",
		region = "wh2_main_vor_avelorn_gaean_vale",
		setup = 
			function() 
				Worldroots:set_up_generic_encounter_marker("gaean_vale_druchii_vs_moulder_vortex", "wh2_dlc16_dilemma_wef_encounter_gaean_vale_druchii_v_moulder", 491, 611, "gaean_vale")
			end,
		on_battle_trigger_callback =
			function(self, character, marker_info)
				Worldroots:set_up_generic_encounter_forced_battle(character, "wh2_main_def_dark_elves_qb1", "def_corsairs", false, 18, "wh2_main_def_dreadlord", 1)
			end,
		second_option_callback =
			function(self, character, marker_info)
				Worldroots:set_up_generic_encounter_forced_battle(character, "wh2_dlc13_skv_skaven_invasion", "skv_moulder", false, 12, "wh2_main_skv_grey_seer_plague")
			end,
	},

	["heart_of_the_jungle_bowmen_v_dinosaurs_vortex"] = 
	{
		spawn_turn = 20,
		spawn_incident = "wh2_dlc16_incident_wef_new_confed_encounter_available",
		region = "wh2_main_vor_heart_of_the_jungle_oreons_camp",
		setup = 
			function() 
				Worldroots:set_up_generic_encounter_marker("heart_of_the_jungle_bowmen_v_dinosaurs_vortex", "wh2_dlc16_dilemma_wef_encounter_heart_of_the_jungle_bowmen_v_dinosaurs", 601, 172, "heart_of_the_jungle")
				cm:make_region_seen_in_shroud(Worldroots.primary_player_key, "wh2_main_vor_heart_of_the_jungle_oreons_camp")
				cm:make_diplomacy_available(Worldroots.primary_player_key, "wh2_main_wef_bowmen_of_oreon")

				cm:callback(
					function()
						if confed_missions:is_mission_valid_for_faction(Worldroots.primary_player_key, "wood_elves_oreons_camp") then
							confed_missions:trigger_mission(Worldroots.primary_player_key, "wood_elves_oreons_camp")
						end
					end,
				1)
			end,
		on_battle_trigger_callback =
			function(self, character, marker_info)
				Worldroots:set_up_generic_encounter_forced_battle(character, "wh2_main_wef_bowmen_of_oreon", "wh_dlc05_sc_wef_wood_elves", false, nil, "dlc05_wef_glade_lord", 1,true)
				Worldroots.forests["heart_of_the_jungle"].unresolved_markers = Worldroots.forests["heart_of_the_jungle"].unresolved_markers - 1
			end,
		second_option_callback =
			function(self, character, marker_info)
				cm:force_confederation(character:faction():name(), "wh2_main_wef_bowmen_of_oreon")
				Worldroots.forests["heart_of_the_jungle"].unresolved_markers = Worldroots.forests["heart_of_the_jungle"].unresolved_markers - 1
			end,
	},


	-----------------------------------
	---- SISTERS ENDGAME INVASIONS ----
	-----------------------------------
	["sisters_skaven_invaders_endgame_1"] = 
		{forest = "witchwood",
		custom_condition = 
		function()
			return active_skaven_invasions and (skaven_invasions_turn_start + 5) <= cm:turn_number();
		end,
		spawn_incident = "wh2_dlc16_incident_sisters_skaven_invasion_continues", 
		faction_filter = "wh2_dlc16_wef_sisters_of_twilight", 
		region = "wh2_main_vor_naggaroth_glade", 
		setup =
		function() 
			--- this creates a special countdown marker type.  NOTE: marker key (e.g. "sisters_skaven_invaders_endgame_1") below MUST match the table reference for this encounter)
			local countdown_markers = Interactive_Marker_Manager:create_countdown("sisters_skaven_invaders_endgame_1","ScriptEventWEFIntroMarkerBattleTriggered","ScriptEventWEFEncounterMarkerExpired",{"invasion_marker_1","invasion_marker_2"},Worldroots.primary_player_key)
			countdown_markers[1]:add_spawn_event_feed_event("event_feed_strings_text_wh2_dlc16_event_feed_string_scripted_event_forest_encounter_title",
			"incidents_localised_title_wh2_dlc16_incident_sisters_skaven_invasion_continues",
			"incidents_localised_description_wh2_dlc16_incident_sisters_skaven_invasion_continues",
			555,
			"wh2_dlc16_wef_sisters_of_twilight")
			countdown_markers[2]:add_spawn_event_feed_event(
			"event_feed_strings_text_wh2_dlc16_event_feed_string_scripted_event_invasion_title",
			"event_feed_strings_text_wh2_dlc16_event_feed_string_scripted_event_invasion_imminent_primary_detail",
			"event_feed_strings_text_wh2_dlc16_event_feed_string_scripted_event_invasion_imminent_secondary_detail", 
			555,
			"wh2_dlc16_wef_sisters_of_twilight")
			countdown_markers[2]:add_despawn_event_feed_event(
			"event_feed_strings_text_wh2_dlc16_event_feed_string_scripted_event_invasion_title",
			"event_feed_strings_text_wh2_dlc16_event_feed_string_scripted_event_invasion_spawned_primary_detail",
			"event_feed_strings_text_wh2_dlc16_event_feed_string_scripted_event_invasion_spawned_secondary_detail", 
			555,
			"wh2_dlc16_wef_sisters_of_twilight")
			countdown_markers[1]:spawn_at_location(137,535);
			countdown_markers[2]:spawn_at_location(101,581);
		end,
		on_battle_trigger_callback =
		function(self, character, marker_info) 
			--- this function fires when a character moves into the marker and fights a battle
			--- currently sets up a forced battle between the character who enters the marker and a skaven force
			Worldroots:set_up_generic_encounter_forced_battle(character, "wh2_main_skv_clan_moulder", "wh2_main_sc_skv_skaven", true, nil,"wh2_main_skv_grey_seer_plague" )		
			
			--- doesn't have to be a battle, can be anything
		end,
		on_expiry_callback = 
		function(self, marker_info) 
			--- this function will fire when the marker expires
			local naggaroth_glade = Worldroots:get_forest_by_string("witchwood")

			--- the below two lines show you how to get the x/y coords of a marker if you need to use that (e.g. to determine the spawn location for an army)
			local instance_ref = marker_info.instance_ref
			local x,y = Interactive_Marker_Manager:get_coords_from_instance_ref(instance_ref)

			-- this function will create an invasion using the invasion manager, and point it at a specific glade
			Worldroots:trigger_invasion(naggaroth_glade, x, y, 20)
		end
	},


	["sisters_skaven_invaders_endgame_2"] = 
		{forest = "witchwood",
		custom_condition = 
		function()
			return active_skaven_invasions and (skaven_invasions_turn_start + 10) <= cm:turn_number();
		end,
		spawn_incident = "wh2_dlc16_incident_sisters_skaven_invasion_continues", 
		faction_filter = "wh2_dlc16_wef_sisters_of_twilight", 
		region = "wh2_main_vor_naggaroth_glade", 
		setup =
		function() 
			--- this creates a special countdown marker type.  NOTE: marker key (e.g. "sisters_skaven_invaders_endgame_1") below MUST match the table reference for this encounter)
			local countdown_markers = Interactive_Marker_Manager:create_countdown("sisters_skaven_invaders_endgame_2","ScriptEventWEFIntroMarkerBattleTriggered","ScriptEventWEFEncounterMarkerExpired",{"invasion_marker_1","invasion_marker_2"},Worldroots.primary_player_key)
			countdown_markers[1]:add_spawn_event_feed_event("event_feed_strings_text_wh2_dlc16_event_feed_string_scripted_event_forest_encounter_title",
			"incidents_localised_title_wh2_dlc16_incident_sisters_skaven_invasion_continues",
			"incidents_localised_description_wh2_dlc16_incident_sisters_skaven_invasion_continues",
			555,
			"wh2_dlc16_wef_sisters_of_twilight")
			countdown_markers[2]:add_spawn_event_feed_event(
			"event_feed_strings_text_wh2_dlc16_event_feed_string_scripted_event_invasion_title",
			"event_feed_strings_text_wh2_dlc16_event_feed_string_scripted_event_invasion_imminent_primary_detail",
			"event_feed_strings_text_wh2_dlc16_event_feed_string_scripted_event_invasion_imminent_secondary_detail", 
			555,
			"wh2_dlc16_wef_sisters_of_twilight")
			countdown_markers[2]:add_despawn_event_feed_event(
			"event_feed_strings_text_wh2_dlc16_event_feed_string_scripted_event_invasion_title",
			"event_feed_strings_text_wh2_dlc16_event_feed_string_scripted_event_invasion_spawned_primary_detail",
			"event_feed_strings_text_wh2_dlc16_event_feed_string_scripted_event_invasion_spawned_secondary_detail", 
			555,
			"wh2_dlc16_wef_sisters_of_twilight")
			countdown_markers[1]:spawn_at_location(102,575);
			countdown_markers[2]:spawn_at_location(101,535);
		end,
		on_battle_trigger_callback =
		function(self, character, marker_info) 
			--- this function fires when a character moves into the marker and fights a battle
			--- currently sets up a forced battle between the character who enters the marker and a skaven force
			Worldroots:set_up_generic_encounter_forced_battle(character, "wh2_main_skv_clan_moulder", "wh2_main_sc_skv_skaven", true, nil,"wh2_main_skv_grey_seer_plague" )		
			
			--- doesn't have to be a battle, can be anything
		end,
		on_expiry_callback = 
		function(self, marker_info) 
			--- this function will fire when the marker expires
			local naggaroth_glade = Worldroots:get_forest_by_string("witchwood")

			--- the below two lines show you how to get the x/y coords of a marker if you need to use that (e.g. to determine the spawn location for an army)
			local instance_ref = marker_info.instance_ref
			local x,y = Interactive_Marker_Manager:get_coords_from_instance_ref(instance_ref)

			-- this function will create an invasion using the invasion manager, and point it at a specific glade
			Worldroots:trigger_invasion(naggaroth_glade, x, y, 20)
		end
	},

	["sisters_skaven_invaders_endgame_3"] = 
		{forest = "witchwood",
		custom_condition = 
		function()
			return active_skaven_invasions and (skaven_invasions_turn_start + 15) <= cm:turn_number();
		end,
		spawn_incident = "wh2_dlc16_incident_sisters_skaven_invasion_continues", 
		faction_filter = "wh2_dlc16_wef_sisters_of_twilight", 
		region = "wh2_main_vor_naggaroth_glade", 
		can_reoccur = true, -- this event will NOT be added to the 'completed encounters' list and can fire again once the global cooldown has passed
		setup =
		function() 
			--- this creates a special countdown marker type.  NOTE: marker key (e.g. "sisters_skaven_invaders_endgame_1") below MUST match the table reference for this encounter)
			local countdown_markers = Interactive_Marker_Manager:create_countdown("sisters_skaven_invaders_endgame_3","ScriptEventWEFIntroMarkerBattleTriggered","ScriptEventWEFEncounterMarkerExpired",{"invasion_marker_1","invasion_marker_2","invasion_marker_3"},Worldroots.primary_player_key)
			countdown_markers[1]:add_spawn_event_feed_event("event_feed_strings_text_wh2_dlc16_event_feed_string_scripted_event_forest_encounter_title",
			"incidents_localised_title_wh2_dlc16_incident_sisters_skaven_invasion_continues",
			"incidents_localised_description_wh2_dlc16_incident_sisters_skaven_invasion_continues",
			555,
			"wh2_dlc16_wef_sisters_of_twilight")
			countdown_markers[3]:add_spawn_event_feed_event(
			"event_feed_strings_text_wh2_dlc16_event_feed_string_scripted_event_invasion_title",
			"event_feed_strings_text_wh2_dlc16_event_feed_string_scripted_event_invasion_imminent_primary_detail",
			"event_feed_strings_text_wh2_dlc16_event_feed_string_scripted_event_invasion_imminent_secondary_detail", 
			555,
			"wh2_dlc16_wef_sisters_of_twilight")
			countdown_markers[3]:add_despawn_event_feed_event(
			"event_feed_strings_text_wh2_dlc16_event_feed_string_scripted_event_invasion_title",
			"event_feed_strings_text_wh2_dlc16_event_feed_string_scripted_event_invasion_spawned_primary_detail",
			"event_feed_strings_text_wh2_dlc16_event_feed_string_scripted_event_invasion_spawned_secondary_detail", 
			555,
			"wh2_dlc16_wef_sisters_of_twilight")
			countdown_markers[1]:spawn_at_location(129,586);
			countdown_markers[2]:spawn_at_location(149,539);
			countdown_markers[3]:spawn_at_location(79,555);
		end,
		on_battle_trigger_callback =
		function(self, character, marker_info) 
			--- this function fires when a character moves into the marker and fights a battle
			--- currently sets up a forced battle between the character who enters the marker and a skaven force
			Worldroots:set_up_generic_encounter_forced_battle(character, "wh2_main_skv_clan_moulder", "wh2_main_sc_skv_skaven", true, nil,"wh2_main_skv_grey_seer_plague" )		
			
			--- doesn't have to be a battle, can be anything
		end,
		on_expiry_callback = 
		function(self, marker_info) 
			--- this function will fire when the marker expires
			local naggaroth_glade = Worldroots:get_forest_by_string("witchwood")

			--- the below two lines show you how to get the x/y coords of a marker if you need to use that (e.g. to determine the spawn location for an army)
			local instance_ref = marker_info.instance_ref
			local x,y = Interactive_Marker_Manager:get_coords_from_instance_ref(instance_ref)

			-- this function will create an invasion using the invasion manager, and point it at a specific glade
			Worldroots:trigger_invasion(naggaroth_glade, x, y, 20)
		end
	},
}

Worldroots.teleport_rituals_to_regions =  {
	["wh2_dlc16_worldroots_teleport_athel_loren"] = "wh_main_yn_edri_eternos_the_oak_of_ages",
	["wh2_dlc16_worldroots_teleport_emerald_pools_main"]= "wh2_main_lustria_glade",
	["wh2_dlc16_worldroots_teleport_emerald_pools_vortex"] = "wh2_main_vor_lustria_glade",
	["wh2_dlc16_worldroots_teleport_gaean_vale_main"] = "wh2_main_avelorn_gaean_vale",
	["wh2_dlc16_worldroots_teleport_gaean_vale_vortex"]= "wh2_main_vor_avelorn_gaean_vale",
	["wh2_dlc16_worldroots_teleport_gryphon_wood"] = "wh2_main_old_world_glade",
	["wh2_dlc16_worldroots_teleport_heart_of_the_jungle_main"] = "wh2_main_heart_of_the_jungle_oreons_camp",
	["wh2_dlc16_worldroots_teleport_heart_of_the_jungle_vortex"] = "wh2_main_vor_heart_of_the_jungle_oreons_camp",
	["wh2_dlc16_worldroots_teleport_laurelorn"]= "wh2_main_laurelorn_forest_laurelorn_forest",
	["wh2_dlc16_worldroots_teleport_witchwood_main"] = "wh2_main_naggaroth_glade",
	["wh2_dlc16_worldroots_teleport_witchwood_vortex"] = "wh2_main_vor_naggaroth_glade",
	["wh2_dlc16_worldroots_teleport_forest_of_gloom"] = "wh2_main_badlands_glade"
}
---------------
---FUNCTIONS---
---------------


---VFX---
--functions for showing the Worldroots VFX
function Worldroots:pulse_all_worldroots_beams()
	local primary_forest_key = Worldroots.forests[Worldroots.primary_forest].glade_region_key
	local ignore_primary_glade_vfx = false
	for forest_ref, forest in pairs(Worldroots.forests) do
		if forest.glade_region_key ~= primary_forest_key then
			self:pulse_worldroots_beam(primary_forest_key, forest.glade_region_key, ignore_primary_glade_vfx)
			ignore_primary_glade_vfx = true
		end
	end
end


function Worldroots:pulse_worldroots_beam(starting_region, ending_region, opt_ignore_start_scene, opt_ignore_end_scene)
	local starting_x, starting_y = self:get_coords_of_settlement(starting_region)
	local ending_x, ending_y = self:get_coords_of_settlement(ending_region)
	local composite_scene_key


	local dx = starting_x - ending_x
  	local dy = starting_y - ending_y
	local distance = math.sqrt( dx * dx + dy * dy)


	local beams_required = math.floor(distance/self.worldroots_vfx_beam_length) + 1
	

	local beam_division_x = (ending_x-starting_x)/beams_required
	local beam_division_y = (ending_y-starting_y)/beams_required
	  


	if not opt_ignore_start_scene then
		cm:add_scripted_composite_scene_to_logical_position("worldroot_end"..starting_region,self.worldroots_vfx_beam_end_key,starting_x,starting_y,ending_x,ending_y,true,true,true)
	end

	if not opt_ignore_end_scene then
		cm:add_scripted_composite_scene_to_logical_position("worldroot_end"..ending_region,self.worldroots_vfx_beam_end_key,ending_x,ending_y,ending_x,ending_y,true,true,true)
	end


	for i = 1, beams_required - 1 do  
		local beam_component_start_x, beam_component_start_y
		local beam_facing_x, beam_facing_y = ending_x, ending_y

		beam_component_start_x, beam_component_start_y = starting_x + beam_division_x*i, starting_y + beam_division_y*i
	
		composite_scene_key = self.worldroots_vfx_beam_key


		cm:add_scripted_composite_scene_to_logical_position(composite_scene_key..starting_region..ending_region..i,composite_scene_key,beam_component_start_x,beam_component_start_y,beam_facing_x,beam_facing_y,true,true,true)
	end
	
end

function Worldroots:get_coords_of_settlement(region_key)
	local settlement_x_coord = cm:get_region(region_key):settlement():logical_position_x()
	local settlement_y_coord = cm:get_region(region_key):settlement():logical_position_y()
	return settlement_x_coord, settlement_y_coord
	
end

function Worldroots:add_worldroots_listeners()
	out("#####Adding Worldroots Listeners#####")

	-- Automatically Upgrade AI Units at set intervals
	cm:add_faction_turn_start_listener_by_subculture(
		"aspect_upgrade",
		wef_subc,
		function(context)
			if context:faction():is_human() == false then
				local turn = cm:model():turn_number();
				local wef_interface = context:faction();
				local wef_force_list = wef_interface:military_force_list();
				if context:faction():name() ~= "wh2_dlc16_wef_drycha" and context:faction():name() ~= "wh_dlc05_wef_argwylon" then
					return
				end
				if turn % cooldown == 0 then 
					for l = 0, wef_force_list:num_items() - 1 do
						local wef_force = wef_force_list:item_at(l);
						local unit_list = wef_force:unit_list();
						for i = 0, unit_list:num_items() - 1 do
							local unit_interface = unit_list:item_at(i);
							local unit_purchasable_effect_list = unit_interface:get_unit_purchasable_effects();
							if unit_purchasable_effect_list:num_items() ~=0 then
								local rand = cm:random_number(unit_purchasable_effect_list:num_items()) -1;
								local effect_interface = unit_purchasable_effect_list:item_at(rand);
								-- Upgrade the unit
								if wef_force:is_armed_citizenry() == false then
								cm:faction_purchase_unit_effect(context:faction(), unit_interface, effect_interface);
								end	
							end	
						end
					end
				end
			end
		end,
		true
	);

	--- find the first human wood elf and define them as the primary, then define a secondary if there is one
	self.primary_player_key = false
	self.secondary_player_key = false
	for i = 1, #Worldroots.playable_wood_elf_factions do
		if cm:get_faction(Worldroots.playable_wood_elf_factions[i]) ~= false and cm:get_faction(Worldroots.playable_wood_elf_factions[i]):is_human() then
			if self.primary_player_key == false then
				self.primary_player_key = Worldroots.playable_wood_elf_factions[i]
			else
				self.secondary_player_key = Worldroots.playable_wood_elf_factions[i]
			end
		end
	end

	--- Drycha can never confederate with anyone but Durthu
	cm:force_diplomacy("faction:wh2_dlc16_wef_drycha", "culture:wh_dlc05_wef_wood_elves", "form confederation", false, false);
	cm:force_diplomacy("faction:wh2_dlc16_wef_drycha", "faction:wh_dlc05_wef_argwylon", "form confederation", true, true);

	if self.primary_player_key ~= "wh2_dlc16_wef_drycha" and self.secondary_player_key ~= "wh2_dlc16_wef_drycha" then
		core:add_listener(
			"CharacterRankUpDrychaQuest",
			"CharacterRankUp",
			function(context)
				return context:character():character_subtype("wh2_dlc16_wef_drycha") and context:character():rank() >= 5 and Worldroots.coeddil_unlocked == false
				and not context:character():faction():is_human()
			end,
			function(context)
				local drycha_faction = context:character():faction()
				cm:spawn_unique_agent(drycha_faction:command_queue_index(), "wh2_dlc16_wef_coeddil", true);
				out("COEDDIL SPAWNED!")
			end,
			true
		)
	end

	if self.primary_player_key == false or (self.primary_player_key == "wh2_dlc16_wef_drycha" and self.secondary_player_key == false) then
		out("No human Wood Elves found or human Drycha")
		--- if no humans, kick off a listener to spawn ariel around a specified turn
		if Worldroots.ariel_unlocked == false then
			core:add_listener(
				"WorldrootsUpdateFactionTurnStart",
				"ScriptEventHumanFactionTurnStart",
				function(context)
					return cm:turn_number()>= Worldroots.ai_ariel_spawn_turn and Worldroots.ariel_unlocked == false
				end,
				function(context)
					---- don't spawn if you're in Throt's vortex campaign
					if cm:get_campaign_name() == "wh2_main_great_vortex" and cm:get_faction("wh2_main_skv_clan_moulder") ~=false and cm:get_faction("wh2_main_skv_clan_moulder"):is_human() then
						return
					end

					local ariel_potential_factions = {"wh2_dlc16_wef_sisters_of_twilight", "wh_dlc05_wef_wood_elves"} --- order matters here, Sisters get 'first shot'
					
					for i = 1, #ariel_potential_factions do 
						local faction_to_check = ariel_potential_factions[i]
						if cm:get_faction(faction_to_check) ~= false and cm:get_faction(faction_to_check):is_dead() == false then
							if cm:random_number() <= Worldroots.ai_ariel_spawn_chance then 
								Worldroots:spawn_ariel(faction_to_check)
								return
							end
						end
					end		
				end,
			true)
		end
		if self.primary_player_key == false then
			return ---Nothing after this point should fire if there aren't any human Wood Elves
		end
	end

	out("Primary Wood Elf Faction is "..tostring(self.primary_player_key))
	out("Secondary Wood Elf Faction is "..tostring(self.secondary_player_key))
	
	---update the invasion power.
	Worldroots:calculate_invasion_power()

	
	--- only player(s) - excluding Drycha - can confederate
	if self.primary_player_key ~= "wh2_dlc16_wef_drycha" then
		cm:force_diplomacy("culture:wh_dlc05_wef_wood_elves", "culture:wh_dlc05_wef_wood_elves", "form confederation", false, false);
		cm:force_diplomacy("faction:"..self.primary_player_key,"culture:wh_dlc05_wef_wood_elves","form confederation",true,true)
	end

	if self.secondary_player_key ~= false and self.secondary_player_key ~= "wh2_dlc16_wef_drycha" then
		cm:force_diplomacy("faction:"..self.secondary_player_key,"culture:wh_dlc05_wef_wood_elves","form confederation",true,true)
	end

	
	---swap out the forest data for vortex overrides if we're in vortex
	if cm:get_campaign_name() == "wh2_main_great_vortex" then
		Worldroots:apply_vortex_overrides()
	end

	if cm:is_new_game() then
		-- things we do only once on campaign start go here
		--- we start the Worldroots health rituals locked then unlock them here, otherwise the AI will use them!
		self:unlock_all_rituals_for_humans()
		self:reveal_adjacent_regions_to_glade_owners()
		if cm:get_faction("wh2_dlc16_wef_drycha") ~= false then
			cm:faction_add_pooled_resource("wh2_dlc16_wef_drycha", "wef_amber", "wh2_main_resource_factor_other", 1)
		end
		if Worldroots.debug_ariel_unlock then 
			self:spawn_ariel(self.primary_player_key)
			if cm:get_faction("wh2_dlc16_wef_drycha") ~= false then
				cm:spawn_unique_agent(cm:get_faction("wh2_dlc16_wef_drycha"):command_queue_index(), "wh2_dlc16_wef_coeddil", true);
			end
		end
	end
	

	self:set_up_ritual_listeners()
	self:lock_buildings()
	self:set_up_battle_listeners()

	---things we do every player turn can go inside this listener
	core:add_listener(
		"WorldrootsUpdateFactionTurnStart",
		"ScriptEventHumanFactionTurnStart",
		function(context)
			return Worldroots:faction_is_human_wood_elf(context:faction())
		end,
		function(context)
			if context:faction():has_technology("tech_dlc16_wef_ancients_eagles") then
				Worldroots:provide_vision_on_all_glades(context:faction():name())
			end

			Worldroots:generate_encounter(context:faction())

			if cm:get_faction("wh2_main_wef_bowmen_of_oreon"):is_dead() then
				local bowmen_marker_key = "heart_of_the_jungle_bowmen_v_dinosaurs_me"
				if cm:get_campaign_name() == "wh2_main_great_vortex" then
					bowmen_marker_key = "heart_of_the_jungle_bowmen_v_dinosaurs_vortex"
				end
				Worldroots:remove_encounter(bowmen_marker_key)
			end
		
			if context:faction():name() == Worldroots.primary_player_key then
				Worldroots:update_worldroots_health()
				Worldroots:calculate_invasion_power()
				
				if cm:turn_number() == Worldroots.deeproots_unlock_turn then
					cm:unlock_rituals_in_category(context:faction(), "WORLDROOTS_TELEPORTATION", -1)
					if Worldroots.secondary_player_key ~= false then
						cm:unlock_rituals_in_category(cm:get_faction(Worldroots.secondary_player_key), "WORLDROOTS_TELEPORTATION", -1)
					end
					core:trigger_event("ScriptEventDeeprootsUnlocked")
				end

				if cm:turn_number() == Worldroots.avelorn_invasion_turn then
					Worldroots:launch_avelorn_invasion()
				elseif cm:turn_number() == Worldroots.avelorn_invasion_turn + Worldroots.avelorn_invasion_duration then
					Worldroots:end_avelorn_invasion()
				end
			end
		end,
	true)

	core:add_listener(
		"MissionSucceededDrychaQuest",
		"MissionSucceeded",
		function(context)
			return context:mission():mission_record_key() == "wh2_dlc16_wef_drycha_coeddil_unchained_stage_4_mpc" or context:mission():mission_record_key() ==  "wh2_dlc16_wef_drycha_coeddil_unchained_stage_4"
		end,
		function (context)
			if Worldroots.coeddil_unlocked == false then
				cm:spawn_unique_agent(context:mission():faction():command_queue_index(), "wh2_dlc16_wef_coeddil", true);
				out("COEDDIL SPAWNED!")
			end
		end
	)

	core:add_listener(
		"AspectUnitEffectPurchased",
		"UnitEffectPurchased",
		function(context)
			local upgrade_key = context:effect():record_key()
			return string.match(upgrade_key, "wh2_dlc16_wef_upgrade_aspect_.*")
		end,
		function(context)
			local unit = context:unit()
			local new_upgrade_key  = context:effect():record_key()
			local unit_current_effects = unit:get_unit_purchased_effects()
			for i = 0, unit_current_effects:num_items() - 1 do
				local current_upgrade = unit_current_effects:item_at(i)
				if current_upgrade:record_key() ~= new_upgrade_key then
					cm:faction_unpurchase_unit_effect(unit, current_upgrade);
				end
			end
		end,
	true)

	--- edge case handling if the player confederates the Bowmen between the marker spawning and interacting with it
	if not cm:get_faction("wh2_main_wef_bowmen_of_oreon"):is_dead() then
		core:add_listener(
			"BowmenJoinConfederation",
			"FactionJoinsConfederation",
			function(context)
				return context:faction():name() == "wh2_main_wef_bowmen_of_oreon"
			end,
			function(context)
				local bowmen_marker_key = "heart_of_the_jungle_bowmen_v_dinosaurs_me"
				if cm:get_campaign_name() == "wh2_main_great_vortex" then
					bowmen_marker_key = "heart_of_the_jungle_bowmen_v_dinosaurs_vortex"
				end

				Worldroots:remove_encounter(bowmen_marker_key)
			end,
		true)
	end


--- make the magical forest panel disappear on click, reappear when you click the worldroots button
	local uic_root = core:get_ui_root()
	local magical_forest_info = find_uicomponent(uic_root, "layout", "magical_forest_info")
	if magical_forest_info ~= false then
		magical_forest_info:SetInteractive(true)
	end
	
	core:add_listener(
		"MagicalForestLClickUp_listener",
		"ComponentLClickUp",
		function(context)
			return context.string == "magical_forest_info"
		end,
		function(context)
			Worldroots:set_magic_forest_panel_visibility(false)
		end,
		true
	);	

	function Worldroots:set_magic_forest_panel_visibility(is_visible, opt_opacity)
		if magical_forest_info == false then
			return
		end
		
		local opacity = opt_opacity or 255

		if not is_visible then 
			opacity = 0
		end

		magical_forest_info:SetOpacity(opacity)
		magical_forest_info:PropagateOpacity(opacity)
		magical_forest_info:SetVisible(is_visible)
		magical_forest_info:PropagateVisibility(is_visible)
	
	end


	---VFX listeners
	--- show the roots when you click the worldroots button
	core:add_listener(
		"WorldrootsButtonLClickUp_listener",
		"ComponentLClickUp",
		function(context)
			if context.string == "button_world_roots" and not Worldroots.vfx_active then
				return true;
			end
		end,
		function(context)
			Worldroots:pulse_all_worldroots_beams()
			Worldroots.vfx_active = true
			cm:callback(
				function()
					Worldroots.vfx_active = false
				end,
				Worldroots.worldroot_vfx_cooldown
			)
			magical_forest_info:SetInteractive(true)
			Worldroots:set_magic_forest_panel_visibility(true)
		end,
		true
	);	

	
	--- apply VFX when teleporting
	core:add_listener(
		"TelportationRitualStartedEvent",
		"RitualStartedEvent",
		function(context)
			return context:ritual():ritual_category() == "WORLDROOTS_TELEPORTATION"
		end,
		function(context)
			local teleported_force = context:ritual():ritual_target():get_target_force()
			local force_x = teleported_force:general_character():logical_position_x()
			local force_y = teleported_force:general_character():logical_position_y()
			local force_starting_region_key = teleported_force:general_character():region():name()
			local force_target_region_key = Worldroots.teleport_rituals_to_regions[context:ritual():ritual_key()]

			if not is_string(force_target_region_key) then
				script_error("Worldroots: teleporting to a region but don't have a valid target region for VFX, so no VFX will be fired")
				return
			end

			Worldroots:pulse_worldroots_beam(force_starting_region_key, force_target_region_key, true, true)

			cm:add_scripted_composite_scene_to_logical_position("teleport_vfx",Worldroots.teleport_vfx_key,force_x,force_y,force_x+1,force_y+1,true,true,true)
			cm:callback(
				function()
					local force_x = teleported_force:general_character():logical_position_x()
					local force_y = teleported_force:general_character():logical_position_y()
					cm:add_scripted_composite_scene_to_logical_position("teleport_vfx",Worldroots.teleport_vfx_key,force_x,force_y,force_x+1,force_y+1,true,true,true)
				end,
				0.2
			)

		end,
		true
	)
end

function Worldroots:set_up_generic_encounter_marker(key, dilemma, loc_x, loc_y, forest_key)
	local marker = Interactive_Marker_Manager:new_marker_type(key, "worldroots_encounter",nil,1, nil, "wh_dlc05_sc_wef_wood_elves")
	marker:add_interaction_event("ScriptEventWEFEncounterMarkerPeacefullyResolved", 0)
	marker:add_interaction_event("ScriptEventWEFEncounterMarkerBattleTriggered", 1)
	marker:despawn_on_interaction(true,{0,1})
	marker:add_dilemma(dilemma)
	if self.encounters[key].spawn_incident ~= nil then
		marker:add_spawn_event_feed_event("event_feed_strings_text_wh2_dlc16_event_feed_string_scripted_event_forest_encounter_title",
		"incidents_localised_title_"..self.encounters[key].spawn_incident,
		"incidents_localised_description_"..self.encounters[key].spawn_incident,
		555,
		false,
		"wh_dlc05_sc_wef_wood_elves")
	end
	marker:spawn_at_location(loc_x,loc_y)
	marker:is_persistent(false)

	if forest_key ~= nil and Worldroots.forests[forest_key] ~= nil then
		Worldroots.forests[forest_key].unresolved_markers = Worldroots.forests[forest_key].unresolved_markers + 1
	end

end

function Worldroots:set_up_generic_encounter_forced_battle(character, target_faction_key, force_template_key, is_ambush, army_size_override, opt_general_subtype, opt_power_modifier, opt_ignore_effect_bundle)
	local interacting_force_cqi = character:military_force():command_queue_index()
	local army_size = army_size_override or Worldroots:calculate_enemy_force_size_from_player_force(character, 0)
	local general_override = opt_general_subtype or nil
	local power_modifier = opt_power_modifier or 0
	local effect_bundle = nil
	if not opt_ignore_effect_bundle then
		effect_bundle = self.invasion_force_interrupted_effect_bundle
	end

	Forced_Battle_Manager:trigger_forced_battle_against_generated_ai_army(
		interacting_force_cqi,
		target_faction_key,
		force_template_key,
		army_size,
		Worldroots.invasion_power_modifier + power_modifier,
		false,
		false,
		is_ambush,
		nil,
		nil,
		general_override,
		Worldroots.invasion_power_modifier + power_modifier,
		effect_bundle
		)


end

function Worldroots:apply_vortex_overrides()
	for forest_key, forest in pairs(Worldroots.forests) do
		if is_table(Worldroots.vortex_forest_overrides[forest_key]) then
			for override_key, override_value in pairs(Worldroots.vortex_forest_overrides[forest_key]) do
				if override_value ~= nil then
					forest[override_key] = override_value
				end
			end
		else
			Worldroots.forests[forest_key] = nil
		end
	end
	self.primary_forest = self.primary_forest_vortex
end


function Worldroots:generate_encounter(faction_interface)
	self.turns_since_last_marker = self.turns_since_last_marker + 1
	if self.turns_since_last_marker < self.marker_cooldown and not Worldroots.debug_ignore_marker_cooldown then
		return
	end
	
	local valid_encounters = Worldroots:generate_valid_encounter_list_for_faction(faction_interface:name())

	out.design(valid_encounters)
	
	if valid_encounters ~= false then
		local random_encounter = valid_encounters[cm:random_number(#valid_encounters, 1)]
		out.design(random_encounter)
		local encounter_to_trigger = Worldroots.encounters[random_encounter]

		encounter_to_trigger:setup()
		if encounter_to_trigger.can_reoccur ~= true then
			table.insert(Worldroots.completed_encounters, random_encounter)
			Worldroots.completed_encounters[random_encounter] = true
		end

		self.turns_since_last_marker = 0

	end
end

function Worldroots:lock_buildings()
	local forests_list = self.forests
	local button_world_roots = find_uicomponent(core:get_ui_root(), "world_roots")

	for forest_key, forest in pairs(forests_list) do
		if forest.locked_building ~= nil then
			local building_to_lock = forest.locked_building
			if forest_key ~= self.primary_forest then
				button_world_roots:InterfaceFunction("AddBuildingRecordForRegion", forest.glade_region_key, building_to_lock, false)
			end
			if cm:is_new_game() then
				cm:add_event_restricted_building_record(building_to_lock, "building_lock_rite_of_rebirth");
			end
		end
	end

	--do the primary glade last as we need to signal to the UI that we're done
	local primary_locked_building = forests_list[self.primary_forest].locked_building
	local primary_region = forests_list[self.primary_forest].glade_region_key

	button_world_roots:InterfaceFunction("AddBuildingRecordForRegion", primary_region, primary_locked_building, true)

end

function Worldroots:spawn_ariel(faction_key)
	if faction_key == "wh2_dlc16_wef_drycha" then
		return
	end

	self.ariel_unlocked = true

	core:add_listener(
		"GiveArielAncillaries",
		"UniqueAgentSpawned",
		function(context)
			return context:unique_agent_details():character():get_forename() == "names_name_671478894";
		end,
		function(context)
			
			local agent = context:unique_agent_details():character();

			if agent:is_null_interface() == false and agent:character_subtype("wh2_dlc16_wef_ariel") then
				out("ARIEL SPAWNED!");
				if agent:rank() < 30 then
					local cqi = agent:cqi();
					local faction_cqi = agent:faction():command_queue_index()
					
					cm:replenish_action_points(cm:char_lookup_str(cqi));
					

					cm:callback(function()
						cm:force_add_ancillary(agent, "wh2_dlc16_anc_arcane_item_wand_of_wych_elm", false, true);
						cm:force_add_ancillary(agent, "wh2_dlc16_anc_enchanted_item_acorns_of_the_oak_of_ages", false, true);
						cm:force_add_ancillary(agent, "wh2_dlc16_anc_talisman_berry_wine", false, true);
						cm:force_add_ancillary(agent, "wh2_dlc16_anc_weapon_dart_of_doom", false, true);
						cm:force_add_ancillary(agent, "wh2_dlc16_anc_armour_heartstone_of_athel_loren", false, true);
						
						cm:trigger_incident_with_targets(faction_cqi,"wh2_dlc16_incident_wef_ariel_arrives",0,0,cqi,0,0,0)

						cm:callback(function()
							CampaignUI.ClearSelection();
						end, 0.5);
					end, 0.5);
				end
			end
			
		end,
		false
	);

	if cm:is_processing_battle() then
		cm:progress_on_battle_completed(
			"ariel_spawn_pending_battle_delay",
			function()
				cm:spawn_unique_agent(cm:get_faction(faction_key):command_queue_index(), "wh2_dlc16_wef_ariel", true);
				cm:cancel_progress_on_battle_completed("ariel_spawn_pending_battle_delay")
			end
		)
	else
		cm:spawn_unique_agent(cm:get_faction(faction_key):command_queue_index(), "wh2_dlc16_wef_ariel", true);
	end
	
	
end

function Worldroots:reveal_adjacent_regions_to_glade_owners()
	local forests_list = self.forests
	for forest_ref, forest in pairs(forests_list) do
		local forest_owner_key = cm:get_region(forest.glade_region_key):owning_faction():name()
		for i=1, #forest.adjacent_regions_override do
			cm:make_region_seen_in_shroud(forest_owner_key, forest.adjacent_regions_override[i])
		end

		if forest.additional_regions ~= nil then
			for i=1, #forest.additional_regions do
				cm:make_region_seen_in_shroud(forest_owner_key, forest.additional_regions[i])
			end
		end
	end
end

function Worldroots:unlock_all_rituals_for_humans()
	local primary_player_interface = cm:get_faction(self.primary_player_key)
	local secondary_player_interface = false
	if self.secondary_player_key ~= false then
		secondary_player_interface = cm:get_faction(self.secondary_player_key)
	end
	for k,v in pairs(Worldroots.forests) do
		local ritual = v.rite_key
		cm:unlock_ritual(primary_player_interface, ritual, -1)
		if secondary_player_interface ~= false then
			cm:unlock_ritual(secondary_player_interface, ritual, -1)
		end
	end
end


function Worldroots:set_up_battle_listeners()
	core:add_listener(
		"CharacterPerformsSettlementOccupationDecisionRazeForestBorders",
		"CharacterPerformsSettlementOccupationDecision",
		function(context)
			return context:occupation_decision() == "1265386007" and context:character():faction():is_human()
		end,
		function(context)
			local region_key = context:garrison_residence():region():name()
			
			local forest_to_benefit = self:is_adjacent_to_forest(region_key)
			if forest_to_benefit ~= false then
				local razing_value = self.razing_value
				if context:character():faction():has_technology("tech_dlc16_wef_ancients_cypress") then
					razing_value = self.razing_value + self.razing_tech_bonus
				end
				Worldroots:add_pooled_resource_to_all_wood_elves( forest_to_benefit, "wh2_dlc16_resource_factor_razing_and_battles", razing_value, nil, true)
			end
		end,
	true)



	core:add_listener(
		"WoodElfCharacterCompletedBattle",
		"CharacterCompletedBattle",
		function(context)
			if not context:character():character_type("general") or not context:character():won_battle() then
				return false
			elseif context:character():faction():name() == self.primary_player_key then
				return true
			elseif self.secondary_player_key ~= false and  context:character():faction():name() == self.secondary_player_key then
				return true
			end
		end,
		function(context)
			local character = context:character()

			local region_key = character:region():name()

			local forest_to_benefit = self:is_adjacent_to_forest(region_key)

			if forest_to_benefit == false then 
				forest_to_benefit = self:is_part_of_forest(region_key)
			end

			if forest_to_benefit ~= false then
				local amount_to_gain = self.battle_value
				if character:faction():has_technology("tech_dlc05_2_ellinill") then
					amount_to_gain = amount_to_gain + self.battle_value_tech_bonus
				end
				if character:has_skill(self.battle_value_skill_key) then
					amount_to_gain = amount_to_gain + self.battle_value_skill_bonus
				end
				Worldroots:add_pooled_resource_to_all_wood_elves(forest_to_benefit, "wh2_dlc16_resource_factor_razing_and_battles", amount_to_gain, nil, true)
			end
		end,
	true)

end


function Worldroots:set_up_ritual_listeners()
	core:add_listener(
		"ForestRitualStartedEvent",
		"RitualStartedEvent",
		function(context)
			local ritual_key = context:ritual():ritual_key()
			if self:get_forest_by_rite(ritual_key) ~= false then
				return true
			end
		end,
		function(context)
			local ritual_key = context:ritual():ritual_key()
			local forest = self:get_forest_by_rite(ritual_key)
			self:set_up_ritual(forest)
		end,
		true)

	core:add_listener(
		"ForestRitualCompletedEvent",
		"RitualCompletedEvent",
		function(context)
			local ritual_key = context:ritual():ritual_key()
			if self:get_forest_by_rite(ritual_key) ~= false then
				return true
			end
		end,
		function(context)
			local ritual_key = context:ritual():ritual_key()
			local forest = self:get_forest_by_rite(ritual_key)
			local faction_key = context:performing_faction():name()
			self:complete_ritual(forest, faction_key)
		end,
		true)

	core:add_listener(
		"ScriptEventWEFInvasionMarkerExpired",
		"ScriptEventWEFInvasionMarkerExpired",
		true,
		function(context)
			local marker_ref = context.stored_table.marker_ref
			local instance_ref = context.stored_table.instance_ref
			--we get cheeky here
			--the forest key is part of the marker ref, so we can strip out the standardised marker part to get the forest
			local forest_key = string.gsub(marker_ref,"_invasion_marker_%d","")
			local forest = self:get_forest_by_string(forest_key)

			--use the instance ref to grab the x-y-coords so we know where to spawn
			local x,y = Interactive_Marker_Manager:get_coords_from_instance_ref(instance_ref)

			Worldroots:trigger_invasion(forest, x,y,self.invasion_force_strength)
		end,
		true)
	
		core:add_listener(
		"ScriptEventWEFInvasionMarkerInteraction",
		"ScriptEventWEFInvasionMarkerInteraction",
		true,
		function(context)
			local marker_ref = context.stored_table.marker_ref
			local instance_ref = context.stored_table.instance_ref
			local forest_key = string.gsub(marker_ref,"_invasion_marker_%d","")
			local invasion_level = string.gsub(marker_ref, forest_key.."_","")
			local forest = self:get_forest_by_string(forest_key)
			local interacting_character_cqi = context:character():command_queue_index()
			local interacting_force_cqi = context:character():military_force():command_queue_index()
			local interruption_modifier = self.invasion_force_interruption_modifiers[invasion_level]
			local invasion_faction = forest.invasion_faction

			if cm:get_faction(invasion_faction):is_human() and forest.invasion_faction_alternate ~=nil then
				invasion_faction = forest.invasion_faction_alternate
			end

			Forced_Battle_Manager:trigger_forced_battle_against_generated_ai_army(
				interacting_force_cqi,
				invasion_faction,
				cm:get_faction(invasion_faction):subculture(),
				self.invasion_force_strength + interruption_modifier,
				self.invasion_power_modifier,
				false,
				false,
				true,
				nil,
				nil,
				nil,
				nil,
				self.invasion_force_interrupted_effect_bundle
			)
			

		end,
		true)

		--- variant listener for the intro battles
		core:add_listener(
		"ScriptEventWEFIntroMarkerBattleTriggered",
		"ScriptEventWEFIntroMarkerBattleTriggered",
		true,
		function(context)
			local character = context:character()
			local marker_info = context.stored_table
			local marker_ref = string.gsub(context.stored_table.marker_ref,"_invasion_marker_%d","")
			local encounter = Worldroots.encounters[marker_ref]
			if not is_table(encounter) then
				script_error("Worldroots: Received an event trigger for a marker "..marker_ref.." that cannot be found")
			end
		
			
			if is_function(encounter.on_battle_trigger_callback) then
				encounter:on_battle_trigger_callback(character, marker_info)
			end
		end,
		true)

		core:add_listener(
		"ScriptEventWEFEncounterMarkerBattleTriggered",
		"ScriptEventWEFEncounterMarkerBattleTriggered",
		true,
		function(context)
			local character = context:character()
			local interacting_faction = character:faction():name()
			local marker_info = context.stored_table
			local marker_ref = marker_info.marker_ref
			local encounter = Worldroots.encounters[marker_ref]
			if not is_table(encounter) then
				script_error("Worldroots: Received an event trigger for a marker "..marker_ref.." that cannot be found")
			end

			if encounter.forest ~= nil then
				local forest = Worldroots.forests[encounter.forest]
				forest.unresolved_markers = forest.unresolved_markers -1	
				Worldroots:add_pooled_resource_to_all_wood_elves(forest, "wh2_dlc16_resource_factor_completed_encounters",Worldroots.battle_resolution_value, interacting_faction, true)
			end
			
			if is_function(encounter.on_battle_trigger_callback) then
				encounter:on_battle_trigger_callback(character, marker_info)
			end
		end,
		true)

		

		core:add_listener(
		"ScriptEventWEFEncounterMarkerPeacefullyResolved",
		"ScriptEventWEFEncounterMarkerPeacefullyResolved",
		true,
		function(context)
			local character = context:character()
			local marker_info = context.stored_table
			local marker_ref = marker_info.marker_ref
			local interacting_faction = character:faction():name()
			
			local encounter = Worldroots.encounters[marker_ref]
			if not is_table(encounter) then
				script_error("Worldroots: Received an event trigger for a marker "..marker_ref.." that cannot be found")
			end

			if encounter.forest ~= nil then
				local forest = Worldroots.forests[encounter.forest]
				forest.unresolved_markers = forest.unresolved_markers -1	
				Worldroots:add_pooled_resource_to_all_wood_elves(forest, "wh2_dlc16_resource_factor_completed_encounters",Worldroots.peaceful_resolution_value, interacting_faction, true)
			end

			if is_function(encounter.second_option_callback) then
				encounter:second_option_callback(character, marker_info)
			end
		
		end,
		true)

		core:add_listener(
		"ScriptEventWEFEncounterMarkerExpired",
		"ScriptEventWEFEncounterMarkerExpired",
		true,
		function(context)
			
			local marker_info = context.stored_table
			local marker_ref = string.gsub(context.stored_table.marker_ref,"_invasion_marker_%d","")
			local encounter = Worldroots.encounters[marker_ref]

			if encounter == nil then
				script_error("Worldroots: Received an event trigger for a marker "..marker_ref.." that cannot be found")
			end

			if is_function(encounter.on_expiry_callback) then
				encounter:on_expiry_callback(marker_info)
			end
		end,
		true)
end



----Below are functions for controlling the rituals and invasions
function Worldroots:set_up_ritual(forest)

	forest.rite_active = true

	----apply some vfx
	cm:add_scripted_composite_scene_to_settlement("healing_ritual_"..forest.key,self.ritual_vfx_key,"settlement:"..forest.glade_region_key,0,0, false, true, true)

	--- trigger incident
	local primary_player_faction_cqi = cm:get_faction(self.primary_player_key):command_queue_index()
	
	local region_cqi = cm:get_region(forest.glade_region_key):cqi()

	local incident_key = "wh2_dlc16_incident_wef_ritual_begun_"..forest.key

	---hacky hack as Drycha has a special set of incidents in Gryphon Wood
	if forest.key == "gryphon_wood" and self.primary_player_key == "wh2_dlc16_wef_drycha" then
		incident_key = "wh2_dlc16_incident_wef_ritual_begun_gryphon_wood_drycha"
	end

	cm:trigger_incident_with_targets(primary_player_faction_cqi,incident_key,0,0,0,0,region_cqi,0)

	if self.secondary_player_key ~= false then
		local secondary_player_faction_cqi = cm:get_faction(self.secondary_player_key):command_queue_index()
		cm:trigger_incident_with_targets(secondary_player_faction_cqi,"wh2_dlc16_incident_wef_ritual_begun",0,0,0,0,region_cqi,0)
	end


	--use the marker manager to spawn a series of invasion markers, with an event that fires when they expire
	local marker_base_key = forest.key
	
	local countdown_markers = Interactive_Marker_Manager:create_countdown(marker_base_key,"ScriptEventWEFInvasionMarkerInteraction","ScriptEventWEFInvasionMarkerExpired",{"invasion_marker_3","invasion_marker_2","invasion_marker_1"})
	
	local countdown_marker_stage_1 = countdown_markers[1]
	local countdown_marker_stage_2 = countdown_markers[2]
	local countdown_marker_stage_3 = countdown_markers[3]

	local glade_owner = cm:get_region(forest.glade_region_key):owning_faction():name()

	countdown_marker_stage_1:add_spawn_event_feed_event(
		"event_feed_strings_text_wh2_dlc16_event_feed_string_scripted_event_invasion_title",
		"event_feed_strings_text_wh2_dlc16_event_feed_string_scripted_event_invasion_mustering_primary_detail",
		"event_feed_strings_text_wh2_dlc16_event_feed_string_scripted_event_invasion_mustering_secondary_detail", 
		555,
		glade_owner
		)

	countdown_marker_stage_3:add_spawn_event_feed_event(
		"event_feed_strings_text_wh2_dlc16_event_feed_string_scripted_event_invasion_title",
		"event_feed_strings_text_wh2_dlc16_event_feed_string_scripted_event_invasion_imminent_primary_detail",
		"event_feed_strings_text_wh2_dlc16_event_feed_string_scripted_event_invasion_imminent_secondary_detail", 
		555,
		glade_owner)

	countdown_marker_stage_3:add_despawn_event_feed_event(
		"event_feed_strings_text_wh2_dlc16_event_feed_string_scripted_event_invasion_title",
		"event_feed_strings_text_wh2_dlc16_event_feed_string_scripted_event_invasion_spawned_primary_detail",
		"event_feed_strings_text_wh2_dlc16_event_feed_string_scripted_event_invasion_spawned_secondary_detail", 
		555,
		glade_owner)

	
	local invasion_coord_list = forest.invasion_spawn_coords
	for i = 1, #invasion_coord_list do
		local x = invasion_coord_list[i][1]
		local y = invasion_coord_list[i][2]
		local random_duration = cm:random_number(3,1) 
		if random_duration == 3 then 
			countdown_marker_stage_1:spawn_at_location(x,y, false)
		elseif random_duration == 2 then
			countdown_marker_stage_2:spawn_at_location(x,y, false)
		elseif random_duration == 1 then
			countdown_marker_stage_1:spawn_at_location(x,y,false)
		end
	end


end


function Worldroots:trigger_invasion(forest,x,y,force_size, opt_faction_override, opt_template_override)
	out("triggering invasion of"..forest.glade_region_key)

	local invasion_target = forest.glade_region_key
	local glade_owner_key = cm:get_region(invasion_target):owning_faction():name()
	local invasion_faction = opt_faction_override or forest.invasion_faction

	if cm:get_faction(invasion_faction):is_human() then
		invasion_faction = forest.invasion_faction_alternate
	end
	
	local invasion_army_template = opt_template_override or cm:get_faction(invasion_faction):subculture()

	if opt_template_override == nil and forest.invasion_army_template_override ~= nil then
		invasion_army_template = forest.invasion_army_template_override	
	end

	local unit_list = WH_Random_Army_Generator:generate_random_army(forest.invasion_force_key, invasion_army_template,  force_size, self.invasion_power_modifier, true, false)
	
	if x ~= nil and y ~= nil then
		local invasion_key = forest.rite_key.."_invasion_"..x..y
		local spawn_location_x, spawn_location_y = cm:find_valid_spawn_location_for_character_from_position(glade_owner_key, x, y, true)
		local invasion_object = invasion_manager:new_invasion(invasion_key, invasion_faction,unit_list,{spawn_location_x, spawn_location_y})
		invasion_object:apply_effect(self.invasion_force_effect_bundle, -1);
		invasion_object:set_target("REGION",invasion_target,glade_owner_key)
		invasion_object:add_aggro_radius(25, {glade_owner_key}, 1)
		invasion_object:start_invasion(true,true,false,false)
	end
end




--- all the tidy-up we need to do once a ritual is completed
function Worldroots:complete_ritual(forest, faction_key)
	--clean up vfx
	
	if not cm:is_multiplayer() then
		cm:scroll_camera_with_cutscene_to_settlement(
			5, 
			function()
				cm:remove_scripted_composite_scene("healing_ritual_"..forest.key)			
				cm:add_scripted_composite_scene_to_settlement("ritual_finished",self.ritual_finished_vfx_key,"settlement:"..forest.glade_region_key,0,0, true, true, true)
			end, 
			forest.glade_region_key
		)
	else 
		cm:remove_scripted_composite_scene("healing_ritual_"..forest.key)			
		cm:add_scripted_composite_scene_to_settlement("ritual_finished",self.ritual_finished_vfx_key,"settlement:"..forest.glade_region_key,0,0, true, true, true)
	end


	--kill invasions
	Interactive_Marker_Manager:clear_marker_type(forest.key.."_invasion_marker_1")
	Interactive_Marker_Manager:clear_marker_type(forest.key.."_invasion_marker_2")
	Interactive_Marker_Manager:clear_marker_type(forest.key.."_invasion_marker_3")
	self:kill_invasions(forest)

	--apply rewards
	self:grant_ritual_rewards(forest, faction_key)
	

	forest.rite_active = false
	
end

function Worldroots:kill_invasions(forest)
	local invasion_coord_list = forest.invasion_spawn_coords
	for i=1, #invasion_coord_list do
		local invasion_key = forest.rite_key.."_invasion_"..invasion_coord_list[i][1]..invasion_coord_list[i][2]
		invasion_manager:kill_invasion_by_key(invasion_key)
	end
end

function Worldroots:grant_ritual_rewards(forest, completing_faction_key)
	local region_cqi = cm:get_region(forest.glade_region_key):cqi()

	local completing_player_faction_interface = cm:get_faction(completing_faction_key)
	local completing_player_faction_cqi = completing_player_faction_interface:command_queue_index()

	local non_completing_player_key = false
	local non_completing_player_faction_interface = false
	local non_completing_player_faction_cqi = false

	if Worldroots.secondary_player_key ~= false then

		if completing_faction_key == Worldroots.primary_player_key then
			non_completing_player_key = Worldroots.secondary_player_key
		else
			non_completing_player_key = Worldroots.primary_player_key
		end

		non_completing_player_faction_interface = cm:get_faction(non_completing_player_key)
		non_completing_player_faction_cqi = non_completing_player_faction_interface:command_queue_index()
	end
	
	forest.rite_completed = true

	if forest.locked_building ~= nil then
		local building_to_unlock = forest.locked_building
		cm:remove_event_restricted_building_record(building_to_unlock);
	end

	if forest.custom_ritual_completion_callback ~= nil then 
		forest:custom_ritual_completion_callback()
	end

	if Worldroots.ariel_unlocked == false and cm:is_dlc_flag_enabled("TW_WH2_DLC16_TWILIGHT") then
		Worldroots:spawn_ariel(completing_faction_key)
	end

	cm:lock_ritual(completing_player_faction_interface, forest.rite_key)
	if self.secondary_player_key ~= false then
		cm:lock_ritual(non_completing_player_faction_interface, forest.rite_key)
	end
	
	if forest.rite_key == "wh2_dlc16_ritual_rebirth_athel_loren" and forest.rite_completed == true then
		cm:complete_scripted_mission_objective("wh_main_short_victory", "athel_healed", true);
		cm:complete_scripted_mission_objective("wh_main_long_victory", "athel_healed", true);
	end

	if self:human_wood_elf_controls_glade(forest) and not cm:get_region(forest.glade_region_key):owning_faction():at_war_with(completing_player_faction_interface) then
		local incident_key = "wh2_dlc16_incident_wef_ritual_succeeded_"..forest.key
	
		if forest.key == "gryphon_wood" and self.primary_player_key == "wh2_dlc16_wef_drycha" then
			incident_key = "wh2_dlc16_incident_wef_ritual_succeeded_gryphon_wood_drycha"
		end	
		
		cm:trigger_incident_with_targets(completing_player_faction_cqi,incident_key,0,0,0,0,region_cqi,0)

		if non_completing_player_faction_cqi ~= false then
			cm:trigger_incident_with_targets(non_completing_player_faction_cqi,"wh2_dlc16_incident_wef_ritual_succeeded",0,0,0,0,region_cqi,0)
		end

	else

		cm:trigger_incident_with_targets(completing_player_faction_cqi,"wh2_dlc16_incident_wef_ritual_failed",0,0,0,0,region_cqi,0)
		
		if non_completing_player_faction_cqi ~= false then
			if cm:get_region(forest.glade_region_key):owning_faction():name() == non_completing_player_key then
				cm:trigger_incident_with_targets(non_completing_player_faction_cqi,"wh2_dlc16_incident_wef_ritual_failed_other_pvp",0,0,0,0,region_cqi,0)
			else
				cm:trigger_incident_with_targets(non_completing_player_faction_cqi,"wh2_dlc16_incident_wef_ritual_failed_other",0,0,0,0,region_cqi,0)
			end
		end
	end

	core:trigger_event("ScriptEventForestRitualCompletedEvent")
end

function Worldroots:ritual_ready_check(forest)
	local glade_owner_faction_interface = cm:get_region(forest.glade_region_key):owning_faction()
	local glade_owner_faction_cqi = glade_owner_faction_interface:command_queue_index()
	local healing_amount = glade_owner_faction_interface:pooled_resource(forest.pooled_resource):value()
	local ritual_ready_incident = "wh2_dlc16_incident_wef_ritual_rebirth_available_"..forest.key
	local region_cqi = cm:get_region(forest.glade_region_key):cqi()
	local ritual_resource_required = Worldroots.ritual_resource_required_default

	if is_number(forest.ritual_resource_required_override) then
		ritual_resource_required = forest.ritual_resource_required_override
	end

	if not forest.rite_completed and not forest.rite_active and healing_amount > (ritual_resource_required - 1) then
		cm:trigger_incident_with_targets(glade_owner_faction_cqi,ritual_ready_incident,0,0,0,0,region_cqi,0)	
		core:trigger_event("ScriptEventForestRitualAvailable", forest.glade_region_key);
	end
end

----High-level function for updating pooled resources
function Worldroots:update_worldroots_health()
	out("updating worldroots_health")
	local forests_list = self.forests
	local rites_completed = 0
	for forest_ref, forest in pairs(forests_list) do
		local glade_region_interface = cm:get_region(forest.glade_region_key)
		local primary_building_level = glade_region_interface:settlement():primary_slot():building():building_level()

		--- only go further if a player owns the glade
		if self:human_wood_elf_controls_glade(forest) then

			if not forest.rite_completed and not forest.rite_active and not cm:is_new_game() then
				--n.b. all negative factors need to go first otherwise you can be prevented from maxing out the bar!

				--unresolved markers
				if forest.unresolved_markers > 0 then
					Worldroots:add_pooled_resource_to_all_wood_elves(forest,  "wh2_dlc16_resource_factor_unresolved_encounters", self.unresolved_marker_value*forest.unresolved_markers)
				end
				
				-- corruption
				if glade_region_interface:religion_proportion("wh_main_religion_untainted") < self.corruption_threshold then
					Worldroots:add_pooled_resource_to_all_wood_elves(forest,  "wh2_dlc16_resource_factor_corruption", self.corruption_penalty)
				end

				-- pacification
				local pacification_count,hostile_count = self:check_pacification(forest)
		
				Worldroots:add_pooled_resource_to_all_wood_elves(forest,  "wh2_dlc16_resource_factor_hostile_regions", hostile_count)
				Worldroots:add_pooled_resource_to_all_wood_elves(forest,  "wh2_dlc16_resource_factor_pacified_regions", pacification_count)

				--technology
				if cm:get_faction(self.primary_player_key):has_technology("tech_dlc05_1_cadai") then
					Worldroots:add_pooled_resource_to_all_wood_elves(forest,  "technology", self.technology_value)
				end

				if self.secondary_player_key ~= false and cm:get_faction(self.secondary_player_key):has_technology("tech_dlc05_1_cadai") then
					Worldroots:add_pooled_resource_to_all_wood_elves(forest,  "technology", self.technology_value)
				end

				-- settlement level, applies to Athel Loren only
				if forest.key == "athel_loren" then
					Worldroots:add_pooled_resource_to_all_wood_elves(forest,  "buildings", (primary_building_level-1))
				end

				---buildings
				local building_count, sum_of_primary_settlement_levels = self:count_buildings_in_forest(forest, {"wh_dlc05_wef_spellsingers_2","wh_dlc05_wef_spellsingers_3"})
				local health_to_gain_from_buildings = building_count*self.worldroots_building_value
				Worldroots:add_pooled_resource_to_all_wood_elves(forest,  "buildings", health_to_gain_from_buildings)
				
				local healing_amount = cm:get_faction(Worldroots.primary_player_key):pooled_resource(forest.pooled_resource):value()
			
				--- If the health goes below 0, we bump it back up. This allows us to display transactions that otherwise wouldn't show up if we hard-capped at 0
				if healing_amount < 0 then
					local correction = 0 - healing_amount
					Worldroots:add_pooled_resource_to_all_wood_elves(forest,  "wh2_dlc16_resource_factor_hidden", correction)
				end
				
				self:ritual_ready_check(forest)
			end			
		end

	end
end

function Worldroots:provide_vision_on_all_glades(faction_key)
	local forests_list = self.forests
	for forest_ref, forest in pairs(forests_list) do
		cm:make_region_visible_in_shroud(faction_key, forest.glade_region_key)
	end
end


---adds the pooled resource to all playable wood elf factions who are present in the campaign. 
---Can exclude a specified faction (e.g. they're getting it from a different source and we want to mirror that gain to everyone else
--- If marked as 'in turn gain', will pulse VFX and check to see if ritual is ready
function Worldroots:add_pooled_resource_to_all_wood_elves(forest, factor, amount, excluded_faction_key, in_turn_gain)
	
	if amount > 0 and in_turn_gain then
		if cm:is_processing_battle() then
			cm:progress_on_battle_completed(
				"healing_vfx_pending_battle_delay",
				function()
					self:pulse_heal_vfx_for_forest(forest)
					cm:cancel_progress_on_battle_completed("healing_vfx_pending_battle_delay")
				end
			)
		else
			self:pulse_heal_vfx_for_forest(forest)
		end
	end

	for i = 1, #Worldroots.playable_wood_elf_factions do
		local wood_elf_faction = cm:get_faction(Worldroots.playable_wood_elf_factions[i])
		if wood_elf_faction ~= false  and Worldroots.playable_wood_elf_factions[i] ~= excluded_faction_key then
			cm:faction_add_pooled_resource(Worldroots.playable_wood_elf_factions[i], forest.pooled_resource, factor, amount)
		end
	end

	if in_turn_gain then
		self:ritual_ready_check(forest)
	end
end

function Worldroots:pulse_heal_vfx_for_forest(forest)

	cm:add_scripted_composite_scene_to_settlement("healing_pulse_"..forest.key,self.ritual_vfx_key,"settlement:"..forest.glade_region_key,0,0, false, true, true)
		
	cm:callback(
		function()
			cm:remove_scripted_composite_scene("healing_pulse_"..forest.key)
		end,
		4
	)
end

function Worldroots:remove_encounter(encounter_key)
	local encounter = Worldroots.encounters[encounter_key]
	
	local encounter_marker_object = Interactive_Marker_Manager:get_marker(encounter_key)
	
	if encounter_marker_object ~= false then
		encounter_marker_object:despawn_all()

		if encounter.forest ~= nil then
			Worldroots.forests[encounter.forest].unresolved_markers = Worldroots.forests[encounter.forest].unresolved_markers - 1
		end
	end
end

---------------------
---ONE-OFF EVENTS----
---------------------
function Worldroots:launch_avelorn_invasion()
	local gaean_vale_key = Worldroots.forests["gaean_vale"].glade_region_key
	local gaean_vale_invasion_faction = Worldroots.forests["gaean_vale"].invasion_faction

	local gaean_vale_owner_interface = cm:get_region(gaean_vale_key):owning_faction()
	local gaean_vale_owner_key = gaean_vale_owner_interface:name()


	if gaean_vale_owner_interface:is_null_interface() or gaean_vale_owner_interface:is_human() or gaean_vale_owner_interface:subculture() ~= "wh2_main_sc_hef_high_elves" then
		return
	end

	cm:set_region_abandoned(gaean_vale_key)

	local spawn_x, spawn_y = cm:find_valid_spawn_location_for_character_from_settlement(gaean_vale_invasion_faction, gaean_vale_key, false, true, 3)
	local patrol_point_x, patrol_point_y = cm:find_valid_spawn_location_for_character_from_settlement(gaean_vale_invasion_faction, gaean_vale_key, false, true, 8)
	local unit_list = WH_Random_Army_Generator:generate_random_army("gaean_vale_invasion", "wh_main_sc_chs_chaos", 20, self.invasion_power_modifier, true)
	local gaean_vale_invasion = invasion_manager:new_invasion("gaean_vale_invasion",gaean_vale_invasion_faction, unit_list, {spawn_x, spawn_y}) 

	gaean_vale_invasion:apply_effect("wh_main_bundle_military_upkeep_free_force", -1)
	gaean_vale_invasion:should_maintain_army(true, 0.2)
	gaean_vale_invasion:set_target("PATROL", {{x = spawn_x, y = spawn_y},{x = patrol_point_x, y = patrol_point_y}}, gaean_vale_owner_key)
	gaean_vale_invasion:add_aggro_radius(100, self.playable_wood_elf_factions, 1)
	gaean_vale_invasion:start_invasion(true)

	cm:cai_disable_targeting_against_settlement("settlement:"..gaean_vale_key)


	local player_cqi = cm:get_faction(self.primary_player_key):command_queue_index()
	local gaen_vale_cqi = cm:get_region(gaean_vale_key):cqi()

	cm:trigger_incident_with_targets(player_cqi,"wh2_dlc16_incident_wef_avelorn_invaded", 0,0,0,0,gaen_vale_cqi,0)
	cm:make_region_visible_in_shroud(self.primary_player_key, gaean_vale_key)

end

function Worldroots:end_avelorn_invasion()
	local gaean_vale_key = Worldroots.forests["gaean_vale"].glade_region_key

	local gaean_vale_invasion = invasion_manager:get_invasion("gaean_vale_invasion")
	gaean_vale_invasion:release()
	cm:cai_enable_targeting_against_settlement("settlement:"..gaean_vale_key)
end

----------------------
---Helper functions----
------------------------

---is a specified region adjacent to any forest? if so, return that forest table. If not, return false
function Worldroots:is_adjacent_to_forest(region_key)
	for forest_key, forest in pairs(self.forests) do
		if forest.adjacent_regions_override ~= nil then 
			for i = 1, #forest.adjacent_regions_override do
				if region_key == forest.adjacent_regions_override[i] then
					return forest
				end
			end
		end
	end
	return  false
end

function Worldroots:faction_is_human_wood_elf(faction_to_check)
	if is_string(faction_to_check) then
		faction_to_check = cm:get_faction(faction_to_check);
		if not faction_to_check then
			return false
		end
	end

	return faction_to_check:is_human() and faction_to_check:subculture() == "wh_dlc05_sc_wef_wood_elves"
end

---is a specified region part of any forest? if so, return that forest table. If not, return false
function Worldroots:is_part_of_forest(region_key)
	for forest_key, forest in pairs(self.forests) do
		if forest.glade_region_key == region_key then
			return forest
		end
		if forest.additional_regions ~= nil  then
			for i = 1, #forest.additional_regions do
				if region_key == forest.additional_regions[i] then
					return forest
				end
			end
		end
	end
	return false
end

function Worldroots:generate_valid_encounter_list_for_faction(faction_key)
	local valid_encounters = {}
	for encounter_key,encounter_info in pairs(self.encounters) do
		local is_valid = true
		if encounter_info.faction_filter ~= nil and encounter_info.faction_filter ~= faction_key then
			is_valid = false
		end

		if cm:get_region(encounter_info.region) == false then
			is_valid = false
		end

		local forest = Worldroots:get_forest_by_string(encounter_info.forest)

		if forest ~= false and Worldroots:human_wood_elf_controls_glade(forest) ~= true then
			is_valid = false
		end

		if encounter_info.spawn_turn ~= nil and encounter_info.spawn_turn >= cm:turn_number() and not Worldroots.debug_ignore_marker_cooldown then
			is_valid = false
		end

		if is_function(encounter_info.custom_condition) and not encounter_info:custom_condition() then
			is_valid = false
		end 

		if self.completed_encounters[encounter_key] then
			is_valid = false
		end

		if is_valid then
			table.insert(valid_encounters, encounter_key)
			valid_encounters[encounter_key] = true
		end
	end
	if #valid_encounters >0   then
		return valid_encounters
	else 
		return false
	end
end


function Worldroots:calculate_invasion_power()
	local turn_number = cm:turn_number()
	local turn_mod = 0
	local difficulty_mod = 0
	local rituals_completed = self:count_completed_rituals()
	local ritual_mod = 0

	if turn_number <=10 then
		turn_mod = 1
	elseif turn_number <=20 then
		turn_mod  = 2
	elseif turn_number <=40 then
		turn_mod  = 3
	elseif turn_number <=50 then
		turn_mod  = 4
	elseif turn_number <=75 then
		turn_mod  = 5
	elseif turn_number <100 then
		turn_mod  = 6
	elseif turn_number >=100 then
		turn_mod  = 7
	end

	if cm:get_difficulty() < 2 then
		difficulty_mod = 0
	elseif cm:get_difficulty() >= 3 then
		difficulty_mod = 2
	else 
		difficulty_mod = 1
	end

	if rituals_completed >= 4 then
		ritual_mod = 2
	elseif rituals_completed >= 2 then
		ritual_mod = 1
	end

	Worldroots.invasion_power_modifier = turn_mod + difficulty_mod + ritual_mod

end

function Worldroots:count_completed_rituals()
	local completed_ritual_count = 0
	for k,v in pairs(Worldroots.forests) do
		if v.rite_completed then
			completed_ritual_count = completed_ritual_count + 1
		end
	end
	return completed_ritual_count
end

function Worldroots:human_wood_elf_controls_glade(forest)
	
	local glade_region_interface = cm:get_region(forest.glade_region_key)
	local owning_faction = glade_region_interface:owning_faction()

	if Worldroots:faction_is_human_wood_elf(owning_faction) then	
		return true
	else 
		return false
	end
end

--- allows you to grab a forest by the table key string in case you need to target a specific forest
function Worldroots:get_forest_by_string(string_forest_ref)
	if Worldroots.forests[string_forest_ref] ~= nil then
		return Worldroots.forests[string_forest_ref]
	else 
		return false
	end
end

---find a forest by rite. Used in listeners where we listen for the rite
function Worldroots:get_forest_by_rite(string_rite_key)
	for forest_ref, forest in pairs(Worldroots.forests) do
		if forest.rite_key == string_rite_key then 
			return forest 
		end
	end
	return false
end

---returns the number of a specified building in a forest, as well as the combined number of all the primary settlement levels (this second bit not currently used but might be helpful)
function Worldroots:count_buildings_in_forest(forest, table_of_building_keys)
	local glade_region_interface = cm:get_region(forest.glade_region_key)
	local building_count = 0
	local sum_of_primary_settlement_levels = 0
	for i = 1, #table_of_building_keys do
		local building_to_check = table_of_building_keys[i]
		if glade_region_interface:building_exists(building_to_check) then
			building_count= building_count + 1
		end
	end
	sum_of_primary_settlement_levels = sum_of_primary_settlement_levels + glade_region_interface:settlement():primary_slot():building():building_level()

	--- if we have extra regions to check, do so here
	if forest.additional_regions ~= nil then
		local additional_regions = forest.additional_regions
		for i = 1, #additional_regions do
			local region_interface = cm:get_region(additional_regions[i])

			if region_interface == false or region_interface:is_null_interface() then
				script_error("While checking buildings for "..forest.glade_region_key.." we got a false value or a null interface");
				break
			end

			if Worldroots:faction_is_human_wood_elf(region_interface:owning_faction()) then
				sum_of_primary_settlement_levels = sum_of_primary_settlement_levels + region_interface:settlement():primary_slot():building():building_level()

				for j = 1, #table_of_building_keys do
					local building_to_check = table_of_building_keys[j]
					if region_interface:building_exists(building_to_check)  then
						building_count= building_count + 1
					end
				end
			end
		end
	end

	return building_count, sum_of_primary_settlement_levels
end

function Worldroots:calculate_enemy_force_size_from_player_force(player_character_interface, modifier)
	local enemy_force_size = player_character_interface:military_force():unit_list():num_items()
	if enemy_force_size <5 then
		enemy_force_size = 5
	end
	enemy_force_size = enemy_force_size + modifier
	if enemy_force_size > 19 then
		enemy_force_size = 19
	end

	return enemy_force_size
end

-- returns the number of pacified and hostile regions adjacent to a forest's glade region
function Worldroots:check_pacification(forest)
	local hostile_count = 0
	local pacified_count = 0
	local glade_region_interface = cm:get_region(forest.glade_region_key)
	local glade_owner = glade_region_interface:owning_faction()
	local adjacent_regions = forest.adjacent_regions_override

	for i = 1, #adjacent_regions do
		local adjacent_region

		adjacent_region = cm:get_region(adjacent_regions[i]) -- different count if we're using a script list because Lua!
	

		if adjacent_region == false or adjacent_region:is_null_interface() then
			script_error("While checking adjacent region "..forest.glade_region_key.." we got either a null interface or a false value");
			break
		end

		if adjacent_region:is_abandoned() then
			pacified_count = pacified_count + self.pacified_value
		elseif Worldroots:faction_is_human_wood_elf(adjacent_region:owning_faction()) then
			pacified_count = pacified_count + self.pacified_value
		elseif glade_owner:defensive_allies_with(adjacent_region:owning_faction()) or glade_owner:military_allies_with(adjacent_region:owning_faction()) then
			pacified_count = pacified_count + self.pacified_value
		elseif glade_owner:at_war_with(adjacent_region:owning_faction()) then
			hostile_count = hostile_count + self.hostile_value
		end
	end

	return pacified_count, hostile_count
end


----------------------
------save/load------
-----------------------
cm:add_saving_game_callback(
	function(context)
		for k, v in pairs(Worldroots.forests) do
			cm:save_named_value("Worldroots"..k.."_unresolved_markers", v.unresolved_markers, context)
			cm:save_named_value("Worldroots"..k.."_rite_completed", v.rite_completed, context)
			cm:save_named_value("Worldroots"..k.."rite_active", v.rite_active,context)
		end
		cm:save_named_value("WorldrootsArielSpawned", Worldroots.ariel_unlocked, context)
		cm:save_named_value("WorldrootsCoeddilSpawned", Worldroots.coeddil_unlocked, context)
		cm:save_named_value("WorldrootsCompletedEncounters", Worldroots.completed_encounters, context)
		cm:save_named_value("WorldrootsTurnsSinceLastMarker", Worldroots.turns_since_last_marker, context)
	end
);
cm:add_loading_game_callback(
	function(context)
		if not cm:is_new_game() then
			for k, v in pairs(Worldroots.forests) do
				v.unresolved_markers =	cm:load_named_value("Worldroots"..k.."_unresolved_markers", 0, context)
				v.rite_completed =cm:load_named_value("Worldroots"..k.."_rite_completed", false, context)
				v.rite_active = cm:load_named_value("Worldroots"..k.."rite_active", false, context)
			end
			Worldroots.completed_encounters = cm:load_named_value("WorldrootsCompletedEncounters", {}, context)
			Worldroots.turns_since_last_marker = cm:load_named_value("WorldrootsTurnsSinceLastMarker", 0, context)
			Worldroots.ariel_unlocked = cm:load_named_value("WorldrootsArielSpawned", false, context)
			Worldroots.coeddil_unlocked = cm:load_named_value("WorldrootsCoeddilSpawned", false, context)
		end
	end
);