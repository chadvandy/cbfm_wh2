

-------------------------------------------------------
-------------------------------------------------------
--	Export Helpers
--	Add functions here that replace massive conditional
--	tests that would otherwise be added to the db
-------------------------------------------------------
-------------------------------------------------------

ancillary_list = {
	["armour"] = {
		["common"] = {
			"wh_dlc03_anc_armour_blackened_plate",
			"wh_dlc03_anc_armour_ramhorn_helm",
			"wh_dlc05_anc_armour_the_helm_of_the_hunt",
			"wh_dlc07_anc_armour_cuirass_of_fortune",
			"wh_main_anc_armour_charmed_shield",
			"wh_main_anc_armour_dragonhelm",
			"wh_main_anc_armour_enchanted_shield",
			"wh_main_anc_armour_gamblers_armour",
			"wh_main_anc_armour_glittering_scales",
			"wh_main_anc_armour_shield_of_ptolos",
			"wh_main_anc_armour_spellshield",
			"wh2_main_anc_armour_armour_of_darkness",
			"wh2_main_anc_armour_cloak_of_hag_graef",
			"wh2_main_anc_armour_dragonscale_shield",
			"wh2_main_anc_armour_helm_of_fortune",
			"wh2_main_anc_armour_shadow_armour",
			"wh2_main_anc_armour_shield_of_distraction",
			"wh2_main_anc_armour_shield_of_the_merwyrm",
			"wh2_main_anc_armour_the_bane_shield",
			"wh2_main_anc_armour_worlds_edge_armour"
		},

		["uncommon"] = {
			"wh_dlc03_anc_armour_pelt_of_the_shadowgave",
			"wh_dlc07_anc_armour_armour_of_the_midsummer_sun",
			"wh_main_anc_armour_armour_of_fortune",
			"wh_main_anc_armour_armour_of_silvered_steel",
			"wh_main_anc_armour_helm_of_discord",
			"wh_main_anc_armour_helm_of_many_eyes",
			"wh_main_anc_armour_nightshroud",
			"wh_dlc08_anc_armour_helm_of_reavers",
			"wh2_main_anc_armour_armour_of_the_stars",
			"wh2_main_anc_armour_sacred_stegadon_helm_of_itza",
			"wh2_main_anc_armour_shield_of_ghrond",
			"wh2_main_anc_armour_shield_of_the_mirrored_pool",
			"wh2_main_anc_armour_the_maiming_shield",
			"wh2_main_anc_armour_warpstone_armour",
			"wh2_dlc11_anc_armour_seadragon_buckler"
		},

		["rare"] = {
			"wh_dlc03_anc_armour_trollhide",
			"wh_dlc07_anc_armour_gilded_cuirass",
			"wh_dlc07_anc_armour_the_grail_shield",
			"wh_main_anc_armour_armour_of_destiny",
			"wh_main_anc_armour_armour_of_gork",
			"wh_main_anc_armour_magnificent_armour_of_borek_beetlebrow",
			"wh_main_anc_armour_the_armour_of_meteoric_iron",
			"wh_main_anc_armour_tricksters_helm",
			"wh_dlc08_anc_armour_blood_stained_armour_of_morkar",
			"wh_dlc08_anc_armour_huskarl_plates",
			"wh_dlc08_anc_armour_mammoth_hide_cape",
			"wh2_main_anc_armour_armour_of_caledor",
			"wh2_main_anc_armour_armour_of_eternal_servitude",
			"wh2_main_anc_armour_armour_of_living_death",
			"wh2_main_anc_armour_hide_of_the_cold_ones",
			"wh2_dlc11_anc_armour_the_gunnarsson_kron",
			"wh2_dlc11_anc_armour_armour_of_the_depth"
		},
	},
		
	["enchanted_item"] = {
		["common"] = {
			"wh_dlc07_anc_enchanted_item_sacrament_of_the_lady",
			"wh_main_anc_enchanted_item_featherfoe_torc",
			"wh_main_anc_enchanted_item_ironcurse_icon",
			"wh_main_anc_enchanted_item_potion_of_foolhardiness",
			"wh_main_anc_enchanted_item_potion_of_speed",
			"wh_main_anc_enchanted_item_potion_of_strength",
			"wh_main_anc_enchanted_item_potion_of_toughness",
			"wh_main_anc_enchanted_item_ruby_ring_of_ruin",
			"wh_main_anc_enchanted_item_silver_horn_of_vengeance",
			"wh_main_anc_enchanted_item_the_terrifying_mask_of_eee",
			"wh2_main_anc_enchanted_item_blood_statuette_of_spite",
			"wh2_main_anc_enchanted_item_carnosaur_pendant",
			"wh2_main_anc_enchanted_item_curse_charm_of_tepok",
			"wh2_main_anc_enchanted_item_dragonfly_of_quicksilver",
			"wh2_main_anc_enchanted_item_dragonhorn",
			"wh2_main_anc_enchanted_item_pipes_of_piebald",
			"wh2_main_anc_enchanted_item_portents_of_verminous_doom",
			"wh2_main_anc_enchanted_item_radiant_gem_of_hoeth",
			"wh2_main_anc_enchanted_item_talisman_of_loec",
			"wh2_main_anc_enchanted_item_the_guiding_eye",
			"wh2_main_anc_enchanted_item_venom_of_the_firefly_frog",
			"wh2_main_anc_enchanted_item_whip_of_agony"
		},
		
		["uncommon"] = {
			"wh_dlc05_anc_enchanted_item_hail_of_doom_arrow",
			"wh_dlc07_anc_enchanted_item_holy_icon",
			"wh_main_anc_enchanted_item_crown_of_command",
			"wh_main_anc_enchanted_item_fiery_ring_of_thori",
			"wh_main_anc_enchanted_item_healing_potion",
			"wh_main_anc_enchanted_item_pendant_of_slaanesh",
			"wh_main_anc_enchanted_item_rod_of_flaming_death",
			"wh_main_anc_enchanted_item_van_horstmanns_speculum",
			"wh_dlc08_anc_enchanted_item_manticore_horn",
			"wh2_main_anc_enchanted_item_cloak_of_beards",
			"wh2_main_anc_enchanted_item_divine_plaque_of_protection",
			"wh2_main_anc_enchanted_item_folariaths_robe",
			"wh2_main_anc_enchanted_item_khaines_ring_of_fury",
			"wh2_main_anc_enchanted_item_skalm",
			"wh2_main_anc_enchanted_item_the_book_of_the_phoenix",
			"wh2_main_anc_enchanted_item_the_cloak_of_feathers",
			"wh2_main_anc_enchanted_item_the_horn_of_kygor",
			"wh2_main_anc_enchanted_item_war_drum_of_xahutec",
			"wh2_dlc09_anc_enchanted_item_cloak_of_the_dunes",
			"wh2_dlc09_anc_enchanted_item_golden_deathmask_of_kharnut",
			"wh2_dlc11_anc_enchanted_item_moonshine",
			"wh2_dlc11_anc_enchanted_item_pyrotechnic_compound"
		},
			
		["rare"] = {
			"wh_dlc03_anc_enchanted_item_horn_of_the_first_beast",
			"wh_dlc03_anc_enchanted_item_shard_of_the_herdstone",
			"wh_dlc07_anc_enchanted_item_mane_of_the_purebreed",
			"wh_main_anc_enchanted_item_chalice_of_chaos",
			"wh_main_anc_enchanted_item_skull_wand_of_kaloth",
			"wh_main_anc_enchanted_item_the_other_tricksters_shard",
			"wh_dlc08_anc_enchanted_item_frost_wyrm_scale",
			"wh_dlc08_anc_enchanted_item_vial_of_troll_blood",
			"wh2_main_anc_enchanted_item_black_dragon_egg",
			"wh2_main_anc_enchanted_item_cloak_of_twilight",
			"wh2_main_anc_enchanted_item_moranions_wayshard",
			"wh2_main_anc_enchanted_item_ring_of_corin",
			"wh2_main_anc_enchanted_item_rubric_of_dark_dimensions",
			"wh2_main_anc_enchanted_item_skavenbrew",
			"wh2_dlc11_anc_enchanted_item_black_buckthorns_treasure_map"
		},
	},
	
	["banner"] = {
		["common"] = {
			"wh_dlc03_anc_magic_standard_banner_of_outrage",
			"wh_dlc03_anc_mark_of_chaos_gnarled_hide",
			"wh_dlc03_anc_mark_of_chaos_gouge_tusks",
			"wh_dlc03_anc_mark_of_chaos_many_limbed_fiend",
			"wh_dlc03_anc_mark_of_chaos_shadow_hide",
			"wh_dlc03_anc_mark_of_chaos_uncanny_senses",
			"wh_dlc07_anc_magic_standard_errantry_banner",
			"wh_dlc07_anc_magic_standard_twilight_banner",
			"wh_main_anc_magic_standard_banner_of_eternal_flame",
			"wh_main_anc_magic_standard_banner_of_rage",
			"wh_main_anc_magic_standard_banner_of_swiftness",
			"wh_main_anc_magic_standard_blasted_standard",
			"wh_main_anc_magic_standard_gleaming_pennant",
			"wh_main_anc_magic_standard_griffon_banner",
			"wh_main_anc_magic_standard_lichbone_pennant",
			"wh_main_anc_magic_standard_scarecrow_banner",
			"wh_main_anc_magic_standard_standard_of_discipline",
			"wh_main_anc_magic_standard_the_screaming_banner",
			"wh_main_anc_mark_of_chaos_mark_of_nurgle",
			"wh_main_anc_mark_of_chaos_mark_of_slaanesh",
			"wh_main_anc_rune_ancestor_rune",
			"wh_main_anc_rune_master_rune_of_courage",
			"wh_dlc08_anc_magic_standard_banner_of_wolfclaw",
			"wh_dlc08_anc_magic_standard_black_iron_reavers",
			"wh_dlc08_anc_magic_standard_crimson_reapers",
			"wh_dlc08_anc_magic_standard_drake_hunters",
			"wh2_main_anc_magic_standard_banner_of_ellyrion",
			"wh2_main_anc_magic_standard_banner_of_the_under_empire",
			"wh2_main_anc_magic_standard_banner_of_verminous_scurrying",
			"wh2_main_anc_magic_standard_dwarf_hide_banner",
			"wh2_main_anc_magic_standard_huanchis_blessed_totem",
			"wh2_main_anc_magic_standard_lion_standard",
			"wh2_main_anc_magic_standard_sea_serpent_standard",
			"wh2_main_anc_magic_standard_the_blood_banner",
			"wh2_dlc11_anc_magic_standard_dead_mans_chest",
			"wh2_dlc11_anc_magic_standard_boatswain",
			"wh2_dlc11_anc_magic_standard_corpse_surgeon",
			"wh2_dlc11_anc_magic_standard_rookie_gunner"
		},
		
		["uncommon"] = {
			"wh_dlc03_anc_mark_of_chaos_slug_skin",
			"wh_main_anc_magic_standard_banner_of_lost_holds",
			"wh_main_anc_magic_standard_razor_standard",
			"wh_main_anc_magic_standard_steel_standard",
			"wh_main_anc_magic_standard_war_banner",
			"wh_main_anc_mark_of_chaos_mark_of_khorne",
			"wh_main_anc_mark_of_chaos_mark_of_tzeentch",
			"wh_main_anc_rune_master_rune_of_groth_one-eye",
			"wh_main_anc_rune_master_rune_of_grungni",
			"wh_main_anc_rune_master_rune_of_sanctuary",
			"wh_main_anc_rune_master_rune_of_stoicism",
			"wh_main_anc_rune_strollaz_rune",
			"wh2_main_anc_magic_standard_banner_of_murder",
			"wh2_main_anc_magic_standard_grand_banner_of_clan_superiority",
			"wh2_main_anc_magic_standard_shroud_of_dripping_death",
			"wh2_main_anc_magic_standard_standard_of_hag_graef",
			"wh2_main_anc_magic_standard_sun_standard_of_chotec",
			"wh2_dlc09_anc_magic_standard_banner_of_the_hidden_dead",
			"wh2_dlc09_anc_magic_standard_standard_of_the_undying_legion",
			"wh2_dlc11_anc_magic_standard_bloodied_banner_of_slayers",
			"wh2_dlc11_anc_magic_standard_burnt_banner_of_knights",
			"wh2_dlc11_anc_magic_standard_holed_banner_of_militia",
			"wh2_dlc11_anc_magic_standard_torn_banner_of_pilgrims"
		},
		
		["rare"] = {
			"wh_dlc03_anc_magic_standard_manbane_standard",
			"wh_dlc03_anc_magic_standard_the_beast_banner",
			"wh_dlc03_anc_magic_standard_totem_of_rust",
			"wh_dlc03_anc_mark_of_chaos_crown_of_horns",
			"wh_dlc05_anc_magic_standard_the_banner_of_the_eternal_queen",
			"wh_dlc05_anc_magic_standard_the_banner_of_the_hunter_king",
			"wh_dlc07_anc_magic_standard_banner_of_defence",
			"wh_dlc07_anc_magic_standard_valorous_standard",
			"wh_main_anc_magic_standard_banner_of_the_barrows",
			"wh_main_anc_magic_standard_morks_war_banner",
			"wh_main_anc_magic_standard_rampagers_standard",
			"wh_main_anc_magic_standard_rangers_standard",
			"wh_main_anc_magic_standard_spider_banner",
			"wh_main_anc_magic_standard_the_bad_moon_banner",
			"wh_main_anc_magic_standard_wailing_banner",
			"wh_main_anc_rune_master_rune_of_battle",
			"wh_main_anc_rune_master_rune_of_slowness",
			"wh_main_anc_rune_master_rune_of_stromni_redbeard",
			"wh_main_anc_rune_master_rune_of_valaya",
			"wh2_main_anc_magic_standard_banner_of_the_world_dragon",
			"wh2_main_anc_magic_standard_battle_banner",
			"wh2_main_anc_magic_standard_dread_banner",
			"wh2_main_anc_magic_standard_horn_of_isha",
			"wh2_main_anc_magic_standard_hydra_banner",
			"wh2_main_anc_magic_standard_sacred_banner_of_the_horned_rat",
			"wh2_main_anc_magic_standard_skavenpelt_banner",
			"wh2_main_anc_magic_standard_storm_banner",
			"wh2_main_anc_magic_standard_the_jaguar_standard",
			"wh2_main_anc_magic_standard_totem_of_prophecy",
			"wh2_dlc11_anc_magic_standard_ships_colors"
		},
	},
	
	["talisman"] = {
		["common"]	= {
			"wh_main_anc_talisman_dragonbane_gem",
			"wh_main_anc_talisman_luckstone",
			"wh_main_anc_talisman_pidgeon_plucker_pendant",
			"wh2_main_anc_enchanted_item_talisman_of_loec",
			"wh_main_anc_talisman_seed_of_rebirth",
			"wh2_main_anc_talisman_rival_hide_talisman",
			"wh_main_anc_talisman_obsidian_trinket",
			"wh_main_anc_talisman_opal_amulet",
			"wh_main_anc_talisman_talisman_of_protection",
			"wh2_main_anc_talisman_amulet_of_fire",
			"wh_dlc07_anc_talisman_dragons_claw",
			"wh2_main_anc_talisman_pearl_of_infinite_blackness",
			"wh_main_anc_talisman_dawnstone"
		},
		
		["uncommon"] = {
			"wh_dlc03_anc_talisman_chalice_of_dark_rain",
			"wh_dlc07_anc_talisman_siriennes_locket",
			"wh_main_anc_talisman_obsidian_amulet",
			"wh_main_anc_talisman_obsidian_lodestone",
			"wh_main_anc_talisman_talisman_of_endurance",
			"wh_dlc08_anc_talisman_lootbag_of_marauders",
			"wh_dlc08_anc_talisman_slave_chain",
			"wh_dlc08_anc_talisman_wolf_teeth_amulet",
			"wh2_main_anc_talisman_amulet_of_itzl",
			"wh2_main_anc_talisman_aura_of_quetzl",
			"wh2_main_anc_talisman_crown_of_black_iron",
			"wh2_main_anc_talisman_foul_pendant",
			"wh2_main_anc_talisman_glyph_necklace",
			"wh2_main_anc_talisman_golden_crown_of_atrazar",
			"wh2_main_anc_talisman_loremasters_cloak",
			"wh2_main_anc_talisman_ring_of_darkness",
			"wh2_main_anc_talisman_sacred_incense",
			"wh2_main_anc_talisman_shadow_magnet_trinket",
			"wh2_main_anc_talisman_talisman_of_saphery",
			"wh2_dlc11_anc_talisman_blackpearl_eye",
			"wh2_dlc11_anc_talisman_jellyfish_in_a_jar"
		},
		
		["rare"] = {
			"wh_main_anc_talisman_talisman_of_preservation",
			"wh_main_anc_talisman_the_white_cloak_of_ulric",
			"wh_dlc08_anc_talisman_headband_of_berserker",
			"wh2_main_anc_talisman_deathmask",
			"wh2_main_anc_talisman_ring_of_hotek",
			"wh2_main_anc_talisman_the_black_amulet",
			"wh2_main_anc_talisman_vambraces_of_defence",
			"wh2_dlc11_anc_talisman_kraken_fang"
		},
	},
	
	["weapon"] = {
		["common"] = {
			"wh_dlc03_anc_weapon_everbleed",
			"wh_dlc05_anc_weapon_the_bow_of_loren",
			"wh_dlc07_anc_weapon_sword_of_the_quest",
			"wh_dlc07_anc_weapon_the_wyrmlance",
			"wh_main_anc_weapon_berserker_sword",
			"wh_main_anc_weapon_biting_blade",
			"wh_main_anc_weapon_gold_sigil_sword",
			"wh_main_anc_weapon_relic_sword",
			"wh_main_anc_weapon_shrieking_blade",
			"wh_main_anc_weapon_sword_of_battle",
			"wh_main_anc_weapon_sword_of_might",
			"wh_main_anc_weapon_sword_of_striking",
			"wh_main_anc_weapon_sword_of_swift_slaying",
			"wh_main_anc_weapon_tormentor_sword",
			"wh_main_anc_weapon_warrior_bane",
			"wh2_main_anc_weapon_blade_of_nurglitch",
			"wh2_main_anc_weapon_burning_blade_of_chotec",
			"wh2_main_anc_weapon_dagger_of_sotek",
			"wh2_main_anc_weapon_deathpiercer",
			"wh2_main_anc_weapon_dwarfbane",
			"wh2_main_anc_weapon_foe_bane",
			"wh2_main_anc_weapon_heartseeker",
			"wh2_main_anc_weapon_sword_of_the_hornet",
			"wh2_main_anc_weapon_web_of_shadows"
		},
		
		["uncommon"] = {
			"wh_dlc03_anc_weapon_axes_of_khorgor",
			"wh_dlc03_anc_weapon_hunting_spear",
			"wh_dlc03_anc_weapon_the_brass_cleaver",
			"wh_dlc03_anc_weapon_the_steel_claws",
			"wh_dlc07_anc_weapon_sword_of_the_ladys_champion",
			"wh_main_anc_weapon_fencers_blades",
			"wh_main_anc_weapon_filth_mace",
			"wh_main_anc_weapon_hellfire_sword",
			"wh_main_anc_weapon_ogre_blade",
			"wh_main_anc_weapon_skabscrath",
			"wh_main_anc_weapon_sword_of_anti-heroes",
			"wh_main_anc_weapon_sword_of_strife",
			"wh_main_anc_weapon_the_hammer_of_karak_drazh",
			"wh_dlc08_anc_weapon_fimir_hammer",
			"wh_dlc08_anc_weapon_troll_fang_dagger",
			"wh2_main_anc_weapon_blade_of_corruption",
			"wh2_main_anc_weapon_blade_of_darting_steel",
			"wh2_main_anc_weapon_caledors_bane",
			"wh2_main_anc_weapon_crimson_death",
			"wh2_main_anc_weapon_dagger_of_hotek",
			"wh2_main_anc_weapon_the_star_lance",
			"wh2_main_anc_weapon_the_white_sword",
			"wh2_main_anc_weapon_warlock_augmented_weapon",
			"wh2_main_anc_weapon_weeping_blade"
		},
		
		["rare"] = {
			"wh_dlc03_anc_weapon_axe_of_men",
			"wh_dlc03_anc_weapon_mangelder",
			"wh_dlc03_anc_weapon_primeval_club",
			"wh_dlc03_anc_weapon_stonecrusher_mace",
			"wh_dlc05_anc_weapon_daiths_reaper",
			"wh_dlc05_anc_weapon_the_spirit_sword",
			"wh_dlc07_anc_weapon_the_silver_lance_of_the_blessed",
			"wh_main_anc_weapon_bashas_axe_of_stunty_smashin",
			"wh_main_anc_weapon_battleaxe_of_the_last_waaagh",
			"wh_main_anc_weapon_giant_blade",
			"wh_main_anc_weapon_obsidian_blade",
			"wh_main_anc_weapon_red_axe_of_karak_eight_peaks",
			"wh_main_anc_weapon_runefang",
			"wh_main_anc_weapon_sword_of_bloodshed",
			"wh_main_anc_weapon_the_mace_of_helsturm",
			"wh_dlc08_anc_weapon_flaming_axe_of_cormac",
			"wh2_main_anc_weapon_blade_of_bel_korhadris",
			"wh2_main_anc_weapon_blade_of_leaping_gold",
			"wh2_main_anc_weapon_blade_of_revered_tzunki",
			"wh2_main_anc_weapon_blade_of_ruin",
			"wh2_main_anc_weapon_bow_of_the_seafarer",
			"wh2_main_anc_weapon_chillblade",
			"wh2_main_anc_weapon_executioners_axe",
			"wh2_main_anc_weapon_hydra_blade",
			"wh2_main_anc_weapon_scimitar_of_the_sun_resplendent",
			"wh2_main_anc_weapon_stegadon_war_spear",
			"wh2_main_anc_weapon_the_blade_of_realities",
			"wh2_main_anc_weapon_the_fellblade",
			"wh2_main_anc_weapon_the_piranha_blade",
			"wh2_main_anc_weapon_venom_sword",
			"wh2_main_anc_weapon_warpforged_blade",
			"wh2_dlc11_anc_weapon_double_barrel",
			"wh2_dlc11_anc_weapon_lucky_levis_hookhand",
			"wh2_dlc11_anc_weapon_masamune"
		},
	},
	
	["arcane_item"] = {
		["common"] = {
			"wh_main_anc_arcane_item_book_of_arkhan",
			"wh_main_anc_arcane_item_channelling_staff",
			"wh_main_anc_arcane_item_earthing_rod",
			"wh_main_anc_arcane_item_power_scroll",
			"wh_main_anc_arcane_item_power_stone",
			"wh_main_anc_arcane_item_sceptre_of_stability",
			"wh_main_anc_arcane_item_scroll_of_shielding",
			"wh_main_anc_arcane_item_skull_of_katam",
			"wh_main_anc_arcane_item_wand_of_jet",
			"wh_dlc03_anc_arcane_item_jagged_dagger",
			"wh_dlc03_anc_arcane_item_hagtree_fetish",
			"wh2_main_anc_arcane_item_scrying_stone",
			"wh2_main_anc_arcane_item_warpstone_tokens",
			"wh2_main_anc_arcane_item_warp_energy_condenser",
			"wh2_main_anc_arcane_item_diadem_of_power",
			"wh2_main_anc_arcane_item_itxi_grubs",
			"wh2_main_anc_arcane_item_plaque_of_dominion",
			"wh2_main_anc_arcane_item_rod_of_the_storm",
			"wh2_main_anc_arcane_item_darkstar_cloak",
			"wh2_main_anc_arcane_item_tome_of_furion",
			"wh2_dlc10_anc_arcane_item_scroll_of_blast",
			"wh2_dlc10_anc_arcane_item_scroll_of_speed_of_lykos",
			"wh2_dlc10_anc_arcane_item_scroll_of_the_amber_trance"
		},
		
		["uncommon"] = {
			"wh_main_anc_arcane_item_forbidden_rod",
			"wh_main_anc_arcane_item_staff_of_damnation",
			"wh_main_anc_arcane_item_tricksters_shard",
			"wh2_main_anc_arcane_item_cube_of_darkness",
			"wh2_main_anc_arcane_item_cupped_hands_of_the_old_ones",
			"wh2_main_anc_arcane_item_the_seerstaff_of_saphery",
			"wh2_main_anc_arcane_item_the_tricksters_pendant",
			"wh2_main_anc_arcane_item_starwood_staff",
			"wh2_dlc10_anc_arcane_item_scroll_of_assault_of_stone",
			"wh2_dlc10_anc_arcane_item_scroll_of_fear_of_aramar"
		},
		
		["rare"] = {
			"wh_main_anc_arcane_item_black_periapt",
			"wh_main_anc_arcane_item_book_of_ashur",
			"wh_main_anc_arcane_item_lucky_shrunken_head",
			"wh_main_anc_arcane_item_scroll_of_leeching",
			"wh_dlc03_anc_arcane_item_staff_of_darkoth",
			"wh_dlc03_anc_arcane_item_skull_of_rarkos",
			"wh2_main_anc_arcane_item_warpstorm_scroll",
			"wh2_main_anc_arcane_item_black_staff",
			"wh2_main_anc_arcane_item_book_of_hoeth",
			"wh2_main_anc_arcane_item_the_vortex_shard",
			"wh2_main_anc_arcane_item_the_gem_of_sunfire",
			"wh2_dlc10_anc_arcane_item_scroll_of_arnizipals_black_horror"
		}
	}
};

