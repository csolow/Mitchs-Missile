extends Gun


# Called when the node enters the scene tree for the first time.
func _ready():
	rocket_prefab = load("res://Prefabs/Projectiles/FireworkProjectile.tscn")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	fire_cooldown_counter += delta
	if firing and fire_cooldown_counter>=fire_cooldown:
		fire_gun()
		fire_cooldown_counter = 0
		if not automatic:
			self.firing = false
	pass


