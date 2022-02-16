extends Sprite

export var hp : float
export var total_hp : float

func hit(damage):
	$PlaneLights.update_glow(damage)
	hp -= damage
