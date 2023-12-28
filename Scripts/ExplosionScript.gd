extends Area2D
@export var cooldown = 0.0
var cooldown_counter = 0

var explosion_complete = false
# Called when the node enters the scene tree for the first time.
func _ready():
	if get_node("GPUParticles2D").lifetime < cooldown:
		cooldown = get_node("GPUParticles2D").lifetime
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (cooldown_counter >= cooldown):
		explosion_complete = true
	if (cooldown_counter >= get_node("GPUParticles2D").lifetime):
		queue_free()
	cooldown_counter += delta
	pass


func _on_body_entered(body):
	if body.is_in_group("Player") and not explosion_complete:
		body.on_explosion_body_entered(self)
	pass # Replace with function body.


