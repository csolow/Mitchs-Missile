extends CharacterClass2D
@export var speed = 5
@export var acceleration = 5
@export var friction = 5
@export var jump_speed = -400
@export var t = 0.1
@export var collision_friction = 1.0
@export var rocket_speed = 70.0

# Get the gravity from the project settings so you can sync with rigid body nodes.
@onready var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

#
@onready var rocket_to_be_spawned = load("res://Prefabs/Projectiles/FireworkProjectile.tscn")
@onready var instantiation_point_object = get_node("ArmPivot/FireworkGun/InstantiationPoint")
@onready var arm_pivot_child = get_node("ArmPivot") 
@onready var FireworkGun = get_node("ArmPivot/FireworkGun") 

#Cooldown variables
@export var cooldown_start = 0.2
@onready var cooldown = cooldown_start
@onready var cooldown_counter = cooldown

#Handle override movement
@onready var temp_velocity = Vector2.ZERO
@onready var gravity_vector = Vector2.ZERO
var override_movement = false

#Damage Variables
@export var collision_damage_factor = 0.005 
@export var rocket_damage_factor = 1.0


func _ready():
	$MultiplayerSynchronizer.set_multiplayer_authority(str(name).to_int())


func character_process(delta):
	#Handle Cooldown
	cooldown_counter += delta
	
	#Handle firing
	
	if Input.is_action_just_pressed("fire") and not override_movement:
		if get_node("ArmPivot/FireworkGun").has_method("start_fire"):
			get_node("ArmPivot/FireworkGun").start_fire()
	
			
	if Input.is_action_just_released("fire"):
		if get_node("ArmPivot/FireworkGun").has_method("stop_fire"):
			get_node("ArmPivot/FireworkGun").stop_fire()
	
	if Input.is_action_just_pressed("reload"):
		if get_node("ArmPivot/FireworkGun").has_method("reload"):
			get_node("ArmPivot/FireworkGun").reload()

func character_physics_process(delta):
	if $MultiplayerSynchronizer.get_multiplayer_authority() == multiplayer.get_unique_id():
		temp_velocity = velocity
		var input_dir: Vector2 = get_input_direction()
		
		# Add the gravity.
		gravity_vector.y = gravity * delta

		# Handle Jump.
		if Input.is_action_just_pressed("jump") and is_on_floor():
			temp_velocity.y = jump_speed

		# Moving
		if input_dir != Vector2.ZERO and is_on_floor():
			accelerate(input_dir)
		# Idle
		elif input_dir == Vector2.ZERO and is_on_floor():
			apply_friction()
		# Moving in air
		#elif input_dir != Vector2.ZERO and not is_on_floor():
			#apply_air_resistance(delta, input_dir)
		
		if not override_movement:
			velocity = temp_velocity
		velocity += gravity_vector
		
		move(delta)
 
func move(delta):
	if not override_movement:
		move_and_slide()
	else: 
		var collision_object = move_and_collide(velocity*delta)
		if collision_object and collision_object.get_collider().is_in_group("Ground"):
			velocity = velocity.bounce(collision_object.get_normal()) * collision_friction
			take_damage(velocity.length()*collision_damage_factor)
	


func accelerate(direction: Vector2):
	temp_velocity.x = temp_velocity.move_toward(speed * direction, acceleration).x
 
func apply_friction():
	temp_velocity.x = temp_velocity.move_toward(Vector2.ZERO, friction).x

func apply_air_resistance(delta: float, direction: Vector2):
	temp_velocity.x = temp_velocity.move_toward(speed * direction, acceleration).lerp(Vector2.ZERO, delta*t).x

 
func get_input_direction() -> Vector2:
	var input_direction = Vector2.ZERO
	
	input_direction.x = Input.get_axis("left", "right")
	input_direction = input_direction.normalized()
	
	return input_direction

func _on_body_entered(body):

	pass

func on_explosion_body_entered(body):
	var new_velocity = calculate_difference_vector(body.get_global_transform().get_origin())
	temp_velocity = new_velocity.normalized() * 750
	cooldown = 1
	pass # Replace with function body.

func calculate_difference_vector (prop_vector):
	return get_global_transform().get_origin() - prop_vector

func add_knockback (knockback_speed):
	if not override_movement:
		velocity = arm_pivot_child.get_pivot_vector().normalized() * -knockback_speed

func hit_by_rocket (knockback_vector):
	take_damage(knockback_vector.length() * rocket_damage_factor)
	velocity = knockback_vector.normalized() * rocket_speed
	override_movement = true
	stop_override_movement()
	pass

func stop_override_movement ():
	await get_tree().create_timer(1.0).timeout
	override_movement = false


