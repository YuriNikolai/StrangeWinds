extends Node2D

export (PackedScene) var cloud

var cloud_instance : PackedScene

func _ready():
	if Global.day == 2 or Global.day == 5 or Global.day == 6:
		spawn()

func spawn():
	for number in 3:
		var cloud_instance = cloud.instance()
		cloud_instance.position = Vector2(get_global_position().x + rand_range(0, 1920), get_global_position().y - 1024)
		get_parent().add_child(cloud_instance)
		yield(get_tree().create_timer(2), "timeout")
