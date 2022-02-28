extends Control

var AudioStreamer = preload("res://scenes/AudioStreamer.tscn")
var sfx_navigation = preload("res://sfx/navigation.wav")
var sound = AudioStreamer.instance()

var hover = 1.2
var nhover = 1

func _ready():
	pass
	#$HBoxContainer/DaySelectButton.grab_focus()
	
func _on_DaySelectButton_pressed():
	sound = AudioStreamer.instance()
	add_child(sound)
	sound.play_sound(sfx_navigation)
	get_tree().change_scene("res://scenes/Intro.tscn")
	
func _on_CreditsButton_pressed():
	sound = AudioStreamer.instance()
	add_child(sound)
	sound.play_sound(sfx_navigation)

func _on_QuitButton_pressed():
	get_tree().quit()


func _on_DaySelectButton_mouse_entered():
	$HBoxContainer/DaySelectButton.modulate = Color(hover, hover, hover, 1)

func _on_DaySelectButton_mouse_exited():
	$HBoxContainer/DaySelectButton.modulate = Color(nhover, nhover, nhover, 1)

func _on_CreditsButton_mouse_entered():
	$HBoxContainer/CreditsButton.modulate = Color(hover, hover, hover, 1)

func _on_CreditsButton_mouse_exited():
	$HBoxContainer/CreditsButton.modulate = Color(nhover, nhover, nhover, 1)

func _on_QuitButton_mouse_entered():
	$HBoxContainer/QuitButton.modulate = Color(hover, hover, hover, 1)

func _on_QuitButton_mouse_exited():
	$HBoxContainer/QuitButton.modulate = Color(nhover, nhover, nhover, 1)
