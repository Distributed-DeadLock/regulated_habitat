-- lava bucket
-- get original on_place funtion of the lava bucket
local nodename = "bucket:bucket_lava"
local def = core.registered_items[nodename]
regulated_habitat.bucket_lava_on_place = def and def.on_place

-- override on_place functions
function regulated_habitat.bucket_lava_op_override(itemstack, placer, pointed_thing)
	local pos = placer:get_pos()
	local in_habitat = regulated_habitat.pos_in_areas(pos)
	local prot_override = core.check_player_privs(placer, "protection_bypass")
	local y_level = tonumber(pointed_thing.above.y)
	if ((not in_habitat) or prot_override or (y_level <= regulated_habitat.lava_limit_y)) then
		return regulated_habitat.bucket_lava_on_place(itemstack, placer, pointed_thing)
	else
		core.chat_send_player(placer:get_player_name(), "Placing Lava NOT allowed. You're in a regulated habitat above Y: " .. regulated_habitat.lava_limit_y)
		return itemstack
	end
end

core.override_item(nodename, {on_place=regulated_habitat.bucket_lava_op_override})