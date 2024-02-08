extends Node2D

@export var weapon_resources: Array[Weapon_Resource] 
var weapons = {}
var current_weapon
var current_weapon_index = 0
@onready var player_object = get_parent().get_parent()
 
# Called when the node enters the scene tree for the first time.
func _ready():
	var index = 0
	for weapon in weapon_resources:
		var add_weapon = weapon.weapon_scene.instantiate()
		add_weapon.name = str("Weapon", index)
		add_weapon.rocket_prefab = weapon.Projectile
		add_child(add_weapon)
		weapons[index] = get_child(index)
		weapons[index].visible = false
		index += 1
	current_weapon = weapons[current_weapon_index]
	current_weapon.visible = true
	player_object.CurrentGun = current_weapon
	pass # Replace with function body.


func weapon_up():
	current_weapon.visible = false
	current_weapon_index = wrapi(current_weapon_index+1, 0, weapons.size())
	current_weapon = weapons[current_weapon_index]
	player_object.CurrentGun = current_weapon
	current_weapon.visible = true
	pass

func weapon_down():
	current_weapon.visible = false
	current_weapon_index = wrapi(current_weapon_index-1, 0, weapons.size())
	current_weapon = weapons[current_weapon_index]
	player_object.CurrentGun = current_weapon
	current_weapon.visible = true
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func get_current_gun():
	
	return null
