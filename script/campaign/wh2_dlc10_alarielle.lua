---- Direct overwrite of the vanilla script required for this fix. Not happy about it
---- Fix is within the `defender_of_ulthuan_update()` function

local power_of_nature_regions = {};
local power_of_nature_vfx = {full = "scripted_effect7", half = "scripted_effect8"};
local mortal_worlds_torment_army_count = false;
local mortal_worlds_torment_global_corruption = true;
local mortal_worlds_torment_last_effect = "wh2_dlc10_bundle_alarielle_corruption_0";
local defender_of_ulthuan_faction = "wh2_main_hef_avelorn";
local defender_of_ulthuan_effect = "";
local defender_of_ulthuan_level = 1;
local ulthuan_regions = {
	["main_warhammer"] = {
		["outer"] = {
			["wh2_main_caledor_vauls_anvil"] = true,
			["wh2_main_caledor_tor_sethai"] = true,
			["wh2_main_tiranoc_whitepeak"] = true,
			["wh2_main_tiranoc_tor_anroc"] = true,
			["wh2_main_nagarythe_tor_dranil"] = true,
			["wh2_main_nagarythe_tor_anlec"] = true,
			["wh2_main_nagarythe_shrine_of_khaine"] = true,
			["wh2_main_chrace_tor_achare"] = true,
			["wh2_main_chrace_elisia"] = true,
			["wh2_main_cothique_mistnar"] = true,
			["wh2_main_cothique_tor_koruali"] = true,
			["wh2_main_yvresse_tor_yvresse"] = true,
			["wh2_main_yvresse_elessaeli"] = true,
			["wh2_main_yvresse_tralinia"] = true,
			["wh2_main_yvresse_shrine_of_loec"] = true
		},
		["inner"] = {
			["wh2_main_eataine_lothern"] = true,
			["wh2_main_eataine_tower_of_lysean"] = true,
			["wh2_main_ellyrion_tor_elyr"] = true,
			["wh2_main_eagle_gate"] = true,
			["wh2_main_ellyrion_whitefire_tor"] = true,
			["wh2_main_griffon_gate"] = true,
			["wh2_main_avelorn_evershale"] = true,
			["wh2_main_unicorn_gate"] = true,
			["wh2_main_phoenix_gate"] = true,
			["wh2_main_avelorn_tor_saroir"] = true,
			["wh2_main_avelorn_gaean_vale"] = true,
			["wh2_main_saphery_tor_finu"] = true,
			["wh2_main_saphery_tower_of_hoeth"] = true,
			["wh2_main_saphery_port_elistor"] = true,
			["wh2_main_eataine_angerrial"] = true,
			["wh2_main_eataine_shrine_of_asuryan"] = true
		},
		["outer_lost"] = 0,
		["inner_lost"] = 0
	},
	["wh2_main_great_vortex"] = {
		["outer"] = {
			["wh2_main_vor_straits_of_lothern_glittering_tower"] = true,
			["wh2_main_vor_caledor_vauls_anvil"] = true,
			["wh2_main_vor_caledor_caledors_repose"] = true,
			["wh2_main_vor_caledor_tor_sethai"] = true,
			["wh2_main_vor_tiranoc_whitepeak"] = true,
			["wh2_main_vor_tiranoc_tor_anroc"] = true,
			["wh2_main_vor_tiranoc_the_high_vale"] = true,
			["wh2_main_vor_tiranoc_salvation_isle"] = true,
			["wh2_main_vor_nagarythe_tor_dranil"] = true,
			["wh2_main_vor_nagarythe_tor_anlec"] = true,
			["wh2_main_vor_nagarythe_shrine_of_khaine"] = true,
			["wh2_main_vor_chrace_tor_gard"] = true,
			["wh2_main_vor_chrace_tor_achare"] = true,
			["wh2_main_vor_chrace_elisia"] = true,
			["wh2_main_vor_cothique_tor_koruali"] = true,
			["wh2_main_vor_cothique_mistnar"] = true,
			["wh2_main_vor_northern_yvresse_sardenath"] = true,
			["wh2_main_vor_northern_yvresse_tor_yvresse"] = true,
			["wh2_main_vor_northern_yvresse_tralinia"] = true,
			["wh2_main_vor_southern_yvresse_elessaeli"] = true,
			["wh2_main_vor_southern_yvresse_shrine_of_loec"] = true,
			["wh2_main_vor_southern_yvresse_cairn_thel"] = true
		},
		["inner"] = {
			["wh2_main_vor_straits_of_lothern_lothern"] = true,
			["wh2_main_vor_straits_of_lothern_tower_of_lysean"] = true,
			["wh2_main_vor_ellyrion_the_arc_span"] = true,
			["wh2_main_vor_eagle_gate"] = true,
			["wh2_main_vor_ellyrion_tor_elyr"] = true,
			["wh2_main_vor_griffon_gate"] = true,
			["wh2_main_vor_ellyrion_reavers_mark"] = true,
			["wh2_main_vor_unicorn_gate"] = true,
			["wh2_main_vor_avelorn_evershale"] = true,
			["wh2_main_vor_phoenix_gate"] = true,
			["wh2_main_vor_avelorn_tor_saroir"] = true,
			["wh2_main_vor_avelorn_gaean_vale"] = true,
			["wh2_main_vor_saphery_tor_finu"] = true,
			["wh2_main_vor_saphery_shadow_peak"] = true,
			["wh2_main_vor_saphery_tower_of_hoeth"] = true,
			["wh2_main_vor_saphery_port_elistor"] = true,
			["wh2_main_vor_eataine_angerrial"] = true,
			["wh2_main_vor_eataine_shrine_of_asuryan"] = true
		},
		["outer_lost"] = 0,
		["inner_lost"] = 0
	}
};

