extends "res://src/actors/actor/actor.gd"

export var score: = 100

func _ready() -> void:
	set_physics_process(false)
	_velocity.x = -speed.x * .35


func _on_StompDetector_body_entered(body: Node) -> void:
	if body.global_position.y > get_node("StompDetector").global_position.y:
		return
	die()

func _physics_process(delta: float) -> void:
	_velocity.y += gravity * delta
	if is_on_wall():
		_velocity.x *= -1  
	_velocity.y = move_and_slide(_velocity, FLOOR_NORMAL).y

func die()-> void:
	queue_free()
	PlayerData.score += score
