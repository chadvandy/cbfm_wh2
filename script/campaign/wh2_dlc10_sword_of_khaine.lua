Sword_key_index = {"wh2_dlc10_anc_weapon_the_widowmaker_1", "wh2_dlc10_anc_weapon_the_widowmaker_2", "wh2_dlc10_anc_weapon_the_widowmaker_3"};

Sword_negative_index = {"wh2_sword_of_khaine_1","wh2_sword_of_khaine_2","wh2_sword_of_khaine_3"};

Sword_event_index = {
	["Sword_issued"] = "wh2_dlc10_sword_of_khaine_issued",
	["Sword_stuck"] = "wh2_dlc10_sword_of_khaine_stuck",
	["Sword_returned"] = "wh2_dlc10_sword_of_khaine_returned",
	["Sword_building_done"] = "wh2_dlc10_sword_of_khaine_building_done",
	["Sword_level_dilemma_index"] = {"wh2_dlc10_sword_of_khaine_lv1", "wh2_dlc10_sword_of_khaine_lv2"},
	["Sword_issued_AI"] = "wh2_dlc10_sword_of_khaine_issued_AI",
	["Sword_region_got"] = "wh2_dlc10_sword_of_khaine_region_captured",
	["Sword_picking"] = "wh2_dlc10_sword_of_khaine_pick_or_not"
};

Sword_elven_subculture = {"wh_dlc05_sc_wef_wood_elves", "wh2_main_sc_def_dark_elves", "wh2_main_sc_hef_high_elves"};

Sword_building_key = "wh2_main_sch_special_shrine_of_khaine";

Sword_region_key_list = {
	["main_warhammer"] = "wh2_main_nagarythe_shrine_of_khaine", 
	["wh2_main_great_vortex"] = "wh2_main_vor_nagarythe_shrine_of_khaine"
	};
	
Sword_region_key = "";

Sword_eventfeed_can_trigger = true;

Sword_growth_time = {15, 10, 10};

Sword_owner = {
	["character_cqi"] = nil,
	["region"] = "",
	["faction"] = "",
	["lv"] = 0,
	["cd"] = 0,
	["ready"] = false
	};
	
Sword_owner_default = {
	["character_cqi"] = nil,
	["region"] = "",
	["faction"] = "",
	["lv"] = 0,
	["cd"] = 0,
	["ready"] = false
	};

Sword_vfx = {
	["garrison"] = "scripted_effect4",
	["character"] = "scripted_effect5"
};	

--Sword_button_states = {"not_ready", "ready", "held_by_player", "held_by_AI"};

Sword_vfx_cache = {
	["garrison"] = nil,
	["character"] = nil
};

Sword_vfx_cache_default = {
	["garrison"] = nil,
	["character"] = nil
};

Sword_owner_cache = -1;

Sword_owner_cache_default = -1;

Sword_firing = false;

Sword_fire_faction = "";

Sword_initiate = false;

Sword_stop_cam = false;

AI_pick_chance = 20;

AI_drop_chance = 5;

AI_hold_time = 10;

Sword_building_keys = {
						"wh2_main_special_shrine_of_khaine_def_1",
						"wh2_main_special_shrine_of_khaine_hef_1",
						"wh2_main_special_shrine_of_khaine_wef_1"
};
--Sword_current_state = Sword_button_states[1];

-- listener which (re)initiates the sword button - this event can be triggered by ui override script
core:add_listener(
	"initiate_sword_button_listener",
	"ScriptEventInitiateSwordButton",
	true,
	function() initiate_sword_button() end,
	true
);

--initiate sword states
function initiate_sword_button()
	local script_belongs_to = cm:get_local_faction_name(true);
	local cm_model = cm:model()
	local ui_root = core:get_ui_root()

	if Sword_initiate == false then
		if cm_model:campaign_name("main_warhammer") then
			Sword_region_key = Sword_region_key_list["main_warhammer"];
		elseif cm_model:campaign_name("wh2_main_great_vortex") then
			Sword_region_key = Sword_region_key_list["wh2_main_great_vortex"];
		else
			script_error("ERROR: Trying to set sword of khaine, but could not find the campaign name!");
			return;
		end;
		Reset_sword_owner();
		Sword_initiate = true;	
	end
	
	-- in case its an autorun
	if not script_belongs_to then
		return;
	end
	
	if Sword_faction_is_elven(cm_model:world():faction_by_key(script_belongs_to)) then
		find_uicomponent(ui_root, "sword_of_khaine"):SetVisible(true);

		Set_sword_button_state();
		if script_belongs_to == Sword_fire_faction then
			find_uicomponent(ui_root, "VFX"):SetVisible(true);
		else
			find_uicomponent(ui_root, "VFX"):SetVisible(false);
		end
	else
		find_uicomponent(ui_root, "sword_of_khaine"):SetVisible(false);
	end
end

--scan and find sword owner, this is used to correct any corner cases
function Get_sword_owner()
	for	i = 1, #Sword_key_index do
		local characters = cm:model():world():characters_owning_ancillary(Sword_key_index[i])

		for j = 0, characters:num_items()-1 do
			local character = characters:item_at(j);
			return character:command_queue_index(), character:faction():name();
		end
	end
	--out("nothing is found");
	return nil, nil; 
