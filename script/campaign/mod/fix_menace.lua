--v function(char: CA_CHAR)
local function update_menace_bundle(char)
    local effect_bundle = "wh2_sm0_bundle_fix_menace_below_"
    local char_cqi = char:command_queue_index()
    local corruption_bonus = false
    local pb = cm:model():pending_battle();
    local defender = pb:defender()
    if defender:has_region() and defender:region():religion_proportion("wh2_main_religion_skaven") >= 0.095 then
        corruption_bonus = true
    end
    out("sm0/corruption_bonus = "..tostring(corruption_bonus))
    local queek_bonus = false
    if char:character_subtype("wh2_main_skv_queek_headtaker") then
        queek_bonus = true
    end
    out("sm0/queek_bonus = "..tostring(queek_bonus))
    if char:military_force():has_effect_bundle("wh2_sm0_bundle_fix_menace_below_plus") then 
        cm:remove_effect_bundle_from_characters_force("wh2_sm0_bundle_fix_menace_below_plus", char_cqi)
    end
    if char:military_force():has_effect_bundle("wh2_sm0_bundle_fix_menace_below_minus") then 
        cm:remove_effect_bundle_from_characters_force("wh2_sm0_bundle_fix_menace_below_minus", char_cqi)
    end
    core:remove_listener("menace_charges_ScriptEventPlayerBattleStarted")
    if not corruption_bonus and not queek_bonus then
        if not char:faction():is_human() or cm:is_multiplayer() then
            cm:apply_effect_bundle_to_characters_force("wh2_sm0_bundle_fix_menace_below_minus", char_cqi, 0, false)
            out("sm0/effect_bundle = wh2_sm0_bundle_fix_menace_below_minus")
        else
            core:add_listener(
                "menace_charges_ScriptEventPlayerBattleStarted",
                "ScriptEventPlayerBattleStarted", 
                true,
                function(context)
                    cm:apply_effect_bundle_to_characters_force("wh2_sm0_bundle_fix_menace_below_minus", char_cqi, 0, false)
                    out("sm0/effect_bundle = wh2_sm0_bundle_fix_menace_below_minus")
                end,
                false
            ) 
        end
    end
    if corruption_bonus and queek_bonus then
        cm:apply_effect_bundle_to_characters_force("wh2_sm0_bundle_fix_menace_below_plus", char_cqi, 0, false)
        out("sm0/effect_bundle = wh2_sm0_bundle_fix_menace_below_plus")
    end
end

core:add_listener(
    "fix_menace_below_monitor",
    "PendingBattle",
    true,
    function()
        local pb = cm:model():pending_battle()
        local defender = pb:defender()
        local attacker = pb:attacker()                      
        if attacker:faction():culture() == "wh2_main_skv_skaven" then
            update_menace_bundle(attacker)
        end
        if defender:faction():culture() == "wh2_main_skv_skaven" then
            update_menace_bundle(defender)
        end
    end,
    true
) 	

core:add_listener(
    "fix_menace_below_cleanup",
    "BattleCompleted",
    function()
        local pb = cm:model():pending_battle()	
        if pb:has_been_fought() then
            local attacker_cqi, attacker_force_cqi, attacker_faction_name = cm:pending_battle_cache_get_attacker(1)
            local defender_cqi, defender_force_cqi, defender_faction_name = cm:pending_battle_cache_get_defender(1)
            local attacker = cm:get_faction(attacker_faction_name)
            local defender = cm:get_faction(defender_faction_name)							
            return (attacker and attacker:culture() == "wh2_main_skv_skaven") or (defender and defender:culture() == "wh2_main_skv_skaven")
        else
            return (pb:has_attacker() and pb:attacker():faction():culture() == "wh2_main_skv_skaven") or (pb:has_defender() and pb:defender():faction():culture() == "wh2_main_skv_skaven")
        end
    end,
    function()			
        local pb = cm:model():pending_battle()	
        if pb:has_attacker() then
            local char = pb:attacker()
            local char_cqi = pb:attacker():command_queue_index()
            if char:military_force():has_effect_bundle("wh2_sm0_bundle_fix_menace_below_plus") then 
                cm:remove_effect_bundle_from_characters_force("wh2_sm0_bundle_fix_menace_below_plus", char_cqi)
            end
            if char:military_force():has_effect_bundle("wh2_sm0_bundle_fix_menace_below_minus") then 
                cm:remove_effect_bundle_from_characters_force("wh2_sm0_bundle_fix_menace_below_minus", char_cqi)
            end
        end	
        if pb:has_defender() then
            local char = pb:defender()
            local char_cqi = pb:defender():command_queue_index()
            if char:military_force():has_effect_bundle("wh2_sm0_bundle_fix_menace_below_plus") then 
                cm:remove_effect_bundle_from_characters_force("wh2_sm0_bundle_fix_menace_below_plus", char_cqi)
            end
            if char:military_force():has_effect_bundle("wh2_sm0_bundle_fix_menace_below_minus") then 
                cm:remove_effect_bundle_from_characters_force("wh2_sm0_bundle_fix_menace_below_minus", char_cqi)
            end			
        end
    end,
    true
)