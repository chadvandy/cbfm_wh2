function fix_minor_elven_colonies()
	if cm:is_new_game() then cm:set_saved_value("fix_minor_elven_colonies", true) end

	local minor_elven_colonies = {
		"wh2_main_vor_land_of_the_dervishes_elven_ruins",
		"wh2_main_vor_sea_of_dread_tower_of_the_stars",
		"wh2_main_vor_the_black_coast_arnheim",
		"wh2_main_vor_the_capes_tip_of_lustria"
	} --: vector<string>

	if not cm:get_saved_value("fix_minor_elven_colonies") then
		for _, region_name in pairs(minor_elven_colonies) do
			local ca_region = cm:get_region(region_name)
			if not ca_region:is_null_interface() and not ca_region:is_abandoned() and ca_region:owning_faction():subculture() == "wh_main_sc_brt_bretonnia" then
				local building = ca_region:settlement():primary_slot():building():name()
				local level_string = string.match(building, '_(%d)')
				cm:region_slot_instantly_upgrade_building(ca_region:settlement():primary_slot(), "wh2_main_special_settlement_colony_minor_brt_"..level_string)
			end
		end
		cm:set_saved_value("fix_minor_elven_colonies", true)
	end
end