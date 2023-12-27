extends Area2D
@export var cooldown = 5.0
var cooldown_counter = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (cooldown_counter >= cooldown):
		queue_free()
	cooldown_counter += delta
	pass


func _on_body_entered(body):
	if body.is_in_group("Player"):
		body.on_explosion_body_entered(self)
	pass # Replace with function body.


