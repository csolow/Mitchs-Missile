extends CharacterBody2D


var speed = 200
var jump_speed = -400
var instantiation_point : Vector2
var knockback_speed = 400

@onready var rocket_to_be_spawned = load("res://Prefabs/FireworkPrefab.tscn")
@onready var instantiation_point_object = get_node("ArmPivot/InstantiationPoint") 
@onready var arm_pivot_child = get_node("ArmPivot") 
@onready var FireworkGun = get_node("ArmPivot/FireworkGun") 
@onready var cooldown = 0
@onready var cooldown_counter = cooldown


# Get the gravity from the project settings so you can sync with rigid body nodes.
@onready var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _process(delta):
	#Handle Cooldown
	cooldown_counter += delta
	
	#Handle firing
	if Input.is_action_just_pressed("fire") and cooldown_counter>cooldown:
		cooldown_counter = 0
		fire_gun()

func _physics_process(delta):
	
	# Add the gravity.
	velocity.y += gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_speed

	# Get the input direction.
	var direction = Input.get_axis("left", "right")
	velocity.x = (velocity.x * direction * speed) 
	move_and_slide() 


func fire_gun():
	
	var parent_node = get_tree().get_root().get_node("Main")
	var rocket_instance = rocket_to_be_spawned.instantiate()
	
	rocket_instance.transform = rocket_instance.transform.translated(instantiation_point_object.global_position)
	rocket_instance.DirectionVector = arm_pivot_child.get_pivot_to_mouse()
	
	#Add instance to scene
	parent_node.add_child(rocket_instance)
	
	velocity = arm_pivot_child.get_pivot_to_mouse().normalized() * -knockback_speed


