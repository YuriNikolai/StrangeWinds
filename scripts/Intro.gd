extends ColorRect

var AudioStreamer = preload("res://scenes/AudioStreamer.tscn")
var sfx_wind_loop = preload("res://sfx/wind_loop.ogg")
var sfx_navigation = preload("res://sfx/navigation.wav")
var sound = AudioStreamer.instance()

#Stripped down version of dialog box code

export var dialogPath = ""
export(float) var textSpeed = 0.05

var dialog

var phraseNum = 0
var finished = false


func _ready():
	sound = AudioStreamer.instance()
	add_child(sound)
	sound.play_sound(sfx_wind_loop)
	
	$Timer.wait_time = textSpeed
	dialog = getDialog()
	assert (dialog, "Dialog not found")
	nextPhrase()

func _process(_delta):
	if Input.is_action_just_pressed("fire"):
		if finished:
			nextPhrase()
		else:
			$Text.visible_characters = len($Text.text)

func getDialog() -> Array:
	var f = File.new()
	assert(f.file_exists(dialogPath), "File path does not exist")
	
	f.open(dialogPath, File.READ)
	var json = f.get_as_text()
	
	var output = parse_json(json)
	
	if typeof(output) == TYPE_ARRAY:
		return output
	else:
		return []
func nextPhrase() -> void:
	
	if phraseNum > 0:
		sound = AudioStreamer.instance()
		add_child(sound)
		sound.play_sound(sfx_navigation)
	
	if phraseNum >= len(dialog):
		queue_free()
		get_tree().change_scene("res://scenes/Level0.tscn")
		return
	
	finished = false
	
	$Text.bbcode_text = dialog[phraseNum]["Text"]
	
	$Text.visible_characters = 0
	
	while $Text.visible_characters < len($Text.text):
		$Text.visible_characters += 1
		
		$Timer.start()
		yield($Timer,"timeout")
	
	finished = true
	phraseNum += 1
	
	return
