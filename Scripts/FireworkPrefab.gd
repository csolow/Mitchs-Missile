extends AnimatableBody2D
@export var DirectionVector : Vector2
@export var speed = 1

#<<<<<<< Updated upstream
#Cooldown variables
@export var cooldown = 1
@onready var cooldown_counter = 0

@onready var explosion_to_be_spawned = load("res://Prefabs/ExplosionPrefab.tscn")

#=======
@onready var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
#>>>>>>> Stashed changes
# Called when the node enters the scene tree for the first time.
func _ready():
	transform = transform.rotated_local(DirectionVector.angle())
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	
	move_and_collide(DirectionVector.normalized() * speed)
	pass

func _process(delta):
	cooldown_counter += delta
	if cooldown_counter >= cooldown:
		explode()
	pass


func set_angle(angle):
	transform = global_transform.rotated(angle)
	print(global_transform.get_origin())

func explode():
	var parent_node = get_tree().get_root().get_node("Main")
	var explosion_instance = explosion_to_be_spawned.instantiate()
	explosion_instance.transform = explosion_instance.transform.translated(get_node("RocketTip").global_transform.get_origin()) 
	#Add instance to scene
	parent_node.call_deferred("add_child", explosion_instance)
	queue_free()



func _on_area_2d_body_entered(body):
	explode()
	pass # Replace with function body.