function attempt_to_award_random_magical_item(context)
	-- don't award a magical item if it is a quest battle
	local a_char_cqi, a_mf_cqi, a_faction_name = cm:pending_battle_cache_get_attacker(1);
	local d_char_cqi, d_mf_cqi, d_faction_name = cm:pending_battle_cache_get_defender(1);
	
	local attacker = cm:get_faction(a_faction_name);
	local defender = cm:get_faction(d_faction_name);
	
	if (attacker and attacker:is_quest_battle_faction()) or (defender and defender:is_quest_battle_faction()) then
		out.traits("attempt_to_award_random_magical_item() called, but it is a quest battle. Not going to award anything.");
		return;
	end;
	
	local index = 0;
	
	local character = context:character();
	local faction = character:faction();
	
	if faction:subculture() ~= "wh_main_sc_dwf_dwarfs" and (character:is_caster() or general_has_caster_embedded_in_army(character)) then
		index = cm:random_number(7); -- this will weigh slightly towards arcane items when the character is a caster (6 or higher)
	else
		index = cm:random_number(5); -- don't drop arcane items if the character involved is not a caster
	end;
	
	local new_ancillary_list = {};
	
	if index == 1 then
		new_ancillary_list = ancillary_list.armour;
	elseif index == 2 then
		new_ancillary_list = ancillary_list.enchanted_item;
	elseif index == 3 then
		new_ancillary_list = ancillary_list.banner;
	elseif index == 4 then
		new_ancillary_list = ancillary_list.talisman;
	elseif index == 5 then
		new_ancillary_list = ancillary_list.weapon;
	else
		new_ancillary_list = ancillary_list.arcane_item;
	end;
	
	-- get the list of ancillaries based on the rarity
	local rarity_roll = cm:random_number(100);
	
	if rarity_roll > 90 then
		new_ancillary_list = new_ancillary_list.rare;
	elseif rarity_roll > 61 then
		new_ancillary_list = new_ancillary_list.uncommon;
	else
		new_ancillary_list = new_ancillary_list.common;
	end;
	
	local pb = context:pending_battle();
	local model = pb:model();
	local campaign_difficulty = model:difficulty_level();
	local chance = 40;
	local bv_chance = character:post_battle_ancillary_chance();
	
	-- mod the chance based on the bonus value state
	chance = chance + bv_chance;
	
	-- mod the chance based on campaign difficulty (only if singleplayer)
	if model:is_multiplayer() then
		-- in mp, modify as if playing on normal difficulty
		chance = chance + 6;
	elseif faction:is_human() then							-- player
		if campaign_difficulty == 1 then					-- easy
			chance = chance + 8;
		elseif campaign_difficulty == 0 then				-- normal
			chance = chance + 6;
		elseif campaign_difficulty == -1 then				-- hard
			chance = chance + 4;
		elseif campaign_difficulty == -2 then				-- very hard
			chance = chance + 2;
		end;
	else													-- AI
		if campaign_difficulty == 0 then					-- normal
			chance = chance + 2;
		elseif campaign_difficulty == -1 then				-- hard
			chance = chance + 4;
		elseif campaign_difficulty == -2 then				-- very hard
			chance = chance + 6;
		else												-- legendary
			chance = chance + 8;
		end;
	end;
	
	-- mod the chance based on victory type
	if pb:has_attacker() and pb:attacker() == character then
		if pb:attacker_battle_result() == "close_victory" then
			chance = chance + 2;
		elseif pb:attacker_battle_result() == "decisive_victory" then
			chance = chance + 4;
		elseif pb:attacker_battle_result() == "heroic_victory" then
			chance = chance + 6;
		end;
	elseif pb:has_defender() then
		if pb:defender_battle_result() == "close_victory" then
			chance = chance + 2;
		elseif pb:defender_battle_result() == "decisive_victory" then
			chance = chance + 4;
		elseif pb:defender_battle_result() == "heroic_victory" then
			chance = chance + 6;
		end;
	end;
	
	if chance > 100 then
		chance = 100
	end;
	
	-- tomb kings chance is cut in half due to mortuary cult
	if faction:culture() == "wh2_dlc09_tmb_tomb_kings" then
		chance = chance * 0.5;
	end;
	
	local roll = cm:random_number(100);
	
	if core:is_tweaker_set("FORCE_ANCILLARY_DROP_POST_BATTLE") then
		roll = 1;
	end;
	
	out.traits("Rolled a " .. roll .. " to assign an ancillary with a chance of " .. chance .. " for a character belonging to the faction " .. faction:name());
	
	if roll <= chance then
		local can_equip = false;
		local count = 0;
		
		while not can_equip and count < 20 do
			local ancillary_index = cm:random_number(#new_ancillary_list);
			local chosen_ancillary = new_ancillary_list[ancillary_index];
			
			count = count + 1;
			
			-- cbf
			--if character:can_equip_ancillary(chosen_ancillary) then
			if military_force_has_character_that_can_equip_ancillary(character:military_force(), chosen_ancillary) then
				can_equip = true;
				out.traits("Trying to assign the ancillary " .. chosen_ancillary .. " for a character belonging to the faction " .. faction:name());
				effect.ancillary(chosen_ancillary, 100, context);
			end;
		end;
	end;
end;



function wh_main_trig_greenskin_general_lost_battle_against_goblin_great_shaman_test(character, pb)
	return
		cm:char_is_defeated_general(character) and
		character:character_subtype("grn_orc_warboss") and 
		pb:has_attacker() and 
		pb:has_defender() and
		(
			(cm:pending_battle_cache_char_is_attacker(character) and pb:defender():character_subtype("grn_goblin_great_shaman")) or
			(cm:pending_battle_cache_char_is_defender(character) and pb:attacker():character_subtype("grn_goblin_great_shaman"))
		)
end;


function char_can_recruit_unit(character, unit)
	return character:has_military_force() and character:military_force():can_recruit_unit(unit);
end;



function char_has_tech(character, tech)
	return character:faction():has_technology(tech)
end;



function has_poo(region)
	return region:building_exists("wh_main_special_greenskin_vandalisation_1") or region:building_exists("wh_main_special_greenskin_vandalisation_2") or region:building_exists("wh_main_special_greenskin_vandalisation_3") or region:building_exists("wh_main_special_greenskin_vandalisation_4") or region:building_exists("wh_main_special_greenskin_vandalisation_5")
end;



function char_on_sea(character)
	return character:turns_at_sea() > 0;
end;



function char_army_has_unit(character, unit)

	-- allow a table of units to be passed in as a parameter
	if type(unit) == "table" then
		if not character:has_military_force() and not character:is_embedded_in_military_force() then
			return false;
		end;
	
		for i = 1, #unit do
			if char_army_has_unit(character, unit[i]) then
				return true;
			end;
		end;
		return false;
	end;
	
	if character:has_military_force() then
		return character:military_force():unit_list():has_unit(unit);
	elseif character:is_embedded_in_military_force() then
		return character:embedded_in_military_force():unit_list():has_unit(unit);
	end;
end;



function battle_featured_unit(pb, unit)
	return (pb:has_defender() and char_army_has_unit(pb:defender(), unit)) or (pb:has_attacker() and char_army_has_unit(pb:attacker(), unit));
end;



function char_spent_skill_point_on_level2_skill(skill)	
	local level2_skills = {
		"wh_main_skill_all_all_self_blade_master_2",
		"wh_main_skill_all_all_self_blade_shield_2",
		"wh_main_skill_all_all_self_deadly_blade_2",
		"wh_main_skill_all_all_self_hard_to_hit_2",
		"wh_main_skill_all_all_self_scarred_veteran_2",
		"wh_main_skill_all_all_self_thick-skinned_2",
		"wh_main_skill_all_all_self_wound-maker_2",
		"wh_main_skill_all_dignitary_self_inviolable_2",
		"wh_main_skill_all_dignitary_self_tenacity_2",
		"wh_main_skill_all_lord_self_full_plate_armour_2",
		"wh_main_skill_all_spy_self_counter-striker_2",
		"wh_main_skill_all_spy_self_gutter_fighter_2",
		"wh_main_skill_all_spy_self_precise_2",
		"wh_main_skill_emp_spy_self_silver_bullets",
		"wh_main_skill_all_spy_self_survivalist_2",
		"wh_main_skill_grn_lord_self_choppas_2",
		"wh_main_skill_vmp_lord_self_curse_of_the_revenant_2",
		"wh_main_skill_vmp_lord_self_master_strike_2",
		"wh_main_skill_vmp_lord_self_quickblood_2"
	}
	
	for i = 1, #level2_skills do
		local current_skill = level2_skills[i];
		if skill == current_skill then return true end;
	end;
end;



function char_spent_skill_point_on_buff_skill(skill)
	local buff_skills = {
		"wh_main_skill_emp_dignitary_self_benediction",
		"wh_main_skill_emp_dignitary_self_faiths_bastion",
		"wh_main_skill_emp_dignitary_unique_warrior_priest_hammer_of_sigmar",
		"wh_main_skill_emp_dignitary_unique_warrior_priest_righteous_fury",
		"wh_main_skill_emp_dignitary_unique_warrior_priest_shield_of_faith",
		"wh_main_skill_emp_dignitary_unique_warrior_priest_soulfire",
		"wh_main_skill_all_magic_death_01_spirit_leech",
		"wh_main_skill_all_magic_death_02_aspect_of_the_dreadknight",
		"wh_main_skill_all_magic_death_04_soulblight",
		"wh_main_skill_all_magic_death_05_doom_and_darkness",
		"wh_main_skill_all_magic_death_09_the_fate_of_bjuna",
		"wh_main_skill_all_magic_death_10_the_purple_sun_of_xereus",
		"wh_main_skill_all_magic_fire_01_fireball",
		"wh_main_skill_all_magic_fire_02_cascading_fire-cloak",
		"wh_main_skill_all_magic_fire_03_flaming_sword_of_rhuin",
		"wh_main_skill_all_magic_fire_05_the_burning_head",
		"wh_main_skill_all_magic_fire_09_piercing_bolts_of_burning",
		"wh_main_skill_all_magic_fire_10_flame_storm",
		"wh_main_skill_all_magic_heavens_01_harmonic_convergence",
		"wh_main_skill_all_magic_heavens_02_wind_blast",
		"wh_main_skill_all_magic_heavens_04_curse_of_the_midnight_wind",
		"wh_main_skill_all_magic_heavens_05_urannons_thunderbolt",
		"wh_main_skill_all_magic_heavens_09_comet_of_casandora",
		"wh_main_skill_all_magic_heavens_10_chain_lightning",
		"wh_main_skill_all_magic_light_01_shems_burning_gaze",
		"wh_main_skill_all_magic_light_02_phas_protection",
		"wh_main_skill_all_magic_light_04_light_of_battle",
		"wh_main_skill_all_magic_light_05_net_of_amyntok",
		"wh_main_skill_all_magic_light_09_banishment",
		"wh_main_skill_all_magic_light_10_bironas_timewarp",
		"wh_main_skill_all_magic_metal_01_searing_doom",
		"wh_main_skill_all_magic_metal_02_plague_of_rust",
		"wh_main_skill_all_magic_metal_04_glittering_robe",
		"wh_main_skill_all_magic_metal_05_gehennas_golden_hounds",
		"wh_main_skill_all_magic_metal_09_transmutation_of_lead",
		"wh_main_skill_all_magic_metal_10_final_transmutation",
		"wh_main_skill_grn_magic_big_waaagh_01_gaze_of_mork",
		"wh_main_skill_grn_magic_big_waaagh_02_brain_bursta",
		"wh_main_skill_grn_magic_big_waaagh_03_fists_of_gork",
		"wh_main_skill_grn_magic_big_waaagh_05_eadbutt",
		"wh_main_skill_grn_magic_big_waaagh_09_ere_we_go",
		"wh_main_skill_grn_magic_big_waaagh_10_foot_of_gork",
		"wh_main_skill_grn_magic_little_waaagh_01_sneaky_stabbin",
		"wh_main_skill_grn_magic_little_waaagh_02_vindictive_glare",
		"wh_main_skill_grn_magic_little_waaagh_04_itchy_nuisance",
		"wh_main_skill_grn_magic_little_waaagh_05_gorkll_fix_it",
		"wh_main_skill_grn_magic_little_waaagh_09_night_shroud",
		"wh_main_skill_grn_magic_little_waaagh_10_curse_of_da_bad_moon",
		"wh_main_skill_vmp_magic_vampires_01_invocation_of_nehek",
		"wh_main_skill_vmp_magic_vampires_02_vanhels_danse_macabre",
		"wh_main_skill_vmp_magic_vampires_04_gaze_of_nagash",
		"wh_main_skill_vmp_magic_vampires_05_raise_dead",
		"wh_main_skill_vmp_magic_vampires_09_curse_of_years",
		"wh_main_skill_vmp_magic_vampires_10_wind_of_death",
		"wh_main_skill_dwf_engineer_unique_master_engineer_entrenchment",
		"wh_main_skill_dwf_engineer_self_extra_powder",
		"wh_main_skill_dwf_engineer_self_ballistics_calibration",
		"wh_main_skill_dwf_engineer_self_overseer",
		"wh_main_skill_dwf_engineer_self_ballistics_instructor",
		"wh_main_skill_dwf_runesmith_self_rune_of_hearth_&_home",
		"wh_main_skill_dwf_runesmith_self_rune_of_oath_&_steel",
		"wh_main_skill_dwf_runesmith_self_strike_the_runes",
		"wh_main_skill_dwf_runesmith_self_forgefire",
		"wh_main_skill_dwf_runesmith_self_rune_of_negation",
		"wh_dlc03_skill_magic_wild_bestial_surge",
		"wh_dlc03_skill_magic_wild_bray_scream",
		"wh_dlc03_skill_magic_wild_devolve",
		"wh_dlc03_skill_magic_wild_mantle_of_ghorok",
		"wh_dlc03_skill_magic_wild_savage_dominion",
		"wh_dlc03_skill_magic_wild_traitor_kin",
		"wh_dlc03_skill_magic_wild_viletide,",
		"wh_dlc03_skill_magic_beasts_flock_of_doom",
		"wh_dlc03_skill_magic_beasts_panns_impenetrable_pelt",
		"wh_dlc03_skill_magic_beasts_the_amber_spear",
		"wh_dlc03_skill_magic_beasts_the_curse_of_anraheir",
		"wh_dlc03_skill_magic_beasts_transformation_of_kadon",
		"wh_dlc03_skill_magic_beasts_wild_heart",
		"wh_dlc03_skill_magic_beasts_wyssans_wildform"
	};
	
	for i = 1, #buff_skills do
		local current_skill = buff_skills[i];
		if skill == current_skill then return true end;
	end;
end;



function num_units_in_battle(pb)
	local attacker = pb:attacker();
	local secondary_attacker_char_list = pb:secondary_attackers();

	local defender = pb:defender();
	local secondary_defender_char_list = pb:secondary_defenders();

	local attacker_army_size = 0;
	local defender_army_size = 0;

	if attacker:has_military_force() then
		attacker_army_size = attacker:military_force():unit_list():num_items();
		
		for i = 0, secondary_attacker_char_list:num_items() - 1 do
			local current_char = secondary_attacker_char_list:item_at(i);
			if current_char:has_military_force() then
				attacker_army_size = attacker_army_size + current_char:military_force():unit_list():num_items();
			end;
		end;
	end;

	if defender:has_military_force() then
		defender_army_size = defender:military_force():unit_list():num_items();
		
		for i = 0, secondary_defender_char_list:num_items() - 1 do
			local current_char = secondary_defender_char_list:item_at(i);
			if current_char:has_military_force() then
				defender_army_size = defender_army_size + current_char:military_force():unit_list():num_items();
			end;
		end;
	end;
	
	out("######## Battle completed - attacker had " .. attacker_army_size .. " units, defender had " .. defender_army_size .. " units");
end;


function region_has_chain_or_superchain(region, superchain)
	local slot_list = region:slot_list();
	
	for i = 0, slot_list:num_items() - 1 do
		current_slot = slot_list:item_at(i);
		if current_slot:has_building() and (current_slot:building():superchain() == superchain or current_slot:building():chain() == superchain) then
			return true;
		end;
	end;
	
	return false;
end;



function general_has_caster_embedded_in_army(character)
	if character:has_military_force() then
		local character_list = character:military_force():character_list();
		
		for i = 0, character_list:num_items() - 1 do
			if character_list:item_at(i):is_caster() then
				return true;
			end;
		end;
	end;
	
	return false;
end;

-- cbf
function military_force_has_character_that_can_equip_ancillary(military_force, ancillary)
	local character_list = military_force:character_list()
	
	for i = 0, character_list:num_items() - 1 do
		if character_list:item_at(i):can_equip_ancillary(ancillary) then
			return true
		end
	end
	
	return false
end