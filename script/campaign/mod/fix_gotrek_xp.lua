core:add_listener(
    "fix_gotrek_xp_CharacterCreated",
    "CharacterCreated",
    function(context)
        return context:character():character_subtype("wh2_pro08_neu_gotrek")
    end,
    function(context)
        local char_cqi = context:character():command_queue_index()

        cm:callback(function()                
            cm:remove_effect_bundle_from_characters_force("wh2_pro08_gotrek_xp_sharing", char_cqi)
        end, 1)
    end,
    true
)