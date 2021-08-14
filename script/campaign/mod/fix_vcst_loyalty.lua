local loyalty_change_rate = {
	["post_battle_share"] = {100, 1},
	["post_siege_battle_share"] = {100, 1},
	["loyalty_rite"] = {50, 1}
};

core:remove_listener("character_turn_start_vmp_modify_loyalty")
-- everyone loyalty decline
core:add_listener(
	"character_turn_start_vmp_modify_loyalty",
	"CharacterTurnStart",
	function(context)
		return background_check_vampire_coast_player_lord(context:character());
	end,
	function(context)
		local character = context:character();
		
		if character:faction():has_effect_bundle("wh2_dlc11_ritual_cst_eternal_service") then
			modify_loyalty(character, loyalty_change_rate["loyalty_rite"][2], loyalty_change_rate["loyalty_rite"][1]);
		elseif not (character:has_region() and character:region():get_active_edict_key() == "wh2_dlc11_edict_cst_share_the_spoils") and not character:has_skill("wh2_dlc11_skill_cst_loyal_lord") then
			modify_loyalty_on_event(character, "decline_rate");
		end;
	end,
	true
);