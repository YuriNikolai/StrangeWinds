extends Node2D

export(PackedScene) var enemy

onready var player = get_parent().get_node("Player")

enum {
	ARTILECT
}

func _on_Timer_timeout():
	spawn()

func spawn():
	var enemy_instance = enemy.instance()
	enemy_instance.position = Vector2(get_global_position().x, get_global_position().y + rand_range(-540, 540))
	enemy_instance.target = generate_target_point(enemy_instance)
	enemy_instance.rotation_degrees = 90
	get_tree().get_root().add_child(enemy_instance)
	yield(get_tree().create_timer(0.2), "timeout")


func generate_target_point(instance):
	#get a destination point from a circle around the player
	var cx = player.global_position.x
	var cy = player.global_position.y
	var radius = instance.attack_range
	
	var angle = rand_range(1.7*PI, 2.3*PI)
	
	var tx = cx + radius * cos(angle)
	var ty = cy + radius * sin(angle)
	
	return Vector2(tx, ty)*rand_range(0.8, 1.2)
