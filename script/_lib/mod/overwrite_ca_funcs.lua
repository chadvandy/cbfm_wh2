local function char_army_has_unit_table(character, unit_table)
    local ret = false
    local mf = nil

    if character:has_military_force() then
        mf = character:military_force():unit_list()
    elseif character:is_embedded_in_military_force() then
        mf = character:embedded_in_military_force():unit_list()
    end
    
    for i = 1, #unit_table do
        local unit_key = unit_table[i]
        if mf:has_unit(unit_key) then
            ret = true
        end
    end

    return ret
end

function char_army_has_unit(character, unit)
    if not character:has_military_force() or not character:is_embedded_in_military_force() then
        return false
    end

	-- allow a table of units to be passed in as a parameter
    if type(unit) == "table" then
        return char_army_has_unit_table(character, unit)
    end
	
	if character:has_military_force() then
		return character:military_force():unit_list():has_unit(unit);
	elseif character:is_embedded_in_military_force() then
		return character:embedded_in_military_force():unit_list():has_unit(unit);
	end;
end