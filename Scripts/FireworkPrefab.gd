extends AnimatableBody2D
@export var DirectionVector : Vector2
var speed = 2

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	move_and_collide(DirectionVector.normalized() * speed)
	pass

func set_angle(angle):
	transform = transform.rotated(angle - transform.get_rotation())
