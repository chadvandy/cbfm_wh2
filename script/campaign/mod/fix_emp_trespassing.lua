local occupation_option_id = {
	["1799653059"] = "wh2_main_sc_emp_empire_occupation_decision_reinstate_elector",
	["1252885465"] = "wh2_main_sc_emp_empire_occupation_decision_return_to_elector"
} 

core:add_listener(
    "fix_emp_trespassing_CharacterPerformsSettlementOccupationDecision",
    "CharacterPerformsSettlementOccupationDecision",
    function(context)
        local occupation_decision = context:occupation_decision()
        return occupation_option_id[occupation_decision] ~= nil
    end,
    function(context)
        local elector_faction_key = context:garrison_residence():faction():name()
        local mf_cqi = context:character():military_force():command_queue_index()
        cm:set_character_excluded_from_trespassing(context:character(), true)
        --out("fix_emp_trespassing_CharacterPerformsSettlementOccupationDecision/elector_faction_key = "..tostring(elector_faction_key))
        --out("fix_emp_trespassing_CharacterPerformsSettlementOccupationDecision/set_character_excluded_from_trespassing = true/"..tostring(mf_cqi))
        core:add_listener(
            "fix_emp_trespassing_immediate_CharacterFinishedMovingEvent",
            "CharacterFinishedMovingEvent",
            true,
            function(context)
                out("fix_emp_trespassing_immediate_CharacterFinishedMovingEvent")
                core:add_listener(
                    "fix_emp_trespassing_benefactor_CharacterFinishedMovingEvent",
                    "CharacterFinishedMovingEvent",
                    function(context)
                        return context:character():military_force():command_queue_index() == mf_cqi and (context:character():region():is_abandoned() or 
                        (context:character():has_region() and context:character():region():owning_faction():name() ~= elector_faction_key))    
                    end,
                    function(context)
                        cm:set_character_excluded_from_trespassing(context:character(), false)
                        --out("fix_emp_trespassing_benefactor_CharacterFinishedMovingEvent/set_character_excluded_from_trespassing = false/"..tostring(context:character():military_force():command_queue_index()))
                    end,
                    false
                )            
            end,
            false
        )
    end,
    true
)	