-----------------------------------------------------------------------------------
-----------------------------------------------------------------------------------
--
--	CAMPAIGN CUSTOM STARTS 
--	This script is to be used when creating a custom start that differs from the start_pos
--	Please use this instead of editing [faction_name]_start.lua - editing that file with start pos changes can only be done in SP as MP changes cause desync issues
--
-----------------------------------------------------------------------------------
-----------------------------------------------------------------------------------
--
-- 	HOW TO USE CAMPAIGN CUSTOM START FUNCTIONS
--
-- 	To use the custom start functions you need to declare which faction you want to change and then start a custom_start table 
--		EXAMPLE: 	{faction = "wh2_dlc12_lzd_cult_of_sotek",	custom_start = { ....} }
--	Inside the custom_start you need to declare an exception list, this list is the set of factions that you DO NOT want these changes to happen for if they are human
--		EXAMPLE:	exceptions = {"wh2_dlc11_def_the_blessed_dread", "wh2_main_skv_clan_pestilens"}, 	changes = {....}
--	If you want the change to happen regardless of any factions being human then set the exceptiosn to nil
--		EXAMPLE:	exceptions = nil,	changes = {....}
-- 	Inside the changes section this is where you actually declare what you want to change when playing as the faction
--		EXAMPLE:	changes = {	{"region_change", "wh2_main_vor_culchan_plains_the_hissing_god", "wh2_main_skv_clan_pestilens"}, {...}, ...	}
--	The first element in all the change lists will be to declare what it is you want to change, after you declare the type of change the rest of the parameters are the required information to make that change
--		EXAMPLE:	changes = {	{"region_change", ...}, {"primary_slot_change", ...}, ...	}
--	Types of changes and how to use them:
--	
--		"region_change"  - This function is used for changing which faction owns a region
--			region_change([region key], [faction key]);
--			region_change(	 string   ,     string   )
--		"primary_slot_change"  - This function is used for changing which building is in the primary slot of a region
--			primary_slot_change([region key], [building key])
--			primary_slot_change(    string  ,  string    )
--		"port_slot_change"  - This function is used for changing which building is in the port slot of a region
--			port_slot_change([region key], [building key])
--			port_slot_change(    string  ,  string    )
--		"secondary_slot_change"  - This function is used for changing which building is in a secondary slot of a region
--			secondary_slot_change([region key], [slot index], [building key])
--			secondary_slot_change(    string  ,  number  ,  string    )
--		"create_army"  - This function is used for creating a new army for a faction
--			create_army([faction key], [list of units / number of units], [region key], [x co-ordinate], [y co-ordinate], [agent subtype], [is faction leader?], [turn number], [list of names](optional))
--			create_army(    string   , 		string    / 	number		,    string   ,      number    ,      number    ,      string    ,        boolean       ,     number   , list of 4 strings(optional))
--		"create_army_for_leader" - This function is used for creating an army using the faction leader of an existing faction as its leader
--			create_army_for_faction_leader([faction key], [region key], [x co-ordinate], [y co-ordinate], [list of units / number of units])
--			create_army_for_faction_leader(    string   ,    string   ,      number    ,      number    , 		string   / 	 	number	   )
--		"teleport_character"  - This function is used for teleporting a character from a defined faction to a new position
--			teleport_character([faction key], [current x co-ordinate], [current y co-ordinate], [target x co-ordinate], [target y co-ordinate], [is a general?])
--			teleport_character(    string   ,   	   number    	 ,   	   number   	  ,    		  number  	  ,  	 	   number     , 	boolean	   )
--		"add_units"  - This function is used for adding more units to an existing army
--			add_units_to_army([faction key], [x co-ordinate], [y co-ordinate], [list of units / number of units])
--			add_units_to_army(    string   ,      number    ,      number    , 		string    / 	number		)
--		"force_diplomacy"  - This function is for forcing a faction to make war or peace with another faction
--			force_diplomacy_change([source faction key], [target faction key], ["war" / "peace"])
--			force_diplomacy_change(   	 string   	   ,     	string   	 , 		string		)
--		"block_diplomacy"  - This function is used to block diplomacy between a source and a target faction
--			force_diplomacy_change([source faction key], [target faction key], [	can offer	],[	can accept]	)
--			force_diplomacy_change(   	 string   	   ,     	string   	 , 		bool,			bool	   )
--		"abandon_region"  - This function is used for abandoning a target region
--			abandon_region([region key])
--			abandon_region(   string   )
--		"kill_faction"  - This function is used for killing all target factions armies and abandoning any regions
--			kill_faction([faction key])
--			kill_faction(   string   )
--		"char_effect_bundle" - This function applies an effect bundle to a target character using the x and y coordinates to make sure the correct character is selected
--			apply_effect_bundle_character([faction key], [x co-ordinate], [y co-ordinate], [effect bundle], [bundle length])
--			apply_effect_bundle_character(    string   ,      number    ,      number    , 		string	  , 	number	   )
--		"add_development_points" - This function adds development points to a targeted region
--			add_development_points([region],[number_points])
--			add_development_points(string, number)
--
-----------------------------------------------------------------------------------
-----------------------------------------------------------------------------------

