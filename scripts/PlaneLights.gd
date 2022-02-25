extends Sprite

var MIN_MOD = 1.15
var MAX_MOD = 1.3
var MIN_ALPHA = 0.7
var time = 0.3
var TRANS = [Tween.TRANS_BACK, Tween.TRANS_BOUNCE, Tween.TRANS_ELASTIC, Tween.TRANS_QUINT, Tween.TRANS_EXPO]

var updating = false
var new_mod
var new_alpha

func update_glow(hp_lost):
	
	if get_parent().hp - hp_lost <= 0:
		new_mod = MIN_MOD
		new_alpha = 0
		time = 3
	else:
		new_mod = modulate.r - (((MAX_MOD - MIN_MOD) / get_parent().total_hp) * hp_lost)
		new_alpha = modulate.a - (((1 - MIN_ALPHA) / get_parent().total_hp) * hp_lost)
		
	modulate = Color(new_mod, new_mod, new_mod, new_alpha)
	
	
