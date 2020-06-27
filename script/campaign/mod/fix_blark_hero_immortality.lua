--v function() --> CA_CQI
local function get_selected_char_CQI()
    local charCQI = cm:get_campaign_ui_manager():get_char_selected_cqi()
    local char = cm:get_character_by_cqi(charCQI)
    if char:has_military_force() then
        local unitsUIC = find_uicomponent(core:get_ui_root(), "units_panel", "main_units_panel", "units")
        for i = 0, unitsUIC:ChildCount() - 1 do
            local uic_child = UIComponent(unitsUIC:Find(i))
            if uic_child:CurrentState() == "Selected" and string.find(uic_child:Id(), "Agent") then
                local charList = char:military_force():character_list()
                local agentIndex = string.match(uic_child:Id(), "%d")
                local selectedChar = charList:item_at(tonumber(agentIndex))
                charCQI = selectedChar:command_queue_index()
                break
            end     
        end
    end
    return charCQI
end

--v function()
local function set_admiral_immortality_invisible()
    cm:callback(function()
        local selected_char_cqi = get_selected_char_CQI()
        local selected_char = cm:get_character_by_cqi(selected_char_cqi)
        if selected_char:character_subtype("wh2_main_def_black_ark") then
            set_component_visible_with_parent(false, core:get_ui_root(), "character_details_panel", "effects_parent", "campaign_effects_window", "listview", "list_clip", "list_box", "wh2_main_effect_grant_immortality_hero")		
        end
    end, 0.1)
end

-- Having both the hero and the lord immortality effect state in the character effect list of blark admirals is annoying so we hide the former
function fix_blark_hero_immortality()
    core:add_listener(
        "cbf_im_PanelOpenedCampaign",
        "PanelOpenedCampaign",
        function(context)
            return context.string == "character_details_panel"
        end,
        function()
            set_admiral_immortality_invisible()
        end,
        true
    )
    core:add_listener(
        "cbf_im_ComponentLClickUp",
        "ComponentLClickUp",
        function(context)
            local panel = find_uicomponent(core:get_ui_root(), "character_details_panel")
            return (context.string == "button_cycle_right" or context.string == "button_cycle_left") and is_uicomponent(panel)
        end,
        function(context)
            set_admiral_immortality_invisible()		
        end,
        true
    )	
    core:add_listener(
        "cbf_im_ShortcutPressed",
        "ShortcutPressed",
        function(context)
            local panel = find_uicomponent(core:get_ui_root(), "character_details_panel")
            return (context.string == "select_next" or context.string == "select_prev") and is_uicomponent(panel)
        end,
        function(context)
            set_admiral_immortality_invisible()	
        end,
        true
    )
end