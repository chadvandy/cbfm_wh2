--v function(x: number, y: number, cqi: CA_CQI?) --> boolean
local function is_valid_spawn_coordinate(x, y, cqi)
    local is_valid = true
    if is_number(x) and is_number(y) and x ~= -1 and y ~= -1 then
        local faction_list = cm:model():world():faction_list()
        for i = 0, faction_list:num_items() - 1 do
            local current_faction = faction_list:item_at(i)
            local char_list = current_faction:character_list()
            for j = 0, char_list:num_items() - 1 do
                local current_char = char_list:item_at(j)
                if not cqi or cqi ~= current_char:command_queue_index() then
                    if current_char:logical_position_x() == x and current_char:logical_position_y() == y then
                        is_valid = false
                        break
                    end
                end
            end
            if is_valid then
                local region_list = current_faction:region_list()
                for j = 0, region_list:num_items() - 1 do
                    local current_region = region_list:item_at(j)
                    if current_region:settlement():logical_position_x() == x and current_region:settlement():logical_position_y() == y then
                        is_valid = false
                        break
                    end
                end
            end
        end
    else
        is_valid = false
    end
    return is_valid
end

function fix_revitalizing_rite()
    core:remove_listener("snikch_RitualCompletedEvent")
    core:add_listener(
        "fix_snikch_RitualCompletedEvent",
        "RitualCompletedEvent",
        function(context)
            return context:performing_faction():name() == "wh2_main_skv_clan_eshin"
        end,
        function(context)
            local ritual = context:ritual():ritual_key()
            
            if ritual == "wh2_dlc14_rituals_skv_revitalizing" then
                local snikch_interface = context:performing_faction()
                local snikch_cqi = snikch_interface:command_queue_index()
                local snikch_char_list = snikch_interface:character_list()
                local snikch_force_list = snikch_interface:military_force_list()

                for i = 0, snikch_char_list:num_items() - 1 do
                    local snikch_char = snikch_char_list:item_at(i)

                    if ritual == "wh2_dlc14_rituals_skv_revitalizing" then
                        -- return convalescing characters back into action
                        cm:stop_character_convalescing(snikch_char:cqi())
                    end
                end
                for j = 0, snikch_force_list:num_items() - 1 do
                    local snikch_force = snikch_force_list:item_at(j)
                    local unit_list = snikch_force:unit_list()

                    for h = 0, unit_list:num_items() - 1 do
                        local unit = unit_list:item_at(h)
                        -- returns forces to max health
                        cm:set_unit_hp_to_unary_of_maximum(unit, 1)
                    end
                end

                local spawn_offset = 3
                for i = 0, snikch_char_list:num_items() - 1 do
                    local snikch_char = snikch_char_list:item_at(i)
                    if not snikch_char:is_null_interface() and cm:char_is_agent(snikch_char) and not snikch_char:is_embedded_in_military_force() 
                    and not snikch_char:character_type("colonel") and not is_valid_spawn_coordinate(snikch_char:logical_position_x(), snikch_char:logical_position_y(), snikch_char:command_queue_index()) then
                        out("sm0/"..snikch_char:command_queue_index().." | spawnX="..snikch_char:logical_position_x().." | spawnY="..snikch_char:logical_position_y())
                        --local x, y = cm:find_valid_spawn_location_for_character_from_position("wh2_main_skv_clan_eshin", snikch_char:logical_position_x(), snikch_char:logical_position_y(), true)
                        local x, y = cm:find_valid_spawn_location_for_character_from_settlement("wh2_main_skv_clan_eshin", "wh2_main_gnoblar_country_flayed_rock", false, true, spawn_offset) --snikch_char:faction():home_region():name()
                        --local x, y = cm:find_valid_spawn_location_for_character_from_character("wh2_main_skv_clan_eshin", cm:char_lookup_str(snikch_char:command_queue_index()), false, spawn_offset)
                        --while not is_valid_spawn_coordinate(x, y) do
                        --    x, y = cm:find_valid_spawn_location_for_character_from_position("wh2_main_skv_clan_eshin", snikch_char:logical_position_x(), snikch_char:logical_position_y(), true, spawn_offset)
                            spawn_offset = spawn_offset + 1
                        --end
                        out("sm0/"..snikch_char:command_queue_index().." | find_valid_x="..x.." | find_valid_y="..y)
                        if is_valid_spawn_coordinate(x, y, snikch_char:command_queue_index()) then
                            cm:teleport_to(cm:char_lookup_str(snikch_char:command_queue_index()), x, y, true)
                        end
                    end
                end
            end
        end,
        true 
    )
end