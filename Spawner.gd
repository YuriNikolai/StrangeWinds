extends Node2D

export(PackedScene) var enemy

enum {
	ARTILECT
}

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func spawn():
	var enemy_instance = enemy.instance()
	enemy_instance.position = Vector2(get_global_position().x, get_global_position().y + rand_range(-540, 540))
	enemy_instance.rotation_degrees = 90
	get_tree().get_root().add_child(enemy_instance)
	yield(get_tree().create_timer(0.2), "timeout")

func _on_Timer_timeout():
	spawn()
