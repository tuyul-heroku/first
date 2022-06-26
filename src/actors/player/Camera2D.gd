extends Camera2D

var path: = "../player"
onready var NODE: = get_node(path)

func _physics_process(delta):
	if NODE._velocity.x > 15 or NODE._velocity.y > 15 or -NODE._velocity.x > -15 or -NODE._velocity.y > -15:
		global_position = NODE.global_position.round()
		force_update_scroll()
