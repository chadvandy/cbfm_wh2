---- Black Ark generals cannot get any scripted traits (including defeat LL traits) due to an exclusion writtein into `wh2_campaign_traits.lua`
---- This script overwrites that exclusion function.


-- needed to be here since it's local to the wh2_campaign_traits.lua scropt
local TRAIT_EXCLUSIONS = {
	["culture"] = {
		["wh2_main_trait_corrupted_chaos"] = {"wh_main_chs_chaos", "wh_dlc03_bst_beastmen", "wh2_main_skv_skaven"},
		["wh2_main_trait_corrupted_vampire"] = {"wh_main_vmp_vampire_counts", "wh2_dlc09_tmb_tomb_kings", "wh2_dlc11_cst_vampire_coast"},
		["wh2_main_trait_corrupted_skaven"] = {"wh2_main_skv_skaven", "wh_main_chs_chaos", "wh_dlc03_bst_beastmen"},
		["wh2_main_trait_pacifist"] = {"wh_main_chs_chaos", "wh_dlc03_bst_beastmen"},
		["wh2_main_trait_stance_recruiting"] = {"wh2_dlc09_tmb_tomb_kings"},
		["wh2_main_trait_defeats_against_chaos"] = {"wh_main_chs_chaos"},
		["wh2_main_trait_agent_actions_against_chaos"] = {"wh_main_chs_chaos"},
		["wh2_main_trait_wins_against_chaos"] = {"wh_main_chs_chaos"}
	},
	["subculture"] = {
		["wh2_main_trait_attacking_defeat"] = {"wh_main_sc_brt_bretonnia"},
		["wh2_main_trait_attacking_victory"] = {"wh_main_sc_brt_bretonnia"},
		["wh2_main_trait_builder"] = {"wh_main_sc_brt_bretonnia"},
		["wh2_main_trait_defeats"] = {"wh_main_sc_brt_bretonnia"},
		["wh2_main_trait_defending_defeat"] = {"wh_main_sc_brt_bretonnia"},
		["wh2_main_trait_defending_victory"] = {"wh_main_sc_brt_bretonnia"},
		["wh2_main_trait_far_from_capital"] = {"wh_main_sc_brt_bretonnia"},
		["wh2_main_trait_lazy"] = {"wh_main_sc_brt_bretonnia"},
		["wh2_main_trait_lone_wolf"] = {"wh_main_sc_brt_bretonnia"},
		["wh2_main_trait_post_battle_execute"] = {"wh_main_sc_brt_bretonnia"},
		["wh2_main_trait_post_battle_ransom"] = {"wh_main_sc_brt_bretonnia"},
		["wh2_main_trait_public_order"] = {"wh_main_sc_brt_bretonnia"},
		["wh2_main_trait_razing"] = {"wh_main_sc_brt_bretonnia"},
		["wh2_main_trait_reinforcing"] = {"wh_main_sc_brt_bretonnia"},
		["wh2_main_trait_routed"] = {"wh_main_sc_brt_bretonnia"},
		["wh2_main_trait_sacking"] = {"wh_main_sc_brt_bretonnia"},
		["wh2_main_trait_siege_defeat"] = {"wh_main_sc_brt_bretonnia"},
		["wh2_main_trait_siege_victory"] = {"wh_main_sc_brt_bretonnia"},
		["wh2_main_trait_stance_raiding"] = {"wh_main_sc_brt_bretonnia"},
		["wh2_main_trait_wins"] = {"wh_main_sc_brt_bretonnia"},
		["wh2_main_trait_wins_against_humans"] = {"wh_main_sc_brt_bretonnia"},
		["wh2_main_trait_defeated_louen_leoncouer"] = {"wh_main_sc_brt_bretonnia"}
	},
	["faction"] = {
		["wh2_main_trait_corrupted_chaos"] = {"wh2_main_def_cult_of_pleasure", "wh2_main_def_cult_of_pleasure_separatists", "wh2_dlc13_lzd_spirits_of_the_jungle"},
		["wh2_main_trait_sacking"] = {"wh2_dlc13_lzd_spirits_of_the_jungle"}
	}
};

-- overwrite da vanilla function
function Check_Exclusion(trait, character)
	local char_faction = character:faction();
	local char_culture = char_faction:culture();
	local char_subculture = char_faction:subculture();
	local char_faction_name = char_faction:name();

	local culture_exclusions = TRAIT_EXCLUSIONS["culture"][trait];
	local subculture_exclusions = TRAIT_EXCLUSIONS["subculture"][trait];
	local faction_exclusions = TRAIT_EXCLUSIONS["faction"][trait];
	
	if culture_exclusions ~= nil then
		for i = 1, #culture_exclusions do
			if culture_exclusions[i] == char_culture then
				return true;
			end
		end
	end
	if subculture_exclusions ~= nil then
		for i = 1, #subculture_exclusions do
			if subculture_exclusions[i] == char_subculture then
				return true;
			end
		end
	end
	if faction_exclusions ~= nil then
		for i = 1, #faction_exclusions do
			if faction_exclusions[i] == char_faction_name then
				return true;
			end
		end
    end
    
    -- remove reference here 
	if character:character_type("colonel") --[[or character:character_subtype("wh2_main_def_black_ark")]] or char_faction:is_quest_battle_faction() then
		return true;
	end
	return false;
end