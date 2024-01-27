extends Area2D
@export var lifetime = 0.0
var cooldown_counter = 0

var explosion_complete = false
# Called when the node enters the scene tree for the first time.
func _ready():
	if get_node("GPUParticles2D").lifetime < lifetime:
		lifetime = get_node("GPUParticles2D").lifetime
	explode_self()
	pass # Replace with function body.

func explode_self():
	#await get_tree().create_timer(lifetime).timeout
	#explosion_complete = true
	await get_tree().create_timer(get_node("GPUParticles2D").lifetime-lifetime).timeout
	queue_free()
	pass

#func _on_body_entered(body):
	#if body.is_in_group("Player") and not explosion_complete:
		#body.on_explosion_body_entered(self)
#


