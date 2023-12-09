extends CharacterBody2D
@export var speed = 5
@export var acceleration = 5
@export var friction = 5
@export var jump_speed = -400
@export var knockback_speed = 400
# Get the gravity from the project settings so you can sync with rigid body nodes.
@onready var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

#
@onready var rocket_to_be_spawned = load("res://Prefabs/FireworkPrefab.tscn")
@onready var instantiation_point_object = get_node("ArmPivot/InstantiationPoint") 
@onready var arm_pivot_child = get_node("ArmPivot") 
@onready var FireworkGun = get_node("ArmPivot/FireworkGun") 

#Cooldown variables
@export var cooldown = 0
@onready var cooldown_counter = cooldown


func _process(delta):
	#Handle Cooldown
	cooldown_counter += delta
	
	#Handle firing
	if Input.is_action_just_pressed("fire") and cooldown_counter>cooldown:
		cooldown_counter = 0
		fire_gun()


func _physics_process(delta):
	var input_dir: Vector2 = get_input_direction()
	
	# Add the gravity.
	velocity.y += gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_speed	

	# Moving
	if input_dir != Vector2.ZERO:
		accelerate(input_dir)
	# Idle
	elif input_dir == Vector2.ZERO and is_on_floor():
		apply_friction()
	
	move()
 
func move():
	move_and_slide()
 
func accelerate(direction: Vector2):
	velocity.x = velocity.move_toward(speed * direction, acceleration).x
 
func apply_friction():
	velocity.x = velocity.move_toward(Vector2.ZERO, friction).x
 
func get_input_direction() -> Vector2:
	var input_direction = Vector2.ZERO
	
	input_direction.x = Input.get_axis("left", "right")
	input_direction = input_direction.normalized()
	
	return input_direction


func fire_gun():
	
	var parent_node = get_tree().get_root().get_node("Main")
	var rocket_instance = rocket_to_be_spawned.instantiate()
	
	rocket_instance.transform = rocket_instance.transform.translated(instantiation_point_object.global_position)
	rocket_instance.DirectionVector = arm_pivot_child.get_pivot_to_mouse()
	
	#Add instance to scene
	parent_node.add_child(rocket_instance)
	
	velocity = arm_pivot_child.get_pivot_to_mouse().normalized() * -knockback_speed

