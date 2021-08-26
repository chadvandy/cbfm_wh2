function CI_spawn_unique_characters()
	out.chaos("CI_spawn_unique_characters()");
	out.inc_tab("chaos");
	CI_spawn_character(CI_CHAOS_CHARACTERS["sigvald"]);
	out.chaos("Spawned Sigvald");
	CI_spawn_character(CI_CHAOS_CHARACTERS["kholek"]);
	out.chaos("Spawned Kholek");
	CI_spawn_character(CI_CHAOS_CHARACTERS["sarthorael"]);
	out.chaos("Spawned Sarthorael");
	CI_spawn_character(CI_CHAOS_CHARACTERS["archaon"]);
	out.chaos("Spawned Archaon");
	out.dec_tab("chaos");
	
	cm:complete_scripted_mission_objective("wh_main_short_victory", "archaon_spawned", true);
	cm:complete_scripted_mission_objective("wh_main_long_victory", "archaon_spawned", true);
end