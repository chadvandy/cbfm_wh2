local contract_faction = "wh2_main_skv_clan_eshin";
local contract_clans = {
	{key = "mors", level = 1, last_contract = 0},
	{key = "moulder", level = 1, last_contract = 0},
	{key = "pestilens", level = 1, last_contract = 0},
	{key = "skyre", level = 1, last_contract = 0}
};
local contract_council_countdown = 3;
local contract_council_countdown_reset = 10; -- The turns between every council meeting
local contract_per_turn_chance = 5;
local contract_timeout_after_issue = 10; -- The turns each contract is active for
local contract_level_2_unlock = 1;
local contract_level_3_unlock = 20;
local contract_level_weights = {50, 40, 30};
local dust_xp_gain = 1200;

function add_clan_contracts_listeners()
	out("#### Adding Clan Contracts Listeners ####");

	cm:add_faction_turn_start_listener_by_name(
		"contract_FactionTurnStart",
		contract_faction,
		function(context)
			contract_FactionTurnStart(context:faction());
		end,
		true
	);
	core:add_listener(
		"contract_RitualCompletedEvent",
		"RitualCompletedEvent",
		function(context)
			return context:performing_faction():name() == contract_faction;
		end,
		function(context)
			contract_RitualCompletedEvent(context);
		end,
		true
	);

	-- Lock all rituals at the start
	if cm:is_new_game() == true then
		local faction = cm:model():world():faction_by_key(contract_faction);

		if faction:is_null_interface() == false then
			cm:lock_rituals_in_category(faction, "ESHIN_MORS_RITUAL");
			cm:lock_rituals_in_category(faction, "ESHIN_MOULDER_RITUAL");
			cm:lock_rituals_in_category(faction, "ESHIN_PESTILENS_RITUAL");
			cm:lock_rituals_in_category(faction, "ESHIN_SKYRE_RITUAL");
		end
	end
end

function contract_FactionTurnStart(faction)
	local possible_clans = weighted_list:new();
	local turn_number = cm:model():turn_number();
	local generate_chance = contract_per_turn_chance;

	if contract_council_countdown > 1 then
		contract_council_countdown = contract_council_countdown - 1;
	else
		generate_chance = 100;
		contract_council_countdown = contract_council_countdown_reset;
	end

	--local contract_component = find_uicomponent(core:get_ui_root(), "clan_contract_tab");
	--contract_component:InterfaceFunction("SetCouncilCounter", true);
	effect.set_context_value("contract_council_counter", contract_council_countdown);

	for i = 1, #contract_clans do
		local clan = contract_clans[i];
		local rep_key = "skv_clan_"..clan.key;

		if faction:has_pooled_resource(rep_key) == true then
			local rep = faction:pooled_resource(rep_key):value();

			if clan.level < 2 then
				if rep >= contract_level_2_unlock then
					clan.level = 2;
				end
			end
			if clan.level < 3 then
				if rep >= contract_level_3_unlock then
					clan.level = 3;
				end
			end

			if turn_number > clan.last_contract then
				if cm:model():random_percent(generate_chance) then
					for j = 1, clan.level do
						for k = 1, #contract_clans do
							if contract_clans[k].key ~= clan.key then
								local contract = {clan = clan.key, target = contract_clans[k].key, level = j};
								possible_clans:add_item(contract, contract_level_weights[j]);
							end
						end
					end
				end
			end
		end
	end

	if #possible_clans.items > 0 then
		local contract = possible_clans:weighted_select();
		local ritual_key = "wh2_dlc14_eshin_contracts_"..contract.clan.."_"..contract.target.."_"..contract.level;
		cm:unlock_ritual(faction, ritual_key, contract_council_countdown_reset);
		cm:trigger_incident(faction:name(), "wh2_dlc14_incident_skv_new_contract_"..contract.clan, true, true)

		for i = 1, #contract_clans do
			if contract.clan == contract_clans[i].key then
				contract_clans[i].last_contract = cm:model():turn_number() + contract_council_countdown_reset;
				break;
			end
		end
	end
end

function contract_RitualCompletedEvent(context)
	local ritual = context:ritual();
	local ritual_category = ritual:ritual_category();

	if ritual_category == "ESHIN_MORS_RITUAL" or ritual_category == "ESHIN_MOULDER_RITUAL" or ritual_category == "ESHIN_PESTILENS_RITUAL" or ritual_category == "ESHIN_SKYRE_RITUAL" then	
		local faction = context:performing_faction();
		cm:lock_rituals_in_category(faction, ritual_category);
		contract_diplomacy_unlock(faction);
	end
end

function contract_diplomacy_unlock(faction)
	for i = 1, #contract_clans do
		local clan = contract_clans[i];
		local rep_key = "skv_clan_"..clan.key;
		if faction:has_pooled_resource(rep_key) == true then
			local rep = faction:pooled_resource(rep_key):value();
			if rep > 0 then
				cm:make_diplomacy_available(contract_faction, "wh2_main_skv_clan_"..clan.key)
			end
		end
	end
end

-- Debug
function contract(clan1, clan2, level)
	local faction = cm:model():world():whose_turn_is_it();
	local ritual_key = "wh2_dlc14_eshin_contracts_"..clan1.."_"..clan2.."_"..level;

	cm:unlock_ritual(faction, ritual_key, contract_council_countdown_reset);
	cm:trigger_incident(faction:name(), "wh2_dlc14_incident_skv_new_contract_"..clan1, true, true);
end

--------------------------------------------------------------
----------------------- SAVING / LOADING ---------------------
--------------------------------------------------------------
cm:add_saving_game_callback(
    function(context)
        cm:save_named_value("contract_clans", contract_clans, context);
        cm:save_named_value("councilTimer", contract_council_countdown, context);
    end
);
cm:add_loading_game_callback(
    function(context)
        contract_clans = cm:load_named_value("contract_clans", contract_clans, context);
        contract_council_countdown = cm:load_named_value("councilTimer", contract_council_countdown, context);
        effect.set_context_value("contract_council_counter", contract_council_countdown);
    end
);