--Vortex Changes
local vor_custom_start_factions = {
	--------------------
	---- TEHENHAUIN ----
	--------------------
	{faction = "wh2_dlc12_lzd_cult_of_sotek",
		custom_start = {
			{
				exceptions = {"wh2_dlc11_def_the_blessed_dread", "wh2_main_skv_clan_pestilens","wh2_main_lzd_itza"},
				changes = {
					{"region_change", "wh2_main_vor_culchan_plains_the_hissing_god", "wh2_main_skv_clan_pestilens"},
					{"region_change", "wh2_main_vor_northern_great_jungle_quetza", "wh2_main_skv_clan_pestilens"},
					{"region_change", "wh2_main_vor_northern_great_jungle_chaqua", "wh2_main_skv_clan_pestilens"},
					{"primary_slot_change", "wh2_main_vor_culchan_plains_the_southern_sentinels", "wh2_main_lzd_settlement_minor_3"},
					{"secondary_slot_change", "wh2_main_vor_culchan_plains_the_southern_sentinels", 0, "wh2_main_lzd_skinks_2"},
					{"secondary_slot_change", "wh2_main_vor_culchan_plains_the_southern_sentinels", 1, "wh2_main_lzd_defence_minor_1"},
					{"primary_slot_change", "wh2_main_vor_culchan_plains_the_hissing_god", "wh2_main_skv_settlement_minor_1"},
					{"create_army", clan_fester_faction_str, "wh2_main_skv_inf_clanrats_0,wh2_main_skv_inf_clanrats_0,wh2_main_skv_inf_skavenslaves_0,wh2_main_skv_inf_skavenslaves_0,wh2_main_skv_inf_skavenslaves_0,wh2_main_skv_inf_plague_monks,wh2_main_skv_inf_plague_monks,wh2_main_skv_mon_rat_ogres,wh2_main_skv_mon_rat_ogres,wh2_main_skv_inf_gutter_runners_0,wh2_main_skv_inf_gutter_runners_0", 
						"wh2_main_vor_northern_great_jungle_chaqua", 185, 230, "wh2_main_skv_warlord", false, 1, {"names_name_2147360586", "", "", ""}
					}
				}
			},	
			{
				exceptions = {"wh2_dlc11_def_the_blessed_dread"},
				changes = {
					{"force_diplomacy", "wh2_dlc11_def_the_blessed_dread", "wh2_main_hef_citadel_of_dusk", "war"}
				}
			},
			{
				exceptions = {"wh2_main_lzd_itza"},
				changes = {
					{"teleport_character", clan_fester_faction_str, 190, 209, 190, 58, true},
					{"add_units", clan_fester_faction_str, 190, 209, {"wh2_main_skv_inf_plague_monks","wh2_main_skv_inf_plague_monks","wh2_main_skv_mon_rat_ogres","wh2_main_skv_mon_rat_ogres"}}
				}
			},
			{
				exceptions = nil,
				changes = {
					{"region_change", "wh2_main_vor_copper_desert_the_golden_colossus", clan_fester_faction_str},
					{"region_change", "wh2_main_vor_copper_desert_the_dust_gate", clan_fester_faction_str},
					{"region_change", "wh2_main_vor_coasts_of_the_lustrian_gulf_the_night_forest", clan_fester_faction_str},
					{"primary_slot_change", "wh2_main_vor_coasts_of_the_lustrian_gulf_the_night_forest", "wh2_main_skv_settlement_minor_2"},
					{"secondary_slot_change", "wh2_main_vor_coasts_of_the_lustrian_gulf_the_night_forest", 0, "wh2_main_skv_clanrats_1"},
					{"secondary_slot_change", "wh2_main_vor_coasts_of_the_lustrian_gulf_the_night_forest", 1, "wh2_main_skv_farm_1"},
					{"secondary_slot_change", "wh2_main_vor_copper_desert_the_dust_gate", 0, "wh2_main_skv_defence_minor_1"},
					{"secondary_slot_change", "wh2_main_vor_copper_desert_the_dust_gate", 1, "wh2_main_skv_farm_2"},
					{"primary_slot_change", "wh2_main_vor_copper_desert_the_golden_colossus", "wh2_main_skv_settlement_minor_3"},
					{"secondary_slot_change", "wh2_main_vor_copper_desert_the_golden_colossus", 0, "wh2_main_skv_clanrats_3"},
					{"secondary_slot_change", "wh2_main_vor_copper_desert_the_golden_colossus", 1, "wh2_main_skv_defence_minor_2"},
					{"secondary_slot_change", "wh2_main_vor_copper_desert_the_golden_colossus", 2, "wh2_main_skv_engineers_1"},
					{"primary_slot_change", "wh2_main_vor_the_capes_citadel_of_dusk", "wh2_main_special_settlement_colony_major_hef_1"},
					{"secondary_slot_change", "wh2_main_vor_the_capes_citadel_of_dusk", 0, "wh2_main_hef_barracks_1"},
					{"primary_slot_change", "wh2_main_vor_the_capes_tip_of_lustria", "wh2_main_special_settlement_colony_minor_hef_1"},
					{"primary_slot_change", "wh2_main_vor_copper_desert_the_forgotten_isles", "wh2_dlc09_tmb_settlement_major_coast_1"},
					{"create_army", clan_fester_faction_str, "wh2_main_skv_inf_clanrats_0,wh2_main_skv_inf_skavenslaves_0,wh2_main_skv_inf_clanrats_1,wh2_main_skv_inf_clanrats_1,wh2_main_skv_inf_clanrats_1,wh2_main_skv_inf_skavenslave_slingers_0,wh2_main_skv_inf_skavenslave_slingers_0,wh2_main_skv_inf_plague_monks", 
						"wh2_main_vor_coasts_of_the_lustrian_gulf_the_night_forest", 234, 52, "wh2_main_skv_warlord", false, 1, {"names_name_1178399311", "", "", ""}
					},
					{"create_army", clan_fester_faction_str, "wh2_main_skv_inf_clanrats_0,wh2_main_skv_inf_clanrats_0,wh2_main_skv_inf_skavenslaves_0,wh2_main_skv_inf_skavenslaves_0,wh2_main_skv_inf_skavenslaves_0,wh2_main_skv_inf_plague_monks,wh2_main_skv_inf_plague_monks,wh2_main_skv_inf_gutter_runners_0,wh2_main_skv_inf_gutter_runners_0,wh2_main_skv_inf_skavenslave_slingers_0,wh2_main_skv_mon_rat_ogres", 
						"wh2_main_vor_copper_desert_the_golden_colossus", 144, 82, "wh2_main_skv_grey_seer_plague", false, 1
					},
					{"create_army", clan_fester_faction_str, "wh2_main_skv_inf_stormvermin_0,wh2_main_skv_inf_stormvermin_1,wh2_main_skv_inf_clanrats_0,wh2_main_skv_inf_plague_monks,wh2_main_skv_inf_gutter_runners_0,wh2_main_skv_inf_gutter_runners_0,wh2_dlc12_skv_inf_ratling_gun_0,wh2_main_skv_mon_rat_ogres,wh2_main_skv_art_plagueclaw_catapult", 
						"wh2_main_vor_copper_desert_the_golden_colossus", 144, 82, "wh2_main_skv_grey_seer_plague", false, 8, {"names_name_123161244", "", "", ""}
					}					
				}
			}
		}
	},
	--------------------
	----- TIKTAQ'TO ----
	--------------------
	{faction = "wh2_main_lzd_tlaqua", 
		custom_start = {
			{
				exceptions = nil,
				changes = {
					{"add_units", "wh2_main_emp_sudenburg", 552, 240, {"wh_main_emp_inf_spearmen_1","wh_main_emp_inf_swordsmen","wh_main_emp_art_mortar"}},
					{"create_army", "wh2_main_emp_sudenburg", "wh_main_emp_inf_swordsmen,wh_main_emp_inf_swordsmen,wh_main_emp_inf_swordsmen,wh_main_emp_inf_spearmen_0,wh_main_emp_inf_spearmen_0,wh_main_emp_inf_crossbowmen,wh_main_emp_inf_handgunners", 
						"wh2_main_vor_land_of_the_dervishes_elven_ruins", 511, 201, "emp_lord", false, 1, {"names_name_2147355015", "", "names_name_2147352770", ""}
					},
					{"region_change", "wh2_main_vor_western_jungles_deaths-head_monoliths", "wh2_main_emp_sudenburg"},
					{"region_change", "wh2_main_vor_land_of_the_dervishes_elven_ruins", "wh2_main_emp_sudenburg"},
					{"primary_slot_change", "wh2_main_vor_western_jungles_deaths-head_monoliths", "wh_main_emp_settlement_minor_2_coast"},
					{"port_slot_change", "wh2_main_vor_western_jungles_deaths-head_monoliths", "wh_main_teb_port_1"},
					{"secondary_slot_change", "wh2_main_vor_western_jungles_deaths-head_monoliths", 1, "wh_main_emp_barracks_1"},
					{"primary_slot_change", "wh2_main_vor_land_of_the_dervishes_elven_ruins", "wh2_main_special_settlement_colony_minor_other_2"},
					{"port_slot_change", "wh2_main_vor_land_of_the_dervishes_elven_ruins", "wh_main_teb_port_1"},
					{"secondary_slot_change", "wh2_main_vor_land_of_the_dervishes_elven_ruins", 0, "wh_main_emp_stables_1"},
					{"create_army", clan_fester_faction_str, "wh2_main_skv_inf_stormvermin_0,wh2_main_skv_inf_stormvermin_1,wh2_main_skv_inf_clanrats_0,wh2_main_skv_inf_plague_monks,wh2_main_skv_inf_gutter_runners_0,wh2_main_skv_inf_gutter_runners_0,wh2_dlc12_skv_inf_ratling_gun_0,wh2_main_skv_mon_rat_ogres,wh2_main_skv_art_plagueclaw_catapult", 
						"wh2_main_vor_copper_desert_the_golden_colossus", 144, 82, "wh2_main_skv_grey_seer_plague", false, 8, {"names_name_123161244", "", "", ""}
					}	
				}
			}
		}
	},
	--------------------
	------- IKIT -------
	--------------------
	{faction = "wh2_main_skv_clan_skyre", 
		custom_start = {
			{
				exceptions = nil,
				changes = {
					{"add_units", "wh2_dlc11_cst_vampire_coast_rebels", 235, 316, {"wh2_dlc11_cst_mon_bloated_corpse_0","wh2_dlc11_cst_mon_bloated_corpse_0"}},
					{"char_effect_bundle", "wh2_dlc11_cst_vampire_coast_rebels", 302, 204, "wh2_main_bundle_scripted_prevent_ambush", 2},
					{"region_change", "wh2_main_vor_the_vampire_coast_the_blood_swamps", "wh2_dlc11_cst_vampire_coast_rebels"},
					{"region_change", "wh2_main_vor_mosquito_swamps_tlax", xlanhuapec_faction_str},
					{"region_change", "wh2_main_vor_the_vampire_coast_pox_marsh", xlanhuapec_faction_str},
					{"teleport_character", "wh2_dlc11_cst_vampire_coast_rebels", 235, 316, 302, 204, true},
					{"primary_slot_change", "wh2_main_vor_the_vampire_coast_the_blood_swamps", "wh2_dlc11_vampirecoast_settlement_minor_coast_2"},
					{"port_slot_change", "wh2_main_vor_the_vampire_coast_the_blood_swamps", "wh2_dlc11_vampirecoast_port_1"},
					{"secondary_slot_change", "wh2_main_vor_the_vampire_coast_the_blood_swamps", 0, "wh2_dlc11_vampirecoast_support_artillery_1"}
				}
			},
			{
				exceptions = {"wh2_main_lzd_itza"},
				changes = {
					
					{"teleport_character", clan_fester_faction_str, 186, 209, 145, 265, true},
					{"region_change", "wh2_main_vor_river_qurveza_mouth_of_qurveza", "wh2_dlc11_cst_vampire_coast_rebels"},
					{"region_change", "wh2_main_vor_northern_great_jungle_quetza", "wh2_main_lzd_itza"},
					{"region_change", "wh2_main_vor_northern_great_jungle_quittax", "wh2_main_lzd_itza"},
					{"region_change", "wh2_main_vor_southern_great_jungle_xhotl", "wh2_main_lzd_southern_sentinels"},
					{"region_change", "wh2_main_vor_the_creeping_jungle_tlanxla", "wh2_dlc12_skv_clan_fester"},
					{"primary_slot_change", "wh2_main_vor_river_qurveza_mouth_of_qurveza", "wh2_dlc11_vampirecoast_settlement_minor_coast_2"},
					{"port_slot_change", "wh2_main_vor_river_qurveza_mouth_of_qurveza", "wh2_dlc11_vampirecoast_port_1"},
					{"secondary_slot_change", "wh2_main_vor_river_qurveza_mouth_of_qurveza", 0, "wh2_dlc11_vampirecoast_military_barracks_1"},
					{"primary_slot_change", "wh2_main_vor_northern_great_jungle_quittax", "wh2_main_lzd_settlement_minor_1"},
					{"secondary_slot_change", "wh2_main_vor_northern_great_jungle_quittax", 0, "wh2_main_lzd_industry_1"},
					{"primary_slot_change", "wh2_main_vor_southern_great_jungle_xhotl", "wh2_main_lzd_settlement_minor_1"},
					{"secondary_slot_change", "wh2_main_vor_southern_great_jungle_xhotl", 0, "wh2_main_lzd_saurus_1"},
					{"primary_slot_change", "wh2_main_vor_the_creeping_jungle_tlanxla", "wh2_main_skv_settlement_minor_1"},
					{"secondary_slot_change", "wh2_main_vor_the_creeping_jungle_tlanxla", 0, "wh2_main_skv_clanrats_1"}
				}
			}
		}
	},
	--------------------
	------ LOKHIR ------
	--------------------
	{faction = "wh2_dlc11_def_the_blessed_dread", 
		custom_start = {
			{
				exceptions = {"wh2_dlc12_lzd_cult_of_sotek", "wh2_main_skv_clan_pestilens"},
				changes = {
					{"add_units", "wh2_main_lzd_southern_sentinels", 274, 77, {"wh2_main_lzd_inf_skink_skirmishers_0","wh2_main_lzd_inf_skink_skirmishers_0","wh2_main_lzd_inf_saurus_warriors_0","wh2_main_lzd_inf_saurus_warriors_0"}},
					{"teleport_character", "wh2_main_lzd_southern_sentinels", 274, 77, 244, 83, true},
					{"region_change", "wh2_main_vor_the_lost_valleys_the_sentinel_of_time", "wh2_main_lzd_southern_sentinels"}
				}
			}
		}
	},
	--------------------
	---- ALITH ANAR ----
	--------------------
	{faction = "wh2_main_hef_nagarythe", 
		custom_start = {
			{
				exceptions = {"wh2_dlc09_skv_clan_rictus", "wh2_main_def_har_ganeth"},
				changes = {
					{"create_army_for_leader", "wh2_main_def_karond_kar", "wh2_main_vor_the_broken_land_blacklight_tower", 315, 635, "wh2_main_def_inf_dreadspears_0,wh2_main_def_inf_dreadspears_0,wh2_main_def_inf_black_ark_corsairs_0,wh2_main_def_inf_bleakswords_0,wh2_main_def_inf_bleakswords_0,wh2_main_def_inf_black_ark_corsairs_1,wh2_main_def_inf_black_ark_corsairs_1"},
					{"teleport_character", "wh2_main_def_the_forgebound", 317, 636, 311, 605, true},
					{"region_change", "wh2_main_vor_the_broken_land_blacklight_tower", "wh2_main_def_karond_kar"}
				}
			}
		}
	},
	--------------------
	----- GOR-ROK ------
	--------------------
	{faction = "wh2_main_lzd_itza", 
		custom_start = {
			{
				exceptions = {"wh2_dlc12_lzd_cult_of_sotek", "wh2_main_skv_clan_pestilens", "wh2_dlc11_def_the_blessed_dread", "wh2_main_skv_clan_skyre","wh2_dlc13_lzd_spirits_of_the_jungle"},
				changes = {
					{"teleport_character", "wh2_dlc12_skv_clan_fester", 190, 209, 197, 198, true},
					{"teleport_character", "wh2_main_lzd_southern_sentinels", 271, 73, 193, 117, true},
					{"teleport_character", "wh2_dlc13_lzd_spirits_of_the_jungle", 150, 233, 230, 267, true},
					{"region_change", "wh2_main_vor_southern_great_jungle_xhotl", "wh2_main_lzd_southern_sentinels"},
					{"region_change", "wh2_main_vor_culchan_plains_the_southern_sentinels", "wh2_dlc11_def_the_blessed_dread"},
					{"region_change", "wh2_main_vor_northern_great_jungle_quittax", "wh2_dlc12_skv_clan_fester"},					
					{"primary_slot_change", "wh2_main_vor_southern_great_jungle_xhotl", "wh2_main_lzd_settlement_minor_1"},
					{"secondary_slot_change", "wh2_main_vor_southern_great_jungle_xhotl", 0, "wh2_main_lzd_skinks_1"},
					{"primary_slot_change", "wh2_main_vor_northern_great_jungle_quittax", "wh2_main_skv_settlement_minor_2"},
					{"secondary_slot_change", "wh2_main_vor_northern_great_jungle_quittax", 0, "wh2_main_skv_clanrats_2"},
					{"secondary_slot_change", "wh2_main_vor_northern_great_jungle_quittax", 1, "wh2_main_skv_defence_minor_1"},
					{"secondary_slot_change", "wh2_main_vor_northern_great_jungle_chaqua", 0, "wh2_main_skv_resource_wood_1"}
				}
			}
		}
	},
	--------------------
	----  WULFHART  ----
	--------------------
	{faction = "wh2_dlc13_emp_the_huntmarshals_expedition",
		custom_start = {
			{
				exceptions = {"wh2_dlc13_lzd_spirits_of_the_jungle"},
				changes = {
					{"create_army", "wh2_main_lzd_tlaxtlan", "wh2_main_lzd_inf_skink_cohort_1,wh2_main_lzd_inf_skink_cohort_0,wh2_main_lzd_inf_skink_cohort_0,wh2_main_lzd_inf_saurus_warriors_0,wh2_main_lzd_mon_bastiladon_0", 
						"wh2_main_vor_scorpion_coast_chotec", 191, 320, "wh2_main_lzd_saurus_old_blood", false, 1
					},
					{"region_change", "wh2_main_vor_scorpion_coast_chotec", "wh2_main_lzd_tlaxtlan"}		
				}
			}
		}
	},
	--------------------
	------  NAKAI  -----
	--------------------
	{faction = "wh2_dlc13_lzd_spirits_of_the_jungle",
		custom_start = {
			{
				exceptions = {"wh2_dlc13_emp_the_huntmarshals_expedition"},
				changes = {
					{"region_change", "wh2_main_vor_northern_spine_of_sotek_monument_of_izzatal", "wh2_dlc12_skv_clan_mange"},	
					{"primary_slot_change", "wh2_main_vor_northern_spine_of_sotek_monument_of_izzatal", "wh2_main_skv_settlement_minor_2"},
					{"secondary_slot_change", "wh2_main_vor_northern_spine_of_sotek_monument_of_izzatal", 0, "wh2_main_skv_clanrats_1"},
					{"secondary_slot_change", "wh2_main_vor_northern_spine_of_sotek_monument_of_izzatal", 1, "wh2_main_skv_farm_1"},
					{"region_change", "wh2_main_vor_the_forbidden_jungle_chamber_of_visions", "wh2_dlc13_emp_the_huntmarshals_expedition"},
					{"primary_slot_change", "wh2_main_vor_the_forbidden_jungle_chamber_of_visions", "wh_main_emp_settlement_minor_2"},
					{"secondary_slot_change", "wh2_main_vor_the_forbidden_jungle_chamber_of_visions", 0, "wh_main_emp_barracks_2"},
					{"secondary_slot_change", "wh2_main_vor_the_forbidden_jungle_chamber_of_visions", 1, "wh_main_emp_industry_basic_2"},
					{"region_change", "wh2_main_vor_scorpion_coast_chotec", "wh2_dlc13_emp_the_huntmarshals_expedition"},
					{"primary_slot_change", "wh2_main_vor_scorpion_coast_chotec", "wh_main_emp_settlement_minor_2_coast"},
					{"port_slot_change", "wh2_main_vor_scorpion_coast_chotec", "wh_main_emp_port_1"},
					{"secondary_slot_change", "wh2_main_vor_scorpion_coast_chotec", 0, "wh_main_emp_industry_basic_2"},
					{"region_change", "wh2_main_vor_jungle_of_pahualaxa_floating_pyramid", "wh2_dlc13_emp_the_huntmarshals_expedition"},
					{"primary_slot_change", "wh2_main_vor_jungle_of_pahualaxa_floating_pyramid", "wh_main_emp_settlement_minor_2"},
					{"secondary_slot_change", "wh2_main_vor_jungle_of_pahualaxa_floating_pyramid", 0, "wh_main_emp_barracks_2"},
					{"secondary_slot_change", "wh2_main_vor_jungle_of_pahualaxa_floating_pyramid", 1, "wh_main_emp_industry_basic_2"},
					{"region_change", "wh2_main_vor_jungle_of_pahualaxa_monument_of_the_moon", "wh2_dlc13_emp_the_huntmarshals_expedition"},
					{"primary_slot_change", "wh2_main_vor_jungle_of_pahualaxa_monument_of_the_moon", "wh_main_emp_settlement_minor_2_coast"},
					{"port_slot_change", "wh2_main_vor_jungle_of_pahualaxa_monument_of_the_moon", "wh_main_emp_port_1"},
					{"secondary_slot_change", "wh2_main_vor_jungle_of_pahualaxa_monument_of_the_moon", 0, "wh_main_emp_garrison_1"},
					{"region_change", "wh2_main_vor_jungle_of_pahualaxa_pahuax", "wh2_dlc13_emp_the_huntmarshals_expedition"},
					{"primary_slot_change", "wh2_main_vor_jungle_of_pahualaxa_pahuax", "wh_main_emp_settlement_major_3"},
					{"secondary_slot_change", "wh2_main_vor_jungle_of_pahualaxa_pahuax", 0, "wh_main_emp_walls_1"},
					{"secondary_slot_change", "wh2_main_vor_jungle_of_pahualaxa_pahuax", 1, "wh_main_emp_stables_1"},
					{"secondary_slot_change", "wh2_main_vor_jungle_of_pahualaxa_pahuax", 2, "wh_main_emp_smiths_1"},
					{"region_change", "wh2_main_vor_jungle_of_pahualaxa_the_high_sentinel", "wh2_dlc13_emp_the_huntmarshals_expedition"},
					{"primary_slot_change", "wh2_main_vor_jungle_of_pahualaxa_the_high_sentinel", "wh_main_emp_settlement_minor_2"},
					{"secondary_slot_change", "wh2_main_vor_jungle_of_pahualaxa_the_high_sentinel", 0, "wh_main_emp_farm_basic_2"},
					{"secondary_slot_change", "wh2_main_vor_jungle_of_pahualaxa_the_high_sentinel", 1, "wh_main_emp_garrison_1"},
					{"region_change", "wh2_main_vor_mosquito_swamps_tlax", "wh2_dlc13_emp_the_huntmarshals_expedition"},
					{"primary_slot_change", "wh2_main_vor_mosquito_swamps_tlax", "wh_main_emp_settlement_minor_2"},
					{"secondary_slot_change", "wh2_main_vor_mosquito_swamps_tlax", 0, "wh_main_emp_barracks_2"},
					{"secondary_slot_change", "wh2_main_vor_mosquito_swamps_tlax", 1, "wh_main_emp_garrison_1"},
					{"region_change", "wh2_main_vor_river_qurveza_axlotl", "wh2_dlc13_emp_the_huntmarshals_expedition"},
					{"primary_slot_change", "wh2_main_vor_river_qurveza_axlotl", "wh_main_emp_settlement_major_3"},
					{"secondary_slot_change", "wh2_main_vor_river_qurveza_axlotl", 0, "wh_main_emp_barracks_2"},
					{"secondary_slot_change", "wh2_main_vor_river_qurveza_axlotl", 1, "wh_main_emp_farm_basic_2"},
					{"secondary_slot_change", "wh2_main_vor_river_qurveza_axlotl", 2, "wh_main_emp_industry_basic_2"},
					{"region_change", "wh2_main_vor_river_qurveza_mouth_of_qurveza", "wh2_dlc13_emp_the_huntmarshals_expedition"},
					{"primary_slot_change", "wh2_main_vor_river_qurveza_mouth_of_qurveza", "wh_main_emp_settlement_minor_2_coast"},
					{"port_slot_change", "wh2_main_vor_river_qurveza_mouth_of_qurveza", "wh_main_emp_port_1"},
					{"secondary_slot_change", "wh2_main_vor_river_qurveza_mouth_of_qurveza", 0, "wh_main_emp_garrison_1"},
					{"teleport_character", "wh2_main_def_blood_hall_coven", 99, 149, 42, 180, true},
					{"teleport_character", "wh2_dlc11_cst_vampire_coast_rebels", 240, 314, 271, 317, true},
					--Jorek Grimm
					{"create_army", "wh2_dlc13_emp_the_huntmarshals_expedition", "wh_main_emp_art_great_cannon,wh_main_emp_inf_handgunners,wh_main_emp_inf_handgunners,wh_main_emp_inf_handgunners,wh2_dlc13_emp_veh_war_wagon_0,wh_main_emp_inf_swordsmen,wh_main_emp_inf_swordsmen,wh_main_emp_inf_swordsmen,wh_main_emp_inf_swordsmen", 
						"wh2_main_vor_the_forbidden_jungle_chamber_of_visions", 100, 148, "wh2_dlc13_emp_cha_huntsmarshal_0", false, 1
					},
					--Doctor Hertwig van Hal
					{"create_army", "wh2_dlc13_emp_the_huntmarshals_expedition", "wh_dlc04_emp_inf_flagellants_0,wh_dlc04_emp_inf_flagellants_0,wh_dlc04_emp_inf_flagellants_0,wh2_dlc13_emp_inf_archers_0,wh2_dlc13_emp_inf_archers_0,wh_main_emp_inf_swordsmen,wh_main_emp_inf_swordsmen,wh_main_emp_inf_halberdiers,wh_main_emp_cav_empire_knights,wh_main_emp_cav_empire_knights,wh_main_emp_art_mortar", 
						"wh2_main_vor_river_qurveza_mouth_of_qurveza", 233, 195, "dlc04_emp_arch_lector", false, 1
					},
					--Rodrik L'Anguille
					{"create_army", "wh2_dlc13_emp_the_huntmarshals_expedition", "wh_main_emp_inf_greatswords,wh_main_emp_inf_greatswords,wh_main_emp_inf_greatswords,wh_main_emp_inf_halberdiers,wh_main_emp_inf_halberdiers,wh2_dlc13_emp_inf_archers_0,wh2_dlc13_emp_inf_archers_0,wh_main_emp_cav_empire_knights,wh_main_emp_cav_empire_knights,wh_main_emp_art_mortar,wh_main_emp_cav_reiksguard,wh_main_emp_cav_reiksguard,wh_main_emp_cav_pistoliers_1,wh_main_emp_cav_pistoliers_1", 
						"wh2_main_vor_scorpion_coast_chotec", 171, 319, "emp_lord", false, 1
					},
					--Kalara of Wydrioth
					{"create_army", "wh2_dlc13_emp_the_huntmarshals_expedition", "wh_main_emp_inf_greatswords,wh_main_emp_inf_greatswords,wh_main_emp_inf_greatswords,wh_main_emp_cav_reiksguard,wh_main_emp_cav_reiksguard,wh_main_emp_art_great_cannon,wh_main_emp_art_great_cannon,wh_main_emp_inf_spearmen_1,wh_main_emp_inf_spearmen_1,wh_main_emp_inf_spearmen_1,wh2_dlc13_emp_inf_huntsmen_0,wh2_dlc13_emp_inf_huntsmen_0,wh2_dlc13_emp_inf_huntsmen_0,wh2_dlc13_emp_inf_huntsmen_0,wh_main_emp_cav_outriders_0,wh_main_emp_cav_outriders_0,wh_main_emp_cav_outriders_0,wh_main_emp_cav_outriders_1", 
						"wh2_main_vor_jungle_of_pahualaxa_floating_pyramid", 99, 307, "wh2_dlc13_emp_cha_huntsmarshal_0", false, 1
					}
				}
			}
		}
	},
	--------------------
	------ REPANSE -----
	--------------------
	{faction = "wh2_dlc14_brt_chevaliers_de_lyonesse",
		custom_start = {
			{
				exceptions = nil,
				changes = {
					{"region_change", "wh2_main_vor_coast_of_araby_al_haikk", "wh2_main_vmp_strygos_empire"},
					{"primary_slot_change", "wh2_main_vor_coast_of_araby_al_haikk", "wh_main_vmp_settlement_major_2_coast"},
					{"port_slot_change", "wh2_main_vor_coast_of_araby_al_haikk", "wh_main_vmp_port_1"},
					{"secondary_slot_change", "wh2_main_vor_coast_of_araby_al_haikk", 0, "wh_main_vmp_bindingcircle_1"},
					{"region_change", "wh2_main_vor_coast_of_araby_martek", "wh2_main_vmp_strygos_empire"},
					{"primary_slot_change", "wh2_main_vor_coast_of_araby_martek", "wh_main_vmp_settlement_minor_1"},
					{"secondary_slot_change", "wh2_main_vor_coast_of_araby_martek", 0, "wh_main_vmp_forest_1"},
					{"region_change", "wh2_main_vor_ash_river_springs_of_eternal_life", "wh2_dlc09_tmb_numas"},
					{"force_diplomacy", "wh2_dlc14_brt_chevaliers_de_lyonesse", "wh2_main_vmp_strygos_empire", "war"},
					{"teleport_character", "wh2_main_brt_knights_of_the_flame", 480, 338, 440, 322, true},
					{"teleport_character", "wh2_dlc14_brt_chevaliers_de_lyonesse", 549, 333, 481, 334, true},
					{"teleport_character", "wh2_dlc14_brt_chevaliers_de_lyonesse", 551, 330, 488, 331, false},
					{"teleport_character", "wh2_main_vmp_strygos_empire", 677, 288, 552, 335, false},
					{"create_army", "wh2_main_vmp_strygos_empire", "wh_main_vmp_inf_grave_guard_1,wh_main_vmp_inf_cairn_wraiths,wh_dlc04_vmp_veh_corpse_cart_1,wh_main_vmp_inf_skeleton_warriors_1,wh_main_vmp_inf_crypt_ghouls,wh_main_vmp_inf_skeleton_warriors_0,wh_main_vmp_inf_skeleton_warriors_0,wh_main_vmp_inf_skeleton_warriors_0,wh_main_vmp_cav_black_knights_0,wh_main_vmp_cav_black_knights_0", 
						"wh2_main_vor_coast_of_araby_fyrus", 496, 329, "dlc04_vmp_strigoi_ghoul_king", false, 1
					},
					{"add_units", "wh2_main_vmp_strygos_empire", 552, 335, {"wh_main_vmp_cav_black_knights_0","wh_main_vmp_cav_black_knights_0","wh_main_vmp_inf_zombie","wh_main_vmp_inf_zombie","wh_main_vmp_inf_crypt_ghouls","wh_main_vmp_inf_crypt_ghouls","wh_main_vmp_inf_crypt_ghouls","wh_main_vmp_mon_fell_bats","wh_main_vmp_inf_skeleton_warriors_0","wh_main_vmp_inf_skeleton_warriors_0","wh_main_vmp_inf_skeleton_warriors_0","wh_main_vmp_mon_dire_wolves"}},
					{"create_army", "wh2_dlc09_tmb_followers_of_nagash", "wh2_dlc09_tmb_inf_skeleton_warriors_0,wh2_dlc09_tmb_inf_skeleton_warriors_0,wh2_dlc09_tmb_inf_skeleton_warriors_0,wh2_dlc09_tmb_inf_skeleton_warriors_0,wh2_dlc09_tmb_inf_skeleton_spearmen_0,wh2_dlc09_tmb_inf_skeleton_spearmen_0,wh2_dlc09_tmb_inf_skeleton_archers_0,wh2_dlc09_tmb_inf_skeleton_archers_0,wh2_dlc09_tmb_inf_skeleton_archers_0", 
						"wh2_main_vor_land_of_assassins_palace_of_the_wizard_caliph", 454, 294, "wh2_dlc09_tmb_tomb_king", false, 1
					},
					{"create_army", "wh2_dlc09_tmb_rakaph_dynasty", "wh2_dlc09_tmb_inf_skeleton_warriors_0,wh2_dlc09_tmb_inf_skeleton_warriors_0,wh2_dlc09_tmb_inf_skeleton_warriors_0,wh2_dlc09_tmb_inf_skeleton_warriors_0,wh2_dlc09_tmb_inf_skeleton_spearmen_0,wh2_dlc09_tmb_inf_skeleton_spearmen_0,wh2_dlc09_tmb_inf_skeleton_archers_0,wh2_dlc09_tmb_inf_skeleton_archers_0,wh2_dlc09_tmb_inf_skeleton_archers_0", 
						"wh2_main_vor_the_great_desert_black_tower_of_arkhan", 585, 287, "wh2_dlc09_tmb_tomb_king", false, 1
					},
					{"kill_faction", "wh2_main_brt_thegans_crusaders"},
					{"kill_faction", "wh2_main_bst_blooded_axe"}
				}
			}
		}	
	},
	--------------------
	------ SNIKCH ------
	--------------------
	{faction = "wh2_main_skv_clan_eshin",
		custom_start = {
			{
				exceptions = nil,
				changes = {
					{"region_change", "wh2_main_vor_land_of_the_dervishes_elven_ruins", "wh2_main_emp_sudenburg"},
					{"primary_slot_change", "wh2_main_vor_land_of_the_dervishes_elven_ruins", "wh_main_emp_settlement_minor_1_coast"},
					{"port_slot_change", "wh2_main_vor_land_of_the_dervishes_elven_ruins", "wh_main_teb_port_1"},
					{"force_diplomacy", "wh2_main_skv_clan_eshin", "wh2_main_emp_sudenburg", "war"},
					{"teleport_character", "wh2_main_skv_clan_eshin", 522, 253, 503, 244, true},
					{"char_effect_bundle", "wh2_main_emp_sudenburg", 495, 246, "wh2_dlc14_bundle_scripted_force_ambush", 2}
				}
			}
		}	
	},
	--------------------
	------- GROM -------
	--------------------
	{faction = "wh2_dlc15_grn_broken_axe",
		custom_start = {
			{
				exceptions = nil,
				changes = {
					{"teleport_character_faction_leader", "wh2_dlc15_grn_broken_axe", 711, 234},
					{"teleport_character", "wh2_dlc15_grn_broken_axe", 622, 469, 706, 230, false},
					{"region_change", "wh2_main_vor_southlands_world_edge_mountains_karag_orrud", "wh2_dlc15_grn_broken_axe"},
					{"region_change", "wh2_main_vor_southern_yvresse_elessaeli", "wh2_main_hef_yvresse"},
					{"region_change", "wh2_main_vor_southern_yvresse_cairn_thel", "wh2_main_hef_yvresse"},
					{"force_diplomacy", "wh2_main_grn_arachnos", "wh2_dlc15_grn_broken_axe", "war"},
					{"kill_faction", "wh2_main_vmp_strygos_empire"},
					{"block_diplomacy","subculture:wh2_main_sc_hef_high_elves","faction:wh2_main_hef_yvresse","form confederation", false, true},
					{"secondary_slot_change", "wh2_main_vor_southlands_world_edge_mountains_karak_zorn", 0, "wh_main_dwf_farm_1"}
				}
			}
		}	
	},
	
	---------------------
	--------IMRIK--------
	---------------------
	{faction = "wh2_dlc15_hef_imrik",
	custom_start = {
		{
			exceptions = nil,
			changes = {
				{"kill_faction", "wh2_main_vmp_necrarch_brotherhood"},
				{"abandon_region", "wh2_main_vor_shifting_sands_plain_of_tuskers"},
				{"region_change", "wh2_main_vor_shifting_sands_bhagar", "wh2_dlc09_tmb_dune_kingdoms"},
				{"teleport_character_faction_leader", "wh2_dlc09_tmb_dune_kingdoms", 624, 229},
				{"create_army", "wh2_dlc09_tmb_dune_kingdoms", "wh2_dlc09_tmb_inf_nehekhara_warriors_0,wh2_dlc09_tmb_inf_skeleton_warriors_0,wh2_dlc09_tmb_inf_skeleton_warriors_0,wh2_dlc09_tmb_inf_skeleton_spearmen_0,wh2_dlc09_tmb_inf_skeleton_archers_0,wh2_dlc09_tmb_inf_skeleton_archers_0,wh2_dlc09_tmb_veh_skeleton_chariot_0", 
						"wh2_main_vor_shifting_sands_ka-sabar", 625, 194, "wh2_dlc09_tmb_tomb_king", false, 1, {"names_name_1020465424", "", "", ""}
				},
				{"region_change", "wh2_main_vor_caledor_caledors_repose", "wh2_main_hef_caledor"},
				{"force_diplomacy", "wh2_main_emp_sudenburg", "wh2_dlc09_tmb_dune_kingdoms", "war"},
				{"primary_slot_change", "wh2_main_vor_shifting_sands_antoch", "wh2_dlc09_tmb_settlement_minor_3"},
				{"add_development_points","wh2_main_vor_shifting_sands_ka-sabar",2}

			}
		}
	}
	},

	---------------------
	----- ELTHARION -----
	---------------------
	{faction = "wh2_main_hef_yvresse",
		custom_start = {
			{
				exceptions = nil,
				changes = {
					{"teleport_character_faction_leader", "wh2_main_grn_arachnos", 644, 519},
					{"region_change", "wh2_main_vor_southern_yvresse_elessaeli", "wh2_main_grn_arachnos"},
					{"region_change", "wh2_main_vor_northern_yvresse_tralinia", "wh2_main_grn_arachnos"},
					{"region_change", "wh2_main_vor_southern_yvresse_cairn_thel", "wh2_main_grn_arachnos"},	
					{"region_change", "wh2_main_vor_southern_yvresse_shrine_of_loec", "wh2_dlc11_cst_pirates_of_sartosa"},
					{"force_diplomacy", "wh2_main_hef_yvresse", "wh2_main_grn_arachnos", "war"},
					{"create_army", "wh2_main_grn_arachnos","wh_main_grn_inf_orc_boyz,wh_main_grn_inf_orc_boyz,wh_main_grn_inf_orc_arrer_boyz,wh_main_grn_inf_orc_arrer_boyz,wh2_dlc15_grn_mon_river_trolls_0", 
						"wh2_main_vor_southern_yvresse_elessaeli", 621, 457, "grn_goblin_great_shaman", false, 1
					},
					{"block_diplomacy","faction:wh2_main_grn_arachnos","faction:wh2_dlc15_grn_broken_axe","form confederation", false, false},
					{"block_diplomacy","subculture:wh_main_sc_grn_greenskins","faction:wh2_dlc15_grn_broken_axe","form confederation", false, true},
				}
			},
			{
				exceptions = {"wh2_dlc15_grn_broken_axe"},
				changes = {
					{"teleport_character_faction_leader", "wh2_dlc15_grn_broken_axe", 711, 234},
					{"teleport_character", "wh2_dlc15_grn_broken_axe", 622, 469, 706, 230, false},
					{"region_change", "wh2_main_vor_southlands_world_edge_mountains_karag_orrud", "wh2_dlc15_grn_broken_axe"},
					{"region_change", "wh2_main_vor_southlands_world_edge_mountains_mount_arachnos", "wh2_dlc15_grn_broken_axe"},
					{"region_change", "wh2_main_vor_southlands_world_edge_mountains_lost_plateau", "wh2_dlc15_grn_broken_axe"},
					{"hide_faction_leader", "wh2_dlc15_grn_broken_axe", "1540480612", false},
				}
			}
		}
	},

};

