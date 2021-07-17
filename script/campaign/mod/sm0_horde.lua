function sm0_horde()
	core:add_listener(
		"sm0_horde_FactionTurnStart",
		"FactionTurnStart",
		function(context)
            return context:faction():subculture() == "wh2_main_sc_lzd_lizardmen" and context:faction():name() ~= "wh2_dlc13_lzd_spirits_of_the_jungle"
		end,
		function(context)
			local character_list = context:faction():character_list()
			for i = 0, character_list:num_items() - 1 do
				local character = character_list:item_at(i)
				if character:has_military_force() and character:military_force():force_type():key() ~= "ARMY" and character:military_force():force_type():key() ~= "OXYOTL" then
					cm:convert_force_to_type(character:military_force(), "ARMY")
				end
			end
		end,
		true
	)
    core:add_listener(
		"sm0_horde_MilitaryForceCreated",
		"MilitaryForceCreated",
		function(context)
            return context:military_force_created():faction():subculture() == "wh2_main_sc_lzd_lizardmen" 
            and context:military_force_created():faction():name() ~= "wh2_dlc13_lzd_spirits_of_the_jungle" 
			and context:military_force_created():force_type():key() ~= "ARMY" and context:military_force_created():force_type():key() ~= "OXYOTL"
		end,
		function(context)
			cm:convert_force_to_type(context:military_force_created(), "ARMY")
		end,
		true
	)
end