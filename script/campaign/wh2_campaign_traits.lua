
local TRAIT_LORDS_RECORDS = {};

local TRAIT_EXCLUSIONS = {
	["culture"] = {
		["wh2_main_trait_corrupted_chaos"] = {"wh_main_chs_chaos", "wh_dlc03_bst_beastmen", "wh2_main_skv_skaven"},
		["wh2_main_trait_corrupted_vampire"] = {"wh_main_vmp_vampire_counts", "wh2_dlc09_tmb_tomb_kings", "wh2_dlc11_cst_vampire_coast"},
		["wh2_main_trait_corrupted_skaven"] = {"wh2_main_skv_skaven", "wh_main_chs_chaos", "wh_dlc03_bst_beastmen"},
		["wh2_main_trait_pacifist"] = {"wh_main_chs_chaos", "wh_dlc03_bst_beastmen"},
		["wh2_main_trait_stance_recruiting"] = {"wh2_dlc09_tmb_tomb_kings", "wh_dlc03_bst_beastmen"},
		["wh2_main_trait_defeats_against_chaos"] = {"wh_main_chs_chaos"},
		["wh2_main_trait_agent_actions_against_chaos"] = {"wh_main_chs_chaos"},
		["wh2_main_trait_wins_against_chaos"] = {"wh_main_chs_chaos"}
	},
	["subculture"] = {
		["wh2_main_trait_attacking_defeat"] = {"wh_main_sc_brt_bretonnia"},
		["wh2_main_trait_attacking_victory"] = {"wh_main_sc_brt_bretonnia"},
		["wh2_main_trait_builder"] = {"wh_main_sc_brt_bretonnia"},
		["wh2_main_trait_defeats"] = {"wh_main_sc_brt_bretonnia"},
		["wh2_main_trait_defending_defeat"] = {"wh_main_sc_brt_bretonnia"},
		["wh2_main_trait_defending_victory"] = {"wh_main_sc_brt_bretonnia"},
		["wh2_main_trait_far_from_capital"] = {"wh_main_sc_brt_bretonnia"},
		["wh2_main_trait_lazy"] = {"wh_main_sc_brt_bretonnia", "wh_dlc05_sc_wef_wood_elves"},
		["wh2_main_trait_lone_wolf"] = {"wh_main_sc_brt_bretonnia"},
		["wh2_main_trait_post_battle_execute"] = {"wh_main_sc_brt_bretonnia", "wh_main_sc_dwf_dwarfs"},
		["wh2_main_trait_post_battle_ransom"] = {"wh_main_sc_brt_bretonnia"},
		["wh2_main_trait_public_order"] = {"wh_main_sc_brt_bretonnia"},
		["wh2_main_trait_razing"] = {"wh_main_sc_brt_bretonnia"},
		["wh2_main_trait_reinforcing"] = {"wh_main_sc_brt_bretonnia"},
		["wh2_main_trait_routed"] = {"wh_main_sc_brt_bretonnia"},
		["wh2_main_trait_sacking"] = {"wh_main_sc_brt_bretonnia"},
		["wh2_main_trait_siege_defeat"] = {"wh_main_sc_brt_bretonnia"},
		["wh2_main_trait_siege_victory"] = {"wh_main_sc_brt_bretonnia"},
		["wh2_main_trait_stance_raiding"] = {"wh_main_sc_brt_bretonnia"},
		["wh2_main_trait_wins"] = {"wh_main_sc_brt_bretonnia"},
		["wh2_main_trait_wins_against_humans"] = {"wh_main_sc_brt_bretonnia"},
		["wh2_main_trait_defeated_louen_leoncouer"] = {"wh_main_sc_brt_bretonnia"}
	},
	["faction"] = {
		["wh2_main_trait_corrupted_chaos"] =
			{"wh2_main_def_cult_of_pleasure",
			"wh2_main_def_cult_of_pleasure_separatists",
			"wh2_dlc13_lzd_spirits_of_the_jungle",
			"wh2_dlc17_lzd_oxyotl"},
		["wh2_main_trait_sacking"] = {"wh2_dlc13_lzd_spirits_of_the_jungle"}
	}
};

