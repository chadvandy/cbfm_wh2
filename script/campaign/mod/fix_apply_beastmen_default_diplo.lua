function apply_beastmen_default_diplomacy()
	--Set up who are they allowed to declare war with 
	
	local trade_str = "trade agreement,break trade";

	-- Beastmen can only do peace and war with other factions
	cm:force_diplomacy("culture:wh_dlc03_bst_beastmen", "all", "all", false, false, true);
	cm:force_diplomacy("culture:wh_dlc03_bst_beastmen", "all", "war", true, true, true);
	cm:force_diplomacy("culture:wh_dlc03_bst_beastmen", "all", "payments", true, true, true);
	cm:force_diplomacy("culture:wh_dlc03_bst_beastmen", "all", "peace", true, true, true);	
	cm:force_diplomacy("culture:wh_dlc03_bst_beastmen", "culture:wh_dlc03_bst_beastmen", "all", true, true, true);
	cm:force_diplomacy("culture:wh_dlc03_bst_beastmen", "culture:wh_dlc03_bst_beastmen", "form confederation", false, false, true);
	cm:force_diplomacy("culture:wh_dlc03_bst_beastmen", "culture:wh_dlc03_bst_beastmen", trade_str, false, false, true);
	cm:force_diplomacy("culture:wh_dlc03_bst_beastmen", "culture:wh_main_chs_chaos", "all", true, true, true);
	cm:force_diplomacy("culture:wh_dlc03_bst_beastmen", "culture:wh_main_chs_chaos", trade_str, false, false, true);
	cm:force_diplomacy("culture:wh_dlc03_bst_beastmen", "culture:wh2_main_skv_skaven", "all", true, true, true);
	cm:force_diplomacy("culture:wh_dlc03_bst_beastmen", "culture:wh2_main_skv_skaven", trade_str, false, false, true);
	
	-- if Empire/Bretonnia/Dwarfs are human controlled (i.e. MPC) then all options are available to Beastmen (except trade)
	if cm:is_multiplayer() then
		local emp = cm:get_faction("wh_main_emp_empire");	
		local beast = cm:get_faction("wh_dlc03_bst_beastmen");
		if beast and emp:is_human() and beast:is_human() then
			cm:force_diplomacy("faction:wh_dlc03_bst_beastmen", "faction:wh_main_emp_empire", "all", true, true, true);
		end;
		
		local brt = cm:get_faction("wh_main_brt_bretonnia");	
		if beast and brt:is_human() and beast:is_human() then
			cm:force_diplomacy("faction:wh_dlc03_bst_beastmen", "faction:wh_main_brt_bretonnia", "all", true, true, true);
		end;
		
		local dwf = cm:get_faction("wh_main_dwf_dwarfs");	
		if beast and dwf:is_human() and beast:is_human() then
			cm:force_diplomacy("faction:wh_dlc03_bst_beastmen", "faction:wh_main_dwf_dwarfs", "all", true, true, true);
		end;
	end
	
	--Set up diplomatic relationships based on starting leader
	
	local faction_list = cm:model():world():faction_list();
	local beastmen_subculture = "wh_dlc03_sc_bst_beastmen";
	local brayherd_append_str = "_brayherd";
	local faction_prepend_str = "faction:";
	for i = 0, faction_list:num_items() - 1 do
		local current_faction = faction_list:item_at(i);
		local current_faction_name = current_faction:name();
		local current_faction_subculture = current_faction:subculture();
		-- full beastmen factions cannot cancel vassal treaties with their brayherd factions
		if current_faction_subculture == beastmen_subculture then		
			local target_faction_name = current_faction_name .. brayherd_append_str;
			if cm:model():world():faction_exists(target_faction_name) then
				cm:force_diplomacy(faction_prepend_str .. current_faction_name, faction_prepend_str .. target_faction_name, "war,break vassal,break alliance,break vassal,break client state", false, false, true);
			end;
		end;
		
	end;
end