extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_video_pressed():
	get_tree().change_scene_to_file("res://Scenes/Video_menu.tscn")


func _on_audio_pressed():
	get_tree().change_scene_to_file("res://Scenes/Audio_menu.tscn")
	

func _on_back_pressed():
	get_tree().change_scene_to_file("res://Scenes/menu.tscn")
