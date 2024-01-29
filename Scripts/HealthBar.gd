extends ProgressBar

var health = 100.0 : set = _set_health
var target_health = 100.0
var damage_bar_target = 100.0
var prev_damage = health
var t = 0.0
var t1 = 0.0

@onready var prev_health = health


@onready var damage_bar = $DamageBar
@onready var timer = $Timer



func _set_health(new_health):
	prev_health = health
	prev_damage = health
	health = min(max_value, new_health)
	health = max(0.0, health)
	target_health = health
	
	t = 0
	timer.start(0.5)
	
func _process(delta):
	t += delta*3
	t = min(t, 1)
	value = lerp(prev_health, target_health, t)
	
	t1 += delta*3
	t1 = min(t1, 1)
	damage_bar.value = lerp(prev_damage, damage_bar_target, t1)
	

func _on_timer_timeout():

	damage_bar_target = health
	t1 = 0
	print("No funny")
	pass # Replace with function body.