end


--scan and find sword owner, and also update cached sword owner accordingly, this is used to corect any corner cases
function Get_and_update_sword_owner()
	local owner_cqi, owner_faction = Get_sword_owner();

	if owner_cqi == nil then
		if Sword_owner["character_cqi"] == nil then
			--it fits
		else
			--mismatch
			if cm:model():character_for_command_queue_index(Sword_owner["character_cqi"]):is_null_interface() then
				correct_sword_owner(owner_cqi);
				Reset_sword_owner();
			else
				correct_sword_owner(owner_cqi);
				Reset_sword_owner();
			end
		end
	else
		if Sword_owner["character_cqi"] == nil then
			--mismatch
			correct_sword_owner(owner_cqi);
			Reset_sword_owner();
			Set_sword_owner(owner_cqi);
		else
			if Sword_owner["character_cqi"] == owner_cqi then
				--char fits, check faction
				if owner_faction ~= nil and owner_faction ~= "rebels" then
				-- the owner faction is legit, either computer or player
					if Sword_owner["faction"] == owner_faction then
					--completely fit, but still check if the character is alive
						local sword_owner_character = cm:model():character_for_command_queue_index(Sword_owner["character_cqi"]);
						if not sword_owner_character:is_null_interface() then
							if sword_owner_character:has_military_force() then
								--fits with no problem
							else 
								--fits but dismissed in a way
								if not sword_owner_character:faction():is_human() then
									Reset_sword_owner();
								end
							end
						else
							--fits but no longer there
							Reset_sword_owner();
						end
					else
						--mismatch
						correct_sword_owner(owner_cqi);
						Reset_sword_owner();
						Set_sword_owner(owner_cqi);
					end
				else 
					-- the owner faction is not legit
					correct_sword_owner(owner_cqi);
					Reset_sword_owner();
				end
			else
				--mismatch
				correct_sword_owner(owner_cqi);
				Reset_sword_owner();
				Set_sword_owner(owner_cqi);
			end
		end
	end
end

function correct_sword_owner(cqi)
	if cqi == nil then
		Sword_owner = {	["character_cqi"] = nil,
						["region"] = Sword_region_key,
						["faction"] = nil,
						["lv"] = 0,
						["cd"] = 0,
						["ready"] = false
						};	
		Set_sword_button_state();
	else
		Sword_owner = {	["character_cqi"] = cqi,
						["region"] = "",
						["faction"] = cm:model():character_for_command_queue_index(cqi):faction():name(),
						["lv"] = 1,
						["cd"] = Sword_growth_time[1],
						["ready"] = true
						};	
		Set_sword_button_state();
	end
end


--set button state according to cached sword owner
function Set_sword_button_state()
	local script_belongs_to = cm:get_local_faction_name(true);
	local component = find_uicomponent(core:get_ui_root(), "button_sword_of_khaine");
	local turn_faction = cm:model():world():whose_turn_is_it();
	local sword_owner_faction = cm:model():world():faction_by_key(Sword_owner["faction"]);
	local ui_root = core:get_ui_root()
	
	if Sword_owner["faction"] ~= nil and Sword_owner["faction"] ~= "rebels" then
		find_uicomponent(ui_root, "faction_symbol"):SetVisible(true);
		component:InterfaceFunction("SetFactionFlag", sword_owner_faction:command_queue_index());
		if Sword_owner["character_cqi"] == nil then
			if Sword_owner["ready"] == false then
				find_uicomponent(ui_root, "button_sword_of_khaine"):SetState("locked_active");
				component:InterfaceFunction("SetTooltip", sword_owner_faction:command_queue_index(), "sword_button_locked_down");
			elseif Sword_owner["faction"] == script_belongs_to then
				find_uicomponent(ui_root, "button_sword_of_khaine"):SetState("active");
				component:InterfaceFunction("SetTooltip", sword_owner_faction:command_queue_index(), "sword_button_active");
				--find_uicomponent(core:get_ui_root(), "VFX"):SetState("NewState");
			else 
				find_uicomponent(ui_root, "button_sword_of_khaine"):SetState("locked_active");
				component:InterfaceFunction("SetTooltip", sword_owner_faction:command_queue_index(), "sword_button_locked_down");
			end
		elseif Sword_owner["faction"] == script_belongs_to then
			find_uicomponent(ui_root, "faction_symbol"):SetVisible(false);
			find_uicomponent(ui_root, "button_sword_of_khaine"):SetState("owned");
			component:InterfaceFunction("SetTooltip", sword_owner_faction:command_queue_index(), "sword_button_owned");
		else
			find_uicomponent(ui_root, "button_sword_of_khaine"):SetState("locked_down");
			component:InterfaceFunction("SetTooltip", sword_owner_faction:command_queue_index(), "sword_button_owned_by_others");
		end
	else 
		if Sword_owner["character_cqi"] == nil then
			find_uicomponent(ui_root, "faction_symbol"):SetVisible(false);
			find_uicomponent(ui_root, "button_sword_of_khaine"):SetState("locked_active");
			component:InterfaceFunction("SetTooltip", "sword_button_locked_down_and_razed");
		end
	end
