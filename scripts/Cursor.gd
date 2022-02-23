extends Node


# Load the custom images for the mouse cursor
var flare = load("res://gfx/gui/cursor_flare.png")
var laser = load("res://gfx/gui/cursor_laser.png")
onready var weapon = get_parent().get_node("Weapon")

func _ready():
	
	Input.set_default_cursor_shape(Input.CURSOR_ARROW) # might not be necessary; confirms the default

	Input.set_custom_mouse_cursor(flare, Input.CURSOR_ARROW, Vector2 (12,12))

	Input.set_custom_mouse_cursor(laser, Input.CURSOR_CROSS, Vector2 (12,12))
	
func _process(_delta):
	
	if weapon.is_hitscan == false: # circle (arrow) for flare, cross for rifle
		Input.set_default_cursor_shape(Input.CURSOR_ARROW)
	else:
		Input.set_default_cursor_shape(Input.CURSOR_CROSS)
