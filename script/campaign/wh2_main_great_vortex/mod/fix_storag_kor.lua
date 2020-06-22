function fix_storag_kor()
    if cm:is_new_game() then
        cm:transfer_region_to_faction("wh2_main_vor_the_black_flood_storag_kor", "wh2_main_def_hag_graef")
        cm:set_region_abandoned("wh2_main_vor_the_black_flood_storag_kor")
    end
end