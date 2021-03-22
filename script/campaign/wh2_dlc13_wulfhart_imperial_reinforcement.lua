local wulfhart_faction = "wh2_dlc13_emp_the_huntmarshals_expedition";

local buildings_to_lock = {"wh_main_emp_barracks_3", "wh_main_emp_stables_2", "wh_main_emp_stables_3", "wh_main_emp_forges_2", "wh_main_emp_forges_3"};

local buildings_to_unlock = {
	{},
	{"wh_main_emp_barracks_3", "wh_main_emp_stables_2"},
	{},
	{"wh_main_emp_stables_3", "wh_main_emp_forges_2"},
	{"wh_main_emp_forges_3"},
	{}
};

--these variables define the timing of when imperial supply happens
local imperial_guard_meter = 90;
local imperial_guard_max = 100;
local imperial_guard_charge = {2, 3, 4, 6, 8, 1};

--these variables define the strength level and corresponding incident to trigger when imperial supply happens
local imperial_guard_strength = 1;

local imperial_guard_strength_dilemmas = {
	"wh2_dlc13_wulfhart_imperial_guards_st_0",
	"wh2_dlc13_wulfhart_imperial_guards_st_1",
	"wh2_dlc13_wulfhart_imperial_guards_st_2"
};

local imperial_guard_extra_unit_incidents = {
	"wh2_dlc13_wulfhart_extra_reinforcement_0",
	"wh2_dlc13_wulfhart_extra_reinforcement_1",
	"wh2_dlc13_wulfhart_extra_reinforcement_2"
};

local imperial_guard_strength_detail = {
	{"wh2_dlc13_emp_wulfhart_imperial_supply_0", "wh2_dlc13_emp_wulfhart_imperial_supply_1", "wh2_dlc13_emp_wulfhart_imperial_supply_2", "wh2_dlc13_emp_wulfhart_imperial_supply_3"},
	{"wh2_dlc13_emp_wulfhart_imperial_supply_4", "wh2_dlc13_emp_wulfhart_imperial_supply_5", "wh2_dlc13_emp_wulfhart_imperial_supply_6", "wh2_dlc13_emp_wulfhart_imperial_supply_7"},
	{"wh2_dlc13_emp_wulfhart_imperial_supply_8", "wh2_dlc13_emp_wulfhart_imperial_supply_9", "wh2_dlc13_emp_wulfhart_imperial_supply_10", "wh2_dlc13_emp_wulfhart_imperial_supply_11"}
};

local progress_thresholds = {20, 40, 60, 80, 100};
local progress_merc_strength = {1, 2, 2, 3, 3};
local progress_enemy_strength = {"lizard_retaliate_low", "lizard_retaliate_low", "lizard_retaliate_mid", "lizard_retaliate_mid", "lizard_retaliate_hig"};
local progress_max = 100;
local progress_lock = false;

--these variables controls the wanted bar and progress bar
local wanted_level_current = 0;
local wanted_lvl_increased = 0;

local wanted_level_resource_key = "emp_wanted";
local campaign_progress_resource_key = "emp_progress";
local wanted_level_resource_factors = {
	["increase_major"] = "wh2_dlc13_resource_factor_settlement",
	["increase_minor"] = "wh2_dlc13_resource_factor_harassment",
	["decrease_major"] = "wh2_dlc13_resource_factor_lost_general",
	["decrease_minor"] = "wh2_dlc13_resource_factor_neutral",
	["increase_kill_army"] = "wh2_dlc13_resource_factor_casualty",
	["increase_kill_scripted_army"] = "wh2_dlc13_resource_factor_casualty",
	["increase_event"] = "wh2_dlc09_resource_factor_events",
	["reset"] = "wh2_dlc13_resource_factor_wanted_reset"
};

local wanted_level_resource_intervals = {
	["increase_major"] = 7,
	["increase_minor"] = 2,
	["decrease_major"] = -10,
	["decrease_minor"] = -0.1, 
	["increase_kill_army"] = 3,
	["increase_kill_scripted_army"] = 0,
	["increase_event"] = 10,
	["reset"] = -60
};

local wanted_level_resource_thresholds = {10, 20, 30, 40, 50, 60};

local campaign_progress_resource_factors = {
	["increase"] = "wh2_dlc13_resource_factor_siege",
	["decrease"] = "wh2_dlc13_resource_factor_losing_settlement",
	["increase_ports"] = "wh2_dlc13_resource_factor_building_ports",
	["increase_hunters"] = "wh2_dlc13_resource_factor_hunters_unlocked",
	--["increase_lzd"] = "wh2_dlc13_resource_factor_siege_lizardman"
};

local campaign_progress_resource_intervals = {
	["increase"] = 3,
	["decrease"] = -2,
	["increase_ports"] = 1,
	["increase_hunters"] = 4,
	--["increase_lzd"] = 1
};

local campaign_progress_half = false;

local wanted_level_scripted_army_details = {
	["location"] = {},
	["number"] = {0, 1, 1, 1, 1, 1},
	["strength"] = {"lizard_retaliate_low", "lizard_retaliate_low", "lizard_retaliate_low", "lizard_retaliate_mid", "lizard_retaliate_mid", "lizard_retaliate_hig"},
	["size"] = {5, 5, 10, 14, 14, 18},
	["loc_index"] = {{1, 2}, {1, 2}, {2, 2}, {2, 3}, {3, 4}, {4, 4}}
};

local wanted_level_scripted_army_check_list = {
	["main_warhammer"] = {
		{"wh2_main_the_creeping_jungle_temple_of_kara", "wh2_main_the_creeping_jungle_tlaxtlan"},
		{"wh2_main_the_creeping_jungle_tlaxtlan", "wh2_main_northern_great_jungle_chaqua"},
		{"wh2_main_northern_great_jungle_chaqua", "wh2_main_spine_of_sotek_hualotal", "wh2_main_northern_great_jungle_xlanhuapec", "wh2_main_southern_great_jungle_itza"},
		{"wh2_main_northern_great_jungle_xlanhuapec", "wh2_main_southern_great_jungle_axlotl"},
		{"wh2_main_southern_great_jungle_itza", "wh2_main_spine_of_sotek_hualotal"},
		{"wh2_main_spine_of_sotek_hualotal", "wh2_main_huahuan_desert_sentinels_of_xeti"},
		{"wh2_main_vampire_coast_the_awakening", "wh2_main_northern_great_jungle_xlanhuapec"},
		{"wh2_main_volcanic_islands_the_star_tower", "wh2_main_vampire_coast_the_awakening"},
		{"wh2_main_the_creeping_jungle_temple_of_kara", "wh2_main_southern_jungle_of_pahualaxa_the_high_sentinel"},
		{"wh2_main_southern_jungle_of_pahualaxa_the_high_sentinel", "wh2_main_southern_jungle_of_pahualaxa_monument_of_the_moon", "wh2_main_northern_jungle_of_pahualaxa_macu_peaks"},
		{"wh2_main_northern_jungle_of_pahualaxa_macu_peaks", "wh2_main_isthmus_of_lustria_hexoatl"},
		{"wh2_main_isthmus_of_lustria_hexoatl", "wh2_main_isthmus_of_lustria_fallen_gates", "wh2_main_isthmus_of_lustria_ziggurat_of_dawn"},
		{"wh2_main_the_black_coast_bleak_hold_fortress", "wh2_main_doom_glades_hag_hall"},
		{"wh2_main_doom_glades_vauls_anvil", "wh2_main_doom_glades_temple_of_addaioth"},
		{"wh2_main_doom_glades_temple_of_addaioth"},
		{"wh2_main_southern_great_jungle_axlotl"},
		{"wh2_main_huahuan_desert_sentinels_of_xeti"},
		{"wh2_main_southern_jungle_of_pahualaxa_floating_pyramid"},
		{"wh2_main_southern_jungle_of_pahualaxa_monument_of_the_moon"},
		{"wh2_main_isthmus_of_lustria_fallen_gates"},
		{"wh2_main_isthmus_of_lustria_ziggurat_of_dawn"},
		{"wh2_main_doom_glades_hag_hall"}, 
		{"wh2_main_eataine_lothern"},
		{"wh2_main_caledor_vauls_anvil"},
		{"wh2_main_tiranoc_tor_anroc"}, 
		{"wh2_main_nagarythe_tor_anlec"}, 
		{"wh2_main_cothique_tor_koruali"},
		{"wh_main_estalia_magritta"}, 
		{"wh_main_tilea_miragliano"},
		{"wh2_main_sartosa_sartosa"}, 
		{"wh_main_western_border_princes_myrmidens"},
		{"wh_main_carcassone_et_brionne_castle_carcassonne"},
		{"wh_main_bastonne_et_montfort_castle_bastonne"},
		{"wh_main_the_wasteland_marienburg"},
		{"wh_main_reikland_altdorf"},
		{"wh_main_averland_averheim"},
		{"wh_main_middenland_middenheim"},
		{"wh_main_bordeleaux_et_aquitaine_bordeleaux"}
	},
	["wh2_main_great_vortex"] = {
		{"wh2_main_vor_scorpion_coast_temple_of_tlencan", "wh2_main_vor_the_creeping_jungle_tlaxtlan"},
		{"wh2_main_vor_the_creeping_jungle_tlaxtlan", "wh2_main_vor_the_creeping_jungle_tlanxla", "wh2_main_vor_northern_great_jungle_chaqua"},
		{"wh2_main_vor_northern_great_jungle_chaqua", "wh2_main_vor_northern_great_jungle_quetza", "wh2_main_vor_northern_great_jungle_itza"},
		{"wh2_main_vor_northern_great_jungle_itza", "wh2_main_vor_southern_great_jungle_xhotl", "wh2_main_vor_southern_great_jungle_mortuary_of_tzulaqua"},
		{"wh2_main_vor_southern_great_jungle_mortuary_of_tzulaqua", "wh2_main_vor_southern_great_jungle_gwakmol_crater", "wh2_main_vor_the_lost_valleys_oyxl"},
		{"wh2_main_vor_the_lost_valleys_oyxl", "wh2_main_vor_the_lost_valleys_subatuun", "wh2_main_vor_culchan_plains_kaiax"},
		{"wh2_main_vor_culchan_plains_kaiax", "wh2_main_vor_culchan_plains_xlansec"} 
	}
};

