extends Node2D

func _process(_delta):
	if abs(get_local_mouse_position().x) > abs(get_local_mouse_position().y):
		look_at(get_global_mouse_position())
