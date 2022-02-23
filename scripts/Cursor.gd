extends Node


# Load the custom images for the mouse cursor.
var flare = load("res://gfx/gui/cursor_flare.png")
var laser = load("res://gfx/gui/cursor_laser.png")

func _ready():

	Input.set_custom_mouse_cursor(flare, Input.CURSOR_ARROW, Vector2 (12,12))

	Input.set_custom_mouse_cursor(laser, Input.CURSOR_CROSS, Vector2 (12,12))