end

--control sword fire
function Set_sword_fire(andreas)
	local ui_root = core:get_ui_root()
	if andreas then 
		find_uicomponent(ui_root, "VFX"):SetVisible(true);
		Sword_fire_faction = Sword_owner["faction"];
	else
		find_uicomponent(ui_root, "VFX"):SetVisible(false);
		Sword_fire_faction = "";
	end
end

--check if sword region has the proper building to unlock sword
function Sword_building_super_chain_check()
	local region = cm:model():world():region_manager():region_by_key(Sword_region_key);

	for i = 0, region:slot_list():num_items()-1 do
		local current_slot = region:slot_list():item_at(i);
		if current_slot:has_building() then
			for j=1, #Sword_building_keys do
				local building_name = current_slot:building():name()
				local building_name_2 = Sword_building_keys[j]
				if current_slot:building():name() == Sword_building_keys[j] then
					return true;
				end
			end
		end
	end
	return false;
end

--reset sword owner, returning sword back to sword region
function Reset_sword_owner()
	local region = cm:model():world():region_manager():region_by_key(Sword_region_key);
	
	if Sword_owner["character_cqi"] ~= nil then
		local script_belongs_to = cm:get_local_faction_name(true);
		core:trigger_event("ScriptEventSwordReturned");
	end
	Remove_sword();
	
	
	if region:is_abandoned() then
		Sword_owner = {	["character_cqi"] = nil,
						["region"] = Sword_region_key,
						["faction"] = nil,
						["lv"] = 0,
						["cd"] = 0,
						["ready"] = false
						};	
		Set_sword_button_state();
	elseif Sword_building_super_chain_check() == false then
			Sword_owner = {	["character_cqi"] = nil,
						["region"] = Sword_region_key,
						["faction"] = region:owning_faction():name(),
						["lv"] = 0,
						["cd"] = 0,
						["ready"] = false
						};	
			Set_sword_button_state();
	else
		Sword_owner = {	["character_cqi"] = nil,
					["region"] = Sword_region_key,
					["faction"] = region:owning_faction():name(),
					["lv"] = 0,
					["cd"] = 0,
					["ready"] = true
					};	
		Set_sword_button_state();
	end
	Handle_vfx(Sword_owner["character_cqi"], true)
end

--apply or remove vfx from char/region
function Handle_vfx(cqi, apply)
	local cm_model = cm:model()
	local region_manager = cm_model:world():region_manager()
	local sword_garrison_residence = region_manager:region_by_key(Sword_region_key):garrison_residence()

	if apply == false then
		if cqi ~= nil then
			Remove_vfx();
		elseif not region_manager:region_by_key(Sword_region_key):is_null_interface() then
			cm:remove_garrison_residence_vfx(sword_garrison_residence:command_queue_index(),Sword_vfx["garrison"]);
			Sword_vfx_cache["garrison"] = nil;
		end
	else	
		if cqi == nil then
			if not sword_garrison_residence:is_null_interface() and Sword_vfx_cache["garrison"] ~= sword_garrison_residence:command_queue_index() then
				Remove_vfx();
				cm:add_garrison_residence_vfx(sword_garrison_residence:command_queue_index(),Sword_vfx["garrison"], true);
				Sword_vfx_cache["garrison"] = sword_garrison_residence:command_queue_index();
			end
		else
			local character = cm_model:character_for_command_queue_index(cqi)

			Remove_vfx();
			if not character:is_null_interface() then
				local character_region = character:region()
				if not(character_region:is_null_interface()) then
					local character_garrison_residence = character_region:garrison_residence()

					if character:in_settlement() then
						cm:add_character_vfx(cqi, Sword_vfx["character"], true);
						Sword_vfx_cache["character"] = cqi; 
						cm:add_garrison_residence_vfx(character_garrison_residence:command_queue_index(),Sword_vfx["garrison"], true);
						Sword_vfx_cache["garrison"] = character_garrison_residence:command_queue_index();
					else
						cm:add_character_vfx(cqi, Sword_vfx["character"], true);
						Sword_vfx_cache["character"] = cqi; 
					end
				end
			else
				out("sowrd of khaine vfx: new assignee is not found");
			end
		end
	end
end

function Remove_vfx()
	if Sword_vfx_cache["character"] ~= nil then
		cm:remove_character_vfx(Sword_vfx_cache["character"], Sword_vfx["character"]);
		Sword_vfx_cache["character"] = nil;
	end
	if Sword_vfx_cache["garrison"] ~= nil then
		cm:remove_garrison_residence_vfx(Sword_vfx_cache["garrison"], Sword_vfx["garrison"]);
		Sword_vfx_cache["garrison"] = nil;
	end
end

--reapply vfx everytime a the sword owner enters or leaves a settlement
function Reapply_vfx()
	Handle_vfx(Sword_owner["character_cqi"], false);
	Handle_vfx(Sword_owner["character_cqi"], true);
end

