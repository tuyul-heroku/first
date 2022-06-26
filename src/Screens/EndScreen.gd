extends Control

onready var score: Label = get_node("Label2")

func _ready() -> void:
	update_interface()

func update_interface()-> void:
	score.text = "Score: %s " % PlayerData.score
