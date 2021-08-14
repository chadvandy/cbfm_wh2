local grom_faction_key = "wh2_dlc15_grn_broken_axe"
local occupation_option_ids = {"691", "701", "707", "716"} --Colonise, Loot & Occupy, Occupy, Raze

function fix_grom_story()
    --search for the Yvresse block listener
    for event_name, listeners in pairs(core.event_listeners) do
		for i = #listeners, 1, -1 do
			if listeners[i].name == "Yvresse_block_listerner_for_player" then
				--remove original Yvresse block listener
                core:remove_listener("Yvresse_block_listerner_for_player")
                --listener to find and disable occupation for Yvresse
                core:add_listener(
                    "Yvresse_block_listerner_for_player",
                    "PanelOpenedCampaign",
                    function(context)		
                        return context.string == "settlement_captured" 
                    end,
                    function(context)  
                        local faction = cm:model():world():whose_turn_is_it()
                        if not faction:is_null_interface() and faction:is_human() and faction:name() == grom_faction_key then
                            --check if this is yvresse
                            local settlement_name_uic = find_uicomponent(core:get_ui_root(), "settlement_captured", "header_docker", "panel_subtitle", "settlement_name")
                            local yvresse_loc_string = effect.get_localised_string("regions_battle_name_".."wh2_main_vor_northern_yvresse_tor_yvresse")
                            if is_uicomponent(settlement_name_uic) and yvresse_loc_string == settlement_name_uic:GetStateText() then
                                for i = 1, #occupation_option_ids do
                                    local current_id = occupation_option_ids[i]
                                    local frame = find_uicomponent(core:get_ui_root(), "settlement_captured", current_id)
                                    if frame then
                                        local button = find_uicomponent(core:get_ui_root(), "settlement_captured", tostring(current_id), "option_button")
                                        button:SetState("inactive")  
                                    end
                                end
                            end
                        end
                    end,
                true
                )
			end
		end
	end
end