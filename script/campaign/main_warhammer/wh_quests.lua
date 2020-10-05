
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
	local karl_franz_subtype = "emp_karl_franz";
	local balthasar_gelt_subtype = "emp_balthasar_gelt";
	local volkmar_the_grim_subtype = "dlc04_emp_volkmar";
	local wulfhart_subtype = "wh2_dlc13_emp_cha_markus_wulfhart_0";
	
	local thorgrim_grudgebearer_subtype = "dwf_thorgrim_grudgebearer";
	local ungrim_ironfist_subtype = "dwf_ungrim_ironfist";
	local grombrindal_subtype = "pro01_dwf_grombrindal";
	
	local grimgor_ironhide_subtype = "grn_grimgor_ironhide";
	local azhag_the_slaughterer_subtype = "grn_azhag_the_slaughterer";
	local grom_the_paunch_subtype = "wh2_dlc15_grn_grom_the_paunch";
	
	local mannfred_von_carstein_subtype = "vmp_mannfred_von_carstein";
	local heinrich_kemmler_subtype = "vmp_heinrich_kemmler";
	local vlad_von_carstein_subtype = "dlc04_vmp_vlad_con_carstein";
	local helman_ghorst_subtype = "dlc04_vmp_helman_ghorst";
	local isabella_subtype = "pro02_vmp_isabella_von_carstein";
	
	local archaon_the_everchosen_subtype = "chs_archaon";
	local prince_sigvald_subtype = "chs_prince_sigvald";
	local kholek_suneater_subtype = "chs_kholek_suneater";
	
	local khazrak_subtype = "dlc03_bst_khazrak";
	local malagor_subtype = "dlc03_bst_malagor";
	local morghur_subtype = "dlc05_bst_morghur";
	
	local belegar_subtype = "dlc06_dwf_belegar";
	local skarsnik_subtype = "dlc06_grn_skarsnik";
	local wurrzag_subtype = "dlc06_grn_wurrzag_da_great_prophet";
	
	local orion_subtype = "dlc05_wef_orion";
	local durthu_subtype = "dlc05_wef_durthu";

	local fay_enchantress_subtype = "dlc07_brt_fay_enchantress";
	local louen_subtype = "brt_louen_leoncouer";
	local alberic_subtype = "dlc07_brt_alberic";
	local repanse_subtype = "wh2_dlc14_brt_repanse";

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
	
	local settra_subtype = "wh2_dlc09_tmb_settra";
	local arkhan_subtype = "wh2_dlc09_tmb_arkhan";
	local khatep_subtype = "wh2_dlc09_tmb_khatep";
	local khalida_subtype = "wh2_dlc09_tmb_khalida";
	
	local wulfrik_subtype = "wh_dlc08_nor_wulfrik";
	local throgg_subtype = "wh_dlc08_nor_throgg";
	
	local harkon_subtype = "wh2_dlc11_cst_harkon";
	local noctilus_subtype = "wh2_dlc11_cst_noctilus";
	local aranessa_subtype = "wh2_dlc11_cst_aranessa";
	local cylostra_subtype = "wh2_dlc11_cst_cylostra";
	local lokhir_subtype = "wh2_dlc11_def_lokhir";
	
	--factions for each subtype, this will be used to check if they are in their own faction or confederated, if latter, wew trigger mpc version of the mission
	local karl_franz_faction = "wh_main_emp_empire";
	local balthasar_gelt_faction = "wh2_dlc13_emp_golden_order";
	local volkmar_the_grim_faction = "wh_main_emp_empire";
	local wulfhart_faction = "wh2_dlc13_emp_the_huntmarshals_expedition";
	
	local thorgrim_grudgebearer_faction = "wh_main_dwf_dwarfs";
	local ungrim_ironfist_faction = "wh_main_dwf_karak_kadrin";
	local grombrindal_faction = "wh_main_dwf_dwarfs";
	
	local grimgor_ironhide_faction = "wh_main_grn_greenskins";
	local azhag_the_slaughterer_faction = "wh2_dlc15_grn_bonerattlaz";
	local grom_the_paunch_faction = "wh2_dlc15_grn_broken_axe";
	
	local mannfred_von_carstein_faction = "wh_main_vmp_vampire_counts";
	local heinrich_kemmler_faction = "wh2_dlc11_vmp_the_barrow_legion";
	local vlad_von_carstein_faction = "wh_main_vmp_schwartzhafen";
	local helman_ghorst_faction = "wh_main_vmp_vampire_counts";
	local isabella_faction = "wh_main_vmp_schwartzhafen";
	
	local archaon_the_everchosen_faction = "wh_main_chs_chaos";
	local prince_sigvald_faction = "wh_main_chs_chaos";
	local kholek_suneater_faction = "wh_main_chs_chaos";
	
	local khazrak_faction = "wh_dlc03_bst_beastmen";
	local malagor_faction = "wh_dlc03_bst_beastmen";
	local morghur_faction = "wh_dlc03_bst_beastmen";
	
	local belegar_faction = "wh_main_dwf_karak_izor";
	local skarsnik_faction = "wh_main_grn_crooked_moon";
	local wurrzag_faction = "wh_main_grn_orcs_of_the_bloody_hand";
	
	local orion_faction = "wh_dlc05_wef_wood_elves";
	local durthu_faction = "wh_dlc05_wef_argwylon";

	local fay_enchantress_faction = "wh_main_brt_carcassonne";
	local louen_faction = "wh_main_brt_bretonnia";
	local alberic_faction = "wh_main_brt_bordeleaux";
	local repanse_faction = "wh2_dlc14_brt_chevaliers_de_lyonesse";

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
	
	local settra_faction = "wh2_dlc09_tmb_khemri";
	local arkhan_faction = "wh2_dlc09_tmb_followers_of_nagash";
	local khatep_faction = "wh2_dlc09_tmb_exiles_of_nehek";
	local khalida_faction = "wh2_dlc09_tmb_lybaras";
	
	local wulfrik_faction = "wh_dlc08_nor_norsca";
	local throgg_faction = "wh_dlc08_nor_wintertooth";
	
	local harkon_faction = "wh2_dlc11_cst_vampire_coast";
	local noctilus_faction = "wh2_dlc11_cst_noctilus";
	local aranessa_faction = "wh2_dlc11_cst_pirates_of_sartosa";
	local cylostra_faction = "wh2_dlc11_cst_the_drowned";
	local lokhir_faction = "wh2_dlc11_def_the_blessed_dread";
	
	-- type, ancillary key, mission key, rank required, [optional] mission key if playing MPC
	local karl_franz_quests = {
		{"mission", "wh2_dlc13_anc_weapon_runefang_drakwald", "wh_main_emp_karl_franz_reikland_runefang_stage_1", 3, "wh_main_emp_karl_franz_reikland_runefang_stage_3a_mpc"},
		{"mission", "wh_main_anc_weapon_ghal_maraz", "wh_main_emp_karl_franz_ghal_maraz_stage_1", 14,"wh_main_emp_karl_franz_ghal_maraz_stage_3.1_mpc"},
		{"mission", "wh_main_anc_talisman_the_silver_seal", "wh_main_emp_karl_franz_silver_seal_stage_1", 8}
	};
	
	local balthasar_gelt_quests = {
		{"mission", "wh_main_anc_enchanted_item_cloak_of_molten_metal", "wh_main_emp_balthasar_gelt_cloak_of_molten_metal_stage_1", 4,"wh_main_emp_balthasar_gelt_cloak_of_molten_metal_stage_5a_mpc"},
		{"mission", "wh_main_anc_talisman_amulet_of_sea_gold", "wh_main_emp_balthasar_gelt_amulet_of_sea_gold_stage_1.1", 8,"wh_main_emp_balthasar_gelt_amulet_of_sea_gold_stage_4.1a_mpc"},
		{"mission", "wh_main_anc_arcane_item_staff_of_volans", "wh_main_emp_balthasar_gelt_staff_of_volans_stage_1", 14,"wh_main_qb_emp_balthasar_gelt_staff_of_volans_stage_3_battle_of_bloodpine_woods_mpc"}
	};
	
	add_to_alt_quests("wh_main_anc_arcane_item_staff_of_volans", "wh_main_emp_balthasar_gelt_staff_of_volans_stage_4", balthasar_gelt_subtype)

	local volkmar_the_grim_quests = {
		{"mission", "wh_dlc04_anc_talisman_jade_griffon", "wh_dlc04_emp_volkmar_the_grim_jade_griffon_stage_1", 5,"wh_dlc04_emp_volkmar_the_grim_jade_griffon_stage_4_mpc"},
		{"mission", "wh_dlc04_anc_weapon_staff_of_command", "wh_dlc04_emp_volkmar_the_grim_staff_of_command_stage_1", 10,"wh_dlc04_emp_volkmar_the_grim_staff_of_command_stage_5_mpc"}
	};

	local wulfhart_quests = {
		{"mission", "wh2_dlc13_anc_weapon_amber_bow", "wh2_dlc13_emp_wulfhart_amber_bow_stage_1", 8,"wh2_dlc13_emp_wulfhart_amber_bow_stage_4"}
	};

	local thorgrim_grudgebearer_quests = {
		{"mission", "wh_main_anc_weapon_the_axe_of_grimnir", "wh_main_dwf_thorgrim_grudgebearer_axe_of_grimnir_stage_1", 8,"wh_main_dwf_thorgrim_grudgebearer_axe_of_grimnir_stage_3a_mpc"},
		{"mission", "wh_main_anc_armour_the_armour_of_skaldour", "wh_main_dwf_thorgrim_grudgebearer_armour_of_skaldour_stage_1", 13,"wh_main_dwf_thorgrim_grudgebearer_armour_of_skaldour_stage_4a_mpc"},
		{"mission", "wh_main_anc_talisman_the_dragon_crown_of_karaz", "wh_main_dwf_thorgrim_grudgebearer_dragon_crown_of_karaz_stage_1", 18,"wh_main_dwf_thorgrim_grudgebearer_dragon_crown_of_karaz_stage_3a_mpc"},
		{"mission", "wh_main_anc_enchanted_item_the_great_book_of_grudges", "wh_main_dwf_thorgrim_grudgebearer_book_of_grudges_stage_1", 23,"wh_main_dwf_thorgrim_grudgebearer_book_of_grudges_stage_2_mpc"}
	};
	
	local ungrim_ironfist_quests = {
		{"mission", "wh_main_anc_armour_the_slayer_crown", "wh_main_dwf_ungrim_ironfist_slayer_crown_stage_1", 8,"wh_main_dwf_ungrim_ironfist_slayer_crown_stage_4a_mpc"},
		{"mission", "wh_main_anc_talisman_dragon_cloak_of_fyrskar", "wh_main_dwf_ungrim_ironfist_dragon_cloak_of_fyrskar_stage_1", 13,"wh_main_dwf_ungrim_ironfist_dragon_cloak_of_fyrskar_stage_3.2a_mpc"},
		{"mission", "wh_main_anc_weapon_axe_of_dargo", "wh_main_dwf_ungrim_ironfist_axe_of_dargo_stage_1", 18,"wh_main_dwf_ungrim_ironfist_axe_of_dargo_stage_3_mpc"}
	};
	
	local grombrindal_quests = {
		{"mission", "wh_pro01_anc_armour_armour_of_glimril_scales", "wh_pro01_dwf_grombrindal_amour_of_glimril_scales_stage_1", 8,"wh_pro01_dwf_grombrindal_amour_of_glimril_scales_stage_3a_b_mpc"},
		{"mission", "wh_pro01_anc_weapon_the_rune_axe_of_grombrindal", "wh_pro01_dwf_grombrindal_rune_axe_of_grombrindal_stage_1", 13,"wh_pro01_dwf_grombrindal_rune_axe_of_grombrindal_stage_3.1_mpc"},
		{"mission", "wh_pro01_anc_talisman_cloak_of_valaya", "wh_pro01_dwf_grombrindal_rune_cloak_of_valaya_stage_1", 18,"wh_pro01_dwf_grombrindal_rune_cloak_of_valaya_stage_5.1_mpc"},
		{"mission", "wh_pro01_anc_enchanted_item_rune_helm_of_zhufbar", "wh_pro01_dwf_grombrindal_rune_helm_of_zhufbar_stage_1", 23,"wh_pro01_dwf_grombrindal_rune_helm_of_zhufbar_stage_4.1_mpc"}
	};
	
	local grimgor_ironhide_quests = {
		{"mission", "wh_main_anc_weapon_gitsnik", "wh_main_grn_grimgor_ironhide_gitsnik_stage_1", 8,"wh_main_grn_grimgor_ironhide_gitsnik_stage_4a_mpc"},
		{"mission", "wh_main_anc_armour_blood-forged_armour", "wh_main_grn_grimgor_ironhide_blood_forged_armour_stage_1.1", 13,"wh_main_grn_grimgor_ironhide_blood_forged_armour_stage_4a_mpc"}
	};
	
	local azhag_the_slaughterer_quests = {
		{"mission", "wh_main_anc_enchanted_item_the_crown_of_sorcery", "wh_main_grn_azhag_the_slaughterer_crown_of_sorcery_stage_1", 8,"wh_main_grn_azhag_the_slaughterer_crown_of_sorcery_stage_3a_mpc"},
		{"dilemma", "wh_main_anc_armour_azhags_ard_armour", "wh_main_azhag_the_slaughterer_azhags_ard_armour_stage_1", 13,"wh_main_grn_azhag_the_slaughterer_azhags_ard_armour_stage_4a_mpc"},
		{"mission", "wh_main_anc_weapon_slaggas_slashas", "wh_main_grn_azhag_the_slaughterer_slaggas_slashas_stage_1", 18,"wh_main_grn_azhag_the_slaughterer_slaggas_slashas_stage_4a_mpc"}
	};
	
	local grom_the_paunch_quests ={
		{"mission", "wh2_dlc15_anc_weapon_axe_of_grom", "wh2_dlc15_main_grn_grom_axe_of_grom_stage_1", 5,"wh2_dlc15_main_grn_grom_axe_of_grom_stage_4_mpc"},
		{"mission", "wh2_dlc15_anc_enchanted_item_lucky_banner", "wh2_dlc15_main_grn_grom_lucky_banner_stage_1", 2}
	};

	add_to_alt_quests("wh2_dlc15_anc_enchanted_item_lucky_banner", "wh2_dlc15_main_grn_grom_lucky_banner_stage_1", grom_the_paunch_subtype);

	local mannfred_von_carstein_quests = {
		{"mission", "wh_main_anc_weapon_sword_of_unholy_power", "wh_main_vmp_mannfred_von_carstein_sword_of_unholy_power_stage_1", 8,"wh_main_vmp_mannfred_von_carstein_sword_of_unholy_power_stage_3_mpc"},
		{"mission", "wh_main_anc_armour_armour_of_templehof", "wh_main_vmp_mannfred_von_carstein_armour_of_templehof_stage_1", 13,"wh_main_vmp_mannfred_von_carstein_armour_of_templehof_stage_4_mpc"}
	};
	
	local heinrich_kemmler_quests = {
		{"mission", "wh_main_anc_weapon_chaos_tomb_blade", "wh_main_vmp_heinrich_kemmler_chaos_tomb_blade_stage_1", 8,"wh_main_vmp_heinrich_kemmler_chaos_tomb_blade_stage_4a_mpc"},
		{"mission", "wh_main_anc_enchanted_item_cloak_of_mists_and_shadows", "wh_main_vmp_heinrich_kemmler_cloak_of_mists_stage_1", 13,"wh_main_vmp_heinrich_kemmler_cloak_of_mists_stage_2a_mpc"},
		{"mission", "wh_main_anc_arcane_item_skull_staff", "wh_main_vmp_heinrich_kemmler_skull_staff_stage_1.1", 18,"wh_main_vmp_heinrich_kemmler_skull_staff_stage_3a_mpc"}
	};
	
	local vlad_von_carstein_quests = {
		{"mission", "wh_dlc04_anc_weapon_blood_drinker", "wh_dlc04_vmp_vlad_von_carstein_blood_drinker_stage_1", 8,"wh_dlc04_vmp_vlad_von_carstein_blood_drinker_stage_3_mpc"},
		{"mission", "wh_dlc04_anc_talisman_the_carstein_ring", "wh_dlc04_vmp_vlad_von_carstein_the_carstein_ring_stage_1", 13,"wh_dlc04_vmp_vlad_von_carstein_the_carstein_ring_stage_4_mpc"}
	};
	
	local helman_ghorst_quests = {
		{"mission", "wh_dlc04_anc_arcane_item_the_liber_noctus", "wh_dlc04_vmp_helman_ghorst_liber_noctus_stage_1", 8,"wh_dlc04_vmp_helman_ghorst_liber_noctus_stage_5_mpc"}
	};
	
	local archaon_the_everchosen_quests = {
		{"mission", "wh_main_anc_weapon_the_slayer_of_kings", "wh_dlc01_chs_archaon_slayer_of_kings_stage_1", 8,"wh_dlc01_chs_archaon_slayer_of_kings_stage_3a_mpc"},
		{"mission", "wh_main_anc_armour_the_armour_of_morkar", "wh_dlc01_chs_archaon_armour_of_morkar_stage_1", 13,"wh_dlc01_chs_archaon_armour_of_morkar_stage_3a_mpc"},
		{"mission", "wh_main_anc_talisman_the_eye_of_sheerian", "wh_dlc01_chs_archaon_eye_of_sheerian_stage_1", 18,"wh_dlc01_chs_archaon_eye_of_sheerian_stage_2_mpc"},
		{"mission", "wh_main_anc_enchanted_item_the_crown_of_domination", "wh_dlc01_chs_archaon_crown_of_domination_stage_1", 23,"wh_dlc01_chs_archaon_crown_of_domination_stage_2a_mpc"}
	};
	
	local prince_sigvald_quests = {
		{"mission", "wh_main_anc_weapon_sliverslash", "wh_dlc01_chs_prince_sigvald_sliverslash_stage_1", 8,"wh_dlc01_chs_prince_sigvald_sliverslash_stage_4a_mpc"},
		{"mission", "wh_main_anc_armour_auric_armour", "wh_dlc01_chs_prince_sigvald_auric_armour_stage_1", 13,"wh_dlc01_chs_prince_sigvald_auric_armour_stage_3a_mpc"}
	};
	
	local kholek_suneater_quests = {
		{"mission", "wh_main_anc_weapon_starcrusher", "wh_dlc01_chs_kholek_suneater_starcrusher_stage_1", 8,"wh_dlc01_chs_kholek_suneater_starcrusher_stage_2_mpc"}
	};
	
	local khazrak_quests = {
		{"mission", "wh_dlc03_anc_weapon_scourge", "wh_dlc03_bst_khazrak_one_eye_scourge_stage_1_grandcampaign", 8,"wh_dlc03_bst_khazrak_one_eye_scourge_stage_4a_grandcampaign_mpc"},
		{"mission", "wh_dlc03_anc_armour_the_dark_mail", "wh_dlc03_bst_khazrak_one_eye_the_dark_mail_stage_1_grandcampaign", 13,"wh_dlc03_bst_khazrak_one_eye_the_dark_mail_stage_4_grandcampaign_mpc"}
	};
	
	local malagor_quests = {
		{"mission", "wh_dlc03_anc_talisman_icon_of_vilification", "wh_dlc03_bst_malagor_the_dark_omen_the_icons_of_vilification_stage_1_grandcampaign", 8,"wh_dlc03_bst_malagor_the_dark_omen_the_icons_of_vilification_stage_6a_grandcampaign_mpc"}
	};
	
	local morghur_quests = {
		{"mission", "wh_main_anc_weapon_stave_of_ruinous_corruption", "wh_dlc05_qb_bst_morghur_stave_of_ruinous_corruption_stage_1", 8,"wh_dlc05_qb_bst_morghur_stave_of_ruinous_corruption_stage_4a_mpc"}
	};
	
	local belegar_quests = {
		{"mission", "wh_dlc06_anc_armour_shield_of_defiance", "wh_dlc06_dwf_belegar_ironhammer_shield_of_defiance_stage_1", 8,"wh_dlc06_dwf_belegar_ironhammer_shield_of_defiance_stage_2a_mpc"},
		{"mission", "wh_dlc06_anc_weapon_the_hammer_of_angrund", "wh_dlc06_dwf_belegar_ironhammer_hammer_of_angrund_stage_1", 13,"wh_dlc06_dwf_belegar_ironhammer_hammer_of_angrund_stage_3a_mpc"}
	};
	
	local skarsnik_quests = {
		{"mission", "wh_dlc06_anc_weapon_skarsniks_prodder", "wh_dlc06_grn_skarsnik_skarsniks_prodder_stage_1", 8,"wh_dlc06_grn_skarsnik_skarsniks_prodder_stage_4a_mpc"}
	};
	
	local wurrzag_quests = {
		{"mission", "wh_dlc06_anc_enchanted_item_baleful_mask", "wh_dlc06_grn_wurrzag_da_great_green_prophet_baleful_mask_stage_1", 8,"wh_dlc06_grn_wurrzag_da_great_green_prophet_baleful_mask_stage_4a_mpc"},
		{"mission", "wh_dlc06_anc_arcane_item_squiggly_beast", "wh_dlc06_grn_wurrzag_da_great_green_prophet_squiggly_beast_stage_1", 13,"wh_dlc06_grn_wurrzag_da_great_green_prophet_squiggly_beast_stage_3a_mpc"},
		{"mission", "wh_dlc06_anc_weapon_bonewood_staff", "wh_dlc06_grn_wurrzag_da_great_green_prophet_bonewood_staff_stage_1", 18,"wh_dlc06_grn_wurrzag_da_great_green_prophet_bonewood_staff_stage_3_mpc"}
	};
	
	local orion_quests = {
		{"mission", "wh_dlc05_anc_enchanted_item_horn_of_the_wild_hunt", "wh_dlc05_wef_orion_horn_of_the_wild_stage_1", 8,"wh_dlc05_wef_orion_horn_of_the_wild_stage_3a_mpc"},
		{"mission", "wh_dlc05_anc_talisman_cloak_of_isha", "wh_dlc05_wef_orion_cloak_of_isha_stage_1", 13,"wh_dlc05_wef_orion_cloak_of_isha_stage_3a_mpc"},
		{"mission", "wh_dlc05_anc_weapon_spear_of_kurnous", "wh_dlc05_wef_orion_spear_of_kurnous_stage_1", 18,"wh_dlc05_wef_orion_spear_of_kurnous_stage_3a_mpc"}
	};
	
	local durthu_quests = {
		{"mission", "wh_dlc05_anc_weapon_daiths_sword", "wh_dlc05_wef_durthu_sword_of_daith_stage_1", 8,"wh_dlc05_wef_durthu_sword_of_daith_stage_4a_mpc"}
	};
	
	local fay_enchantress_quests = {
		{"mission", "wh_dlc07_anc_arcane_item_the_chalice_of_potions", "wh_dlc07_qb_brt_fay_enchantress_chalice_of_potions_stage_1", 9, "wh_dlc07_qb_brt_fay_enchantress_chalice_of_potions_stage_6_mpc"},
		{"mission", "wh2_dlc12_anc_arcane_item_brt_morgianas_mirror", "wh2_dlc12_brt_fay_morgianas_mirror", 6}
	};
	--add_to_alt_quests(ancillary_key, final_mission_key, character_subtype)
	add_to_alt_quests("wh2_dlc12_anc_arcane_item_brt_morgianas_mirror", "wh2_dlc12_brt_fay_morgianas_mirror", "dlc07_brt_fay_enchantress");
	
	local alberic_quests = {
		{"incident", "wh_dlc07_anc_weapon_trident_of_manann", "wh_dlc07_qb_brt_alberic_trident_of_bordeleaux_stage_1", 3, "wh_dlc07_qb_brt_alberic_trident_of_bordeleaux_stage_8_estalian_tomb_mpc"},
		{"mission", "wh2_dlc12_anc_enchanted_item_brt_braid_of_bordeleaux", "wh2_dlc12_brt_alberic_braid_of_bordeleaux", 6}
	};
	--add_to_alt_quests(ancillary_key, final_mission_key, character_subtype)
	add_to_alt_quests("wh2_dlc12_anc_enchanted_item_brt_braid_of_bordeleaux", "wh2_dlc12_brt_alberic_braid_of_bordeleaux", "dlc07_brt_alberic");
	
	local louen_quests = {
		{"incident", "wh_main_anc_weapon_the_sword_of_couronne", "wh_dlc07_qb_brt_louen_sword_of_couronne_stage_0", 9, "wh_dlc07_qb_brt_louen_sword_of_couronne_stage_4_la_maisontaal_abbey_mpc"},
		{"mission", "wh2_dlc12_anc_armour_brt_armour_of_brilliance", "wh2_dlc12_brt_louen_armour_of_brilliance", 6}
	};
	--add_to_alt_quests(ancillary_key, final_mission_key, character_subtype)
	add_to_alt_quests("wh2_dlc12_anc_armour_brt_armour_of_brilliance", "wh2_dlc12_brt_louen_armour_of_brilliance", "brt_louen_leoncouer");

	local repanse_quests = {
		{"mission", "wh2_dlc14_anc_weapon_sword_of_lyonesse", "wh2_dlc14_main_brt_repanse_sword_of_lyonesse_stage_1", 5, "wh2_dlc14_main_brt_repanse_sword_of_lyonesse_stage_4_mpc"}
	};
	
	local isabella_quests = {
		{"mission", "wh_pro02_anc_enchanted_item_blood_chalice_of_bathori", "wh_pro02_qb_vmp_isabella_von_carstein_blood_chalice_of_bathori_stage_1", 9, "wh_pro02_qb_vmp_isabella_von_carstein_blood_chalice_of_bathori_stage_8_mpc"}
	};
	
	local tyrion_quests = {
		{"mission", "wh2_main_anc_weapon_sunfang", "wh2_main_hef_tyrion_sunfang_stage_1", 10, "wh2_main_hef_tyrion_sunfang_stage_4_mpc"},
		{"mission", "wh2_main_anc_armour_dragon_armour_of_aenarion", "wh2_main_hef_tyrion_dragon_armour_of_aenarion_stage_1", 6, "wh2_main_hef_tyrion_dragon_armour_of_aenarion_stage_4_mpc"},
		{"mission", "wh2_main_anc_enchanted_item_heart_of_avelorn", "wh2_dlc14_hef_me_anc_enchanted_item_heart_of_avelorn", 2}
	};
	--add_to_alt_quests(ancillary_key, final_mission_key, character_subtype)
	add_to_alt_quests("wh2_main_anc_enchanted_item_heart_of_avelorn", "wh2_dlc14_hef_me_anc_enchanted_item_heart_of_avelorn", "wh2_main_hef_tyrion");
	
	
	local teclis_quests = {
		{"mission", "wh2_main_anc_weapon_sword_of_teclis", "wh2_main_hef_teclis_sword_of_teclis_stage_1", 10, "wh2_main_hef_teclis_sword_of_teclis_stage_3_mpc"},
		{"mission", "wh2_main_anc_arcane_item_war_crown_of_saphery", "wh2_main_hef_teclis_war_crown_of_saphery_stage_1", 6, "wh2_main_hef_teclis_war_crown_of_saphery_stage_3_mpc"},
		{"mission", "wh2_main_anc_arcane_item_scroll_of_hoeth", "wh2_main_vortex_narrative_hef_the_lies_of_the_druchii", 2},
		{"mission", "wh2_main_anc_arcane_item_moon_staff_of_lileath", "wh2_main_vortex_narrative_hef_the_vermin_of_hruddithi", 4}
	};
		--add_to_alt_quests(ancillary_key, final_mission_key, character_subtype)
	add_to_alt_quests("wh2_main_anc_arcane_item_scroll_of_hoeth", "wh2_main_vortex_narrative_hef_the_lies_of_the_druchii", "wh2_main_hef_teclis");
	add_to_alt_quests("wh2_main_anc_arcane_item_moon_staff_of_lileath", "wh2_main_vortex_narrative_hef_the_vermin_of_hruddithi", "wh2_main_hef_teclis");
	
	local alarielle_quests = {
		{"mission", "wh2_dlc10_anc_talisman_shieldstone_of_isha", "wh2_dlc10_alarielle_shieldstone_of_isha_1", 2},
		{"mission", "wh2_dlc10_anc_enchanted_item_star_of_avelorn", "wh2_dlc10_hef_alarielle_star_of_avelorn_stage_1", 15, "wh2_dlc10_hef_alarielle_star_of_avelorn_stage_5_mpc"}
	};
	--add_to_alt_quests(ancillary_key, final_mission_key, character_subtype)
	add_to_alt_quests("wh2_dlc10_anc_talisman_shieldstone_of_isha", "wh2_dlc10_alarielle_shieldstone_of_isha_1", "wh2_dlc10_hef_alarielle");
	
	local alith_anar_quests = {
		{"mission", "wh2_dlc10_anc_enchanted_item_the_shadow_crown", "wh2_dlc10_hef_alith_anar_the_shadow_crown", 2},
		{"mission", "wh2_dlc10_anc_weapon_moonbow", "wh2_dlc10_hef_alith_anar_the_moonbow_stage_1", 5, "wh2_dlc10_hef_alith_anar_the_moonbow_stage_4_mpc"}
	};
	--add_to_alt_quests(ancillary_key, final_mission_key, character_subtype)
	add_to_alt_quests("wh2_dlc10_anc_enchanted_item_the_shadow_crown", "wh2_dlc10_hef_alith_anar_the_shadow_crown", "wh2_dlc10_hef_alith_anar");
	
	local eltharion_quests = {
		{"mission","wh2_dlc15_anc_talisman_talisman_of_hoeth","wh2_dlc15_main_hef_eltharion_talisman_of_hoeth_stage_1",5,"wh2_dlc15_main_hef_eltharion_talisman_of_hoeth_stage_3_mpc"},
		{"mission","wh2_dlc15_anc_armour_helm_of_yvresse","wh2_dlc15_vortex_hef_eltharion_helm_of_yvresse_stage_1",7},
		{"mission","wh2_dlc15_anc_weapon_fangsword_of_eltharion","wh2_dlc15_vortex_hef_eltharion_fangsword_of_eltharion_stage_1",10}
	}
	--add_to_alt_quests(ancillary_key, final_mission_key, character_subtype)
	add_to_alt_quests("wh2_dlc15_anc_weapon_fangsword_of_eltharion","wh2_dlc15_vortex_hef_eltharion_fangsword_of_eltharion_stage_1", "wh2_dlc15_hef_eltharion");
	add_to_alt_quests("wh2_dlc15_anc_armour_helm_of_yvresse","wh2_dlc15_vortex_hef_eltharion_helm_of_yvresse_stage_1", "wh2_dlc15_hef_eltharion");
	
	local imrik_quests = {
		{"mission","wh2_dlc15_anc_armour_armour_of_caledor","wh2_dlc15_main_hef_imrik_armour_of_caledor_stage_1",5,"wh2_dlc15_main_hef_imrik_armour_of_caledor_stage_3_mpc"}
	}
	
	local malekith_quests = {
		{"mission", "wh2_main_anc_weapon_destroyer", "wh2_main_def_malekith_destroyer_stage_1", 10, "wh2_main_def_malekith_destroyer_stage_3_mpc"},
		{"mission", "wh2_main_anc_arcane_item_circlet_of_iron", "wh2_main_def_malekith_circlet_of_iron_stage_1", 6, "wh2_main_def_malekith_circlet_of_iron_stage_3_mpc"},
		{"mission", "wh2_main_anc_armour_supreme_spellshield", "wh2_main_def_malekith_supreme_spellshield_stage_1", 14, "wh2_main_def_malekith_supreme_spellshield_stage_3_mpc"},
		{"mission", "wh2_main_anc_armour_armour_of_midnight", "wh2_main_vortex_narrative_def_hoteks_levy", 2}
	};
	--add_to_alt_quests(ancillary_key, final_mission_key, character_subtype)
	add_to_alt_quests("wh2_main_anc_armour_armour_of_midnight", "wh2_main_vortex_narrative_def_hoteks_levy", "wh2_main_def_malekith");
	
	local morathi_quests = {
		{"mission", "wh2_main_anc_weapon_heartrender_and_the_darksword", "wh2_main_def_morathi_heartrender_and_the_darksword_stage_1", 6, "wh2_main_def_morathi_heartrender_and_the_darksword_stage_6_mpc"},
		{"mission", "wh2_main_anc_arcane_item_wand_of_the_kharaidon", "wh2_dlc14_def_wand_of_kharaidon", 4},
		{"mission", "wh2_main_anc_talisman_amber_amulet", "wh2_dlc14_def_amber_amulet", 2}
	};
		--add_to_alt_quests(ancillary_key, final_mission_key, character_subtype)
	add_to_alt_quests("wh2_main_anc_arcane_item_wand_of_the_kharaidon", "wh2_dlc14_def_wand_of_kharaidon", "wh2_main_def_morathi");
	add_to_alt_quests("wh2_main_anc_talisman_amber_amulet", "wh2_dlc14_def_amber_amulet", "wh2_main_def_morathi");
	
	local hellebron_quests = {
		{"mission", "wh2_dlc10_anc_weapon_deathsword_and_the_cursed_blade", "wh2_dlc10_def_hellebron_deathsword_and_the_cursed_blade_stage_1", 8, "wh2_dlc10_def_hellebron_deathsword_and_the_cursed_blade_stage_4_mpc"},
		{"mission", "wh2_dlc10_anc_talisman_amulet_of_dark_fire", "wh2_dlc10_def_hellebron_amulet_of_dark_fire_stage_1", 2}
	};
	--add_to_alt_quests(ancillary_key, final_mission_key, character_subtype)
	add_to_alt_quests("wh2_dlc10_anc_talisman_amulet_of_dark_fire", "wh2_dlc10_def_hellebron_amulet_of_dark_fire_stage_1", "wh2_dlc10_def_crone_hellebron");
	
	local malus_quests = {
		{"mission", "wh2_dlc14_anc_weapon_warpsword_of_khaine", "wh2_dlc14_main_def_malus_warpsword_of_khaine_stage_1", 5, "wh2_dlc14_main_def_malus_warpsword_of_khaine_stage_4_mpc"}
	};

	local mazdamundi_quests = {
		{"mission", "wh2_main_anc_weapon_cobra_mace_of_mazdamundi", "wh2_main_lzd_mazdamundi_cobra_mace_of_mazdamundi_stage_1", 10, "wh2_main_lzd_mazdamundi_cobra_mace_of_mazdamundi_stage_3_mpc"},
		{"mission", "wh2_main_anc_magic_standard_sunburst_standard_of_hexoatl", "wh2_main_lzd_mazdamundi_sunburst_standard_of_hexoatl_stage_1", 6, "wh2_main_lzd_mazdamundi_sunburst_standard_of_hexoatl_stage_4_mpc"}
	};
	
	local kroq_gar_quests = {
		{"mission", "wh2_main_anc_enchanted_item_hand_of_gods", "wh2_main_liz_kroq_gar_hand_of_gods_stage_1", 10, "wh2_main_liz_kroq_gar_hand_of_gods_stage_3_mpc"},
		{"mission", "wh2_main_anc_weapon_revered_spear_of_tlanxla", "wh2_main_liz_kroq_gar_revered_spear_of_tlanxla_stage_1", 6, "wh2_main_liz_kroq_gar_revered_spear_of_tlanxla_stage_3_mpc"}
	};
	
	local tehenhauin_quests = {
		{"mission", "wh2_dlc12_anc_enchanted_item_plaque_of_sotek", "wh2_dlc12_lzd_tehenhauin_plaque_of_sotek_stage_1", 8, "wh2_dlc12_lzd_tehenhauin_plaque_of_sotek_mp"}
	};
	
	local tiktaqto_quests = {
		{"mission", "wh2_dlc12_anc_enchanted_item_mask_of_heavens", "wh2_dlc12_lzd_tiktaqto_mask_of_heavens_stage_1", 8,"wh2_dlc12_lzd_tiktaqto_mask_of_heavens_mp"}
	};
	
	local nakai_quests = {
		{"mission", "wh2_dlc13_anc_enchanted_item_golden_tributes", "wh2_dlc13_lzd_nakai_golden_tributes_stage_1", 8,"wh2_dlc13_lzd_nakai_golden_tributes_stage_3"},
		{"mission", "wh2_dlc13_talisman_the_ogham_shard", "wh2_dlc13_lzd_nakai_the_ogham_shard_stage_1", 8,"wh2_dlc13_lzd_nakai_the_ogham_shard_stage_2"}
	};
	
	local gorrok_quests = {
		{"mission", "wh2_dlc13_anc_armour_the_shield_of_aeons", "wh2_dlc13_gorrok_the_shield_of_aeons_stage_1", 8,"wh2_dlc13_gorrok_the_shield_of_aeons_stage_3"},
		{"mission", "wh2_dlc13_anc_weapon_mace_of_ulumak", "wh2_dlc14_lzd_the_mace_of_ulumak", 2}
	};
	--add_to_alt_quests(ancillary_key, final_mission_key, character_subtype)
	add_to_alt_quests("wh2_dlc13_anc_weapon_mace_of_ulumak", "wh2_dlc14_lzd_the_mace_of_ulumak", "wh2_dlc13_lzd_gor_rok");
	
	
	local skrolk_quests = {
		{"mission", "wh2_main_anc_weapon_rod_of_corruption", "wh2_main_skv_skrolk_rod_of_corruption_stage_1", 10, "wh2_main_skv_skrolk_rod_of_corruption_stage_3_mpc"},
		{"mission", "wh2_main_anc_arcane_item_the_liber_bubonicus", "wh2_main_skv_skrolk_liber_bubonicus_stage_1", 6, "wh2_main_skv_skrolk_liber_bubonicus_stage_3_mpc"}
	};	
	
	local queek_headtaker_quests = {
		{"mission", "wh2_main_anc_armour_warp_shard_armour", "wh2_main_skv_queek_headtaker_warp_shard_armour_stage_1", 6, "wh2_main_skv_queek_headtaker_warp_shard_armour_stage_6_mpc"},
		{"mission", "wh2_main_anc_weapon_dwarf_gouger", "wh2_main_skv_queek_headtaker_dwarfgouger_stage_1", 10, "wh2_main_skv_queek_headtaker_dwarfgouger_stage_4_mpc"}
	};
	
	local tretch_craventail_quests = {
		{"mission", "wh2_dlc09_anc_enchanted_item_lucky_skullhelm", "wh2_dlc09_skv_tretch_lucky_skullhelm_stage_1", 8, "wh2_dlc09_skv_tretch_lucky_skullhelm_stage_5_mpc"}
	};
	local ikit_claw_quests = {
		{"mission", "wh2_dlc12_anc_weapon_storm_daemon", "wh2_dlc12_ikit_claw_storm_daemon_stage_1", 8, "wh2_dlc12_ikit_claw_storm_daemon_mp"}
	};

	local snikch_quests = {
		{"mission", "wh2_dlc14_anc_armour_the_cloak_of_shadows", "wh2_dlc14_main_skv_snikch_the_cloak_of_shadows_stage_1", 5, "wh2_dlc14_main_skv_snikch_the_cloak_of_shadows_stage_4_mpc"},
		{"mission", "wh2_dlc14_anc_weapon_whirl_of_weeping_blades", "wh2_dlc14_main_skv_snikch_whirl_of_weeping_blades_stage_1", 3}
	};
	--add_to_alt_quests(ancillary_key, final_mission_key, character_subtype)
	add_to_alt_quests("wh2_dlc14_anc_weapon_whirl_of_weeping_blades", "wh2_dlc14_main_skv_snikch_whirl_of_weeping_blades_stage_1", "wh2_dlc14_skv_snikch"); 
	
	local settra_quests = {
		{"mission", "wh2_dlc09_anc_enchanted_item_the_crown_of_nehekhara", "wh2_dlc09_tmb_settra_the_crown_of_nehekhara_stage_1", 6, "wh2_dlc09_tmb_settra_the_crown_of_nehekhara_stage_5_mpc"},
		{"mission", "wh2_dlc09_anc_weapon_the_blessed_blade_of_ptra", "wh2_dlc09_tmb_settra_the_blessed_blade_of_ptra_stage_1", 13, "wh2_dlc09_tmb_settra_the_blessed_blade_of_ptra_stage_3_mpc"}
	};
	
	local arkhan_quests = {
		{"mission", "wh2_dlc09_anc_weapon_the_tomb_blade_of_arkhan", "wh2_dlc09_tmb_arkhan_the_tomb_blade_of_arkhan_stage_1", 6, "wh2_dlc09_tmb_arkhan_the_tomb_blade_of_arkhan_stage_4_mpc"},
		{"mission", "wh2_dlc09_anc_arcane_item_staff_of_nagash", "wh2_dlc09_tmb_arkhan_the_staff_of_nagash_stage_1", 10, "wh2_dlc09_qb_tmb_arkhan_the_staff_of_nagash_stage_5_mpc"}
	};
	
	local khatep_quests = {
		{"mission", "wh2_dlc09_anc_arcane_item_the_liche_staff", "wh2_dlc09_mortal_empires_tmb_khatep_the_liche_staff_1", 6}
	};
	
	local khalida_quests = {
		{"mission", "wh2_dlc09_anc_weapon_the_venom_staff", "wh2_dlc09_mortal_empires_tmb_khalida_venom_staff_stage_1", 12, "wh2_dlc09_mortal_empires_tmb_khalida_venom_staff_stage_3_mpc"}
	};
	
	local wulfrik_quests = {
		{"mission", "wh_dlc08_anc_weapon_sword_of_torgald", "wh_dlc08_qb_nor_wulfrik_the_wanderer_sword_of_torgald_stage_1", 9,"wh_dlc08_qb_nor_wulfrik_the_wanderer_sword_of_torgald_stage_4a"}
	};
	
	local throgg_quests = {
		{"mission", "wh_dlc08_anc_talisman_wintertooth_crown", "wh_dlc08_qb_nor_throgg_wintertooth_crown_stage_1", 9,"wh_dlc08_qb_nor_throgg_wintertooth_crown_stage_5"}
	};
	
	local harkon_quests = {
		{"mission", "wh2_dlc11_anc_enchanted_item_slann_gold", "wh2_dlc11_cst_harkon_quest_for_slann_gold_stage_1", 15, "wh2_dlc11_qb_cst_luthor_harkon_slann_gold_MP"}
	};
	
	local noctilus_quests = {
		{"mission", "wh2_dlc11_anc_enchanted_item_captain_roths_moondial", "wh2_dlc11_cst_noctilus_captain_roths_moondial_stage_1", 15, "wh2_dlc11_qb_cst_noctilus_captain_roths_moondial_MP"}
	};
	
	local aranessa_quests = {
		{"mission", "wh2_dlc11_anc_weapon_krakens_bane", "wh2_dlc11_cst_aranessa_krakens_bane_stage_1", 15, "wh2_dlc11_qb_cst_aranessa_saltspite_krakens_bane_MP"}
	};
	
	local cylostra_quests = {
		{"mission", "wh2_dlc11_anc_arcane_item_the_bordeleaux_flabellum", "wh2_dlc11_cst_cylostra_the_bordeleaux_flabellum_stage_1", 9, "wh2_dlc11_cylostra_the_bordeleaux_flabellum_mp"}
	};
	
	local lokhir_quests = {
		{"mission", "wh2_main_anc_armour_helm_of_the_kraken", "wh2_dlc11_lokhir_helm_of_the_kraken_stage_1", 11, "wh2_dlc11_lokhir_fellheart_helm_of_the_kraken_mp"},
		{"mission", "wh2_dlc11_anc_weapon_red_blades", "wh2_dlc11_def_lokhir_red_blades_stage_1", 2}
	};
	--add_to_alt_quests(ancillary_key, final_mission_key, character_subtype)
	add_to_alt_quests("wh2_dlc11_anc_weapon_red_blades", "wh2_dlc11_def_lokhir_red_blades_stage_1", "wh2_dlc11_def_lokhir");
	
	set_up_rank_up_listener(karl_franz_quests, karl_franz_subtype, nil, karl_franz_faction);
	set_up_rank_up_listener(balthasar_gelt_quests, balthasar_gelt_subtype, nil, balthasar_gelt_faction);
	set_up_rank_up_listener(volkmar_the_grim_quests, volkmar_the_grim_subtype, nil, volkmar_the_grim_faction);
	set_up_rank_up_listener(wulfhart_quests, wulfhart_subtype, nil, wulfhart_faction);

	set_up_rank_up_listener(thorgrim_grudgebearer_quests, thorgrim_grudgebearer_subtype, nil, thorgrim_grudgebearer_faction);
	set_up_rank_up_listener(ungrim_ironfist_quests, ungrim_ironfist_subtype, nil, ungrim_ironfist_faction);
	set_up_rank_up_listener(grombrindal_quests, grombrindal_subtype, nil, grombrindal_faction);

	set_up_rank_up_listener(grimgor_ironhide_quests, grimgor_ironhide_subtype, nil, grimgor_ironhide_faction);
	set_up_rank_up_listener(azhag_the_slaughterer_quests, azhag_the_slaughterer_subtype, nil, azhag_the_slaughterer_faction);
	set_up_rank_up_listener(grom_the_paunch_quests,grom_the_paunch_subtype, nil, grom_the_paunch_faction);

	set_up_rank_up_listener(mannfred_von_carstein_quests, mannfred_von_carstein_subtype, nil, mannfred_von_carstein_faction);
	set_up_rank_up_listener(heinrich_kemmler_quests, heinrich_kemmler_subtype, nil, heinrich_kemmler_faction);
	set_up_rank_up_listener(vlad_von_carstein_quests, vlad_von_carstein_subtype, nil, vlad_von_carstein_faction);
	set_up_rank_up_listener(helman_ghorst_quests, helman_ghorst_subtype, nil, helman_ghorst_faction);
	set_up_rank_up_listener(isabella_quests, isabella_subtype, nil, isabella_faction);

	set_up_rank_up_listener(archaon_the_everchosen_quests, archaon_the_everchosen_subtype, nil, archaon_the_everchosen_faction);
	set_up_rank_up_listener(prince_sigvald_quests, prince_sigvald_subtype, nil, prince_sigvald_faction);
	set_up_rank_up_listener(kholek_suneater_quests, kholek_suneater_subtype, nil, kholek_suneater_faction);
	
	set_up_rank_up_listener(khazrak_quests, khazrak_subtype, nil, khazrak_faction);
	set_up_rank_up_listener(malagor_quests, malagor_subtype, nil, malagor_faction);
	set_up_rank_up_listener(morghur_quests, morghur_subtype, nil, morghur_faction);
	
	set_up_rank_up_listener(belegar_quests, belegar_subtype, nil, belegar_faction);
	set_up_rank_up_listener(skarsnik_quests, skarsnik_subtype, nil, skarsnik_faction);
	set_up_rank_up_listener(wurrzag_quests, wurrzag_subtype, nil, wurrzag_faction);
	
	set_up_rank_up_listener(orion_quests, orion_subtype, nil, orion_faction);
	set_up_rank_up_listener(durthu_quests, durthu_subtype, nil, durthu_faction);

	set_up_rank_up_listener(tyrion_quests, tyrion_subtype, nil, tyrion_faction);
	set_up_rank_up_listener(teclis_quests, teclis_subtype, nil, teclis_faction);
	set_up_rank_up_listener(alarielle_quests, alarielle_subtype, nil, alarielle_faction);
	set_up_rank_up_listener(alith_anar_quests, alith_anar_subtype, nil, alith_anar_faction);
	set_up_rank_up_listener(eltharion_quests, eltharion_subtype, nil, eltharion_faction);
	set_up_rank_up_listener(imrik_quests, imrik_subtype, nil, imrik_faction);
	
	set_up_rank_up_listener(malekith_quests, malekith_subtype, nil, malekith_faction);
	set_up_rank_up_listener(morathi_quests, morathi_subtype, nil, morathi_faction);
	set_up_rank_up_listener(hellebron_quests, hellebron_subtype, nil, hellebron_faction);
	set_up_rank_up_listener(malus_quests, malus_subtype, nil, malus_faction);
	
	set_up_rank_up_listener(mazdamundi_quests, mazdamundi_subtype, nil, mazdamundi_faction);
	set_up_rank_up_listener(kroq_gar_quests, kroq_gar_subtype, nil, kroq_gar_faction);
	set_up_rank_up_listener(tehenhauin_quests, tehenhauin_subtype, infotext, tehenhauin_faction);
	set_up_rank_up_listener(tiktaqto_quests, tiktaqto_subtype, infotext, tiktaqto_faction);
	set_up_rank_up_listener(nakai_quests, nakai_subtype, infotext, nakai_faction);
	set_up_rank_up_listener(gorrok_quests, gorrok_subtype, infotext, gorrok_faction);
	
	set_up_rank_up_listener(skrolk_quests, skrolk_subtype, nil, skrolk_faction);
	set_up_rank_up_listener(queek_headtaker_quests, queek_headtaker_subtype, nil, queek_headtaker_faction);
	set_up_rank_up_listener(tretch_craventail_quests, tretch_craventail_subtype, nil, tretch_craventail_faction);
	set_up_rank_up_listener(ikit_claw_quests, ikit_claw_subtype, nil, ikit_claw_faction);
	set_up_rank_up_listener(snikch_quests, snikch_subtype, nil, snikch_faction);
	
	set_up_rank_up_listener(alberic_quests, alberic_subtype, nil, alberic_faction);
	set_up_rank_up_listener(louen_quests, louen_subtype, nil, louen_faction);
	set_up_rank_up_listener(fay_enchantress_quests, fay_enchantress_subtype, nil, fay_enchantress_faction);
	set_up_rank_up_listener(repanse_quests, repanse_subtype, nil, repanse_faction);
	
	set_up_rank_up_listener(settra_quests, settra_subtype, nil, settra_faction);
	set_up_rank_up_listener(arkhan_quests, arkhan_subtype, nil, arkhan_faction);
	set_up_rank_up_listener(khatep_quests, khatep_subtype, nil, khatep_faction);
	set_up_rank_up_listener(khalida_quests, khalida_subtype, nil, khalida_faction);
	
	set_up_rank_up_listener(wulfrik_quests, wulfrik_subtype, nil, wulfhart_faction);
	set_up_rank_up_listener(throgg_quests, throgg_subtype, nil, throgg_faction);
	
	set_up_rank_up_listener(harkon_quests, harkon_subtype, nil, harkon_faction);
	set_up_rank_up_listener(noctilus_quests, noctilus_subtype, nil, noctilus_faction);
	set_up_rank_up_listener(aranessa_quests, aranessa_subtype, nil, aranessa_faction);
	set_up_rank_up_listener(cylostra_quests, cylostra_subtype, nil, cylostra_faction);
	set_up_rank_up_listener(lokhir_quests, lokhir_subtype, nil, lokhir_faction);
	
	-- some quest chains are a bit more complex and require backup missions if the first mission fails to trigger
	set_up_backup_mission("wh_main_emp_karl_franz_reikland_runefang_stage_1", "wh_main_emp_karl_franz_reikland_runefang_stage_1.1", karl_franz_subtype);
	
	set_up_backup_mission("wh_main_dwf_thorgrim_grudgebearer_armour_of_skaldour_stage_2.1", "wh_main_dwf_thorgrim_grudgebearer_armour_of_skaldour_stage_2.2", thorgrim_grudgebearer_subtype);
	set_up_backup_mission("wh_main_dwf_thorgrim_grudgebearer_dragon_crown_of_karaz_stage_2.1", "wh_main_dwf_thorgrim_grudgebearer_dragon_crown_of_karaz_stage_2.2", thorgrim_grudgebearer_subtype);
	
	set_up_backup_mission("wh_main_grn_azhag_the_slaughterer_slaggas_slashas_stage_1", "wh_main_grn_azhag_the_slaughterer_slaggas_slashas_stage_2a", azhag_the_slaughterer_subtype);
	set_up_backup_mission("wh_dlc06_grn_wurrzag_da_great_green_prophet_squiggly_beast_stage_3", "wh_dlc06_grn_wurrzag_da_great_green_prophet_squiggly_beast_stage_3.1", wurrzag_subtype);
	
	set_up_backup_mission("wh_dlc04_vmp_vlad_von_carstein_blood_drinker_stage_1", "wh_dlc04_vmp_vlad_von_carstein_blood_drinker_stage_2", vlad_von_carstein_subtype);
	set_up_backup_mission("wh_dlc04_vmp_vlad_von_carstein_blood_drinker_stage_2", "wh_dlc04_vmp_vlad_von_carstein_blood_drinker_stage_2_2", vlad_von_carstein_subtype);
	
	set_up_backup_mission("wh_pro01_dwf_grombrindal_rune_axe_of_grombrindal_stage_2", "wh_pro01_dwf_grombrindal_rune_axe_of_grombrindal_stage_2a", grombrindal_subtype);
	
	
	
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