extends Sprite

export var hp : float
export var total_hp : float

func _ready():
	$Tracks.modulate.a = 1
	if Global.day > 1:
		$Crates.visible = true
		$Tracks.modulate.a = 0.9
	if Global.day == 3:
		$Barrel.visible = true
		$Tracks.modulate.a = 0.8
	elif Global.day > 3:
		$Barrel.queue_free()
		$Barrels.visible = true
	if Global.day == 4:
		$Tracks.modulate.a = 0.7
	if Global.day == 5:
		$Tracks.modulate.a = 0.6
	if Global.day == 6:
		$Tracks.modulate.a = 0.5
	if Global.day > 6:
		$Tracks.modulate.a = 0.4

func hit(damage):
	$PlaneLights.update_glow(damage)
	hp -= damage