local wanted_level_scripted_army_spawn_loc = {
	["wh2_main_vor_the_creeping_jungle_tlaxtlan"]					= {159, 278},
	["wh2_main_vor_the_creeping_jungle_tlanxla"]					= {144, 273},
	["wh2_main_vor_northern_great_jungle_chaqua"]					= {171, 250},
	["wh2_main_vor_northern_great_jungle_quetza"]					= {215, 215},
	["wh2_main_vor_northern_great_jungle_itza"]						= {194, 190},
	["wh2_main_vor_southern_great_jungle_xhotl"]					= {171, 147},
	["wh2_main_vor_southern_great_jungle_mortuary_of_tzulaqua"] 	= {204, 157},
	["wh2_main_vor_southern_great_jungle_gwakmol_crater"]			= {175, 129},
	["wh2_main_vor_the_lost_valleys_oyxl"]							= {242, 121},
	["wh2_main_vor_the_lost_valleys_subatuun"]						= {184, 115},
	["wh2_main_vor_culchan_plains_kaiax"]							= {265, 54},
	["wh2_main_vor_culchan_plains_xlansec"]							= {319, 59},
	["wh2_main_vor_scorpion_coast_temple_of_tlencan"]				= {176, 319},
	["wh2_main_the_creeping_jungle_tlaxtlan"]						= {112, 152},
	["wh2_main_northern_great_jungle_chaqua"]						= {119, 105},
	["wh2_main_spine_of_sotek_hualotal"]							= {84, 67},
	["wh2_main_southern_great_jungle_axlotl"]						= {168, 64},
	["wh2_main_huahuan_desert_sentinels_of_xeti"]					= {13, 51},
	["wh2_main_the_creeping_jungle_temple_of_kara"]					= {118, 180},
	["wh2_main_southern_jungle_of_pahualaxa_floating_pyramid"]		= {73, 202},
	["wh2_main_southern_jungle_of_pahualaxa_monument_of_the_moon"]	= {97, 249},
	["wh2_main_isthmus_of_lustria_fallen_gates"]					= {11, 326},
	["wh2_main_isthmus_of_lustria_ziggurat_of_dawn"]				= {78, 322},
	["wh2_main_doom_glades_hag_hall"]								= {73, 462},
	["wh2_main_doom_glades_temple_of_addaioth"]						= {54, 496},
	["wh2_main_northern_great_jungle_xlanhuapec"]					= {163, 93},
	["wh2_main_northern_jungle_of_pahualaxa_macu_peaks"]			= {49, 246},
	["wh2_main_vampire_coast_the_awakening"]						= {216, 117},
	["wh2_main_volcanic_islands_the_star_tower"]					= {239, 88},
	["wh2_main_southern_great_jungle_itza"]							= {123, 60},
	["wh2_main_southern_jungle_of_pahualaxa_the_high_sentinel"]		= {90, 237},
	["wh2_main_isthmus_of_lustria_hexoatl"]							= {50, 304},
	["wh2_main_the_black_coast_bleak_hold_fortress"]				= {87, 401},
	["wh2_main_doom_glades_vauls_anvil"]							= {93, 470},
	["wh2_main_eataine_lothern"]									= {213, 207},
	["wh2_main_caledor_vauls_anvil"]								= {173, 273},
	["wh2_main_tiranoc_tor_anroc"]									= {128, 347},
	["wh2_main_nagarythe_tor_anlec"]								= {192, 424},
	["wh2_main_cothique_tor_koruali"]								= {283, 384},
	["wh_main_estalia_magritta"]									= {394, 248},
	["wh_main_tilea_miragliano"]									= {480, 278},
	["wh2_main_sartosa_sartosa"]									= {478, 210},
	["wh_main_western_border_princes_myrmidens"]					= {553, 255},
	["wh_main_carcassone_et_brionne_castle_carcassonne"]			= {428, 306},
	["wh_main_bastonne_et_montfort_castle_bastonne"]				= {402, 403},
	["wh_main_the_wasteland_marienburg"]							= {410, 474},
	["wh_main_reikland_altdorf"]									= {489, 442},
	["wh_main_averland_averheim"]									= {595, 406},
	["wh_main_middenland_middenheim"]								= {528, 504},
	["wh_main_bordeleaux_et_aquitaine_bordeleaux"]					= {375, 398}
};

local wanted_level_scripted_army_spawn_detail_main = {
	["wh2_main_the_creeping_jungle_tlaxtlan"]						= {"", "wh2_dlc13_lzd_avengers"},
	["wh2_main_northern_great_jungle_chaqua"]						= {"", "wh2_dlc13_lzd_avengers"},
	["wh2_main_spine_of_sotek_hualotal"]							= {"_skv", "wh2_main_skv_skaven_qb1"},
	["wh2_main_southern_great_jungle_axlotl"]						= {"_skv", "wh2_main_skv_skaven_qb1"},
	["wh2_main_huahuan_desert_sentinels_of_xeti"]					= {"", "wh2_dlc13_lzd_avengers"},
	["wh2_main_the_creeping_jungle_temple_of_kara"]					= {"", "wh2_dlc13_lzd_avengers"},
	["wh2_main_southern_jungle_of_pahualaxa_floating_pyramid"]		= {"_grn", "wh_main_grn_greenskins_qb1"},
	["wh2_main_southern_jungle_of_pahualaxa_monument_of_the_moon"]	= {"_cst", "wh2_dlc11_cst_vampire_coast_qb1"},
	["wh2_main_isthmus_of_lustria_fallen_gates"]					= {"", "wh2_dlc13_lzd_avengers"},
	["wh2_main_isthmus_of_lustria_ziggurat_of_dawn"]				= {"_cst", "wh2_dlc11_cst_vampire_coast_qb1"},
	["wh2_main_doom_glades_hag_hall"]								= {"_def", "wh2_main_def_dark_elves_qb1"},
	["wh2_main_doom_glades_temple_of_addaioth"]						= {"_def", "wh2_main_def_dark_elves_qb1"},
	["wh2_main_northern_great_jungle_xlanhuapec"]					= {"", "wh2_dlc13_lzd_avengers"},
	["wh2_main_northern_jungle_of_pahualaxa_macu_peaks"]			= {"_grn", "wh_main_grn_greenskins_qb1"},
	["wh2_main_vampire_coast_the_awakening"]						= {"_cst", "wh2_dlc11_cst_vampire_coast_qb1"},
	["wh2_main_volcanic_islands_the_star_tower"]					= {"_skv", "wh2_main_skv_skaven_qb1"},
	["wh2_main_southern_great_jungle_itza"]							= {"", "wh2_dlc13_lzd_avengers"},
	["wh2_main_southern_jungle_of_pahualaxa_the_high_sentinel"]		= {"_grn", "wh_main_grn_greenskins_qb1"},
	["wh2_main_isthmus_of_lustria_hexoatl"]							= {"", "wh2_dlc13_lzd_avengers"},
	["wh2_main_the_black_coast_bleak_hold_fortress"]				= {"_def", "wh2_main_def_dark_elves_qb1"},
	["wh2_main_doom_glades_vauls_anvil"]							= {"_def", "wh2_main_def_dark_elves_qb1"},
	["wh2_main_eataine_lothern"]									= {"_cst", "wh2_dlc11_cst_vampire_coast_qb1"},
	["wh2_main_caledor_vauls_anvil"]								= {"_def", "wh2_main_def_dark_elves_qb1"},
	["wh2_main_tiranoc_tor_anroc"]									= {"_cst", "wh2_dlc11_cst_vampire_coast_qb1"},
	["wh2_main_nagarythe_tor_anlec"]								= {"_def", "wh2_main_def_dark_elves_qb1"},
	["wh2_main_cothique_tor_koruali"]								= {"_def", "wh2_main_def_dark_elves_qb1"},
	["wh_main_estalia_magritta"]									= {"_emp", "wh_main_emp_empire_qb1"},
	["wh_main_tilea_miragliano"]									= {"_emp", "wh_main_emp_empire_qb1"},
	["wh2_main_sartosa_sartosa"]									= {"_cst", "wh2_dlc11_cst_vampire_coast_qb1"},
	["wh_main_western_border_princes_myrmidens"]					= {"_emp", "wh_main_emp_empire_qb1"},
	["wh_main_carcassone_et_brionne_castle_carcassonne"]			= {"_grn", "wh_main_grn_greenskins_qb1"},
	["wh_main_bastonne_et_montfort_castle_bastonne"]				= {"_grn", "wh_main_grn_greenskins_qb1"},
	["wh_main_the_wasteland_marienburg"]							= {"_emp", "wh_main_emp_empire_qb1"},
	["wh_main_reikland_altdorf"]									= {"_emp", "wh_main_emp_empire_qb1"},
	["wh_main_averland_averheim"]									= {"_emp", "wh_main_emp_empire_qb1"},
	["wh_main_middenland_middenheim"]								= {"_emp", "wh_main_emp_empire_qb1"},
	["wh_main_bordeleaux_et_aquitaine_bordeleaux"]					= {"_grn", "wh_main_grn_greenskins_qb1"}
};

local queued_army_spawn = {
	["counter"] = 2,
	["army_detail"] = {"lizard_retaliate_low", "wh2_dlc13_lzd_avengers"},
	["loc"] = {"wh2_main_the_creeping_jungle_temple_of_kara", {118, 180}},
	["valid"] = false
};

local wanted_level_scripted_army_expire_counter_default = 5;
local wanted_level_scripted_army_expire_counter = wanted_level_scripted_army_expire_counter_default;

local wanted_level_decay_counter_default = 5;
local wanted_level_decay_counter = wanted_level_decay_counter_default;

local wanted_level_5_lock_counter_default = 5;
local wanted_level_5_lock_counter = 0;

local wanted_level_change_events = {
	["increase"] = {"wh2_dlc13_emp_wulfhart_wanted_level_0", "wh2_dlc13_emp_wulfhart_wanted_level_1", "wh2_dlc13_emp_wulfhart_wanted_level_2", "wh2_dlc13_emp_wulfhart_wanted_level_3", "wh2_dlc13_emp_wulfhart_wanted_level_4", "wh2_dlc13_emp_wulfhart_wanted_level_5"},
	["decrease"] = "wh2_dlc13_emp_wulfhart_wanted_level_decreased",
	["reset"] = "wh2_dlc13_emp_wulfhart_wanted_level_reset"
};

local wanted_level_enemy_buffs = {
	"",
	"wh2_dlc13_wanted_level_enemy_buff_1",
	"wh2_dlc13_wanted_level_enemy_buff_2",
	"wh2_dlc13_wanted_level_enemy_buff_3",
	"wh2_dlc13_wanted_level_enemy_buff_4",
	"wh2_dlc13_wanted_level_enemy_buff_5"
};

local wanted_level_scripted_army_counter = 0;
local wanted_level_scripted_army_list = {};

local wanted_level_scripted_army_faction = "wh2_dlc13_lzd_avengers";

local elector_count_counter_default = 9;
local elector_count_reward_counter_default = 4;

local elector_count_index = {"a", "b", "c", "d", "e", "f", "g", "h", "i", "j"};

--elector count details, name, affinity, and favor effect dummy
local elector_count_details = {
	["a"] = {"averland", 0, "wh2_dlc13_wulfhart_favor_of_A_dummy"},
	["b"] = {"reikland", 0, "wh2_dlc13_wulfhart_favor_of_B_dummy"},
	["c"] = {"hochland", 0, "wh2_dlc13_wulfhart_favor_of_C_dummy"},
	["d"] = {"middenland", 0, "wh2_dlc13_wulfhart_favor_of_D_dummy"},
	["e"] = {"nordland", 0, "wh2_dlc13_wulfhart_favor_of_E_dummy"},
	["f"] = {"ostermark", 0, "wh2_dlc13_wulfhart_favor_of_F_dummy"},
	["g"] = {"ostland", 0, "wh2_dlc13_wulfhart_favor_of_G_dummy"},
	["h"] = {"stirland", 0, "wh2_dlc13_wulfhart_favor_of_H_dummy"},
	["i"] = {"talabecland", 0, "wh2_dlc13_wulfhart_favor_of_I_dummy"},
	["j"] = {"wissenland", 0, "wh2_dlc13_wulfhart_favor_of_J_dummy"},
	["counter"] = elector_count_counter_default,
	["ongoing"] = false
};

local elector_count_weight_table = {1, 1, 1, 1, 1, 2, 2, 2};

