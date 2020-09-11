local Grom_faction = "wh2_dlc15_grn_broken_axe";

local encounter_sea_location_set = {
	["main_warhammer"] = {
		{
			{136, 597}, {208, 586}, {265, 628}, {347, 575}, {262, 266}, {230, 331}, {337, 672}, {505, 706}, {128, 488},	{639, 700}, 
			{724, 659}, {379, 533}, {472, 576}, {561, 609}, {281, 556}, {308, 520}, {330, 479}, {276, 418}, {268, 504}, {234, 466}, 
			{199, 519}, {173, 452}, {310, 352}, {141, 401}, {110, 353}, { 76, 279},	{129, 298}, {111, 234}, {152, 191}, {395, 683}, 
			{224, 177}, {181, 235}, {321, 414}, {344, 382}, {350, 329}, {404, 300}, {304, 287}, {315, 242}, {265, 193}, {414, 486}, 
			{330, 211}, {395, 192}, {422, 235}, {477, 202}, {512, 152}, {543, 228}, {336, 158}, {398, 138}, {289, 140}, {241, 127}, 
			{212, 286}, {343, 111}, {236, 220}, {225,  79}, {286,  61}, {260,  24}, {366,  64}, {331,  24}, {122, 448}, { 50, 321}, 
			{604, 309}, {302, 590}, {418, 693}, {411, 518}, {361, 630}, {584, 589}, {441, 152}, {184, 324}, {289,  91}, {475, 167},
			{987, 237}, {888, 111}, {811, 196}, {981,  62}
		},
		{
			{124, 589}, {207, 585}, {265, 628}, {326, 526}, {231, 255}, {194, 314}, {370, 664}, {530, 701}, {160, 488},	{666, 696}, 
			{742, 667}, {377, 524}, {517, 589}, {181, 463}, {282, 534}, {129, 317}, {330, 479}, {303, 408}, {280, 461}, {235, 437}, 
			{199, 519}, {171, 428}, {299, 339}, {119, 371}, { 84, 359}, { 76, 274},	{125, 273}, {132, 215}, {152, 191}, {395, 683}, 
			{224, 177}, {168, 225}, {329, 427}, {369, 373}, {344, 300}, {393, 320}, {278, 271}, {315, 242}, {265, 193}, {430, 560}, 
			{330, 211}, {395, 192}, {459, 246}, {453, 183}, {537, 185}, {536, 228}, {363, 152}, {384, 106}, {304, 104}, {258, 143}, 
			{238, 308}, {298,  64}, {236, 220}, {230,  51}, {249,  82}, {291,  23}, {348,  84}, {345,  38}, {129, 421}, { 42, 317}, 
			{615, 315}, {302, 590}, {439, 690}, {521, 449}, {361, 630}, {584, 589}, {479, 148}, {239, 489}, {234, 359}, {308, 149}, 
			{933, 196}, {881, 146}, {977, 110}, {992,  48}
		}
	},
	
	["wh2_main_great_vortex"] = {
		{
			{ 16, 695}, { 10, 637}, { 38, 603}, {104, 556}, { 14, 560}, { 13, 460}, { 10, 497}, { 61, 398}, { 21, 349}, { 63, 317},
			{ 15, 393}, { 27, 291}, { 40, 234}, { 23, 175}, { 85, 120}, { 30, 134}, { 46,  83}, {161,  61}, { 89,  55}, { 31,  44},
			{ 37, 423}, {205,  37}, {252,  18}, {316,  46}, {427,  38}, {365,  77}, {145,  17}, {506, 127}, {362,  13}, {504,  25},
			{558,  23}, {606,  46}, {626,  13}, {478,  61}, {660,  41}, {710,   8}, {684,  77}, {668, 118}, {705, 167}, {473,  93},
			{540, 115}, {301, 114}, {388, 121}, {463, 152}, {377, 167}, {288, 173}, {336, 144}, {436, 190}, {284, 216}, {349, 209},
			{531, 204}, {472, 238}, {400, 213}, {324, 243}, {421,  85}, {498, 216}, {286, 262}, {406, 251}, {406, 295}, {342, 302},
			{394, 327}, {333, 180}, {323, 469}, {131, 311}, {169, 354}, {361, 277}, {292, 326}, {291, 288}, {481, 354}, {210, 315},
			{250, 348}, {216, 361}, {119, 394}, {161, 428}, {132, 474}, {186, 502}, {232, 474}, {423, 367}, {343, 362}, {322, 425},
			{210, 393}, {271, 386}, {381, 391}, {418, 456}, {401, 506}, {347, 595}, {275, 530}, {712, 374}, {664, 467}, {665, 323},
			{596, 380}, {538, 412}, {522, 463}, {481, 495}, {577, 501}, {529, 535}, {247, 425}, {428, 413}, {352, 551}, {282, 495},
			{541, 619}, {652, 359}, {605, 432}, {532, 383}, {597, 336}, {473, 412}, {377, 438},	{623, 607},	{590, 622}, {285, 452},
			{345, 505}, {213, 623}, {281, 628}, {374, 646}, {653, 508}, {703, 496}, {693, 547}, {613, 592}, {674, 613}, {696, 687},
			{625, 661}, {544, 650}, {451, 615}, {466, 660}, {404, 688}, {208, 447}, {385, 567}, {646, 396}
		},
		{
			{ 41, 700}, { 26, 637}, { 32, 595}, { 21, 541}, {103, 557}, { 17, 440}, { 25, 500}, { 53, 421}, { 21, 349}, { 76, 326},
			{ 33, 379}, { 33, 271}, { 28, 222}, { 23, 175}, { 77, 143}, { 30, 134}, { 23,  62}, {161,  61}, { 89,  55}, { 62,  23},
			{ 17, 417}, {201,  24}, {256,  43}, {316,  46}, {463,  13}, {365,  77}, {145,  17}, {506, 127}, {386,  26}, {493,  46},
			{558,  23}, {606,  46}, {626,  13}, { 85, 100}, {660,  41}, {710,   8}, {684,  77}, {668, 118}, {705, 167}, {473,  93},
			{540, 115}, {301, 114}, {388, 121}, {463, 152}, {377, 167}, {288, 173}, {336, 144}, {436, 190}, {284, 216}, {349, 209},
			{525, 203}, {462, 230}, {403, 215}, {316, 238}, {416,  89}, {493, 212}, {680, 403}, {419, 654}, {402, 295}, {332, 292},
			{395, 328}, {325, 170}, {318, 474}, {160, 301}, {184, 335}, {364, 287}, {292, 323}, {294, 279}, {490, 359}, {114, 343},
			{253, 340}, {220, 370}, {126, 436}, {123, 393}, {185, 502}, {129, 472}, {248, 467}, {416, 357}, {349, 358}, {314, 424},
			{204, 397}, {262, 386}, {391, 399}, {411, 453}, {394, 514}, {340, 586}, {282, 524}, {701, 360}, {651, 440}, {666, 317},
			{602, 377}, {544, 406}, {495, 464}, {519, 488}, {574, 507}, {505, 538}, {245, 427}, {427, 415}, {464, 340}, {287, 499},
			{537, 617}, {643, 369}, {579, 416}, {542, 382}, {655, 547}, {461, 384}, {385, 448}, {613, 606}, {597, 625}, {288, 451},
			{346, 511}, {223, 621}, {279, 623}, {365, 637}, {654, 492}, {700, 493}, {690, 541}, {656, 579}, {681, 623}, {680, 662},
			{618, 668}, {544, 652}, {452, 609}, {470, 661}, {389, 684}, {202, 455}, {384, 561}, {584, 336}
		}
	}
};

