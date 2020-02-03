function fix_snikch_anc()
    core:add_listener(
        "fix_snikch_anc_MissionSucceeded",
        "MissionSucceeded",
        function(context)
            local mission_key = context:mission():mission_record_key()
            return mission_key == "wh2_dlc14_main_skv_snikch_whirl_of_weeping_blades_stage_1" or mission_key == "wh2_dlc14_vortex_skv_snikch_whirl_of_weeping_blades_stage_1"
        end,
        function(context)
            local faction = context:faction()
            local snikch = faction:faction_leader()
            cm:force_add_ancillary(snikch, "wh2_dlc14_anc_weapon_whirl_of_weeping_blades", true, true)
        end,
        false 
    )
end