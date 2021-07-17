-- Blood Kiss from defeating Faction Leaders
function vampire_bloodline_faction_leader_killed(context)
	local pending_battle = cm:model():pending_battle()
	
	if pending_battle:is_active() == true then

		local attacker = pending_battle:attacker()
		local defender = pending_battle:defender()
		local attacker_result = pending_battle:attacker_battle_result()
		local defender_result = pending_battle:defender_battle_result()
		local attacker_won = (attacker_result == "heroic_victory") or (attacker_result == "decisive_victory") or (attacker_result == "close_victory") or (attacker_result == "pyrrhic_victory")
		local defender_won = (defender_result == "heroic_victory") or (defender_result == "decisive_victory") or (defender_result == "close_victory") or (defender_result == "pyrrhic_victory")
		
		local attacker_died = false
		local attacker_leader = false
		local defender_died = false
		local defender_leader = false
		
		local num_attackers = cm:pending_battle_cache_num_attackers()
		local num_defenders = cm:pending_battle_cache_num_defenders()
	
		if pending_battle:night_battle() == true then
			num_attackers = 1
			num_defenders = 1
		end

		if attacker:is_null_interface() == false then
			attacker_died = attacker:command_queue_index() == context:character():command_queue_index()
			attacker_leader = attacker:is_faction_leader()
			if not attacker_died then
				for i = 1, num_attackers do
					local this_char_cqi, this_mf_cqi, current_faction_name = cm:pending_battle_cache_get_attacker(i)
					attacker = cm:model():character_for_command_queue_index(this_char_cqi)
					attacker_leader = attacker:is_faction_leader()
					attacker_died = this_char_cqi == context:character():command_queue_index()
					if attacker_died then
						break
					end
				end
			end
		end
		if defender:is_null_interface() == false then
			defender_died = defender:command_queue_index() == context:character():command_queue_index()
			defender_leader = defender:is_faction_leader()
			if not defender_died then
				for i = 1, num_defenders do
					local this_char_cqi, this_mf_cqi, current_faction_name = cm:pending_battle_cache_get_defender(i)
					defender = cm:model():character_for_command_queue_index(this_char_cqi)
					defender_leader = defender:is_faction_leader()
					defender_died = this_char_cqi == context:character():command_queue_index()
					if defender_died then
						break
					end
				end
			end
		end

		if attacker_won == true and defender_died == true and defender_leader == true and attacker:is_null_interface() == false and attacker:faction():subculture() == "wh_main_sc_vmp_vampire_counts" then
			cm:faction_add_pooled_resource(attacker:faction():name(), "vmp_blood_kiss", "wh2_dlc11_vmp_resource_factor_enemy_general_killed", 1)
			first_blood_kiss_gained(attacker:faction())
		elseif defender_won == true and attacker_died == true and attacker_leader == true and defender:is_null_interface() == false and defender:faction():subculture() == "wh_main_sc_vmp_vampire_counts" then
			cm:faction_add_pooled_resource(defender:faction():name(), "vmp_blood_kiss", "wh2_dlc11_vmp_resource_factor_enemy_general_killed", 1)
			first_blood_kiss_gained(defender:faction())
		end	
	end
end