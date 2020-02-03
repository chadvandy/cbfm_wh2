cm:add_first_tick_callback(function()
    local f = cm:get_faction("wh_dlc03_bst_beastmen_qb1")
    if f == false or f:is_null_interface() then
        return
    end

    local mads = f:factions_at_war_with()

    if not mads:is_empty() then
        for i = 0, mads:num_items() -1 do
            local f_mad = mads:item_at(i)
             if f_mad:name() ~= "wh2_main_def_hag_graef" then
                cm:force_make_peace(f:name(), f_mad:name())
            end
        end
    end

    cm:force_diplomacy("all", "faction:wh_dlc03_bst_beastmen_qb1", "all", false, false, true)
    cm:force_diplomacy("faction:wh_dlc03_bst_beastmen_qb1", "all", "all", false, false, true)
end)