--Mortal Empires Changes
local me_custom_start_factions = {

	--------------------
	---- ARGWYLON ------
	--------------------

	{faction = "wh_dlc05_wef_argwylon",
		custom_start = {
			{
				exceptions = {"wh_dlc05_wef_wood_elves"},
				changes = {
					{"region_change", "wh_main_yn_edri_eternos_the_oak_of_ages", "wh_dlc05_wef_argwylon"},
				}
			}
		}
	},

	--------------------
	----    IKIT    ----
	--------------------
	{faction = "wh2_main_skv_clan_skyre",
		custom_start = {
			{
				exceptions = {"wh2_dlc11_cst_pirates_of_sartosa"},
				changes = {
					{"teleport_character", "wh2_dlc11_cst_pirates_of_sartosa", 464, 239, 427, 169, true},
					{"force_diplomacy", "wh2_dlc11_cst_pirates_of_sartosa", "wh2_main_brt_knights_of_origo", "war"},
					{"force_diplomacy", "wh2_dlc11_cst_pirates_of_sartosa", "wh_main_teb_tilea", "peace"}					
				}
			}
		}
	},
	--------------------
	----  TIKTAQ'TO ----
	--------------------
	{faction = "wh2_main_lzd_tlaqua",
		custom_start = {
			{
				exceptions = nil,
				changes = {
					{"teleport_character", "wh2_main_emp_sudenburg", 564, 22, 495, 23, true},
					{"region_change", "wh2_main_western_jungles_cuexotl", "wh2_main_emp_sudenburg"},
					{"primary_slot_change", "wh2_main_western_jungles_cuexotl", "wh_main_emp_settlement_minor_1"},
					{"secondary_slot_change", "wh2_main_western_jungles_cuexotl", 0, "wh_main_emp_barracks_1"}					
				}
			}
		}
	},
	--------------------
	----- GOR-ROK ------
	--------------------
	{faction = "wh2_main_lzd_itza", 
		custom_start = {
			{
				exceptions = {"wh2_main_skv_clan_pestilens", "wh2_dlc11_def_the_blessed_dread"},
				changes = {
					{"create_army", "wh2_main_skv_clan_pestilens", "wh2_main_skv_inf_skavenslave_slingers_0,wh2_main_skv_inf_skavenslave_slingers_0,wh2_main_skv_inf_clanrats_0,wh2_main_skv_inf_clanrats_0,wh2_main_skv_inf_skavenslaves_0,wh2_main_skv_inf_skavenslaves_0,wh2_main_skv_inf_skavenslave_spearmen_0", 
						"wh2_main_southern_great_jungle_axlotl", 147, 63, "wh2_main_skv_warlord", false, 1
					},
					{"region_change", "wh2_main_southern_great_jungle_axlotl", "wh2_main_skv_clan_pestilens"},
					{"primary_slot_change", "wh2_main_southern_great_jungle_axlotl", "wh2_main_skv_settlement_minor_1"},
					{"secondary_slot_change", "wh2_main_southern_great_jungle_axlotl", 1, "wh2_main_skv_clanrats_1"}
				}
			}
		}
	},
	--------------------
	------  NAKAI  -----
	--------------------
	{faction = "wh2_dlc13_lzd_spirits_of_the_jungle",
		custom_start = {
			{
				exceptions = nil,
				changes = {
					{"char_effect_bundle", "wh2_dlc13_lzd_spirits_of_the_jungle", 1, 1, "wh2_dlc13_bundle_nakai_early_game", 10},
					{"force_diplomacy", "wh2_dlc13_lzd_spirits_of_the_jungle", "wh_dlc08_nor_vanaheimlings", "war"}
				}
			}
		}
	},
	--------------------
	----  WULFHART  ----
	--------------------
	{faction = "wh2_dlc13_emp_the_huntmarshals_expedition",
		custom_start = {
			{
				exceptions = nil,
				changes = {
					{"create_army", "wh2_main_lzd_tlaxtlan", "wh2_main_lzd_inf_skink_cohort_1,wh2_main_lzd_inf_skink_cohort_1,wh2_main_lzd_inf_saurus_warriors_1,wh2_main_lzd_cav_cold_ones_feral_0", 
						"wh2_main_the_creeping_jungle_temple_of_kara", 97, 181, "wh2_main_lzd_saurus_old_blood", false, 1
					},
					{"region_change", "wh2_main_the_creeping_jungle_tlanxla", "wh2_main_lzd_tlaxtlan"},	
					{"force_diplomacy", "wh2_dlc13_emp_the_huntmarshals_expedition", "wh2_main_lzd_tlaxtlan", "war"},
					{"force_diplomacy", "wh2_dlc13_emp_the_huntmarshals_expedition", "wh2_main_grn_blue_vipers", "peace"},
					{"teleport_character", "wh2_dlc12_skv_clan_mange", 80, 155, 36, 144, true}
				}
			}
		}
	},
	--------------------
	------  GELT  ------
	--------------------
	{faction = "wh2_dlc13_emp_golden_order",
		custom_start = {
			{
				exceptions = nil,
				changes = {
					{"region_change", "wh_main_black_mountains_mighdal_vongalbarak", "wh_main_grn_black_venom"},
					{"region_change", "wh_main_black_mountains_karak_angazhar", "wh_main_dwf_karak_hirn"},
					{"region_change", "wh_main_black_mountains_karak_hirn", "wh_main_grn_black_venom"},
					{"teleport_character", "wh_main_dwf_karak_hirn", 561, 346, 596, 339, true},
					{"primary_slot_change", "wh2_main_solland_pfeildorf", "wh_main_emp_settlement_major_2"},
					{"secondary_slot_change", "wh2_main_solland_pfeildorf", 1, "wh2_main_special_solland_market_1"},
					{"secondary_slot_change", "wh2_main_solland_steingart", 0, "wh_main_grn_industry_1"}
				}
			}
		}
	},
	--------------------
	------ REPANSE -----
	--------------------
	{faction = "wh2_dlc14_brt_chevaliers_de_lyonesse",
		custom_start = {
			{
				exceptions = nil,
				changes = {
					{"region_change", "wh2_main_land_of_the_dead_zandri", "wh2_main_brt_knights_of_origo"},
					{"primary_slot_change", "wh2_main_land_of_the_dead_zandri", "wh_main_brt_settlement_minor_2_coast"},
					{"port_slot_change", "wh2_main_land_of_the_dead_zandri", "wh_main_brt_port_1"},
					{"secondary_slot_change", "wh2_main_land_of_the_dead_zandri", 0, "wh_main_brt_barracks_1"},
					{"region_change", "wh2_main_coast_of_araby_fyrus", "wh2_main_vmp_strygos_empire"},
					{"primary_slot_change", "wh2_main_coast_of_araby_fyrus", "wh_main_vmp_settlement_minor_1"},
					{"secondary_slot_change", "wh2_main_coast_of_araby_fyrus", 0, "wh_main_vmp_forest_1"},
					{"region_change", "wh2_main_coast_of_araby_al_haikk", "wh2_main_vmp_strygos_empire"},
					{"primary_slot_change", "wh2_main_coast_of_araby_al_haikk", "wh_main_vmp_settlement_major_2_coast"},
					{"port_slot_change", "wh2_main_coast_of_araby_al_haikk", "wh_main_vmp_port_1"},
					{"secondary_slot_change", "wh2_main_coast_of_araby_al_haikk", 0, "wh_main_vmp_cemetary_2"},
					{"force_diplomacy", "wh2_dlc14_brt_chevaliers_de_lyonesse", "wh2_main_vmp_strygos_empire", "war"},
					{"teleport_character", "wh2_main_brt_knights_of_origo", 426, 161, 505, 140, true},
					{"teleport_character", "wh2_main_vmp_strygos_empire", 507, 143, 451, 139, true},
					{"create_army", "wh2_main_vmp_strygos_empire", "wh_main_vmp_inf_grave_guard_1,wh_main_vmp_inf_cairn_wraiths,wh_dlc04_vmp_veh_corpse_cart_1,wh_main_vmp_inf_skeleton_warriors_1,wh_main_vmp_inf_crypt_ghouls,wh_main_vmp_inf_skeleton_warriors_0,wh_main_vmp_inf_skeleton_warriors_0,wh_main_vmp_inf_skeleton_warriors_0,wh_main_vmp_cav_black_knights_0", 
						"wh2_main_coast_of_araby_al_haikk", 425, 106, "dlc04_vmp_strigoi_ghoul_king", false, 1
					},
					{"create_army", "wh2_dlc09_tmb_followers_of_nagash", "wh2_dlc09_tmb_inf_skeleton_warriors_0,wh2_dlc09_tmb_inf_skeleton_warriors_0,wh2_dlc09_tmb_inf_skeleton_warriors_0,wh2_dlc09_tmb_inf_skeleton_warriors_0,wh2_dlc09_tmb_inf_skeleton_spearmen_0,wh2_dlc09_tmb_inf_skeleton_spearmen_0,wh2_dlc09_tmb_inf_skeleton_archers_0,wh2_dlc09_tmb_inf_skeleton_archers_0,wh2_dlc09_tmb_inf_skeleton_archers_0", 
						"wh2_main_land_of_assassins_lashiek", 392, 53, "wh2_dlc09_tmb_tomb_king", false, 1
					},
					{"create_army", "wh2_dlc09_tmb_rakaph_dynasty", "wh2_dlc09_tmb_inf_skeleton_warriors_0,wh2_dlc09_tmb_inf_skeleton_warriors_0,wh2_dlc09_tmb_inf_skeleton_warriors_0,wh2_dlc09_tmb_inf_skeleton_warriors_0,wh2_dlc09_tmb_inf_skeleton_spearmen_0,wh2_dlc09_tmb_inf_skeleton_spearmen_0,wh2_dlc09_tmb_inf_skeleton_archers_0,wh2_dlc09_tmb_inf_skeleton_archers_0,wh2_dlc09_tmb_inf_skeleton_archers_0", 
						"wh2_main_great_desert_of_araby_pools_of_despair", 522, 99, "wh2_dlc09_tmb_tomb_king", false, 1
					},
					{"kill_faction", "wh2_main_brt_thegans_crusaders"}
				}
			}
		}	
	},
	--------------------
	------ SNIKCH ------
	--------------------
	{faction = "wh2_main_skv_clan_eshin",
		custom_start = {
			{
				exceptions = nil,
				changes = {
					{"char_effect_bundle", "wh2_dlc14_grn_red_cloud", 988, 289, "wh2_dlc14_bundle_scripted_force_ambush", 2}
				}
			}
		}
	},
	--------------------
	------- GROM -------
	--------------------
	{faction = "wh2_dlc15_grn_broken_axe",
		custom_start = {
			{
				exceptions = nil,
				changes = {
					{"region_change", "wh_main_massif_orcal_massif_orcal", "wh2_dlc15_grn_broken_axe"},
					{"teleport_character_faction_leader", "wh2_dlc15_grn_broken_axe", 425, 364},
					{"teleport_character", "wh2_dlc15_grn_broken_axe", 269, 272, 420, 363, false},
					{"force_diplomacy", "wh2_dlc15_grn_broken_axe", "wh_main_brt_parravon", "war"},
					{"teleport_character_faction_leader", "wh_main_brt_parravon", 434, 358},
					{"char_effect_bundle", "wh_main_brt_parravon", 434, 358, "wh_main_reduced_movement_range_90", 1},
				}
			},
			{
				exceptions = {"wh2_main_hef_yvresse"},
				changes = {
					{"block_diplomacy","subculture:wh2_main_sc_hef_high_elves","faction:wh2_main_hef_yvresse","form confederation", false, true},
					{"region_change", "wh2_main_yvresse_shrine_of_loec", "wh2_main_hef_yvresse"},
					{"region_change", "wh2_main_yvresse_elessaeli", "wh2_main_hef_yvresse"},
					{"region_change", "wh2_main_yvresse_tralinia", "wh2_main_hef_yvresse"},
				}
			}
		}
	},



	---------------------
	--------AZHAG--------
	---------------------
	{faction = "wh2_dlc15_grn_bonerattlaz",
	custom_start = {
		{
			exceptions = nil,
			changes = {
				{"secondary_slot_change", "wh_main_ostermark_essen", 1, "wh_main_emp_barracks_1"},
			}
		}
	}
	},
		
	---------------------
	----- ELTHARION -----
	---------------------
	{faction = "wh2_main_hef_yvresse",
		custom_start = {
			{
				exceptions = nil,
				changes = {
					{"secondary_slot_change", "wh2_main_yvresse_elessaeli", 1, "wh_main_grn_industry_1"},
					{"secondary_slot_change", "wh2_main_yvresse_shrine_of_loec", 0, "wh_main_grn_garrison_1"},
					{"region_change", "wh_main_southern_badlands_gronti_mingol", "wh2_main_hef_yvresse"},
					{"region_change", "wh2_main_yvresse_shrine_of_loec", "wh2_dlc15_grn_skull_crag"},
					{"region_change", "wh2_main_yvresse_elessaeli", "wh2_dlc15_grn_skull_crag"},
					{"region_change", "wh2_main_yvresse_tralinia", "wh2_dlc15_grn_skull_crag"},
					{"region_change", "wh2_main_land_of_the_dead_zandri", "wh2_dlc09_tmb_khemri"},
					{"primary_slot_change", "wh_main_southern_badlands_gronti_mingol", "wh2_main_special_settlement_colony_minor_hef_2"},
					{"teleport_character_faction_leader", "wh2_main_hef_yvresse", 563, 219},
					{"teleport_character_faction_leader", "wh2_dlc15_grn_skull_crag", 294,335},
					{"teleport_character_faction_leader", "wh_main_grn_teef_snatchaz", 638, 267},
					{"teleport_character_faction_leader", "wh_main_grn_top_knotz", 575, 206},
					{"force_diplomacy", "wh2_main_hef_yvresse", "wh_main_grn_top_knotz", "war"},
					{"force_diplomacy", "wh2_main_hef_yvresse", "wh2_dlc15_grn_skull_crag", "war"},
					{"create_army", "wh2_dlc15_grn_skull_crag","wh_main_grn_inf_goblin_spearmen,wh_main_grn_inf_goblin_spearmen,wh_main_grn_inf_goblin_archers,wh2_dlc15_grn_mon_river_trolls_0", 
					"wh2_main_yvresse_elessaeli", 264, 277, "grn_orc_warboss", false, 1},
					{"block_diplomacy","subculture:wh_main_sc_grn_greenskins","faction:wh2_dlc15_grn_broken_axe","form confederation", false, true},
				}
			},
			{
				exceptions = {"wh2_dlc15_grn_broken_axe"},
				changes = {
					{"region_change", "wh_main_blightwater_misty_mountain", "wh2_dlc15_grn_broken_axe"},
					{"region_change", "wh_main_blightwater_kradtommen", "wh2_dlc15_grn_broken_axe"},
					{"region_change", "wh_main_desolation_of_nagash_spitepeak", "wh2_dlc15_grn_broken_axe"},
					{"region_change", "wh_main_blightwater_deff_gorge", "wh2_dlc15_grn_broken_axe"},
					{"teleport_character_faction_leader", "wh2_dlc15_grn_broken_axe", 773, 202},
					{"teleport_character", "wh2_dlc15_grn_broken_axe", 269, 272, 777, 201, false},
					{"force_diplomacy", "wh2_dlc15_grn_broken_axe", "wh2_dlc15_skv_clan_volkn", "war"},
					{"block_diplomacy","faction:wh2_dlc15_grn_broken_axe","faction:wh2_dlc15_grn_broken_axe","form confederation", false, false},
				}
			}
		}
	},
	---------------------
	----- IMRIK---- -----
	---------------------
	{faction = "wh2_dlc15_hef_imrik",
		custom_start = {
			{
				exceptions = nil,
				changes = {
					{"create_army", "wh2_dlc15_dwf_clan_helhein", "wh_main_dwf_inf_dwarf_warrior_0,wh_main_dwf_inf_dwarf_warrior_0,wh2_dlc10_dwf_inf_giant_slayers,wh_main_dwf_inf_thunderers_0,wh_main_dwf_art_cannon",
					"wh2_main_the_plain_of_bones_ash_ridge_mountains", 864, 262, "dwf_lord", false, 2
					},
					{"primary_slot_change", "wh2_main_the_plain_of_bones_darkhold", "wh_main_dwf_settlement_minor_3"},
					{"secondary_slot_change", "wh2_main_the_plain_of_bones_darkhold", 1, "wh_main_dwf_barracks_1"},
					{"secondary_slot_change", "wh2_main_the_plain_of_bones_ash_ridge_mountains", 0, "wh_main_dwf_farm_2"},
					{"secondary_slot_change", "wh2_main_the_plain_of_bones_the_fortress_of_vorag", 1, "wh2_main_hef_order_1"},
					{"teleport_character_faction_leader", "wh2_dlc15_dwf_clan_helhein", 783, 252},
					{"add_development_points","wh2_main_the_plain_of_bones_the_fortress_of_vorag",3}

				}
			},
			{
				exceptions = {"wh2_dlc11_cst_noctilus"},
				changes = {
					{"force_diplomacy", "wh2_main_hef_caledor", "wh2_dlc11_cst_noctilus", "peace"},
					{"force_diplomacy", "wh2_main_hef_tiranoc", "wh2_dlc11_cst_noctilus", "war"},
				}
			},
			{
				exceptions = {"wh2_main_skv_clan_eshin", "wh2_main_def_hag_graef"}, 
				changes = {
					{"force_diplomacy", "wh2_main_skv_clan_eshin", "wh2_main_def_hag_graef", "war"},
					{"region_change", "wh2_main_dragon_isles_shattered_stone_isle", "wh2_main_def_hag_graef"},
					{"create_army", "wh2_dlc14_grn_red_cloud", "wh_main_grn_inf_goblin_spearmen,wh_main_grn_inf_goblin_spearmen,wh_main_grn_inf_goblin_archers,wh2_dlc15_grn_mon_river_trolls_0",
					"wh2_main_gnoblar_country_haunted_forest", 983, 268, "grn_orc_warboss", false, 1
					},
				}
			}
		}
	}



};


