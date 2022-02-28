extends Line2D 

var lastLevel : Node

func _process(delta):
	var p1 = 540.0 + (540.0/1000.0*get_parent().get_node("Plane").hp)
	var p0 = 540.0 - (540.0/1000.0*get_parent().get_node("Plane").hp)
	points[0].y = p0
	points[1].y = p1
	if p0 > p1:
		get_tree().change_scene("res://scenes/DeathScreen.tscn") 
		#TODO nasty bug where lines (rifle, artilects) don't get deleted and stay in screen forever after you die
