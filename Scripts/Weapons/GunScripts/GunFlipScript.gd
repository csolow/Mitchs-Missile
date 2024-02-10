extends AnimatedSprite2D
@onready var parent_node = get_parent()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var par_rot = parent_node.get_global_transform().get_rotation()
	if  par_rot <= -0.5 * PI  or parent_node.get_global_transform().get_rotation() >= 0.5 * PI:
		flip_v = true
	else:

		flip_v = false
		pass
