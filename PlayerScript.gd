extends CharacterBody2D

@onready var rocket_to_be_spawned = load("res://Prefabs/FireworkPrefab.tscn")

var speed = 300.0
var jump_speed = -400
var instantiation_point : Vector2
@onready var instantiation_point_object = get_node("ArmPivot/InstantiationPoint") 
@onready var arm_pivot_child = get_node("ArmPivot") 
@onready var FireworkGun = get_node("ArmPivot/FireworkGun") 



# Get the gravity from the project settings so you can sync with rigid body nodes.
@onready var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _process(delta):
	if Input.is_action_just_pressed("fire"):
			fire_gun()

func _physics_process(delta):
	
	# Add the gravity.
	velocity.y += gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_speed

	# Get the input direction.
	var direction = Input.get_axis("left", "right")
	velocity.x = direction * speed

	move_and_slide() 

func fire_gun():
	var parent_node = get_tree().get_root().get_node("Main")
	var rocket_instance = rocket_to_be_spawned.instantiate()
	rocket_instance.transform = rocket_instance.transform.translated(instantiation_point_object.global_position)
	rocket_instance.transform = rocket_instance.transform.rotated(FireworkGun.transform.get_rotation())
	rocket_instance.DirectionVector = arm_pivot_child.get_pivot_to_mouse()
	print(rocket_instance.global_position)
	parent_node.add_child(rocket_instance)
		

func get_instantiation_point():
	
	pass
