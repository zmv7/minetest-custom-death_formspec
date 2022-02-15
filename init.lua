local DWP = nil
local DP
core.register_on_death(function()
    DP = core.localplayer:get_pos()
	core.display_chat_message(minetest.colorize("#F00","You died at " .. core.pos_to_string(vector.round(DP))))
	core.show_formspec("cdf", "size[4,3.5]" ..
		"label[1.45,0;" .. fgettext("You died") ..
		"]button_exit[1,1;2,0.5;btn_respawn;".. fgettext("Respawn") ..
		"]button_exit[1,2;2,0.5;btn_ghostmode;" .. "GhostMode" .. 
		"]button_exit[1,3;2,0.5;btn_disconnect;" .. fgettext("Exit to Menu") .. "]")
end)

core.register_on_formspec_input(function(formname, fields)
	if formname == "cdf" then
		if fields.btn_disconnect then
		    core.disconnect()
		elseif fields.btn_respawn then
		    core.send_respawn()
         if not DWP then
            DWP = core.localplayer:hud_add({
            hud_elem_type = "waypoint",
            name = "DeathPoint",
            number = 0xFF0000,
            world_pos = DP})
            if not DWP then return end
        else
            core.localplayer:hud_change(DWP,'world_pos',DP)
        end

		else
		    core.display_chat_message(minetest.colorize("#FF0","GhostMode active. Type '.resp' to respawn."))
		end
	end
end)

core.register_chatcommand("resp", {
	description = "Respawn from GhostMode",
	func = function()
		if core.localplayer:get_hp() == 0 then
			core.send_respawn()
		else
			core.display_chat_message(minetest.colorize("#FF0","You're alive yet ;)"))
		end
end})

core.register_chatcommand("rdp", {
	description = "Remove death waypoint",
	func = function()
        if DWP then
            core.localplayer:hud_remove(DWP)
            DWP = nil
        end
end})
