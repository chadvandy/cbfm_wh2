cm:add_first_tick_callback(function()
    if cm:is_multiplayer() then

        core:add_listener(
            "Bret_CharacterEntersGarrison",
            "CharacterEntersGarrison",
            true,
            function(context) Bret_RepanseSupplies(context:character()) end,
            true
        );
        core:add_listener(
            "Bret_CharacterTurnStart",
            "CharacterTurnStart",
            true,
            function(context) Bret_RepanseSupplies(context:character()) end,
            true
        );
        
    end
end)