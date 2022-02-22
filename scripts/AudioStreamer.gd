#Code snippet by natelastname, licensed as GPL v3.0

extends AudioStreamPlayer

var offset = 0

func remove_self():
	queue_free()

func play_sound(sound_stream):
	stream = sound_stream
	connect("finished",self,"remove_self")
	play(offset)

func _ready():
	pass # Replace with function body.
