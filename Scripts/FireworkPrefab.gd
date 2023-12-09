extends AnimatableBody2D
@export var DirectionVector : Vector2
@export var speed = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	transform = transform.rotated_local(DirectionVector.angle())
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	move_and_collide(DirectionVector.normalized() * speed)
	pass

func set_angle(angle):
	transform = global_transform.rotated(angle)
	print(global_transform.get_origin())
