-- Definitions made by this mod that other mods can use too
regulated_habitat = {}

-- init Mod storage
regulated_habitat.storage = core.get_mod_storage()

local modpath = core.get_modpath("regulated_habitat")

-- load settings
regulated_habitat.limit_beds = core.settings:get_bool("limit_beds", true)
regulated_habitat.limit_sethome = core.settings:get_bool("limit_sethome", true)
regulated_habitat.limit_protector = core.settings:get_bool("limit_protector", true)
regulated_habitat.limit_ui = core.settings:get_bool("limit_ui", true)


dofile(modpath .. "/area_mgt.lua")

if (core.get_modpath("beds") and regulated_habitat.limit_beds) then
	dofile(modpath .. "/beds.lua")
end

if (core.get_modpath("sethome") and regulated_habitat.limit_sethome) then
	dofile(modpath .. "/sethome.lua")
end

if (core.get_modpath("protector") and regulated_habitat.limit_protector) then
	dofile(modpath .. "/protector.lua")
end

if (core.get_modpath("unified_inventory") and regulated_habitat.limit_ui) then
	dofile(modpath .. "/unified_inventory.lua")
end