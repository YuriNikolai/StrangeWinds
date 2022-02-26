extends RichTextLabel

onready var file = 'res://texts/credits.csv'

func _ready():
	load_file(file)
	self.visible = false

func load_file(file):

	var f = File.new()
	f.open(file, File.READ)
	var contents = f.get_as_text()
	bbcode_text = contents
	f.close()
	return

func _on_CreditsButton_pressed():
	if self.visible == false:
		self.visible = true
	else:
		self.visible = false