function add_alarielle_listeners()
	out("#### Adding Alarielle Listeners ####");
	local alarielle = cm:model():world():faction_by_key(defender_of_ulthuan_faction);
	
	-- POWER OF NATURE
	core:add_listener(
		"power_of_nature",
		"CharacterTurnStart",
		true,
		function(context)
			local character = context:character();
			if character:character_subtype("wh2_dlc10_hef_alarielle") and character:has_region() and character:is_at_sea() == false then
				local region = character:region();
				
				if region:is_abandoned() == false and region:owning_faction():name() == character:faction():name() then
					local region_key = region:name();
					cm:remove_effect_bundle_from_region("wh2_dlc10_power_of_nature", region_key);
					cm:apply_effect_bundle_to_region("wh2_dlc10_power_of_nature", region_key, 10);
					power_of_nature_regions[region_key] = 10;
					
					local garrison_residence = region:garrison_residence();
					local garrison_residence_CQI = garrison_residence:command_queue_index();
					cm:add_garrison_residence_vfx(garrison_residence_CQI, power_of_nature_vfx.full, false);
					core:trigger_event("ScriptEventPowerOfNatureTriggered");
				end;
			end;
		end,
		true
	);
	core:add_listener(
		"power_of_nature_region",
		"RegionTurnStart",
		function(context)
			local region = context:region();
			return power_of_nature_regions[region:name()] ~= nil;
		end,
		function(context)
			local region = context:region();
			local region_key = region:name();
			local garrison_residence = region:garrison_residence();
			local garrison_residence_CQI = garrison_residence:command_queue_index();
			
			if region:is_abandoned() == true or region:owning_faction():culture() ~= "wh2_main_hef_high_elves" then
				cm:remove_garrison_residence_vfx(garrison_residence_CQI, power_of_nature_vfx.full);
				cm:remove_garrison_residence_vfx(garrison_residence_CQI, power_of_nature_vfx.half);
				cm:remove_effect_bundle_from_region("wh2_dlc10_power_of_nature", region_key);
			end
			
			local turns_remaining = power_of_nature_regions[region_key];
			turns_remaining = turns_remaining - 1;
			
			if turns_remaining > 5 then
				-- Display full VFX
				cm:remove_garrison_residence_vfx(garrison_residence_CQI, power_of_nature_vfx.full);
				cm:remove_garrison_residence_vfx(garrison_residence_CQI, power_of_nature_vfx.half);
				cm:add_garrison_residence_vfx(garrison_residence_CQI, power_of_nature_vfx.full, false);
				power_of_nature_regions[region_key] = turns_remaining;
			elseif turns_remaining > 0 then
				-- Switch to half strength VFX
				cm:remove_garrison_residence_vfx(garrison_residence_CQI, power_of_nature_vfx.full);
				cm:remove_garrison_residence_vfx(garrison_residence_CQI, power_of_nature_vfx.half);
				cm:add_garrison_residence_vfx(garrison_residence_CQI, power_of_nature_vfx.half, false);
				power_of_nature_regions[region_key] = turns_remaining;
			else
				-- Remove all VFX
				cm:remove_garrison_residence_vfx(garrison_residence_CQI, power_of_nature_vfx.full);
				cm:remove_garrison_residence_vfx(garrison_residence_CQI, power_of_nature_vfx.half);
				power_of_nature_regions[region_key] = nil;
			end
		end,
		true
	);
	
	-- MORTAL WORLDS TORMENT
	core:add_listener(
		"mortal_worlds_torment",
		"CharacterTurnStart",
		true,
		function(context)			
			if context:character():character_subtype("wh2_dlc10_hef_alarielle") == true then
				local current_char = context:character();

				local chaos_count = 0;
				local faction_list = cm:model():world():faction_list();
				local faction_name = current_char:faction():name();
				
				for i = 0, faction_list:num_items() - 1 do
					local faction = faction_list:item_at(i);
					
					if faction:subculture() == "wh_main_sc_chs_chaos" then
						chaos_count = chaos_count + faction:military_force_list():num_items();
					end
				end
				
				local chaos_spread_max = 0;
				local chaos_spread = 0;
				local region_list = current_char:faction():region_list();
				
				for i = 0, region_list:num_items() - 1 do
					local current_region = region_list:item_at(i);
					
					chaos_spread_max = chaos_spread_max + 1;
					chaos_spread = chaos_spread + current_region:religion_proportion("wh_main_religion_chaos");
				end
				
				if chaos_spread_max > 0 then
					chaos_spread = chaos_spread / chaos_spread_max;
				end
				
				local chaos_spread_percent = chaos_spread * 100;
				chaos_spread_percent = math.ceilTo(chaos_spread_percent, 1);
				--out("Mortal Worlds Torment: "..chaos_spread_percent);
				
				cm:remove_effect_bundle(mortal_worlds_torment_last_effect, faction_name);
				cm:apply_effect_bundle("wh2_dlc10_bundle_alarielle_corruption_"..chaos_spread_percent, faction_name, 0);
				mortal_worlds_torment_last_effect = "wh2_dlc10_bundle_alarielle_corruption_"..chaos_spread_percent;
				
				cm:disable_event_feed_events(true, "wh_event_category_traits_ancillaries", "", "");
				
				local trait_level = current_char:trait_points("wh2_dlc10_trait_alarielle_chaos");
				trait_level = trait_level - current_char:trait_points("wh2_dlc10_trait_alarielle_chaos_none");
		
				local char_str = "character_cqi:"..current_char:command_queue_index();
				cm:force_remove_trait(char_str, "wh2_dlc10_trait_alarielle_chaos");
				cm:force_remove_trait(char_str, "wh2_dlc10_trait_alarielle_chaos_none");
				
				if (mortal_worlds_torment_army_count == true and chaos_count > 6) or (mortal_worlds_torment_global_corruption == true and chaos_spread > 0.75) then
					cm:force_add_trait(char_str, "wh2_dlc10_trait_alarielle_chaos", false, 3);
					core:trigger_event("ScriptEventMortalWorldsTorment4");
					
					if trait_level < 3 then
						cm:trigger_incident(current_char:faction():name(), "wh2_dlc10_incident_hef_alarielle_torment_increase", true);
					end
				elseif (mortal_worlds_torment_army_count == true and chaos_count > 3) or (mortal_worlds_torment_global_corruption == true and chaos_spread > 0.50) then
					cm:force_add_trait(char_str, "wh2_dlc10_trait_alarielle_chaos", false, 2);
					core:trigger_event("ScriptEventMortalWorldsTorment3");
					
					if trait_level < 2 then
						cm:trigger_incident(current_char:faction():name(), "wh2_dlc10_incident_hef_alarielle_torment_increase", true);
					elseif trait_level > 2 then
						cm:trigger_incident(current_char:faction():name(), "wh2_dlc10_incident_hef_alarielle_torment_decrease", true);
					end
				elseif (mortal_worlds_torment_army_count == true and chaos_count > 0) or (mortal_worlds_torment_global_corruption == true and chaos_spread > 0.25) then
					cm:force_add_trait(char_str, "wh2_dlc10_trait_alarielle_chaos", false);
					core:trigger_event("ScriptEventMortalWorldsTorment2");
					
					if trait_level < 1 then
						cm:trigger_incident(current_char:faction():name(), "wh2_dlc10_incident_hef_alarielle_torment_increase", true);
					elseif trait_level > 1 then
						cm:trigger_incident(current_char:faction():name(), "wh2_dlc10_incident_hef_alarielle_torment_decrease", true);
					end
				else
					cm:force_add_trait(char_str, "wh2_dlc10_trait_alarielle_chaos_none", false);
					core:trigger_event("ScriptEventMortalWorldsTorment1");
					
					if trait_level > -1 then
						cm:trigger_incident(current_char:faction():name(), "wh2_dlc10_incident_hef_alarielle_torment_decrease", true);
					end
				end
				
				cm:callback(function() cm:disable_event_feed_events(false, "wh_event_category_traits_ancillaries", "", "") end, 0.5);
			end
		end,
		true
	);
		
	if alarielle:is_human() == true then
		-- DEFENDER OF ULTHUAN
		core:add_listener(
			"defender_of_ulthuan_region_update",
			"CharacterPerformsSettlementOccupationDecision",
			function(context)
				if ulthuan_regions["all"] then
					local region_key = context:garrison_residence():region():name();
					return ulthuan_regions["all"][region_key] == true;
				else
					return false;
				end
			end,
			function(context)
				local region = context:garrison_residence():region();
				defender_of_ulthuan_update(region);
			end,
			true
		);

		cm:add_faction_turn_start_listener_by_name(
			"defender_of_ulthuan_update",
			defender_of_ulthuan_faction,
			function(context)
				if defender_of_ulthuan_level < 10 then
					defender_of_ulthuan_level = defender_of_ulthuan_level + 1;
				end
				
				defender_of_ulthuan_remove_effects(defender_of_ulthuan_faction);
				cm:apply_effect_bundle(defender_of_ulthuan_effect.."_"..defender_of_ulthuan_level, defender_of_ulthuan_faction, 0);
			end,
			true
		);
		
		local campaign_key = "main_warhammer";
		local phoenix_gate = "wh2_main_phoenix_gate";
		local blood_voyage_display_pos = {x = 415, y = 684};
		
		if cm:model():campaign_name("wh2_main_great_vortex") then
			campaign_key = "wh2_main_great_vortex";
			phoenix_gate = "wh2_main_vor_phoenix_gate";
			blood_voyage_display_pos = {x = 415, y = 684};
		end
		
		if cm:is_new_game() == true then
			defender_of_ulthuan_initialize(true);
			
			-- Prevents growth in this Pheonix fortress gate for the first owner
			cm:apply_effect_bundle_to_region("wh2_dlc10_dark_elf_fortress_gate", phoenix_gate, 0);
			
			-- Spawn a small Blood Voyage for camera pan
			local intro_blood_voyage = false;
			if intro_blood_voyage == true then
				local death_night, blood_voyage = death_night_accessor();
				local blood_voyage_basic_army = "wh2_main_def_inf_bleakswords_0,wh2_main_def_inf_bleakswords_0,wh2_main_def_inf_bleakswords_0,wh2_main_def_inf_dreadspears_0,wh2_main_def_inf_dreadspears_0,wh2_main_def_inf_dreadspears_0,wh2_dlc10_def_inf_sisters_of_slaughter";
				local blood_voyage_inv = invasion_manager:new_invasion("blood_voyage_inv_1", "wh2_dlc10_def_blood_voyage", blood_voyage_basic_army, blood_voyage_display_pos);
				blood_voyage_inv:set_target("NONE", nil, defender_of_ulthuan_faction);
				blood_voyage_inv:apply_effect("wh2_dlc10_bundle_blood_voyage", 0);
				blood_voyage_inv:abort_on_target_owner_change(true);
				blood_voyage_inv:start_invasion(
				function(self)
					local force_leader = self:get_general();
					local local_faction = cm:get_local_faction_name(true);
				
					if local_faction == "wh2_main_def_har_ganeth" then
						cm:scroll_camera_from_current(false, 3, {force_leader:display_position_x(), force_leader:display_position_y(), 14.768, 0.0, 12.0});
					end
					
					blood_voyage.active = true;
					
					cm:force_alliance("wh2_main_def_har_ganeth", "wh2_dlc10_def_blood_voyage", true);
					cm:add_character_vfx(force_leader:command_queue_index(), "scripted_effect6", false);
				end,
				true, false, false
				);
				
				cm:force_diplomacy("all", "faction:wh2_dlc10_def_blood_voyage", "all", false, false, true);
				cm:force_diplomacy("faction:wh2_main_def_har_ganeth", "faction:wh2_dlc10_def_blood_voyage", "join war", true, true, false);
				cm:force_diplomacy("all", "faction:wh2_dlc10_def_blood_voyage", "war", true, true, false);
				blood_voyage.target = defender_of_ulthuan_faction;
				blood_voyage.human = false;
			end
		else
			defender_of_ulthuan_initialize(false);
		end
	end
