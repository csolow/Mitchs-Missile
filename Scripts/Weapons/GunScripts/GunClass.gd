extends Weapon
class_name Gun

@export var automatic = false

@export var fire_cooldown = 0.0
var fire_cooldown_counter = 0.0

var firing = false

@export var reload_cooldown = 0.0
var reload_cooldown_counter = 0.0

var reloading = false

@export var ammo_amount = 3
@onready var current_ammo = ammo_amount
var out_of_ammo = false
var infinite_ammo = false

@export var knockback_speed = 0.0


@onready var instantiation_point_object = get_node("InstantiationPoint")
@onready var arm_pivot_child = get_parent().get_parent()
@onready var player_object = get_parent().get_parent().get_parent()


# Called when the node enters the scene tree for the first time.
func _ready():
	if ammo_amount == 0:
		infinite_ammo = true
		current_ammo = 3
	print(player_object)
	pass # Replace with function body.
 
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	base_gun_process(delta)
	pass

func fire_gun():
	shoot()
	fire_cooldown_counter = 0
	#if not infinite_ammo:
	current_ammo -= 1
	if not automatic:
		firing = false

func get_instantiation_vector():
	var instantiation_vector = instantiation_point_object.global_position
	return instantiation_vector 

func base_gun_process(delta):
	fire_cooldown_counter += delta
	
	if firing and fire_cooldown_counter>=fire_cooldown and not out_of_ammo:
		fire_gun()
	
	if current_ammo<=0:
		out_of_ammo = true
	
	if reloading:
		reload_cooldown_counter += delta
		pass
	
	if reload_cooldown_counter >= reload_cooldown and reloading:
		current_ammo = ammo_amount
		reloading = false
		out_of_ammo = false
		reload_cooldown_counter = 0


func shoot():
	var root_node = get_tree().get_root().get_node("Main")
	var spawner = root_node.get_node("MultiplayerSpawner")
	var rocket_instance = rocket_prefab.instantiate()
	
	rocket_instance.transform = rocket_instance.transform.translated(get_instantiation_vector())
	rocket_instance.DirectionVector = arm_pivot_child.get_pivot_vector()
	
	if player_object.has_method("add_knockback"):
		player_object.add_knockback(knockback_speed)
	
	
	#Add instance to scene
	root_node.get_node("SpawnObjects").add_child(rocket_instance)
	spawner.add_spawnable_scene(rocket_instance.get_path())
	
	spawner.spawn(rocket_instance)
	

func start_fire():	
	firing = true
	pass

func reload():
	if out_of_ammo:
		print("Reloading on some shit")
		reloading = true
		reload_cooldown_counter = 0

func stop_fire():
	firing = false
	pass

