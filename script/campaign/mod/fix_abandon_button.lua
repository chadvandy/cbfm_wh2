core:add_listener(
    "abandon_button_building_browser_PanelOpenedCampaign",
    "PanelOpenedCampaign",
    function(context) 
        return context.string == "building_browser" 
    end,
    function(context)			
        local button_abandon = find_uicomponent(core:get_ui_root(), "building_browser", "options_list", "button_abandon")
        local icon_abandon_settlement_path = effect.get_skinned_image_path("icon_abandon_settlement.png")
        button_abandon:SetImagePath(icon_abandon_settlement_path)
    end,
    true
)