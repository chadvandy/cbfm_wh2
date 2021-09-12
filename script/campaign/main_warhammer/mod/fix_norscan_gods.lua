core:add_listener(
    "fix_norscan_gods_FactionTurnEnd",
    "FactionTurnEnd",
    function(context)
        return context:faction():subculture() == "wh_main_sc_nor_norsca"
    end,
    function(context) 
        local faction_key = context:faction():name()
        for key, data in pairs(NORSCAN_GODS[faction_key]) do
            Check_God_Favour_Win_Conditions(faction_key, key)
        end
    end,
    true
)