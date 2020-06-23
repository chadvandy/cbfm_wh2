local ACTION_KEY_TO_ACTION = {
	["wh2_dlc15_agent_action_runesmith_assist_army_replenish_troops"] = "Replenish Troops",
    ["wh2_dlc15_agent_action_runesmith_hinder_army_assault_unit"] = "Assault Units",
    ["wh2_dlc15_agent_action_runesmith_hinder_settlement_steal_technology"] = "Steal Technology"
}

local ACTION_TO_TRAIT = {
	["Assassinate"] = "wh2_main_trait_agent_action_assassinate",
	["Assault Garrison"] = "wh2_main_trait_agent_action_assault_garrison",
	["Assault Unit"] = "wh2_main_trait_agent_action_assault_unit",
	["Assault Units"] = "wh2_main_trait_agent_action_assault_units",
	["Block Army"] = "wh2_main_trait_agent_action_block_army",
	["Block Magic"] = "wh2_main_trait_agent_action_block_magic",
	["Cleanse Corruption"] = "wh2_main_trait_agent_action_cleanse_corruption",
	["Damage Building"] = "wh2_main_trait_agent_action_damage_building",
	["Damage Buildings"] = "wh2_main_trait_agent_action_damage_buildings",
	["Damage Walls"] = "wh2_main_trait_agent_action_damage_walls",
	["Demoralise Army"] = "wh2_main_trait_agent_action_demoralise_army",
	["Sabotage"] = "wh2_main_trait_agent_action_sabotage",
	["Spread Plague"] = "wh2_main_trait_agent_action_spread_plague",
	["Storm Garrison"] = "wh2_main_trait_agent_action_storm_garrison",
	["Steal Technology"] = "wh2_main_trait_agent_action_steal_technology",
	["Wound"] = "wh2_main_trait_agent_action_wound",
	["Scout Settlement"] = "wh2_main_trait_agent_action_scout_settlement",
	["Hinder Replenishment"] = "wh2_main_trait_agent_action_hinder_replenishment",
	["Cause Earthquake"] = "wh2_main_trait_agent_action_cause_earthquake"
}

function fix_agent_action_traits()
    -----------------------------
    ---- AGENT ACTION TRAITS ----
    -----------------------------
    events.CharacterCharacterTargetAction[#events.CharacterCharacterTargetAction+1] =
    function (context)
        if context:mission_result_critial_success() or context:mission_result_success() then
            local trait_key = ACTION_TO_TRAIT[ACTION_KEY_TO_ACTION[context:agent_action_key()]];
            if trait_key ~= nil then
                Give_Trait(context:character(), trait_key);
            end
        end
    end

    events.CharacterGarrisonTargetAction[#events.CharacterGarrisonTargetAction+1] =
    function (context)
        if context:mission_result_critial_success() or context:mission_result_success() then
            local trait_key = ACTION_TO_TRAIT[ACTION_KEY_TO_ACTION[context:agent_action_key()]];
            if trait_key ~= nil then
                Give_Trait(context:character(), trait_key);
            end
        end
    end
end