local LEGENDARY_LORD_DEFEATED_TRAITS = {
  --["character key"] (agent_subtypes) =   		"trait key" (character_traits)
	["emp_karl_franz"] =						"wh2_main_trait_defeated_karl_franz", 					-- Karl Franz
	["emp_balthasar_gelt"] =					"wh2_main_trait_defeated_balthasar_gelt",				-- Balthasar Gelt
	["dlc04_emp_volkmar"] =						"wh2_main_trait_defeated_volkmar_the_grim", 			-- Volkmar the Grim
	["dwf_thorgrim_grudgebearer"] =				"wh2_main_trait_defeated_thorgrim_grudgebearer", 		-- Thorgrim Grudgebearer
	["dwf_ungrim_ironfist"] =					"wh2_main_trait_defeated_ungrim_ironfist", 				-- Ungrim Ironfist
	["pro01_dwf_grombrindal"] = 				"wh2_main_trait_defeated_grombrindal", 					-- Grombrindal
	["dlc06_dwf_belegar"] =						"wh2_main_trait_defeated_belegar_ironhammer", 			-- Belegar Ironhammer
	["dlc05_wef_orion"] =						"wh2_main_trait_defeated_orion", 						-- Orion
	["dlc05_wef_durthu"] =						"wh2_main_trait_defeated_durthu", 						-- Durthu
	["grn_grimgor_ironhide"] =					"wh2_main_trait_defeated_grimgor_ironhide", 			-- Grimgor Ironhide
	["grn_azhag_the_slaughterer"] =				"wh2_main_trait_defeated_azhag_the_slaughterer", 		-- Azhag the Slaughterer
	["dlc06_grn_skarsnik"] =					"wh2_main_trait_defeated_skarsnik", 					-- Skarsnik
	["dlc06_grn_wurrzag_da_great_prophet"] =	"wh2_main_trait_defeated_wurzzag", 						-- Wurrzag
	["vmp_mannfred_von_carstein"] =				"wh2_main_trait_defeated_mannfred_von_carstein", 		-- Mannfred von Carstein
	["vmp_heinrich_kemmler"] =					"wh2_main_trait_defeated_heinrich_kemmler", 			-- Heinrich Kemmler
	["dlc04_vmp_vlad_con_carstein"] =			"wh2_main_trait_defeated_vlad_von_carstein", 			-- Vlad von Carstein
	["dlc04_vmp_helman_ghorst"] =				"wh2_main_trait_defeated_helmen_ghorst", 				-- Helman Ghorst
	["pro02_vmp_isabella_von_carstein"] =		"wh2_main_trait_defeated_isabella_von_carstein", 		-- Isabella von Carstein
	["chs_archaon"] =							"wh2_main_trait_defeated_archaon_the_everchosen", 		-- Archaon the Everchosen
	["chs_kholek_suneater"] =					"wh2_main_trait_defeated_kholek_suneater", 				-- Kholek Suneater
	["chs_prince_sigvald"] =					"wh2_main_trait_defeated_prince_sigvald", 				-- Prince Sigvald
	["dlc03_bst_khazrak"] =						"wh2_main_trait_defeated_khazrak_one_eye", 				-- Khazrak One-Eye
	["dlc03_bst_malagor"] =						"wh2_main_trait_defeated_malagor_the_dark_omen", 		-- Malagor the Dark Omen
	["dlc05_bst_morghur"] =						"wh2_main_trait_defeated_morghur_the_shadowgave", 		-- Morghur the Shadowgave
	["brt_louen_leoncouer"] =					"wh2_main_trait_defeated_louen_leoncouer", 				-- Louen Leoncouer
	["dlc07_brt_fay_enchantress"] =				"wh2_main_trait_defeated_fay_enchantress", 				-- Fay Enchantress
	["dlc07_brt_alberic"] =						"wh2_main_trait_defeated_alberic_de_bordeleaux", 		-- Alberic de Bordeleaux
	["wh_dlc08_nor_wulfrik"] =					"wh_dlc08_trait_defeated_wulfrik",						-- Wulfrik the Wanderer
	["wh_dlc08_nor_throgg"] =					"wh_dlc08_trait_defeated_throgg",						-- Throgg
	["wh2_main_hef_tyrion"] =					"wh2_main_trait_defeated_tyrion", 						-- Tyrion
	["wh2_main_hef_teclis"] =					"wh2_main_trait_defeated_teclis", 						-- Teclis
	["wh2_main_lzd_lord_mazdamundi"] =			"wh2_main_trait_defeated_lord_mazdamundi", 				-- Lord Mazdamundi
	["wh2_main_lzd_kroq_gar"] =					"wh2_main_trait_defeated_kroq_gar", 					-- Kroq-Gar
	["wh2_main_def_malekith"] =					"wh2_main_trait_defeated_malekith", 					-- Malekith
	["wh2_main_def_morathi"] =					"wh2_main_trait_defeated_morathi", 						-- Morathi
	["wh2_main_skv_queek_headtaker"] =			"wh2_main_trait_defeated_queen_headtaker", 				-- Queen Headtaker
	["wh2_main_skv_lord_skrolk"] =				"wh2_main_trait_defeated_lord_strolk", 					-- Lord Skrolk
	["wh2_dlc09_skv_tretch_craventail"] =		"wh2_dlc09_trait_defeated_tretch",						-- Tretch Craventail
	["wh2_dlc09_tmb_settra"] =					"wh2_dlc09_trait_defeated_settra",						-- Settra the Imperishable
	["wh2_dlc09_tmb_arkhan"] =					"wh2_dlc09_trait_defeated_arkhan",						-- Arkhan the Black
	["wh2_dlc09_tmb_khalida"] =					"wh2_dlc09_trait_defeated_khalida",						-- High Queen Khalida
	["wh2_dlc09_tmb_khatep"] =					"wh2_dlc09_trait_defeated_khatep",						-- Grand Hierophant Khatep
	["wh2_dlc10_hef_alarielle"] =				"wh2_dlc10_trait_defeated_alarielle",					-- Alarielle the Radiant
	["wh2_dlc10_hef_alith_anar"] =				"wh2_dlc10_trait_defeated_alith_anar",					-- Alith Anar
	["wh2_dlc10_def_crone_hellebron"] =			"wh2_dlc10_trait_defeated_hellebron",					-- Crone Hellebron
	["wh2_dlc11_cst_harkon"] =					"wh2_dlc11_trait_defeated_luthor_harkon",				-- Luthor Harkon
	["wh2_dlc11_cst_noctilus"] =				"wh2_dlc11_trait_defeated_count_noctilus",				-- Count Noctilus
	["wh2_dlc11_cst_aranessa"] =				"wh2_dlc11_trait_defeated_aranessa_saltspite",			-- Aranessa Saltspite
	["wh2_dlc11_cst_cylostra"] =				"wh2_dlc11_trait_defeated_cylostra_direfin",			-- Cylostra Direfin
	["wh2_dlc11_def_lokhir"] =					"wh2_dlc11_trait_defeated_lokhir_fellheart",			-- Lokhir Fellheart
	["wh2_dlc12_lzd_tehenhauin"] =				"wh2_dlc12_trait_defeated_tehenhauin",					-- Tehenhauin
	["wh2_dlc12_skv_ikit_claw"] =				"wh2_dlc12_trait_defeated_ikit_claw",					-- Ikit Claw
	["wh2_dlc12_lzd_tiktaqto"] =				"wh2_dlc12_trait_defeated_tiktaqto",					-- Tiktaq'to
	["wh2_dlc13_emp_cha_markus_wulfhart_0"] = 	"wh2_dlc13_trait_defeated_wulfhart",					-- Markus Wulfhart
	["wh2_dlc13_lzd_nakai"] = 					"wh2_dlc13_trait_defeated_nakai",						-- Nakai
	["wh2_dlc13_lzd_gor_rok"] = 				"wh2_dlc13_trait_defeated_gorrok",						-- Gor-Rok
	["wh2_dlc14_brt_repanse"] = 				"wh2_dlc14_trait_defeated_repanse",						-- Repanse de Lyonese
	["wh2_dlc14_def_malus_darkblade"] =			"wh2_dlc14_trait_defeated_malus",						-- Malus Darkblade
	["wh2_dlc14_skv_deathmaster_snikch"] =		"wh2_dlc14_trait_defeated_snikch",						-- Deathmaster Snikch
	["wh2_pro08_neu_gotrek"] =					"wh2_dlc14_trait_defeated_gotrek",						-- Gotrek
	["wh2_dlc15_hef_imrik"] = 					"wh2_dlc15_trait_defeated_imrik",						-- Imrik
	["wh2_dlc15_hef_eltharion"] = 				"wh2_dlc15_trait_defeated_eltharion",					-- Eltharion the Grim
	["wh2_dlc15_grn_grom_the_paunch"] = 		"wh2_dlc15_trait_defeated_grom",					    -- Grom the Paunch
	["wh2_dlc16_wef_drycha"] = 		            "wh2_main_trait_defeated_drycha",						-- Drycha
	["wh2_dlc16_wef_sisters_of_twilight"] =     "wh2_main_trait_defeated_sisters_of_twilight",			-- Sisters of Twilight
	["wh2_dlc16_skv_throt_the_unclean"] = 		"wh2_main_trait_defeated_throt",						-- Throt the Unclean
	["wh2_twa03_def_rakarth"] = 				"wh2_twa03_trait_defeated_rakarth",						-- Rakarth
	["wh2_dlc17_lzd_oxyotl"] =					"wh2_dlc17_trait_defeated_oxyotl",						-- Oxyotl
	["wh2_dlc17_bst_taurox"] =					"wh2_dlc17_trait_defeated_taurox",						-- Taurox
	["wh2_dlc17_dwf_thorek"] =					"wh2_dlc17_trait_defeated_thorek"						-- Thorek Ironbrow
};

