function add_throt_unlock_ghoritch_listeners()
	out("#### Adding Throt Unlock Ghoritch Listeners ####");
    --local throt_interface = cm:model():world():faction_by_key(throt_faction_key);
    --if throt_interface:is_null_interface() == false then
        core:add_listener(
            "Ghoritch_MissionSucceeded",
            "MissionSucceeded",
            function(context)
                return context:mission():mission_record_key():find("whip_of_domination_stage_4");
            end,
            function(context)
                local throt_faction_cqi = context:faction():command_queue_index();
                local throt = context:faction():faction_leader();
                local throt_cqi = throt:command_queue_index();
                
                -- number Faction cqi
                -- string Agent record key from the unique_agents table 
                -- number The cqi of the target character.
                -- boolean Force agent to spawn even if invalid.
                cm:spawn_unique_agent_at_character(throt_faction_cqi, "wh2_dlc16_skv_ghoritch", throt_cqi, false);
                cm:trigger_incident(context:faction():name(), "wh2_dlc16_incident_skv_ghoritch_arrives", true, false);
            end,
            false
        );
        core:add_listener(
            "Ghoritch_CharacterRankUp",
            "CharacterRankUp",
            function(context)
                local character = context:character();
                return character:character_subtype("wh2_dlc16_skv_throt_the_unclean") and character:rank() >= 5 and not cm:get_saved_value("ghoritch_unlocked")
                and not character:faction():is_human();
            end,
            function(context)
                -- ideally we would care for the edge cases where throt is confederated before this happens so ghoritch appears regardless, but at rank 5 the odds are very low
                local throt_faction_cqi = context:character():faction():command_queue_index();
                -- number Faction cqi
                -- string Agent record key from the unique_agents table
                -- boolean Force agent to spawn even if invalid.
                cm:spawn_unique_agent(throt_faction_cqi, "wh2_dlc16_skv_ghoritch", false);
                cm:set_saved_value("ghoritch_unlocked", true);
                out("#### Ghoritch spawned for Throt ####");		-- re-enable to help with testing
            end,
            false
        );
    --end
end