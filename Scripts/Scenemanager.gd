extends Node2D

@export var playerscene : PackedScene
# Called when the node enters the scene tree for the first time.
func _ready():
	var index = 0
	for i in GameManager.players:
		var currentplayer = playerscene.instantiate()
		currentplayer.name = str(GameManager.players[i].id)
		currentplayer.CharacterName = GameManager.players[i].name
		add_child(currentplayer)
		for spawn in get_tree().get_nodes_in_group("playerspawnpoint"):
			if spawn.name == str(index):
				currentplayer.global_position = spawn.global_position
		index += 1
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