local SUBCULTURES_TRAIT_KEYS = {
	["wh_main_sc_chs_chaos"] = "chaos",
	["wh_main_sc_nor_norsca"] = "chaos",
	["wh_main_sc_dwf_dwarfs"] = "dwarfs",
	["wh_main_sc_grn_greenskins"] = "greenskins",
	["wh_main_sc_grn_savage_orcs"] = "greenskins",
	["wh_main_sc_emp_empire"] = "humans",
	["wh_main_sc_ksl_kislev"] = "humans",
	["wh_main_sc_brt_bretonnia"] = "humans",
	["wh_main_sc_teb_teb"] = "humans",
	["wh_main_sc_vmp_vampire_counts"] = "vampires",
	["wh_dlc03_sc_bst_beastmen"] = "beastmen",
	["wh_dlc05_sc_wef_wood_elves"] = "wood_elves",
	["wh2_main_sc_def_dark_elves"] = "dark_elves",
	["wh2_main_sc_hef_high_elves"] = "high_elves",
	["wh2_main_sc_lzd_lizardmen"] = "lizardmen",
	["wh2_main_sc_skv_skaven"] = "skaven",
	["wh2_dlc09_sc_tmb_tomb_kings"] = "tomb_kings",
	["wh2_dlc11_sc_cst_vampire_coast"] = "vampire_coast"
};

local ACTION_KEY_TO_ACTION = {
	["wh2_main_agent_action_champion_assist_army_replenish_troops"] = "Replenish Troops",
	["wh2_main_agent_action_champion_assist_army_training"] = "Training",
	["wh2_main_agent_action_champion_hinder_agent_assassinate"] = "Assassinate",
	["wh2_main_agent_action_champion_hinder_agent_wound"] = "Wound",
	["wh2_main_agent_action_champion_hinder_army_assault_units"] = "Assault Units",
	["wh2_main_agent_action_champion_hinder_army_block_army"] = "Block Army",
	["wh2_main_agent_action_champion_hinder_settlement_assault_garrison"] = "Assault Garrison",
	["wh2_main_agent_action_champion_hinder_settlement_damage_walls"] = "Damage Walls",
	["wh2_main_agent_action_champion_hinder_settlement_scout_settlement"] = "Scout Settlement",
	["wh2_main_agent_action_dignitary_assist_army_replenish_troops"] = "Replenish Troops",
	["wh2_main_agent_action_dignitary_hinder_agent_wound"] = "Wound",
	["wh2_main_agent_action_dignitary_hinder_army_hinder_replenishment"] = "Hinder Replenishment",
	["wh2_main_agent_action_dignitary_hinder_settlement_damage_building"] = "Damage Building",
	["wh2_main_agent_action_dignitary_hinder_settlement_damage_walls"] = "Damage Walls",
	["wh2_main_agent_action_dignitary_hinder_settlement_scout_settlement"] = "Scout Settlement",
	["wh2_main_agent_action_engineer_assist_army_increase_mobility"] = "Increase Mobility",
	["wh2_main_agent_action_engineer_hinder_agent_wound"] = "Wound",
	["wh2_main_agent_action_engineer_hinder_army_block_army"] = "Block Army",
	["wh2_main_agent_action_engineer_hinder_settlement_scout_settlement"] = "Scout Settlement",
	["wh2_main_agent_action_engineer_hinder_settlement_steal_technology"] = "Steal Technology",
	["wh2_main_agent_action_engineer_hinder_settlement_warlock_engineer_ritual"] = "Cause Earthquake",
	["wh2_main_agent_action_runesmith_assist_army_scouting"] = "Scouting",
	["wh2_main_agent_action_runesmith_assist_army_training"] = "Training",
	["wh2_main_agent_action_runesmith_hinder_agent_wound"] = "Wound",
	["wh2_main_agent_action_runesmith_hinder_army_hinder_replenishment"] = "Hinder Replenishment",
	["wh2_main_agent_action_runesmith_hinder_settlement_damage_walls"] = "Damage Walls",
	["wh2_main_agent_action_runesmith_hinder_settlement_scout_settlement"] = "Scout Settlement",
	["wh2_main_agent_action_spy_assist_army_increase_mobility"] = "Increase Mobility",
	["wh2_main_agent_action_spy_assist_army_replenish_troops"] = "Replenish Troops",
	["wh2_main_agent_action_spy_assist_army_scavenge"] = "Scavenge",
	["wh2_main_agent_action_spy_assist_army_training"] = "Training",
	["wh2_main_agent_action_spy_hinder_agent_assassinate"] = "Assassinate",
	["wh2_main_agent_action_spy_hinder_army_assault_units"] = "Assault Units",
	["wh2_main_agent_action_spy_hinder_army_block_army"] = "Block Army",
	["wh2_main_agent_action_spy_hinder_army_hinder_replenishment"] = "Hinder Replenishment",
	["wh2_main_agent_action_spy_hinder_settlement_assault_garrison"] = "Assault Garrison",
	["wh2_main_agent_action_spy_hinder_settlement_damage_walls"] = "Damage Walls",
	["wh2_main_agent_action_spy_hinder_settlement_scout_settlement"] = "Scout Settlement",
	["wh2_main_agent_action_wizard_assist_army_scouting"] = "Scouting",
	["wh2_main_agent_action_wizard_hinder_agent_wound"] = "Wound",
	["wh2_main_agent_action_wizard_hinder_army_assault_unit"] = "Assault Unit",
	["wh2_main_agent_action_wizard_hinder_army_block_army"] = "Block Army",
	["wh2_main_agent_action_wizard_hinder_army_hinder_replenishment"] = "Hinder Replenishment",
	["wh2_main_agent_action_wizard_hinder_settlement_damage_walls"] = "Damage Walls",
	["wh2_main_agent_action_wizard_hinder_settlement_plague_priest_ritual"] = "Spread Plague",
	["wh2_main_agent_action_wizard_hinder_settlement_scout_settlement"] = "Scout Settlement",
	["wh2_main_agent_action_wizard_hinder_settlement_steal_technology"] = "Steal Technology"
};

