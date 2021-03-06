extends Control

var AudioStreamer = preload("res://scenes/AudioStreamer.tscn")
var sfx_navigation = preload("res://sfx/navigation.wav")
var sound = AudioStreamer.instance()

var hover = 1.2
var nhover = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	#$HBoxContainer/DaySelectButton.grab_focus()
	pass
	
func _on_QuitButton_pressed():
	sound = AudioStreamer.instance()
	add_child(sound)
	sound.play_sound(sfx_navigation)
	get_tree().quit()

func _on_QuitButton_mouse_entered():
	$HBoxContainer/QuitButton.modulate = Color(hover, hover, hover, 1)

func _on_QuitButton_mouse_exited():
	$HBoxContainer/QuitButton.modulate = Color(nhover, nhover, nhover, 1)
