extends Node2D
var MousePosition 
var PivotToMouse: Vector2

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	MousePosition = get_global_mouse_position()
	PivotToMouse = get_pivot_vector()
	transform = transform.rotated(get_pivot_angle())
	pass

func get_pivot_vector():
	return MousePosition - get_global_transform().get_origin()

func get_pivot_angle():
	return PivotToMouse.angle()-transform.get_rotation()
