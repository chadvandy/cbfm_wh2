local function override_hag_graef_listener()
    local malus_obj = cm:get_faction("wh2_main_def_hag_graef")
    local malekith_obj = cm:get_faction("wh2_main_def_naggarond")

    if not malus_obj:is_null_interface() and malus_obj:is_human() then
        -- remove the vanilla listener
        core:remove_listener("Malus_DilemmaChoiceMadeEvent")
        
        -- add in our own copy with a distance check
        core:add_listener(
            "Malus_DilemmaChoiceMadeEvent2",
            "DilemmaChoiceMadeEvent",
            function(context)
                return context:dilemma() == "wh2_dlc14_malus_start_dilemma"
            end,
            function(context)
                local choice = context:choice()

                if choice == 0 then
                    hag_graef_region_change();	
                    local secondary_army = cm:get_closest_character_to_position_from_faction(malus_faction, 195, 612, true, false);
                    
                    local x, y = secondary_army:logical_position_x(), secondary_army:logical_position_y()

                    local distance = distance_squared(x, y, 195, 612)
                    if distance < 10000 then
                        cm:disable_event_feed_events(true, "wh_event_category_character", "", "");
                        cm:kill_character(secondary_army:command_queue_index(), true, false);
                        cm:disable_event_feed_events(false, "wh_event_category_character", "", "");
                    end
                end
            end,
            true
        )

    end
end

cm:add_first_tick_callback(function()
    override_hag_graef_listener()
end)