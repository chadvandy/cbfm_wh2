


-----------------------------------------------------------------------------------
-----------------------------------------------------------------------------------
--
--	FACTION SCRIPT
--
--	Custom script for this faction starts here. The should_load_first_turn is
--	queried to determine whether to load the startup script for the full-prelude
--	first turn or just the standard startup script.
--
-----------------------------------------------------------------------------------
-----------------------------------------------------------------------------------





-------------------------------------------------------
--	String / position setup
-------------------------------------------------------

altdorf_region_str = "wh_main_reikland_altdorf";
altdorf_settlement_str = prepend_settlement_str .. altdorf_region_str;
altdorf_province_str = "wh_main_reikland";

grunburg_region_str = "wh_main_reikland_grunburg";
grunburg_settlement_str = prepend_settlement_str .. grunburg_region_str;

marienburg_region_str = "wh_main_the_wasteland_marienburg";
marienburg_settlement_str = prepend_settlement_str .. marienburg_region_str;

carroburg_region_str = "wh_main_middenland_carroburg";
carroburg_settlement_str = prepend_settlement_str .. carroburg_region_str;

middenheim_region_str = "wh_main_middenland_middenheim";
middenheim_settlement_str = prepend_settlement_str .. middenheim_region_str;

weismund_region_str = "wh_main_middenland_weismund";
weismund_settlement_str = prepend_settlement_str .. weismund_region_str;

empire_faction_str = "wh_main_emp_empire";
secessionists_faction_str = "wh_main_emp_empire_separatists";
middenland_faction_str = "wh_main_emp_middenland";


-- position of (players) vip army in startpos
vip_army_start_x = 493;
vip_army_start_y = 455;

function get_vip_cqi()
	local cqi = cm:get_saved_value("vip_cqi");

	if is_number(cqi) and cqi > 0 then
		return cqi;
	end;
	
	local character = cm:get_closest_general_to_position_from_faction(cm:get_faction(local_faction), vip_army_start_x, vip_army_start_y);
	
	if character then
		cqi = character:cqi();
	else
		cqi = -1;
	end;
	
	cm:set_saved_value("vip_cqi", cqi);
	
	return cqi;
end;

-- position vip army moves to in first turn
vip_army_move_to_x = 503;
vip_army_move_to_y = 441;

-- position to teleport vip army to if skipping prelude
vip_army_teleport_to_x = 493;
vip_army_teleport_to_y = 455;

-- enemy army moves towards player start position at the start of the first turn
enemy_army_move_to_x = 511;
enemy_army_move_to_y = 437;

-- position to teleport enemy army to if skipping prelude
enemy_army_teleport_to_x = 511;
enemy_army_teleport_to_y = 437;


-- this function stores and returns the cqi of the military force
function get_first_enemy_army_cqi()
	local enemy_mf_cqi = cm:get_saved_value("first_enemy_army_cqi");
		
	if not enemy_mf_cqi then
		local settlement = cm:get_region(grunburg_region_str):settlement();
		local character = cm:get_closest_general_to_position_from_faction(cm:get_faction(secessionists_faction_str), settlement:logical_position_x(), settlement:logical_position_y());
				
		if character then
			enemy_mf_cqi = character:military_force():command_queue_index();
			cm:set_saved_value("first_enemy_army_cqi", enemy_mf_cqi);
		else
			enemy_mf_cqi = -1;
		end;
	end;
	
	return enemy_mf_cqi;
end;





-------------------------------------------------------
--	Loading of faction scripts (single-player only)
-------------------------------------------------------

local should_load_first_turn = cm:get_saved_value("bool_prelude_should_load_first_turn");

-- include prelude missions
cm:load_global_script(local_faction .. "_prelude", true);


-------------------------------------------------------
--	Initial camera co-ords
--	Should ideally be used for the start/end points 
--	of the intro camera pan
-------------------------------------------------------

-- end position of the intro camera
-- (382.476501 291.71759 12.853671 0.089588 8.441447)
if should_load_first_turn then
	cam_skip_x = 373.7;					-- camera target x position
	cam_skip_y = 294.5;					-- camera target y position
	cam_skip_d = 10;					-- camera distance
	cam_skip_b = 0;						-- camera heading
	cam_skip_h = 10;					-- camera height
