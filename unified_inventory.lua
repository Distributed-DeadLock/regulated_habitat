regulated_habitat.unified_inventory_set_home = unified_inventory.set_home
regulated_habitat.unified_inventory_go_home = unified_inventory.go_home

function unified_inventory.set_home(player, pos)
	local in_habitat = regulated_habitat.pos_in_areas(pos)
	local prot_override = core.check_player_privs(player, "protection_bypass")
	if not (in_habitat or prot_override) then
		local name = player:get_player_name()
		core.chat_send_player(name, "Home NOT set. You're not in a regulated habitat")
		return false
	else
		return regulated_habitat.unified_inventory_set_home(player, pos)
	end
end

function unified_inventory.go_home(player)
	local pos = player:get_pos()
	local in_habitat = regulated_habitat.pos_in_areas(pos)
	local prot_override = core.check_player_privs(player, "protection_bypass")
	if not (in_habitat or prot_override) then
		local name = player:get_player_name()
		core.chat_send_player(name, "Go Home NOT allowed. You're not in a regulated habitat")
		return false
	else
		return regulated_habitat.unified_inventory_go_home(player)
	end
end