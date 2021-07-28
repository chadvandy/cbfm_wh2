core:add_listener(
    "fix_beastmen_panel_opened",
    "PanelOpenedCampaign",
    function(context) 
        return context.string == "beastmen_panel" 
    end,
    function()
        local beastmen_panel_uic = find_uicomponent(core:get_ui_root(), "beastmen_panel")
        beastmen_panel_uic:SetDockOffset(0, 1)
    end,
    true
)