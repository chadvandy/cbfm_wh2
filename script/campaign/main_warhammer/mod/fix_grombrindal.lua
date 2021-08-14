function fix_grombrindal()
    if cm:is_new_game() then
        local grombrindal_faction = cm:get_faction("wh_main_dwf_dwarfs")
        if grombrindal_faction:has_effect_bundle("wh_pro01_bundle_god_choice_none") then
            local god_choice_first_event = 2
            local effect_bundles = grombrindal_faction:effect_bundles()
            for i = 0, effect_bundles:num_items() - 1 do
                local effect_bundle = effect_bundles:item_at(i)
                if effect_bundle:key() == "wh_pro01_bundle_god_choice_none" then
                    god_choice_first_event = effect_bundle:duration()
                    break
                end
            end
            cm:remove_effect_bundle("wh_pro01_bundle_god_choice_none", "wh_main_dwf_dwarfs")
            cm:apply_effect_bundle("wh_pro01_bundle_god_choice_none", "wh_main_dwf_dwarfs", god_choice_first_event + 1)
        end
    end
end