--reapply vfx in case if the character left port, where the char will embark into a different region and lose connection to the garrison residence
function Reapply_vfx_when_leaving_port(port_garrison_residence_cqi)
	cm:remove_garrison_residence_vfx(port_garrison_residence_cqi,Sword_vfx["garrison"]);
	Handle_vfx(Sword_owner["character_cqi"], true);
end

--remove sword and sword vfx and sword effect bundle
function Remove_sword()
	Handle_vfx(Sword_owner["character_cqi"], false);
	if Sword_owner["character_cqi"] ~= nil then
		-- remove current lvl sword from currently stored character_cqi	
		Remove_effect_bundle()
		out("removing_sword");
		out(Sword_key_index[Sword_owner["lv"]]);
		out(Sword_owner["character_cqi"]);
		Remove_all_sword_ancillary();
	end
end

function Remove_effect_bundle()
	for i = 1, #Sword_negative_index do
		cm:remove_effect_bundle(Sword_negative_index[i], Sword_owner["faction"]);
	end
end

function Remove_all_sword_ancillary()
	local sword_owner_faction = cm:model():world():faction_by_key(Sword_owner["faction"]);
	for i = 1, #Sword_key_index do
		cm:force_remove_ancillary_from_faction(sword_owner_faction, Sword_key_index[i]);
	end
end

--set new sword owner and update sword owner cache
function Set_sword_owner(cqi, limited_to_elven)
	local character_interface = cqi == nil and nil or cm:model():character_for_command_queue_index(cqi); --lua ternaries are weird
	
	if character_interface == nil or character_interface:is_null_interface() or ( limited_to_elven == true and Sword_candidate_is_elven(character_interface) == false ) or character_interface:faction():name() == "rebels" then
		Reset_sword_owner();
	else
		Remove_sword();
		local sword_owner_faction = character_interface:faction();
		Sword_owner = {	["character_cqi"] = cqi,
					["region"] = "",
					["faction"] = sword_owner_faction:name(),
					["lv"] = 1,
					["cd"] = Sword_growth_time[1],
					["ready"] = true
					};
		cm:force_add_ancillary(character_interface, Sword_key_index[Sword_owner["lv"]], true, false);
		if sword_owner_faction:is_human() then
			cm:apply_effect_bundle(Sword_negative_index[Sword_owner["lv"]], Sword_owner["faction"], 0)
		else
			local all_faction = cm:model():world():faction_list();
			for i = 0, all_faction:num_items()-1 do
				local current_faction = all_faction:item_at(i);
				if current_faction:is_human() then
					if Sword_eventfeed_can_trigger == true then 
						Sword_eventfeed_can_trigger = false;
						Claim_sword_taken_to_human(current_faction:name());
					end
				end
			end	
		end
		
		Set_sword_button_state();
		Handle_vfx(cqi, true);
		Set_sword_fire(false);
		out("given sword to");
		out(Sword_owner["character_cqi"]);
		out(Sword_owner["faction"]);
	end
end

function Claim_sword_taken_to_human(faction_name)

	cm:add_faction_turn_start_listener_by_name(
		"sword_change_hands",
		faction_name,
		function(context)
			if Sword_owner["character_cqi"] then
				local character_interface = cm:model():character_for_command_queue_index(Sword_owner["character_cqi"]);
				Sword_eventfeed_can_trigger = true;
				cm:show_message_event_located(
					faction_name,
					"event_feed_strings_text_wh2_dlc10_event_feed_string_scripted_event_sword_of_khiane_issued_AI_title",
					"event_feed_strings_text_wh2_dlc10_event_feed_string_scripted_event_sword_of_khiane_issued_AI_primary_details",
					"event_feed_strings_text_wh2_dlc10_event_feed_string_scripted_event_sword_of_khiane_issued_AI_secondary_details",
					character_interface:logical_position_x(),
					character_interface:logical_position_y(),
					false,
					1016
				);
			end;
		end,
		false
	);
end


--checking if the sword candidate cqi is elven
function Sword_candidate_is_elven(character_interface)
	local faction_subculture = "";
	local is_elf = false;
	
	if not character_interface:is_null_interface() then
		faction_subculture = character_interface:faction():subculture();
	else
		return false;
	end
	
	for i=1, #Sword_elven_subculture do
		if faction_subculture == Sword_elven_subculture[i] then
			is_elf = true;
		end
	end
	
	if is_elf == true then
		return true;
	else
		return false;
	end
end

--checking if a certain faction is elven
function Sword_faction_is_elven(faction)
	if faction:is_null_interface() then
		return false;
	end

	local faction_subculture = faction:subculture();
	local is_elf = false;
	
	for i=1, #Sword_elven_subculture do
		if faction_subculture == Sword_elven_subculture[i] then
			is_elf = true;
		end
	end
	
	if is_elf == true then
		return true;
	else
		return false;
	end
end

