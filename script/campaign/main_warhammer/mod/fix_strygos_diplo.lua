function fix_strygos_diplo()
    if cm:is_new_game() then
        local repanse_faction = cm:get_faction("wh2_dlc14_brt_chevaliers_de_lyonesse")
        local rakaph_faction = cm:get_faction("wh2_dlc09_tmb_rakaph_dynasty")
        local strygos_faction = cm:get_faction("wh2_main_vmp_strygos_empire")

        if repanse_faction and rakaph_faction and strygos_faction and not repanse_faction:is_human() and not rakaph_faction:is_human() then
            cm:force_make_peace("wh2_dlc09_tmb_rakaph_dynasty", "wh2_main_vmp_strygos_empire")
        end
    end
end