extends ColorRect

var day = Global.day

var AudioStreamer = preload("res://scenes/AudioStreamer.tscn")
var sfx_wind_loop = preload("res://sfx/wind_loop.ogg")
var sfx_navigation = preload("res://sfx/navigation.wav")
var sound = AudioStreamer.instance()

onready var root = get_node("../..")

var dialogPath : String
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
	$Marker.visible = finished
	if Input.is_action_just_pressed("fire") and root.visible == true: #We use visibility to control when speechbox appears on the intro
		if finished:
			nextPhrase()
		else:
			$Text.visible_characters = len($Text.text)

func getPath():
	return "res://texts/day" + str(day) + ".json"

func getDialog() -> Array:
	var f = File.new()
	dialogPath = getPath()
	assert(f.file_exists(dialogPath), "File path does not exist")
	f.open(dialogPath, File.READ)
	var json = f.get_as_text()
	
	var output = parse_json(json)
	
	if typeof(output) == TYPE_ARRAY:
		return output
	else:
		return []


func nextPhrase() -> void:
	
	if phraseNum > 0 and root.visible == true:
		sound = AudioStreamer.instance()
		add_child(sound)
		sound.play_sound(sfx_navigation)
	
	if phraseNum >= len(dialog) and dialogPath != "res://texts/day7.json": #Make this string be whatever the last dialog is
		root.queue_free()
		get_tree().change_scene("res://scenes/Level0.tscn")
		return
	elif phraseNum >= len(dialog) and dialogPath == "res://texts/day7.json": #Make this string be whatever the last dialog is
		root.queue_free()
		get_tree().change_scene("res://scenes/EndScreen.tscn")
		return
	
	finished = false
	
	$Name.bbcode_text = dialog[phraseNum]["Name"]
	$Text.bbcode_text = dialog[phraseNum]["Text"]
	
	$Text.visible_characters = 0
	
	while $Text.visible_characters < len($Text.text):
		$Text.visible_characters += 1
		
		$Timer.start()
		yield($Timer,"timeout")
	
	finished = true
	phraseNum += 1
	
	return
