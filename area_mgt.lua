regulated_habitat.areas = {}

function regulated_habitat.vt_serialize(v_table)
	local demi_serial = {}
	for i,v in pairs(v_table) do
		if (vector.check(v[1]) and vector.check(v[2])) then
			table.insert(demi_serial,{vector.to_string(v[1]),vector.to_string(v[2])})
		end
	end
	return core.serialize(demi_serial)
end

function regulated_habitat.vt_deserialize(sv_table)
	local demi_serial = core.deserialize(sv_table)
	local v_table = {}
	for i,v in pairs(demi_serial) do
		table.insert(v_table, {vector.from_string(v[1]), vector.from_string(v[2])})
	end
	return v_table
end


-- init or load areas
local s_areas = regulated_habitat.storage:get("areas")
if not s_areas then
	s_areas = regulated_habitat.vt_serialize({})
	regulated_habitat.storage:set_string("areas", s_areas)
end
regulated_habitat.areas = regulated_habitat.vt_deserialize(s_areas)


function regulated_habitat.v_in_area(pos, v1, v2)
	if not ( vector.check(pos) and vector.check(v1) and vector.check(v2) ) then
		return false
	end
	local vmin, vmax = vector.sort(v1, v2)
	return vector.in_area(pos, vmin, vmax)
end

function regulated_habitat.pos_in_areas(vpos)
	for i,v in pairs(regulated_habitat.areas) do
		if regulated_habitat.v_in_area(vpos, v[1], v[2]) then
			return i
		end
	end
	return false
end


function regulated_habitat.add_area(v1, v2)
	if (vector.check(v1) and vector.check(v2)) then
		table.insert(regulated_habitat.areas, {vector.sort(v1, v2)})		
		regulated_habitat.storage:set_string("areas", regulated_habitat.vt_serialize(regulated_habitat.areas))
		return true
	else
		return false
	end
end

function regulated_habitat.remove_area(id)
	if regulated_habitat.areas[id] then
		local removed = table.remove(regulated_habitat.areas, id)
		regulated_habitat.storage:set_string("areas", regulated_habitat.vt_serialize(regulated_habitat.areas))
		return removed
	else
		return false
	end
end



-- register priv for area mgt
core.register_privilege("rh_areas", {
    description = "Can manage the areas for regulated habitat",
    give_to_singleplayer = true
})

-- chatcommand to add an area
core.register_chatcommand("rh_add_area", {
	params = "<x1> <y1> <z1> <x2> <y2> <z3> ",
    description = "Add an Area to the regulated habitat list",
	privs = {
        rh_areas = true,
    },
    func = function(name, param)
		local parts = param:split(" ")
		local v1 = vector.new(tonumber(parts[1]), tonumber(parts[2]), tonumber(parts[3]))
		local v2 = vector.new(tonumber(parts[4]), tonumber(parts[5]), tonumber(parts[6]))
		local vmin, vmax = vector.sort(v1, v2)
		if regulated_habitat.add_area(vmin, vmax) then
			core.chat_send_player(name, "Added Area " .. vector.to_string(vmin) .. " " .. vector.to_string(vmax))
		else
			core.chat_send_player(name, "Failed to Add Area!")
		end
    end,
})

-- chatcommand to list all areas
core.register_chatcommand("rh_list_areas", {
    description = "List all Areas in the regulated habitat list",
	privs = {
        rh_areas = true,
    },
    func = function(name)
		core.chat_send_player(name,"Regulated Areas: <ID>  (minp)  (maxp)")
		for i,v in pairs(regulated_habitat.areas) do
			core.chat_send_player(name,i .. ". " .. vector.to_string(v[1]) .. "  " .. vector.to_string(v[2]))
		end
    end,
})

-- chatcommand to remove an area
core.register_chatcommand("rh_remove_area", {
	params = "<id> ",
    description = "Removes an Area from the regulated habitat list",
	privs = {
        rh_areas = true,
    },
    func = function(name, param)
		local id = tonumber(param)
		local removed = regulated_habitat.remove_area(id)
		if removed then
			core.chat_send_player(name, "Removed Area " .. id .. ". " .. vector.to_string(removed[1]) .. " " .. vector.to_string(removed[2]))
		else
			core.chat_send_player(name, "Failed to Remove Area!")
		end
    end,
})

-- chatcommand to find area at current pos
core.register_chatcommand("rh_this_area", {
    description = "Return the Area the player is currently in, if in any",
	privs = {
        rh_areas = true,
    },
    func = function(name)
		local player = core.get_player_by_name(name)
		local pos = player:get_pos()
		local vpos = vector.new(tonumber(pos.x), tonumber(pos.y), tonumber(pos.z))
		local id = regulated_habitat.pos_in_areas(pos)
		if id then
			core.chat_send_player(name, "You are in Area " .. id .. " : " .. vector.to_string(regulated_habitat.areas[id][1]) .. " " .. vector.to_string(regulated_habitat.areas[id][2]))
		else
			core.chat_send_player(name, "You are NOT in an RH-Area")
		end
    end,
})