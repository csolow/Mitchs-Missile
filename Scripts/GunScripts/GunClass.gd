extends Node2D
class_name Gun

@export var automatic = false

@export var fire_cooldown = 0.0
var fire_cooldown_counter = 0.0

var firing = false

@export var reload_cooldown = 0.0
var reload_cooldown_counter = 0.0

@export var knockback_speed = 0.0

#Declare from guns
var rocket_prefab

@onready var instantiation_point_object = get_parent().get_node("InstantiationPoint")
@onready var arm_pivot_child = get_parent()
@onready var player_object = get_parent().get_parent()


# Called when the node enters the scene tree for the first time.
func _ready():
	print(player_object)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	fire_cooldown_counter += delta
	pass

func fire_gun():
	var parent_node = get_tree().get_root().get_node("Main")
	var rocket_instance = rocket_prefab.instantiate()
	rocket_instance.transform = rocket_instance.transform.translated(instantiation_point_object.global_position)
	rocket_instance.DirectionVector = arm_pivot_child.get_pivot_to_mouse()
	if player_object.has_method("add_knockback"):
		player_object.add_knockback(knockback_speed)
	#Add instance to scene
	parent_node.add_child(rocket_instance)
	

func start_fire():	
	firing = true
	pass


func stop_fire():
	firing = false
	pass

