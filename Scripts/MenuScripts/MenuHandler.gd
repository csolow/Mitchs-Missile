extends Node2D
class_name MenuHandler

var showing_pause_menu = false
@onready var root = get_tree().get_node("Main")


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("esc") and not showing_pause_menu:
		showing_pause_menu = true
		show_pause_menu()
	elif Input.is_action_just_pressed("esc") and showing_pause_menu:
		showing_pause_menu = false
		
	pass

func show_pause_menu():
	
	
	pass
