extends Camera2D
@onready var Player = get_tree().get_root().get_node("Main/Mitch") 
@export var camera_bounds = Vector2(500.0, 500.0)
var camera_square = Rect2(transform.get_origin() - camera_bounds/2, camera_bounds)
@onready var player_origin = Player.transform.get_origin()
@onready var camera_origin = transform.get_origin()
var t = 7.0
# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	#t += delta
	player_origin = Player.transform.get_origin()
	camera_origin = transform.get_origin()
	camera_square = Rect2(transform.get_origin() - camera_bounds/2, camera_bounds)
	if not camera_square.has_point(Player.transform.get_origin()):
		position = position.lerp(position+get_bounds_vector(), t * delta)
		pass

func get_bounds_vector() -> Vector2:
	var is_out_x = not camera_square.has_point(Vector2(Player.transform.get_origin().x, transform.get_origin().y))
	var is_out_y = not camera_square.has_point(Vector2(transform.get_origin().x, Player.transform.get_origin().y))
	
	return Vector2((player_origin.x - camera_origin.x + pow(-1, int(player_origin.x > camera_origin.x)) * camera_bounds.x/2) * int(is_out_x), (player_origin.y - camera_origin.y + pow(-1, int(player_origin.y > camera_origin.y)) * camera_bounds.y/2) * int(is_out_y))
	#
func _draw():
	#draw_rect(camera_square, Color.GREEN, false, 5.0)

	pass
