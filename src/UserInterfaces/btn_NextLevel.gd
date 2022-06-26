tool
extends Button

onready var currentLevel = PlayerData.currentLevel
var next_scene_path: = ""


func _on_button_up() -> void:
	get_tree().paused = false
	
	if currentLevel == 1:
		next_scene_path = "res://src/levels/lv1.tscn"
	if currentLevel == 2:
		next_scene_path = "res://src/levels/lv2.tscn"
	
	get_tree().change_scene(next_scene_path)