--level up the sword when it's due time to level up
function Sword_level_up()
	if (Sword_owner["lv"] + 1) <= #Sword_key_index then
		local character_interface = nil;
		local sword_owner_faction = cm:model():world():faction_by_key(Sword_owner["faction"]);

		if Sword_owner["character_cqi"] ~= nil then
			-- remove current lvl sword from currently stored character_cqi	
			Remove_effect_bundle();
			out("removing_sword");
			out(Sword_key_index[Sword_owner["lv"]]);
			out(Sword_owner["character_cqi"]);
			cm:force_remove_ancillary_from_faction(sword_owner_faction, Sword_key_index[Sword_owner["lv"]]);
			character_interface = cm:model():character_for_command_queue_index(Sword_owner["character_cqi"]);
		end
		Sword_owner["lv"] = Sword_owner["lv"] + 1;
		Sword_owner["cd"] = Sword_growth_time[Sword_owner["lv"]];
		
		if character_interface ~= nil then
			cm:force_add_ancillary(character_interface, Sword_key_index[Sword_owner["lv"]], true, false);
		end

		if sword_owner_faction:is_human() then
			cm:apply_effect_bundle(Sword_negative_index[Sword_owner["lv"]], Sword_owner["faction"], 0)
		end
	else 
		--sword at max level
	end
end



--check if confedration/loyalty changed sowrd owner_cqi
core:add_listener(
	"sword_of_khaine_FactionJoinsConfederation",
	"FactionJoinsConfederation",
	true,
	function(context)
		Get_and_update_sword_owner();
	end,
	true
);

core:add_listener(
	"sword_of_khaine_FactionCivilWarOccured",
	"FactionCivilWarOccured",
	true,
	function(context)
		Get_and_update_sword_owner();
	end,
	true
);

--check if mission success had taken off the sword
core:add_listener(
	"sword_of_khaine_CharacterAncillaryGained",
	"CharacterAncillaryGained",
	true,
	function(context)
		if context:character():command_queue_index() == Sword_owner["character_cqi"] then
			Refresh_sword();
		end
	end,
	true
);

function Refresh_sword()
	local character_interface = cm:model():character_for_command_queue_index(Sword_owner["character_cqi"]);
	if not character_interface:has_ancillary(Sword_key_index[Sword_owner["lv"]]) then
		cm:force_remove_ancillary_from_faction(character_interface:faction(), Sword_key_index[Sword_owner["lv"]]);
		cm:force_add_ancillary(character_interface, Sword_key_index[Sword_owner["lv"]], true, false);
	end
end

--check if the place is razed
core:add_listener(
	"sword_of_khaine_CharacterRazedSettlement",
	"CharacterRazedSettlement",
	true,
	function(context)
		local region = context:character():region()
		if region:is_null_interface() then
			return
		elseif region:name() == Sword_region_key then
			find_uicomponent(core:get_ui_root(), "faction_symbol"):SetVisible(false);
			if Sword_owner["character_cqi"] == nil then
				Sword_owner["faction"] = nil;
				Set_sword_button_state();
				Set_sword_fire(false);
			end
		end
	end,
	true
);

--check if we should power-up the sword
core:add_listener(
	"sword_of_khaine_FactionTurnStart",
	"FactionTurnStart",
	true,
	function(context)
		local current_faction = context:faction();
		local current_faction_name = current_faction:name();
		
		if Sword_initiate == true then
			Get_and_update_sword_owner();
			if current_faction:is_human() and Sword_owner["faction"] == current_faction_name then 
				Deal_with_sword_lv();
			elseif current_faction:is_human() == false and Sword_owner["faction"] == current_faction_name then
				--deal with AI lv
				Deal_with_AI_sword(current_faction);
			end
		end
	end,
	true
);

function Deal_with_sword_lv()
	local current_faction = cm:model():world():whose_turn_is_it():name();
	if Sword_owner["character_cqi"] ~= nil and Sword_owner["cd"] >= 1 and Sword_owner["lv"] <= #Sword_key_index then
		Sword_owner["cd"] = Sword_owner["cd"] - 1;
	elseif Sword_owner["character_cqi"] ~= nil and Sword_owner["cd"] == 0 and Sword_owner["lv"] + 1 <= #Sword_key_index then
		cm:trigger_dilemma(current_faction, Sword_event_index["Sword_level_dilemma_index"][Sword_owner["lv"]]);
	elseif Sword_owner["character_cqi"] ~= nil and Sword_owner["cd"] == 0 and Sword_owner["lv"] == #Sword_key_index then
		--cm:trigger_incident(current_faction, Sword_event_index["Sword_stuck"], true);
	end
end

function Find_highest_general(faction)
	local char_list = faction:character_list();
	local highest_rank = 0;
	local highest_cqi = nil;
		for i = 0, char_list:num_items() - 1 do
		local current_char = char_list:item_at(i);
		if current_char:rank() > highest_rank and Check_general_background(current_char) then
			highest_rank = current_char:rank()
			highest_cqi = current_char:command_queue_index();
		end;
	end;
	return highest_cqi;
end

function Check_general_background(character)
	if character:is_null_interface() then
		return false;
	end
	if cm:char_is_general_with_army(character) and character:has_military_force() and character:military_force():is_armed_citizenry() == false then
		return true;
	else
		return false;
	end
end

