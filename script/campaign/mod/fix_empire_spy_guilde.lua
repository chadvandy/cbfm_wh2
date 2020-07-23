--v function(faction: CA_FACTION)
local function spy_guilde_elven_espionage_reveal_shroud(faction)
	local effect_bundle = "wh2_dlc13_empire_prestige_reward_spy_guild"
	
	local has_effect_bundle = faction:has_effect_bundle(effect_bundle)
	
	local factions_trading_with = faction:factions_trading_with()
	local faction_name = faction:name()
	
	if factions_trading_with:num_items() > 0 then
		if has_effect_bundle then
			cm:apply_effect_bundle(effect_bundle, faction_name, 0)
		end
	
		for i = 0, factions_trading_with:num_items() - 1 do
			local current_faction = factions_trading_with:item_at(i)
			local current_faction_regions = current_faction:region_list()
			
			for j = 0, current_faction_regions:num_items() - 1 do
				local current_region_name = current_faction_regions:item_at(j):name()
				
				cm:make_region_visible_in_shroud(faction_name, current_region_name)
			end
		end
	elseif has_effect_bundle then
		cm:remove_effect_bundle(effect_bundle, faction_name)
	end
end

function fix_empire_spy_guilde()
	-- reveal the shroud on game start
	cm:disable_event_feed_events(true, "", "", "diplomacy_faction_encountered")
	
	local human_factions = cm:get_human_factions()
	
	for i = 1, #human_factions do
		local faction = cm:get_faction(human_factions[i])
		
		if faction:culture() == "wh_main_emp_empire" then
			spy_guilde_elven_espionage_reveal_shroud(faction)
		end
	end
	
	cm:callback(function() cm:disable_event_feed_events(false, "", "", "diplomacy_faction_encountered") end, 1)
	
	-- reveal the shroud on the faction's turn start
	core:add_listener(
		"spy_guilde_elven_espionage_turn_start",
		"FactionTurnStart",
		function(context)
			local faction = context:faction()
			
			return faction:is_human() and faction:culture() == "wh_main_emp_empire"
		end,
		function(context)
			spy_guilde_elven_espionage_reveal_shroud(context:faction())
		end,
		true
	)
	
	-- reveal the shroud when a trade deal is made, if it's the player's turn
	core:add_listener(
		"spy_guilde_elven_espionage_trade_established",
		"TradeRouteEstablished",
		function(context)
			local faction = context:faction()
			
			return faction:is_human() and faction:culture() == "wh_main_emp_empire" and faction == cm:model():world():whose_turn_is_it()
		end,
		function(context)
			spy_guilde_elven_espionage_reveal_shroud(context:faction())
		end,
		true
	)
end