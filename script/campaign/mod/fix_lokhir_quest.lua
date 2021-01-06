--lokhir quest bit
local lokhir_faction = "wh2_dlc11_def_the_blessed_dread";
local lokhir_mission = {["pre"] = {["vort"] = "wh2_dlc11_great_vortex_lokhir_helm_of_the_kraken_stage_2", ["mort"] = "wh2_dlc11_lokhir_helm_of_the_kraken_stage_2"},
						["now"] = {["vort"] = "wh2_dlc11_great_vortex_lokhir_helm_of_the_kraken_stage_3", ["mort"] = "wh2_dlc11_lokhir_helm_of_the_kraken_stage_3"},
						["aft"] = {["vort"] = "wh2_dlc11_great_vortex_lokhir_helm_of_the_kraken_stage_4", ["mort"] = "wh2_dlc11_lokhir_helm_of_the_kraken_stage_4"}
};
local lokhir_obj_key = "wh2_dlc11_objective_override_lokhir_sen_encounter";

core:remove_listener("mission_succeeded_trigger_lokhir_mission")
core:add_listener(
	"mission_succeeded_trigger_lokhir_mission",
	"MissionSucceeded",
	true,
	function(context)
		local mission_key = "";
		local next_mission_key = "";
		local lokhir_mission_happened = false;
		if context:mission():mission_record_key() == lokhir_mission["pre"]["vort"] then
			mission_key = lokhir_mission["now"]["vort"];
			next_mission_key = lokhir_mission["aft"]["vort"];
			lokhir_mission_happened = true;
		elseif context:mission():mission_record_key() == lokhir_mission["pre"]["mort"] then
			mission_key = lokhir_mission["now"]["mort"];
			next_mission_key = lokhir_mission["aft"]["mort"];
			lokhir_mission_happened = true;
		end
		if lokhir_mission_happened == true then
			local mm = mission_manager:new(lokhir_faction, mission_key);
			mm:add_new_objective("SCRIPTED");
			mm:add_condition("script_key joys_mission");
			mm:add_condition("override_text mission_text_text_"..lokhir_obj_key);

			mm:add_payload("money 2000");
			mm:set_should_whitelist(false);
			mm:trigger();
				
			encounter_listener_info[1] = true;
			encounter_listener_info[4] = mission_key;
			encounter_listener_info[5] = next_mission_key;
			
			--add the listener thing
			core:add_listener(
			"Lokhir_mission_listener",
			"AreaEntered", 
			true,
			function(context)
				local index = tonumber(string.sub(context:area_key(), 13));
				if not index then
					out("not an encounter!");
				else
					out("an encounter!");
					local character = context:character();
					local faction = character:faction();
					local faction_name = faction:name();
					out("acessing lokhir check");
					out(faction_name);
					if lokhir_faction == faction_name then
						out("it is lokhir");
						cm:complete_scripted_mission_objective(mission_key, "joys_mission", true);
						cm:trigger_mission(lokhir_faction, next_mission_key, true);
						encounter_listener_info[1] = false;
						encounter_listener_info[4] = "";
						encounter_listener_info[5] = "";
					end
				end;
			end,
			false
			);
		end
	end,
	true
);