function Deal_with_AI_sword(faction)
	if Sword_owner["character_cqi"] == nil and Sword_owner["ready"] == true then
		--give the sword to strongest general of that faction by a chance
		local roll = cm:random_number(100);
		if roll >= AI_pick_chance then
			--give sword to AI char
			Set_sword_owner(Find_highest_general(faction), true);
			--trigger the incident
			local faction_list = cm:model():world():faction_list();
			for i = 0, faction_list:num_items() - 1 do
				local faction_now = faction_list:item_at(i);
				if faction_now:is_human() then
					local faction_name = faction_now:name();
					local script_belongs_to = cm:get_local_faction_name(true);
					if script_belongs_to == faction_name then
						core:trigger_event("ScriptEventSwordClaimedByAI");
					end
				end
			end
		end
	elseif Sword_owner["character_cqi"] ~= nil and Sword_owner["cd"] >= 1 and Sword_owner["lv"] <= #Sword_key_index then
		Sword_owner["cd"] = Sword_owner["cd"] - 1;
	elseif Sword_owner["character_cqi"] ~= nil and Sword_owner["cd"] == 0 and Sword_owner["lv"] + 1 <= #Sword_key_index then
		Sword_level_up();
	elseif Sword_owner["character_cqi"] ~= nil and Sword_owner["lv"] == #Sword_key_index and Sword_owner["cd"] == 0 then
		--remove the sword from the general by a chance, if he's holding it too long
		local roll = cm:random_number(100);
		if roll >= AI_drop_chance then
			--remove sword from AI char
			Reset_sword_owner();
			--trigger the incident
			local faction_list = cm:model():world():faction_list();
			for i = 0, faction_list:num_items() - 1 do
				local faction_now = faction_list:item_at(i);
				if faction_now:is_human() then
					local faction_name = faction_now:name();
					cm:trigger_incident(faction_name, Sword_event_index["Sword_returned"], true);
				end
			end
		end
	end
end

function Find_candidate_for_faction(faction)
	for i = 0,  faction:character_list():num_items() - 1 do
		local character = faction:character_list():item_at(i);
		if character:has_military_force() then
			if Check_general_background(character) and character:has_region() and character:in_settlement() and character:region():name() == Sword_region_key then
				return character:command_queue_index();
			end
		end
	end;
	return false;
end

--issue sword when incident is triggered
--this is done such a way since only events are broadcasted during UIevents(button click)
core:add_listener(
	"sword_of_khaine_IncidentOccuredEvent",
	"IncidentOccuredEvent",
	true,
	function(context)
		local cm_world = cm:model():world()
		local incident = context:dilemma();
		local region = cm_world:region_manager():region_by_key(Sword_region_key);
		local faction = cm_world:whose_turn_is_it();
		local script_belongs_to = cm:get_local_faction_name(true);
		if incident == Sword_event_index["Sword_issued"] then
			if Find_candidate_for_faction(faction) ~= false then
				Set_sword_owner(Find_candidate_for_faction(faction), false);
				if script_belongs_to == faction:name() then
					core:trigger_event("ScriptEventSwordClaimedByPlayer");
				end
			end
		end
	end,
	true
);

--level-up/return sword based on dilemma
core:add_listener(
	"sword_of_khaine_DilemmaChoiceMadeEvent",
	"DilemmaChoiceMadeEvent",
	true,
	function(context)
		local choice = context:choice();
		local dilemma = context:dilemma();
		local whose_turn_is_it_name = cm:model():world():whose_turn_is_it():name();
		local script_belongs_to = cm:get_local_faction_name(true);
		if dilemma == Sword_event_index["Sword_level_dilemma_index"][1] and whose_turn_is_it_name == script_belongs_to then
			core:trigger_event("ScriptEventSwordDilemmaFirst");
		end
		for i=1, #Sword_event_index["Sword_level_dilemma_index"] do
			if dilemma == Sword_event_index["Sword_level_dilemma_index"][i] and choice == 0 then
				Sword_level_up();
				if i == #Sword_event_index["Sword_level_dilemma_index"] then
					cm:trigger_incident(whose_turn_is_it_name, Sword_event_index["Sword_stuck"], true);
					if Sword_owner["faction"] == script_belongs_to then
						core:trigger_event("ScriptEventSwordStuck");
					end
				end
			elseif dilemma == Sword_event_index["Sword_level_dilemma_index"][i] and choice == 1 then
				Reset_sword_owner();
				cm:trigger_incident(whose_turn_is_it_name, Sword_event_index["Sword_returned"], true);
			end
		end
		if dilemma == Sword_event_index["Sword_picking"] and choice == 0 then
			if Sword_owner_cache > 0 then
				Set_sword_owner(Sword_owner_cache);
			end
		elseif dilemma == Sword_event_index["Sword_picking"] and choice == 1 then
			Reset_sword_owner();
		end
	end,
	true
);

