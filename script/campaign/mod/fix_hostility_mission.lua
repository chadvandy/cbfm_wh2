function fix_hostility_mission()
   core:add_listener(
        "fix_hostility_mission_PooledResourceEffectChangedEvent", 
        "PooledResourceEffectChangedEvent",
        function(context)
            local faction = context:faction();
            local resource = context:resource();
            return resource:key() == "emp_wanted" and faction:name() == "wh2_dlc13_emp_the_huntmarshals_expedition" and resource:value() >= 20;
        end,
        function(context)
            core:trigger_event("ScriptEventWantedLevel2Reached")
        end,
        true
    )
end

--[[
function start_early_game_raise_wanted_level_mission_listener(advice_key, infotext, mission_key, current_wanted_level, target_wanted_level, mission_issuer, mission_rewards)
	
	if not is_string(advice_key) then
		script_error("ERROR: start_early_game_raise_wanted_level_mission_listener() called but supplied advice key [" .. tostring(advice_key) .. "] is not a string");
		return false;
	end;
	
	-- default infotext value
	if not infotext then
		infotext = {
			"wh2.camp.advice.ruins.info_001",		-- create default infotext
			"wh2.camp.advice.ruins.info_002",
			"wh2.camp.advice.ruins.info_003"
		};
	end;
	
	if not is_table(infotext) then
		script_error("ERROR: start_early_game_raise_wanted_level_mission_listener() called but supplied infotext [" .. tostring(infotext) .. "] is not a table or nil");
		return false;
	end;
	
	if not is_string(mission_key) then
		script_error("ERROR: start_early_game_raise_wanted_level_mission_listener() called but supplied mission key [" .. tostring(mission_key) .. "] is not a string");
		return false;
	end;
	
	if not is_number(current_wanted_level) then
		script_error("ERROR: start_early_game_raise_wanted_level_mission_listener() called but supplied turn_number [" .. tostring(current_wanted_level) .. "] is not a number or nil");
		return false;
	end;
	
	if not is_number(target_wanted_level) then
		script_error("ERROR: start_early_game_raise_wanted_level_mission_listener() called but supplied turn_number [" .. tostring(target_wanted_level) .. "] is not a number or nil");
		return false;
	end;
	
	if mission_issuer and not is_string(mission_issuer) then
		script_error("ERROR: start_early_game_raise_wanted_level_mission_listener() called but supplied mission issuer [" .. tostring(mission_issuer) .. "] is not a string or nil");
		return false;
	end;
	
	if not mission_rewards then
		mission_rewards = {"money 1000"};
	end;
	
	if not is_table(mission_rewards) then
		script_error("ERROR: start_early_game_raise_wanted_level_mission_listener() called but supplied mission rewards [" .. mission_rewards .. "] is not a table");
		return false;
	end;
	
	if #mission_rewards == 0 then
		script_error("ERROR: start_early_game_raise_wanted_level_mission_listener() called but supplied mission rewards table is empty");
		return false;
	end;
	
	for i = 1, #mission_rewards do
		if not is_string(mission_rewards[i]) then
			script_error("ERROR: start_early_game_raise_wanted_level_mission_listener() called but supplied mission reward [" .. i .. "] is [" .. tostring(mission_rewards[i]) .. "] and not a string");
			return false;
		end;
	end;
	
		
	-- affects how prominently this advice will be delivered based on advice level/history
	-- possible values:
	-- EARLY_GAME_ADVICE_VOICED_BY_LEGENDARY_LORD		| advice voiced by LL, relax criteria for showing it
	-- EARLY_GAME_ADVICE_SPECIFIC_TO_FACTION			| advice voiced by advisor, string is different for different factions
	-- EARLY_GAME_ADVICE_SHARED							| advice voiced by advisor, but string is shared between factions
	local advice_mode = EARLY_GAME_ADVICE_VOICED_BY_LEGENDARY_LORD;
	
	-- set up mission
	local mm = mission_manager:new(
		cm:get_local_faction(), 
		mission_key,
		function() core:trigger_event("ScriptEventEGRaiseWantedLevelMissionSucceeded") end 			-- success
	);
	
	mm:add_new_scripted_objective(
		"mission_text_text_mis_raise_wanted_level_objective", 
		"PooledResourceEffectChangedEvent", --ScriptEventWantedLevel2Reached
        function(context)
            local faction = context:faction();
            local resource = context:resource();
            return resource:key() == "emp_wanted" and faction:name() == "wh2_dlc13_emp_the_huntmarshals_expedition" and resource:value() >= target_wanted_level;
        end
    );
	
	if mission_issuer then
		mm:set_mission_issuer(mission_issuer);
	end;
	
	-- mm:add_condition("region " .. region_key);			-- don't specify a target region, so the mission succeeds no matter which ruins are searched
	for i = 1, #mission_rewards do
		mm:add_payload(mission_rewards[i]);
	end
	
	local event_name = "early_game_recruit_hunter_mission_issued";
	
	-- pre-declare the intervention variable, so that it exists as a local for the subsequent function
	local in_eg_raise_wanted_level_mission = false;
	
	-- intervention trigger function
	local function in_eg_raise_wanted_level_mission_trigger()
		out.design("[EG] start_early_game_recruit_hunter_mission_listener() is triggering mission, advice level is " .. core:get_advice_level());
		
		local delivery_mode, delivery_mode_str = early_game_decide_content_delivery_mode(advice_mode, advice_key);
		
		out.design("\t" .. delivery_mode_str);
		
		-- override delivery_mode to only show the mission for now
		delivery_mode = EARLY_GAME_SHOW_MISSION_ONLY;
		
		if delivery_mode == EARLY_GAME_SHOW_MISSION_ONLY then
			out.design("\tjust issuing mission");
			
			set_early_game_event_experienced(event_name, true);
			--mm:trigger(function() in_eg_raise_wanted_level_mission:complete() end);
			mm:trigger();
			cm:callback(function() in_eg_raise_wanted_level_mission:complete() end, 1);
		else
			if not early_game_should_show_infotext(advice_mode, advice_key, event_name) then
				out.design("\tnot showing infotext");
				infotext = {};
			end;
			
			out.design("\tplaying advice with mission");
			in_eg_raise_wanted_level_mission:play_advice_for_intervention(
				advice_key,
				infotext,
				mm
			);
			
		end;
	end;
	
	-- set up intervention	
	in_eg_raise_wanted_level_mission = intervention:new(
		"eg_raise_wanted_level_mission", 										-- string name
		70,	 																	-- cost
		function() in_eg_raise_wanted_level_mission_trigger() end,					-- trigger callback
		BOOL_INTERVENTIONS_DEBUG	 											-- show debug output
	);
	
	in_eg_raise_wanted_level_mission:set_disregard_cost_when_triggering(true);
	
	in_eg_raise_wanted_level_mission:add_precondition(
		function()
			return not get_early_game_event_experienced(event_name, true);
		end
	);
		
	-- trigger at the start of the specified turn if it's not been triggered already
	in_eg_raise_wanted_level_mission:add_trigger_condition(
		"ScriptEventPlayerFactionTurnStart",
		function(context)
			if context:faction():name() == "wh2_dlc13_emp_the_huntmarshals_expedition" and context:faction():is_human() == true then
				local pooled_resources = context:faction():pooled_resources();
				
				for i = 0, pooled_resources:num_items() - 1 do
					local current_pr = pooled_resources:item_at(i);
					if current_pr:key() == "emp_wanted" then
						if current_pr:value() >= current_wanted_level then
							return true;
						end;
					end;
					
				end;
			end;
		end
	);
	
	in_eg_raise_wanted_level_mission:start();
	
end;
--]]