local ACTION_TO_TRAIT = {
	["Assassinate"] = "wh2_main_trait_agent_action_assassinate",
	["Assault Garrison"] = "wh2_main_trait_agent_action_assault_garrison",
	["Assault Unit"] = "wh2_main_trait_agent_action_assault_unit",
	["Assault Units"] = "wh2_main_trait_agent_action_assault_units",
	["Block Army"] = "wh2_main_trait_agent_action_block_army",
	["Block Magic"] = "wh2_main_trait_agent_action_block_magic",
	["Cleanse Corruption"] = "wh2_main_trait_agent_action_cleanse_corruption",
	["Damage Building"] = "wh2_main_trait_agent_action_damage_building",
	["Damage Buildings"] = "wh2_main_trait_agent_action_damage_buildings",
	["Damage Walls"] = "wh2_main_trait_agent_action_damage_walls",
	["Demoralise Army"] = "wh2_main_trait_agent_action_demoralise_army",
	["Sabotage"] = "wh2_main_trait_agent_action_sabotage",
	["Spread Plague"] = "wh2_main_trait_agent_action_spread_plague",
	["Storm Garrison"] = "wh2_main_trait_agent_action_storm_garrison",
	["Steal Technology"] = "wh2_main_trait_agent_action_steal_technology",
	["Wound"] = "wh2_main_trait_agent_action_wound",
	["Scout Settlement"] = "wh2_main_trait_agent_action_scout_settlement",
	["Hinder Replenishment"] = "wh2_main_trait_agent_action_hinder_replenishment",
	["Cause Earthquake"] = "wh2_main_trait_agent_action_cause_earthquake"
};

------------------------------------------------------------------------------
---- Function: Gives points in a trait to a Lord, with an optional chance ----
------------------------------------------------------------------------------
function Give_Trait(character, trait, _points, _chance)
	local chance = _chance or 100;
	local points = _points or 1;
	
	if character == nil then
		out("TRAIT ERROR: Tried to give trait to a character that was not specified!");
		return false;
	end

	if character:is_null_interface() == true then
		out("TRAIT ERROR: Tried to give trait to a character that was a null interface!");
		return false;
	end
	
	if Check_Exclusion(trait, character) then
		return false;
	end
	
	if cm:model():random_percent(chance) == false then
		return false;
	end
	
	cm:force_add_trait("character_cqi:"..character:cqi(), trait, true, points, true);
	return true;
end

function Remove_Trait(character, trait)
	if character == nil then
		return false;
	end

	if character:is_null_interface() == true then
		return false;
	end

	cm:force_remove_trait("character_cqi:"..character:cqi(), trait);
	return true;
end

function Check_Exclusion(trait, character)
	local char_faction = character:faction();
	local char_culture = char_faction:culture();
	local char_subculture = char_faction:subculture();
	local char_faction_name = char_faction:name();

	local culture_exclusions = TRAIT_EXCLUSIONS["culture"][trait];
	local subculture_exclusions = TRAIT_EXCLUSIONS["subculture"][trait];
	local faction_exclusions = TRAIT_EXCLUSIONS["faction"][trait];
	
	if culture_exclusions ~= nil then
		for i = 1, #culture_exclusions do
			if culture_exclusions[i] == char_culture then
				return true;
			end
		end
	end
	if subculture_exclusions ~= nil then
		for i = 1, #subculture_exclusions do
			if subculture_exclusions[i] == char_subculture then
				return true;
			end
		end
	end
	if faction_exclusions ~= nil then
		for i = 1, #faction_exclusions do
			if faction_exclusions[i] == char_faction_name then
				return true;
			end
		end
	end
	if character:character_type("colonel") or char_faction:is_quest_battle_faction() then
		return true;
	end
	return false;
end

-------------------------------------------------------------------
---- Function: Retrieves a piece of recorded data about a Lord ----
-------------------------------------------------------------------
function Get_Lord_Record(character, stat_key)
	if character:is_null_interface() == false then
		local char_cqi = character:cqi();
		local val = TRAIT_LORDS_RECORDS[tostring(char_cqi).."_"..stat_key];
		return val;
	end
end

-------------------------------------------------------------------------
---- Function: Records a piece of custom data associated with a Lord ----
-------------------------------------------------------------------------
function Set_Lord_Record(character, stat_key, value)
	if character:is_null_interface() == false then
		local char_cqi = character:cqi();
		TRAIT_LORDS_RECORDS[tostring(char_cqi).."_"..stat_key] = value;
	end
end