end

function defender_of_ulthuan_initialize(new_game)
	local campaign_key = "main_warhammer";
	local ulthuan_types = {"inner", "outer"};
	
	if cm:model():campaign_name("wh2_main_great_vortex") then
		campaign_key = "wh2_main_great_vortex";
		ulthuan_regions["main_warhammer"] = nil;
	else
		ulthuan_regions["wh2_main_great_vortex"] = nil;
	end
	
	-- Populate a lookup table of all relevant regions
	ulthuan_regions["all"] = {};
	
	for i = 1, #ulthuan_types do
		for region_key, value in pairs(ulthuan_regions[campaign_key][ulthuan_types[i]]) do
			ulthuan_regions["all"][region_key] = true;
			local region = cm:model():world():region_manager():region_by_key(region_key);
			
			if region:is_null_interface() == false then
				if region:is_abandoned() == true or region:owning_faction():culture() ~= "wh2_main_hef_high_elves" then
					ulthuan_regions[campaign_key][ulthuan_types[i]][region_key] = false;
					ulthuan_regions[campaign_key][ulthuan_types[i].."_lost"] = ulthuan_regions[campaign_key][ulthuan_types[i].."_lost"] + 1;
				end
			end
		end
	end
	
	defender_of_ulthuan_remove_effects(defender_of_ulthuan_faction);
	
	if ulthuan_regions[campaign_key]["inner_lost"] > 0 then
		if new_game == true then
			defender_of_ulthuan_level = 1;
		end
		defender_of_ulthuan_effect = "wh2_dlc10_defender_of_ulthuan_inner";
		cm:apply_effect_bundle(defender_of_ulthuan_effect.."_"..defender_of_ulthuan_level, defender_of_ulthuan_faction, 0);
	elseif ulthuan_regions[campaign_key]["outer_lost"] > 0 then
		if new_game == true then
			defender_of_ulthuan_level = 1;
		end
		defender_of_ulthuan_effect = "wh2_dlc10_defender_of_ulthuan_outer";
		cm:apply_effect_bundle(defender_of_ulthuan_effect.."_"..defender_of_ulthuan_level, defender_of_ulthuan_faction, 0);
	else
		if new_game == true then
			defender_of_ulthuan_level = 1;
		end
		defender_of_ulthuan_effect = "wh2_dlc10_defender_of_ulthuan_all";
		cm:apply_effect_bundle(defender_of_ulthuan_effect.."_"..defender_of_ulthuan_level, defender_of_ulthuan_faction, 0);
	end