function add_campaign_custom_start_listeners()
	out("#### Add Campaign Custom Start Listeners ####");
	
	local human_factions = cm:get_human_factions();
	
	--Autorun Guard - checks for a human faction
	if human_factions[1] ~= nil then
		local custom_table = {};
		
		if cm:get_campaign_name() == "main_warhammer" then
			custom_table = me_custom_start_factions;
		else
			custom_table = vor_custom_start_factions;
		end
					
		for i = 1, #human_factions do 
			for j = 1, #custom_table do
				if human_factions[i] == custom_table[j].faction or custom_table[j].faction == "all" then
					local custom_faction = custom_table[j];
					for k = 1, #custom_faction.custom_start do
						local current_custom_start = custom_faction.custom_start;
						local exception_list = current_custom_start[k].exceptions;

						if not exception_list or not cm:are_any_factions_human(exception_list) then
							local custom_changes = current_custom_start[k].changes;
							
							for l = 1, #custom_changes do
								local changes = custom_changes[l];
								if cm:is_new_game() == true then
									cm:disable_event_feed_events(true,"all","","")
									if changes[1] == "region_change" then
										region_change(changes[2], changes[3]);
									elseif changes[1] == "primary_slot_change" then 
										primary_slot_change(changes[2], changes[3]);
									elseif changes[1] == "port_slot_change" then 
										port_slot_change(changes[2], changes[3]);
									elseif changes[1] == "secondary_slot_change" then 
										secondary_slot_change(changes[2], changes[3], changes[4]);
									elseif changes[1] == "create_army" then 
										create_army(changes[2], changes[3], changes[4], changes[5], changes[6], changes[7], changes[8], changes[9], changes[10]);
									elseif changes[1] == "create_army_for_leader" then
										create_army_for_faction_leader(changes[2], changes[3], changes[4], changes[5], changes[6]);
									elseif changes[1] == "teleport_character" then 
										teleport_character(changes[2], changes[3], changes[4], changes[5], changes[6], changes[7]);
									elseif changes[1] == "teleport_character_faction_leader" then
										teleport_character_faction_leader(changes[2], changes[3], changes[4]);
									elseif changes[1] == "hide_faction_leader" then
										hide_faction_leader(changes[2], changes[3], changes[4]);
									elseif changes[1] == "add_units" then 
										add_units_to_army(changes[2], changes[3], changes[4], changes[5]);
									elseif changes[1] == "force_diplomacy" then 
										force_diplomacy_change(changes[2], changes[3], changes[4]);
									elseif changes[1] == "abandon_region" then 
										abandon_region(changes[2]);
									elseif changes[1] == "kill_faction" then 
										kill_faction(changes[2]);											
									elseif changes[1] == "char_effect_bundle" then 
										apply_effect_bundle_character(changes[2], changes[3], changes[4], changes[5], changes[6]);
									elseif changes[1] == "add_development_points" then 
										cm:add_development_points_to_region(changes[2],changes[3])
									end
									cm:callback(function() 
										cm:disable_event_feed_events(false, "all", "", "");
									end, 0.5);
								end
								if changes[1] == "block_diplomacy" then 
									block_diplomacy(changes[2], changes[3], changes[4], changes[5], changes[6]);
								end
							end
						end
					end
				end
			end
		end
	end
end

--pass this function a region(string) and faction(string)
function region_change(region_name, faction_name)
	--check the region key is a string
	if not is_string(region_name) then
		script_error("ERROR: region_change() called but supplied target region key [" .. tostring(region_name) .. "] is not a string");
		return false;
	end;
	
	--check the faction key is a string
	if not is_string(faction_name) then
		script_error("ERROR: region_change() called but supplied target faction key [" .. tostring(faction_name) .. "] is not a string");
		return false;
	end

	cm:transfer_region_to_faction(region_name, faction_name);

	cm:callback(function() 
		cm:heal_garrison(cm:get_region(region_name):cqi());
	end, 0.5);
end

--pass this function a region(string), and building(string)
function primary_slot_change(region, building)
	--check the region key is a string
	if not is_string(region) then
		script_error("ERROR: primary_slot_change() called but supplied target region key [" .. tostring(region) .. "] is not a string");
		return false;
	end;
	
	--check the region key is a string
	if not is_string(building) then
		script_error("ERROR: primary_slot_change() called but supplied target building key [" .. tostring(building) .. "] is not a string");
		return false;
	end;

	local region_interface = cm:get_region(region);
	if region_interface:is_null_interface() then
		script_error("ERROR: primary_slot_change() called but supplied target region key [" .. region .. "] is not present in the campaign");
		return false;
	end;

	local result_building = cm:region_slot_instantly_upgrade_building(region_interface:settlement():primary_slot(), building);
	cm:callback(function() cm:heal_garrison(cm:get_region(region):cqi()) end, 0.5);
	
	return not result_building:is_null_interface() and result_building:name() == building;
end

--pass this function a region(string), and building(string)
function port_slot_change(region, building)
	--check the region key is a string
	if not is_string(region) then
		script_error("ERROR: port_slot_change() called but supplied target region key [" .. tostring(region) .. "] is not a string");
		return false;
	end;
	
	--check the region key is a string
	if not is_string(building) then
		script_error("ERROR: port_slot_change() called but supplied target building key [" .. tostring(building) .. "] is not a string");
		return false;
	end;

	local region_interface = cm:get_region(region);
	if region_interface:is_null_interface() then
		script_error("ERROR: port_slot_change() called but supplied target region key [" .. region .. "] is not present in the campaign");
		return false;
	end;

	local port_slot = region_interface:settlement():port_slot();
	if port_slot:is_null_interface() then
		script_error("ERROR: port_slot_change() called but supplied target region [" .. region .. "] does not have a port");
		return false;
	end;

	local result_building = cm:region_slot_instantly_upgrade_building(port_slot, building);
	cm:callback(function() cm:heal_garrison(cm:get_region(region):cqi()) end, 0.5);
	
	return not result_building:is_null_interface() and result_building:name() == building;
end

--pass this function a region(string), index (number), and building(string)
function secondary_slot_change(region, slot_index, building)
	--check the region key is a string
	if not is_string(region) then
		script_error("ERROR: secondary_slot_change() called but supplied target region key [" .. tostring(region) .. "] is not a string");
		return false;
	end;
	
	-- check the slot index is a number
	if not is_number(slot_index) then
		script_error("ERROR: secondary_slot_change() called but the supplied slot index [" .. tostring(slot_index) .. "] is not a number or nil");
		return false;
	end;
	
	--check the region key is a string
	if not is_string(building) then
		script_error("ERROR: secondary_slot_change() called but supplied target building key [" .. tostring(building) .. "] is not a string");
		return false;
	end;

	local region_interface = cm:get_region(region);
	if region_interface:is_null_interface() then
		script_error("ERROR: secondary_slot_change() called but supplied target region key [" .. region .. "] is not present in the campaign");
		return false;
	end;

	local active_secondary_slots = region_interface:settlement():active_secondary_slots();
	if not (active_secondary_slots:num_items() > slot_index) then
		script_error("ERROR: secondary_slot_change() called but the supplied active slot index of [" .. tostring(slot_index) .. "] is out of bounds");
		return false;
	end;

	local result_building = cm:region_slot_instantly_upgrade_building(active_secondary_slots:item_at(slot_index), building);
	cm:callback(function() cm:heal_garrison(cm:get_region(region):cqi()) end, 0.5);
	
	return not result_building:is_null_interface() and result_building:name() == building;
end

--pass this function a faction(string), units (string/number), region(string), x(number), y(number), subtype(string), faction_leader(bool), turn(number), names(list of strings)
function create_army(faction_name, unit_list, region_name, x_pos, y_pos, agent_subtype, is_leader, spawn_on_turn, name_table)
	--check the faction key is a string
	if not is_string(faction_name) then
		script_error("ERROR: create_army() called but supplied target faction key [" .. tostring(faction_name) .. "] is not a string");
		return false;
	end
	
	--check the unit_list is a list of strings or nil (if nil then we will generate a random army)
	if is_number(unit_list) then
		local num_units = unit_list; 
		if num_units > 19 then
			num_units = 19;
		end
		unit_list = generate_random_army(cm:get_faction(faction_name):subculture(), num_units);
	elseif not is_string(unit_list) then
		script_error("ERROR: create_army() called but supplied unit_list [" .. tostring(region_name) .. "] is not a number or table");
		return false;
	end;
	
	--check the region key is a string
	if not is_string(region_name) then
		script_error("ERROR: create_army() called but supplied target region key [" .. tostring(region_name) .. "] is not a string");
		return false;
	end;
	
	--check the x position is a number
	if not is_number(x_pos) then
		script_error("ERROR: create_army() called but supplied x position [" .. tostring(x_pos) .. "] is not a number");
		return false;
	end;
	
	--check the y position is a number
	if not is_number(y_pos) then
		script_error("ERROR: create_army() called but supplied y position [" .. tostring(y_pos) .. "] is not a number");
		return false;
	end;
	
	--check the agent subtype is a string
	if not is_string(agent_subtype) then
		script_error("ERROR: create_army() called but supplied agent subtype [" .. tostring(agent_subtype) .. "] is not a string");
		return false;
	end
	
	--check the faction leader boolean is a boolean
	if not is_boolean(is_leader) then
		script_error("ERROR: create_army() called but supplied faction leader boolean [" .. tostring(is_leader) .. "] is not a boolean");
		return false;
	end
	
	--check the turn number is a number
	if not is_number(spawn_on_turn) then
		script_error("ERROR: create_army() called but supplied turn number [" .. tostring(spawn_on_turn) .. "] is not a number");
		return false;
	end;
	
	if name_table == nil or #name_table ~= 4 then
		name_table = generate_character_name(cm:get_faction(faction_name):subculture());
	elseif not is_table(name_table) then
		script_error("ERROR: create_army() called but supplied name [" .. tostring(name_table) .. "] is not a table");
		return false;
	end
	
	if spawn_on_turn == 1 then
		cm:create_force_with_general(
			-- faction_key, unit_list, region_key, x, y, agent_type, agent_subtype, forename, clan_name, family_name, other_name, make_faction_leader, success_callback
			faction_name,
			unit_list,
			region_name,
			x_pos,
			y_pos,
			"general",
			agent_subtype,
			name_table[1],		-- Felix
			name_table[2],
			name_table[3],		-- Hellborg
			name_table[4],
			is_leader
		);
	else
		core:add_listener(
			"CustomStart_ArmySpawner",
			"FactionTurnStart",
			function(context) 
				return cm:turn_number() >= spawn_on_turn;
			end,
			function(context) 
				cm:create_force_with_general(
					-- faction_key, unit_list, region_key, x, y, agent_type, agent_subtype, forename, clan_name, family_name, other_name, make_faction_leader, success_callback
					faction_name,
					unit_list,
					region_name,
					x_pos,
					y_pos,
					"general",
					agent_subtype,
					name_table[1],		-- Felix
					name_table[2],
					name_table[3],		-- Hellborg
					name_table[4],
					is_leader
				);
			end,
			false	
		);
	end
end

--pass this function a faction(string), region(string), x(number), y(number), units(string/number)
function create_army_for_faction_leader(faction_name, region_name, x_pos, y_pos, unit_list)
	--check the faction key is a string
	if not is_string(faction_name) then
		script_error("ERROR: create_army_for_faction_leader() called but supplied target faction key [" .. tostring(faction_name) .. "] is not a string");
		return false;
	end
	
	--check the region key is a string
	if not is_string(region_name) then
		script_error("ERROR: create_army_for_faction_leader() called but supplied target region key [" .. tostring(region_name) .. "] is not a string");
		return false;
	end;
	
	--check the x position is a number
	if not is_number(x_pos) then
		script_error("ERROR: create_army_for_faction_leader() called but supplied x position [" .. tostring(x_pos) .. "] is not a number");
		return false;
	end;
	
	--check the y position is a number
	if not is_number(y_pos) then
		script_error("ERROR: create_army_for_faction_leader() called but supplied y position [" .. tostring(y_pos) .. "] is not a number");
		return false;
	end;
	
	--check the unit_list is a list of strings or nil (if nil then we will generate a random army)
	if is_number(unit_list) then
		local num_units = unit_list; 
		if num_units > 19 then
			num_units = 19;
		end
		unit_list = generate_random_army(cm:get_faction(faction_name):subculture(), num_units);
	elseif not is_string(unit_list) then
		script_error("ERROR: create_army_for_faction_leader() called but supplied unit_list [" .. tostring(region_name) .. "] is not a number or table");
		return false;
	end	
	
	cm:create_force_with_existing_general(
		"character_cqi:" .. cm:get_faction(faction_name):faction_leader():command_queue_index(),
		faction_name,
		unit_list,
		region_name,
		x_pos,
		y_pos
	);
