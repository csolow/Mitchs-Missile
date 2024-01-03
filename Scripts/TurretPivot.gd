extends Node2D
@onready var parent_node = get_tree().get_root().get_node("Main")
@onready var player_node = parent_node.get_node("Mitch")

var vector_to_player = Vector2.RIGHT
var interpolation_vector = Vector2.RIGHT
@export var interpolation_speed = 0.0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	interpolation_vector = interpolation_vector.lerp(vector_to_player, interpolation_speed * delta)
	look_at(interpolation_vector)
	pass

func rotate_towards_player():
	var player_location = player_node.global_transform.get_origin()
	vector_to_player = player_location
	pass

func get_pivot_vector():
	return Vector2.RIGHT.rotated(transform.get_rotation())
	pass
