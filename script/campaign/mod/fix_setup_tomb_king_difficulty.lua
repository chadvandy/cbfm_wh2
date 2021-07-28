local tomb_king_difficulty_modifiers = {
	["HUMAN"] = {
		["easy"] = "wh2_dlc09_tomb_king_difficulty_player_easy",
		["normal"] = "wh2_dlc09_tomb_king_difficulty_player_normal",
		["hard"] = "wh2_dlc09_tomb_king_difficulty_player_hard",
		["very hard"] = "wh2_dlc09_tomb_king_difficulty_player_very_hard",
		["legendary"] = "wh2_dlc09_tomb_king_difficulty_player_legendary"
	},
	["AI"] = {
		["easy"] = "wh2_dlc09_tomb_king_difficulty_AI_easy",
		["normal"] = "wh2_dlc09_tomb_king_difficulty_AI_normal",
		["hard"] = "wh2_dlc09_tomb_king_difficulty_AI_hard",
		["very hard"] = "wh2_dlc09_tomb_king_difficulty_AI_very_hard",
		["legendary"] = "wh2_dlc09_tomb_king_difficulty_AI_legendary"
	},
	-- Faction Specific
	["wh2_dlc09_tmb_the_sentinels"] = "wh2_main_negative_research_speed_50"
}

local difficulty_settings = {
	"easy",
	"normal",
	"hard",
	"very hard",
	"legendary"
}

function setup_tomb_king_difficulty_modifiers()
	local faction_list = cm:model():world():faction_list();
	
	for i = 0, faction_list:num_items() - 1 do
		local faction = faction_list:item_at(i);
		
		if faction:culture() == "wh2_dlc09_tmb_tomb_kings" then
			local fac_type = "AI";
			local difficulty_str = cm:get_difficulty(true);
			
			if faction:is_human() then
				fac_type = "HUMAN";
			else
				-- No crafting armies or ROR for AI Tomb Kings
				if faction:is_quest_battle_faction() == false and faction:has_effect_bundle("wh2_dlc09_disable_crafting") == false then
					cm:apply_effect_bundle("wh2_dlc09_disable_crafting", faction:name(), 0);
				end
			end
			
			if tomb_king_difficulty_modifiers[faction:name()] ~= nil then
				local difficulty_effect = tomb_king_difficulty_modifiers[faction:name()];
				
				if faction:has_effect_bundle(difficulty_effect) == false then
					cm:apply_effect_bundle(difficulty_effect, faction:name(), 0);
				end
			end
			if tomb_king_difficulty_modifiers[fac_type][difficulty_str] ~= nil and tomb_king_difficulty_modifiers[fac_type][difficulty_str] ~= "" then
				local difficulty_effect = tomb_king_difficulty_modifiers[fac_type][difficulty_str];
				
				if faction:is_quest_battle_faction() == false and faction:has_effect_bundle(difficulty_effect) == false then
                    for _, difficulty in ipairs(difficulty_settings) do 
						local effect_bundle_key = tomb_king_difficulty_modifiers[fac_type][difficulty]
                        if faction:has_effect_bundle(effect_bundle_key) then
                            cm:remove_effect_bundle(effect_bundle_key, faction:name())
                        end
                    end
					cm:apply_effect_bundle(difficulty_effect, faction:name(), 0);
				end
			end
		end
	end
end