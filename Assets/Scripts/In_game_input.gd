var handler

func input(event):
	if (event.is_action("wayp_select")):
		if (event.is_pressed()):
			handler.A_star(Vector2(0,0), handler.get_global_mouse_pos())
			handler.get_tree().set_input_as_handled()