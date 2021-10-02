function Bret_StartCharacterRazedSettlement(context)
	local faction_key = context:character():faction():name();
	
	if Is_Bretonnian(faction_key) then
		local razed_faction = cm:model():world():faction_by_key(CHIVALRY_LAST_ATTACKED_GARRISON);

		if razed_faction:is_null_interface() == false then
			local razed_sc = razed_faction:subculture();
			if razed_sc == "wh_main_sc_grn_greenskins" then
				cm:remove_effect_bundle("wh_dlc07_greenskins_incursions", faction_key);
			end
		end
	end
end