local encounter_sea_spot = {
	["index"] = 0,
	["location"] = {0, 0},
	["occupied"] = "not",
	["cd"] = 0,
	["model"] = 0,
	["event"] = ""
};

local encounter_starting_faction = "";

local encounter_events = {
	["treasure"] = {
		"wh2_main_incident_encounter_at_sea_1",
		"wh2_main_incident_encounter_at_sea_2",
		"wh2_main_incident_encounter_at_sea_3",
		"wh2_main_incident_encounter_at_sea_4"
	},
	
	["marker"] = {
		"wh2_main_dilemma_encounter_at_sea_1",
		"wh2_main_dilemma_encounter_at_sea_2",
		"wh2_main_dilemma_encounter_at_sea_3",
		"wh2_main_dilemma_encounter_at_sea_4"
	}
};

--neo counters, corresponding info, including reward, chance of battle, enemy size, treausre map chance(only cst), extra loot event
local treausre_map_drop_rate = {30 , 50};

local neo_counters = {
	["wh2_main_incident_encounter_at_sea_1_a"] = {"wh2_dlc11_dilemma_neo_encounter_at_sea_1_a", 100, 10, treausre_map_drop_rate[1],"wh2_dlc11_neo_counter_extra_loot", "wh2_dlc11_incident_neo_encounter_at_sea_1_a"},
	["wh2_main_incident_encounter_at_sea_1_b"] = {"wh2_dlc11_dilemma_neo_encounter_at_sea_1_b", 100, 10, treausre_map_drop_rate[1],"wh2_dlc11_neo_counter_extra_loot", "wh2_dlc11_incident_neo_encounter_at_sea_1_b"},
	["wh2_main_incident_encounter_at_sea_1_c"] = {"wh2_dlc11_dilemma_neo_encounter_at_sea_1_c", 100, 10, treausre_map_drop_rate[1],"wh2_dlc11_neo_counter_extra_loot", "wh2_dlc11_incident_neo_encounter_at_sea_1_c"},
	["wh2_main_incident_encounter_at_sea_2_a"] = {"wh2_dlc11_dilemma_neo_encounter_at_sea_2_a", 100, 10, treausre_map_drop_rate[1],"wh2_dlc11_neo_counter_extra_loot", "wh2_dlc11_incident_neo_encounter_at_sea_2_a"},
	["wh2_main_incident_encounter_at_sea_2_b"] = {"wh2_dlc11_dilemma_neo_encounter_at_sea_2_b", 100, 10, treausre_map_drop_rate[1],"wh2_dlc11_neo_counter_extra_loot", "wh2_dlc11_incident_neo_encounter_at_sea_2_b"},
	["wh2_main_incident_encounter_at_sea_2_c"] = {"wh2_dlc11_dilemma_neo_encounter_at_sea_2_c", 100, 10, treausre_map_drop_rate[1],"wh2_dlc11_neo_counter_extra_loot", "wh2_dlc11_incident_neo_encounter_at_sea_2_c"},
	["wh2_main_incident_encounter_at_sea_3_a"] = {"wh2_dlc11_dilemma_neo_encounter_at_sea_3_a", 100, 10, treausre_map_drop_rate[1],"wh2_dlc11_neo_counter_extra_loot", "wh2_dlc11_incident_neo_encounter_at_sea_3_a"},
	["wh2_main_incident_encounter_at_sea_3_b"] = {"wh2_dlc11_dilemma_neo_encounter_at_sea_3_b", 100, 10, treausre_map_drop_rate[1],"wh2_dlc11_neo_counter_extra_loot", "wh2_dlc11_incident_neo_encounter_at_sea_3_b"},
	["wh2_main_incident_encounter_at_sea_3_c"] = {"wh2_dlc11_dilemma_neo_encounter_at_sea_3_c", 100, 10, treausre_map_drop_rate[1],"wh2_dlc11_neo_counter_extra_loot", "wh2_dlc11_incident_neo_encounter_at_sea_3_c"},
	["wh2_main_incident_encounter_at_sea_4_a"] = {"wh2_dlc11_dilemma_neo_encounter_at_sea_4_a", 100, 16, treausre_map_drop_rate[2],"wh2_dlc11_neo_counter_extra_loot", "wh2_dlc11_incident_neo_encounter_at_sea_4_a"}
};

