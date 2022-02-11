local vlad_character_subtype_key = "dlc04_vmp_vlad_con_carstein"
local isablle_character_subtype_key = "pro02_vmp_isabella_von_carstein"
local vampire_subculture_key = "wh_main_sc_vmp_vampire_counts"
local bundle_name = "wh_pro02_undying_love_bundle"

function add_vlad_isabella_listeners()	
	-- lock the conderation options for rival vampire counts
	cm:force_diplomacy("faction:wh_main_vmp_rival_sylvanian_vamps", "faction:wh_main_vmp_vampire_counts", "form confederation", false, false, true)
	cm:force_diplomacy("faction:wh_main_vmp_rival_sylvanian_vamps", "faction:wh_main_vmp_schwartzhafen", "form confederation", false, false, true)
	
	-- apply the effect bundle
	core:add_listener(
		"apply_couple_bundle_on_PendingBattle",
		"PendingBattle",
		true,
		function(context)
			add_undying_love_bundle(context)
		end,
		true
	)
	
	-- remove the effect bundle
	core:add_listener(
		"remove_couple_bundle_CharacterCompletedBattle",
		"CharacterCompletedBattle",
		true,
		function(context)
			remove_undying_love_bundle(context:character())
		end,
		true
	)
	core:add_listener(
		"remove_couple_bundle_CharacterTurnStart",
		"CharacterTurnStart",
		true,
		function(context)
			remove_undying_love_bundle(context:character())
		end,
		true
	)
end

function add_undying_love_bundle(context)
	local pb = context:pending_battle()
	local all_attackers 
	local all_defenders 
	local couple_cqi = {}

	if pb:has_attacker() then
		all_attackers = {pb:attacker()}
		local reinforce_attackers = pb:secondary_attackers()
		if reinforce_attackers:num_items() >= 1 then
			for i = 0, reinforce_attackers:num_items() - 1 do
				table.insert(all_attackers, reinforce_attackers:item_at(i))
			end
		end
	end
	if pb:has_defender() then
		all_defenders = {pb:defender()}
		local reinforce_defenders = pb:secondary_defenders()
		if reinforce_defenders:num_items() >= 1 then
			for i = 0, reinforce_defenders:num_items() - 1 do
				table.insert(all_defenders, reinforce_defenders:item_at(i))
			end
		end
	end
	
	for i = 1, #all_attackers do
		local current_attacker = all_attackers[i]
		if current_attacker:character_subtype_key() == vlad_character_subtype_key or current_attacker:character_subtype_key() == isablle_character_subtype_key then
			table.insert(couple_cqi, current_attacker:military_force():command_queue_index())
			remove_undying_love_bundle(current_attacker)
		end
	end
	
	for i = 1, #all_defenders do
		local current_defender = all_defenders[i]
		
		if current_defender:character_subtype_key() == vlad_character_subtype_key or current_defender:character_subtype_key() == isablle_character_subtype_key then
			table.insert(couple_cqi, current_defender:military_force():command_queue_index())
			remove_undying_love_bundle(current_defender)
		end
	end
	
	if #couple_cqi >= 2 then
		for i = 1, 2 do
			local mf = cm:get_military_force_by_cqi(couple_cqi[i])
			if not mf:has_effect_bundle(bundle_name) and pb:night_battle() == false then
				cm:apply_effect_bundle_to_force(bundle_name, couple_cqi[i], 0)
			end
		end
	end
end

function remove_undying_love_bundle(character)
	-- in case vlad or isabella are wounded post battle make sure the effect bundle is removed from all vampire forces
	if character:faction():subculture() == vampire_subculture_key and character:has_military_force() then
		local mf = character:military_force()
			
		if mf:has_effect_bundle(bundle_name) then
			cm:remove_effect_bundle_from_force(bundle_name, mf:command_queue_index())
		end
	end
end