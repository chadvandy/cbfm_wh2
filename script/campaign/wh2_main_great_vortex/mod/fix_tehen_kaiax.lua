function fix_tehen_kaiax()
    if cm:is_new_game() then
        local faction = cm:get_faction("wh2_dlc12_lzd_cult_of_sotek")
        if faction and faction:home_region() and faction:home_region():name() == "wh2_main_vor_culchan_plains_kaiax" then
            secondary_slot_change(faction:home_region():name(), 0, "wh2_main_lzd_skinks_1")
        end
    end
end