--transfer through battles
core:add_listener(
	"sword_of_khaine_BattleCompleted",
	"BattleCompleted",
	true,
	function(context)
		local Sword_is_there = false;
		local Sword_is_attacking = false; 
		local Sword_owner_cqi = Sword_owner["character_cqi"];
		local cm_model = cm:model()
		
		if cm_model:pending_battle():night_battle() then
			if Sword_owner_cqi ~= nil then
				local this_char_cqi, this_mf_cqi, current_faction_name = cm:pending_battle_cache_get_attacker(1);
				if this_char_cqi == Sword_owner_cqi then
						Sword_is_there = true;
						Sword_is_attacking =  true;
						out("sword is attacking");
				end
			end
			
			if Sword_owner_cqi ~= nil then
				local this_char_cqi, this_mf_cqi, current_faction_name = cm:pending_battle_cache_get_defender(1);
				if this_char_cqi == Sword_owner_cqi then
						Sword_is_there = true;
						out("sword is defending");
				end
			end 
			
		else
			if cm:pending_battle_cache_num_attackers() >= 1 and Sword_owner_cqi ~= nil then
				for i = 1, cm:pending_battle_cache_num_attackers() do
					local this_char_cqi, this_mf_cqi, current_faction_name = cm:pending_battle_cache_get_attacker(i);
					if this_char_cqi == Sword_owner_cqi then
						Sword_is_there = true;
						Sword_is_attacking =  true;
						out("sword is attacking");
					end
				end
			end
			
			if cm:pending_battle_cache_num_defenders() >= 1 and Sword_owner_cqi ~= nil then
				for i = 1, cm:pending_battle_cache_num_defenders() do
					local this_char_cqi, this_mf_cqi, current_faction_name = cm:pending_battle_cache_get_defender(i);
					if this_char_cqi == Sword_owner_cqi then
						Sword_is_there = true;
						out("sword is defending");
					end
				end
			end
		end
		
		
		
		if Sword_is_there and Sword_is_attacking then
			local this_char_cqi, this_mf_cqi, current_faction_name = cm:pending_battle_cache_get_defender(1);
			local this_char = cm_model:character_for_command_queue_index(this_char_cqi)
			--Transfer_sword
			if this_char:is_null_interface() == false and this_char:won_battle() and Check_general_background(this_char) then
				if this_char:faction():is_human() then
					cm:trigger_dilemma(current_faction_name, Sword_event_index["Sword_picking"]);
					Sword_owner_cache = this_char_cqi;
					return nil;
				else
					Set_sword_owner(this_char_cqi, false);
					return nil;
				end
			end
		elseif Sword_is_there and Sword_is_attacking==false then
			local this_char_cqi, this_mf_cqi, current_faction_name = cm:pending_battle_cache_get_attacker(1);
			local this_char = cm_model:character_for_command_queue_index(this_char_cqi)
			--Transfer_sword
			if this_char:is_null_interface() == false and this_char:won_battle() and Check_general_background(this_char) then
				if cm:model():character_for_command_queue_index(this_char_cqi):faction():is_human() then
					cm:trigger_dilemma(current_faction_name, Sword_event_index["Sword_picking"]);
					Sword_owner_cache = this_char_cqi;
					return nil;
				else
					Set_sword_owner(this_char_cqi, false);
					return nil;
				end
			end
		end
		
		if Sword_is_there and cm:model():character_for_command_queue_index(Sword_owner_cqi):is_null_interface() then
			Reset_sword_owner();
		end
	end,
	true
);

core:add_listener(
	"SwordRegionOccupied",
	"CharacterPerformsSettlementOccupationDecision",
	function(context)
		local region = context:garrison_residence():region():name()

		if (Sword_owner["region"] == region) then
			return true
		end
		return false
	end,
	function(context)
		-- This fixes a bug caused by occupation sometimes returning the previous occupants building list, resulting in the sword button being active without the building being owned.
		-- This event is triggered after CharacterEntersGarrison which was previously handling this, and seems to give the game enough time to update the building list correctly/consistently.
		local region = context:garrison_residence():region()
		if region:is_abandoned() then
			if Sword_owner["character_cqi"] == nil then
				Sword_owner["faction"] = nil
			end
			Sword_owner["ready"] = false
			Set_sword_button_state()
		elseif Sword_building_super_chain_check() == false then
			Sword_owner["ready"] = false
			Set_sword_button_state()
		elseif Sword_owner["faction"] == region:faction():name() then
			Sword_owner["ready"] = true
			Set_sword_button_state()
		end
		Handle_vfx(Sword_owner["character_cqi"], true)	
	end,
	true
)

