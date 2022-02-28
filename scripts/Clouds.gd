extends Sprite

var screenHeight
var screenWidth
export var cloudSpeed = 2

func _ready():
	screenHeight = get_viewport().get_visible_rect().size.y # Get Height
	screenWidth = get_viewport().get_visible_rect().size.x # Get Width


func _process(delta):
	self.position.y += cloudSpeed
	if self.position.y > screenHeight + 1024:
		self.position.y = screenHeight - 2048
		self.position.x = rand_range(0, screenWidth)

#var array = []
#
#func _ready():
#
#	var path = "res://gfx/fx/"
#	var dir = Directory.new()
#	dir.open(path)
#	dir.list_dir_begin()
#	while true:
#		var file_name = dir.get_next()
#		if file_name == "":
#			#break the while loop when get_next() returns ""
#			break
#		elif !file_name.begins_with("."):
#			#get_next() returns a string so this can be used to load the images into an array.
#			array.append(load(path + file_name))
#		dir.list_dir_end()
#		array.shuffle()
#		get_node(".").set_texture(array[0])
#i give up for now