end

function defender_of_ulthuan_update(region)
	if region ~= nil and region:is_null_interface() == false then
		local region_key = region:name();
		out("Defender of Ulthuan Region Update: "..region_key);
		local ulthuan_type = nil;
		local campaign_key = "main_warhammer";
		
		if cm:model():campaign_name("wh2_main_great_vortex") then
			campaign_key = "wh2_main_great_vortex";
		end
		
		if ulthuan_regions[campaign_key]["outer"][region_key] ~= nil then
			ulthuan_type = "outer";
		elseif ulthuan_regions[campaign_key]["inner"][region_key] ~= nil then
			ulthuan_type = "inner";
		end
		
		if ulthuan_type ~= nil then
			if ulthuan_regions[campaign_key][ulthuan_type][region_key] == true then
				if region:is_abandoned() == true or region:owning_faction():culture() ~= "wh2_main_hef_high_elves" then
					ulthuan_regions[campaign_key][ulthuan_type][region_key] = false;
					ulthuan_regions[campaign_key][ulthuan_type.."_lost"] = ulthuan_regions[campaign_key][ulthuan_type.."_lost"] + 1;
					out("\tRegion was true and is now false - Value "..ulthuan_type.."_lost count is "..tostring(ulthuan_regions[campaign_key][ulthuan_type.."_lost"]).." (+1)");
				end
			elseif ulthuan_regions[campaign_key][ulthuan_type][region_key] == false then
				-- VANDY OVERWRITE, check if the region isn't ruined and is owned by helves
				if not region:is_abandoned() and region:owning_faction():culture() == "wh2_main_hef_high_elves" then
					ulthuan_regions[campaign_key][ulthuan_type][region_key] = true;
					ulthuan_regions[campaign_key][ulthuan_type.."_lost"] = ulthuan_regions[campaign_key][ulthuan_type.."_lost"] - 1;
					out("\tRegion was false and is now true - Value "..ulthuan_type.."_lost count is "..tostring(ulthuan_regions[campaign_key][ulthuan_type.."_lost"]).." (-1)");
				end
			else
				out("\tNo changes made");
			end
			
			defender_of_ulthuan_remove_effects(defender_of_ulthuan_faction);
			
			if ulthuan_regions[campaign_key]["inner_lost"] > 0 then
				if defender_of_ulthuan_effect == "wh2_dlc10_defender_of_ulthuan_all" or defender_of_ulthuan_effect == "wh2_dlc10_defender_of_ulthuan_outer" then
					defender_of_ulthuan_show_event(region, "inner_lost");
					core:trigger_event("ScriptEventDefenderOfUlthuanInnerLost");
				end
				defender_of_ulthuan_level = 1;
				defender_of_ulthuan_effect = "wh2_dlc10_defender_of_ulthuan_inner";
			elseif ulthuan_regions[campaign_key]["outer_lost"] > 0 then
				if defender_of_ulthuan_effect == "wh2_dlc10_defender_of_ulthuan_all" then
					defender_of_ulthuan_show_event(region, "outer_lost");
					core:trigger_event("ScriptEventDefenderOfUlthuanOuterLost");
				elseif defender_of_ulthuan_effect == "wh2_dlc10_defender_of_ulthuan_inner" then
					core:trigger_event("ScriptEventDefenderOfUlthuanInnerRegained");
				end
				defender_of_ulthuan_level = 1;
				defender_of_ulthuan_effect = "wh2_dlc10_defender_of_ulthuan_outer";
			else
				if defender_of_ulthuan_effect == "wh2_dlc10_defender_of_ulthuan_outer" or defender_of_ulthuan_effect == "wh2_dlc10_defender_of_ulthuan_inner" then
					defender_of_ulthuan_show_event(region, "united");
					core:trigger_event("ScriptEventDefenderOfUlthuanUnited");
				end
				defender_of_ulthuan_level = 1;
				defender_of_ulthuan_effect = "wh2_dlc10_defender_of_ulthuan_all";
			end
			
			cm:apply_effect_bundle(defender_of_ulthuan_effect.."_"..defender_of_ulthuan_level, defender_of_ulthuan_faction, 0);
		end
	end
