extends Sprite

export var hp : float
export var total_hp : float

func _ready():
	if Global.day > 1:
		$Crates.visible = true
	if Global.day == 3:
		$Barrel.visible = true
	elif Global.day > 3:
		$Barrel.queue_free()
		$Barrels.visible = true

func hit(damage):
	$PlaneLights.update_glow(damage)
	hp -= damage

