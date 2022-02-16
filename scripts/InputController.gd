extends Node

onready var weapon = get_parent().get_node("Weapon")

func _process(delta):
	if Input.is_action_pressed("fire") and weapon.can_fire:
		weapon.fire()
		owner.get_node("Plane/PlaneLights").update_glow(100)
		owner.get_node("Plane").hp -= 100
