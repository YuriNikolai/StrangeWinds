extends RichTextLabel

onready var file = 'res://texts/credits.csv'

func _ready():
	load_file(file)
	self.visible = true

func load_file(file):

	var f = File.new()
	f.open(file, File.READ)
	var contents = f.get_as_text()
	bbcode_text = contents
	f.close()
	return
