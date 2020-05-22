-- rewrites the function called in `export_ancillaries__.lua`, to read the Alarielle version of the court.

function wh2_main_trig_general_constructed_building_hef_court_of_the_everqueen_impl (context)
    return 
        not context:character():character_type("colonel") and 
        context:character():has_region() and 
        context:character():turns_in_own_regions() >= 1 and 
        (
            (region_has_chain_or_superchain(context:character():region(), "wh2_main_special_everqueen_court")) or 
            region_has_chain_or_superchain(context:character():region(), "wh2_main_special_everqueen_court_hef")
        ) and context:character():model():turn_number() % 5 == 0
end