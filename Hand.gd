extends Node2D
var MousePosition 
@export var PivotToMouse: Vector2

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	MousePosition = get_global_mouse_position()
	
	PivotToMouse = MousePosition - get_global_transform().get_origin()
	transform = transform.rotated((PivotToMouse.angle()-transform.get_rotation()))
	pass
