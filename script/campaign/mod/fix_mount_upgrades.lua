-- Overwriting script/campaign/wh2_campaign_mount_upgrades.lua Faction_AttemptToAddMount function
-- added a check wether the ancillary already exists (using ancillary_exists())

local subtype_to_mount_list = {
    ["wh2_dlc12_lzd_tlaqua_skink_chief"] = {
        skill = 		"wh2_dlc12_skill_lzd_tlaqua_skink_chief_terradon",
        ancillary =		"wh2_dlc12_anc_mount_lzd_tlaqua_skink_chief_terradon",
        unique = false
    },
    ["wh2_dlc12_lzd_tlaqua_skink_priest_beasts"] = {
        skill = 		"wh2_dlc12_skill_lzd_tlaqua_skink_priest_beasts_terradon",
        ancillary =		"wh2_dlc12_anc_mount_lzd_tlaqua_skink_priest_beasts_terradon",
        unique = false
    },
    ["wh2_dlc12_lzd_tlaqua_skink_priest_heavens"] = {
        skill = 		"wh2_dlc12_skill_lzd_tlaqua_skink_priest_heavens_terradon",
        ancillary =		"wh2_dlc12_anc_mount_lzd_tlaqua_skink_priest_heavens_terradon",
        unique = false
    },
    ["wh2_dlc11_cst_ghost_paladin"] = {
        skill = 		"wh2_dlc11_skill_brt_champion_unique_paladin_damned_barded_warhorse",
        ancillary =		"wh2_dlc11_anc_mount_brt_damned_paladin_barded_warhorse",
        unique = true
    },
    ["brt_paladin"] = {
        skill = 		"wh_main_skill_brt_champion_unique_paladin_barded_warhorse",
        ancillary =		"wh_main_anc_mount_brt_paladin_barded_warhorse",
        unique = false
    },
    ["brt_lord"] = {
        skill = 		"wh_main_skill_brt_lord_unique_general_barded_warhorse",
        ancillary =		"wh_main_anc_mount_brt_general_barded_warhorse",
        unique = false
    },
    ["dlc07_brt_alberic"] = {
        skill = 		"wh_dlc07_skill_brt_alberic_unique_general_barded_warhorse",
        ancillary =		"wh_dlc07_anc_mount_brt_alberic_barbed_warhorse",
        unique = true
    },
    ["wh2_dlc14_brt_repanse"] = {
        skill = 		"wh2_dlc14_skill_brt_repanse_barded_warhorse",
        ancillary =		"wh2_dlc14_anc_mount_brt_repanse_barded_warhorse",
        unique = true
    },
    ["wh2_dlc14_brt_henri_le_massif"] = {
        skill = 		"wh2_dlc14_skill_brt_henri_le_massif_barded_warhorse",
        ancillary =		"wh2_dlc14_anc_mount_brt_henri_le_massif_barded_warhorse",
        unique = true
	},
	["wh2_dlc15_hef_imrik"] = {
		skill = 		"wh2_dlc15_skill_hef_imrik_mount_dragon_prince_steed",
        ancillary =		"wh2_dlc15_anc_mount_hef_imrik_dragon_prince_warhorse",
        unique = true

	}
};
function Faction_AttemptToAddMount(character)
    local subtype_key = character:character_subtype_key();

    if subtype_to_mount_list[subtype_key] and character:character_type_key() ~= "colonel" and 
    (not subtype_to_mount_list[subtype_key].unique or not character:faction():ancillary_exists(subtype_to_mount_list[subtype_key].ancillary)) then
		out("* Faction_AttemptToAddMount is adding skill " .. subtype_to_mount_list[subtype_key].skill .. " and ancillary " .. subtype_to_mount_list[subtype_key].ancillary .. " to character with subtype " .. subtype_key .. ", forename " .. tostring(character:get_forename()) .. ", surname " .. tostring(character:get_surname()) .. ", position [" .. character:logical_position_x() .. ", " .. character:logical_position_y() .. "], faction " .. character:faction():name() .. ", cqi " .. tostring(character:cqi()));
		cm:force_add_skill(cm:char_lookup_str(character), subtype_to_mount_list[subtype_key].skill);
		cm:force_add_ancillary(character, subtype_to_mount_list[subtype_key].ancillary, true, true);
	end;
end;