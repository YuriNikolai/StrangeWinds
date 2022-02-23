extends Control

var AudioStreamer = preload("res://scenes/AudioStreamer.tscn")
var sfx_navigation = preload("res://sfx/navigation.wav")
var sound = AudioStreamer.instance()

# Called when the node enters the scene tree for the first time.
func _ready():
	$HBoxContainer/DaySelectButton.grab_focus()
	
func _on_DaySelectButton_pressed():
	sound = AudioStreamer.instance()
	add_child(sound)
	sound.play_sound(sfx_navigation)
	get_tree().change_scene("res://scenes/Level0.tscn")
	
func _on_CreditsButton_pressed():
	sound = AudioStreamer.instance()
	add_child(sound)
	sound.play_sound(sfx_navigation)

func _on_QuitButton_pressed():
	get_tree().quit()
