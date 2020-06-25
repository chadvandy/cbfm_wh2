function fix_brt_exclusive_traits()
	--------------------------------------
	---- BRT: IN OWNED SETTLEMENT TOO LONG ----
	--------------------------------------
	events.CharacterTurnStart[#events.CharacterTurnStart+1] =
	function (context)
		local character = context:character()	
		if character:faction():is_human() and character:has_region() and character:faction():is_allowed_to_capture_territory() and cm:char_is_general_with_army(character) 
		and character:faction():subculture() == "wh_main_sc_brt_bretonnia" then
			if character:in_settlement() and character:region():public_order() >= 90 and character:military_force():active_stance() ~= "MILITARY_FORCE_ACTIVE_STANCE_TYPE_MUSTER" then
				local char_turns_being_lazy = cm:get_saved_value(tostring(character:command_queue_index()).."_turns_lazy") or 0
				char_turns_being_lazy = char_turns_being_lazy + 1
				
				if char_turns_being_lazy >= 20 then
					Give_Trait(character, "wh_dlc07_trait_brt_lord_bad_lazy")
					cm:set_saved_value(tostring(character:command_queue_index()).."_turns_lazy", 0)
				else
					cm:set_saved_value(tostring(character:command_queue_index()).."_turns_lazy", char_turns_being_lazy)
				end
			else
				cm:set_saved_value(tostring(character:command_queue_index()).."_turns_lazy", 0)
			end
		end
	end

	------------------------
	---- BRT: SIEGE BATTLES FOUGHT ----
	------------------------
	events.CharacterCompletedBattle[#events.CharacterCompletedBattle+1] =
	function (context)
		local character = context:character()
		local side = Get_Character_Side_In_Last_Battle(character)
		local result = "defeat"
		if character:faction():subculture() == "wh_main_sc_brt_bretonnia" and context:pending_battle():seige_battle() == true and context:pending_battle():battle_type() == "settlement_standard" then
			if character:won_battle() == true then
				--"victory"
				Give_Trait(character, "wh_dlc07_trait_brt_lord_good_sieging")
			else
				--"defeat"
				Give_Trait(character, "wh_dlc07_trait_brt_lord_bad_sieging")
			end
		end
	end
end

-- more unused (old) traitss
--local old_traits = {
--    "wh_dlc07_trait_brt_lord_bad_scared_of_beastmen",
--    "wh_dlc07_trait_brt_lord_bad_scared_of_chaos",
--    "wh_dlc07_trait_brt_lord_bad_scared_of_greenskins",
--    "wh_dlc07_trait_brt_lord_bad_scared_of_vampires",
--    "wh_dlc07_trait_brt_lord_good_beastmen",
--    "wh_dlc07_trait_brt_lord_good_chaos",
--    "wh_dlc07_trait_brt_lord_good_greenskins",
--    "wh_dlc07_trait_brt_lord_good_vampires",
--    "wh_dlc07_trait_brt_lord_good_defeated_archaon",
--    "wh_dlc07_trait_brt_lord_good_defeated_grimgor",
--    "wh_dlc07_trait_brt_lord_good_defeated_khazrak",
--    "wh_dlc07_trait_brt_lord_good_defeated_manfred"
--}