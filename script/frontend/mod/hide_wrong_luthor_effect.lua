-- hide the wrong effects
core:add_listener(
    "HideWrongHarkonEffects",
    "ComponentLClickUp",
    function(context) 
        return context.string == "Luthor Harkon" 
    end, 
    function(context)
        local tm = get_tm()
        tm:callback(function()
            local root = core:get_ui_root()
            local parent = find_uicomponent(root, "sp_grand_campaign", "dockers", "centre_docker", "lord_details_panel", "faction", "faction_traits", "effects", "listview", "list_clip", "list_box")
			if is_uicomponent(parent) then
                find_uicomponent(parent, "lord_effect2"):SetVisible(false)
			end
        end, 50)
    end,
    true
)