end

--pass this function a faction(string), current_x(number), current_y(number), target_x(number), target_y(number), general(bool)
function teleport_character(faction_name, start_x, start_y, end_x, end_y, is_general)
	--check the faction key is a string
	if not is_string(faction_name) then
		script_error("ERROR: teleport_character() called but supplied target faction key [" .. tostring(faction_name) .. "] is not a string");
		return false;
	end;
	
	--check the starting x co-ordinate is a number
	if not is_number(start_x) then
		script_error("ERROR: teleport_character() called but supplied starting x co-ordinate [" .. tostring(start_x) .. "] is not a number");
		return false;
	end;
	
	--check the starting y co-ordinate is a number
	if not is_number(start_y) then
		script_error("ERROR: teleport_character() called but supplied starting y co-ordinate [" .. tostring(start_y) .. "] is not a number");
		return false;
	end;
	
	--check the end x co-ordinate is a number
	if not is_number(end_x) then
		script_error("ERROR: teleport_character() called but supplied end x co-ordinate [" .. tostring(end_x) .. "] is not a number");
		return false;
	end;

	--check the end y co-ordinate is a number
	if not is_number(end_y) then
		script_error("ERROR: teleport_character() called but supplied end y co-ordinate [" .. tostring(end_y) .. "] is not a number");
		return false;
	end;
	
	--check the end y co-ordinate is a number
	if not is_boolean(is_general) then
		script_error("ERROR: teleport_character() called but supplied  is_general [" .. tostring(is_general) .. "] is not a boolean");
		return false;
	end;
	
	local custom_start_char = cm:get_closest_character_to_position_from_faction(faction_name, start_x, start_y, is_general, false);
		
	if custom_start_char then
		cm:teleport_to(cm:char_lookup_str(custom_start_char), end_x, end_y, true);
	end
end

function teleport_character_faction_leader(faction_key, target_x, target_y)
	local faction = cm:model():world():faction_by_key(faction_key); 

	if faction:is_null_interface() == false then
		local leader = faction:faction_leader();
		cm:teleport_to(cm:char_lookup_str(leader), target_x, target_y, true);
	end
end

--pass this function a faction(string), startpos_ID(string), kill_army(bool)
function hide_faction_leader(faction_key, startpos_ID, kill_army)
	cm:callback(function()
		local faction = cm:model():world():faction_by_key(faction_key);

		if faction:is_null_interface() == false then
			local leader = faction:faction_leader();
			local leader_cqi = leader:command_queue_index();
			cm:kill_character(leader_cqi, kill_army, false);
			cm:lock_starting_general_recruitment(startpos_ID, faction_key);
		end
	end, 0.5);
end

--pass this function a faction(string), x(number), y(number), units(list of strings)
function add_units_to_army(faction_name, pos_x, pos_y, unit_list)
	--check the faction key is a string
	if not is_string(faction_name) then
		script_error("ERROR: add_units_to_army() called but supplied target faction key [" .. tostring(faction_name) .. "] is not a string");
		return false;
	end;
	
	--check the starting x co-ordinate is a number
	if not is_number(pos_x) then
		script_error("ERROR: add_units_to_army() called but supplied x co-ordinate [" .. tostring(pos_x) .. "] is not a number");
		return false;
	end;
	
	--check the starting y co-ordinate is a number
	if not is_number(pos_y) then
		script_error("ERROR: add_units_to_army() called but supplied y co-ordinate [" .. tostring(pos_y) .. "] is not a number");
		return false;
	end;
	
	--check the unit_list is a table
	if not is_table(unit_list) then
		script_error("ERROR: add_units_to_army() called but supplied units [" .. tostring(unit_list) .. "] is not a table");
		return false;
	end;
	
	local custom_start_char = cm:get_closest_general_to_position_from_faction(faction_name, pos_x, pos_y, false);
	
	for i = 1, #unit_list do
		cm:grant_unit_to_character(cm:char_lookup_str(custom_start_char), unit_list[i]);
	end
end

--pass this function a source faction(string), target faction(string), diplomacy type(string)
function force_diplomacy_change(s_faction, t_faction, d_type)
	--check the region key is a string
	if not is_string(s_faction) then
		script_error("ERROR: force_diplomacy_change() called but supplied source faction key [" .. tostring(s_faction) .. "] is not a string");
		return false;
	end;
	
	--check the slot number is a number
	if not is_string(t_faction) then
		script_error("ERROR: force_diplomacy_change() called but supplied target faction key [" .. tostring(t_faction) .. "] is not a string");
		return false;
	end;
	
	--check the region key is a string
	if not is_string(d_type) then
		script_error("ERROR: force_diplomacy_change() called but supplied diplomacy type [" .. tostring(d_type) .. "] is not a string");
		return false;
	end
	
	if d_type == "war" then
		cm:force_declare_war(s_faction, t_faction, false, false);
	elseif d_type == "peace" then
		cm:force_make_peace(s_faction, t_faction);	
	else
		script_error("ERROR: force_diplomacy_change() called but supplied diplomacy type [" .. tostring(d_type) .. "] is not a valid type or has not been implemented");
	end
end

--pass this function a source(string), target(string), diplomacy type(string), can_offer(bool), can_accept(bool)
function block_diplomacy(source, target, diplomacy, can_offer, can_accept)
	--check the source is a string
	if not is_string(source) then
		script_error("ERROR: block_diplomacy() called but supplied source [" .. tostring(source) .. "] is not a string");
		return false;
	end;
	
	--check the target is a string
	if not is_string(target) then
		script_error("ERROR: block_diplomacy() called but supplied target [" .. tostring(target) .. "] is not a string");
		return false;
	end;
	
	--check the diplomacy is a string
	if not is_string(diplomacy) then
		script_error("ERROR: block_diplomacy() called but supplied diplomacy [" .. tostring(diplomacy) .. "] is not a string");
		return false;
	end;
	
	--check the can_offer flag is a boolean
	if not is_boolean(can_offer) then
		script_error("ERROR: block_diplomacy() called but supplied can_offer flag is a boolean [" .. tostring(can_offer) .. "] is not a boolean");
		return false;
	end
	
	--check the can_accept flag is a boolean
	if not is_boolean(can_accept) then
		script_error("ERROR: block_diplomacy() called but supplied can_accept flag is a boolean [" .. tostring(can_accept) .. "] is not a boolean");
		return false;
	end
	
	cm:force_diplomacy(source, target, diplomacy, can_offer, can_accept);
end

--pass the region key(string)
function abandon_region(region_key)
	--check the region key is a string
	if not is_string(region_key) then
		script_error("ERROR: abandon_region() called but supplied region key [" .. tostring(region_key) .. "] is not a string");
		return false;
	end
	
	cm:set_region_abandoned(region_key);

	cm:callback(function() 
		cm:heal_garrison(cm:get_region(region_key):cqi());
	end, 0.5);
end

--pass the faction key(string)
function kill_faction(faction_key)
	--check the faction key is a string
	if not is_string(faction_key) then
		script_error("ERROR: kill_faction() called but supplied region key [" .. tostring(faction_key) .. "] is not a string");
		return false;
	end;
	
	local faction = cm:model():world():faction_by_key(faction_key); 

	if faction:is_null_interface() == false then
		
		cm:kill_all_armies_for_faction(faction);

		local region_list = faction:region_list();

		for j = 0, region_list:num_items() - 1 do
			local region = region_list:item_at(j):name();
			cm:set_region_abandoned(region);
		end
	end
end

--pass the faction(string), x position(number), y position(number), effect bundle key(string), bundle duration(number)
function apply_effect_bundle_character(faction_name, x_pos, y_pos, bundle, duration)
	--check the faction key is a string
	if not is_string(faction_name) then
		script_error("ERROR: apply_effect_bundle_character() called but supplied target faction key [" .. tostring(faction_name) .. "] is not a string");
		return false;
	end;
	
	--check the x co-ordinate is a number
	if not is_number(x_pos) then
		script_error("ERROR: apply_effect_bundle_character() called but supplied x co-ordinate [" .. tostring(x_pos) .. "] is not a number");
		return false;
	end;
	
	--check the y co-ordinate is a number
	if not is_number(y_pos) then
		script_error("ERROR: apply_effect_bundle_character() called but supplied y co-ordinate [" .. tostring(y_pos) .. "] is not a number");
		return false;
	end;
	
	--check the effetc bundle key is a string
	if not is_string(bundle) then
		script_error("ERROR: apply_effect_bundle_character() called but supplied effect bundle key [" .. tostring(bundle) .. "] is not a string");
		return false;
	end;
	
	--check the effect bundle duration is a number
	if not is_number(duration) then
		script_error("ERROR: apply_effect_bundle_character() called but supplied effect bundle duration [" .. tostring(duration) .. "] is not a number");
		return false;
	end;
	
	local custom_start_char = cm:get_closest_character_to_position_from_faction(faction_name, x_pos, y_pos, true, false);
		
	if custom_start_char then
		cm:apply_effect_bundle_to_characters_force(bundle, custom_start_char:cqi(), duration, true);
	end
end

