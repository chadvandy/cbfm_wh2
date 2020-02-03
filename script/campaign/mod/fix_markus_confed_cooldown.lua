local function fix_markus_confed_cooldown()
    core:add_listener(
        "MarkusConfedCooldown",
        "FactionJoinsConfederation",
        function(context)
            return context:confederation():name() == "wh2_dlc13_emp_the_huntmarshals_expedition"
        end,
        function(context)
            local faction = context:confederation()
            local faction_human = faction:is_human()
            local confederation_timeout = 5
            
            if not faction_human then
                confederation_timeout = 10
            end

            out("Restricting confederation between [faction:wh2_dlc13_emp_the_huntmarshals_expedition] and [subculture:wh_main_sc_emp_empire]")
            cm:force_diplomacy("faction:wh2_dlc13_emp_the_huntmarshals_expedition", "subculture:wh_main_sc_emp_empire", "form confederation", false, true, false);
            cm:add_turn_countdown_event("wh2_dlc13_emp_the_huntmarshals_expedition", confederation_timeout, "ScriptEventConfederationExpired", "wh2_dlc13_emp_the_huntmarshals_expedition");
        end,
        true
    )

end

cm:add_first_tick_callback(function()
    fix_markus_confed_cooldown()
end)