extends Sprite

onready var tween = get_parent().get_node("Tween")

var MIN_MOD = 1.15
var MAX_MOD = 1.3
var MIN_ALPHA = 0.7
var TIME = 0.3
var TRANS = [Tween.TRANS_BACK, Tween.TRANS_BOUNCE, Tween.TRANS_ELASTIC, Tween.TRANS_QUINT, Tween.TRANS_EXPO]

var new_mod
var new_alpha

func update_glow(hp_lost):
	new_mod = modulate.r - (((MAX_MOD - MIN_MOD) / get_parent().total_hp) * hp_lost)
	new_alpha = modulate.a - (((1 - MIN_ALPHA) / get_parent().total_hp) * hp_lost)
	tween.interpolate_property(self, "modulate", modulate, Color(MIN_MOD, MIN_MOD, MIN_MOD, 0), TIME, TRANS[rand_range(0,5)], Tween.EASE_IN, 0)
	tween.start()
	yield(get_tree().create_timer(TIME), "timeout")
	print(get_parent().hp)
	tween.interpolate_property(self, "modulate", modulate, Color(new_mod, new_mod, new_mod, new_alpha), TIME, TRANS[rand_range(0,5)], Tween.EASE_IN, 0)
	tween.start()
