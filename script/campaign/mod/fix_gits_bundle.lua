core:add_listener(
    "fix_wh_dlc06_bundle_eight_peaks_defender_FactionJoinsConfederation",
    "FactionJoinsConfederation",
    function(context)
        return context:faction():name() == "wh_main_grn_necksnappers"
    end,
    function(context) 
        local confederator = context:confederation()
        local mf_list = confederator:military_force_list()
        for i = 0, mf_list:num_items() - 1 do  
            local mf = mf_list:item_at(i)
            local char = mf:general_character()
            if char and mf:has_effect_bundle("wh_dlc06_bundle_eight_peaks_defender") then 
                cm:remove_effect_bundle_from_characters_force("wh_dlc06_bundle_eight_peaks_defender", char:command_queue_index())
            end
        end    
    end,
    true
)