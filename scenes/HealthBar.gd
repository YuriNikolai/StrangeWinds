extends Line2D 

func _process(delta):
	var p1 = 540.0 + (540.0/1000.0*get_parent().get_node("Plane").hp)
	var p0 = 540.0 - (540.0/1000.0*get_parent().get_node("Plane").hp)
	points[0].y = p0
	points[1].y = p1
