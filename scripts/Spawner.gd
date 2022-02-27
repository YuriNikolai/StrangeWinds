extends Node2D

export(PackedScene) var enemy

onready var player = get_parent().get_node("Player")

var spawn_number = 0
var day_spawn_limit = Global.day + 1

enum {
	ARTILECT
}

func _on_Timer_timeout():
	if spawn_number <= day_spawn_limit: #Still some left to spawn today
		spawn()
	if spawn_number > day_spawn_limit and Global.population == 0: #Every enemy dead and no more spawning
		yield(get_tree().create_timer(7), "timeout") #Lull before end so you don't skip dialogue accidentally
		Global.day += 1
		get_tree().change_scene("res://scenes/EndDay.tscn")

func spawn():
	var enemy_instance = enemy.instance()
	enemy_instance.position = Vector2(get_global_position().x, get_global_position().y + rand_range(-540, 540))
	enemy_instance.target = generate_target_point(enemy_instance)
	get_parent().add_child(enemy_instance)
	spawn_number += 1
	Global.population += 1
	yield(get_tree().create_timer(0.2), "timeout")


func generate_target_point(instance):
	#get a destination point from a circle around the player
	var cx = player.global_position.x
	var cy = player.global_position.y
	var radius = instance.attack_range
	
	var angle = rand_range(1.82*PI, 2.2*PI)
	
	var tx = cx + radius * cos(angle)
	var ty = cy + radius * sin(angle)
	
	return Vector2(tx, ty)*rand_range(0.9, 1.1)
