
-----------------------------------------------------------------------------------
-----------------------------------------------------------------------------------
--
--	QUESTS
--	This script kicks off character quests when they rank up to the required level
--
-----------------------------------------------------------------------------------
-----------------------------------------------------------------------------------

local alt_quests = {};

function q_setup()	
	local tyrion_subtype = "wh2_main_hef_tyrion";
	local teclis_subtype = "wh2_main_hef_teclis";
	local alarielle_subtype = "wh2_dlc10_hef_alarielle";
	local alith_anar_subtype = "wh2_dlc10_hef_alith_anar";
	local eltharion_subtype = "wh2_dlc15_hef_eltharion";
	local imrik_subtype = "wh2_dlc15_hef_imrik";
	
	local malekith_subtype = "wh2_main_def_malekith";
	local morathi_subtype = "wh2_main_def_morathi";
	local hellebron_subtype = "wh2_dlc10_def_crone_hellebron";
	local malus_subtype = "wh2_dlc14_def_malus_darkblade";
	
	local mazdamundi_subtype = "wh2_main_lzd_lord_mazdamundi";
	local kroq_gar_subtype = "wh2_main_lzd_kroq_gar";
	local tehenhauin_subtype = "wh2_dlc12_lzd_tehenhauin";
	local tiktaqto_subtype = "wh2_dlc12_lzd_tiktaqto";
	local nakai_subtype = "wh2_dlc13_lzd_nakai";
	local gorrok_subtype = "wh2_dlc13_lzd_gor_rok";
	
	local skrolk_subtype = "wh2_main_skv_lord_skrolk";
	local queek_headtaker_subtype = "wh2_main_skv_queek_headtaker";
	local tretch_craventail_subtype = "wh2_dlc09_skv_tretch_craventail";
	local ikit_claw_subtype = "wh2_dlc12_skv_ikit_claw";
	local snikch_subtype = "wh2_dlc14_skv_deathmaster_snikch";
	local throt_subtype = "wh2_dlc16_skv_throt_the_unclean";
	
	local settra_subtype = "wh2_dlc09_tmb_settra";
	local arkhan_subtype = "wh2_dlc09_tmb_arkhan";
	local khatep_subtype = "wh2_dlc09_tmb_khatep";
	local khalida_subtype = "wh2_dlc09_tmb_khalida";
	
	local harkon_subtype = "wh2_dlc11_cst_harkon";
	local noctilus_subtype = "wh2_dlc11_cst_noctilus";
	local aranessa_subtype = "wh2_dlc11_cst_aranessa";
	local cylostra_subtype = "wh2_dlc11_cst_cylostra";
	local lokhir_subtype = "wh2_dlc11_def_lokhir";
	
	local wulfhart_subtype = "wh2_dlc13_emp_cha_markus_wulfhart_0";

	local repanse_subtype = "wh2_dlc14_brt_repanse";

	local grom_the_paunch_subtype = "wh2_dlc15_grn_grom_the_paunch";
	
	local sisters_of_twilight_subtype = "wh2_dlc16_wef_sisters_of_twilight";
	
	--factions for each subtype, this will be used to check if they are in their own faction or confederated, if latter, we trigger mpc version of the mission
	local tyrion_faction = "wh2_main_hef_eataine";
	local teclis_faction = "wh2_main_hef_order_of_loremasters";
	local alarielle_faction = "wh2_main_hef_avelorn";
	local alith_anar_faction = "wh2_main_hef_nagarythe";
	local eltharion_faction = "wh2_main_hef_yvresse";
	local imrik_faction = "wh2_dlc15_hef_imrik";
	
	local malekith_faction = "wh2_main_def_naggarond";
	local morathi_faction = "wh2_main_def_cult_of_pleasure";
	local hellebron_faction = "wh2_main_def_har_ganeth";
	local malus_faction = "wh2_main_def_hag_graef";
	
	local mazdamundi_faction = "wh2_main_lzd_hexoatl";
	local kroq_gar_faction = "wh2_main_lzd_last_defenders";
	local tehenhauin_faction = "wh2_dlc12_lzd_cult_of_sotek";
	local tiktaqto_faction = "wh2_main_lzd_tlaqua";
	local nakai_faction = "wh2_dlc13_lzd_spirits_of_the_jungle";
	local gorrok_faction = "wh2_main_lzd_itza";
	
	local skrolk_faction = "wh2_main_skv_clan_pestilens";
	local queek_headtaker_faction = "wh2_main_skv_clan_mors";
	local tretch_craventail_faction = "wh2_dlc09_skv_clan_rictus";
	local ikit_claw_faction = "wh2_main_skv_clan_skyre";
	local snikch_faction = "wh2_main_skv_clan_eshin";
	local throt_faction = "wh2_main_skv_clan_moulder";
	
	local settra_faction = "wh2_dlc09_tmb_khemri";
	local arkhan_faction = "wh2_dlc09_tmb_followers_of_nagash";
	local khatep_faction = "wh2_dlc09_tmb_exiles_of_nehek";
	local khalida_faction = "wh2_dlc09_tmb_lybaras";
	
	local harkon_faction = "wh2_dlc11_cst_vampire_coast";
	local noctilus_faction = "wh2_dlc11_cst_noctilus";
	local aranessa_faction = "wh2_dlc11_cst_pirates_of_sartosa";
	local cylostra_faction = "wh2_dlc11_cst_the_drowned";
	local lokhir_faction = "wh2_dlc11_def_the_blessed_dread";
	
	local wulfhart_faction = "wh2_dlc13_emp_the_huntmarshals_expedition";

	local repanse_faction = "wh2_dlc14_brt_chevaliers_de_lyonesse";

	local grom_the_paunch_faction = "wh2_dlc15_grn_broken_axe";

	local sisters_of_twilight_faction = "wh2_dlc16_wef_sisters_of_twilight";

	-- type, ancillary key, mission key, rank required, [optional] mission key if playing MPC, [optional] advice key, [optional] log x co-ord, [optional] log y co-ord, [optional] target region
	local tyrion_quests = {
		{"mission", "wh2_main_anc_armour_dragon_armour_of_aenarion", "wh2_main_great_vortex_hef_tyrion_dragon_armour_of_aenarion_stage_1", 6, "wh2_main_great_vortex_hef_tyrion_dragon_armour_of_aenarion_stage_4_mpc", "war.camp.advice.quest.tyrion.dragon_armour_of_aenarion.001"},
		{"mission", "wh2_main_anc_weapon_sunfang", "wh2_main_great_vortex_hef_tyrion_sunfang_stage_1", 10, "wh2_main_great_vortex_hef_tyrion_sunfang_stage_4_mpc", "war.camp.advice.quest.tyrion.sunfang.001"},
		{"ai_only", "wh2_main_anc_enchanted_item_heart_of_avelorn", nil, 14},
		{"mission", "wh2_main_anc_enchanted_item_heart_of_avelorn", "wh2_main_vortex_narrative_hef_the_phoenix_gate", 2}
	};
	--add_to_alt_quests(ancillary_key, final_mission_key, character_subtype)
	add_to_alt_quests("wh2_main_anc_enchanted_item_heart_of_avelorn", "wh2_main_vortex_narrative_hef_the_phoenix_gate", "wh2_main_hef_tyrion");
	
	local teclis_quests = {
		{"mission", "wh2_main_anc_arcane_item_war_crown_of_saphery", "wh2_main_great_vortex_hef_teclis_war_crown_of_saphery_stage_1", 6, "wh2_main_great_vortex_hef_teclis_war_crown_of_saphery_stage_3_mpc", "war.camp.advice.quest.teclis.war_crown_of_saphery.001"},
		{"mission", "wh2_main_anc_weapon_sword_of_teclis", "wh2_main_great_vortex_hef_teclis_sword_of_teclis_stage_1", 10, "wh2_main_great_vortex_hef_teclis_sword_of_teclis_stage_3_mpc", "war.camp.advice.quest.teclis.sword_of_teclis.001"},
		{"ai_only", "wh2_main_anc_arcane_item_moon_staff_of_lileath", nil, 14},
		{"ai_only", "wh2_main_anc_arcane_item_scroll_of_hoeth", nil, 18},
		{"mission", "wh2_main_anc_arcane_item_scroll_of_hoeth", "wh2_main_vortex_narrative_hef_the_lies_of_the_druchii", 2},
		{"mission", "wh2_main_anc_arcane_item_moon_staff_of_lileath", "wh2_main_vortex_narrative_hef_the_vermin_of_hruddithi", 4}
	};
	--add_to_alt_quests(ancillary_key, final_mission_key, character_subtype)
	add_to_alt_quests("wh2_main_anc_arcane_item_scroll_of_hoeth", "wh2_main_vortex_narrative_hef_the_lies_of_the_druchii", "wh2_main_hef_teclis");
	add_to_alt_quests("wh2_main_anc_arcane_item_moon_staff_of_lileath", "wh2_main_vortex_narrative_hef_the_vermin_of_hruddithi", "wh2_main_hef_teclis");
	
	local alarielle_quests = {
		{"mission", "wh2_dlc10_anc_talisman_shieldstone_of_isha", "wh2_dlc10_vortex_alarielle_shieldstone_of_isha_1", 2},
		{"mission", "wh2_dlc10_anc_enchanted_item_star_of_avelorn", "wh2_dlc10_great_vortex_hef_alarielle_star_of_avelorn_stage_1", 15, "wh2_dlc10_great_vortex_hef_alarielle_star_of_avelorn_stage_5_mpc"}
	};
	--add_to_alt_quests(ancillary_key, final_mission_key, character_subtype)
	add_to_alt_quests("wh2_dlc10_anc_talisman_shieldstone_of_isha", "wh2_dlc10_vortex_alarielle_shieldstone_of_isha_1", "wh2_dlc10_hef_alarielle");
	
	local alith_anar_quests = {
		{"mission", "wh2_dlc10_anc_enchanted_item_the_shadow_crown", "wh2_dlc10_great_vortex_hef_alith_anar_the_shadow_crown", 2},
		{"mission", "wh2_dlc10_anc_weapon_moonbow", "wh2_dlc10_great_vortex_hef_alith_anar_the_moonbow_stage_1", 5, "wh2_dlc10_great_vortex_hef_alith_anar_the_moonbow_stage_4_mpc"}
	};
	--add_to_alt_quests(ancillary_key, final_mission_key, character_subtype)
	add_to_alt_quests("wh2_dlc10_anc_enchanted_item_the_shadow_crown", "wh2_dlc10_great_vortex_hef_alith_anar_the_shadow_crown", "wh2_dlc10_hef_alith_anar");

	local eltharion_quests = {
		{"mission","wh2_dlc15_anc_talisman_talisman_of_hoeth","wh2_dlc15_vortex_hef_eltharion_talisman_of_hoeth_stage_1",5,"wh2_dlc15_vortex_hef_eltharion_talisman_of_hoeth_stage_3_mpc"},
		{"mission","wh2_dlc15_anc_armour_helm_of_yvresse","wh2_dlc15_vortex_hef_eltharion_helm_of_yvresse_stage_1",7},
		{"mission","wh2_dlc15_anc_weapon_fangsword_of_eltharion","wh2_dlc15_vortex_hef_eltharion_fangsword_of_eltharion_stage_1",10}
	}
	--add_to_alt_quests(ancillary_key, final_mission_key, character_subtype)
	add_to_alt_quests("wh2_dlc15_anc_weapon_fangsword_of_eltharion","wh2_dlc15_vortex_hef_eltharion_fangsword_of_eltharion_stage_1", "wh2_dlc15_hef_eltharion");
	add_to_alt_quests("wh2_dlc15_anc_armour_helm_of_yvresse","wh2_dlc15_vortex_hef_eltharion_helm_of_yvresse_stage_1", "wh2_dlc15_hef_eltharion");


	local imrik_quests = {
		{"mission","wh2_dlc15_anc_armour_armour_of_caledor","wh2_dlc15_vortex_hef_imrik_armour_of_caledor_stage_1",5,"wh2_dlc15_vortex_hef_imrik_armour_of_caledor_stage_3_mpc"},
	}
		
	local malekith_quests = {
		{"mission", "wh2_main_anc_arcane_item_circlet_of_iron", "wh2_main_great_vortex_def_malekith_circlet_of_iron_stage_1", 6, "wh2_main_great_vortex_def_malekith_circlet_of_iron_stage_3_mpc", "war.camp.advice.quest.malekith.circlet_of_iron.001"},
		{"mission", "wh2_main_anc_weapon_destroyer", "wh2_main_great_vortex_def_malekith_destroyer_stage_1", 10, "wh2_main_great_vortex_def_malekith_destroyer_stage_3_mpc", "war.camp.advice.quest.malekith.destroyer.001"},
		{"mission", "wh2_main_anc_armour_supreme_spellshield", "wh2_main_great_vortex_def_malekith_supreme_spellshield_stage_1", 14, "wh2_main_great_vortex_def_malekith_supreme_spellshield_stage_3_mpc", "war.camp.advice.quest.malekith.supreme_spellshield.001"},
		{"ai_only", "wh2_main_anc_armour_armour_of_midnight", nil, 18},
		{"mission", "wh2_main_anc_armour_armour_of_midnight", "wh2_main_vortex_narrative_def_hoteks_levy", 2}
	};
	--add_to_alt_quests(ancillary_key, final_mission_key, character_subtype)
	add_to_alt_quests("wh2_main_anc_armour_armour_of_midnight", "wh2_main_vortex_narrative_def_hoteks_levy", "wh2_main_def_malekith");
	
	local morathi_quests = {
		{"mission", "wh2_main_anc_weapon_heartrender_and_the_darksword", "wh2_main_great_vortex_def_morathi_heartrender_and_the_darksword_stage_1", 6, "wh2_main_great_vortex_def_morathi_heartrender_and_the_darksword_stage_6_mpc", "war.camp.advice.quest.morathi.heartrender_and_the_darksword.001"},
		{"mission", "wh2_main_anc_arcane_item_wand_of_the_kharaidon", "wh2_dlc14_def_wand_of_kharaidon", 4},
		{"mission", "wh2_main_anc_talisman_amber_amulet", "wh2_dlc14_def_amber_amulet", 2}
	};
		--add_to_alt_quests(ancillary_key, final_mission_key, character_subtype)
	add_to_alt_quests("wh2_main_anc_arcane_item_wand_of_the_kharaidon", "wh2_dlc14_def_wand_of_kharaidon", "wh2_main_def_morathi");
	add_to_alt_quests("wh2_main_anc_talisman_amber_amulet", "wh2_dlc14_def_amber_amulet", "wh2_main_def_morathi");
	
	local hellebron_quests = {
		{"mission", "wh2_dlc10_anc_weapon_deathsword_and_the_cursed_blade", "wh2_dlc10_great_vortex_def_hellebron_deathsword_and_the_cursed_blade_stage_1", 8, "wh2_dlc10_great_vortex_def_hellebron_deathsword_and_the_cursed_blade_stage_4_mpc"},
		{"mission", "wh2_dlc10_anc_talisman_amulet_of_dark_fire", "wh2_dlc10_great_vortex_def_hellebron_amulet_of_dark_fire_stage_1", 2}
	};
	--add_to_alt_quests(ancillary_key, final_mission_key, character_subtype)
	add_to_alt_quests("wh2_dlc10_anc_talisman_amulet_of_dark_fire", "wh2_dlc10_great_vortex_def_hellebron_amulet_of_dark_fire_stage_1", "wh2_dlc10_def_crone_hellebron");
	
	local malus_quests = {
		{"mission", "wh2_dlc14_anc_weapon_warpsword_of_khaine", "wh2_dlc14_vortex_def_malus_warpsword_of_khaine_stage_1", 5, "wh2_dlc14_vortex_def_malus_warpsword_of_khaine_stage_4_mpc"}
	};

	local mazdamundi_quests = {
		{"mission", "wh2_main_anc_magic_standard_sunburst_standard_of_hexoatl", "wh2_main_great_vortex_lzd_mazdamundi_sunburst_standard_of_hexoatl_stage_1", 6, "wh2_main_great_vortex_lzd_mazdamundi_sunburst_standard_of_hexoatl_stage_4_mpc", "war.camp.advice.quest.mazdamundi.sunburst_standard_of_hexoatl.001"},
		{"mission", "wh2_main_anc_weapon_cobra_mace_of_mazdamundi", "wh2_main_great_vortex_lzd_mazdamundi_cobra_mace_of_mazdamundi_stage_1", 10, "wh2_main_great_vortex_lzd_mazdamundi_cobra_mace_of_mazdamundi_stage_3_mpc", "war.camp.advice.quest.mazdamundi.cobra_mace_of_mazdamundi.001"}
	};
	
	local kroq_gar_quests = {
		{"mission", "wh2_main_anc_weapon_revered_spear_of_tlanxla", "wh2_main_great_vortex_liz_kroq_gar_revered_spear_of_tlanxla_stage_1", 6, "wh2_main_great_vortex_liz_kroq_gar_revered_spear_of_tlanxla_stage_3_mpc", "war.camp.advice.quest.kroqgar.revered_spear_of_tlanxla.001"},
		{"mission", "wh2_main_anc_enchanted_item_hand_of_gods", "wh2_main_great_vortex_liz_kroq_gar_hand_of_gods_stage_1", 10, "wh2_main_great_vortex_liz_kroq_gar_hand_of_gods_stage_3_mpc", "war.camp.advice.quest.kroqgar.hand_of_gods.001"}
	};
	
	local tehenhauin_quests = {
		{"mission", "wh2_dlc12_anc_enchanted_item_plaque_of_sotek", "wh2_dlc12_great_vortex_lzd_tehenhauin_plaque_of_sotek_stage_1", 8, "wh2_dlc12_great_vortex_lzd_tehenhauin_plaque_of_sotek_mp"}
	};
	
	local tiktaqto_quests = {
		{"mission", "wh2_dlc12_anc_enchanted_item_mask_of_heavens", "wh2_dlc12_great_vortex_lzd_tiktaqto_mask_of_heavens_stage_1", 8, "wh2_dlc12_great_vortex_lzd_tiktaqto_mask_of_heavens_mp"}
	};
	
	local nakai_quests = {
		{"mission", "wh2_dlc13_anc_enchanted_item_golden_tributes", "wh2_dlc13_vortex_lzd_nakai_golden_tributes_stage_1", 8, "wh2_dlc13_vortex_lzd_nakai_golden_tributes_stage_3"},
		{"mission", "wh2_dlc13_talisman_the_ogham_shard", "wh2_dlc13_vortex_lzd_nakai_the_ogham_shard_stage_1", 8, "wh2_dlc13_vortex_lzd_nakai_the_ogham_shard_stage_2"}
	};
	
	local gorrok_quests = {
		{"mission", "wh2_dlc13_anc_armour_the_shield_of_aeons", "wh2_dlc13_vortex_gorrok_the_shield_of_aeons_stage_1", 8, "wh2_dlc13_vortex_gorrok_the_shield_of_aeons_stage_3"},
		{"mission", "wh2_dlc13_anc_weapon_mace_of_ulumak", "wh2_dlc14_lzd_the_mace_of_ulumak", 2}
	};
	--add_to_alt_quests(ancillary_key, final_mission_key, character_subtype)
	add_to_alt_quests("wh2_dlc13_anc_weapon_mace_of_ulumak", "wh2_dlc14_lzd_the_mace_of_ulumak", "wh2_dlc13_lzd_gor_rok");
	
	local skrolk_quests = {
		{"mission", "wh2_main_anc_arcane_item_the_liber_bubonicus", "wh2_main_great_vortex_skv_skrolk_liber_bubonicus_stage_1", 6, "wh2_main_great_vortex_skv_skrolk_liber_bubonicus_stage_3_mpc", "war.camp.advice.quest.skrolk.liber_bubonicus.001"},
		{"mission", "wh2_main_anc_weapon_rod_of_corruption", "wh2_main_great_vortex_skv_skrolk_rod_of_corruption_stage_1", 10, "wh2_main_great_vortex_skv_skrolk_rod_of_corruption_stage_3_mpc", "war.camp.advice.quest.skrolk.rod_of_corruption.001"}
	};
	
	local queek_headtaker_quests = {
		{"mission", "wh2_main_anc_armour_warp_shard_armour", "wh2_main_great_vortex_skv_queek_headtaker_warp_shard_armour_stage_1", 6, "wh2_main_great_vortex_skv_queek_headtaker_warp_shard_armour_stage_6_mpc", "war.camp.advice.quest.queek.warp_shard_armour.001"},
		{"mission", "wh2_main_anc_weapon_dwarf_gouger", "wh2_main_great_vortex_skv_queek_headtaker_dwarfgouger_stage_1", 10, "wh2_main_great_vortex_skv_queek_headtaker_dwarfgouger_stage_4_mpc", "war.camp.advice.quest.queek.dwarfgouger.001"}
	};
	
	local tretch_craventail_quests = {
		{"mission", "wh2_dlc09_anc_enchanted_item_lucky_skullhelm", "wh2_dlc09_great_vortex_skv_tretch_lucky_skullhelm_stage_1", 8, "wh2_dlc09_great_vortex_skv_tretch_lucky_skullhelm_stage_5_mpc", "dlc09.camp.advice.quest.tretch.lucky_skullhelm.001"}
	};
	
	local ikit_claw_quests = {
		{"mission", "wh2_dlc12_anc_weapon_storm_daemon", "wh2_dlc12_great_vortex_ikit_claw_storm_daemon_stage_1", 8, "wh2_dlc12_great_vortex_ikit_claw_storm_daemon_mp"}
	};
	
	local snikch_quests = {
		{"mission", "wh2_dlc14_anc_armour_the_cloak_of_shadows", "wh2_dlc14_vortex_skv_snikch_the_cloak_of_shadows_stage_1", 5, "wh2_dlc14_vortex_skv_snikch_the_cloak_of_shadows_stage_4_mpc"},
		{"mission", "wh2_dlc14_anc_weapon_whirl_of_weeping_blades", "wh2_dlc14_vortex_skv_snikch_whirl_of_weeping_blades_stage_1", 3}
	};
	--add_to_alt_quests(ancillary_key, final_mission_key, character_subtype)
	add_to_alt_quests("wh2_dlc14_anc_weapon_whirl_of_weeping_blades", "wh2_dlc14_vortex_skv_snikch_whirl_of_weeping_blades_stage_1", "wh2_dlc14_skv_snikch"); 

	local throt_quests = {
		{"mission", "wh2_dlc16_anc_enchanted_item_whip_of_domination", "wh2_dlc16_skv_throt_vortex_whip_of_domination_stage_1", 5, "wh2_dlc16_skv_throt_vortex_whip_of_domination_stage_4_mpc"},
		{"mission", "wh2_dlc16_anc_weapon_creature_killer", "wh2_dlc16_skv_throt_vortex_creature_killer_stage_1", 3}
	};
	--add_to_alt_quests(ancillary_key, final_mission_key, character_subtype)
	add_to_alt_quests("wh2_dlc16_anc_weapon_creature_killer", "wh2_dlc16_skv_throt_vortex_creature_killer_stage_1", "wh2_dlc16_skv_throt_the_unclean");

	local settra_quests = {
		{"mission", "wh2_dlc09_anc_enchanted_item_the_crown_of_nehekhara", "wh2_dlc09_great_vortex_tmb_settra_the_crown_of_nehekhara_stage_1", 6, "wh2_dlc09_great_vortex_tmb_settra_the_crown_of_nehekhara_stage_5_mpc", "dlc09.camp.advice.quest.settra.the_crown_of_nehekhara.001"},
		{"mission", "wh2_dlc09_anc_weapon_the_blessed_blade_of_ptra", "wh2_dlc09_great_vortex_tmb_settra_the_blessed_blade_of_ptra_stage_1", 13, "wh2_dlc09_great_vortex_tmb_settra_the_blessed_blade_of_ptra_stage_3_mpc", "dlc09.camp.advice.quest.settra.the_blessed_blade_of_ptra.001"}
	};
	
	local arkhan_quests = {
		{"mission", "wh2_dlc09_anc_weapon_the_tomb_blade_of_arkhan", "wh2_dlc09_great_vortex_tmb_arkhan_the_tomb_blade_of_arkhan_stage_1", 6, "wh2_dlc09_great_vortex_tmb_arkhan_the_tomb_blade_of_arkhan_stage_4_mpc", "dlc09.camp.advice.quest.arkhan.the_tomb_blade_of_arkhan.001"}
	};
	
	local khatep_quests = {
		{"mission", "wh2_dlc09_anc_arcane_item_the_liche_staff", "wh2_dlc09_vortex_tmb_khatep_the_liche_staff_1", 6, "wh2_dlc09_great_vortex_tmb_khatep_the_liche_staff_stage_5_mpc", "dlc09.camp.advice.quest.khatep.the_liche_staff.001"}
	};
	
	local khalida_quests = {
		{"mission", "wh2_dlc09_anc_weapon_the_venom_staff", "wh2_dlc09_great_vortex_tmb_khalida_venom_staff_stage_1", 12, "wh2_dlc09_great_vortex_tmb_khalida_venom_staff_stage_3_mpc", "dlc09.camp.advice.quest.khalida.venom_staff.001"}
	};
	local harkon_quests = {
		{"mission", "wh2_dlc11_anc_enchanted_item_slann_gold", "wh2_dlc11_cst_vortex_harkon_quest_for_slann_gold_stage_1", 15, "wh2_dlc11_great_vortex_qb_cst_luthor_harkon_slann_gold_MP", "wh2_dlc11.camp.advice.quest.harkon.001"}
	};
	local noctilus_quests = {
		{"mission", "wh2_dlc11_anc_enchanted_item_captain_roths_moondial", "wh2_dlc11_cst_vortex_noctilus_captain_roths_moondial_stage_1", 15, "wh2_dlc11_great_vortex_qb_cst_noctilus_captain_roths_moondial_MP", "wh2_dlc11.camp.advice.quest.noctilus.001"}
	};
	local aranessa_quests = {
		{"mission", "wh2_dlc11_anc_weapon_krakens_bane", "wh2_dlc11_great_vortex_cst_aranessa_krakens_bane_stage_1", 15, "wh2_dlc11_great_vortex_qb_cst_aranessa_saltspite_krakens_bane_MP", "wh2_dlc11.camp.advice.quest.aranessa.001"}
	};
	
	local cylostra_quests = {
		{"mission", "wh2_dlc11_anc_arcane_item_the_bordeleaux_flabellum", "wh2_dlc11_great_vortex_cst_cylostra_the_bordeleaux_flabellum_stage_1", 9, "wh2_dlc11_great_vortex_cylostra_the_bordeleaux_flabellum_mp", "wh2_dlc11.camp.advice.quest.cylostra.001"}
	};
	
	local lokhir_quests = {
		{"mission", "wh2_main_anc_armour_helm_of_the_kraken", "wh2_dlc11_great_vortex_lokhir_helm_of_the_kraken_stage_1", 11, "wh2_dlc11_great_vortex_lokhir_fellheart_helm_of_the_kraken_mp", "wh2_dlc11.camp.advice.quest.lokhir.001"},
		{"mission", "wh2_dlc11_anc_weapon_red_blades", "wh2_dlc11_great_vortex_def_lokhir_red_blades_stage_1", 2}
	};
	--add_to_alt_quests(ancillary_key, final_mission_key, character_subtype)
	add_to_alt_quests("wh2_dlc11_anc_weapon_red_blades", "wh2_dlc11_great_vortex_def_lokhir_red_blades_stage_1", "wh2_dlc11_def_lokhir");

	local wulfhart_quests = {
		{"mission", "wh2_dlc13_anc_weapon_amber_bow", "wh2_dlc13_emp_wulfhart_vor_amber_bow_stage_1", 8,"wh2_dlc13_vortex_emp_wulfhart_amber_bow_stage_4"}
	};
	
	local repanse_quests = {
		{"mission", "wh2_dlc14_anc_weapon_sword_of_lyonesse", "wh2_dlc14_vortex_brt_repanse_sword_of_lyonesse_stage_1", 5, "wh2_dlc14_vortex_brt_repanse_sword_of_lyonesse_stage_4_mpc"}
	};

	local grom_the_paunch_quests ={
		{"mission", "wh2_dlc15_anc_weapon_axe_of_grom", "wh2_dlc15_vortex_grn_grom_axe_of_grom_stage_1", 5,"wh2_dlc15_vortex_grn_grom_axe_of_grom_stage_4_mpc"},
		{"mission", "wh2_dlc15_anc_enchanted_item_lucky_banner", "wh2_dlc15_main_grn_grom_lucky_banner_stage_1", 2}
	};

	add_to_alt_quests("wh2_dlc15_anc_enchanted_item_lucky_banner", "wh2_dlc15_main_grn_grom_lucky_banner_stage_1", grom_the_paunch_subtype);
	
	local sisters_of_twilight_quests = {
		{"mission", "wh2_dlc16_anc_mount_wef_cha_sisters_of_twilight_forest_dragon", "wh2_dlc16_great_vortex_wef_sisters_dragon_stage_1", 12,"wh2_dlc16_great_vortex_wef_sisters_dragon_stage_4_mpc"}
	};

	-- assemble infotext about quests
	local infotext = {
		1,
		"wh2.camp.advice.quests.info_001",
		"wh2.camp.advice.quests.info_002",
		"wh2.camp.advice.quests.info_003"
	};
	
	-- establish the listeners
	set_up_rank_up_listener(tyrion_quests, tyrion_subtype, infotext, tyrion_faction);
	set_up_rank_up_listener(teclis_quests, teclis_subtype, infotext, teclis_faction);
	set_up_rank_up_listener(alarielle_quests, alarielle_subtype, infotext, alarielle_faction);
	set_up_rank_up_listener(alith_anar_quests, alith_anar_subtype, nil, alith_anar_faction);
	set_up_rank_up_listener(eltharion_quests, eltharion_subtype, nil, eltharion_faction);
	set_up_rank_up_listener(imrik_quests, imrik_subtype, nil, imrik_faction);
	
	set_up_rank_up_listener(malekith_quests, malekith_subtype, infotext, malekith_faction);
	set_up_rank_up_listener(morathi_quests, morathi_subtype, infotext, morathi_faction);
	set_up_rank_up_listener(hellebron_quests, hellebron_subtype, nil, hellebron_faction);
	set_up_rank_up_listener(malus_quests, malus_subtype, nil, malus_faction);
	
	set_up_rank_up_listener(mazdamundi_quests, mazdamundi_subtype, infotext, mazdamundi_faction);
	set_up_rank_up_listener(kroq_gar_quests, kroq_gar_subtype, infotext, kroq_gar_faction);
	set_up_rank_up_listener(tehenhauin_quests, tehenhauin_subtype, infotext, tehenhauin_faction);
	set_up_rank_up_listener(tiktaqto_quests, tiktaqto_subtype, infotext, tiktaqto_faction);
	set_up_rank_up_listener(nakai_quests, nakai_subtype, infotext, nakai_faction);
	set_up_rank_up_listener(gorrok_quests, gorrok_subtype, infotext, gorrok_faction);
	
	set_up_rank_up_listener(skrolk_quests, skrolk_subtype, infotext, skrolk_faction);
	set_up_rank_up_listener(queek_headtaker_quests, queek_headtaker_subtype, infotext, queek_headtaker_faction);
	set_up_rank_up_listener(tretch_craventail_quests, tretch_craventail_subtype, infotext, tretch_craventail_faction);
	set_up_rank_up_listener(ikit_claw_quests, ikit_claw_subtype, nil, ikit_claw_faction);
	set_up_rank_up_listener(snikch_quests, snikch_subtype, nil, snikch_faction);
	set_up_rank_up_listener(throt_quests, throt_subtype, nil, throt_faction);
	
	set_up_rank_up_listener(settra_quests, settra_subtype, infotext, settra_faction);
	set_up_rank_up_listener(arkhan_quests, arkhan_subtype, infotext, arkhan_faction);
	set_up_rank_up_listener(khatep_quests, khatep_subtype, infotext, khatep_faction);
	set_up_rank_up_listener(khalida_quests, khalida_subtype, infotext, khalida_faction);
	
	set_up_rank_up_listener(harkon_quests, harkon_subtype, nil, harkon_faction);
	set_up_rank_up_listener(noctilus_quests, noctilus_subtype, nil, noctilus_faction);
	set_up_rank_up_listener(aranessa_quests, aranessa_subtype, nil, aranessa_faction);
	set_up_rank_up_listener(cylostra_quests, cylostra_subtype, nil, cylostra_faction);
	set_up_rank_up_listener(lokhir_quests, lokhir_subtype, nil, lokhir_faction);

	set_up_rank_up_listener(wulfhart_quests, wulfhart_subtype, nil, wulfhart_faction);

	set_up_rank_up_listener(repanse_quests, repanse_subtype, nil, repanse_faction);

	set_up_rank_up_listener(grom_the_paunch_quests,grom_the_paunch_subtype, nil, grom_the_paunch_faction);

	set_up_rank_up_listener(sisters_of_twilight_quests, sisters_of_twilight_subtype, nil, sisters_of_twilight_faction);

	core:add_listener(
		"quest_item_listerner",
		"MissionSucceeded",
		true,
		function(context) 
			for i = 1, #alt_quests do
				if context:mission():mission_record_key() == alt_quests[i].mis then
					local character_list = context:faction():character_list();
					for j = 0, character_list:num_items() -1 do
						if character_list:item_at(j):character_subtype_key() == alt_quests[i].cha then
							cm:callback(
								function() 
									cm:force_add_ancillary(character_list:item_at(j), alt_quests[i].anc, true, true);
								end, 
								0.5);
							return true;
						end
					end
				end
			end
		end,
		true	
	);
	core:add_listener(
		"quest_item_listerner",
		"MissionCancelled",
		true,
		function(context) 
			for i = 1, #alt_quests do
				if context:mission():mission_record_key() == alt_quests[i].mis then
					local character_list = context:faction():character_list();
					for j = 0, character_list:num_items() -1 do
						if character_list:item_at(j):character_subtype_key() == alt_quests[i].cha then
							cm:force_add_ancillary(character_list:item_at(j), alt_quests[i].anc, true, false);
							return true;
						end
					end
				end
			end
		end,
		true	
	);
end;

--adds quest chains that do not end in a quest battle to a list, the chains final mission is listened for and upon completion the reward ancillary is forced upon the target character
function add_to_alt_quests(ancillary_key, final_mission_key, character_subtype)
	local alt_quest_entry = {mis = final_mission_key, anc = ancillary_key, cha = character_subtype};
	table.insert(alt_quests, alt_quest_entry);
end