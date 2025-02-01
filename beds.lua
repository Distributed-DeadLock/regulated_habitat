regulated_habitat.beds_set_spawns_old = beds.set_spawns

function beds.set_spawns()
	for name,_ in pairs(beds.player) do
		local player = core.get_player_by_name(name)
		local p = player:get_pos()
		local in_habitat = regulated_habitat.pos_in_areas(p)
		local prot_override = core.check_player_privs(player, "protection_bypass")
		if (in_habitat or prot_override) then
		-- but don't change spawn location if borrowing a bed
			if not core.is_protected(p, name) then
				beds.spawn[name] = p
			end
		else
			core.chat_send_player(name, "Spawn NOT set. You're not in a regulated habitat")
		end
	end
	beds.save_spawns()
end