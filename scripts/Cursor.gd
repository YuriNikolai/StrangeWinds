extends Node


# Load the custom images for the mouse cursor
var flare = load("res://gfx/gui/cursor_flare.png")
var flare_ready = load("res://gfx/gui/cursor_flare_ready.png")
var laser = load("res://gfx/gui/cursor_laser.png")
onready var weapon = get_parent().get_node("Weapon")

func _ready():
	
	Input.set_default_cursor_shape(Input.CURSOR_ARROW) # might not be necessary; confirms the default

	Input.set_custom_mouse_cursor(flare, Input.CURSOR_ARROW, Vector2 (12,12))

	Input.set_custom_mouse_cursor(laser, Input.CURSOR_CROSS, Vector2 (12,12))
	
	Input.set_custom_mouse_cursor(flare_ready, Input.CURSOR_CAN_DROP, Vector2 (12,12))
	
func _process(_delta):
	# circle (arrow) for flare, circle w/ center dot for flare w/ loaded rifle, cross for rifle
	if weapon.is_hitscan == false && weapon.can_fire_rifle == false:
		Input.set_default_cursor_shape(Input.CURSOR_ARROW)
	elif weapon.is_hitscan == false && weapon.can_fire_rifle == true:
		Input.set_default_cursor_shape(Input.CURSOR_CAN_DROP)
	else:
		Input.set_default_cursor_shape(Input.CURSOR_CROSS)
