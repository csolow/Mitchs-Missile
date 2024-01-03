extends CharacterBody2D
@export var speed = 5
@export var acceleration = 5
@export var friction = 5
@export var jump_speed = -400
@export var t = 0.1

# Get the gravity from the project settings so you can sync with rigid body nodes.
@onready var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

#
@onready var rocket_to_be_spawned = load("res://Prefabs/Projectiles/FireworkProjectile.tscn")
@onready var instantiation_point_object = get_node("ArmPivot/InstantiationPoint")
@onready var arm_pivot_child = get_node("ArmPivot") 
@onready var FireworkGun = get_node("ArmPivot/FireworkGun") 

#Cooldown variables
@export var cooldown_start = 0.2
@onready var cooldown = cooldown_start
@onready var cooldown_counter = cooldown


func _process(delta):
	#Handle Cooldown
	cooldown_counter += delta
	
	#Handle firing
	if Input.is_action_just_pressed("fire"):
		if get_node("ArmPivot/FireworkGun").has_method("start_fire"):
			get_node("ArmPivot/FireworkGun").start_fire()
			
	if Input.is_action_just_released("fire"):
		if get_node("ArmPivot/FireworkGun").has_method("stop_fire"):
			get_node("ArmPivot/FireworkGun").stop_fire()
	
	if Input.is_action_just_pressed("reload"):
		if get_node("ArmPivot/FireworkGun").has_method("reload"):
			get_node("ArmPivot/FireworkGun").reload()

func _physics_process(delta):
	var input_dir: Vector2 = get_input_direction()
	
	# Add the gravity.
	velocity.y += gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_speed	

	# Moving
	if input_dir != Vector2.ZERO and is_on_floor():
		accelerate(input_dir)
	# Idle
	elif input_dir == Vector2.ZERO and is_on_floor():
		apply_friction()
	# Moving in air
	elif input_dir != Vector2.ZERO and not is_on_floor():
		apply_air_resistance(delta, input_dir)
	
	move()
 
func move():
	move_and_slide()
 
func accelerate(direction: Vector2):
	velocity.x = velocity.move_toward(speed * direction, acceleration).x
 
func apply_friction():
	velocity.x = velocity.move_toward(Vector2.ZERO, friction).x

func apply_air_resistance(delta: float, direction: Vector2):
	velocity.x = velocity.move_toward(speed * direction, acceleration).lerp(Vector2.ZERO, delta*t).x

 
func get_input_direction() -> Vector2:
	var input_direction = Vector2.ZERO
	
	input_direction.x = Input.get_axis("left", "right")
	input_direction = input_direction.normalized()
	
	return input_direction

func _on_body_entered(body):
	if body.is_in_group("Explosion"):
		print("Collision")
		velocity = body.get_global_transform().get_origin() - get_global_transform().get_origin()
		pass

func on_explosion_body_entered(body):
	var new_velocity = calculate_difference_vector(body.get_global_transform().get_origin())
	velocity = new_velocity.normalized() * 750
	cooldown = 1
	print(body)
	print(new_velocity.normalized())
	pass # Replace with function body.

func calculate_difference_vector (prop_vector):
	return get_global_transform().get_origin() - prop_vector

func add_knockback (knockback_speed):
	velocity = arm_pivot_child.get_pivot_vector().normalized() * -knockback_speed