local neo_counters_list = {
	"wh2_dlc11_dilemma_neo_encounter_at_sea_1_a", 
	"wh2_dlc11_dilemma_neo_encounter_at_sea_1_b",
	"wh2_dlc11_dilemma_neo_encounter_at_sea_1_c",
	"wh2_dlc11_dilemma_neo_encounter_at_sea_2_a",
	"wh2_dlc11_dilemma_neo_encounter_at_sea_2_b",
	"wh2_dlc11_dilemma_neo_encounter_at_sea_2_c",
	"wh2_dlc11_dilemma_neo_encounter_at_sea_3_a",
	"wh2_dlc11_dilemma_neo_encounter_at_sea_3_b",
	"wh2_dlc11_dilemma_neo_encounter_at_sea_3_c",
	"wh2_dlc11_dilemma_neo_encounter_at_sea_4_a"
};

local encounter_events_details = {
	["wh2_main_incident_encounter_at_sea_1"] = {
		["weight"] = 10,
		["variation"] = {"_a", "_b", "_c"},
		["model"] = {1, 4, 24, 27},
		["payloads"] = {}
	},
	
	["wh2_main_incident_encounter_at_sea_2"] = {
		["weight"] = 10,
		["variation"] = {"_a", "_b", "_c"},
		["model"] = {3, 28, 29, 30, 31},
		["payloads"] = {}
	},
	
	["wh2_main_incident_encounter_at_sea_3"] = {
		["weight"] = 10,
		["variation"] = {"_a", "_b", "_c"},
		["model"] = {2, 25, 26},
		["payloads"] = {}
	},
	
	["wh2_main_incident_encounter_at_sea_4"] = {
		["weight"] = 10,
		["variation"] = {"_a"},
		["model"] = {11},
		["payloads"] = {}
	},
	
	["wh2_main_dilemma_encounter_at_sea_1"] = {
		["weight"] = 10,
		["variation"] = {"", "_a"},
		["model"] = {5, 6, 7, 8},
		["payloads"] = {
			{"wh2_main_encounter_at_sea_combat_1", "wh2_main_encounter_at_sea_combat_2"},
			{"wh2_main_encounter_at_sea_campaign_2", "wh2_main_encounter_at_sea_campaign_3"}
		}
	},
	
	["wh2_main_dilemma_encounter_at_sea_2"] = {
		["weight"] = 10,
		["variation"] = {"", "_a"},
		["model"] = {9, 10, 18},
		["payloads"] = {
			{"wh2_main_encounter_at_sea_combat_3", "wh2_main_encounter_at_sea_combat_4"},
			{"wh2_main_encounter_at_sea_campaign_1", "wh2_main_encounter_at_sea_campaign_2"}
		}
	},
	
	["wh2_main_dilemma_encounter_at_sea_3"] = {
		["weight"] = 10,
		["variation"] = {"", "_a"},
		["model"] = {12, 23, 32},
		["payloads"] = {
			{"wh2_main_encounter_at_sea_combat_4", "wh2_main_encounter_at_sea_combat_5"},
			{"wh2_main_encounter_at_sea_campaign_1", "wh2_main_encounter_at_sea_campaign_4"}
		}
	},
	
	["wh2_main_dilemma_encounter_at_sea_4"] = {
		["weight"] = 10,
		["variation"] = {"", "_a"},
		["model"] = {13, 15, 16, 17, 19, 20, 21, 22},
		["payloads"] = {
			{"wh2_main_encounter_at_sea_combat_1", "wh2_main_encounter_at_sea_combat_2"},
			{"wh2_main_encounter_at_sea_campaign_3", "wh2_main_encounter_at_sea_campaign_2"}
		}
	}
};

local encounter_pirate_faction = "wh2_dlc11_cst_vampire_coast_encounters";

local alternative_encounter_pirate_faction = "wh2_main_def_dark_elves_qb1";

local encounter_listener_info = {false, false, false, "", "", "", ""};

local encounter_listener_info_default = {false, false, false, "", "", "", ""};

local encounter_sea_spots = {};

local encounter_turn_recorder = 0;

local encounter_number_per_turn = 0.03;

local encounter_number_start = 0.17;

local encounter_number_treasure = 0.45;

local encounter_spot_base_cd = 8;

local encounter_effect_length = 10; 

local encounter_spawn_interval = 5;

local encounter_target = 0;

local temp_char = nil; 

local temp_loc = nil;

local temp_event = nil;

local encounter_effect_keys = {
	["combat"] = {
		"wh2_main_encounter_at_sea_combat_1",
		"wh2_main_encounter_at_sea_combat_2",
		"wh2_main_encounter_at_sea_combat_3",
		"wh2_main_encounter_at_sea_combat_4",
		"wh2_main_encounter_at_sea_combat_5"
	},
	
	["campaign"] = {
		"wh2_main_encounter_at_sea_campaign_1",
		"wh2_main_encounter_at_sea_campaign_2",
		"wh2_main_encounter_at_sea_campaign_3",
		"wh2_main_encounter_at_sea_campaign_4"
	}
};

