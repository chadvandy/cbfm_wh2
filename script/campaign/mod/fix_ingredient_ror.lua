-- ur index for ingredients
local food_index = {
    "wh2_dlc15_boar",
    "wh2_dlc15_goblin",
    "wh2_dlc15_lion",
    "wh2_dlc15_lizard",
    "wh2_dlc15_troll",
    "wh2_dlc15_bat",
    "wh2_dlc15_dragon",
    "wh2_dlc15_eagle",
    "wh2_dlc15_harpy",
    "wh2_dlc15_phoenix",
    "wh2_dlc15_clams",
    "wh2_dlc15_crab",
    "wh2_dlc15_gold_fish",
    "wh2_dlc15_puffer_fish",
    "wh2_dlc15_tentacle",
    "wh2_dlc15_glowing",
    "wh2_dlc15_green",
    "wh2_dlc15_indigo",
    "wh2_dlc15_pepper",
    "wh2_dlc15_stinky",
    "wh2_dlc15_ale",
    "wh2_dlc15_discharge",
    "wh2_dlc15_ectoplasm",
    "wh2_dlc15_milk",
    "wh2_dlc15_yolk"
}

--this is a list of units record, upon recruiting a unit in corresponding list, the ingrdient will be unlocked, the script requires any one of it when given multiple
local food_recruit_index = {	
    ["wh2_dlc15_boar"] = 	    {},
    ["wh2_dlc15_goblin"] =		{},
    ["wh2_dlc15_lion"] = 		{},
    ["wh2_dlc15_lizard"] =		{},
    ["wh2_dlc15_troll"] =		{},
    ["wh2_dlc15_bat"] = 		{},
    ["wh2_dlc15_dragon"] = 		{},
    ["wh2_dlc15_eagle"] = 		{},
    ["wh2_dlc15_harpy"] = 		{},
    ["wh2_dlc15_phoenix"] = 	{},
    ["wh2_dlc15_clams"] = 		{},
    ["wh2_dlc15_crab"] = 		{},
    ["wh2_dlc15_gold_fish"] = 	{},
    ["wh2_dlc15_puffer_fish"] =	{},
    ["wh2_dlc15_tentacle"] = 	{},
    ["wh2_dlc15_glowing"] = 	{},
    ["wh2_dlc15_green"] = 		{},
    ["wh2_dlc15_indigo"] = 		{},
    ["wh2_dlc15_pepper"] = 		{"wh_main_grn_inf_night_goblin_fanatics", "wh_main_grn_inf_night_goblin_fanatics_1", "wh_dlc06_grn_inf_da_eight_peaks_loonies_0"},
    ["wh2_dlc15_stinky"] = 		{},
    ["wh2_dlc15_ale"] = 		{},
    ["wh2_dlc15_discharge"] = 	{"wh2_dlc15_grn_mon_river_trolls_ror_0"},
    ["wh2_dlc15_ectoplasm"] = 	{},
    ["wh2_dlc15_milk"] = 		{},
    ["wh2_dlc15_yolk"] = 		{"wh_main_grn_mon_arachnarok_spider_0", "wh_dlc15_grn_mon_arachnarok_spider_waaagh_0", "wh_dlc06_grn_mon_venom_queen_0"}
}

function fix_ingredient_ror()
	for i = 1, #food_index do
        if #food_recruit_index[food_index[i]] ~= 0 then
            core:remove_listener("food_recruit"..tostring(i))
			core:add_listener(
			"food_recruit"..tostring(i),
			"UnitTrained",
			function(context)
				--check unlock state of food
				local check_res = false;
				if context:unit():has_force_commander() and context:unit():force_commander():faction():name() == "wh2_dlc15_grn_broken_axe" then
					for j = 1, #food_recruit_index[food_index[i]] do
						if context:unit():unit_key() == food_recruit_index[food_index[i]][j] then
							check_res = true;
						end
					end
				end
				return check_res;
			end,
			function(context)
				UnlockFood(food_index[i]);
			end,
			false
		);
		end
	end
end