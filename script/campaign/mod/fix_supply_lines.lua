function fix_supply_lines()
    -- apply the effect bundles every time a player's general "dies"
    core:add_listener(
        "fix_supply_lines_character_convalesced_or_killed",
        "CharacterConvalescedOrKilled",
        function(context)
            return context:character():character_type("general") and upkeep_penalty_condition(context:character():faction())
		end,
        function(context)
            local faction = context:character():faction()
            cm:callback(function() 
                apply_upkeep_penalty(faction)
            end, 0.1) 
        end,
        true
    )
    core:remove_listener("disband_player_army_count")
end

function player_army_count_listener()
	-- apply the effect bundles every time the player turn starts
	core:add_listener(
		"player_army_turn_start_listener",
		"FactionTurnStart",
		function(context)
			return upkeep_penalty_condition(context:faction())
		end,
        function(context)
            local faction = context:faction()
            cm:callback(function() 
                apply_upkeep_penalty(faction)
            end, 0.1) 
		end,
		true
	)

	-- apply the effect bundles every time the player creates a new force
	core:add_listener(
		"player_army_created_listener",
		"MilitaryForceCreated",
		function(context)
			return upkeep_penalty_condition(context:military_force_created():faction())
		end,
        function(context)
            local faction = context:military_force_created():faction()
            cm:callback(function() 
                apply_upkeep_penalty(faction)
            end, 0.1) 
		end,
		true
	)
	
	-- apply the effect bundles every time the player confederates
	core:add_listener(
		"confederation_player_army_count_listener",
		"FactionJoinsConfederation",
		function(context)
			return upkeep_penalty_condition(context:confederation())
		end,
        function(context)
            local faction = context:confederation()
            cm:callback(function() 
                apply_upkeep_penalty(faction)
            end, 0.1) 
		end,
		true
	)

	--core:add_listener(
	--	"disband_player_army_count",
	--	"UnitDisbanded",
	--	function(context)
	--		local unit = context:unit()
	--		local has_unit_commander = unit:has_unit_commander()
    --
	--		return has_unit_commander == true and upkeep_penalty_condition(unit:faction())
	--	end,
	--	function(context)
	--		local unit = context:unit()
	--		apply_upkeep_penalty(unit:faction())
	--	end,
	--	true
	--)
end