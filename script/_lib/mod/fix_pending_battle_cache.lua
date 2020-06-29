if __game_mode ~= __lib_type_campaign then
    return
end

--- @function pending_battle_cache_get_defender_subtype
--- @desc Returns just the subtype of a particular defender in the cached pending battle. The defender is specified by numerical index, with the first being accessible at record 1.
--- @p @number index of defender
--- @return @string subtype
function campaign_manager:pending_battle_cache_get_defender_subtype(index)
	if not is_number(index) or index < 0 or index > #self.pending_battle_cached_defenders then
		script_error("ERROR: pending_battle_cache_get_defender_subtype() called but supplied index [" .. tostring(index) .. "] is out of range");
		return false;
	end;
	
	return false
end;

--- @function pending_battle_cache_get_attacker_subtype
--- @desc Returns just the subtype of a particular attacker in the cached pending battle. The attacker is specified by numerical index, with the first being accessible at record 1.
--- @p @number index of attacker
--- @return @string subtype
function campaign_manager:pending_battle_cache_get_attacker_subtype(index)
	if not is_number(index) or index < 0 or index > #self.pending_battle_cached_attackers then
		script_error("ERROR: pending_battle_cache_get_attacker_subtype() called but supplied index [" .. tostring(index) .. "] is out of range");
		return false;
	end;
	
	return false
end;

-- caches a pending battle character within a pending battle
function campaign_manager:cache_pending_battle_character(list, character)
	local record = {};
	
	record.cqi = character:cqi();
	record.faction_name = character:faction():name();
	
	if character:has_military_force() then
		record.mf_cqi = character:military_force():command_queue_index();
	else
		script_error("WARNING: cache_pending_battle_character() called but supplied character (cqi: [" .. character:cqi() .. "], faction name: [" .. character:faction():name() .. "]) has no military force, how can this be? Not going to add CQI.");
		return;
	end;
	
	table.insert(list, record);
end;

-- called when the game is saving
function campaign_manager:pending_battle_cache_to_string()
	local attackers = self.pending_battle_cached_attackers;
	local defenders = self.pending_battle_cached_defenders;

	-- pack data into strings for saving
	local attacker_str = "";
	for i = 1, #attackers do
		local current_record = attackers[i];
		if current_record.mf_cqi then
			attacker_str = attacker_str .. current_record.cqi .. "," .. current_record.mf_cqi .. "," .. current_record.faction_name .. ";"
		else
			-- support for old savegames with no military force cqi embedded
			attacker_str = attacker_str .. current_record.cqi .. "," .. current_record.faction_name .. ";"
		end;
	end;
	
	local defender_str = "";
	for i = 1, #defenders do
		local current_record = defenders[i];
		if current_record.mf_cqi then
			defender_str = defender_str .. current_record.cqi .. "," .. current_record.mf_cqi .. "," .. current_record.faction_name .. ";"
		else
			-- support for old savegames with no military force cqi embedded
			defender_str = defender_str .. current_record.cqi .. "," .. current_record.faction_name .. ";"
		end;
	end;

	self.pending_battle_cached_attacker_str = attacker_str;
	self.pending_battle_cached_defender_str = defender_str;
end;

function campaign_manager:pending_battle_cache_table_from_string(str)
	local list = {};
	
	local pointer = 1;
	while true do
		local next_separator = string.find(str, ",", pointer);
		
		if not next_separator then
			break;
		end;
		
		local record = {};
		
		local cqi_str = string.sub(str, pointer, next_separator - 1);
		local cqi = tonumber(cqi_str);
		
		if not cqi then
			script_error("ERROR: pending_battle_cache_table_from_string() could not convert character cqi string [" .. tostring(cqi_str) .. "] into a number, inserting -1");
			cqi = -1;
		end;
		
		record.cqi = cqi;
		
		pointer = next_separator + 1;
		next_separator = string.find(str, ",", pointer);
		
		-- temp support for savegames that have no military force cqis embedded
		if next_separator then
			local mf_cqi_str = string.sub(str, pointer, next_separator - 1);
			local mf_cqi = tonumber(mf_cqi_str);
			
			if not mf_cqi then
				script_error("ERROR: pending_battle_cache_table_from_string() could not convert military force cqi string [" .. tostring(mf_cqi_str) .. "] into a number, inserting -1");
				cqi = -1;
			end;
			
			record.mf_cqi = mf_cqi;
			
			pointer = next_separator + 1;
		end;	
		
		next_separator = string.find(str, ";", pointer);
		
		local faction_name = string.sub(str, pointer, next_separator - 1);
		record.faction_name = faction_name;
		
		pointer = next_separator + 1;
		
		table.insert(list, record);
	end;
	
	return list;
end;