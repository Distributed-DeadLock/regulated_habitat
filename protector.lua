-- protection blocks
-- get original on_place funtion of protector blocks
local nodename = "protector:protect"
local def = core.registered_nodes[nodename]
regulated_habitat.prot_on_place = def and def.on_place

nodename = "protector:protect2"
def = core.registered_nodes[nodename]
regulated_habitat.prot2_on_place = def and def.on_place


-- override on_place functions
function regulated_habitat.prot_op_override(itemstack, placer, pointed_thing)
	local pos = placer:get_pos()
	local in_habitat = regulated_habitat.pos_in_areas(pos)
	local prot_override = core.check_player_privs(placer, "protection_bypass")
	if (in_habitat or prot_override) then
		return regulated_habitat.prot_on_place(itemstack, placer, pointed_thing)
	else
		core.chat_send_player(placer:get_player_name(), "Placing protector NOT allowed. You're not in a regulated habitat")
		return itemstack
	end
end

core.override_item("protector:protect", {on_place=regulated_habitat.prot_op_override})


function regulated_habitat.prot2_op_override(itemstack, placer, pointed_thing)
	local pos = placer:get_pos()
	local in_habitat = regulated_habitat.pos_in_areas(pos)
	local prot_override = core.check_player_privs(placer, "protection_bypass")
	if (in_habitat or prot_override) then
		return regulated_habitat.prot2_on_place(itemstack, placer, pointed_thing)
	else
		core.chat_send_player(placer:get_player_name(), "Placing protector NOT allowed. You're not in a regulated habitat")
		return itemstack
	end
end

core.override_item("protector:protect2", {on_place=regulated_habitat.prot2_op_override})


---------------------
-- protected chest

function regulated_habitat.protchest_op_override(itemstack, placer, pointed_thing)
	local pos = placer:get_pos()
	local in_habitat = regulated_habitat.pos_in_areas(pos)
	local prot_override = core.check_player_privs(placer, "protection_bypass")
	if (in_habitat or prot_override) then
		return core.item_place(itemstack, placer, pointed_thing)
	else
		core.chat_send_player(placer:get_player_name(), "Placing protected chest NOT allowed. You're not in a regulated habitat")
		return itemstack
	end
end

core.override_item("protector:chest", {on_place=regulated_habitat.protchest_op_override})


--------------------
-- protected doors
-- protector:door_wood
-- get original on_place funtion of doors
nodename = "protector:door_wood"
def = core.registered_craftitems[nodename]
regulated_habitat.protdoors_on_place = def and def.on_place

nodename = "protector:door_steel"
def = core.registered_craftitems[nodename]
regulated_habitat.sprotdoors_on_place = def and def.on_place


function regulated_habitat.protdoor_op_override(itemstack, placer, pointed_thing)
	local pos = placer:get_pos()
	local in_habitat = regulated_habitat.pos_in_areas(pos)
	local prot_override = core.check_player_privs(placer, "protection_bypass")
	if (in_habitat or prot_override) then
		return regulated_habitat.protdoors_on_place(itemstack, placer, pointed_thing)
	else
		core.chat_send_player(placer:get_player_name(), "Placing protected doors NOT allowed. You're not in a regulated habitat")
		return itemstack
	end
end

function regulated_habitat.sprotdoor_op_override(itemstack, placer, pointed_thing)
	local pos = placer:get_pos()
	local in_habitat = regulated_habitat.pos_in_areas(pos)
	local prot_override = core.check_player_privs(placer, "protection_bypass")
	if (in_habitat or prot_override) then
		return regulated_habitat.sprotdoors_on_place(itemstack, placer, pointed_thing)
	else
		core.chat_send_player(placer:get_player_name(), "Placing protected doors NOT allowed. You're not in a regulated habitat")
		return itemstack
	end
end

core.override_item("protector:door_wood", {on_place=regulated_habitat.protdoor_op_override})

core.override_item("protector:door_steel", {on_place=regulated_habitat.sprotdoor_op_override})

-- trapdoors

function regulated_habitat.prottrapd_op_override(itemstack, placer, pointed_thing)
	local pos = placer:get_pos()
	local in_habitat = regulated_habitat.pos_in_areas(pos)
	local prot_override = core.check_player_privs(placer, "protection_bypass")
	if (in_habitat or prot_override) then
		return core.item_place(itemstack, placer, pointed_thing)
	else
		core.chat_send_player(placer:get_player_name(), "Placing protected trapdoors NOT allowed. You're not in a regulated habitat")
		return itemstack
	end
end

core.override_item("protector:trapdoor", {on_place=regulated_habitat.prottrapd_op_override})

core.override_item("protector:trapdoor_steel", {on_place=regulated_habitat.prottrapd_op_override})
