function fix_prisoner_confed()
	local yvresse_faction = cm:get_faction("wh2_main_hef_yvresse")
	local prisoner_cqis = {}
	if yvresse_faction then
		local prisoners = cm:model():prison_system():get_faction_prisoners(yvresse_faction)
		for i = 0, prisoners:num_items() - 1 do
			local prisoner = prisoners:item_at(i)
			table.insert(prisoner_cqis, prisoner:character():command_queue_index())
		end
	end

	core:add_listener(
		"fix_prisoner_FactionJoinsConfederation",
		"FactionJoinsConfederation",
		function (context)
			return context:confederation():name() == "wh2_main_hef_yvresse"
		end,
		function (context)
			local char_list = context:confederation():character_list()
			for i = 0, char_list:num_items() - 1 do
				local char = char_list:item_at(i) 
				for j = 1, #prisoner_cqis do
					if char:command_queue_index() == prisoner_cqis[j] then
						--out("found former prisoner " .. tostring(char:character_subtype_key()))
						cm:stop_character_convalescing(char:command_queue_index())
					end
				end
			end		
		end,
		true
	)
end