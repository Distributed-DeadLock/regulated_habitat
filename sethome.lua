-- Load support for MT game translation.
local S = core.get_translator("sethome")

core.register_chatcommand("home", {
	description = S("Teleport you to your home point"),
	privs = {home = true},
	func = function(name)
		local player = core.get_player_by_name(name)
		if not player then
			return false, S("This command can only be executed in-game!")
		end
		local pos = player:get_pos()
		local in_habitat = regulated_habitat.pos_in_areas(pos)
		local prot_override = core.check_player_privs(name, "protection_bypass")
		if not (in_habitat or prot_override) then
			return false, "Home NOT allowed. You're not in a regulated habitat"
		end
		if sethome.go(name) then
			return true, S("Teleported to home!")
		end
		return false, S("Set a home using /sethome")
	end,
})

core.register_chatcommand("sethome", {
	description = S("Set your home point"),
	privs = {home = true},
	func = function(name)
		name = name or "" -- fallback to blank name if nil
		local player = core.get_player_by_name(name)
		local pos = player:get_pos()
		local in_habitat = regulated_habitat.pos_in_areas(pos)
		local prot_override = core.check_player_privs(name, "protection_bypass")
		if not (in_habitat or prot_override) then
			return false, "SetHome NOT allowed. You're not in a regulated habitat"
		end
		if player and sethome.set(name, pos) then
			return true, S("Home set!")
		end
		return false, S("Player not found!")
	end,
})