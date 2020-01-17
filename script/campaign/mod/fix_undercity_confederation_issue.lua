-- fix by Vandy

-- remove any foreign_slot_managers owned by a faction that owns the region, as well
local function add_undercity_confederation_fix()

    -- run this function only on every Lua state change, for player-only
    local function check_owned_regions_for_undercities(faction_key)
        local faction_obj = cm:get_faction(faction_key)
        local region_list = faction_obj:region_list()

        -- loop through owned regions (skip if a horde/regionless)
        if not region_list:is_empty() then
            for i = 0, region_list:num_items() -1 do
                local region = region_list:item_at(i)

                -- grab foreign_slot_manager, the game object for undercities/etc, for the region's owner
                local fsm = region:foreign_slot_manager_for_faction(faction_key)

                -- make sure an fsm exists
                if not fsm:is_null_interface() then
                    cm:remove_faction_foreign_slots_from_region(faction_obj:command_queue_index(), region:cqi())
                end
            end
        end
    end

    local human_factions = cm:get_human_factions()

    for i = 1, #human_factions do
        check_owned_regions_for_undercities(human_factions[i])
    end

    -- remove foreign slots when a region is conquered/confed'd/etc by a faction that has a foreign slot there
    core:add_listener(
        "UndercityConfedFix",
        "FactionJoinsConfederation",
        true,
        function(context)
            local confed_faction = context:confederation():name()
            cm:callback(function()
                check_owned_regions_for_undercities(confed_faction)
            end, 0.5)
        end,
        true
    )
end

cm:add_first_tick_callback(function() add_undercity_confederation_fix() end)