else
	-- start position of the intro camera
	cam_skip_x = 373.7;					-- camera target x position
	cam_skip_y = 294.5;					-- camera target y position
	cam_skip_d = 10;					-- camera distance
	cam_skip_b = 0;						-- camera heading
	cam_skip_h = 10;					-- camera height
end;

-- intro skip camera
cam_skip_x = 373.7;					-- camera target x position
cam_skip_y = 294.5;					-- camera target y position
cam_skip_d = 10;					-- camera distance
cam_skip_b = 0;						-- camera heading
cam_skip_h = 10;					-- camera height








-------------------------------------------------------
--	Faction Start declaration/config
--	This object decides what to do when the faction
--	is initialised - do we play the cutscene, do we
--	position the camera at the start, or do we do
--	nothing, stuff like that.
--
--	Comment out the line adding the intro cutscene
--	to not play it (not ready for playtesting etc.)
-------------------------------------------------------

out("campaign script loaded for " .. local_faction .. ", should_load_first_turn is " .. tostring(should_load_first_turn));

fs_player = faction_start:new(local_faction, cam_skip_x, cam_skip_y, cam_skip_d, cam_skip_b, cam_skip_h);
-- singleplayer initialisation
fs_player:register_new_sp_game_callback(function() faction_new_sp_game_startup() end);
fs_player:register_each_sp_game_callback(function() faction_each_sp_game_startup() end);

-- multiplayer initialisation
fs_player:register_new_mp_game_callback(function() faction_new_mp_game_startup() end);
fs_player:register_each_mp_game_callback(function() faction_each_mp_game_startup() end);

if core:is_tweaker_set("DISABLE_PRELUDE_CAMPAIGN_SCRIPTS") then
	out("Tweaker DISABLE_PRELUDE_CAMPAIGN_SCRIPTS is set so not running any prelude scripts");
else
	fs_player:register_intro_cutscene_callback(						-- comment out to not have intro cutscene
		function()
			show_benchmark_camera_pan_if_required(
				function()
					if should_load_first_turn then
						ft_cutscene_intro_play();
					else
						cutscene_intro_play();
					end;
				end
			);
		end
	);
end;



-------------------------------------------------------
--	This gets called each time the script restarts,
--	this could be at the start of a new game or
--	loading from a save-game (including coming back
--	from a campaign battle). Don't tamper with it.
-------------------------------------------------------

function start_game_for_faction(should_show_cutscene)
	out("start_game_for_faction() called");
	
	-- starts the playable faction script
	fs_player:start(should_show_cutscene, true);
end;



-------------------------------------------------------
--	This gets called only once - at the start of a 
--	new game. Initialise new game stuff for this 
--	faction here
-------------------------------------------------------

function faction_new_sp_game_startup()
	out("faction_new_sp_game_startup() called");
	
	-- first turn only
	if should_load_first_turn then
		set_first_turn_ui_allowed(false, local_faction);
		set_first_turn_resources_bar_allowed(false);
	end;
end;


function faction_new_mp_game_startup()
	out("faction_new_mp_game_startup() called");
	core:add_listener(
		"set_camera_position_campaign_start",
		"ScriptEventStartGameAllFactionsCompleted",
		true,
		function()
			cm:set_camera_position(cam_skip_x, cam_skip_y, cam_skip_d, cam_skip_b, cam_skip_h);
		end,
		true
	);
end;



-------------------------------------------------------
--	This gets called any time the game loads in,
--	singleplayer including from a save game and 
--	from a campaign battle. Put stuff that needs
--	re-initialising each campaign load in here
-------------------------------------------------------

function faction_each_sp_game_startup()
	out("faction_each_sp_game_startup() called");
end;


function faction_each_mp_game_startup()
	out("faction_each_mp_game_startup() called");
end;

-------------------------------------------------------
--
--	INTRO CUTSCENE
--
--	This function declares and configures the cutscene,
--	loads it with actions and plays it.
--	Customise it to suit.
--
-------------------------------------------------------


