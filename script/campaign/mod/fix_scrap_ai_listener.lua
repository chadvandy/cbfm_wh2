local faction_exclusive_available = {
    "wh2_dlc15_grn_bonerattlaz", "wh_main_grn_crooked_moon", "wh_main_grn_greenskins", "wh_main_grn_orcs_of_the_bloody_hand"
};

local faction_exclusive_upgrade_index = {
    ["wh2_dlc15_grn_bonerattlaz"] = "wh2_dlc15_grn_upgrade_sorcery_weapon",
    ["wh_main_grn_crooked_moon"] = "wh2_dlc15_grn_upgrade_fungus_flask",
    ["wh_main_grn_greenskins"] = "wh2_dlc15_grn_upgrade_immortual_armour",
    ["wh_main_grn_orcs_of_the_bloody_hand"] = "wh2_dlc15_grn_upgrade_idol_of_gork"
};

local Greenskin_subc = "wh_main_sc_grn_greenskins";

--this defines the interval we check and apply upgrade to AI
local cooldown = 10

function fix_scrap_ai_listener()
    core:remove_listener("turn_start_upgrade_units")
    -- Automatically Upgrade AI Units at set intervals
    core:add_listener(
        "cbf_turn_start_upgrade_units",
        "FactionTurnStart",
        function(context)
            return context:faction():subculture() == Greenskin_subc and context:faction():is_human() == false;
        end,
        function(context)
            local turn = cm:model():turn_number();
            local grn_interface = context:faction();
            local grn_force_list = grn_interface:military_force_list();
            if turn % cooldown == 0 then 
                for l = 1, #faction_exclusive_available do
                    --Fix by Agemouk
                    --changed-- if grn_interface ~= faction_exclusive_available[l] then 
                    --to--      if grn_interface:name() ~= faction_exclusive_available[l] then
                    if grn_interface:name() ~= faction_exclusive_available[l] then
                        cm:faction_set_unit_purchasable_effect_lock_state(context:faction(), faction_exclusive_upgrade_index[faction_exclusive_available[l]], "", true);
                    end
                end
                for i = 0, grn_force_list:num_items() - 1 do
                    local grn_force = grn_force_list:item_at(i);
                    local unit_list = grn_force:unit_list();
                    
                    for j = 0, unit_list:num_items() - 1 do
                        local unit_interface = unit_list:item_at(j);
                        local unit_purchasable_effect_list = unit_interface:get_unit_purchasable_effects();
                        if unit_purchasable_effect_list:num_items() ~=0 then
                            local rand = cm:random_number(unit_purchasable_effect_list:num_items()) -1;
                            effect_interface = unit_purchasable_effect_list:item_at(rand);
                            -- Upgrade the unit
                            if grn_force:is_armed_citizenry() == false then
                            cm:faction_purchase_unit_effect(context:faction(), unit_interface, effect_interface);
                            end	
                        end	
                    end
                end
            end
        end,
        true
    );
end