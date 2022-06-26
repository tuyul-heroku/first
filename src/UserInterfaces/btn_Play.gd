tool
extends Button

export var next_scene_path: = ""

func _on_button_up() -> void:
	get_tree().paused = false
	get_tree().change_scene(next_scene_path)

func _get_configuration_warning() -> String:
	return "next scene path not assigned yet" if next_scene_path == "" else ""
