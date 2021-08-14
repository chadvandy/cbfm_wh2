local resource_list = {"res_gold", "res_gems", "res_rom_marble"}
local cbf_resource_faction = ""

local resource_locations = {
	["main_warhammer"] = {
		["res_gold"] = {},
		["res_gems"] = {},
		["res_rom_marble"] = {}
	},
	["wh2_main_great_vortex"] = {
		["res_gold"] = {},
		["res_gems"] = {},
		["res_rom_marble"] = {}
	}
}

function fix_book_of_nagash()
	local campaign_key = ""
	
	if cm:model():campaign_name("main_warhammer") then
		campaign_key = "main_warhammer"
	else
		campaign_key = "wh2_main_great_vortex"
	end
	
	local all_regions = cm:model():world():region_manager():region_list()
	
	for i = 0, all_regions:num_items() - 1 do
		local current_region = all_regions:item_at(i)
		local resource_key = ""
		out("add_nagash_books_effects_listeners/current_region:name() = "..current_region:name())

		for k = 0, current_region:slot_list():num_items() - 1 do
			local current_slot = current_region:slot_list():item_at(k)
		
			if current_slot:resource_key() ~= "" then
				out("add_nagash_books_effects_listeners/resource_key = "..tostring(current_slot:resource_key()))
				for l = 1, #resource_list do
					if resource_list[l] == current_slot:resource_key() then
                        resource_key = current_slot:resource_key()
						break
					end
				end
			end
		end
		
		if resource_key ~= "" then
			for j = 1, #resource_list do
				if resource_list[j] == resource_key then
					table.insert(resource_locations[campaign_key][resource_list[j]], current_region:name())
				end
			end
		end
	end

    core:remove_listener("faction_turn_start_tmb_lift_shroud_resource_locations")
    core:add_listener(
        "faction_turn_start_tmb_lift_shroud_resource_locations",
        "ScriptEventHumanFactionTurnStart",
        true,
        function(context)
            local faction = context:faction()
            
            if faction:culture() == "wh2_dlc09_tmb_tomb_kings" then
                local turn_number = cm:model():turn_number()
                
                if faction:has_effect_bundle("wh2_dlc09_books_of_nagash_reward_2") then
                    for i = 1, #resource_list do 
                        for j = 1, #resource_locations[campaign_key][resource_list[i]] do
                            cm:make_region_visible_in_shroud(cbf_resource_faction, resource_locations[campaign_key][resource_list[i]][j])
                        end
                    end
                end
            end
        end,
        true
    )
    core:remove_listener("mission_succeeded_tmb_lift_shroud")
    core:add_listener(
        "mission_succeeded_tmb_lift_shroud",
        "MissionSucceeded",
        true,
        function(context)
            local faction = context:faction()
            
            if faction:culture() == "wh2_dlc09_tmb_tomb_kings" then
                local mission_key = context:mission():mission_record_key()
                local faction_name = context:faction():name()

                if mission_key == "wh2_dlc09_books_of_nagash_2" then
                    cbf_resource_faction = faction_name
                    
                    for i = 1, #resource_list do
                        for j = 1, #resource_locations[campaign_key][resource_list[i]] do
                            cm:make_region_visible_in_shroud(faction_name, resource_locations[campaign_key][resource_list[i]][j])
                        end
                    end
                end
                
                if mission_key == "wh2_dlc09_books_of_nagash_4" then
                    cm:pooled_resource_mod(faction:command_queue_index(), "tmb_canopic_jars", "wh2_main_resource_factor_other", 250)
                    cm:remove_event_restricted_unit_record_for_faction("wh2_dlc09_tmb_mon_necrosphinx_ror", faction_name)
                end
            end
        end,
        true
    )
end

--------------------------------------------------------------
----------------------- SAVING / LOADING ---------------------
--------------------------------------------------------------
cm:add_saving_game_callback(
	function(context)
		cm:save_named_value("cbf_resource_faction", cbf_resource_faction, context)
	end
)

cm:add_loading_game_callback(
	function(context)
		cbf_resource_faction = cm:load_named_value("cbf_resource_faction", "", context)
	end
)