function fix_arkhan_beastmen_diplomacy()
    local arkhan_faction = cm:get_faction("wh2_dlc09_tmb_followers_of_nagash")
    if arkhan_faction and arkhan_faction:factions_non_aggression_pact_with("wh2_main_bst_blooded_axe") then
        cm:force_diplomacy("faction:wh2_dlc09_tmb_followers_of_nagash", "faction:wh2_main_bst_blooded_axe", "non aggression pact", true, true, true)
        cm:force_diplomacy("faction:wh2_dlc09_tmb_followers_of_nagash", "faction:wh2_main_bst_blooded_axe", "break non aggression pact", true, true, true)
        core:add_listener(
            "fix_arkhan_beastmen_diplomacy_NegativeDiplomaticEvent",
            "NegativeDiplomaticEvent",
            function(context)
                local proposer = context:proposer()
                local recipient = context:recipient()
                
                return context:was_non_aggression_pact() 
                and (proposer:name() == "wh2_dlc09_tmb_followers_of_nagash" and recipient:name() == "wh2_main_bst_blooded_axe") 
                or (proposer:name() == "wh2_main_bst_blooded_axe" and recipient:name() == "wh2_dlc09_tmb_followers_of_nagash")
            end,
            function(context)
                cm:force_diplomacy("faction:wh2_dlc09_tmb_followers_of_nagash", "faction:wh2_main_bst_blooded_axe", "non aggression pact", false, false, true)
                cm:force_diplomacy("faction:wh2_dlc09_tmb_followers_of_nagash", "faction:wh2_main_bst_blooded_axe", "break non aggression pact", false, false, true)
            end,
            false
        )
    end
end