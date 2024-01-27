extends AnimatableBody2D
@export var DirectionVector : Vector2
@export var speed = 1

#<<<<<<< Updated upstream
#Cooldown variables
@export var cooldown = 1.0
@onready var cooldown_counter = 0

@export var free_cooldown = 1.0  
var exploded = false

@export var explosion_to_be_spawned = load("res://Prefabs/Explosions/ExplosionPrefab.tscn")

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
		
		start_explosion()
	pass


func set_angle(angle):
	transform = global_transform.rotated(angle)

func explode():
	exploded = true

	
	
	var parent_node = get_tree().get_root().get_node("Main")
	var explosion_instance = explosion_to_be_spawned.instantiate()
	#Add instance to scene

	explosion_instance.transform = explosion_instance.transform.translated(get_node("RocketTip").global_transform.get_origin()) 
	parent_node.call_deferred("add_child", explosion_instance)
	
	queue_free()
	
func start_explosion():
	if exploded:
		return
	await explode()


func _on_area_2d_body_entered(body):
	if body.is_in_group("Player"):
		if body.has_method("hit_by_rocket"):
			body.hit_by_rocket(DirectionVector.normalized() * speed)
		#await get_tree().create_timer(free_cooldown).timeout
		pass
	await start_explosion()
	pass # Replace with function body.