local elector_count_dilemmas = {
	["a"] = {
		"wh2_dlc13_wulfhart_dilemma_A_D_H",
		"wh2_dlc13_wulfhart_dilemma_A_E_I",
		"wh2_dlc13_wulfhart_dilemma_A_F_J",
		"wh2_dlc13_wulfhart_dilemma_A_G_H",
		"wh2_dlc13_wulfhart_dilemma_D_H_A",
		"wh2_dlc13_wulfhart_dilemma_E_J_A",
		"wh2_dlc13_wulfhart_dilemma_F_I_A",
		"wh2_dlc13_wulfhart_dilemma_G_H_A",
		"wh2_dlc13_wulfhart_dilemma_H_A_E",
		"wh2_dlc13_wulfhart_dilemma_I_A_D",
		"wh2_dlc13_wulfhart_dilemma_J_A_G"
	},
	["b"] = {
		"wh2_dlc13_wulfhart_dilemma_B_D_I",
		"wh2_dlc13_wulfhart_dilemma_B_E_J",
		"wh2_dlc13_wulfhart_dilemma_B_F_H",
		"wh2_dlc13_wulfhart_dilemma_B_G_I",
		"wh2_dlc13_wulfhart_dilemma_D_I_B",
		"wh2_dlc13_wulfhart_dilemma_E_H_B",
		"wh2_dlc13_wulfhart_dilemma_F_J_B",
		"wh2_dlc13_wulfhart_dilemma_G_I_B",
		"wh2_dlc13_wulfhart_dilemma_H_B_F",
		"wh2_dlc13_wulfhart_dilemma_I_B_E",
		"wh2_dlc13_wulfhart_dilemma_J_B_D"
	},
	["c"] = {
		"wh2_dlc13_wulfhart_dilemma_C_D_J",
		"wh2_dlc13_wulfhart_dilemma_C_E_H",
		"wh2_dlc13_wulfhart_dilemma_C_F_I",
		"wh2_dlc13_wulfhart_dilemma_C_G_J",
		"wh2_dlc13_wulfhart_dilemma_D_J_C",
		"wh2_dlc13_wulfhart_dilemma_E_I_C",
		"wh2_dlc13_wulfhart_dilemma_F_H_C",
		"wh2_dlc13_wulfhart_dilemma_G_J_C",
		"wh2_dlc13_wulfhart_dilemma_H_C_G",
		"wh2_dlc13_wulfhart_dilemma_I_C_F",
		"wh2_dlc13_wulfhart_dilemma_J_C_E"
	},
	["d"] = {
		"wh2_dlc13_wulfhart_dilemma_A_D_H",
		"wh2_dlc13_wulfhart_dilemma_B_D_I",
		"wh2_dlc13_wulfhart_dilemma_C_D_J",
		"wh2_dlc13_wulfhart_dilemma_D_H_A",
		"wh2_dlc13_wulfhart_dilemma_D_I_B",
		"wh2_dlc13_wulfhart_dilemma_D_J_C",
		"wh2_dlc13_wulfhart_dilemma_I_A_D",
		"wh2_dlc13_wulfhart_dilemma_J_B_D"
	},
	["e"] = {
		"wh2_dlc13_wulfhart_dilemma_A_E_I",
		"wh2_dlc13_wulfhart_dilemma_B_E_J",
		"wh2_dlc13_wulfhart_dilemma_C_E_H",
		"wh2_dlc13_wulfhart_dilemma_E_H_B",
		"wh2_dlc13_wulfhart_dilemma_E_I_C",
		"wh2_dlc13_wulfhart_dilemma_E_J_A",
		"wh2_dlc13_wulfhart_dilemma_H_A_E",
		"wh2_dlc13_wulfhart_dilemma_I_B_E",
		"wh2_dlc13_wulfhart_dilemma_J_C_E"
	},
	["f"] = {
		"wh2_dlc13_wulfhart_dilemma_A_F_J",
		"wh2_dlc13_wulfhart_dilemma_B_F_H",
		"wh2_dlc13_wulfhart_dilemma_C_F_I",
		"wh2_dlc13_wulfhart_dilemma_F_H_C",
		"wh2_dlc13_wulfhart_dilemma_F_I_A",
		"wh2_dlc13_wulfhart_dilemma_F_J_B",
		"wh2_dlc13_wulfhart_dilemma_H_B_F",
		"wh2_dlc13_wulfhart_dilemma_I_C_F"
	},
	["g"] = {
		"wh2_dlc13_wulfhart_dilemma_A_G_H",
		"wh2_dlc13_wulfhart_dilemma_B_G_I",
		"wh2_dlc13_wulfhart_dilemma_C_G_J",
		"wh2_dlc13_wulfhart_dilemma_G_H_A",
		"wh2_dlc13_wulfhart_dilemma_G_I_B",
		"wh2_dlc13_wulfhart_dilemma_G_J_C",
		"wh2_dlc13_wulfhart_dilemma_H_C_G",
		"wh2_dlc13_wulfhart_dilemma_J_A_G"
	},
	["h"] = {
		"wh2_dlc13_wulfhart_dilemma_A_D_H",
		"wh2_dlc13_wulfhart_dilemma_A_G_H",
		"wh2_dlc13_wulfhart_dilemma_B_F_H",
		"wh2_dlc13_wulfhart_dilemma_C_E_H",
		"wh2_dlc13_wulfhart_dilemma_E_H_B",
		"wh2_dlc13_wulfhart_dilemma_F_H_C",
		"wh2_dlc13_wulfhart_dilemma_G_H_A",
		"wh2_dlc13_wulfhart_dilemma_H_A_E",
		"wh2_dlc13_wulfhart_dilemma_H_B_F",
		"wh2_dlc13_wulfhart_dilemma_H_C_G"
	},
	["i"] = {
		"wh2_dlc13_wulfhart_dilemma_A_E_I",
		"wh2_dlc13_wulfhart_dilemma_B_D_I",
		"wh2_dlc13_wulfhart_dilemma_B_G_I",
		"wh2_dlc13_wulfhart_dilemma_C_F_I",
		"wh2_dlc13_wulfhart_dilemma_D_I_B",
		"wh2_dlc13_wulfhart_dilemma_E_I_C",
		"wh2_dlc13_wulfhart_dilemma_F_I_A",
		"wh2_dlc13_wulfhart_dilemma_G_I_B",
		"wh2_dlc13_wulfhart_dilemma_I_A_D",
		"wh2_dlc13_wulfhart_dilemma_I_B_E",
		"wh2_dlc13_wulfhart_dilemma_I_C_F"
	},
	["j"] = {
		"wh2_dlc13_wulfhart_dilemma_A_F_J",
		"wh2_dlc13_wulfhart_dilemma_B_E_J",
		"wh2_dlc13_wulfhart_dilemma_C_D_J",
		"wh2_dlc13_wulfhart_dilemma_C_G_J",
		"wh2_dlc13_wulfhart_dilemma_D_J_C",
		"wh2_dlc13_wulfhart_dilemma_E_J_A",
		"wh2_dlc13_wulfhart_dilemma_F_J_B",
		"wh2_dlc13_wulfhart_dilemma_G_J_C",
		"wh2_dlc13_wulfhart_dilemma_J_A_G",
		"wh2_dlc13_wulfhart_dilemma_J_B_D",
		"wh2_dlc13_wulfhart_dilemma_J_C_E"
	}
};

local elector_count_incidents = {
	["a"] = {"wh2_dlc13_wulfhart_reward_A", "wh2_dlc13_wulfhart_reward_A_unit"},
	["b"] = {"wh2_dlc13_wulfhart_reward_B", "wh2_dlc13_wulfhart_reward_B_unit"},
	["c"] = {"wh2_dlc13_wulfhart_reward_C", "wh2_dlc13_wulfhart_reward_C_unit"},
	["d"] = {"wh2_dlc13_wulfhart_reward_D", "wh2_dlc13_wulfhart_reward_D_unit"},
	["e"] = {"wh2_dlc13_wulfhart_reward_E", "wh2_dlc13_wulfhart_reward_E_unit"},
	["f"] = {"wh2_dlc13_wulfhart_reward_F", "wh2_dlc13_wulfhart_reward_F_unit"},
	["g"] = {"wh2_dlc13_wulfhart_reward_G", "wh2_dlc13_wulfhart_reward_G_unit"},
	["h"] = {"wh2_dlc13_wulfhart_reward_H", "wh2_dlc13_wulfhart_reward_H_unit"},
	["i"] = {"wh2_dlc13_wulfhart_reward_I", "wh2_dlc13_wulfhart_reward_I_unit"},
	["j"] = {"wh2_dlc13_wulfhart_reward_J", "wh2_dlc13_wulfhart_reward_J_unit"},
	["generic"] = {
		"wh2_dlc13_wulfhart_reward_1",
		"wh2_dlc13_wulfhart_reward_2",
		"wh2_dlc13_wulfhart_reward_3"
	},
	["threshold"] = 5
};

local elector_count_reward_queued = {
	["event"] = "",
	["counter"] = 0,
	["active"] = false
};

local special_effect_bundles = {
	["supply_delay"] = "wh2_dlc13_wulfhart_imperial_supply_delay",
	["supply_buff"] = "wh2_dlc13_wulfhart_stronger_imperial_supply",
	["wanted_increase"] = "wh2_dlc13_wulfhart_wanted_bar_increase"
};

local supply_delay_counter = 0;

local spawn_location = {
	["main_warhammer"] = {
		{
			{113, 134}, {102,139}, {99, 133}
		},
		{
			{176, 95}, {164, 93}, {165, 108}
		},
		{
			{125, 51}, {122, 60}, {138, 60}
		},
		{
			{21, 27}, {35, 24}, {33, 33}
		}
	},
	["wh2_main_great_vortex"] = {
		{
			{174, 260}, {162, 259}, {156, 257}
		},
		{
			{239, 295}, {238, 280}, {232, 287}
		},
		{
			{182, 175}, {179, 186}, {199, 179}
		},
		{
			{123, 120}, {116, 117}, {101, 126}
		}
	}
};

function initialize_imperial_guard_listeners()
	update_progress_bar();
	wanted_level_scripted_army_details["location"] = spawn_location[get_campaign_key()]; 
	setup_lizard_army();
	
	core:add_listener(
		"Wulfhart_MissionSucceeded",
		"MissionSucceeded",
		function(context)
			return context:mission():mission_record_key() == "wh2_dlc13_qb_emp_final_battle_wulfhart";
		end,
		function()
			core:svr_save_registry_bool("hunter_wulfhart_win", true);
			cm:register_instant_movie("warhammer2/hunter/hunter_wulfhart_win");
		end,
		false
	);
	
	update_ui_component_accordingly();
end

function get_campaign_key()
	if cm:model():campaign_name("wh2_main_great_vortex") then
		return "wh2_main_great_vortex";
	else
		return "main_warhammer";
	end;
end;

function get_spawn_loc()
	if get_campaign_key() == "wh2_main_great_vortex" then
		return get_loc_in_path(wanted_level_scripted_army_check_list["wh2_main_great_vortex"]);
	elseif get_campaign_key() == "main_warhammer" then
		return get_random_element(get_location_list("main_warhammer"));
	end
end;

function get_location_list(campaign_key)
	local direction = {};
	for i = 1, #wanted_level_scripted_army_check_list[campaign_key] do
		local region = cm:get_region(wanted_level_scripted_army_check_list[campaign_key][i][1]);
		local owning_faction = region:owning_faction();
		if not owning_faction:is_null_interface() and owning_faction:name() == wulfhart_faction then
			table.insert(direction, wanted_level_scripted_army_check_list[campaign_key][i][1]);
		end
	end
	if #direction == 0 then
		table.insert(direction, wanted_level_scripted_army_check_list[campaign_key][1][1]);
	end
	return direction;
end

