function fix_staff_of_volans()
    -- copied relevant function/listeners from wh_quest.lua so I don't have to override said vanilla file
    
    local alt_quests = {};

    --adds quest chains that do not end in a quest battle to a list, the chains final mission is listened for and upon completion the reward ancillary is forced upon the target character
    local function add_to_alt_quests(ancillary_key, final_mission_key, character_subtype)
        local alt_quest_entry = {mis = final_mission_key, anc = ancillary_key, cha = character_subtype};
        table.insert(alt_quests, alt_quest_entry);
    end

    add_to_alt_quests("wh_main_anc_arcane_item_staff_of_volans", "wh_main_emp_balthasar_gelt_staff_of_volans_stage_4", "emp_balthasar_gelt")

    core:add_listener(
		"cbf_quest_item_listerner",
		"MissionSucceeded",
		true,
		function(context) 
			for i = 1, #alt_quests do
				if context:mission():mission_record_key() == alt_quests[i].mis then
					local character_list = context:faction():character_list();
					for j = 0, character_list:num_items() -1 do
						if character_list:item_at(j):character_subtype_key() == alt_quests[i].cha then
							cm:callback(
								function() 
									cm:force_add_ancillary(character_list:item_at(j), alt_quests[i].anc, true, true);
								end, 
								0.5);
							return true;
						end
					end
				end
			end
		end,
		true	
	);
	core:add_listener(
		"cbf_quest_item_listerner",
		"MissionCancelled",
		true,
		function(context) 
			for i = 1, #alt_quests do
				if context:mission():mission_record_key() == alt_quests[i].mis then
					local character_list = context:faction():character_list();
					for j = 0, character_list:num_items() -1 do
						if character_list:item_at(j):character_subtype_key() == alt_quests[i].cha then
							cm:force_add_ancillary(character_list:item_at(j), alt_quests[i].anc, true, false);
							return true;
						end
					end
				end
			end
		end,
		true	
	);
end