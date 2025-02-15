

function regulated_habitat.pvpcheck(player, hitter, time_from_last_punch, tool_capabilities, dir, damage)
    -- if not player and hitter are players return
    if not player or not hitter or not player:is_player() or not hitter:is_player() then
        return
    end
	local pos = player:get_pos()
	local in_habitat = regulated_habitat.pos_in_areas(pos)
	local prot_override = core.check_player_privs(hitter, "protection_bypass")
	if (in_habitat and not prot_override) then
        return true  -- Cancel the punch
    end
end


core.register_on_punchplayer(regulated_habitat.pvpcheck)
