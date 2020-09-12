core:add_listener(
    "fix_gotrek_xp_CharacterCreated",
    "CharacterCreated",
    function(context)
        return context:character():character_subtype("wh2_pro08_neu_gotrek") or context:character():character_subtype("wh2_pro08_neu_felix")
    end,
    function(context)
        local char_cqi = context:character():command_queue_index()

        if context:character():character_subtype("wh2_pro08_neu_gotrek") then
            cm:callback(function()                
                cm:remove_effect_bundle_from_characters_force("wh2_pro08_gotrek_xp_sharing", char_cqi)
            end, 1)
        end
    end,
    true
)