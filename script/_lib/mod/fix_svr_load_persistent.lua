--- @function svr_load_persistent_string
--- @desc Calls @scriptedvalueregistry:LoadPersistentString to load a persistent string value from the svr. Persistent values are not reset until the game is shut down and restarted.
--- @p @string value name
--- @return @string value
function core_object:svr_load_persistent_string(name)
	if not is_string(name) then
		script_error("ERROR: svr_load_persistent_string() called but supplied name [" .. tostring(name) .. "] is not a string");
		return false;
	end;

	return self.svr:LoadPersistentString(name);
end;

--- @function svr_load_persistent_bool
--- @desc Calls @scriptedvalueregistry:LoadPersistentBool to load a persistent boolean value from the svr. Persistent values are not reset until the game is shut down and restarted.
--- @p @string value name
--- @return @boolean value
function core_object:svr_load_persistent_bool(name)
	if not is_string(name) then
		script_error("ERROR: svr_load_persistent_bool() called but supplied name [" .. tostring(name) .. "] is not a string");
		return false;
	end;

	return self.svr:LoadPersistentBool(name);
end;