function get_loc_in_path(path) 
	local occupied_loc = {};
	local occupied_loc_available_slots = {};
	
	for i = 1, #path do
		local current_list = path[i];
		local target = current_list[1];
		local region = cm:get_region(target);
		local owning_faction = region:owning_faction();
		
		if not owning_faction:is_null_interface() and owning_faction:name() == wulfhart_faction then
			table.insert(occupied_loc, target);
			
			for j = 2, #current_list do
				local candidate = cm:get_region(current_list[j]);
				local candidate_owning_faction = candidate:owning_faction();
				
				if candidate_owning_faction:is_null_interface() or candidate_owning_faction:name() ~= wulfhart_faction then
					table.insert(occupied_loc_available_slots, candidate:name());
				end;
			end;
		end;
	end;
		
		if #occupied_loc == 0 then
			--unexplored, head of path
			return path[1][1];
		elseif #occupied_loc_available_slots == 0 then
			--exhausted, tail of path
			return path[#path][#path[#path]];
		else
			--exploring, frontline of path
			return get_random_element(occupied_loc_available_slots);
		end;
end

function lock_buildings(index)
	for i = index, #buildings_to_lock do
		cm:add_event_restricted_building_record_for_faction(buildings_to_lock[i], wulfhart_faction, "wulfhart_building_lock");
	end;
end;

core:add_listener(
	"apply_wanted_level_enemy_buff_bundle",
	"PendingBattle",
	function()
		return not cm:model():pending_battle():has_been_fought();
	end,
	function()
		local faction = cm:get_faction(wulfhart_faction);
		
		if faction and faction:is_human() then 
			local all_attacker_mf_cqi, all_defender_mf_cqi, wulfhart_atking, wulfhart_defing = get_wulfhart_characters_from_battle();
			
				if wulfhart_atking and #all_defender_mf_cqi > 0 then
					check_and_remove_effect_bundles(all_defender_mf_cqi);
				elseif wulfhart_defing and #all_attacker_mf_cqi > 0 then
					check_and_remove_effect_bundles(all_attacker_mf_cqi);
				end

				if wulfhart_atking and #all_defender_mf_cqi > 0 and wanted_level_enemy_buffs[wanted_level_current+1]~="" then
					for i =1, #all_defender_mf_cqi do
						cm:apply_effect_bundle_to_force(wanted_level_enemy_buffs[wanted_level_current+1], all_defender_mf_cqi[i], 1);
					end
				elseif wulfhart_defing and #all_attacker_mf_cqi > 0 and wanted_level_enemy_buffs[wanted_level_current+1]~="" then
					for i =1, #all_attacker_mf_cqi do
						cm:apply_effect_bundle_to_force(wanted_level_enemy_buffs[wanted_level_current+1], all_attacker_mf_cqi[i], 1);
					end
				end
	
			
			if wulfhart_atking and #all_defender_mf_cqi > 0 and wanted_level_enemy_buffs[wanted_level_current + 1] ~= "" then
				for i = 1, #all_defender_mf_cqi do
					cm:apply_effect_bundle_to_force(wanted_level_enemy_buffs[wanted_level_current + 1], all_defender_mf_cqi[i], 0);
				end;
			elseif wulfhart_defing and #all_attacker_mf_cqi > 0 and wanted_level_enemy_buffs[wanted_level_current+1] ~= "" then
				for i = 1, #all_attacker_mf_cqi do
					cm:apply_effect_bundle_to_force(wanted_level_enemy_buffs[wanted_level_current + 1], all_attacker_mf_cqi[i], 0);
				end;
			end;
		end;
	end,
	true
);

core:add_listener(
	"remove_wanted_level_enemy_buff_bundle",
	"BattleCompleted",
	function()
		return cm:model():pending_battle():has_been_fought();
	end,
	function()
		local all_attacker_mf_cqi, all_defender_mf_cqi, wulfhart_atking, wulfhart_defing = get_wulfhart_characters_from_battle();
		
		if wulfhart_atking then
			check_and_remove_effect_bundles(all_defender_mf_cqi);
		elseif wulfhart_defing then
			check_and_remove_effect_bundles(all_attacker_mf_cqi);
		end;
	end,
	true
);

function get_wulfhart_characters_from_battle()
	local all_attacker_mf_cqi = {};
	local all_defender_mf_cqi = {};
	local wulfhart_atking = false; 
	local wulfhart_defing = false;
	
	if cm:pending_battle_cache_num_attackers() >= 1 then
		for i = 1, cm:pending_battle_cache_num_attackers() do
			local this_char_cqi, this_mf_cqi, current_faction_name = cm:pending_battle_cache_get_attacker(i);
			
			if current_faction_name == wulfhart_faction then
				wulfhart_atking = true;
			end;
			
			table.insert(all_attacker_mf_cqi, this_mf_cqi);
		end;
	end;
	
	if cm:pending_battle_cache_num_defenders() >= 1 then
		for i = 1, cm:pending_battle_cache_num_defenders() do
			local this_char_cqi, this_mf_cqi, current_faction_name = cm:pending_battle_cache_get_defender(i);
			
			if current_faction_name == wulfhart_faction then
				wulfhart_defing = true;
			end;
			
			table.insert(all_defender_mf_cqi, this_mf_cqi);
		end;
	end;
	
	return all_attacker_mf_cqi, all_defender_mf_cqi, wulfhart_atking, wulfhart_defing;
end;

function get_strength_lvl()
	local resource_value = cm:get_faction(wulfhart_faction):pooled_resource(campaign_progress_resource_key):value();
	
	for i = 1, #progress_thresholds do
		if resource_value < progress_max / 100 * progress_thresholds[i] then
			return progress_enemy_strength[i];
		elseif resource_value == 100 then
			return progress_enemy_strength[#progress_enemy_strength];
		end;
	end;
end;

function check_and_remove_effect_bundles(all_mf_cqi)
	if #all_mf_cqi > 0 then
		for i = 1, #all_mf_cqi do
			local current_cqi = all_mf_cqi[i];
			
			for j = 1, #wanted_level_enemy_buffs do
				if wanted_level_enemy_buffs[j] ~= "" then
					cm:remove_effect_bundle_from_force(wanted_level_enemy_buffs[j], current_cqi);
				end;
			end;
		end;
	end;
end;

--claiming army composition for scripted armies
--templates 3 strength level
function setup_lizard_army()
	--low strength
	random_army_manager:new_force("lizard_retaliate_low");
	random_army_manager:add_mandatory_unit("lizard_retaliate_low", "wh2_main_lzd_inf_skink_cohort_0", 4);
	random_army_manager:add_mandatory_unit("lizard_retaliate_low", "wh2_main_lzd_inf_saurus_spearmen_0", 2);
	random_army_manager:add_unit("lizard_retaliate_low", "wh2_main_lzd_inf_skink_cohort_1", 1);
	random_army_manager:add_unit("lizard_retaliate_low", "wh2_dlc12_lzd_inf_skink_red_crested_0", 1);
	random_army_manager:add_unit("lizard_retaliate_low", "wh2_main_lzd_cav_terradon_riders_0", 1);
	
	random_army_manager:new_force("lizard_retaliate_low_skv");
	random_army_manager:add_mandatory_unit("lizard_retaliate_low_skv", "wh2_main_skv_inf_clanrat_spearmen_1", 4);
	random_army_manager:add_mandatory_unit("lizard_retaliate_low_skv", "wh2_main_skv_inf_clanrats_0", 2);
	random_army_manager:add_unit("lizard_retaliate_low_skv", "wh2_main_skv_inf_skavenslave_slingers_0", 1);
	random_army_manager:add_unit("lizard_retaliate_low_skv", "wh2_main_skv_mon_rat_ogres", 1);
	random_army_manager:add_unit("lizard_retaliate_low_skv", "wh2_main_skv_inf_night_runners_0", 1);
	
	random_army_manager:new_force("lizard_retaliate_low_grn");
	random_army_manager:add_mandatory_unit("lizard_retaliate_low_grn", "wh_main_grn_inf_orc_boyz", 4);
	random_army_manager:add_mandatory_unit("lizard_retaliate_low_grn", "wh_main_grn_inf_savage_orcs", 2);
	random_army_manager:add_unit("lizard_retaliate_low_grn", "wh_main_grn_inf_orc_arrer_boyz", 1);
	random_army_manager:add_unit("lizard_retaliate_low_grn", "wh_main_grn_inf_goblin_archers", 1);
	random_army_manager:add_unit("lizard_retaliate_low_grn", "wh_main_grn_cav_forest_goblin_spider_riders_0", 1);
	
	random_army_manager:new_force("lizard_retaliate_low_def");
	random_army_manager:add_mandatory_unit("lizard_retaliate_low_def", "wh2_main_def_inf_dreadspears_0", 4);
	random_army_manager:add_mandatory_unit("lizard_retaliate_low_def", "wh2_main_def_inf_bleakswords_0", 2);
	random_army_manager:add_unit("lizard_retaliate_low_def", "wh2_main_def_inf_darkshards_0", 1);
	random_army_manager:add_unit("lizard_retaliate_low_def", "wh2_main_def_inf_black_ark_corsairs_0", 1);
	random_army_manager:add_unit("lizard_retaliate_low_def", "wh2_main_def_cav_dark_riders_0", 1);
	
	random_army_manager:new_force("lizard_retaliate_low_cst");
	random_army_manager:add_mandatory_unit("lizard_retaliate_low_cst", "wh2_dlc11_cst_inf_zombie_gunnery_mob_0", 4);
	random_army_manager:add_mandatory_unit("lizard_retaliate_low_cst", "wh2_dlc11_cst_inf_zombie_gunnery_mob_1", 2);
	random_army_manager:add_unit("lizard_retaliate_low_cst", "wh2_dlc11_cst_inf_zombie_gunnery_mob_2", 1);
	random_army_manager:add_unit("lizard_retaliate_low_cst", "wh2_dlc11_cst_inf_zombie_gunnery_mob_3", 1);
	random_army_manager:add_unit("lizard_retaliate_low_cst", "wh2_dlc11_cst_inf_syreens", 1);
	
	random_army_manager:new_force("lizard_retaliate_low_emp");
	random_army_manager:add_mandatory_unit("lizard_retaliate_low_emp", "wh_main_emp_inf_spearmen_0", 4);
	random_army_manager:add_mandatory_unit("lizard_retaliate_low_emp", "wh_main_emp_inf_swordsmen", 2);
	random_army_manager:add_unit("lizard_retaliate_low_emp", "wh_main_emp_inf_crossbowmen", 1);
	random_army_manager:add_unit("lizard_retaliate_low_emp", "wh2_dlc13_emp_inf_archers_0", 1);
	random_army_manager:add_unit("lizard_retaliate_low_emp", "wh_dlc04_emp_inf_flagellants_0", 1);
	
	--mid strength
	random_army_manager:new_force("lizard_retaliate_mid");
	random_army_manager:add_mandatory_unit("lizard_retaliate_mid", "wh2_main_lzd_inf_saurus_spearmen_0", 3);
	random_army_manager:add_mandatory_unit("lizard_retaliate_mid", "wh2_main_lzd_inf_saurus_spearmen_1", 3);
	random_army_manager:add_mandatory_unit("lizard_retaliate_mid", "wh2_main_lzd_cav_cold_one_spearmen_1", 2);
	random_army_manager:add_mandatory_unit("lizard_retaliate_mid", "wh2_main_lzd_mon_kroxigors", 2);
	random_army_manager:add_mandatory_unit("lizard_retaliate_mid", "wh2_main_lzd_mon_carnosaur_0", 1);
	random_army_manager:add_unit("lizard_retaliate_mid", "wh2_main_lzd_inf_chameleon_skinks_0", 1);
	random_army_manager:add_unit("lizard_retaliate_mid", "wh2_main_lzd_cav_terradon_riders_1", 1);
	
	random_army_manager:new_force("lizard_retaliate_mid_skv");
	random_army_manager:add_mandatory_unit("lizard_retaliate_mid_skv", "wh2_main_skv_inf_clanrat_spearmen_1", 4);
	random_army_manager:add_mandatory_unit("lizard_retaliate_mid_skv", "wh2_main_skv_inf_stormvermin_0", 2);
	random_army_manager:add_mandatory_unit("lizard_retaliate_mid_skv", "wh2_dlc12_skv_inf_ratling_gun_0", 1);
	random_army_manager:add_mandatory_unit("lizard_retaliate_mid_skv", "wh2_dlc12_skv_inf_warplock_jezzails_0", 1);
	random_army_manager:add_unit("lizard_retaliate_mid_skv", "wh2_main_skv_mon_rat_ogres", 1);
	random_army_manager:add_unit("lizard_retaliate_mid_skv", "wh2_main_skv_inf_night_runners_0", 1);
	
	random_army_manager:new_force("lizard_retaliate_mid_grn");
	random_army_manager:add_mandatory_unit("lizard_retaliate_mid_grn", "wh_main_grn_inf_orc_boyz", 3);
	random_army_manager:add_mandatory_unit("lizard_retaliate_mid_grn", "wh_main_grn_inf_savage_orcs", 2);
	random_army_manager:add_mandatory_unit("lizard_retaliate_mid_grn", "wh_main_grn_inf_orc_big_uns", 2);
	random_army_manager:add_unit("lizard_retaliate_mid_grn", "wh_main_grn_cav_orc_boar_boyz", 1);
	random_army_manager:add_unit("lizard_retaliate_mid_grn", "wh_main_grn_inf_goblin_archers", 1);
	random_army_manager:add_unit("lizard_retaliate_mid_grn", "wh_main_grn_cav_goblin_wolf_riders_1", 1);
	
	random_army_manager:new_force("lizard_retaliate_mid_def");
	random_army_manager:add_mandatory_unit("lizard_retaliate_mid_def", "wh2_main_def_inf_dreadspears_0", 4);
	random_army_manager:add_mandatory_unit("lizard_retaliate_mid_def", "wh2_main_def_inf_black_ark_corsairs_0", 2);
	random_army_manager:add_mandatory_unit("lizard_retaliate_mid_def", "wh2_main_def_inf_black_guard_0", 1);
	random_army_manager:add_unit("lizard_retaliate_mid_def", "wh2_main_def_inf_darkshards_0", 1);
	random_army_manager:add_unit("lizard_retaliate_mid_def", "wh2_main_def_inf_shades_1", 1);
	random_army_manager:add_unit("lizard_retaliate_mid_def", "wh2_main_def_inf_black_ark_corsairs_0", 1);
	
	random_army_manager:new_force("lizard_retaliate_mid_cst");
	random_army_manager:add_mandatory_unit("lizard_retaliate_mid_cst", "wh2_dlc11_cst_inf_zombie_gunnery_mob_0", 2);
	random_army_manager:add_mandatory_unit("lizard_retaliate_mid_cst", "wh2_dlc11_cst_inf_zombie_gunnery_mob_1", 2);
	random_army_manager:add_mandatory_unit("lizard_retaliate_mid_cst", "wh2_dlc11_cst_inf_depth_guard_0", 1);
	random_army_manager:add_mandatory_unit("lizard_retaliate_mid_cst", "wh2_dlc11_cst_mon_animated_hulks_0", 2);
	random_army_manager:add_unit("lizard_retaliate_mid_cst", "wh2_dlc11_cst_mon_bloated_corpse_0", 1);
	random_army_manager:add_unit("lizard_retaliate_mid_cst", "wh2_dlc11_cst_inf_zombie_gunnery_mob_3", 1);
	random_army_manager:add_unit("lizard_retaliate_mid_cst", "wh2_dlc11_cst_cav_deck_droppers_2", 1);
	
	random_army_manager:new_force("lizard_retaliate_mid_emp");
	random_army_manager:add_mandatory_unit("lizard_retaliate_mid_emp", "wh_main_emp_inf_spearmen_1", 2);
	random_army_manager:add_mandatory_unit("lizard_retaliate_mid_emp", "wh_main_emp_inf_swordsmen", 2);
	random_army_manager:add_mandatory_unit("lizard_retaliate_mid_emp", "wh_main_emp_inf_greatswords", 1);
	random_army_manager:add_mandatory_unit("lizard_retaliate_mid_emp", "wh_dlc04_emp_inf_free_company_militia_0", 2);
	random_army_manager:add_unit("lizard_retaliate_mid_emp", "wh_main_emp_cav_pistoliers_1", 1);
	random_army_manager:add_unit("lizard_retaliate_mid_emp", "wh2_dlc13_emp_inf_huntsmen_0", 1);
	random_army_manager:add_unit("lizard_retaliate_mid_emp", "wh_main_emp_cav_empire_knights", 1);
	
	--high strength
	random_army_manager:new_force("lizard_retaliate_hig");
	--random_army_manager:add_mandatory_unit("lizard_retaliate_hig", "wh2_main_lzd_inf_saurus_spearmen_1", 3);
	random_army_manager:add_mandatory_unit("lizard_retaliate_hig", "wh2_main_lzd_inf_temple_guards", 2);
	random_army_manager:add_mandatory_unit("lizard_retaliate_hig", "wh2_main_lzd_cav_horned_ones_0", 2);
	random_army_manager:add_mandatory_unit("lizard_retaliate_hig", "wh2_main_lzd_mon_kroxigors", 3);
	random_army_manager:add_mandatory_unit("lizard_retaliate_hig", "wh2_main_lzd_mon_carnosaur_0", 1);
	random_army_manager:add_mandatory_unit("lizard_retaliate_hig", "wh2_dlc12_lzd_mon_ancient_stegadon_1", 1);
	random_army_manager:add_mandatory_unit("lizard_retaliate_hig", "wh2_dlc13_lzd_mon_dread_saurian_0", 1);
	random_army_manager:add_unit("lizard_retaliate_hig", "wh2_main_lzd_inf_chameleon_skinks_0", 1);
	random_army_manager:add_unit("lizard_retaliate_hig", "wh2_dlc12_lzd_cav_ripperdactyl_riders_0", 1);
	random_army_manager:add_unit("lizard_retaliate_hig", "wh2_main_lzd_mon_bastiladon_0", 1);
	
	random_army_manager:new_force("lizard_retaliate_hig_skv");
	random_army_manager:add_mandatory_unit("lizard_retaliate_hig_skv", "wh2_main_skv_inf_stormvermin_1", 3);
	random_army_manager:add_mandatory_unit("lizard_retaliate_hig_skv", "wh2_main_skv_inf_plague_monks", 2);
	random_army_manager:add_mandatory_unit("lizard_retaliate_hig_skv", "wh2_dlc12_skv_inf_ratling_gun_0", 1);
	random_army_manager:add_mandatory_unit("lizard_retaliate_hig_skv", "wh2_dlc12_skv_inf_warplock_jezzails_0", 1);
	random_army_manager:add_mandatory_unit("lizard_retaliate_hig_skv", "wh2_main_skv_mon_hell_pit_abomination", 1);
	random_army_manager:add_unit("lizard_retaliate_hig_skv", "wh2_main_skv_mon_rat_ogres", 1);
	random_army_manager:add_unit("lizard_retaliate_hig_skv", "wh2_main_skv_inf_gutter_runners_0", 1);
	random_army_manager:add_unit("lizard_retaliate_hig_skv", "wh2_main_skv_art_plagueclaw_catapult", 1);
	
	random_army_manager:new_force("lizard_retaliate_hig_grn");
	random_army_manager:add_mandatory_unit("lizard_retaliate_hig_grn", "wh_main_grn_mon_giant", 1);
	random_army_manager:add_mandatory_unit("lizard_retaliate_hig_grn", "wh_main_grn_inf_savage_orcs", 2);
	random_army_manager:add_mandatory_unit("lizard_retaliate_hig_grn", "wh_main_grn_inf_orc_big_uns", 2);
	random_army_manager:add_mandatory_unit("lizard_retaliate_hig_grn", "wh_main_grn_inf_black_orcs", 2);
	random_army_manager:add_unit("lizard_retaliate_hig_grn", "wh_main_grn_cav_orc_boar_boy_big_uns", 1);
	random_army_manager:add_unit("lizard_retaliate_hig_grn", "wh_main_grn_inf_savage_orc_big_uns", 1);
	random_army_manager:add_unit("lizard_retaliate_hig_grn", "wh_main_grn_art_doom_diver_catapult", 1);
	
	random_army_manager:new_force("lizard_retaliate_hig_def");
	random_army_manager:add_mandatory_unit("lizard_retaliate_hig_def", "wh2_main_def_inf_black_ark_corsairs_1", 2);
	random_army_manager:add_mandatory_unit("lizard_retaliate_hig_def", "wh2_main_def_inf_black_ark_corsairs_0", 2);
	random_army_manager:add_mandatory_unit("lizard_retaliate_hig_def", "wh2_main_def_inf_black_guard_0", 2);
	random_army_manager:add_mandatory_unit("lizard_retaliate_hig_def", "wh2_dlc10_def_mon_war_hydra_boss", 1);
	random_army_manager:add_mandatory_unit("lizard_retaliate_hig_def", "wh2_main_def_mon_black_dragon", 1);
	random_army_manager:add_unit("lizard_retaliate_hig_def", "wh2_main_def_inf_witch_elves_0", 1);
	random_army_manager:add_unit("lizard_retaliate_hig_def", "wh2_main_def_inf_shades_2", 1);
	random_army_manager:add_unit("lizard_retaliate_hig_def", "wh2_main_def_inf_darkshards_1", 1);
	
	random_army_manager:new_force("lizard_retaliate_hig_cst");
	random_army_manager:add_mandatory_unit("lizard_retaliate_hig_cst", "wh2_dlc11_cst_inf_zombie_gunnery_mob_0", 2);
	random_army_manager:add_mandatory_unit("lizard_retaliate_hig_cst", "wh2_dlc11_cst_inf_zombie_gunnery_mob_1", 1);
	random_army_manager:add_mandatory_unit("lizard_retaliate_hig_cst", "wh2_dlc11_cst_inf_depth_guard_0", 2);
	random_army_manager:add_mandatory_unit("lizard_retaliate_hig_cst", "wh2_dlc11_cst_inf_depth_guard_1", 2);
	random_army_manager:add_mandatory_unit("lizard_retaliate_hig_cst", "wh2_dlc11_cst_inf_deck_gunners_0", 2);
	random_army_manager:add_mandatory_unit("lizard_retaliate_hig_cst", "wh2_dlc11_cst_mon_rotting_leviathan_0", 1);
	random_army_manager:add_mandatory_unit("lizard_retaliate_hig_cst", "wh2_dlc11_cst_mon_necrofex_colossus_0", 1);
	random_army_manager:add_unit("lizard_retaliate_hig_cst", "wh2_dlc11_cst_mon_bloated_corpse_0", 1);
	random_army_manager:add_unit("lizard_retaliate_hig_cst", "wh2_dlc11_cst_inf_zombie_gunnery_mob_3", 1);
	random_army_manager:add_unit("lizard_retaliate_hig_cst", "wh2_dlc11_cst_cav_deck_droppers_2", 1);
	
	random_army_manager:new_force("lizard_retaliate_hig_emp");
	random_army_manager:add_mandatory_unit("lizard_retaliate_hig_emp", "wh_main_emp_inf_halberdiers", 2);
	random_army_manager:add_mandatory_unit("lizard_retaliate_hig_emp", "wh_main_emp_art_helstorm_rocket_battery", 1);
	random_army_manager:add_mandatory_unit("lizard_retaliate_hig_emp", "wh_main_emp_inf_greatswords", 2);
	random_army_manager:add_mandatory_unit("lizard_retaliate_hig_emp", "wh_main_emp_cav_reiksguard", 2);
	random_army_manager:add_mandatory_unit("lizard_retaliate_hig_emp", "wh_main_emp_inf_spearmen_1", 2);
	random_army_manager:add_mandatory_unit("lizard_retaliate_hig_emp", "wh_main_emp_cav_demigryph_knights_0", 1);
	random_army_manager:add_mandatory_unit("lizard_retaliate_hig_emp", "wh_main_emp_cav_demigryph_knights_1", 1);
	random_army_manager:add_unit("lizard_retaliate_hig_emp", "wh_main_emp_art_helblaster_volley_gun", 1);
	random_army_manager:add_unit("lizard_retaliate_hig_emp", "wh2_dlc13_emp_inf_huntsmen_0", 1);
	random_army_manager:add_unit("lizard_retaliate_hig_emp", "wh_main_emp_inf_handgunners", 1);
	
	--gor-rok
	random_army_manager:new_force("gor_rok");
	--random_army_manager:add_mandatory_unit("lizard_retaliate_hig", "wh2_main_lzd_inf_saurus_spearmen_1", 3);
	random_army_manager:add_mandatory_unit("gor_rok", "wh2_main_lzd_inf_temple_guards", 2);
	random_army_manager:add_mandatory_unit("gor_rok", "wh2_main_lzd_cav_horned_ones_0", 2);
	random_army_manager:add_mandatory_unit("gor_rok", "wh2_main_lzd_inf_saurus_spearmen_1", 3);
	random_army_manager:add_mandatory_unit("gor_rok", "wh2_dlc12_lzd_mon_ancient_stegadon_1", 1);
	random_army_manager:add_mandatory_unit("gor_rok", "wh2_dlc13_lzd_mon_dread_saurian_0", 1);
	random_army_manager:add_unit("gor_rok", "wh2_main_lzd_inf_chameleon_skinks_0", 1);
	random_army_manager:add_unit("gor_rok", "wh2_main_lzd_inf_saurus_spearmen_0", 1);

end;

--imperial supplies control
--this will add imperial supply charge, and when it reaches imperial_guard_meter_max, we dispatch the imperial_guard
function updated_imperial_meter()
	local faction = cm:get_faction(wulfhart_faction);
	
	--checks if there's any delay on it
	if faction and supply_delay_counter == 0 and faction:has_effect_bundle(special_effect_bundles["supply_delay"]) then
		supply_delay_counter = 5;
	end;
	
	if supply_delay_counter > 0 then
		supply_delay_counter = supply_delay_counter - 1;
	else
		imperial_guard_meter = imperial_guard_meter + imperial_guard_charge[wanted_level_current + 1];
		
		if imperial_guard_meter >= imperial_guard_max then
			process_imperial_guard();
		end;
	end;
end;

--triggers the imperial supply event
--also resets the imperial_guard_meter
function process_imperial_guard()
	local faction = cm:get_faction(wulfhart_faction);
	
	update_imperial_guard_strength();
	if faction and faction:is_human() then
		cm:trigger_dilemma(wulfhart_faction, imperial_guard_strength_dilemmas[imperial_guard_strength]);
	end;
	
	imperial_guard_meter = 0;
end;

--edit the imperial supply strength, be called when progression bar changes
function update_imperial_guard_strength()
	local resource_value = cm:get_faction(wulfhart_faction):pooled_resource(campaign_progress_resource_key):value();
	
	for i = 1, #progress_thresholds do
		if resource_value < progress_max / 100 * progress_thresholds[i] then
			imperial_guard_strength = progress_merc_strength[i];
			return;
		elseif resource_value == 100 then
			imperial_guard_strength = progress_merc_strength[#progress_merc_strength];
		end;
	end;
end;

--updated the imperial supply charge at beginning of turn
core:add_listener(
	"faction_turn_start_wulfhart_imperial_supply",
	"ScriptEventHumanFactionTurnStart",
	function(context)
		return context:faction():name() == wulfhart_faction;
	end,
	function()
		updated_imperial_meter();
	end,
	true
);

--connects incidents to dilemmas
core:add_listener(
	"dilemma_choice_made_distribute_imperial_supply",
	"DilemmaChoiceMadeEvent",
	true,
	function(context)
		local choice = context:choice();
		local dilemma = context:dilemma();
		
		for i = 1, #imperial_guard_strength_dilemmas do
			if dilemma == imperial_guard_strength_dilemmas[i] then
				cm:trigger_incident(wulfhart_faction, imperial_guard_strength_detail[i][choice + 1], true);
				
				local faction = cm:get_faction(wulfhart_faction);
				
				if faction and faction:is_human() and (faction:has_effect_bundle(special_effect_bundles["supply_buff"]) or faction:has_technology("tech_dlc13_emp_wulfhart_4")) then
					cm:trigger_incident(wulfhart_faction, imperial_guard_extra_unit_incidents[i], true);
					cm:remove_effect_bundle(special_effect_bundles["supply_buff"], wulfhart_faction);
				end;
			end;
		end;
		
		cm:callback(
			function() 
				local faction = cm:get_faction(wulfhart_faction);
				
				--checks if there's any delay on it
				if faction and faction:is_human() and faction:has_effect_bundle(special_effect_bundles["wanted_increase"]) then
					update_wanted_bar("increase_event");
					cm:remove_effect_bundle(special_effect_bundles["wanted_increase"], wulfhart_faction);
				end;
			end,
			0.5
		);
	end,
	true
);

--getting hunters
core:add_listener(
	"adding_progress_for_hunter_unlock",
	"HunterUnlocked",
	true,
	function()
		update_progress_bar("increase_hunters");
	end,
	true
);

-- progress bar control
-- this will update the progress bar pooled resource based on player's occupation of lustria
function update_progress_bar(index)
	local faction = cm:get_faction(wulfhart_faction);
	
	if faction then
		local previous_level = faction:pooled_resource(campaign_progress_resource_key):value();
		
		if index and campaign_progress_resource_factors[index] and campaign_progress_resource_intervals[index] and not progress_lock and campaign_progress_resource_intervals[index] ~= 0 then
			cm:faction_add_pooled_resource(wulfhart_faction, campaign_progress_resource_key, campaign_progress_resource_factors[index], campaign_progress_resource_intervals[index]);
		end;
		
		local current_level = faction:pooled_resource(campaign_progress_resource_key):value();

		-- trigger an event reminding about progression reward
		for i = 1, #progress_thresholds do
			if previous_level < progress_max / 100 * progress_thresholds[i] and current_level >= progress_max / 100 * progress_thresholds[i] then
				cm:trigger_incident(wulfhart_faction, "wh2_dlc13_emp_wulfhart_progress_level_increase", true);
				
				for j = 1, #buildings_to_unlock[i + 1] do
					cm:remove_event_restricted_building_record_for_faction(buildings_to_unlock[i+1][j], wulfhart_faction);
				end;
				
				lock_buildings(i + 2);
			elseif previous_level >= progress_max / 100 * progress_thresholds[i] and current_level < progress_max/100 * progress_thresholds[i] then
				lock_buildings(i + 1);
			elseif current_level < progress_max / 100 * progress_thresholds[1] then
				lock_buildings(1);
			end;			
		end;
		
		update_imperial_guard_strength();
		if previous_level < progress_max / 100 * 50 and current_level >= progress_max / 100 * 50 and campaign_progress_half == false and get_campaign_key() == "wh2_main_great_vortex" then
			if faction:is_human() then
				create_gor_rok();
			end
			campaign_progress_half = true;
		end
		
		-- trigger endgame mechanics
		if faction:pooled_resource(campaign_progress_resource_key):value() >= progress_max / 100 * progress_thresholds[#progress_thresholds] and not progress_lock then
			if not cm:model():is_multiplayer() and get_campaign_key() == "wh2_main_great_vortex" then
				cm:trigger_mission(wulfhart_faction, "wh2_dlc13_qb_emp_final_battle_wulfhart", true);
				core:svr_save_registry_bool("hunter_wulfhart_call_to_arms", true);
				cm:register_instant_movie("warhammer2/hunter/hunter_wulfhart_call_to_arms");
			end
			progress_lock = true;
		end;
	end;
end;

--create gor_rok function
function create_gor_rok()
	if get_campaign_key() == "main_warhammer" or cm:model():is_multiplayer() then
		return;
	elseif get_campaign_key() == "wh2_main_great_vortex" then

		-- package the triggering of gor-rok in an intervention
		cm:trigger_transient_intervention(
			"create_gor_rok",
			function(intervention)
				local unit_list = random_army_manager:generate_force("gor_rok", 20);
				local force_leader = nil;
				local loc = wanted_level_scripted_army_spawn_loc[get_spawn_loc()];
				loc[1], loc[2] = cm:find_valid_spawn_location_for_character_from_position(wanted_level_scripted_army_faction, loc[1], loc[2], true, 3);
				
				local scripted_army_progress = invasion_manager:new_invasion("progress_bar_army", wanted_level_scripted_army_faction, unit_list, loc);
				scripted_army_progress.target = wulfhart_faction;
				scripted_army_progress.human = false;
				scripted_army_progress:create_general(true, "wh2_dlc13_lzd_gor_rok", "names_name_1693537039", "", "", "");
				scripted_army_progress:apply_effect("wh2_dlc10_bundle_blood_voyage_old", 0);
				scripted_army_progress:start_invasion(
					function(self)
						force_leader = self:get_general();
						
						if not force_leader:region():is_null_interface() then
							cm:make_region_visible_in_shroud(wulfhart_faction, force_leader:region():name());
						end;
						
						cm:force_declare_war(wanted_level_scripted_army_faction, wulfhart_faction, false, false, false);
						
						--the event feed for spawning the army
						cm:show_message_event_located(
							wulfhart_faction,
							"event_feed_strings_text_wh2_dlc13_event_feed_string_scripted_event_lizardman_invasion_title",
							"event_feed_strings_text_wh2_dlc13_event_feed_string_scripted_event_lizardman_invasion_primary_detail",
							"event_feed_strings_text_wh2_dlc13_event_feed_string_scripted_event_lizardman_invasion_secondary_detail",
							loc[1], 
							loc[2],
							false,
							1310
						);
					end,
					false,
					false,
					false
				);	
				
				gor_rok_cutscene(loc, intervention);
			end,
			BOOL_INTERVENTION_DEBUG,
			function(intervention)
				-- configure intervention here

				-- allow transient located scripted event to be shown while intervention is active
				intervention:whitelist_events("scripted_transient_located_eventevent_feed_target_faction");
			end
		);
	end
end

--gor rok cutscene
function gor_rok_cutscene(loc, intervention)
	local advice_to_play = {};
	advice_to_play[1] = "wh2_dlc13.camp.advice.emp.gor_rok.001";
	
	--(14.979279 -0.000111 11.504411)
	local cam_skip_x, cam_skip_y, cam_skip_d, cam_skip_b, cam_skip_h = cm:get_camera_position();
	cm:take_shroud_snapshot();
	
	local gor_rok_scene = campaign_cutscene:new(
		"gor_rok_scene",
		17,
		function()
			cm:modify_advice(true);
			cutscene_nd(cam_skip_x, cam_skip_y, cam_skip_d, cam_skip_b, cam_skip_h, intervention);
		end
	);

	gor_rok_scene:set_skippable(true, function() cutscene_skipped(advice_to_play) end);
	gor_rok_scene:set_skip_camera(cam_skip_x, cam_skip_y, cam_skip_d, cam_skip_b, cam_skip_h);
	gor_rok_scene:set_disable_settlement_labels(false);
	gor_rok_scene:set_dismiss_advice_on_end(true);
	
	gor_rok_scene:action(
		function()
			cm:fade_scene(0, 3);
			cm:clear_infotext();
		end,
		0
	);
	
	gor_rok_scene:action(
		function()
			cm:show_shroud(false);
			cm:show_advice(advice_to_play[1]);
			
			local x_pos, y_pos = cm:log_to_dis(loc[1], loc[2]);
			cm:set_camera_position( x_pos, y_pos, cam_skip_d, cam_skip_b, cam_skip_h);
			cm:fade_scene(1, 2);
		end,
		3
	);
	
	gor_rok_scene:action(
		function()
			gor_rok_scene:wait_for_advisor();
		end,
		15.4
	);
	
	gor_rok_scene:action(
		function()
			cm:fade_scene(0, 1);
		end,
		16
	);
		
	gor_rok_scene:action(
		function()
			cm:set_camera_position(cam_skip_x, cam_skip_y, cam_skip_d, cam_skip_b, cam_skip_h);
			cm:fade_scene(1, 1);
		end,
		17
	);
	
	gor_rok_scene:start();
end

function cutscene_skipped(advice_to_play)
	cm:override_ui("disable_advice_audio", true);
	
	effect.clear_advice_session_history();
	
	for i = 1, #advice_to_play do
		cm:show_advice(advice_to_play[i]);
	end;
	
	cm:callback(function() cm:override_ui("disable_advice_audio", false) end, 0.5);
	cm:restore_shroud_from_snapshot();
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

--checkin all the progression bar factors
core:add_listener(
	"checking_progression_factor_1",
	"RegionFactionChangeEvent",
	true,
	function(context)
		local owning_faction = context:region():owning_faction();
		
		if not owning_faction:is_null_interface() and owning_faction:name() == wulfhart_faction then
			update_progress_bar("increase");
		end;
		
		local previous_faction = context:previous_faction();
		
		if not previous_faction:is_null_interface() and previous_faction:name() == wulfhart_faction then
			update_progress_bar("decrease");
			core:trigger_event("ScriptEventMandateLostSettlement");
		end;
	end,
	true
);

core:add_listener(
	"checking_progression_factor_2",
	"BuildingCompleted",
	function(context)
		local building = context:building();
		local building_name = building:name();
		
		return building:faction():name() == wulfhart_faction and (building_name == "wh_main_emp_port_1" or building_name == "wh_main_emp_port_2" or building_name == "wh_main_emp_port_3");
	end,
	function()
		update_progress_bar("increase_ports");
	end,
	true
);

--spawn wanted bar army
--strength is a string, defines army template
--number is the number of army to spawn
--chance is optional, it defines spawn chance
function spawn_wanted_bar_army(strength, number, size, chance, force, loc, faction)
	-- if get_campaign_key() == "main_warhammer" then
		-- return;
	-- end;
	
	local unit_list = random_army_manager:generate_force(strength, size);
	local existing_army_num = #wanted_level_scripted_army_list;
	local force_leader = nil;
	if loc == nil then
		loc = wanted_level_scripted_army_spawn_loc[get_spawn_loc()];
	end
	loc[1], loc[2] = cm:find_valid_spawn_location_for_character_from_position(wanted_level_scripted_army_faction, loc[1], loc[2], true, 3);
	
	update_scripted_army_list();
	
	if (not chance or cm:model():random_percent(chance)) and (force or (existing_army_num == 0 and wanted_level_scripted_army_expire_counter == 0)) then
		local counter = 0;
		if faction == nil then
			faction = wanted_level_scripted_army_faction;
		end
		
		for i = 1, number do
			local scripted_army_wanted = nil;
			counter = counter + 1;
			scripted_army_wanted = invasion_manager:new_invasion("wanted_bar_army"..tostring(wanted_level_scripted_army_counter), faction, unit_list, loc);
			wanted_level_scripted_army_expire_counter = wanted_level_scripted_army_expire_counter_default;
			wanted_level_scripted_army_counter = wanted_level_scripted_army_counter + 1;
			scripted_army_wanted.target = wulfhart_faction;
			scripted_army_wanted.human = false;
			scripted_army_wanted:apply_effect("wh2_dlc10_bundle_blood_voyage_old", 0);
			scripted_army_wanted:start_invasion(
				function(self)
					force_leader = self:get_general();
					
					if not force_leader:region():is_null_interface() then
						cm:make_region_visible_in_shroud(wulfhart_faction, force_leader:region():name());
					end;
					
					cm:force_declare_war(faction, wulfhart_faction, false, false, false);
					update_scripted_army_list(force_leader:military_force():command_queue_index());
					
					--the event feed for spawning the army
					if get_campaign_key() == "wh2_main_great_vortex" then
						cm:show_message_event_located(
							wulfhart_faction,
							"event_feed_strings_text_wh2_dlc13_event_feed_string_scripted_event_lizardman_invasion_title",
							"event_feed_strings_text_wh2_dlc13_event_feed_string_scripted_event_lizardman_invasion_primary_detail",
							"event_feed_strings_text_wh2_dlc13_event_feed_string_scripted_event_lizardman_invasion_secondary_detail",
							loc[1], 
							loc[2],
							false,
							1310
						);
					else
						cm:show_message_event_located(
							wulfhart_faction,
							"event_feed_strings_text_wh2_dlc13_event_feed_string_scripted_event_hostility_invasion_title",
							"event_feed_strings_text_wh2_dlc13_event_feed_string_scripted_event_hostility_invasion_primary_detail",
							"event_feed_strings_text_wh2_dlc13_event_feed_string_scripted_event_hostility_invasion_0_secondary_detail",
							loc[1], 
							loc[2],
							false,
							1311
						);
					end
				end,
				false,
				false,
				false
			);
		end
	end
end

function update_scripted_army_list(cqi)
	local cqis_to_remove = {};
	
	for i = 1, #wanted_level_scripted_army_list do
		local mf = cm:get_military_force_by_cqi(wanted_level_scripted_army_list[i]);
		
		if not mf or mf:is_null_interface() then
			table.insert(cqis_to_remove, wanted_level_scripted_army_list[i]);
		end;
	end;
	
	for i = 1, #cqis_to_remove do
		table.remove(wanted_level_scripted_army_list, cqis_to_remove[i]);
	end;
	
	if cqi then
		table.insert(wanted_level_scripted_army_list, cqi);
	end;
end;

--wanted bar change with given index
--index is a string, used to browse wanted_level_resource variables
--this will make change to the wanted bar resource, and update the wanted_level_current in script
--based on wanted_level_current increasing or not, this will also spawn instant script army
function update_wanted_bar(index) 
	local wanted_level_previous = wanted_level_current;
	
	if index then
		if index:find("decrease") then
			core:trigger_event("ScriptEventHostilityDecreased");
		end;
	
		if wanted_level_resource_intervals[index] and wanted_level_resource_intervals[index] then
			if wanted_level_resource_intervals[index] >= 1 or wanted_level_resource_intervals[index] <= -1 then
				cm:faction_add_pooled_resource(wulfhart_faction, wanted_level_resource_key, wanted_level_resource_factors[index], wanted_level_resource_intervals[index]);
			else
				local round = wanted_level_resource_thresholds[wanted_level_current + 1] * wanted_level_resource_intervals[index];
				round = math.floor((math.floor(round * 2) + 1) / 2);
				cm:faction_add_pooled_resource(wulfhart_faction, wanted_level_resource_key, wanted_level_resource_factors[index], round);
			end;
			
			if wanted_level_resource_intervals[index] > 0 then
				wanted_lvl_increased = wanted_lvl_increased + wanted_level_resource_intervals[index];
			end;
		end;
	end;
	
	--define the wanted level based on the resource
	local wanted_value = cm:get_faction(wulfhart_faction):pooled_resource(wanted_level_resource_key):value();
	
	if wanted_value< wanted_level_resource_thresholds[1] then
		wanted_level_current = 0;
	elseif wanted_value < wanted_level_resource_thresholds[2] then
		wanted_level_current = 1;
	elseif wanted_value < wanted_level_resource_thresholds[3] then
		wanted_level_current = 2;
	elseif wanted_value < wanted_level_resource_thresholds[4] then
		wanted_level_current = 3;
	elseif wanted_value < wanted_level_resource_thresholds[5] then
		wanted_level_current = 4;
	else
		wanted_level_current = 5;
	end;
	
	--spawn instant invasion army when wanted level increase
	if wanted_level_current > wanted_level_previous then
		out("wanted level increased!");
		cm:trigger_incident(wulfhart_faction, wanted_level_change_events["increase"][wanted_level_current + 1], true);
		
		if wanted_level_current == 5 then
			if get_campaign_key() == "wh2_main_great_vortex" then 
				spawn_wanted_bar_army(get_strength_lvl(), wanted_level_scripted_army_details["number"][wanted_level_current + 1], wanted_level_scripted_army_details["size"][wanted_level_current + 1], nil, true);
			elseif get_campaign_key() == "main_warhammer" then
				local location_key = get_random_element(get_location_list("main_warhammer"));
				local location_num = wanted_level_scripted_army_spawn_loc[location_key];
				queued_army_spawn["loc"][1] = location_key;
				queued_army_spawn["loc"][2] = location_num;

				--queued_army_spawn["army_detail"][1] = get_strength_lvl()..wanted_level_scripted_army_spawn_detail_main[location_key][1];
				--queued_army_spawn["army_detail"][2] = wanted_level_scripted_army_spawn_detail_main[location_key][2];
				queued_army_spawn["army_detail"][1] = get_strength_lvl();
				queued_army_spawn["army_detail"][2] = "wh2_dlc13_lzd_avengers";

				queued_army_spawn["counter"] = 3;
				queued_army_spawn["valid"] = true;
				update_queued_spawn();
			end
			
			process_imperial_guard();
			wanted_level_5_lock_counter = wanted_level_5_lock_counter_default;
			
			update_ui_component_accordingly();
		end;
	elseif wanted_level_current == wanted_level_previous then
		update_ui_component_accordingly();
	elseif wanted_level_current < wanted_level_previous then
		if wanted_level_current == 0 and wanted_level_previous == 5 then
			cm:trigger_incident(wulfhart_faction, wanted_level_change_events["reset"], true);
		else
			cm:trigger_incident(wulfhart_faction, wanted_level_change_events["decrease"], true);
		end

		update_ui_component_accordingly();
	end;
end;

function annouce_queued_spawn()
	local loc = queued_army_spawn["loc"][2]; 
	local text = "event_feed_strings_text_wh2_dlc13_event_feed_string_scripted_event_hostility_invasion_"..queued_army_spawn["counter"].."_secondary_detail"
	cm:show_message_event_located(
						wulfhart_faction,
						"event_feed_strings_text_wh2_dlc13_event_feed_string_scripted_event_hostility_invasion_title",
						"event_feed_strings_text_wh2_dlc13_event_feed_string_scripted_event_hostility_invasion_1_primary_detail",
						text,
						loc[1], 
						loc[2],
						false,
						1311
					);
end

function update_queued_spawn()
	if queued_army_spawn["valid"] == false then
		return;
	else
		queued_army_spawn["counter"] = queued_army_spawn["counter"] - 1;
		if queued_army_spawn["counter"] == 0 then
			spawn_wanted_bar_army(queued_army_spawn["army_detail"][1], 1, wanted_level_scripted_army_details["size"][wanted_level_current + 1], nil, true, queued_army_spawn["loc"][2], queued_army_spawn["army_detail"][2]);
		elseif queued_army_spawn["counter"] > 0 then
			annouce_queued_spawn();
		end
	end

end

function update_ui_component_accordingly()
	if cm:get_local_faction_name(true) == wulfhart_faction then
		local compo = find_uicomponent(core:get_ui_root(), "hostility_number_holder");
		
		if wanted_level_5_lock_counter > 0 then
			compo:InterfaceFunction("SetCooldown", true);
			out("switching ui state");
			effect.set_context_value("wanted_level_cooldown", wanted_level_5_lock_counter);
		else
			compo:InterfaceFunction("SetCooldown", false);
			effect.set_context_value("wanted_level_turns", math.ceil((imperial_guard_max - imperial_guard_meter) / imperial_guard_charge[wanted_level_current + 1]) + supply_delay_counter);
		end;
	end;
end;

-- this checks if a general should be taken account by wanted bar
-- it has to be a general of wulfhart's faction to pass
function check_wulfhart_general(character)
	return character and not character:is_null_interface() and character:faction():is_human() and character:faction():name() == wulfhart_faction and cm:char_is_general_with_army(character) and character:has_military_force() and not character:military_force():is_armed_citizenry();
end;

core:add_listener(
	"wanted_bar_update_occupy",
	"CharacterPerformsSettlementOccupationDecision",
	function(context)
		return check_wulfhart_general(context:character());
	end,
	function(context)
		local occupation_decision = context:occupation_decision();
		
		if occupation_decision == "662" or occupation_decision == "658" or occupation_decision == "664" then
			-- occupy or raze
			update_wanted_bar("increase_major");
		elseif occupation_decision == "679" then
			-- sack
			update_wanted_bar("increase_minor");
		end;
	end,
	true
);

core:add_listener(
	"wanted_bar_update_kill_general_self_general_wounded",
	"BattleCompleted",
	true,
	function()
		local wulfhart_generals = {
			["attacker"] = {},
			["defender"] = {}
		};
		
		local lord_wounded = {
			["attacker"] = 0,
			["defender"] = 0
		};
		
		local scripted_army = {
			["attacker"] = false,
			["defender"] = false
		};
		
		local gor_rok_scripted_army = {
			["gor_rok_attacker"] = false,
			["gor_rok_defender"] = false
		};

		local won_battle = {
			["attacker"] = {},
			["defender"] = {}
		};
		
		local rebel = {
			["attacker"] = false,
			["defender"] = false
		};
		

		for i = 1, cm:pending_battle_cache_num_attackers() do
			local this_char_cqi, this_mf_cqi, current_faction_name = cm:pending_battle_cache_get_attacker(i);
			local character = cm:get_character_by_cqi(this_char_cqi);
			
			if current_faction_name == "rebels" then
				rebel["attacker"] = true;
			elseif current_faction_name == wanted_level_scripted_army_faction then
				scripted_army["attacker"] = true;
				local character_subtype = cm:pending_battle_cache_get_attacker_subtype(i)

				if (character_subtype == "wh2_dlc13_lzd_gor_rok") then
					gor_rok_scripted_army["gor_rok_attacker"] = true;
				end
			end;
			
			if check_wulfhart_general(character) then
				table.insert(wulfhart_generals["attacker"], this_char_cqi);
				
				if character:won_battle() then
					table.insert(won_battle["attacker"], this_char_cqi);
				end;
			end;
			
			if not character or (not character:military_force():is_armed_citizenry() and character:is_wounded()) then
				lord_wounded["attacker"] = lord_wounded["attacker"] + 1;
			end;
		end;
		
		for i = 1, cm:pending_battle_cache_num_defenders() do
			local this_char_cqi, this_mf_cqi, current_faction_name = cm:pending_battle_cache_get_defender(i);
			local character = cm:get_character_by_cqi(this_char_cqi);
			
			if current_faction_name == "rebels" then
				rebel["defender"] = true;
			elseif current_faction_name == wanted_level_scripted_army_faction then
				scripted_army["defender"] = true;
				local character_subtype = cm:pending_battle_cache_get_defender_subtype(i)

				if (character_subtype == "wh2_dlc13_lzd_gor_rok") then
					gor_rok_scripted_army["gor_rok_defender"] = true;
				end
			end;
			
			if check_wulfhart_general(character) then
				table.insert(wulfhart_generals["defender"], this_char_cqi);
				
				if character:won_battle() then
					table.insert(won_battle["defender"], this_char_cqi);
				end;
			end;
			
			if not character or (not character:military_force():is_armed_citizenry() and character:is_wounded()) then
				lord_wounded["defender"] = lord_wounded["defender"] + 1;
			end;
		end;
		
		if cm:pending_battle_cache_faction_is_attacker(wulfhart_faction) then
			if cm:pending_battle_cache_attacker_victory() then
				if not scripted_army["defender"] and not rebel["defender"] then
					update_wanted_bar("increase_kill_army");
				else
					update_wanted_bar("increase_kill_scripted_army");
					wanted_level_scripted_army_expire_counter = wanted_level_scripted_army_expire_counter_default;
				end;
				
				if cm:pending_battle_cache_subculture_is_defender("wh2_main_sc_lzd_lizardmen") then
					--update_progress_bar("increase_lzd");
				end;

				if gor_rok_scripted_army["gor_rok_defender"] then
					core:trigger_event("GorRokDefeated");
				end
			end;
			
			if cm:pending_battle_cache_defender_victory() and lord_wounded["attacker"] > 0 then
				update_wanted_bar("decrease_major");
			end;
		elseif cm:pending_battle_cache_faction_is_defender(wulfhart_faction) and cm:pending_battle_cache_defender_victory() then
			if cm:pending_battle_cache_attacker_victory() and lord_wounded["defender"] > 0 then
				update_wanted_bar("decrease_major");
			end;
			
			if cm:pending_battle_cache_defender_victory() and cm:pending_battle_cache_subculture_is_attacker("wh2_main_sc_lzd_lizardmen") then
				--update_progress_bar("increase_lzd");

				if gor_rok_scripted_army["gor_rok_attacker"] then
					core:trigger_event("GorRokDefeated");
				end
			end;

		end;		
	end,
	true
);

core:add_listener(
	"wanted_bar_update_raid",
	"CharacterTurnStart",
	function(context)
		local character = context:character();
		
		return check_wulfhart_general(character) and character:has_military_force() and character:military_force():active_stance() == "MILITARY_FORCE_ACTIVE_STANCE_TYPE_LAND_RAID";
	end,
	function()
		update_wanted_bar("increase_minor");
	end,
	true
);

core:add_listener(
	"wanted_bar_update_neutural",
	"FactionTurnEnd",
	function(context)
		local faction = context:faction();
		
		return faction:name() == wulfhart_faction and faction:is_human();
	end,
	function()
		if wanted_lvl_increased > 0 then
			wanted_level_decay_counter = wanted_level_decay_counter_default;
		end;
	end,
	true
);

--invasion army spawning
--based on a chance and checks per faction start event
--also updates the scripted army list per turn
cm:add_faction_turn_start_listener_by_name(
	"wanted_bar_invasion",
	wulfhart_faction,
	function(context)
		--check wanted bar resources to keep it up to date
		--spawn invasion army based on chance
		if wanted_level_current == 5 then
			if wanted_level_5_lock_counter > 0 then
				wanted_level_5_lock_counter = wanted_level_5_lock_counter - 1;
				update_ui_component_accordingly();
			--calling effect object again
				if wanted_level_5_lock_counter == 0 then
					update_wanted_bar("reset");
					--cm:trigger_incident(wulfhart_faction, wanted_level_change_events["reset"], true);
				end;
			end;
		elseif wanted_lvl_increased <= 0 then
			if wanted_level_decay_counter > 0 then
				wanted_level_decay_counter = wanted_level_decay_counter - 1;
				--the decrease shouldn't happen when wanted value is 0
				if wanted_level_decay_counter == 0 then
					update_wanted_bar("decrease_minor");
				end;
			end;
		end;
		wanted_lvl_increased = 0;
		update_wanted_bar();
		update_progress_bar();
		update_scripted_army_list();
		update_queued_spawn();
		
		if wanted_level_scripted_army_expire_counter > 0 then
			wanted_level_scripted_army_expire_counter = wanted_level_scripted_army_expire_counter - 1;
		end;
	end,
	true
);

--elector count dilemmas and counters
core:add_listener(
	"elector_count_dilemma_counter",
	"ScriptEventHumanFactionTurnStart",
	function(context)
		return context:faction():name() == wulfhart_faction;
	end,
	function(context)
		--spawning dilemma and arrange things accordingly
		if elector_count_details["counter"] > 0 then
			elector_count_details["counter"] = elector_count_details["counter"] - 1;
		elseif elector_count_details["counter"] == 0 and not elector_count_details["ongoing"] then
			elector_count_details["counter"] = elector_count_counter_default;
			cm:trigger_dilemma(wulfhart_faction, get_the_target_elector_count_event(get_high_elector_count()));
			elector_count_details["ongoing"] = true;
		end;
	end,
	true
);

function get_the_target_elector_count_event(elector_count_ranks)
	local rank = get_random_element(elector_count_weight_table, number_non_empty_ranks(elector_count_ranks));
	local index = get_random_element(elector_count_ranks[rank]);
	local event = get_random_element(elector_count_dilemmas[index]);
	return event;
end;

function number_non_empty_ranks(rank)
	local empty = #rank;
	
	for i = 1, #rank do
		if #rank[#rank - i + 1] == 0 then
			empty = #rank - i;
		end;
	end;
	
	return empty;
end;

function get_random_element(due_table, limiter)	
	if limiter then
		return math.min(due_table[cm:random_number(#due_table)], limiter);
	else
		return due_table[cm:random_number(#due_table)];
	end;
end;

function get_high_elector_count()
	local elector_count_ranks = {
		{},
		{},
		{}
	};
	
	for i = 1, #elector_count_index do
		if #elector_count_ranks[1] == 0 then
			table.insert(elector_count_ranks[1], elector_count_index[i]);
		elseif get_affinity(elector_count_index[i]) > get_affinity(elector_count_ranks[1][1]) then
			elector_count_ranks[3] = elector_count_ranks[2];
			elector_count_ranks[2] = elector_count_ranks[1];
			elector_count_ranks[1] = {};
			table.insert(elector_count_ranks[1], elector_count_index[i]);
		elseif get_affinity(elector_count_index[i]) == get_affinity(elector_count_ranks[1][1]) then
			table.insert(elector_count_ranks[1], elector_count_index[i]);
		elseif #elector_count_ranks[2] == 0 then
			table.insert(elector_count_ranks[2], elector_count_index[i]);
		elseif get_affinity(elector_count_index[i]) > get_affinity(elector_count_ranks[2][1]) then
			elector_count_ranks[3] = elector_count_ranks[2];
			elector_count_ranks[2] = {};
			table.insert(elector_count_ranks[2], elector_count_index[i]);
		elseif get_affinity(elector_count_index[i]) == get_affinity(elector_count_ranks[2][1]) then
			table.insert(elector_count_ranks[2], elector_count_index[i]);
		elseif #elector_count_ranks[3] == 0 then
			table.insert(elector_count_ranks[3], elector_count_index[i]);
		elseif get_affinity(elector_count_index[i]) > get_affinity(elector_count_ranks[3][1]) then
			elector_count_ranks[3] = {};
			table.insert(elector_count_ranks[3], elector_count_index[i]);
		elseif get_affinity(elector_count_index[i]) == get_affinity(elector_count_ranks[3][1])	then
			table.insert(elector_count_ranks[3], elector_count_index[i]);
		end;
	end;
	
	return elector_count_ranks;
end;

function get_affinity(index)
	return elector_count_details[index][2];
end;

core:add_listener(
	"elector_count_choice_made",
	"ScriptEventHumanFactionTurnStart",
	function(context)
		return elector_count_details["ongoing"] and context:faction():name() == wulfhart_faction;
	end,
	function(context)
		local faction = context:faction();
		
		for i = 1, #elector_count_index do
			if faction:has_effect_bundle(elector_count_details[elector_count_index[i]][3]) then
				elector_count_details[elector_count_index[i]][2] = get_affinity(elector_count_index[i]) + 1;
				
				if get_affinity(elector_count_index[i]) == elector_count_incidents["threshold"] then
					reset_elector_count_reward(elector_count_incidents[elector_count_index[i]][1]);
				elseif get_affinity(elector_count_index[i]) > elector_count_incidents["threshold"] then
					reset_elector_count_reward(elector_count_incidents[elector_count_index[i]][2]);
				else
					reset_elector_count_reward(get_random_element(elector_count_incidents["generic"]));
				end;
				
				cm:remove_effect_bundle(elector_count_details[elector_count_index[i]][3], wulfhart_faction);
				elector_count_details["ongoing"] = false;
			end;
		end;
	end,
	true
);

function reset_elector_count_reward(event)
	elector_count_reward_queued["event"] = event;
	elector_count_reward_queued["counter"] = elector_count_reward_counter_default;
	elector_count_reward_queued["active"] = true;
	out("setup special reward events " .. event);
end;

core:add_listener(
	"elector_count_incident_procedure",
	"ScriptEventHumanFactionTurnStart",
	function(context)
		return elector_count_reward_queued["active"] and context:faction():name() == wulfhart_faction;
	end,
	function()
		if elector_count_reward_queued["counter"] == 0 then
			cm:trigger_incident(wulfhart_faction, elector_count_reward_queued["event"], true);
			elector_count_reward_queued["active"] = false;
		else
			elector_count_reward_queued["counter"] = elector_count_reward_queued["counter"] - 1;
		end
	end,
	true
);

---save/load functions
cm:add_saving_game_callback(
	function(context)
		cm:save_named_value("wanted_level_scripted_army_list", wanted_level_scripted_army_list, context);
		cm:save_named_value("wanted_level_scripted_army_counter", wanted_level_scripted_army_counter, context);
		cm:save_named_value("imperial_guard_meter", imperial_guard_meter, context);
		cm:save_named_value("wanted_lvl_increased", wanted_lvl_increased, context);
		cm:save_named_value("wanted_level_current", wanted_level_current, context);
		cm:save_named_value("wanted_level_scripted_army_expire_counter", wanted_level_scripted_army_expire_counter, context);
		cm:save_named_value("wanted_level_decay_counter", wanted_level_decay_counter, context);
		cm:save_named_value("elector_count_details", elector_count_details, context);
		cm:save_named_value("elector_count_reward_queued", elector_count_reward_queued, context);
		cm:save_named_value("progress_lock", progress_lock, context);
		cm:save_named_value("supply_delay_counter", supply_delay_counter, context);
		cm:save_named_value("campaign_progress_half", campaign_progress_half, context);
		cm:save_named_value("queued_army_spawn", queued_army_spawn, context);
		cm:save_named_value("wanted_level_5_lock_counter", wanted_level_5_lock_counter, context);
	end
);

cm:add_loading_game_callback(
	function(context)
		if not cm:is_new_game() then
			wanted_level_scripted_army_list = cm:load_named_value("wanted_level_scripted_army_list", wanted_level_scripted_army_list, context);
			wanted_level_scripted_army_counter = cm:load_named_value("wanted_level_scripted_army_counter", wanted_level_scripted_army_counter, context);
			imperial_guard_meter = cm:load_named_value("imperial_guard_meter", imperial_guard_meter, context);
			wanted_lvl_increased = cm:load_named_value("wanted_lvl_increased", wanted_lvl_increased, context);
			wanted_level_current = cm:load_named_value("wanted_level_current", wanted_level_current, context);
			wanted_level_scripted_army_expire_counter = cm:load_named_value("wanted_level_scripted_army_expire_counter", wanted_level_scripted_army_expire_counter, context);
			wanted_level_decay_counter = cm:load_named_value("wanted_level_decay_counter", wanted_level_decay_counter_default, context);
			elector_count_details = cm:load_named_value("elector_count_details", elector_count_details, context);
			elector_count_reward_queued = cm:load_named_value("elector_count_reward_queued", elector_count_reward_queued, context);
			progress_lock = cm:load_named_value("progress_lock", progress_lock, context);
			supply_delay_counter = cm:load_named_value("supply_delay_counter", supply_delay_counter, context);
			campaign_progress_half = cm:load_named_value("campaign_progress_half", campaign_progress_half, context);
			queued_army_spawn = cm:load_named_value("queued_army_spawn", queued_army_spawn, context);
			wanted_level_5_lock_counter = cm:load_named_value("wanted_level_5_lock_counter", wanted_level_5_lock_counter, context);
		end;
	end
);