extends CharacterBody2D
class_name CharacterClass2D

@export var Health = 100.0
@export var CharacterName = "Mitch"
@onready var HealthBar = get_tree().get_root().get_node("Main/Camera2D/Overlay/HealthBar")


func take_damage (damage):
	Health -= damage
	HealthBar.health = Health
	pass

func game_over ():
	queue_free()

# remember to add this to main scripts process. 
func _process(delta):
	if $MultiplayerSynchronizer.get_multiplayer_authority() == multiplayer.get_unique_id():
		character_process(delta)
		health_process(delta)

func health_process (delta):
	if $MultiplayerSynchronizer.get_multiplayer_authority() == multiplayer.get_unique_id():
		if Health <= 0:
			#print("You dead")
			pass

func character_process(delta):
	pass
	
func _physics_process(delta):
	if $MultiplayerSynchronizer.get_multiplayer_authority() == multiplayer.get_unique_id():	
		character_physics_process(delta)

func character_physics_process(delta):
	pass