function renew_effect_bundle(char_cqi, effect_bundle)
	cm:remove_effect_bundle_from_force(effect_bundle, char_cqi);
	cm:apply_effect_bundle_to_force(effect_bundle, char_cqi, encounter_effect_length);
end;

function get_available_encounter_spots()
	local available_spots = {};
	
	if #encounter_sea_spots > 0 then
		for i = 1,#encounter_sea_spots do
			if encounter_sea_spots[i]["cd"] == 0 and encounter_sea_spots[i]["occupied"] == "not" then
				table.insert(available_spots, encounter_sea_spots[i]["index"]);
			end;
		end;
		
		return available_spots;
	else
		return false;
	end;
end;

function populate_sea_spots(category, number_of_spots)
	local available_spots = get_available_encounter_spots();
	
	if number_of_spots > 0 and #available_spots >= number_of_spots then
		for i = 1,number_of_spots do
			local index = cm:random_number(#available_spots);
			local event_key = encounter_events[category][cm:random_number(#encounter_events[category])];
			local model_index = encounter_events_details[event_key]["model"][cm:random_number(#encounter_events_details[event_key]["model"])];
			
			encounter_sea_spots[available_spots[index]]["occupied"] = category;
			
			cm:add_interactable_campaign_marker("test_marker_" .. encounter_sea_spots[available_spots[index]]["index"], "encounter_marker_" .. tostring(model_index), encounter_sea_spots[available_spots[index]]["location"][1], encounter_sea_spots[available_spots[index]]["location"][2], 4, "", "");
			
			encounter_sea_spots[available_spots[index]]["model"] = model_index;
			
			if #encounter_events_details[event_key]["variation"] == 0 then
				encounter_sea_spots[available_spots[index]]["event"] = event_key;
			else
				encounter_sea_spots[available_spots[index]]["event"] = event_key .. encounter_events_details[event_key]["variation"][cm:random_number(#encounter_events_details[event_key]["variation"])];
			end;
			
			table.remove(available_spots, index);
		end;
	end;
end;

function get_number_of_occupied_spots_with_category(category)
	local counter = 0;
	
	for i = 1, #encounter_sea_spots do
		if encounter_sea_spots[i]["occupied"] == category then
			counter = counter + 1;
		end;
	end;
	
	return counter;
end;


core:add_listener(
	"faction_turn_start_populate_sea_spots",
	"FactionTurnStart",
	true,
	function(context)
		local turn_number = cm:model():turn_number();
		
		if turn_number == 1 and encounter_turn_recorder == 0 then
			local rand_set = cm:random_number(2);
			local campaign_key = "";
			
			if cm:model():campaign_name("main_warhammer") then
				campaign_key = "main_warhammer";
			elseif cm:model():campaign_name("wh2_main_great_vortex") then
				campaign_key = "wh2_main_great_vortex";
			else
				script_error("ERROR: Trying to set encounters at sea, but could not find the campaign name!");
				return;
			end;
			
			local chosen_coordinate_set = encounter_sea_location_set[campaign_key][rand_set];
			
			for i = 1, #chosen_coordinate_set do
				local spot = {
					["index"] = i,
					["location"] = chosen_coordinate_set[i],
					["occupied"] = "not",
					["cd"] = 0
				};
				
				table.insert(encounter_sea_spots, spot);
			end;
			
			populate_sea_spots("treasure", math.floor(encounter_number_start * #encounter_sea_spots));
			populate_sea_spots("marker", math.floor(encounter_number_start * #encounter_sea_spots));
			
			encounter_starting_faction = context:faction():name();
		elseif turn_number ~= encounter_turn_recorder and turn_number % encounter_spawn_interval ==0 then
			for i = 1, #encounter_sea_spots do
				if encounter_sea_spots[i]["cd"] > 0 then
					encounter_sea_spots[i]["cd"] = encounter_sea_spots[i]["cd"] - 1;
				end;
			end;
			
			if get_number_of_occupied_spots_with_category("treasure") < math.floor(encounter_number_treasure * #encounter_sea_spots) then
				populate_sea_spots("treasure",  math.floor(encounter_number_per_turn * #encounter_sea_spots));
			end;
			
			populate_sea_spots("marker", math.floor(encounter_number_per_turn * #encounter_sea_spots));
		end;
		
		encounter_turn_recorder = turn_number;
	end,
	true
);


function TriggerEncounterIncident(faction, incident)
	out("triggered encounter incident");
	if faction:subculture() == "wh2_dlc09_sc_tmb_tomb_kings" then
		cm:trigger_incident(faction:name(), incident.."_tmb", true);
	elseif faction:subculture() == "wh_main_sc_nor_norsca" then
		cm:trigger_incident(faction:name(), incident.."_nor", true);
	else
		cm:trigger_incident(faction:name(), incident, true);
	end
	
	--check aranessa skill
	if neo_counters[incident] ~= nil then
		local skill_found = false;
		if faction:character_list():num_items() >= 1 then
			for i = 1, faction:character_list():num_items() do
				if faction:character_list():item_at(i-1):character_subtype_key() == "wh2_dlc11_cst_aranessa" and faction:character_list():item_at(i-1):has_skill("wh2_dlc11_skill_cst_aranessa_unique_5") then
					--trigger extra loot event
					if neo_counters[incident][5] ~= nil then
						out(neo_counters[incident][5]);
						cm:callback(function()
							cm:trigger_incident(faction:name(), neo_counters[incident][5], true);
						end, 0.5);
					end
				end
			end
		end
		
		--check treasure map drops
		if faction:subculture() == "wh2_dlc11_sc_cst_vampire_coast" then
				if neo_counters[incident][4] ~= nil then
					TriggerTreasureMapMission(faction:name(), neo_counters[incident][4])
				end
		end
	end
end


core:add_listener(
	"dilemma_choice_made_event_trigger_counter_at_sea_incident",
	"DilemmaChoiceMadeEvent",
	true,
	function(context)
		local choice = context:choice();
		local dilemma = context:dilemma();
		local whose_turn_is_it_name = cm:model():world():whose_turn_is_it():name();
		local whose_turn_is_it = cm:model():world():whose_turn_is_it();
		
		out("encounter_target is"..encounter_target);
		--for old timie dilemmas
		for i = 1, #encounter_events["marker"] do
			if #encounter_events_details[encounter_events["marker"][i]]["variation"] == 0 then
				if dilemma == encounter_events["marker"][i] then
					local event_key = encounter_events["marker"][i];
					local payload_index = choice + 1;
					
					if #encounter_events_details[event_key]["payloads"][payload_index] > 0 then
						local rand_number = cm:random_number(#encounter_events_details[event_key]["payloads"][payload_index]);
						
						renew_effect_bundle(encounter_target, encounter_events_details[event_key]["payloads"][payload_index][rand_number]);
						cm:trigger_incident(whose_turn_is_it_name, encounter_events_details[event_key]["payloads"][payload_index][rand_number], true);
					end;
				end;
			else
				for j = 1, #encounter_events_details[encounter_events["marker"][i]]["variation"] do
					if dilemma == encounter_events["marker"][i]..encounter_events_details[encounter_events["marker"][i]]["variation"][j] then
						local event_key = encounter_events["marker"][i];
						local payload_index = choice + 1;
						
						if #encounter_events_details[event_key]["payloads"][payload_index] > 0 then
							local rand_number = cm:random_number(#encounter_events_details[event_key]["payloads"][payload_index]);
							
							renew_effect_bundle(encounter_target, encounter_events_details[event_key]["payloads"][payload_index][rand_number]);
							TriggerEncounterIncident(cm:model():world():whose_turn_is_it(), encounter_events_details[event_key]["payloads"][payload_index][rand_number]);
						end;
					end;
				end;
			end;
		end;
		
		--for neo dilemmas
		for i = 1, #neo_counters_list do
			if dilemma == neo_counters_list[i] then
				if choice == 0 then
					if neo_counters[encounter_listener_info[7]][2] >= cm:random_number(100) then					
						local x, y = cm:find_valid_spawn_location_for_character_from_position(cm:model():world():whose_turn_is_it():name(), temp_loc[1], temp_loc[2], false);
						
						GenerateEncounterPirate(temp_char, {x, y}, neo_counters[encounter_listener_info[7]][3]);
						SetupEncounterPostbattle(encounter_listener_info[7], whose_turn_is_it);
					else
						TriggerEncounterIncident(whose_turn_is_it, encounter_listener_info[7]);
						encounter_listener_info[3] = false;
						encounter_listener_info[6] = "";
						encounter_listener_info[7] = "";
					end
				else
					TriggerEncounterIncident(whose_turn_is_it, neo_counters[encounter_listener_info[7]][6]);
					encounter_listener_info[3] = false;
					encounter_listener_info[6] = "";
					encounter_listener_info[7] = "";
				end
			end
		end
	end,
	true
);


function Remodulate(vector, desired_mag)
	local mag = math.sqrt(vector[1] * vector[1] + vector[2] * vector[2]);
	local result_vector = {0,0};
	local scale = desired_mag/mag; 
	if vector[1] == 0 and vector[2] == 0 then
		vector[1] = 1;
		vector[2] = 1;
	end
	result_vector[1] = math.ceil(vector[1] * scale);
	result_vector[2] = math.ceil(vector[2] * scale);
	return result_vector; 
end


core:add_listener(
	"incident_event_encounter_at_sea_add_agent_experience",
	"IncidentEvent",
	true,
	function(context)
		local incident = context:dilemma();
		
		if incident == "wh2_main_incident_encounter_at_sea_1_b" or incident == "wh2_main_incident_encounter_at_sea_2_b" or incident == "wh2_main_incident_encounter_at_sea_3_b" then
			cm:add_agent_experience(cm:char_lookup_str(encounter_target), 1500);
		end;
	end,
	true
);


core:add_listener(
	"incident_occurred_event_encounter_at_sea_remove_effect_bundle",
	"IncidentOccuredEvent",
	true,
	function(context)
		local incident = context:dilemma();
		local whose_turn_is_it_name = cm:model():world():whose_turn_is_it():name();
		
		cm:callback(function()
			for i = 1, #encounter_effect_keys["combat"] do
				if incident == encounter_effect_keys["combat"][i] then
					cm:remove_effect_bundle(incident .. "_dummy", whose_turn_is_it_name);
				end;
			end;	
			for i = 1, #encounter_effect_keys["campaign"] do
				if incident == encounter_effect_keys["campaign"][i] then
					cm:remove_effect_bundle(incident .. "_dummy", whose_turn_is_it_name);
				end;
			end;
		end, 0.5);
	end,
	true
);


core:add_listener(
	"area_entered_trigger_encounter_at_sea",
	"AreaEntered",
	true,
	function(context)
		local index = tonumber(string.sub(context:area_key(), 13));
		
		if not index then
			return;
		end;
		
		out("encounter being triggered");
		
		local character = context:character();
		local faction = character:faction();
		local faction_name = faction:name();
		
		if cm:char_is_general_with_army(character) then
			TriggerEncounter(index, context);
		end;
	end,
	true
);

core:add_listener(
	"pending_battle_trigger_encounter_at_sea_ui_lock",
	"PendingBattle",
	true,
	function(context)
		local found_encounter_faction = false; 
		
		if cm:pending_battle_cache_num_attackers() >= 1 then
			for i = 1, cm:pending_battle_cache_num_attackers() do
				local this_char_cqi, this_mf_cqi, current_faction_name = cm:pending_battle_cache_get_attacker(i);
				if current_faction_name == encounter_pirate_faction then
					found_encounter_faction = true;
				end
			end
		end		
		if cm:pending_battle_cache_num_defenders() >= 1 then
			for i = 1, cm:pending_battle_cache_num_defenders() do
				local this_char_cqi, this_mf_cqi, current_faction_name = cm:pending_battle_cache_get_defender(i);
				if current_faction_name == encounter_pirate_faction then
					found_encounter_faction = true;
				end
			end
		end
		
		if found_encounter_faction == true then
			local uim = cm:get_campaign_ui_manager();
			uim:override("retreat"):lock();
			cm:disable_event_feed_events(true, "","","diplomacy_faction_destroyed");
			cm:disable_event_feed_events(true, "wh_event_category_character", "", "");
		elseif found_encounter_faction ~= true and encounter_listener_info[3] then
			-- local uim = cm:get_campaign_ui_manager();
			-- uim:override("retreat"):unlock();
			-- encounter_listener_info[3] = false;
			-- encounter_listener_info[6] = "";
			-- encounter_listener_info[7] = "";
		end
	end,
	true
);


function TriggerEncounter(index, context)
	local character = context:character();
	local faction = character:faction();
	local faction_name = faction:name();
	encounter_target = character:command_queue_index();
	local dont_remove_encounter = false;
	if faction:is_human() and cm:model():world():whose_turn_is_it():is_human() then
		if faction:name() == Grom_faction then
			core:trigger_event("ScriptEventSeaEncounterTriggeredByPlayerThatIsPlayingGrom");
		end
		if encounter_sea_spots[index]["occupied"] == "treasure" then
			local incident = encounter_sea_spots[index]["event"];
			out("this is "..incident);
			--out("checking for"..neo_counters[incident][1]);
			
			if neo_counters[incident][1] ~= "" and neo_counters[incident][1] ~= nil then
				--check if the army is in proper stance
				if character:military_force():active_stance() == "MILITARY_FORCE_ACTIVE_STANCE_TYPE_DEFAULT" then
				--if true then
					cm:trigger_dilemma(faction_name, neo_counters[incident][1]);
					temp_char = character;
					temp_loc = encounter_sea_spots[index]["location"];
					--SetupEncounterPostbattle(incident, faction);
					encounter_listener_info[3] = true;
					encounter_listener_info[6] = faction_name;
					encounter_listener_info[7] = incident;
				else
					dont_remove_encounter = true;
					--trigger eventfeed
						cm:show_message_event_located(
						faction_name,
						"event_feed_strings_text_wh2_dlc11_event_feed_string_scripted_event_passing_by_sea_encounter_title",
						"event_feed_strings_text_wh2_dlc11_event_feed_string_scripted_event_passing_by_sea_encounter_primary_details",
						"event_feed_strings_text_wh2_dlc11_event_feed_string_scripted_event_passing_by_sea_encounter_secondary_details",
						encounter_sea_spots[index]["location"][1],
						encounter_sea_spots[index]["location"][2],
						false,
						1017
						);	
				end
			else
				TriggerEncounterIncident(faction, incident);
		
				if (incident == "wh2_main_incident_encounter_at_sea_1_b" or incident == "wh2_main_incident_encounter_at_sea_2_b" or incident == "wh2_main_incident_encounter_at_sea_3_b") then
					cm:add_agent_experience(cm:char_lookup_str(encounter_target), 1500);
				end;
			end;
					
		elseif encounter_sea_spots[index]["occupied"] == "marker" then
			local dilemma = encounter_sea_spots[index]["event"];
			out("marker discovered!");
			encounter_target = character:military_force():command_queue_index();		
			cm:trigger_dilemma(faction_name, dilemma);	
		end;
	end;
	
	if dont_remove_encounter == false then
		ClearSpot(context, index);
	end
	
	
end

function ClearSpot(context, index)
	cm:remove_interactable_campaign_marker(context:area_key());
	encounter_sea_spots[index]["occupied"] = "not";
	encounter_sea_spots[index]["cd"] = encounter_spot_base_cd;
	encounter_sea_spots[index]["model"] = 0;
end


function SetupEncounterPostbattle(incident, faction)
	core:add_listener(
	"EncounterPostbattle",
	"BattleCompleted", 
	true,
	function(context)
		local found_encounter_faction = false; 
		local loot = false;
		local im = invasion_manager;
		local evasion = im:get_invasion("encounter_invasion");
		if cm:pending_battle_cache_num_attackers() >= 1 then
			for i = 1, cm:pending_battle_cache_num_attackers() do
				local this_char_cqi, this_mf_cqi, current_faction_name = cm:pending_battle_cache_get_attacker(i);
				if current_faction_name == encounter_pirate_faction then
					found_encounter_faction = true;
					if cm:model():character_for_command_queue_index(this_char_cqi):is_null_interface()==true or (cm:model():character_for_command_queue_index(this_char_cqi):is_null_interface() == false and cm:model():character_for_command_queue_index(this_char_cqi):won_battle() == false) then
						loot = true; 
					end
					if evasion ~= nil then
						cm:disable_event_feed_events(true, "","","diplomacy_faction_destroyed");
						cm:disable_event_feed_events(true, "wh_event_category_character", "", "");
						evasion:kill();
						cm:callback(function() cm:disable_event_feed_events(false, "","","diplomacy_faction_destroyed") end, 1);
						cm:callback(function() cm:disable_event_feed_events(false, "wh_event_category_character", "", "") end, 1);
					end;
				end
			end
		end		
		if cm:pending_battle_cache_num_defenders() >= 1 then
			for i = 1, cm:pending_battle_cache_num_defenders() do
				local this_char_cqi, this_mf_cqi, current_faction_name = cm:pending_battle_cache_get_defender(i);
				if current_faction_name == encounter_pirate_faction then
					found_encounter_faction = true;
					if cm:model():character_for_command_queue_index(this_char_cqi):is_null_interface()==true or (cm:model():character_for_command_queue_index(this_char_cqi):is_null_interface() == false and cm:model():character_for_command_queue_index(this_char_cqi):won_battle() == false) then
						loot = true; 
					end
					if evasion ~= nil then
						cm:disable_event_feed_events(true, "","","diplomacy_faction_destroyed");
						cm:disable_event_feed_events(true, "wh_event_category_character", "", "");
						evasion:kill();
						cm:callback(function() cm:disable_event_feed_events(false, "","","diplomacy_faction_destroyed") end, 1);
						cm:callback(function() cm:disable_event_feed_events(false, "wh_event_category_character", "", "") end, 1);
					end;
				end
			end
		end
		out("checking if post loot option is needed");
		out(found_encounter_faction);
		out(encounter_listener_info[3]);
		out(loot);
		cm:callback(function() cm:disable_event_feed_events(false, "","","diplomacy_faction_destroyed") end, 1);
		cm:callback(function() cm:disable_event_feed_events(false, "wh_event_category_character", "", "") end, 1);
		if encounter_listener_info[3] then
			local uim = cm:get_campaign_ui_manager();
			uim:override("retreat"):unlock();
			encounter_listener_info[3] = false;
			encounter_listener_info[6] = "";
			encounter_listener_info[7] = "";
			if loot then
				out("triggering loot event");
				local faction_name = faction:name();
				TriggerEncounterIncident(faction, incident);
			end
		end
	end,
	false
	);
end



--lokhir quest bit
local lokhir_faction = "wh2_dlc11_def_the_blessed_dread";
local lokhir_mission = {["pre"] = {["vort"] = "wh2_dlc11_great_vortex_lokhir_helm_of_the_kraken_stage_2", ["mort"] = "wh2_dlc11_lokhir_helm_of_the_kraken_stage_2"},
						["now"] = {["vort"] = "wh2_dlc11_great_vortex_lokhir_helm_of_the_kraken_stage_3", ["mort"] = "wh2_dlc11_lokhir_helm_of_the_kraken_stage_3"},
						["aft"] = {["vort"] = "wh2_dlc11_great_vortex_lokhir_helm_of_the_kraken_stage_4", ["mort"] = "wh2_dlc11_lokhir_helm_of_the_kraken_stage_4"}
};
local lokhir_obj_key = "wh2_dlc11_objective_override_lokhir_sen_encounter";


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
			function(context)
				return context:character():faction():is_human()
			end,
			function(context)
				local index = tonumber(string.sub(context:area_key(), 13));
				if not index then
				else
					local character = context:character();
					local faction = character:faction();
					local faction_name = faction:name();
					
					if lokhir_faction == faction_name then
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


function ReconstructListeners()
	local lokhir_listener = encounter_listener_info[1];
	local pirate_listener = encounter_listener_info[2];
	local encounter_post_battle_listener = encounter_listener_info[3];
	local mission_key = encounter_listener_info[4];
	local next_mission_key = encounter_listener_info[5];
	local faction_key = encounter_listener_info[6];
	local incident = encounter_listener_info[7];
	
	if lokhir_listener == true then
		--lokir listener
		core:add_listener(
		"Lokhir_mission_listener",
		"AreaEntered", 
		function(context)
			out.design("checking lokhir mission existing or not");
			return context:character():faction():is_human()
		end,
		function(context)
			local index = tonumber(string.sub(context:area_key(), 13));
			if not index then
			else
				local character = context:character();
				local faction = character:faction();
				local faction_name = faction:name();
				
				if lokhir_faction == faction_name then
					cm:complete_scripted_mission_objective(mission_key, "joys_mission", true);
					cm:trigger_mission(lokhir_faction, next_mission_key, true);
					encounter_listener_info[1] = false;
					encounter_listener_info[4] = "";
					encounter_listener_info[5] = "";
				end;
			end;
		end,
		false
		);
	end
	
	if pirate_listener == true then
		--remove pirate encounter force
		SetupEncounterForceRemoval();
	end
	
	cm:disable_event_feed_events(false, "","","diplomacy_faction_destroyed");
	cm:disable_event_feed_events(false, "wh_event_category_character", "", "");	
	
	if encounter_post_battle_listener == true then
		--postbattle loot listerner
		out("reconstructing postbattle listeners");
		local faction = cm:model():world():faction_by_key(faction_key);
		SetupEncounterPostbattle(incident, faction);
		cm:disable_event_feed_events(true, "","","diplomacy_faction_destroyed");
		cm:disable_event_feed_events(true, "wh_event_category_character", "", "");	
		local uim = cm:get_campaign_ui_manager();
		uim:override("retreat"):lock();
	end
end

--first tick disable feed
-- cm:add_first_tick_callback(
	-- function()		
		-- -- disable the event feed and enable it back later
		-- cm:disable_event_feed_events(true, "","","diplomacy_faction_destroyed");
		-- cm:disable_event_feed_events(true, "wh_event_category_character", "", "");	
		
		-- cm:disable_event_feed_events(true, "wh_event_category_conquest", "", "");	
	-- end
-- );

--declare invasion army
function DeclareArmy()
	local faction_list 
	if cm:model():world():faction_by_key(encounter_pirate_faction):is_null_interface() then
		encounter_pirate_faction = alternative_encounter_pirate_faction;
		random_army_manager:new_force("encounter_force");
		random_army_manager:add_mandatory_unit("encounter_force", "wh2_main_def_inf_dreadspears_0", 2);
		random_army_manager:add_mandatory_unit("encounter_force", "wh2_main_def_inf_harpies", 2);
		random_army_manager:add_mandatory_unit("encounter_force", "wh2_main_def_inf_darkshards_0", 2);
		random_army_manager:add_mandatory_unit("encounter_force", "wh2_main_def_inf_black_ark_corsairs_0", 2);
		random_army_manager:add_unit("encounter_force", "wh2_dlc10_def_mon_feral_manticore_0", 1);
		random_army_manager:add_unit("encounter_force", "wh2_main_def_mon_black_dragon", 1);
		--random_army_manager:add_unit("encounter_force", "wh2_dlc11_cst_inf_depth_guard_0", 2);
		random_army_manager:add_unit("encounter_force", "wh2_main_def_inf_black_ark_corsairs_1", 2);
		random_army_manager:add_unit("encounter_force", "wh2_dlc10_def_mon_kharibdyss_0", 1);
	else
		random_army_manager:new_force("encounter_force");
		random_army_manager:add_mandatory_unit("encounter_force", "wh2_dlc11_cst_inf_zombie_deckhands_mob_0", 2);
		random_army_manager:add_mandatory_unit("encounter_force", "wh2_dlc11_cst_inf_zombie_deckhands_mob_1", 2);
		random_army_manager:add_mandatory_unit("encounter_force", "wh2_dlc11_cst_inf_zombie_gunnery_mob_0", 2);
		random_army_manager:add_mandatory_unit("encounter_force", "wh2_dlc11_cst_inf_zombie_gunnery_mob_2", 2);
		random_army_manager:add_unit("encounter_force", "wh2_dlc11_cst_art_carronade", 1);
		random_army_manager:add_unit("encounter_force", "wh2_dlc11_cst_art_mortar", 1);
		random_army_manager:add_unit("encounter_force", "wh2_dlc11_cst_inf_depth_guard_0", 2);
		random_army_manager:add_unit("encounter_force", "wh2_dlc11_cst_inf_depth_guard_1", 2);
		random_army_manager:add_unit("encounter_force", "wh2_dlc11_cst_mon_rotting_leviathan_0", 1);
	end
end

--generate encounter pirates
function GenerateEncounterPirate(character, loc, unit)
	local faction = character:faction();
	local faction_name = faction:name();
	local cqi = character:command_queue_index();
	local force_cqi = character:military_force():command_queue_index();
	
	local force = random_army_manager:generate_force("encounter_force", unit, false);
	
	local invasion_1 = invasion_manager:new_invasion("encounter_invasion", encounter_pirate_faction, force, loc);
	invasion_1:set_target("CHARACTER", cqi, faction_name);
	invasion_1:apply_effect("wh_main_bundle_military_upkeep_free_force", -1);
	invasion_1:start_invasion(
		function(self)
			local force_leader = self:get_general();
			
			cm:scroll_camera_from_current(false, 6, {force_leader:display_position_x(), force_leader:display_position_y(), 14.768, 0.0, 12.0});
			
			core:add_listener(
				"Pirate_encounter_engage",
				"FactionLeaderDeclaresWar",
				true,
				function(context)
					local faction = context:character():faction():name();
					
					if faction == encounter_pirate_faction then
						if not force_leader:is_at_sea() then
							script_error("Tried to spawn an army for an encounter at sea, but the army is on land - how can this be?");
						end
						cm:force_attack_of_opportunity(force_leader:military_force():command_queue_index(), force_cqi, false);
					end
				end,
				false
			);
			
			cm:force_declare_war(encounter_pirate_faction, faction_name,  false, false, false);
		end,
		false,
		false,
		false
	);
		
	encounter_listener_info[2] = true;
		
	SetupEncounterForceRemoval();
end



function SetupEncounterForceRemoval()
	core:add_listener(
	"Pirate_encounter_removal",
	"FactionTurnStart", 
	true,
	function(context)
		local im = invasion_manager;
		local evasion = im:get_invasion("encounter_invasion");
		if evasion ~= nil then
			cm:disable_event_feed_events(true, "","","diplomacy_faction_destroyed");
			cm:disable_event_feed_events(true, "wh_event_category_character", "", "");
			evasion:kill();
			cm:callback(function() cm:disable_event_feed_events(false, "","","diplomacy_faction_destroyed") end, 1);
			cm:callback(function() cm:disable_event_feed_events(false, "wh_event_category_character", "", "") end, 1);
		end;
		encounter_listener_info[2] = false;
	end,
	false
	);
end


function initialize_encounter_listeners()
	ReconstructListeners();
	DeclareArmy();
end

cm:add_saving_game_callback(
	function(context)
		cm:save_named_value("encounter_starting_faction", encounter_starting_faction, context);
		cm:save_named_value("encounter_sea_spots", encounter_sea_spots, context);
		cm:save_named_value("encounter_turn_recorder", encounter_turn_recorder, context);
		cm:save_named_value("encounter_listener_info", encounter_listener_info, context);
	end
);

cm:add_loading_game_callback(
	function(context)
		encounter_turn_recorder = cm:load_named_value("encounter_turn_recorder", 0, context);
		encounter_starting_faction = cm:load_named_value("encounter_starting_faction", "none", context);
		encounter_sea_spots = cm:load_named_value("encounter_sea_spots", {}, context);
		encounter_listener_info = cm:load_named_value("encounter_listener_info", encounter_listener_info_default, context);
	end
);