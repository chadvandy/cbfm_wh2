function fix_grn_confed_dilemma()
    local greenskin = "wh_main_sc_grn_greenskins"
    core:remove_listener("character_completed_battle_greenskin_confederation_dilemma")
    core:add_listener(
        "character_completed_battle_greenskin_confederation_dilemma",
        "CharacterCompletedBattle",
        true,
        function(context)
            local character = context:character();
            
            if character:won_battle() == true and character:faction():subculture() == greenskin 
            -- cbf faction exceptions 
            and not character:faction():name():find("rebel") and not character:faction():name():find("invasion") and not character:faction():name():find("waaagh") 
            and not character:faction():is_quest_battle_faction() then
                local enemies = cm:pending_battle_cache_get_enemies_of_char(character);
                local enemy_count = #enemies;
                
                if context:pending_battle():night_battle() == true or context:pending_battle():ambush_battle() == true then
                    enemy_count = 1;
                end

                local character_cqi = character:command_queue_index();
                local attacker_cqi, attacker_force_cqi, attacker_name = cm:pending_battle_cache_get_attacker(1);
                local defender_cqi, defender_force_cqi, defender_name = cm:pending_battle_cache_get_defender(1);
                
                if character_cqi == attacker_cqi or character_cqi == defender_cqi then
                    for i = 1, enemy_count do
                        local enemy = enemies[i];
                        
                        if enemy ~= nil and enemy:is_null_interface() == false and enemy:is_faction_leader() == true and enemy:faction():subculture() == greenskin
                        -- cbf faction exceptions 
                        and not enemy:faction():name():find("rebel") and not enemy:faction():name():find("invasion") and not enemy:faction():name():find("waaagh") 
                        and not enemy:faction():is_quest_battle_faction() then
                            if enemy:has_military_force() == true and enemy:military_force():is_armed_citizenry() == false then
                                if character:faction():is_human() == true and enemy:faction():is_human() == false and enemy:faction():is_dead() == false then
                                    -- Trigger dilemma to offer confederation
                                    GREENSKIN_CONFEDERATION_PLAYER = character:faction():name();
                                    cm:trigger_dilemma(GREENSKIN_CONFEDERATION_PLAYER, GREENSKIN_CONFEDERATION_DILEMMA..enemy:faction():name());
                                    --Play_Norsca_Advice("dlc08.camp.advice.nor.confederation.001", norsca_info_text_confederation);
                                elseif character:faction():is_human() == false and enemy:faction():is_human() == false then
                                    -- AI confederation
                                    cm:force_confederation(character:faction():name(), enemy:faction():name());
                                    out.design("###### AI GREENSKIN CONFEDERATION");
                                    out.design("Faction: "..character:faction():name().." is confederating "..enemy:faction():name());
                                end
                            end
                        end
                    end
                end
            end
        end,
        true
    );
end