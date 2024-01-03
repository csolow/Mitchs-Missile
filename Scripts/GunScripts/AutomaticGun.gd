extends Gun
@export var bullet_spread = 0.0

# Called when the node enters the scene tree for the first time.
func _ready():
	rocket_prefab = load("res://Prefabs/Projectiles/FireworkProjectile.tscn")
	pass # Replace with function body.

#func get_instantiation_vector():
	#print("Don type shit")
	#var instantiation_vector = instantiation_point_object.global_position
	##the normal vector is normalized
	#var normal_vector = Vector2(instantiation_vector.normalized().y,-instantiation_vector.normalized().x)
	#instantiation_vector += normal_vector * randf_range(0,bullet_spread)
	#print("Don type shit")
	#return instantiation_vector