--generates a random army based for the relevant faction subculture
function generate_random_army(subculture, num_units)
	local unit_list = {};
	local ram = random_army_manager;
	ram:remove_force("custom_start_random_army");
	ram:new_force("custom_start_random_army");
	
	if subculture == "wh_main_sc_emp_empire" then
		--Infantry
		ram:add_unit("custom_start_random_army", "wh_main_emp_inf_swordsmen", 20);
		ram:add_unit("custom_start_random_army", "wh_main_emp_inf_spearmen_0", 12);
		ram:add_unit("custom_start_random_army", "wh_main_emp_inf_spearmen_1", 9);
		ram:add_unit("custom_start_random_army", "wh_main_emp_inf_halberdiers", 2);
		ram:add_unit("custom_start_random_army", "wh_main_emp_inf_greatswords", 1);
		ram:add_unit("custom_start_random_army", "wh_dlc04_emp_inf_flagellants_0", 6);
		ram:add_unit("custom_start_random_army", "wh_main_emp_inf_crossbowmen", 8);
		ram:add_unit("custom_start_random_army", "wh_dlc04_emp_inf_free_company_militia_0", 4);
		ram:add_unit("custom_start_random_army", "wh_main_emp_inf_handgunners", 2);
		
		--Cavalry
		ram:add_unit("custom_start_random_army", "wh_main_emp_cav_empire_knights", 6);
		ram:add_unit("custom_start_random_army", "wh_main_emp_cav_reiksguard", 2);
		ram:add_unit("custom_start_random_army", "wh_main_emp_cav_pistoliers_1", 7);
		ram:add_unit("custom_start_random_army", "wh_main_emp_cav_outriders_0", 2);
		ram:add_unit("custom_start_random_army", "wh_main_emp_cav_outriders_1", 2);
		ram:add_unit("custom_start_random_army", "wh_dlc04_emp_cav_knights_blazing_sun_0", 1);
		ram:add_unit("custom_start_random_army", "wh_main_emp_cav_demigryph_knights_0", 1);
		ram:add_unit("custom_start_random_army", "wh_main_emp_cav_demigryph_knights_1", 1);
		
		--Artillery
		ram:add_unit("custom_start_random_army", "wh_main_emp_art_mortar", 6);
		ram:add_unit("custom_start_random_army", "wh_main_emp_art_great_cannon", 4);
		ram:add_unit("custom_start_random_army", "wh_main_emp_art_helblaster_volley_gun", 1);
		ram:add_unit("custom_start_random_army", "wh_main_emp_art_helstorm_rocket_battery", 1);
		
		--Vehicles
		ram:add_unit("custom_start_random_army", "wh_main_emp_veh_steam_tank", 1);
		ram:add_unit("custom_start_random_army", "wh_main_emp_veh_luminark_of_hysh_0", 1);		
		
	elseif subculture == "wh_main_sc_dwf_dwarfs" then
		--Infantry
		ram:add_unit("custom_start_random_army", "wh_main_dwf_inf_miners_0", 18);
		ram:add_unit("custom_start_random_army", "wh_main_dwf_inf_miners_1", 6);
		ram:add_unit("custom_start_random_army", "wh_main_dwf_inf_dwarf_warrior_0", 15);
		ram:add_unit("custom_start_random_army", "wh_main_dwf_inf_dwarf_warrior_1", 10);
		ram:add_unit("custom_start_random_army", "wh_main_dwf_inf_hammerers", 1);
		ram:add_unit("custom_start_random_army", "wh_main_dwf_inf_ironbreakers", 1);
		ram:add_unit("custom_start_random_army", "wh_main_dwf_inf_longbeards", 4);
		ram:add_unit("custom_start_random_army", "wh_main_dwf_inf_longbeards_1", 2);
		ram:add_unit("custom_start_random_army", "wh_main_dwf_inf_slayers", 3);
		ram:add_unit("custom_start_random_army", "wh2_dlc10_dwf_inf_giant_slayers", 1);
		ram:add_unit("custom_start_random_army", "wh_main_dwf_inf_quarrellers_0", 10);
		ram:add_unit("custom_start_random_army", "wh_main_dwf_inf_quarrellers_1", 4);
		ram:add_unit("custom_start_random_army", "wh_main_dwf_inf_thunderers_0", 3);
		ram:add_unit("custom_start_random_army", "wh_main_dwf_inf_irondrakes_0", 1);
		ram:add_unit("custom_start_random_army", "wh_main_dwf_inf_irondrakes_2", 1);
		ram:add_unit("custom_start_random_army", "wh_dlc06_dwf_inf_rangers_0", 2);
		ram:add_unit("custom_start_random_army", "wh_dlc06_dwf_inf_rangers_1", 2);
		ram:add_unit("custom_start_random_army", "wh_dlc06_dwf_inf_bugmans_rangers_0", 1);
		
		--Artillery
		ram:add_unit("custom_start_random_army", "wh_main_dwf_art_grudge_thrower", 8);
		ram:add_unit("custom_start_random_army", "wh_main_dwf_art_cannon", 2);
		ram:add_unit("custom_start_random_army", "wh_main_dwf_art_organ_gun", 1);
		ram:add_unit("custom_start_random_army", "wh_main_dwf_art_flame_cannon", 1);
		
		--Vehicles
		ram:add_unit("custom_start_random_army", "wh_main_dwf_veh_gyrocopter_0", 1);
		ram:add_unit("custom_start_random_army", "wh_main_dwf_veh_gyrocopter_1", 1);
		ram:add_unit("custom_start_random_army", "wh_main_dwf_veh_gyrobomber", 1);
		
	elseif subculture == "wh_main_sc_vmp_vampire_counts" then
		--Infantry
		ram:add_unit("custom_start_random_army", "wh_main_vmp_inf_zombie", 18);
		ram:add_unit("custom_start_random_army", "wh_main_vmp_inf_skeleton_warriors_0", 18);
		ram:add_unit("custom_start_random_army", "wh_main_vmp_inf_skeleton_warriors_1", 16);
		ram:add_unit("custom_start_random_army", "wh_main_vmp_inf_crypt_ghouls", 8);
		ram:add_unit("custom_start_random_army", "wh_main_vmp_inf_cairn_wraiths", 4);
		ram:add_unit("custom_start_random_army", "wh_main_vmp_inf_grave_guard_0", 1);
		ram:add_unit("custom_start_random_army", "wh_main_vmp_inf_grave_guard_1", 1);
		
		--Cavalry
		ram:add_unit("custom_start_random_army", "wh_main_vmp_cav_black_knights_0", 2);
		ram:add_unit("custom_start_random_army", "wh_main_vmp_cav_black_knights_3", 2);
		ram:add_unit("custom_start_random_army", "wh_main_vmp_cav_hexwraiths", 1);
		ram:add_unit("custom_start_random_army", "wh_dlc02_vmp_cav_blood_knights_0", 1);
		
		--Monsters
		ram:add_unit("custom_start_random_army", "wh_main_vmp_mon_fell_bats", 8);
		ram:add_unit("custom_start_random_army", "wh_main_vmp_mon_dire_wolves", 8);
		ram:add_unit("custom_start_random_army", "wh_main_vmp_mon_crypt_horrors", 2);
		ram:add_unit("custom_start_random_army", "wh_main_vmp_mon_vargheists", 2);
		ram:add_unit("custom_start_random_army", "wh_main_vmp_mon_varghulf", 1);
		ram:add_unit("custom_start_random_army", "wh_main_vmp_mon_terrorgheist", 1);
		
		--Vehicles
		ram:add_unit("custom_start_random_army", "wh_dlc04_vmp_veh_corpse_cart_0", 2);
		ram:add_unit("custom_start_random_army", "wh_dlc04_vmp_veh_corpse_cart_1", 1);
		ram:add_unit("custom_start_random_army", "wh_dlc04_vmp_veh_corpse_cart_2", 1);
		ram:add_unit("custom_start_random_army", "wh_main_vmp_veh_black_coach", 1);
		ram:add_unit("custom_start_random_army", "wh_dlc04_vmp_veh_mortis_engine_0", 1);
		
	elseif subculture == "wh_main_sc_grn_greenskins" then
		--Infantry
		ram:add_unit("custom_start_random_army", "wh_main_grn_inf_goblin_spearmen", 10);
		ram:add_unit("custom_start_random_army", "wh_dlc06_grn_inf_nasty_skulkers_0", 4);
		ram:add_unit("custom_start_random_army", "wh_main_grn_inf_night_goblins", 2);
		ram:add_unit("custom_start_random_army", "wh_main_grn_inf_night_goblin_fanatics", 1);
		ram:add_unit("custom_start_random_army", "wh_main_grn_inf_night_goblin_fanatics_1", 1);
		ram:add_unit("custom_start_random_army", "wh_main_grn_inf_orc_boyz", 16);
		ram:add_unit("custom_start_random_army", "wh_main_grn_inf_orc_big_uns", 4);
		ram:add_unit("custom_start_random_army", "wh_main_grn_inf_savage_orcs", 3);
		ram:add_unit("custom_start_random_army", "wh_main_grn_inf_savage_orc_big_uns", 2);
		ram:add_unit("custom_start_random_army", "wh_main_grn_inf_black_orcs", 1);
		ram:add_unit("custom_start_random_army", "wh_main_grn_inf_goblin_archers", 10);
		ram:add_unit("custom_start_random_army", "wh_main_grn_inf_night_goblin_archers", 4);
		ram:add_unit("custom_start_random_army", "wh_main_grn_inf_orc_arrer_boyz", 6);
		ram:add_unit("custom_start_random_army", "wh_main_grn_inf_savage_orc_arrer_boyz", 2);
		
		--Cavalry
		ram:add_unit("custom_start_random_army", "wh_main_grn_cav_goblin_wolf_riders_0", 5);
		ram:add_unit("custom_start_random_army", "wh_main_grn_cav_goblin_wolf_riders_1", 2);
		ram:add_unit("custom_start_random_army", "wh_main_grn_cav_goblin_wolf_chariot", 1);
		ram:add_unit("custom_start_random_army", "wh_main_grn_cav_forest_goblin_spider_riders_0", 2);
		ram:add_unit("custom_start_random_army", "wh_main_grn_cav_forest_goblin_spider_riders_1", 2);
		ram:add_unit("custom_start_random_army", "wh_dlc06_grn_inf_squig_herd_0", 1);
		ram:add_unit("custom_start_random_army", "wh_dlc06_grn_cav_squig_hoppers_0", 1);
		ram:add_unit("custom_start_random_army", "wh_main_grn_cav_orc_boar_boyz", 3);
		ram:add_unit("custom_start_random_army", "wh_main_grn_cav_orc_boar_boy_big_uns", 2);
		ram:add_unit("custom_start_random_army", "wh_main_grn_cav_orc_boar_chariot", 1);
		ram:add_unit("custom_start_random_army", "wh_main_grn_cav_savage_orc_boar_boyz", 1);
		ram:add_unit("custom_start_random_army", "wh_main_grn_cav_savage_orc_boar_boy_big_uns", 1);
		
		--Monsters
		ram:add_unit("custom_start_random_army", "wh_dlc06_grn_inf_squig_herd_0", 2);
		ram:add_unit("custom_start_random_army", "wh_main_grn_mon_trolls", 3);
		ram:add_unit("custom_start_random_army", "wh_main_grn_mon_giant", 1);
		ram:add_unit("custom_start_random_army", "wh_main_grn_mon_arachnarok_spider_0", 1);
		
		--Artillery
		ram:add_unit("custom_start_random_army", "wh_main_grn_art_goblin_rock_lobber", 4);
		ram:add_unit("custom_start_random_army", "wh_main_grn_art_doom_diver_catapult", 1);
		
	elseif subculture == "wh_main_sc_chs_chaos" then
		--Infantry
		ram:add_unit("custom_start_random_army", "wh_main_chs_inf_chaos_marauders_0", 18);
		ram:add_unit("custom_start_random_army", "wh_main_chs_inf_chaos_marauders_1", 13);
		ram:add_unit("custom_start_random_army", "wh_main_chs_inf_chaos_warriors_0", 8);
		ram:add_unit("custom_start_random_army", "wh_main_chs_inf_chaos_warriors_1", 3);
		ram:add_unit("custom_start_random_army", "wh_dlc01_chs_inf_chaos_warriors_2", 2);
		ram:add_unit("custom_start_random_army", "wh_dlc01_chs_inf_forsaken_0", 3);
		ram:add_unit("custom_start_random_army", "wh_dlc06_chs_inf_aspiring_champions_0", 2);
		ram:add_unit("custom_start_random_army", "wh_main_chs_inf_chosen_0", 1);
		ram:add_unit("custom_start_random_army", "wh_main_chs_inf_chosen_1", 1);
		ram:add_unit("custom_start_random_army", "wh_dlc01_chs_inf_chosen_2", 1);
		
		--Cavalry
		ram:add_unit("custom_start_random_army", "wh_main_chs_cav_marauder_horsemen_0", 8);
		ram:add_unit("custom_start_random_army", "wh_main_chs_cav_marauder_horsemen_1", 4);
		ram:add_unit("custom_start_random_army", "wh_dlc06_chs_cav_marauder_horsemasters_0", 2);
		ram:add_unit("custom_start_random_army", "wh_main_chs_cav_chaos_chariot", 1);
		ram:add_unit("custom_start_random_army", "wh_dlc01_chs_cav_gorebeast_chariot", 1);
		ram:add_unit("custom_start_random_army", "wh_main_chs_cav_chaos_knights_0", 1);
		ram:add_unit("custom_start_random_army", "wh_main_chs_cav_chaos_knights_1", 1);
		
		--Monsters
		ram:add_unit("custom_start_random_army", "wh_main_chs_mon_chaos_warhounds_0", 12);
		ram:add_unit("custom_start_random_army", "wh_main_chs_mon_chaos_warhounds_1", 6);
		ram:add_unit("custom_start_random_army", "wh_main_chs_mon_trolls", 3);
		ram:add_unit("custom_start_random_army", "wh_dlc01_chs_mon_trolls_1", 1);
		ram:add_unit("custom_start_random_army", "wh_main_chs_mon_chaos_spawn", 2);
		ram:add_unit("custom_start_random_army", "wh_dlc06_chs_feral_manticore", 2);
		ram:add_unit("custom_start_random_army", "wh_main_chs_mon_giant", 1);
		ram:add_unit("custom_start_random_army", "wh_dlc01_chs_mon_dragon_ogre", 1);
		ram:add_unit("custom_start_random_army", "wh_dlc01_chs_mon_dragon_ogre_shaggoth", 1);
		
		--Artillery
		ram:add_unit("custom_start_random_army", "wh_main_chs_art_hellcannon", 1);
		
	elseif subculture == "wh_dlc03_sc_bst_beastmen" then
		--Infantry
		ram:add_unit("custom_start_random_army", "wh_dlc03_bst_inf_ungor_herd_1", 16);
		ram:add_unit("custom_start_random_army", "wh_dlc03_bst_inf_ungor_spearmen_0", 16);
		ram:add_unit("custom_start_random_army", "wh_dlc03_bst_inf_ungor_spearmen_1", 8);
		ram:add_unit("custom_start_random_army", "wh_dlc03_bst_inf_gor_herd_0", 6);
		ram:add_unit("custom_start_random_army", "wh_dlc03_bst_inf_gor_herd_1", 2);
		ram:add_unit("custom_start_random_army", "wh_dlc03_bst_inf_bestigor_herd_0", 1);
		ram:add_unit("custom_start_random_army", "wh_dlc03_bst_inf_ungor_raiders_0", 10);
		
		--Cavalry
		ram:add_unit("custom_start_random_army", "wh_dlc03_bst_cav_razorgor_chariot_0", 1);
		ram:add_unit("custom_start_random_army", "wh_dlc03_bst_inf_centigors_0", 4);
		ram:add_unit("custom_start_random_army", "wh_dlc03_bst_inf_centigors_1", 2);
		ram:add_unit("custom_start_random_army", "wh_dlc03_bst_inf_centigors_2", 2);
		
		--Monsters
		ram:add_unit("custom_start_random_army", "wh_dlc03_bst_inf_chaos_warhounds_0", 10);
		ram:add_unit("custom_start_random_army", "wh_dlc03_bst_inf_chaos_warhounds_1", 6);
		ram:add_unit("custom_start_random_army", "wh_dlc03_bst_inf_razorgor_herd_0", 2);
		ram:add_unit("custom_start_random_army", "wh_dlc05_bst_mon_harpies_0", 8);
		ram:add_unit("custom_start_random_army", "wh_dlc03_bst_mon_chaos_spawn_0", 2);
		ram:add_unit("custom_start_random_army", "wh_dlc03_bst_inf_minotaurs_0", 2);
		ram:add_unit("custom_start_random_army", "wh_dlc03_bst_inf_minotaurs_1", 1);
		ram:add_unit("custom_start_random_army", "wh_dlc03_bst_inf_minotaurs_2", 1);
		ram:add_unit("custom_start_random_army", "wh_dlc03_bst_mon_giant_0", 1);
		ram:add_unit("custom_start_random_army", "wh_dlc03_bst_inf_cygor_0", 1);
		
	elseif subculture == "wh_dlc05_sc_wef_wood_elves" then
		--Infantry
		ram:add_unit("custom_start_random_army", "wh_dlc05_wef_inf_eternal_guard_0", 16);
		ram:add_unit("custom_start_random_army", "wh_dlc05_wef_inf_eternal_guard_1", 12);
		ram:add_unit("custom_start_random_army", "wh_dlc05_wef_inf_dryads_0", 10);
		ram:add_unit("custom_start_random_army", "wh_dlc05_wef_inf_wardancers_0", 3);
		ram:add_unit("custom_start_random_army", "wh_dlc05_wef_inf_wardancers_1", 1);
		ram:add_unit("custom_start_random_army", "wh_dlc05_wef_inf_wildwood_rangers_0", 1);
		ram:add_unit("custom_start_random_army", "wh_dlc05_wef_inf_glade_guard_0", 10);
		ram:add_unit("custom_start_random_army", "wh_dlc05_wef_inf_glade_guard_1", 6);
		ram:add_unit("custom_start_random_army", "wh_dlc05_wef_inf_glade_guard_2", 5);
		ram:add_unit("custom_start_random_army", "wh_dlc05_wef_inf_deepwood_scouts_0", 4);
		ram:add_unit("custom_start_random_army", "wh_dlc05_wef_inf_deepwood_scouts_1", 2);
		ram:add_unit("custom_start_random_army", "wh_dlc05_wef_inf_waywatchers_0", 1);
		
		--Cavalry
		ram:add_unit("custom_start_random_army", "wh_dlc05_wef_cav_wild_riders_0", 8);
		ram:add_unit("custom_start_random_army", "wh_dlc05_wef_cav_wild_riders_1", 6);
		ram:add_unit("custom_start_random_army", "wh_dlc05_wef_cav_glade_riders_0", 6);
		ram:add_unit("custom_start_random_army", "wh_dlc05_wef_cav_glade_riders_1", 2);
		ram:add_unit("custom_start_random_army", "wh_dlc05_wef_cav_hawk_riders_0", 1);
		ram:add_unit("custom_start_random_army", "wh_dlc05_wef_cav_sisters_thorn_0", 1);
		
		--Monsters
		ram:add_unit("custom_start_random_army", "wh_dlc05_wef_mon_treekin_0", 2);
		ram:add_unit("custom_start_random_army", "wh_dlc05_wef_mon_treeman_0", 1);
		ram:add_unit("custom_start_random_army", "wh_dlc05_wef_mon_great_eagle_0", 1);
		ram:add_unit("custom_start_random_army", "wh_dlc05_wef_forest_dragon_0", 1);
		
	elseif subculture == "wh_main_sc_brt_bretonnia" then
		--Infantry
		ram:add_unit("custom_start_random_army", "wh_dlc07_brt_peasant_mob_0", 12);
		ram:add_unit("custom_start_random_army", "wh_main_brt_inf_spearmen_at_arms", 8);
		ram:add_unit("custom_start_random_army", "wh_dlc07_brt_inf_spearmen_at_arms_1", 3);
		ram:add_unit("custom_start_random_army", "wh_main_brt_inf_men_at_arms", 8);
		ram:add_unit("custom_start_random_army", "wh_dlc07_brt_inf_men_at_arms_1", 4);
		ram:add_unit("custom_start_random_army", "wh_dlc07_brt_inf_men_at_arms_2", 1);
		ram:add_unit("custom_start_random_army", "wh_dlc07_brt_inf_foot_squires_0", 2);
		ram:add_unit("custom_start_random_army", "wh_dlc07_brt_inf_battle_pilgrims_0", 1);
		ram:add_unit("custom_start_random_army", "wh_dlc07_brt_inf_grail_reliquae_0", 1);
		ram:add_unit("custom_start_random_army", "wh_main_brt_inf_peasant_bowmen", 10);
		ram:add_unit("custom_start_random_army", "wh_dlc07_brt_inf_peasant_bowmen_1", 3);
		ram:add_unit("custom_start_random_army", "wh_dlc07_brt_inf_peasant_bowmen_2", 3);
		
		--Cavalry
		ram:add_unit("custom_start_random_army", "wh_dlc07_brt_cav_knights_errant_0", 12);
		ram:add_unit("custom_start_random_army", "wh_main_brt_cav_knights_of_the_realm", 8);
		ram:add_unit("custom_start_random_army", "wh_dlc07_brt_cav_questing_knights_0", 2);
		ram:add_unit("custom_start_random_army", "wh_main_brt_cav_grail_knights", 1);
		ram:add_unit("custom_start_random_army", "wh_dlc07_brt_cav_grail_guardians_0", 1);
		ram:add_unit("custom_start_random_army", "wh_main_brt_cav_mounted_yeomen_0", 4);
		ram:add_unit("custom_start_random_army", "wh_main_brt_cav_mounted_yeomen_1", 8);
		ram:add_unit("custom_start_random_army", "wh_main_brt_cav_pegasus_knights", 1);
		ram:add_unit("custom_start_random_army", "wh_dlc07_brt_cav_royal_pegasus_knights_0", 1);
		ram:add_unit("custom_start_random_army", "wh_dlc07_brt_cav_royal_hippogryph_knights_0", 1);
		
		--Artillery
		ram:add_unit("custom_start_random_army", "wh_main_brt_art_field_trebuchet", 4);
		ram:add_unit("custom_start_random_army", "wh_dlc07_brt_art_blessed_field_trebuchet_0", 1);
		
	elseif subculture == "wh_main_sc_nor_norsca" then
		--Infantry
		ram:add_unit("custom_start_random_army", "wh_main_nor_inf_chaos_marauders_0", 14);
		ram:add_unit("custom_start_random_army", "wh_main_nor_inf_chaos_marauders_1", 10);
		ram:add_unit("custom_start_random_army", "wh_dlc08_nor_inf_marauder_spearman_0", 10);
		ram:add_unit("custom_start_random_army", "wh_dlc08_nor_inf_marauder_berserkers_0", 4);
		ram:add_unit("custom_start_random_army", "wh_dlc08_nor_inf_marauder_hunters_0", 3);
		ram:add_unit("custom_start_random_army", "wh_dlc08_nor_inf_marauder_hunters_1", 1);
		ram:add_unit("custom_start_random_army", "wh_dlc08_nor_inf_marauder_champions_0", 1);
		ram:add_unit("custom_start_random_army", "wh_dlc08_nor_inf_marauder_champions_1", 1);
		
		--Cavalry
		ram:add_unit("custom_start_random_army", "wh_main_nor_cav_marauder_horsemen_0", 10);
		ram:add_unit("custom_start_random_army", "wh_main_nor_cav_marauder_horsemen_1", 4);
		ram:add_unit("custom_start_random_army", "wh_dlc08_nor_cav_marauder_horsemasters_0", 2);
		ram:add_unit("custom_start_random_army", "wh_main_nor_cav_chaos_chariot", 2);
		ram:add_unit("custom_start_random_army", "wh_dlc08_nor_veh_marauder_warwolves_chariot_0", 1);
		
		--Monsters
		ram:add_unit("custom_start_random_army", "wh_main_nor_mon_chaos_warhounds_0", 6);
		ram:add_unit("custom_start_random_army", "wh_dlc08_nor_mon_warwolves_0", 4);
		ram:add_unit("custom_start_random_army", "wh_dlc08_nor_mon_skinwolves_0", 6);
		ram:add_unit("custom_start_random_army", "wh_dlc08_nor_mon_skinwolves_1", 4);
		ram:add_unit("custom_start_random_army", "wh_main_nor_mon_chaos_trolls", 6);
		ram:add_unit("custom_start_random_army", "wh_dlc08_nor_mon_norscan_ice_trolls_0", 2);
		ram:add_unit("custom_start_random_army", "wh_dlc08_nor_mon_norscan_giant_0", 1);
		ram:add_unit("custom_start_random_army", "wh_dlc08_nor_mon_fimir_0", 1);
		ram:add_unit("custom_start_random_army", "wh_dlc08_nor_mon_fimir_1", 1);
		ram:add_unit("custom_start_random_army", "wh_dlc08_nor_feral_manticore", 1);
		ram:add_unit("custom_start_random_army", "wh_dlc08_nor_mon_frost_wyrm_0", 1);
		ram:add_unit("custom_start_random_army", "wh_dlc08_nor_mon_war_mammoth_0", 2);
		ram:add_unit("custom_start_random_army", "wh_dlc08_nor_mon_war_mammoth_1", 1);
		ram:add_unit("custom_start_random_army", "wh_dlc08_nor_mon_war_mammoth_2", 1);
		
	elseif subculture == "wh2_main_sc_def_dark_elves" then
		--Infantry
		ram:add_unit("custom_start_random_army", "wh2_main_def_inf_dreadspears_0", 10);
		ram:add_unit("custom_start_random_army", "wh2_main_def_inf_bleakswords_0", 12);
		ram:add_unit("custom_start_random_army", "wh2_main_def_inf_witch_elves_0", 2);
		ram:add_unit("custom_start_random_army", "wh2_dlc10_def_inf_sisters_of_slaughter", 2);
		ram:add_unit("custom_start_random_army", "wh2_main_def_inf_har_ganeth_executioners_0", 1);
		ram:add_unit("custom_start_random_army", "wh2_main_def_inf_black_guard_0", 1);
		ram:add_unit("custom_start_random_army", "wh2_main_def_inf_black_ark_corsairs_0", 6);
		ram:add_unit("custom_start_random_army", "wh2_main_def_inf_black_ark_corsairs_1", 4);
		ram:add_unit("custom_start_random_army", "wh2_main_def_inf_darkshards_0", 10);
		ram:add_unit("custom_start_random_army", "wh2_main_def_inf_darkshards_1", 8);
		ram:add_unit("custom_start_random_army", "wh2_main_def_inf_shades_0", 4);
		ram:add_unit("custom_start_random_army", "wh2_main_def_inf_shades_1", 2);
		ram:add_unit("custom_start_random_army", "wh2_main_def_inf_shades_2", 1);
		
		--Cavalry
		ram:add_unit("custom_start_random_army", "wh2_main_def_cav_dark_riders_0", 7);
		ram:add_unit("custom_start_random_army", "wh2_main_def_cav_dark_riders_1", 3);
		ram:add_unit("custom_start_random_army", "wh2_main_def_cav_dark_riders_2", 4);
		ram:add_unit("custom_start_random_army", "wh2_dlc10_def_cav_doomfire_warlocks_0", 2);
		ram:add_unit("custom_start_random_army", "wh2_main_def_cav_cold_one_knights_0", 1);
		ram:add_unit("custom_start_random_army", "wh2_main_def_cav_cold_one_knights_1", 1);
		ram:add_unit("custom_start_random_army", "wh2_main_def_cav_cold_one_chariot", 1);
		
		--Monsters
		ram:add_unit("custom_start_random_army", "wh2_main_def_inf_harpies", 6);
		ram:add_unit("custom_start_random_army", "wh2_dlc10_def_mon_feral_manticore_0", 2);
		ram:add_unit("custom_start_random_army", "wh2_main_def_mon_war_hydra", 1);
		ram:add_unit("custom_start_random_army", "wh2_dlc10_def_mon_kharibdyss_0", 1);
		ram:add_unit("custom_start_random_army", "wh2_main_def_mon_black_dragon", 1);
		
		--Artillery
		ram:add_unit("custom_start_random_army", "wh2_main_def_art_reaper_bolt_thrower", 5);
		
	elseif subculture == "wh2_main_sc_hef_high_elves" then
		--Infantry
		ram:add_unit("custom_start_random_army", "wh2_main_hef_inf_spearmen_0", 16);
		ram:add_unit("custom_start_random_army", "wh2_main_hef_inf_white_lions_of_chrace_0", 8);
		ram:add_unit("custom_start_random_army", "wh2_main_hef_inf_swordmasters_of_hoeth_0", 1);
		ram:add_unit("custom_start_random_army", "wh2_main_hef_inf_phoenix_guard", 1);
		ram:add_unit("custom_start_random_army", "wh2_main_hef_inf_archers_0", 18);
		ram:add_unit("custom_start_random_army", "wh2_main_hef_inf_archers_1", 12);
		ram:add_unit("custom_start_random_army", "wh2_main_hef_inf_lothern_sea_guard_0", 8);
		ram:add_unit("custom_start_random_army", "wh2_main_hef_inf_lothern_sea_guard_1", 4);
		ram:add_unit("custom_start_random_army", "wh2_dlc10_hef_inf_shadow_warriors_0", 1);
		ram:add_unit("custom_start_random_army", "wh2_dlc10_hef_inf_sisters_of_avelorn_0", 1);
		
		--Cavalry
		ram:add_unit("custom_start_random_army", "wh2_main_hef_cav_ellyrian_reavers_0", 6);
		ram:add_unit("custom_start_random_army", "wh2_main_hef_cav_ellyrian_reavers_1", 4);
		ram:add_unit("custom_start_random_army", "wh2_main_hef_cav_silver_helms_0", 2);
		ram:add_unit("custom_start_random_army", "wh2_main_hef_cav_silver_helms_1", 1);
		ram:add_unit("custom_start_random_army", "wh2_main_hef_cav_dragon_princes", 1);
		ram:add_unit("custom_start_random_army", "wh2_main_hef_cav_ithilmar_chariot", 2);
		ram:add_unit("custom_start_random_army", "wh2_main_hef_cav_tiranoc_chariot", 1);
		
		--Monsters
		ram:add_unit("custom_start_random_army", "wh2_main_hef_mon_great_eagle", 3);
		ram:add_unit("custom_start_random_army", "wh2_main_hef_mon_moon_dragon", 1);
		ram:add_unit("custom_start_random_army", "wh2_main_hef_mon_sun_dragon", 1);
		ram:add_unit("custom_start_random_army", "wh2_main_hef_mon_star_dragon", 1);
		ram:add_unit("custom_start_random_army", "wh2_main_hef_mon_phoenix_flamespyre", 2);
		ram:add_unit("custom_start_random_army", "wh2_main_hef_mon_phoenix_frostheart", 1);
		
		--Artillery
		ram:add_unit("custom_start_random_army", "wh2_main_hef_art_eagle_claw_bolt_thrower", 4);
		
	elseif subculture == "wh2_main_sc_lzd_lizardmen" then
		--Infantry
		ram:add_unit("custom_start_random_army", "wh2_main_lzd_inf_skink_cohort_0", 12);
		ram:add_unit("custom_start_random_army", "wh2_dlc12_lzd_inf_skink_red_crested_0", 7);
		ram:add_unit("custom_start_random_army", "wh2_main_lzd_inf_saurus_spearmen_0", 12);
		ram:add_unit("custom_start_random_army", "wh2_main_lzd_inf_saurus_spearmen_1", 6);
		ram:add_unit("custom_start_random_army", "wh2_main_lzd_inf_saurus_warriors_0", 12);
		ram:add_unit("custom_start_random_army", "wh2_main_lzd_inf_saurus_warriors_1", 6);
		ram:add_unit("custom_start_random_army", "wh2_main_lzd_inf_temple_guards", 1);
		ram:add_unit("custom_start_random_army", "wh2_main_lzd_inf_skink_cohort_1", 7);
		ram:add_unit("custom_start_random_army", "wh2_main_lzd_inf_skink_skirmishers_0", 6);
		ram:add_unit("custom_start_random_army", "wh2_main_lzd_inf_chameleon_skinks_0", 1);
		
		--Cavalry
		ram:add_unit("custom_start_random_army", "wh2_main_lzd_cav_cold_ones_feral_0", 6);
		ram:add_unit("custom_start_random_army", "wh2_main_lzd_cav_cold_ones_0", 5);
		ram:add_unit("custom_start_random_army", "wh2_main_lzd_cav_cold_ones_1", 5);
		ram:add_unit("custom_start_random_army", "wh2_main_lzd_cav_horned_ones_0", 1);
		ram:add_unit("custom_start_random_army", "wh2_main_lzd_cav_terradon_riders_0", 8);
		ram:add_unit("custom_start_random_army", "wh2_main_lzd_cav_terradon_riders_1", 4);
		ram:add_unit("custom_start_random_army", "wh2_dlc12_lzd_cav_ripperdactyl_riders_0", 1);
		
		--Monsters
		ram:add_unit("custom_start_random_army", "wh2_main_lzd_mon_kroxigors", 2);
		ram:add_unit("custom_start_random_army", "wh2_dlc12_lzd_mon_salamander_pack_0", 4);
		ram:add_unit("custom_start_random_army", "wh2_dlc12_lzd_mon_ancient_salamander_0", 1);
		ram:add_unit("custom_start_random_army", "wh2_main_lzd_mon_bastiladon_0", 4);
		ram:add_unit("custom_start_random_army", "wh2_main_lzd_mon_bastiladon_1", 1);
		ram:add_unit("custom_start_random_army", "wh2_main_lzd_mon_bastiladon_2", 1);
		ram:add_unit("custom_start_random_army", "wh2_dlc12_lzd_mon_bastiladon_3", 1);
		ram:add_unit("custom_start_random_army", "wh2_main_lzd_mon_stegadon_0", 1);
		ram:add_unit("custom_start_random_army", "wh2_main_lzd_mon_stegadon_1", 1);
		ram:add_unit("custom_start_random_army", "wh2_main_lzd_mon_ancient_stegadon", 1);
		ram:add_unit("custom_start_random_army", "wh2_dlc12_lzd_mon_ancient_stegadon_1", 1);
		ram:add_unit("custom_start_random_army", "wh2_main_lzd_mon_carnosaur_0", 1);
		
	elseif subculture == "wh2_main_sc_skv_skaven" then
		--Infantry
		ram:add_unit("custom_start_random_army", "wh2_main_skv_inf_skavenslaves_0", 10);
		ram:add_unit("custom_start_random_army", "wh2_main_skv_inf_skavenslave_spearmen_0", 10);
		ram:add_unit("custom_start_random_army", "wh2_main_skv_inf_clanrats_0", 12);
		ram:add_unit("custom_start_random_army", "wh2_main_skv_inf_clanrats_1", 6);
		ram:add_unit("custom_start_random_army", "wh2_main_skv_inf_clanrat_spearmen_0", 12);
		ram:add_unit("custom_start_random_army", "wh2_main_skv_inf_clanrat_spearmen_1", 6);
		ram:add_unit("custom_start_random_army", "wh2_main_skv_inf_death_runners_0", 2);
		ram:add_unit("custom_start_random_army", "wh2_main_skv_inf_stormvermin_0", 1);
		ram:add_unit("custom_start_random_army", "wh2_main_skv_inf_stormvermin_1", 1);
		ram:add_unit("custom_start_random_army", "wh2_main_skv_inf_plague_monks", 4);
		ram:add_unit("custom_start_random_army", "wh2_main_skv_inf_plague_monk_censer_bearer", 1);
		ram:add_unit("custom_start_random_army", "wh2_main_skv_inf_skavenslave_slingers_0", 6);
		ram:add_unit("custom_start_random_army", "wh2_main_skv_inf_night_runners_0", 4);
		ram:add_unit("custom_start_random_army", "wh2_main_skv_inf_night_runners_1", 1);
		ram:add_unit("custom_start_random_army", "wh2_main_skv_inf_gutter_runners_0", 2);
		ram:add_unit("custom_start_random_army", "wh2_main_skv_inf_gutter_runners_1", 1);
		ram:add_unit("custom_start_random_army", "wh2_main_skv_inf_gutter_runner_slingers_0", 1);
		ram:add_unit("custom_start_random_army", "wh2_main_skv_inf_gutter_runner_slingers_1", 1);
		ram:add_unit("custom_start_random_army", "wh2_main_skv_inf_death_globe_bombardiers", 1);
		ram:add_unit("custom_start_random_army", "wh2_main_skv_inf_poison_wind_globadiers", 1);
		ram:add_unit("custom_start_random_army", "wh2_dlc12_skv_inf_ratling_gun_0", 1);
		ram:add_unit("custom_start_random_army", "wh2_main_skv_inf_warpfire_thrower", 2);
		ram:add_unit("custom_start_random_army", "wh2_dlc12_skv_inf_warplock_jezzails_0", 1);
		
		--Vehicles
		ram:add_unit("custom_start_random_army", "wh2_main_skv_veh_doomwheel", 1);
		ram:add_unit("custom_start_random_army", "wh2_dlc12_skv_veh_doom_flayer_0", 2);
		
		--Monsters
		ram:add_unit("custom_start_random_army", "wh2_main_skv_mon_rat_ogres", 3);
		ram:add_unit("custom_start_random_army", "wh2_main_skv_mon_hell_pit_abomination", 1);
		
		--Artillery
		ram:add_unit("custom_start_random_army", "wh2_main_skv_art_plagueclaw_catapult", 4);
		ram:add_unit("custom_start_random_army", "wh2_main_skv_art_warp_lightning_cannon", 2);
		
	elseif subculture == "wh2_dlc09_sc_tmb_tomb_kings" then
		--Infantry
		ram:add_unit("custom_start_random_army", "wh2_dlc09_tmb_inf_skeleton_warriors_0", 14);
		ram:add_unit("custom_start_random_army", "wh2_dlc09_tmb_inf_skeleton_spearmen_0", 12);
		ram:add_unit("custom_start_random_army", "wh2_dlc09_tmb_inf_tomb_guard_0", 2);
		ram:add_unit("custom_start_random_army", "wh2_dlc09_tmb_inf_tomb_guard_1", 2);
		ram:add_unit("custom_start_random_army", "wh2_dlc09_tmb_inf_nehekhara_warriors_0", 5);
		ram:add_unit("custom_start_random_army", "wh2_dlc09_tmb_inf_skeleton_archers_0", 14);
		
		--Cavalry
		ram:add_unit("custom_start_random_army", "wh2_dlc09_tmb_cav_skeleton_horsemen_0", 8);
		ram:add_unit("custom_start_random_army", "wh2_dlc09_tmb_cav_nehekhara_horsemen_0", 2);
		ram:add_unit("custom_start_random_army", "wh2_dlc09_tmb_veh_skeleton_chariot_0", 2);
		ram:add_unit("custom_start_random_army", "wh2_dlc09_tmb_veh_skeleton_archer_chariot_0", 3);
		ram:add_unit("custom_start_random_army", "wh2_dlc09_tmb_cav_skeleton_horsemen_archers_0", 6);
		ram:add_unit("custom_start_random_army", "wh2_dlc09_tmb_mon_sepulchral_stalkers_0", 3);
		ram:add_unit("custom_start_random_army", "wh2_dlc09_tmb_cav_necropolis_knights_0", 1);
		ram:add_unit("custom_start_random_army", "wh2_dlc09_tmb_cav_necropolis_knights_1", 1);
		
		--Monsters
		ram:add_unit("custom_start_random_army", "wh2_dlc09_tmb_mon_carrion_0", 8);
		ram:add_unit("custom_start_random_army", "wh2_dlc09_tmb_mon_ushabti_0", 4);
		ram:add_unit("custom_start_random_army", "wh2_dlc09_tmb_mon_ushabti_1", 1);
		ram:add_unit("custom_start_random_army", "wh2_dlc09_tmb_veh_khemrian_warsphinx_0", 1);
		ram:add_unit("custom_start_random_army", "wh2_dlc09_tmb_mon_tomb_scorpion_0", 2);
		ram:add_unit("custom_start_random_army", "wh2_dlc09_tmb_mon_heirotitan_0", 1);
		ram:add_unit("custom_start_random_army", "wh2_dlc09_tmb_mon_necrosphinx_0", 1);
		ram:add_unit("custom_start_random_army", "wh2_pro06_tmb_mon_bone_giant_0", 2);
		
		--Artillery
		ram:add_unit("custom_start_random_army", "wh2_dlc09_tmb_art_screaming_skull_catapult_0", 5);
		ram:add_unit("custom_start_random_army", "wh2_dlc09_tmb_art_casket_of_souls_0", 1);
		
	elseif subculture == "wh2_dlc11_sc_cst_vampire_coast" then
		--Infantry
		ram:add_unit("custom_start_random_army", "wh2_dlc11_cst_inf_zombie_deckhands_mob_0", 20);
		ram:add_unit("custom_start_random_army", "wh2_dlc11_cst_inf_zombie_deckhands_mob_1", 10);
		ram:add_unit("custom_start_random_army", "wh2_dlc11_cst_inf_syreens", 3);
		ram:add_unit("custom_start_random_army", "wh2_dlc11_cst_inf_depth_guard_0", 1);
		ram:add_unit("custom_start_random_army", "wh2_dlc11_cst_inf_depth_guard_1", 1);
		ram:add_unit("custom_start_random_army", "wh2_dlc11_cst_inf_zombie_gunnery_mob_0", 10);
		ram:add_unit("custom_start_random_army", "wh2_dlc11_cst_inf_zombie_gunnery_mob_1", 2);
		ram:add_unit("custom_start_random_army", "wh2_dlc11_cst_inf_zombie_gunnery_mob_2", 1);
		ram:add_unit("custom_start_random_army", "wh2_dlc11_cst_inf_zombie_gunnery_mob_3", 1);
		ram:add_unit("custom_start_random_army", "wh2_dlc11_cst_inf_deck_gunners_0", 1);
				
		--Monsters
		ram:add_unit("custom_start_random_army", "wh2_dlc11_cst_cav_deck_droppers_0", 5);
		ram:add_unit("custom_start_random_army", "wh2_dlc11_cst_cav_deck_droppers_1", 1);
		ram:add_unit("custom_start_random_army", "wh2_dlc11_cst_cav_deck_droppers_2", 1);
		ram:add_unit("custom_start_random_army", "wh2_dlc11_cst_mon_fell_bats", 7);
		ram:add_unit("custom_start_random_army", "wh2_dlc11_cst_mon_scurvy_dogs", 6);
		ram:add_unit("custom_start_random_army", "wh2_dlc11_cst_mon_mournguls_0", 2);
		ram:add_unit("custom_start_random_army", "wh2_dlc11_cst_mon_bloated_corpse_0", 10);
		ram:add_unit("custom_start_random_army", "wh2_dlc11_cst_mon_animated_hulks_0", 2);
		ram:add_unit("custom_start_random_army", "wh2_dlc11_cst_mon_rotting_prometheans_0", 1);
		ram:add_unit("custom_start_random_army", "wh2_dlc11_cst_mon_rotting_prometheans_gunnery_mob_0", 1);
		ram:add_unit("custom_start_random_army", "wh2_dlc11_cst_mon_terrorgheist", 1);
		ram:add_unit("custom_start_random_army", "wh2_dlc11_cst_mon_rotting_leviathan_0", 1);
		ram:add_unit("custom_start_random_army", "wh2_dlc11_cst_mon_necrofex_colossus_0", 1);
		
		--Artillery
		ram:add_unit("custom_start_random_army", "wh2_dlc11_cst_art_mortar", 7);
		ram:add_unit("custom_start_random_army", "wh2_dlc11_cst_art_carronade", 4);
		
	else
		script_error("ERROR: generate_random_army() called but supplied subculture [" .. subculture .. "] is not supported");
		return false;
	end
	
	return ram:generate_force("custom_start_random_army", num_units, true);