end

function defender_of_ulthuan_remove_effects(faction_str)
	local effects = {"inner", "outer", "all"};
	local faction = cm:get_faction(faction_str);
	
	for i = 1, 10 do
		for j = 1, #effects do
			local effect_bundle = "wh2_dlc10_defender_of_ulthuan_" .. effects[j] .. "_" .. i;
			
			if faction:has_effect_bundle(effect_bundle) then
				cm:remove_effect_bundle(effect_bundle, faction_str);
			end
		end
	end
end

function defender_of_ulthuan_show_event(region, event_type)
	if event_type == "united" then
		cm:show_message_event(
			defender_of_ulthuan_faction,
			"event_feed_strings_text_".."wh2_dlc10_event_feed_string_scripted_event_defender_of_ulthuan_title",
			"event_feed_strings_text_".."wh2_dlc10_event_feed_string_scripted_event_defender_of_ulthuan_united_primary_detail",
			"event_feed_strings_text_".."wh2_dlc10_event_feed_string_scripted_event_defender_of_ulthuan_united_secondary_detail",
			false,
			1012
		);
	else
		local x = region:settlement():logical_position_x();
		local y = region:settlement():logical_position_y();
	
		cm:show_message_event_located(
			defender_of_ulthuan_faction,
			"event_feed_strings_text_".."wh2_dlc10_event_feed_string_scripted_event_defender_of_ulthuan_title",
			"event_feed_strings_text_".."wh2_dlc10_event_feed_string_scripted_event_defender_of_ulthuan_"..event_type.."_primary_detail",
			"event_feed_strings_text_".."wh2_dlc10_event_feed_string_scripted_event_defender_of_ulthuan_"..event_type.."_secondary_detail",
			x,
			y,
			false,
			1013
		);
	end
end
--------------------------------------------------------------
----------------------- SAVING / LOADING ---------------------
--------------------------------------------------------------
cm:add_saving_game_callback(
	function(context)
		cm:save_named_value("defender_of_ulthuan_level", defender_of_ulthuan_level, context);
		cm:save_named_value("power_of_nature_regions", power_of_nature_regions, context);
		cm:save_named_value("mortal_worlds_torment_last_effect", mortal_worlds_torment_last_effect, context);
	end
);

cm:add_loading_game_callback(
	function(context)
		defender_of_ulthuan_level = cm:load_named_value("defender_of_ulthuan_level", 1, context);
		power_of_nature_regions = cm:load_named_value("power_of_nature_regions", {}, context);
		mortal_worlds_torment_last_effect = cm:load_named_value("mortal_worlds_torment_last_effect", "wh2_dlc10_bundle_alarielle_corruption_0", context);
	end
);