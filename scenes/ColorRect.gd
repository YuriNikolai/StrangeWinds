extends Polygon2D

func _process(delta):
	if color.a >= 0:
		color.a -= delta/2
