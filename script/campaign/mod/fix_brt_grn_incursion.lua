function fix_brt_grn_incursion()
    if cm:is_multiplayer() then
        core:add_listener(
			"Bret_StartCharacterRazedSettlement",
			"CharacterRazedSettlement",
			true,
			function(context) Bret_StartCharacterRazedSettlement(context) end,
			true
		)
		core:add_listener(
			"Bret_StartCharacterOccupiesSettlement",
			"GarrisonOccupiedEvent",
			true,
			function(context) Bret_StartCharacterRazedSettlement(context) end,
			true
        )
    end
end