-----------------------------------
---- DEFEATING LEGENDARY LORDS ----
-----------------------------------
events.CharacterCompletedBattle[#events.CharacterCompletedBattle+1] =
function (context)
	local character = context:character();

	if cm:char_is_general_with_army(character) and character:won_battle() then
		local LL_enemies = Get_Enemy_Legendary_Lords_In_Last_Battle(character);
		
		for i = 1, #LL_enemies do
			local LL_trait = LEGENDARY_LORD_DEFEATED_TRAITS[LL_enemies[i]];
			
			if LL_trait ~= nil then
				if LL_trait == "wh2_dlc09_trait_defeated_settra" and is_surtha_ek(character) then
					Give_Trait(character, "wh2_dlc09_trait_defeated_settra_as_surtha");
				else
					Give_Trait(character, LL_trait);
				end
			elseif LL_enemies[i] == "surtha_ek" and character:character_subtype("wh2_dlc09_tmb_settra") then
				Give_Trait(character, "wh2_dlc09_trait_defeated_surtha_as_settra");
			end
		end
	end
end

function Get_Enemy_Legendary_Lords_In_Last_Battle(character)
	local pb = cm:model():pending_battle();
	local LL_attackers = {};
	local LL_defenders = {};
	local was_attacker = false;

	local num_attackers = cm:pending_battle_cache_num_attackers();
	local num_defenders = cm:pending_battle_cache_num_defenders();

	if pb:night_battle() == true then --or pb:ambush_battle() == true
		num_attackers = 1;
		num_defenders = 1;
	end
	
	for i = 1, num_attackers do
		local this_char_cqi, this_mf_cqi, current_faction_name = cm:pending_battle_cache_get_attacker(i);
		local char_subtype = cm:pending_battle_cache_get_attacker_subtype(i);
		
		if this_char_cqi == character:cqi() then
			was_attacker = true;
			break;
		end
		
		if LEGENDARY_LORD_DEFEATED_TRAITS[char_subtype] ~= nil then
			table.insert(LL_attackers, char_subtype);
		else
			local char_obj = cm:model():character_for_command_queue_index(this_char_cqi);

			if char_obj:is_null_interface() == false and is_surtha_ek(char_obj) == true then
				table.insert(LL_attackers, "surtha_ek");
			end
		end
	end
	
	if was_attacker == false then
		return LL_attackers;
	end
	
	for i = 1, num_defenders do
		local this_char_cqi, this_mf_cqi, current_faction_name = cm:pending_battle_cache_get_defender(i);
		local char_subtype = cm:pending_battle_cache_get_defender_subtype(i);
		
		if LEGENDARY_LORD_DEFEATED_TRAITS[char_subtype] ~= nil then
			table.insert(LL_defenders, char_subtype);
		else
			local char_obj = cm:model():character_for_command_queue_index(this_char_cqi);

			if char_obj:is_null_interface() == false and is_surtha_ek(char_obj) == true then
				table.insert(LL_defenders, "surtha_ek");
			end
		end
	end
	return LL_defenders;
end

function is_surtha_ek(char_obj)
	if char_obj:forename("names_name_2147345608") == true and char_obj:surname("names_name_2147345760") == true then
		return true;
	end
	return false;
end

-------------------------------------------
---- AGENT ACTIONS AGAINST SUBCULTURES ----
-------------------------------------------
events.CharacterCharacterTargetAction[#events.CharacterCharacterTargetAction+1] =
function (context)
	if context:ability() ~= "assist_army" and (context:mission_result_success() or context:mission_result_critial_success()) then
		local subculture = context:target_character():faction():subculture();
		local own_subculture = context:character():faction():subculture();
		
		if subculture ~= own_subculture and SUBCULTURES_TRAIT_KEYS[subculture] ~= nil then
			Give_Trait(context:character(), "wh2_main_trait_agent_actions_against_"..SUBCULTURES_TRAIT_KEYS[subculture]);
			
			if SUBCULTURES_TRAIT_KEYS[subculture] == "skaven" then
				RemoveSkavenFromCharacterAndForce(context:character());
			end
		end
	end
end

events.CharacterGarrisonTargetAction[#events.CharacterGarrisonTargetAction+1] =
function (context)
	if context:mission_result_success() or context:mission_result_critial_success() then
		local subculture = context:garrison_residence():faction():subculture();
		
		if SUBCULTURES_TRAIT_KEYS[subculture] ~= nil then
			Give_Trait(context:character(), "wh2_main_trait_agent_actions_against_"..SUBCULTURES_TRAIT_KEYS[subculture]);
			
			if SUBCULTURES_TRAIT_KEYS[subculture] == "skaven" then
				RemoveSkavenFromCharacterAndForce(context:character());
			end
		end
	end
end

------------------------
---- BATTLES FOUGHT ----
------------------------
events.CharacterCompletedBattle[#events.CharacterCompletedBattle+1] =
function (context)
	local character = context:character();
	local side = Get_Character_Side_In_Last_Battle(character);
	local result = "defeat";
	
	if character:won_battle() == true then
		result = "victory";
	end
	
	if context:pending_battle():seige_battle() == true and context:pending_battle():battle_type() == "settlement_standard" then
		Give_Trait(character, "wh2_main_trait_siege_"..result);
	else
		if side == "Attacker" then
			Give_Trait(character, "wh2_main_trait_attacking_"..result);
		elseif side == "Defender" then
			Give_Trait(character, "wh2_main_trait_defending_"..result);
		end
	end
end

-------------------------------------
---- BATTLES AGAINST SUBCULTURES ----
-------------------------------------
events.CharacterCompletedBattle[#events.CharacterCompletedBattle+1] =
function (context)
	GeneralCompletedBattle(context);
end
events.CharacterParticipatedAsSecondaryGeneralInBattle[#events.CharacterParticipatedAsSecondaryGeneralInBattle+1] =
function (context)
	GeneralCompletedBattle(context);
end

function GeneralCompletedBattle(context)
	local character = context:character();
	local side = Get_Character_Side_In_Last_Battle(character);
	local enemy_culture = "";
	local enemy_subculture = "";
	
	if side == "Attacker" then
		local char_cqi, mf_cqi, faction_name = cm:pending_battle_cache_get_defender(1);
		local world = cm:model():world();
		
		if world:faction_exists(faction_name) then
			local faction = world:faction_by_key(faction_name);
			enemy_culture = faction:culture();
			enemy_subculture = faction:subculture();	
		end;
	elseif side == "Defender" then
		local char_cqi, mf_cqi, faction_name = cm:pending_battle_cache_get_attacker(1);
		local world = cm:model():world();
		
		if world:faction_exists(faction_name) then
			local faction = world:faction_by_key(faction_name);
			enemy_culture = faction:culture();
			enemy_subculture = faction:subculture();	
		end;
	end
	
	if character:faction():subculture() ~= enemy_subculture and SUBCULTURES_TRAIT_KEYS[enemy_subculture] ~= nil then
		if character:won_battle() == true then
			Give_Trait(context:character(), "wh2_main_trait_wins_against_"..SUBCULTURES_TRAIT_KEYS[enemy_subculture]);
		else
			Give_Trait(context:character(), "wh2_main_trait_defeats_against_"..SUBCULTURES_TRAIT_KEYS[enemy_subculture]);
		end
		
		if SUBCULTURES_TRAIT_KEYS[enemy_subculture] == "skaven" then
			RemoveSkavenFromCharacterAndForce(context:character());
		end
	elseif enemy_culture == "wh2_main_rogue" then
		Give_Trait(context:character(), "wh2_main_trait_wins_against_rogue_armies");
	end
end

function Get_Character_Side_In_Last_Battle(character)
	for i = 1, cm:pending_battle_cache_num_attackers() do
		local char_cqi, mf_cqi, faction_name = cm:pending_battle_cache_get_attacker(i);
		
		if char_cqi == character:cqi() then
			return "Attacker";
		end
	end
	for i = 1, cm:pending_battle_cache_num_defenders() do
		local char_cqi, mf_cqi, faction_name = cm:pending_battle_cache_get_defender(i);
		
		if char_cqi == character:cqi() then
			return "Defender";
		end
	end
	return "";
end

------------------------------
---- FOUGHT NAVAL BATTLES ----
------------------------------
events.CharacterCompletedBattle[#events.CharacterCompletedBattle+1] =
function (context)
	local character = context:character();
	
	if character:is_at_sea() == true then
		if character:won_battle() == true then
			Give_Trait(character, "wh2_main_trait_wins_at_sea");
		else
			Give_Trait(character, "wh2_main_trait_defeats_at_sea");
		end
	end
end

---------------------------------
---- REINFORCING SUBCULTURES ----
---------------------------------
events.CharacterCompletedBattle[#events.CharacterCompletedBattle+1] =
function (context)
	if cm:char_is_general_with_army(context:character()) then
		local primary_attacker_char_cqi, primary_attacker_mf_cqi, primary_attacker_faction_name = cm:pending_battle_cache_get_attacker(1);
		local primary_attacker = cm:model():character_for_command_queue_index(primary_attacker_char_cqi);
		
		if primary_attacker:is_null_interface() == false then
			if primary_attacker:command_queue_index() ~= context:character():command_queue_index() then -- We don't check reinforcement for this battle if this is the primary character
				if cm:pending_battle_cache_num_attackers() > 1 then
					local primary_attacker_subculture = primary_attacker:faction():subculture();
					
					for i = 2, cm:pending_battle_cache_num_attackers() do
						local char_cqi, mf_cqi, faction_name = cm:pending_battle_cache_get_attacker(i);
						local char_obj = cm:model():character_for_command_queue_index(char_cqi);
						
						if char_obj:is_null_interface() == false then
							local char_subculture = char_obj:faction():subculture();
							
							if char_subculture == primary_attacker_subculture then
								-- Reinforced Yourself
								Give_Trait(char_obj, "wh2_main_trait_reinforcing");
							elseif SUBCULTURES_TRAIT_KEYS[primary_attacker_subculture] ~= nil then
								-- Reinforced Others
								local trait = "wh2_main_trait_reinforcing_"..SUBCULTURES_TRAIT_KEYS[primary_attacker_subculture];
								Give_Trait(char_obj, trait);
								
								if SUBCULTURES_TRAIT_KEYS[primary_attacker_subculture] == "skaven" then
									RemoveSkavenFromCharacterAndForce(char_obj);
								end
							end
						end
					end
				end
			end
		end
		
		local primary_defender_char_cqi, primary_defender_mf_cqi, primary_defender_faction_name = cm:pending_battle_cache_get_defender(1);
		local primary_defender = cm:model():character_for_command_queue_index(primary_defender_char_cqi);
		
		if primary_defender:is_null_interface() == false then
			if primary_defender:command_queue_index() ~= context:character():command_queue_index() then -- We don't check reinforcement for this battle if this is the primary character
				if cm:pending_battle_cache_num_defenders() > 1 then
					local primary_defender_subculture = primary_defender:faction():subculture();
					
					for i = 2, cm:pending_battle_cache_num_defenders() do
						local char_cqi, mf_cqi, faction_name = cm:pending_battle_cache_get_defender(i);
						local char_obj = cm:model():character_for_command_queue_index(char_cqi);
						
						if char_obj:is_null_interface() == false then
							local char_subculture = char_obj:faction():subculture();
							
							if char_subculture == primary_defender_subculture then
								-- Reinforced Yourself
								Give_Trait(char_obj, "wh2_main_trait_reinforcing");
							elseif SUBCULTURES_TRAIT_KEYS[primary_defender_subculture] ~= nil then
								-- Reinforced Others
								local trait = "wh2_main_trait_reinforcing_"..SUBCULTURES_TRAIT_KEYS[primary_defender_subculture];
								Give_Trait(char_obj, trait);
								
								if SUBCULTURES_TRAIT_KEYS[primary_defender_subculture] == "skaven" then
									RemoveSkavenFromCharacterAndForce(char_obj);
								end
							end
						end
					end
				end
			end
		end
	end
end

--------------------------------
---- TURNS IN ENEMY REGIONS ----
--------------------------------
events.CharacterTurnStart[#events.CharacterTurnStart+1] =
function (context)
	local character = context:character();

	if character:is_null_interface() == false then
		if not character:faction():is_allowed_to_capture_territory() then
			if cm:char_is_general_with_army(character) and character:has_region() and not character:region():is_abandoned() then
				if character:turns_in_enemy_regions() >= 20 then
					if character:trait_points("wh2_main_trait_lone_wolf") == 2 then
						Give_Trait(character, "wh2_main_trait_lone_wolf");
					end
				elseif character:turns_in_enemy_regions() >= 15 then
					if character:trait_points("wh2_main_trait_lone_wolf") == 1 then
						Give_Trait(character, "wh2_main_trait_lone_wolf");
					end
				elseif character:turns_in_enemy_regions() >= 10 then
					if character:trait_points("wh2_main_trait_lone_wolf") == 0 then
						Give_Trait(character, "wh2_main_trait_lone_wolf");
					end
				end
			end
		end
	end
end

----------------------------
---- TURNS SPENT AT SEA ----
----------------------------
events.CharacterTurnStart[#events.CharacterTurnStart+1] =
function (context)
	local character = context:character();

	if character:is_at_sea() and cm:char_is_general_with_army(character) then
		Give_Trait(character, "wh2_main_trait_sea_legs");
	end
end

-------------------------
---- TIME IN STANCES ----
-------------------------
events.CharacterTurnEnd[#events.CharacterTurnEnd+1] =
function (context)
	local character = context:character();
	
	if cm:char_is_general_with_army(character) then
		local stance = character:military_force():active_stance();
		local culture = character:faction():culture();
		
		-- RAIDING
		if stance == "MILITARY_FORCE_ACTIVE_STANCE_TYPE_LAND_RAID" or stance == "MILITARY_FORCE_ACTIVE_STANCE_TYPE_SET_CAMP_RAIDING" then
			Give_Trait(character, "wh2_main_trait_stance_raiding");
		-- AMBUSHING
		elseif stance == "MILITARY_FORCE_ACTIVE_STANCE_TYPE_AMBUSH" then
			Give_Trait(character, "wh2_main_trait_stance_ambushing");
		-- TUNNELING
		elseif stance == "MILITARY_FORCE_ACTIVE_STANCE_TYPE_TUNNELING" then
			Give_Trait(character, "wh2_main_trait_stance_tunneling");
		-- FORCED MARCH
		elseif stance == "MILITARY_FORCE_ACTIVE_STANCE_TYPE_MARCH" then
			Give_Trait(character, "wh2_main_trait_stance_forced_march");
		-- RECRUITING
		elseif stance == "MILITARY_FORCE_ACTIVE_STANCE_TYPE_MUSTER" then
			Give_Trait(character, "wh2_main_trait_stance_recruiting");
		-- STALKING
		elseif stance == "MILITARY_FORCE_ACTIVE_STANCE_TYPE_STALKING" and culture == "wh2_main_skv_skaven" then
			Give_Trait(character, "wh2_main_trait_stance_stalking");
		-- LILEATH
		elseif stance == "MILITARY_FORCE_ACTIVE_STANCE_TYPE_CHANNELING" and culture == "wh2_main_hef_high_elves" then
			Give_Trait(character, "wh2_main_trait_stance_channeling");
		-- ASTROMANCY
		elseif stance == "MILITARY_FORCE_ACTIVE_STANCE_TYPE_ASTROMANCY" and culture == "wh2_main_lzd_lizardmen" then
			Give_Trait(character, "wh2_main_trait_stance_astromancy");
		end
	end
end

-----------------------------
---- SACKING SETTLEMENTS ----
-----------------------------
events.CharacterSackedSettlement[#events.CharacterSackedSettlement+1] =
function (context)
	if cm:char_is_general_with_army(context:character()) then
		Give_Trait(context:character(), "wh2_main_trait_sacking");
	end
end

-----------------------------
---- RAZING SETTLEMENTS ----
-----------------------------
events.CharacterRazedSettlement[#events.CharacterRazedSettlement+1] =
function (context)
	if cm:char_is_general_with_army(context:character()) then
		Give_Trait(context:character(), "wh2_main_trait_razing");
	end
end

--------------------------
---- ROUTED IN BATTLE ----
--------------------------
events.CharacterCompletedBattle[#events.CharacterCompletedBattle+1] =
function (context)
	if cm:char_is_general_with_army(context:character()) then
		if context:character():routed_in_battle() and context:character():won_battle() == false then
			Give_Trait(context:character(), "wh2_main_trait_routed");
		elseif context:character():routed_in_battle() == false and context:character():won_battle() == true and context:character():fought_in_battle() then
			Give_Trait(context:character(), "wh2_main_trait_fighter");
		end
	end
end

-------------------------------
---- POST-BATTLE RANSOMING ----
-------------------------------
events.CharacterPostBattleRelease[#events.CharacterPostBattleRelease+1] =
function (context)
	if cm:char_is_general_with_army(context:character()) then
		Give_Trait(context:character(), "wh2_main_trait_post_battle_ransom");
	end
end

-------------------------------
---- POST-BATTLE EXECUTING ----
-------------------------------
events.CharacterPostBattleSlaughter[#events.CharacterPostBattleSlaughter+1] =
function (context)
	if cm:char_is_general_with_army(context:character()) then
		Give_Trait(context:character(), "wh2_main_trait_post_battle_execute");
	end
end

---------------------------------
---- FOUGHT FAR FROM CAPITAL ----
---------------------------------
events.CharacterCompletedBattle[#events.CharacterCompletedBattle+1] =
function (context)
	local character = context:character();
	
	--if not character:faction():is_allowed_to_capture_territory() then
		if cm:char_is_general_with_army(character) and character:faction():has_home_region() then
			local home = character:faction():home_region():settlement();
			if distance_squared(character:logical_position_x(), character:logical_position_y(), home:logical_position_x(), home:logical_position_y()) >= 100000 then
				Give_Trait(character, "wh2_main_trait_far_from_capital");
			end
		end
	--end
end

--------------------------------------
---- IN OWNED SETTLEMENT TOO LONG ----
--------------------------------------
events.CharacterTurnStart[#events.CharacterTurnStart+1] =
function (context)
	local character = context:character();
	
	if character:faction():is_human() and character:has_region() --[[and not character:faction():is_allowed_to_capture_territory()]] and cm:char_is_general_with_army(character) then
		if character:in_settlement() and character:region():public_order() >= 90 and character:military_force():active_stance() ~= "MILITARY_FORCE_ACTIVE_STANCE_TYPE_MUSTER" then
			local char_turns_being_lazy = Get_Lord_Record(character, "turns_lazy") or 0;
			char_turns_being_lazy = char_turns_being_lazy + 1;
			
			if char_turns_being_lazy >= 20 then
				Give_Trait(character, "wh2_main_trait_lazy");
				Set_Lord_Record(character, "turns_lazy", 0);
			else
				Set_Lord_Record(character, "turns_lazy", char_turns_being_lazy);
			end
		else
			Set_Lord_Record(character, "turns_lazy", 0);
		end
	end;
end

---------------------------------------------
---- IN SETTLEMENT WITH LOW PUBLIC ORDER ----
---------------------------------------------
events.CharacterTurnStart[#events.CharacterTurnStart+1] =
function (context)
	local character = context:character();
	
	if character:has_region() and character:in_settlement() == true then
		local region = character:region();
		if region:public_order() <= -20 and region:owning_faction():is_faction(character:faction()) then 
			Give_Trait(character, "wh2_main_trait_public_order");
		end
	end;
end

------------------------------------
---- TURNS IN CORRUPTED REGIONS ----
------------------------------------
events.CharacterTurnStart[#events.CharacterTurnStart+1] =
function (context)
	local character = context:character();
	
	if character:has_region() then
		local chaos = character:region():religion_proportion("wh_main_religion_chaos");
		local vampiric = character:region():religion_proportion("wh_main_religion_undeath");
		local skaven = character:region():religion_proportion("wh2_main_religion_skaven");
		
		if chaos >= 0.5 then
			Give_Trait(character, "wh2_main_trait_corrupted_chaos");
		elseif vampiric >= 0.5 then
			Give_Trait(character, "wh2_main_trait_corrupted_vampire");
		elseif chaos < 0.1 and vampiric < 0.1 and skaven < 0.1 then
			if character:trait_points("wh2_main_trait_corrupted_chaos") > 0 or character:trait_points("wh2_main_trait_corrupted_vampire") > 0 then
				Give_Trait(character, "wh2_main_trait_non_corrupted");
			end
		end
	end
end

--------------------------------------------
---- IN REGION WHEN BUILDINGS ARE BUILT ----
--------------------------------------------
events.BuildingCompleted[#events.BuildingCompleted+1] =
function (context)
	local building = context:building();
	local faction = building:faction()

	if faction:character_list():num_items() > 1 then
		for i = 0, faction:character_list():num_items() - 1 do
			local builder = faction:character_list():item_at(i);
			
			if builder:has_region() and cm:char_is_general_with_army(builder) and builder:region():name() == building:region():name() then
				Give_Trait(builder, "wh2_main_trait_builder");
			end
		end
	end
end

------------------------------------------------
---- ARMY SUFFERS HIGH CASUALTIES IN BATTLE ----
------------------------------------------------
events.CharacterCompletedBattle[#events.CharacterCompletedBattle+1] =
function (context)
	local character = context:character();
	
	if cm:char_is_general_with_army(character) then
		local losses = character:percentage_of_own_alliance_killed();
		
		if losses >= 0.6 then
			Give_Trait(character, "wh2_main_trait_casualties");
		end
	end
end

-----------------------------------------
---- AGENT ACTIONS AGAINST CHARACTER ----
-----------------------------------------
events.CharacterCharacterTargetAction[#events.CharacterCharacterTargetAction+1] =
function (context)
	local target = context:target_character();
	
	if context:ability() == "assist_army" or context:ability() == "assist_province" or context:ability() == "command_force" or context:ability() == "passive_ability" then
		return false;
	end
	
	if context:mission_result_success() == true or context:mission_result_critial_success() == true then
	
		if target:is_null_interface() == false then
			Give_Trait(target, "wh2_main_trait_agent_target_success");
			
			if context:agent_action_key() == "wh2_main_agent_action_champion_hinder_agent_assassinate" or context:agent_action_key() == "wh2_main_agent_action_spy_hinder_agent_assassinate" then
				Give_Trait(target, "wh2_main_trait_wounded");
			end
		end
	elseif context:mission_result_opportune_failure() == true or context:mission_result_failure() == true or context:mission_result_critial_failure() == true then
		if target:is_null_interface() == false then
			Give_Trait(target, "wh2_main_trait_agent_target_fail");
		end
	end
end

-----------------------
---- DENIES SKAVEN ----
-----------------------
events.CharacterTurnStart[#events.CharacterTurnStart+1] =
function (context)
	local character = context:character();
	if character:has_region() and character:region():religion_proportion("wh2_main_religion_skaven") >= 0.5 then
		local skaven_points = 0;
		skaven_points = skaven_points + character:trait_points("wh2_main_trait_agent_actions_against_skaven");
		skaven_points = skaven_points + character:trait_points("wh2_main_trait_defeats_against_skaven");
		skaven_points = skaven_points + character:trait_points("wh2_main_trait_reinforcing_skaven");
		skaven_points = skaven_points + character:trait_points("wh2_main_trait_wins_against_skaven");
		
		if skaven_points < 1 then
			Give_Trait(character, "wh2_main_trait_corrupted_skaven");
		end
	end
end

function RemoveSkavenFromCharacterAndForce(character)
	Remove_Trait(character, "wh2_main_trait_corrupted_skaven");
	
	if character:has_military_force() == true then
		local force = character:military_force();
		local force_characters = force:character_list();
		
		for i = 0, force_characters:num_items() - 1 do
			local force_character = force_characters:item_at(i);
			Remove_Trait(force_character, "wh2_main_trait_corrupted_skaven");
		end
	end
end

-------------------------------
---- IN REGION WITH SLAVES ----
-------------------------------
events.CharacterTurnStart[#events.CharacterTurnStart+1] =
function (context)
	local character = context:character();
	
	if character:has_region() and character:in_settlement() then 
		local region = character:region();

		if region:has_faction_province_slaves() and region:percentage_faction_province_slaves() > 99 and region:num_faction_province_slaves() >= 300 then
			Give_Trait(character, "wh2_main_trait_slaver");
		end
	end
end

-----------------------------
---- AGENT ACTION TRAITS ----
-----------------------------
events.CharacterCharacterTargetAction[#events.CharacterCharacterTargetAction+1] =
function (context)
	if context:mission_result_critial_success() or context:mission_result_success() then
		local trait_key = ACTION_TO_TRAIT[ACTION_KEY_TO_ACTION[context:agent_action_key()]];
		if trait_key ~= nil then
			Give_Trait(context:character(), trait_key);
		end
	end
end

events.CharacterGarrisonTargetAction[#events.CharacterGarrisonTargetAction+1] =
function (context)
	if context:mission_result_critial_success() or context:mission_result_success() then
		local trait_key = ACTION_TO_TRAIT[ACTION_KEY_TO_ACTION[context:agent_action_key()]];
		if trait_key ~= nil then
			Give_Trait(context:character(), trait_key);
		end
	end
end

---------------------------------
---- SETTRA FACTION TREASURY ----
---------------------------------
events.CharacterTurnStart[#events.CharacterTurnStart+1] =
function (context)
	local character = context:character();
	
	if character:character_subtype("wh2_dlc09_tmb_settra") then
		local money = character:faction():treasury();
		
		if character:trait_points("wh2_dlc09_trait_settra_title") == 0 and money >= 50000 then
			Give_Trait(character, "wh2_dlc09_trait_settra_title", 2);
		elseif character:trait_points("wh2_dlc09_trait_settra_title") == 1 and money >= 100000 then
			Give_Trait(character, "wh2_dlc09_trait_settra_title");
		elseif character:trait_points("wh2_dlc09_trait_settra_title") == 2 and money >= 200000 then
			Give_Trait(character, "wh2_dlc09_trait_settra_title");
		end
	end
end

-------------------------------
---- SWORD OF KHAINE CURSE ----
-------------------------------
events.CharacterTurnStart[#events.CharacterTurnStart+1] =
function (context)
	local character = context:character();
	
	if character:has_ancillary("wh2_dlc10_anc_weapon_the_widowmaker_3") then
		if character:faction():has_effect_bundle("wh2_sword_of_khaine_3") then
			Give_Trait(character, "wh2_dlc10_trait_sword_of_khaine");
		end
	end
end

--------------------------------------------------------------
----------------------- SAVING / LOADING ---------------------
--------------------------------------------------------------
cm:add_saving_game_callback(
	function(context)
		cm:save_named_value("TRAIT_LORDS_RECORDS", TRAIT_LORDS_RECORDS, context);
	end
);

cm:add_loading_game_callback(
	function(context)
		TRAIT_LORDS_RECORDS = cm:load_named_value("TRAIT_LORDS_RECORDS", {}, context);
	end
);