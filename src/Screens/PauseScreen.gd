extends Control

onready var scene_tree: = get_tree()
onready var pause_overlay: ColorRect = get_node("PauseOverlay")
onready var score: Label = get_node("Label")
onready var pause_title: Label = get_node("PauseOverlay/Label")
onready var timer = get_node("Timer")
onready var timeLabel = get_node("LabelTime")

var paused: = false setget set_paused
var currentTime = 0

func _ready() -> void:
	PlayerData.connect("score_updated", self, "update_interface")
	PlayerData.connect("player_died", self, "_PlayerData_player_died")
	timer.set_wait_time(.5)
	timer.start()
	update_interface()

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		self.paused = not paused
		scene_tree.set_input_as_handled()

func _PlayerData_player_died():
	self.paused = true
	pause_title.text = "YOU DIED"

func set_paused(value:bool)->void:
	paused = value
	scene_tree.paused = value
	pause_overlay.visible = value

func update_interface()-> void:
	score.text = "Score: %s" % PlayerData.score


func _on_Timer_timeout() -> void:
	currentTime += 1
	timeLabel.text = "Time: %s" % currentTime
