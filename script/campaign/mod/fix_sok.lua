function fix_sok()
	core:remove_listener("SwordRegionOccupied")
	core:add_listener(
		"SwordRegionOccupied",
		"CharacterPerformsSettlementOccupationDecision",
		function(context)
			local region = context:garrison_residence():region():name()

			if(Sword_region_key == region) then
				return true
			end
			return false
		end,
		function(context)
			-- This fixes a bug caused by occupation sometimes returning the previous occupants building list, resulting in the sword button being active without the building being owned.
			-- This event is triggered after CharacterEntersGarrison which was previously handling this, and seems to give the game enough time to update the building list correctly/consistently.
			local region = context:garrison_residence():region()
			if region:is_abandoned() then
				if Sword_owner["character_cqi"] == nil then
					Sword_owner["faction"] = nil
				end
				Sword_owner["ready"] = false
				Set_sword_button_state()
			elseif Sword_building_super_chain_check() == false then
				Sword_owner["ready"] = false
				Set_sword_button_state()
			elseif Sword_owner["faction"] == region:faction():name() then
				Sword_owner["ready"] = true
				Set_sword_button_state()
			end
			Handle_vfx(Sword_owner["character_cqi"], true)	
		end,
		true
	)
end