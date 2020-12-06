cm:add_first_tick_callback(function()

	function Norsca_UniqueAgentSpawned(context)
		-- blorp
		local agent = context:unique_agent_details():character();
		
		if agent:is_null_interface() == false and agent:character_subtype("dlc08_nor_kihar") and not agent:has_ancillary("wh_dlc08_anc_mount_nor_kihar_chaos_dragon") then
			--if agent:rank() < 40 then
			--	local cqi = agent:cqi();
			--	cm:add_agent_experience("character_cqi:"..cqi, 40, true);
			--	cm:replenish_action_points("character_cqi:"..cqi);
				
				cm:callback(function()
					--for i = 1, 40 do
					--	cm:force_add_skill("character_cqi:"..cqi, "wh_dlc08_skill_kihar_dummy");
					--end
					cm:force_add_ancillary(agent, "wh_dlc08_anc_mount_nor_kihar_chaos_dragon", false, true);
				end, 0.5);
			--end
		end
	end

	function Norsca_CharacterCreated(context)
		-- nada
	end

	core:remove_listener("Bret_UniqueAgentSpawned")
	core:add_listener(
		"fix_Bret_UniqueAgentSpawned",
		"UniqueAgentSpawned",
		function(context)
			local character = context:unique_agent_details():character();

			return not character:is_null_interface() and character:character_subtype("dlc07_brt_green_knight");
		end,
		function(context)
			out("#### Unique Agent Spawned ####");
			local character = context:unique_agent_details():character();
			
			--if character:rank() < 40 then
			--	local char_str = "character_cqi:"..character:cqi();
			--	
			--	cm:add_agent_experience(char_str, 40, true);
			--	cm:replenish_action_points(char_str);
			--	
			--	for i = 1, 40 do
			--		cm:force_add_skill(char_str, "wh_dlc07_skill_green_knight_dummy");
			--	end
			--end
			
			if character:faction():is_human() and not cm:is_multiplayer() then
				-- fly camera to Green Knight
				cm:scroll_camera_from_current(false, 1, {character:display_position_x(), character:display_position_y(), 14.7, 0.0, 12.0});
			end
		end,
		true
	);

end)