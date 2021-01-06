function fix_foreign_slot()
	core:remove_listener("underempire_ForeignSlotManagerRemovedEvent")
	core:add_listener(
		"underempire_ForeignSlotManagerRemovedEvent",
		"ForeignSlotManagerRemovedEvent",
		true,
		function(context)
			under_empire_destroyed(context);
		end,
		true
	)
end