function cutscene_intro_play()

	-- work out who the commander of the player's army is
	local char = cm:get_closest_general_to_position_from_faction(local_faction, 493, 455);

	if not char then
		script_error("WARNING: cutscene_intro_play() couldn't find starting Lord, defaulting to primary choice");
	end;

	local advice_to_play = {};
	
	out("Starting Lord's first name is " .. char:get_forename());
	
	if not char or char:get_forename() == "names_name_2147343922" then
		advice_to_play[1] = "wh2_dlc13_camp_me_flyby_Gelt_001";
		advice_to_play[2] = "wh2_dlc13_camp_me_flyby_Gelt_002";
		advice_to_play[3] = "wh2_dlc13_camp_me_flyby_Gelt_003";
		advice_to_play[4] = "wh2_dlc13_camp_me_flyby_Gelt_004";
		advice_to_play[5] = "wh2_dlc13_camp_me_flyby_Gelt_005";
	end;
	
	local cutscene_intro = campaign_cutscene:new(
		local_faction .. "_intro",							-- string name for this cutscene
		71,													-- length of cutscene in seconds
		function() start_faction() end						-- end callback
	);
	
	--cutscene_intro:set_debug();
	cutscene_intro:set_skippable(true, function() cutscene_intro_skipped(advice_to_play) end);
	cutscene_intro:set_skip_camera(cam_skip_x, cam_skip_y, cam_skip_d, cam_skip_b, cam_skip_h);
	cutscene_intro:set_disable_settlement_labels(false);
	cutscene_intro:set_dismiss_advice_on_end(false);
	
	
	cutscene_intro:action(
		function()
			cm:show_shroud(false);
			cutscene_intro:cindy_playback("script/campaign/main_warhammer/factions/wh2_dlc13_emp_golden_order/scenes/wh2_dlc13_emp_golden_order.CindyScene", 0, 10);
		end,
		0
	);
		
	cutscene_intro:action(
		function()
			cm:show_advice(advice_to_play[1]);
		end,
		1
	);
	
	cutscene_intro:action(
		function()
			cutscene_intro:wait_for_advisor()
		end,
		11.7
	);
		
	cutscene_intro:action(
		function()
			cm:show_advice(advice_to_play[2]);
		end,
		12.7
	);
		
	cutscene_intro:action(
		function()
			cutscene_intro:wait_for_advisor()
		end,
		24.1
	);
	
	cutscene_intro:action(
		function()
			cm:show_advice(advice_to_play[3]);
		end,
		25
	);
		
	cutscene_intro:action(
		function()
			cutscene_intro:wait_for_advisor()
		end,
		38.9
	);
	
	cutscene_intro:action(
		function()
			cm:show_advice(advice_to_play[4]);
		end,
		39.9
	);
	
	cutscene_intro:action(
		function()
			cutscene_intro:wait_for_advisor()
		end,
		51.3
	);
	
	cutscene_intro:action(
		function()
			cm:show_advice(advice_to_play[5]);
		end,
		52.3
	);
		
	cutscene_intro:start();
end;


function cutscene_intro_skipped(advice_to_play)
	cm:override_ui("disable_advice_audio", true);
	
	effect.clear_advice_session_history();
	
	cm:show_advice(advice_to_play[1]);
	cm:show_advice(advice_to_play[2]);
	cm:show_advice(advice_to_play[3]);
	cm:show_advice(advice_to_play[4]);
	
	cm:callback(function() cm:override_ui("disable_advice_audio", false) end, 0.5);
end;











-------------------------------------------------------
--	This gets called after the intro cutscene ends,
--	Kick off any missions or similar scripts here
-------------------------------------------------------

function start_faction()
	out("start_faction() called");
	
	-- show advisor progress button
	cm:modify_advice(true);
	
	-- make the campaign manager report that this is turn two
	cm:set_turn_number_modifier(1);
	
	start_volkmar_prelude(true);
	
	--
	-- show how-to-play event
	--
	cm:show_message_event(
		"wh2_dlc13_emp_golden_order",
		"event_feed_strings_text_wh2_scripted_event_how_they_play_title",
		"factions_screen_name_wh2_dlc13_emp_golden_order",
		"event_feed_strings_text_wh_main_event_feed_string_scripted_event_intro_empire_balthasar_gelt_secondary_detail",
		true,
		591
	);
end;