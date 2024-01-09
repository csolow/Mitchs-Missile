extends CharacterBody2D
var cooldown = 2.0 
var cooldown_counter = 0.0 
@export var offset = 2.0

@onready var FireworkGun = get_node("TurretPivot/FireworkGun")


# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	cooldown = get_node("TurretPivot/FireworkGun").fire_cooldown
	cooldown_counter -= offset

func _process(delta):
	cooldown_counter += delta
	if cooldown_counter>=cooldown and not FireworkGun.out_of_ammo:
		if FireworkGun.has_method("start_fire"):
			FireworkGun.start_fire()
			
		get_node("TurretPivot").rotate_towards_player()
		cooldown_counter = 0.0
	if FireworkGun.out_of_ammo and not FireworkGun.reloading:
		FireworkGun.reload()
		print("Reloading on some don shit")
	
	pass
