extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	$HBoxContainer/DaySelectButton.grab_focus()

func _on_QuitButton_pressed():
	get_tree().quit()
