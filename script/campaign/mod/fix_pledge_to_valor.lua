local vow_lords = {
	-- Chaos
	["chs_archaon"] = "wh_dlc07_trait_brt_grail_vow_untaint_pledge",
	["chs_kholek_suneater"] = "wh_dlc07_trait_brt_grail_vow_untaint_pledge",
	["chs_prince_sigvald"] = "wh_dlc07_trait_brt_grail_vow_untaint_pledge",
	["chs_lord_of_change"] = "wh_dlc07_trait_brt_grail_vow_untaint_pledge",
	-- Skaven
	["wh2_dlc09_skv_tretch_craventail"] = "wh_dlc07_trait_brt_grail_vow_untaint_pledge",
	["wh2_dlc12_skv_ikit_claw"] = "wh_dlc07_trait_brt_grail_vow_untaint_pledge",
	["wh2_dlc14_skv_deathmaster_snikch"] = "wh_dlc07_trait_brt_grail_vow_untaint_pledge",
	["wh2_main_skv_lord_skrolk"] = "wh_dlc07_trait_brt_grail_vow_untaint_pledge",
	["wh2_main_skv_queek_headtaker"] = "wh_dlc07_trait_brt_grail_vow_untaint_pledge",
	["wh2_dlc16_skv_throt_the_unclean"] = "wh_dlc07_trait_brt_grail_vow_untaint_pledge",
	-- Vampire Counts
	["dlc04_vmp_helman_ghorst"] = "wh_dlc07_trait_brt_grail_vow_untaint_pledge",
	["dlc04_vmp_vlad_con_carstein"] = "wh_dlc07_trait_brt_grail_vow_untaint_pledge",
	["pro02_vmp_isabella_von_carstein"] = "wh_dlc07_trait_brt_grail_vow_untaint_pledge",
	["vmp_heinrich_kemmler"] = "wh_dlc07_trait_brt_grail_vow_untaint_pledge",
	["vmp_mannfred_von_carstein"] = "wh_dlc07_trait_brt_grail_vow_untaint_pledge",
	["wh_dlc05_vmp_red_duke"] = "wh_dlc07_trait_brt_grail_vow_untaint_pledge",
	-- Vampire Coast
	["wh2_dlc11_cst_aranessa"] = "wh_dlc07_trait_brt_grail_vow_untaint_pledge",
	["wh2_dlc11_cst_cylostra"] = "wh_dlc07_trait_brt_grail_vow_untaint_pledge",
	["wh2_dlc11_cst_harkon"] = "wh_dlc07_trait_brt_grail_vow_untaint_pledge",
	["wh2_dlc11_cst_noctilus"] = "wh_dlc07_trait_brt_grail_vow_untaint_pledge",
	-- Beastmen
	["dlc03_bst_khazrak"] = "wh_dlc07_trait_brt_questing_vow_protect_pledge",
	["dlc03_bst_malagor"] = "wh_dlc07_trait_brt_questing_vow_protect_pledge",
	["dlc05_bst_morghur"] = "wh_dlc07_trait_brt_questing_vow_protect_pledge",
	["wh2_dlc17_bst_taurox"] = "wh_dlc07_trait_brt_questing_vow_protect_pledge",
	-- Greenskin
	["grn_grimgor_ironhide"] = "wh_dlc07_trait_brt_questing_vow_protect_pledge",
	["grn_azhag_the_slaughterer"] = "wh_dlc07_trait_brt_questing_vow_protect_pledge",
	["dlc06_grn_skarsnik"] = "wh_dlc07_trait_brt_questing_vow_protect_pledge",
	["dlc06_grn_wurrzag_da_great_prophet"] = "wh_dlc07_trait_brt_questing_vow_protect_pledge",
	["wh2_dlc15_grn_grom_the_paunch"] = "wh_dlc07_trait_brt_questing_vow_protect_pledge",
	-- Dark Elves
	["wh2_main_def_malekith"] = "wh_dlc07_trait_brt_questing_vow_protect_pledge",
	["wh2_main_def_morathi"] = "wh_dlc07_trait_brt_questing_vow_protect_pledge",
	["wh2_dlc10_def_crone_hellebron"] = "wh_dlc07_trait_brt_questing_vow_protect_pledge",
	["wh2_dlc11_def_lokhir"] = "wh_dlc07_trait_brt_questing_vow_protect_pledge",
	["wh2_dlc14_def_malus_darkblade"] = "wh_dlc07_trait_brt_questing_vow_protect_pledge",
	["wh2_twa03_def_rakarth"] = "wh_dlc07_trait_brt_questing_vow_protect_pledge"
} --:map<string, string>

function fix_pledge_to_valor()
	core:remove_listener("character_convalesced_or_killed_grail_vow")
	core:add_listener(
		"character_convalesced_or_killed_grail_vow",
		"CharacterConvalescedOrKilled",
		true,
		function(context)
			local character = context:character()		
			if character:is_null_interface() == false and character:character_type("general") == true and character:has_military_force() == true and character:military_force():is_armed_citizenry() == false then
				local dead_subtype = character:character_subtype_key()
				local dead_character_vow = vow_lords[dead_subtype]
				local pending_battle = cm:model():pending_battle()			
				if cm:pending_battle_cache_attacker_victory() == true then
					for i = 1, cm:pending_battle_cache_num_attackers() do
						local char_cqi, mf_cqi, faction_name = cm:pending_battle_cache_get_attacker(i)
						local attacker = cm:model():character_for_command_queue_index(char_cqi)					
						if attacker:is_null_interface() == false and attacker:faction():culture() == "wh_main_brt_bretonnia" then
							for j = 1, cm:pending_battle_cache_num_defenders() do
								local defender_cqi = cm:pending_battle_cache_get_defender(j)
								if character:command_queue_index() == defender_cqi -- check if the wounded/killed char actually participated in the battle
								and character:faction() ~= attacker:faction() then -- confederation edge case
									add_vow_progress(attacker, "wh_dlc07_trait_brt_grail_vow_valour_pledge", false, true) 
								end
							end
						end
						if dead_character_vow ~= nil then
							add_vow_progress(attacker, dead_character_vow, false, true)
						end
					end
				else
					for i = 1, cm:pending_battle_cache_num_defenders() do
						local char_cqi, mf_cqi, faction_name = cm:pending_battle_cache_get_defender(i)
						local defender = cm:model():character_for_command_queue_index(char_cqi)					
						if defender:is_null_interface() == false and defender:faction():culture() == "wh_main_brt_bretonnia" and character:command_queue_index() == char_cqi then
							for j = 1, cm:pending_battle_cache_num_attackers() do
								local attacker_cqi = cm:pending_battle_cache_get_defender(j)
								if character:command_queue_index() == attacker_cqi -- check if the wounded/killed char actually participated in the battle
								and character:faction() ~= defender:faction() then -- confederation edge case
									add_vow_progress(defender, "wh_dlc07_trait_brt_grail_vow_valour_pledge", false, true) 
								end
							end
						end					
						if dead_character_vow ~= nil then
							add_vow_progress(defender, dead_character_vow, false, true)
						end
					end
				end
			end
		end,
		true
	)
end