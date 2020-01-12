if __game_mode ~= __lib_type_campaign then
    return
end

local function kill_all_colonels_for_faction(faction_key)
    local faction_obj = cm:get_faction(faction_key)
    local char_list = faction_obj:character_list()

    for j = 0, char_list:num_items() -1 do
        local char_obj = char_list:item_at(j)

        if char_obj:character_type("colonel") then
            if not char_obj:has_military_force() and not char_obj:is_politician() and not char_obj:has_garrison_residence() then
                cm:kill_character(char_obj:command_queue_index(), true, false)
            end
        end
    end
end

function campaign_manager:set_region_abandoned(region_name)
    if not is_string(region_name) then
        script_error("set_region_abandoned() called, arg sent was not a valid string, aborting!")
        return
    end

    local region = self:get_region(region_name)

    if not is_region(region) then
        script_error("set_region_abandoned() called, but ["..region_name.."] is not a valid region key, aborting!")
        return
    end

    if not region:is_abandoned() then
        local faction_key = region:owning_faction():name()
        
        self.game_interface:set_region_abandoned(region_name)

        self:callback(
            function() 
                kill_all_colonels_for_faction(faction_key)
            end,
            0.1
        )
    end
end