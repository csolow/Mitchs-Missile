extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func volume(bus_index, value):
	AudioServer.set_bus_volume_db(bus_index, value)

func _on_master_value_changed(value):
	volume(0, value)


func _on_music_value_changed(value):
	volume(1, value)


func _on_sound_fx_value_changed(value):
	volume(2, value)


func _on_back_from_audio_pressed():
	get_tree().change_scene_to_file("res://Scenes/options_menu.tscn")
