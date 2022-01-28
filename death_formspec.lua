local dformspec = "size[4,3.5]bgcolor[#320000b4;true]" ..
		"label[1.45,0;" .. fgettext("You died") ..
		"]button_exit[1,1;2,0.5;btn_respawn;".. fgettext("Respawn") ..
		"]button_exit[1,2;2,0.5;btn_ghostmode;" .. "GhostMode" .. 
		"]button_exit[1,3;2,0.5;btn_disconnect;" .. fgettext("Exit to Menu") .. "]"

core.register_on_death(function()
	core.display_chat_message(minetest.colorize("#F00","You died at " .. core.pos_to_string(vector.round(core.localplayer:get_pos()))))
	core.show_formspec("bultin:death", dformspec)
end)

core.register_on_formspec_input(function(formname, fields)
	if formname == "bultin:death" then
		if fields.btn_disconnect then
		core.disconnect()
		elseif
		fields.btn_ghostmode then
			core.display_chat_message(minetest.colorize("#FF0","GhostMode active. Type '.resp' to respawn."))
		else
			core.send_respawn()
		end
	end
end)

core.register_chatcommand("resp", {
	description = "Respawn from GhostMode",
	func = function()
		if core.localplayer:get_hp() == 0 then
			core.send_respawn()
		else
			core.display_chat_message(minetest.colorize("#FF0","You're alive yet;)"))
		end
	end
})