--do the button's thing
core:add_listener(
	"SwordButtonListener",
	"ComponentLClickUp", 
	true,
	function(context) 	
		if UIComponent(context.component):Id() == "button_sword_of_khaine" then
			local cm_model = cm:model()
			local cm_world = cm_model:world()
			local faction = cm_world:whose_turn_is_it();
			local faction_name = faction:name();
			local region_manager = cm_world:region_manager()

			Get_and_update_sword_owner();
			Set_sword_button_state();
			if Sword_owner["character_cqi"] == nil then
				if Sword_owner["faction"] == faction_name and Sword_owner["ready"] == true then
					if Find_candidate_for_faction(faction) ~= false then
						CampaignUI.TriggerIncident(Sword_event_index["Sword_issued"]);
					else
						if Sword_stop_cam == false then
							local settlement = region_manager:region_by_key(Sword_region_key):settlement();
							cm:scroll_camera_from_current(false, 3, {settlement:display_position_x(), settlement:display_position_y(), 14.7, 0.0, 12.0});
							Sword_stop_cam = true;
							cm:callback(function() Sword_stop_cam = false end, 3);
						end
					end
				else
					--zoom to region
					if Sword_stop_cam == false then
						local settlement = region_manager:region_by_key(Sword_region_key):settlement();
						cm:scroll_camera_from_current(false, 3, {settlement:display_position_x(), settlement:display_position_y(), 14.7, 0.0, 12.0});
						Sword_stop_cam = true;
						cm:callback(function() Sword_stop_cam = false end, 3);
					end
				end
			else
				--zoom to character
				local character_target = cm_model:character_for_command_queue_index(Sword_owner["character_cqi"]);
				if Sword_stop_cam == false and character_target:is_null_interface() == false then
					cm:scroll_camera_from_current(false, 3, {character_target:display_position_x(), character_target:display_position_y(), 14.7, 0.0, 12.0});
					Sword_stop_cam = true;
					cm:callback(function() Sword_stop_cam = false end, 3);
				end
			end
		end
	end,
	true
);

--check building completed
core:add_listener(
	"sword_of_khaine_BuildingCompleted",
	"BuildingCompleted",
	true,
	function(context)
		local script_belongs_to = cm:get_local_faction_name(true);
		if context:building():superchain() == Sword_building_key and Sword_faction_is_elven(context:building():faction()) then
			if Sword_owner["character_cqi"] == nil then
				Reset_sword_owner();
				--out(Sword_owner["character_cqi"]);
				--out(Sword_owner["ready"]);
				if Sword_owner["ready"] == true then
					cm:trigger_incident(Sword_owner["faction"], Sword_event_index["Sword_building_done"], true);
				end
				if Find_candidate_for_faction(context:building():faction()) ~= false and Sword_owner["faction"] == script_belongs_to and Sword_owner["ready"] == true then
					Set_sword_fire(true);
					core:trigger_event("ScriptEventSwordAvailable");
				end
			end
		end
	end,
	true
);


--sword region being occupied
--candidate enters the region
core:add_listener(
	"sword_of_khaine_CharacterEntersGarrison",
	"CharacterEntersGarrison",
	true,
	function(context)
		local script_belongs_to = cm:get_local_faction_name(true);
		local garrions_res = context:garrison_residence();
		if garrions_res:region():name() == Sword_region_key then
			if Sword_owner["character_cqi"] == nil then
				Reset_sword_owner();
				if Sword_owner["ready"] == true and Sword_owner["faction"] == script_belongs_to then
					--set button to flames
					Set_sword_fire(true);
				elseif Sword_owner["ready"] ~= true and Sword_faction_is_elven(cm:model():world():faction_by_key(Sword_owner["faction"])) then
					cm:trigger_incident(context:character():faction():name(), Sword_event_index["Sword_region_got"], true);
				end
			end
		end
		if context:character():command_queue_index() == Sword_owner["character_cqi"] then
			Reapply_vfx();
		end
	end,
	true
);

core:add_listener(
	"sword_of_khaine_CharacterLeavesGarrison",
	"CharacterLeavesGarrison",
	true,
	function(context)
		local region = context:garrison_residence():region();
		local script_belongs_to = cm:get_local_faction_name(true);
		if region:name() == Sword_region_key and Sword_owner["ready"] == true and Sword_owner["character_cqi"] == nil and Sword_owner["faction"] == script_belongs_to then 
			--set button flame to extinguish
			Reset_sword_owner();
			Set_sword_fire(false);
		end
		if context:character():command_queue_index() == Sword_owner["character_cqi"] then
			Reapply_vfx_when_leaving_port(context:garrison_residence():command_queue_index());
		end
	end,
	true
);

--save the variables. 
cm:add_saving_game_callback(
	function(context)
		cm:save_named_value("Sword_owner", Sword_owner, context);
		cm:save_named_value("Sword_region_key", Sword_region_key, context);
		cm:save_named_value("Sword_initiate", Sword_initiate, context);
		cm:save_named_value("Sword_fire_faction", Sword_fire_faction, context);		
		cm:save_named_value("Sword_vfx_cache", Sword_vfx_cache, context);
		cm:save_named_value("Sword_owner_cache", Sword_owner_cache, context);
	end
);

cm:add_loading_game_callback(
	function(context)
		Sword_owner = cm:load_named_value("Sword_owner", Sword_owner_default, context);
		Sword_region_key = cm:load_named_value("Sword_region_key", "", context);
		Sword_initiate = cm:load_named_value("Sword_initiate", false, context);
		Sword_fire_faction = cm:load_named_value("Sword_fire_faction", "", context);
		Sword_vfx_cache = cm:load_named_value("Sword_vfx_cache", Sword_vfx_cache_default, context);
		Sword_owner_cache = cm:load_named_value("Sword_owner_cache", Sword_owner_cache_default, context);
	end
);