end

--generates a random name for the relevant faction subculture
function generate_character_name(subculture, subtype)
	local fore_name = "";
	local clan_name = "";
	local family_name = "";
	local other_name = "";
	local names = {};
	
	if subculture == "wh_main_sc_emp_empire" then
		names = {
			{fore = "2147343937", clan = "", family = "2147344037", other = ""}, 	--Boris Hertwig
			{fore = "2147343941", clan = "", family = "2147344064", other = ""}, 	--Marius von Liebwitz
			{fore = "2147343984", clan = "", family = "2147344108", other = ""}, 	--Ludwig Aldrech
			{fore = "2147344017", clan = "", family = "2147354490", other = ""}, 	--Aldebrand Fluss
			{fore = "2147344036", clan = "", family = "2147354518", other = ""}, 	--Wolfram Autlermann
			{fore = "2147344099", clan = "", family = "2147354578", other = ""}, 	--Konrad Pritzkock
			{fore = "2147352765", clan = "", family = "2147354585", other = ""}, 	--Otto Thorpes
			{fore = "2147355011", clan = "", family = "2147354620", other = ""}, 	--Dieter Ludenhower
			{fore = "2147355046", clan = "", family = "2147354631", other = ""}, 	--Wolfgang von Wulfen
			{fore = "2147355056", clan = "", family = "2147354678", other = ""} 	--Johann Hart
		};
	elseif subculture == "wh_main_sc_dwf_dwarfs" then
		names = {
			{fore = "1027251705", clan = "", family = "2147354048", other = ""},	--Thorhall Holdfast
			{fore = "1708936840", clan = "", family = "2147354012", other = ""},	--Worvor Growlsh
			{fore = "2147344203", clan = "", family = "2147353961", other = ""},	--Logazor Truthteller
			{fore = "2147344345", clan = "", family = "2147353948", other = ""},	--Oldor Drenger
			{fore = "2147344337", clan = "", family = "2147353932", other = ""},	--Finn Strongarm
			{fore = "2147345808", clan = "", family = "2147353905", other = ""},	--Barundin Gunnisson
			{fore = "2147354120", clan = "", family = "2147353883", other = ""},	--Boki Norgrimling
			{fore = "2147354167", clan = "", family = "2147353855", other = ""},	--Ulfar Ironwill
			{fore = "2147354204", clan = "", family = "2147344249", other = ""},	--Svenner Proudbeard
			{fore = "2147354230", clan = "", family = "2147344212", other = ""}		--Sindri Brightaxe
		}; 
	elseif subculture == "wh_main_sc_vmp_vampire_counts" then		
		names = {
			{fore = "1928172943", clan = "", family = "680207862", other = ""},		--Gysbrecht Leicheberg
			{fore = "2147345161", clan = "", family = "817148109", other = ""},		--Fritz Barrichmere
			{fore = "2147345209", clan = "", family = "943406012", other = ""},		--Frederick Pfaffbach
			{fore = "2147357278", clan = "", family = "1041741800", other = ""},	--Fremont Skellan
			{fore = "2147357315", clan = "", family = "1199231259", other = ""},	--Willhelm Gerhof
			{fore = "2147357905", clan = "", family = "168545332", other = ""},		--Otto Regak
			{fore = "2147358022", clan = "", family = "2012155459", other = ""},	--Henrik Schtillman
			{fore = "2147358083", clan = "", family = "2147345247", other = ""},	--Oswald Jaeger
			{fore = "2147358194", clan = "", family = "2147357525", other = ""},	--Waldemar von Sinckler
			{fore = "2147358304", clan = "", family = "1003038241", other = ""}		--Oskar zu Krugenheim
		};
	elseif subculture == "wh_main_sc_grn_greenskins" then
		names = {
			{fore = "2147344455", clan = "", family = "2147355468", other = ""}, 	--Snide Toof-Taka
			{fore = "2147344481", clan = "", family = "2147355486", other = ""}, 	--Drok Bogroff
			{fore = "2147344501", clan = "", family = "2147355502", other = ""}, 	--Muga Muckraka
			{fore = "2147344675", clan = "", family = "2147355505", other = ""}, 	--Sour Mudera
			{fore = "2147344803", clan = "", family = "2147355453", other = ""}, 	--Urk Throatcruncha
			{fore = "2147344909", clan = "", family = "2147355514", other = ""}, 	--Ratgash Bootlicka
			{fore = "2147344985", clan = "", family = "2147355395", other = ""}, 	--Morglor Trolleater
			{fore = "2147355554", clan = "", family = "2147344839", other = ""}, 	--Umug Eyegouger
			{fore = "2147345032", clan = "", family = "2147344614", other = ""}, 	--Nobnails Edbut
			{fore = "2147355603", clan = "", family = "2147355538", other = ""} 	--Gozbag Bonecrusha
		};
	elseif subculture == "wh_main_sc_grn_savage_orcs" then
		names = {
			{fore = "2147344455", clan = "", family = "2147355468", other = ""}, 	--Snide Toof-Taka
			{fore = "2147344481", clan = "", family = "2147355486", other = ""}, 	--Drok Bogroff
			{fore = "2147344501", clan = "", family = "2147355502", other = ""}, 	--Muga Muckraka
			{fore = "2147344675", clan = "", family = "2147355505", other = ""}, 	--Sour Mudera
			{fore = "2147344803", clan = "", family = "2147355453", other = ""}, 	--Urk Throatcruncha
			{fore = "2147344909", clan = "", family = "2147355514", other = ""}, 	--Ratgash Bootlicka
			{fore = "2147344985", clan = "", family = "2147355395", other = ""}, 	--Morglor Trolleater
			{fore = "2147355554", clan = "", family = "2147344839", other = ""}, 	--Umug Eyegouger
			{fore = "2147345032", clan = "", family = "2147344614", other = ""}, 	--Nobnails Edbut
			{fore = "2147355603", clan = "", family = "2147355538", other = ""} 	--Gozbag Bonecrusha
		};
	elseif subculture == "wh_dlc03_sc_bst_beastmen" then
		names = {
			{fore = "2147357926", clan = "", family = "2147358680", other = ""}, 	--Skarr Heart-Gorge
			{fore = "2147357945", clan = "", family = "2147358712", other = ""}, 	--Bhorgor Bloodbreath
			{fore = "2147358389", clan = "", family = "2147358808", other = ""}, 	--Rusuizu Tornheart
			{fore = "2147358468", clan = "", family = "2147358760", other = ""}, 	--Slaa Man-Eater
			{fore = "2147358541", clan = "", family = "2147357986", other = ""}, 	--Siidhqu Burrow-Gorger
			{fore = "2147358578", clan = "", family = "2147358895", other = ""}, 	--Aafwub Bloodclaw
			{fore = "2147358597", clan = "", family = "2147358903", other = ""}, 	--Khuguu Halfmind
			{fore = "2147358445", clan = "", family = "2147358009", other = ""}, 	--Guuaa Gorehorn
			{fore = "2147358360", clan = "", family = "2147358811", other = ""}, 	--Akh Soulrend
			{fore = "2147357923", clan = "", family = "2147358757", other = ""} 	--Kloven Soul-Crusher
		};
	elseif subculture == "wh_dlc05_sc_wef_wood_elves" then
		names = {
				{fore = "2147359036", clan = "", family = "", other = ""}, 			--Strathot 
				{fore = "2147359047", clan = "", family = "", other = ""}, 			--Dhulas 
				{fore = "2147359110", clan = "", family = "", other = ""}, 			--Isrostot 
				{fore = "2147359220", clan = "", family = "", other = ""}, 			--Iarac 
				{fore = "2147359231", clan = "", family = "", other = ""}, 			--Dhalsyth 
				{fore = "2147359233", clan = "", family = "", other = ""}, 			--Sesteshal 
				{fore = "2147359118", clan = "", family = "", other = ""}, 			--Orliaruth 
				{fore = "2147359030", clan = "", family = "", other = ""}, 			--Aesrit 
				{fore = "2147359053", clan = "", family = "", other = ""}, 			--Acca 
				{fore = "2147359025", clan = "", family = "", other = ""} 			--Yssellal 
		};		
	elseif subculture == "wh_main_sc_brt_bretonnia" then
		if subtype:find("dlc07_brt_prophetess_") then
			names = {
				{fore = "1006363117", clan = "", family = "2147345469", other = ""}, 	--Vanessa d'Outremer
				{fore = "1040644774", clan = "", family = "2147345471", other = ""}, 	--Angeline le Saracen
				{fore = "105567548", clan = "", family = "2147345475", other = ""}, 	--Cherilyn le Marechal
				{fore = "1057000402", clan = "", family = "2147345485", other = ""}, 	--Nathalie le Troubadour
				{fore = "107879667", clan = "", family = "2147345492", other = ""}, 	--Romane le Jungleur
				{fore = "1116653492", clan = "", family = "2147345501", other = ""}, 	--Ilyse le Chasseur
				{fore = "1130055944", clan = "", family = "2147345510", other = ""}, 	--Jacqueline d'Aquitaine
				{fore = "1194590082", clan = "", family = "2147345511", other = ""}, 	--Mina le Beau
				{fore = "1195331532", clan = "", family = "1008738826", other = ""}, 	--Fleur d'Yderot
				{fore = "1230556090", clan = "", family = "1486457407", other = ""} 	--Margaux Everstone
			};
		else
			names = {
				{fore = "1017721779", clan = "", family = "2147345517", other = ""}, 	--Richard Beastslayer
				{fore = "1050537203", clan = "", family = "2147345528", other = ""}, 	--Esteban Archambault
				{fore = "1069020046", clan = "", family = "2147345530", other = ""}, 	--Nathan Babineaux
				{fore = "1152202501", clan = "", family = "2147345533", other = ""}, 	--Samuel Beaumont
				{fore = "1176502723", clan = "", family = "2147345539", other = ""}, 	--Cedric Béringer
				{fore = "1197344450", clan = "", family = "2147345541", other = ""}, 	--Henk Bisset
				{fore = "1237536125", clan = "", family = "2147345547", other = ""}, 	--Fransiscus Deniaud
				{fore = "1291131263", clan = "", family = "2147345553", other = ""}, 	--Rorik de Sauveterre
				{fore = "1371005350", clan = "", family = "2147345562", other = ""}, 	--Frederique Gagnier
				{fore = "1412580874", clan = "", family = "2147345569", other = ""} 	--Florian Labelle
			};
		end;
	elseif subculture == "wh_main_sc_nor_norsca" then
		names = {
			{fore = "1002972665", clan = "", family = "1004201231", other = ""}, 	--Videmar Mammoth-Rider
			{fore = "1010314968", clan = "", family = "1049452014", other = ""}, 	--Rhagurr Tusktaker
			{fore = "1012073581", clan = "", family = "1080118565", other = ""}, 	--Kharon Snagrsson
			{fore = "1030628873", clan = "", family = "1082261409", other = ""}, 	--Sortsvinaer the Gouger
			{fore = "1060172250", clan = "", family = "1112219668", other = ""}, 	--Tarr of the Gorehunt
			{fore = "1070488151", clan = "", family = "1132597213", other = ""}, 	--Sigwulf Shield-Biter
			{fore = "1091358184", clan = "", family = "1135613655", other = ""}, 	--Ragnar Kraken-Bite
			{fore = "1162975771", clan = "", family = "1139556517", other = ""}, 	--Walker the Slasher
			{fore = "1282984516", clan = "", family = "1237200181", other = ""}, 	--Ormgrim of the Wolfclaw
			{fore = "1305576027", clan = "", family = "1240989680", other = ""} 	--Halvthor Oskharsson
		};
	elseif subculture == "wh2_main_sc_def_dark_elves" then
		if subtype:find("wh2_main_def_dreadlord_fem") or subtype:find("wh2_dlc10_def_supreme_sorceress_") then
			names = {
				{fore = "1003842572", clan = "", family = "", other = ""}, 			--Eva
				{fore = "1005248167", clan = "", family = "", other = ""}, 			--Plyitus
				{fore = "1012272878", clan = "", family = "", other = ""}, 			--Hagrene
				{fore = "1058692048", clan = "", family = "", other = ""}, 			--Myleere
				{fore = "1066656255", clan = "", family = "", other = ""}, 			--Waerna
				{fore = "1073720026", clan = "", family = "", other = ""}, 			--Hulaylian
				{fore = "1087181860", clan = "", family = "", other = ""}, 			--Felicion
				{fore = "1096917599", clan = "", family = "", other = ""}, 			--Alarion
				{fore = "112654795", clan = "", family = "", other = ""}, 			--Boudicca
				{fore = "1126797147", clan = "", family = "", other = ""} 			--Nightshade
			};
		else
			names = {
				{fore = "1043335079", clan = "", family = "", other = ""}, 			--Millen
				{fore = "1145397024", clan = "", family = "", other = ""}, 			--Koval
				{fore = "1225535785", clan = "", family = "", other = ""}, 			--Ramon
				{fore = "1286859150", clan = "", family = "", other = ""}, 			--Ylrishen
				{fore = "1327358560", clan = "", family = "", other = ""}, 			--Azirek
				{fore = "1373918736", clan = "", family = "", other = ""}, 			--Bel-Nenya
				{fore = "139274725", clan = "", family = "", other = ""}, 			--Klendrach
				{fore = "1396496474", clan = "", family = "", other = ""},	 		--Yr-Kithar
				{fore = "1397432329", clan = "", family = "", other = ""}, 			--Maudthekan
				{fore = "1421390481", clan = "", family = "", other = ""} 			--Illiarch
			};
		end;
	elseif subculture == "wh2_main_sc_hef_high_elves" then
		if subtype:find("wh2_main_hef_princess") then
			names = {
				{fore = "1023980541", clan = "", family = "", other = ""}, 			--Altharloss
				{fore = "1044214998", clan = "", family = "", other = ""}, 			--Sheeld
				{fore = "1044995477", clan = "", family = "", other = ""}, 			--Venola
				{fore = "1061636038", clan = "", family = "", other = ""}, 			--Kavinna
				{fore = "1091045834", clan = "", family = "", other = ""}, 			--Deloria
				{fore = "10929957", clan = "", family = "", other = ""}, 			--Rinda
				{fore = "1119925593", clan = "", family = "", other = ""}, 			--Nasheer
				{fore = "1130865469", clan = "", family = "", other = ""},			--Sandrina
				{fore = "1143850849", clan = "", family = "", other = ""},			--Enna
				{fore = "1149635680", clan = "", family = "", other = ""} 			--Zubaran
			};
		else
			names = {
				{fore = "1063475665", clan = "", family = "", other = ""}, 			--Fonahir
				{fore = "1147373454", clan = "", family = "", other = ""}, 			--Eldarion
				{fore = "1197705717", clan = "", family = "", other = ""}, 			--Saji
				{fore = "1218801584", clan = "", family = "", other = ""}, 			--Damien
				{fore = "1254391153", clan = "", family = "", other = ""}, 			--Alondrin
				{fore = "1354862277", clan = "", family = "", other = ""}, 			--Elysion
				{fore = "1359526841", clan = "", family = "", other = ""}, 			--Aeden
				{fore = "1411233647", clan = "", family = "", other = ""}, 			--Fhiron
				{fore = "1435311282", clan = "", family = "", other = ""}, 			--Zoltar
				{fore = "1525341994", clan = "", family = "", other = ""} 			--Fandhir
			};
		end;
	elseif subculture == "wh2_main_sc_lzd_lizardmen" then
		names = {
			{fore = "1012584779", clan = "", family = "", other = ""}, 				--Kalaw
			{fore = "1013532462", clan = "", family = "", other = ""}, 				--Wirim
			{fore = "1016390767", clan = "", family = "", other = ""}, 				--Ra'tul
			{fore = "1018614790", clan = "", family = "", other = ""}, 				--Conquatoc
			{fore = "1022176898", clan = "", family = "", other = ""},				--Praijol
			{fore = "1030065585", clan = "", family = "", other = ""},				--Iren'anar
			{fore = "1042552047", clan = "", family = "", other = ""},				--Rambatan
			{fore = "1047924203", clan = "", family = "", other = ""}, 				--Zlatotta
			{fore = "1059779049", clan = "", family = "", other = ""},				--Rok-Jor
			{fore = "1062390673", clan = "", family = "", other = ""} 				--Karok
		};
	elseif subculture == "wh2_main_sc_skv_skaven" then
		names = {
			{fore = "100271990", clan = "", family = "1184250017", other = ""}, 	--Brom Yolsef
			{fore = "1043050343", clan = "", family = "1276401969", other = ""}, 	--Bak-Bak the Experimenter
			{fore = "1088239444", clan = "", family = "1289169483", other = ""}, 	--Scalpose the Lethal
			{fore = "1100391638", clan = "", family = "139048637", other = ""}, 	--Ognag the Infectious
			{fore = "116980691", clan = "", family = "1414940977", other = ""}, 	--Zapspark the Insane
			{fore = "1178399311", clan = "", family = "1554335585", other = ""}, 	--Infecteek Stabb
			{fore = "1200513675", clan = "", family = "1720903742", other = ""}, 	--Metable the Fabricator
			{fore = "123161244", clan = "", family = "1752261233", other = ""}, 	--Scienlet the Dominator
			{fore = "124304404", clan = "", family = "1812333286", other = ""}, 	--Tyfusrat Skydd
			{fore = "1305842795", clan = "", family = "1814201862", other = ""} 	--Akormh Hemlock
		};
	elseif subculture == "wh2_dlc09_sc_tmb_tomb_kings" then
		names = {
			{fore = "1020465424", clan = "", family = "", other = ""}, 				--Petuhyt
			{fore = "1031264987", clan = "", family = "", other = ""}, 				--Kawatamun
			{fore = "10764423", clan = "", family = "", other = ""}, 				--Omhaf
			{fore = "1078273109", clan = "", family = "", other = ""}, 				--Hatip
			{fore = "112147774", clan = "", family = "", other = ""}, 				--Aharos
			{fore = "1121599619", clan = "", family = "", other = ""}, 				--Senutep
			{fore = "1143749436", clan = "", family = "", other = ""}, 				--Berekht
			{fore = "1146540100", clan = "", family = "", other = ""}, 				--Djenna
			{fore = "1163368971", clan = "", family = "", other = ""}, 				--Inenza
			{fore = "1232023363", clan = "", family = "", other = ""} 				--Kakalekh
		};
	elseif subculture == "wh2_dlc11_sc_cst_vampire_coast" then
		if subtype:find("wh2_dlc11_cst_admiral_fem") then
			names = {
				{fore = "1015687373", clan = "", family = "1003919657", other = ""}, 	--Lana Sinkswell
				{fore = "1175837186", clan = "", family = "1004304689", other = ""}, 	--Maddie Kelp Claw
				{fore = "1292169817", clan = "", family = "1048413402", other = ""}, 	--Penny Butler
				{fore = "1329981000", clan = "", family = "1075450667", other = ""}, 	--Estelle Lowe
				{fore = "1363103152", clan = "", family = "1077961672", other = ""}, 	--Roselyn the Drowner
				{fore = "1435178547", clan = "", family = "1078739176", other = ""}, 	--Kat Half-Mast
				{fore = "14381484", clan = "", family = "1086188503", other = ""}, 		--Felicia Coates
				{fore = "1585435022", clan = "", family = "1093275537", other = ""}, 	--Kelly Notts
				{fore = "1589290222", clan = "", family = "1104849663", other = ""}, 	--Evelyn Deans
				{fore = "1613470346", clan = "", family = "111993090", other = ""} 		--Maggie Oxenfurt
			};
		else
			names = {
				{fore = "1030760937", clan = "", family = "1318593080", other = ""}, 	--Charlie Sawyer
				{fore = "1077378743", clan = "", family = "1324146225", other = ""}, 	--Reid Scott
				{fore = "1087810001", clan = "", family = "1329175883", other = ""}, 	--Arty Boot-Snatcher
				{fore = "1109091435", clan = "", family = "1331308008", other = ""}, 	--Martin Wolesey
				{fore = "111644214", clan = "", family = "1382604376", other = ""}, 	--Peter the Drowned
				{fore = "1121894218", clan = "", family = "1391439533", other = ""}, 	--Ronnie Aldo
				{fore = "1192399688", clan = "", family = "1393118102", other = ""}, 	--Tiny Tim Raynes
				{fore = "1287358079", clan = "", family = "1487815996", other = ""}, 	--Petey Raynor
				{fore = "1304324717", clan = "", family = "1488150802", other = ""}, 	--Lenny Mandell
				{fore = "1328867770", clan = "", family = "1496720696", other = ""} 	--Benny Kelly
			};
		end;
	else
		script_error("ERROR: generate_random_army() called but supplied subculture [" .. subculture .. "] is not supported");
		return false;
	end
	
	local index = cm:random_number(#names);
	
	if names[index].fore ~= "" then
		fore_name = "names_name_" .. names[index].fore;
	end
	if names[index].clan ~= "" then
		clan_name = "names_name_" .. names[index].clan;
	end
	if names[index].family ~= "" then
		family_name = "names_name_" .. names[index].family;
	end
	if names[index].other ~= "" then
		other_name = "names_name_" .. names[index].other;
	end
	
	return {fore_name, clan_name, family_name, other_name};
end