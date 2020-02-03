core:add_listener(
	"fix_rogue_army_idling",
	"FactionTurnStart",
	function(context)
		return context:faction():culture() == "wh2_main_rogue"
	end,
	function(context)
		cm:enable_movement_for_faction(context:faction():name())
	end,
	true
)