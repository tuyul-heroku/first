extends actor

export var stomp_impulse = 400.0

func _on_EnemyDetector_area_entered(area: Area2D) -> void:
	if area.global_position.y < get_node("EnemyDetector").global_position.y:
		return
	_velocity = calculate_stomp_velocity(_velocity, stomp_impulse)

func _physics_process(delta: float) -> void:
	var is_jump_interrupted:bool = Input.is_action_just_released("jump") and _velocity.y < 0.0
	var direction: = get_direction()
	if is_on_floor():
		if direction.x > 0:
			$PlayerAnimation.play("run")
			$PlayerAnimation.flip_h = false
		elif direction.x < 0:
			$PlayerAnimation.play("run")
			$PlayerAnimation.flip_h = true
		elif direction.x == 0:
			$PlayerAnimation.play("idle")
	else:
		if _velocity.y < 0:
			$PlayerAnimation.play("jump")
		else:
			$PlayerAnimation.play("fall")
	_velocity = calculate_move_velocity(_velocity, direction, speed, is_jump_interrupted) * delta * 60
	_velocity = move_and_slide(_velocity, FLOOR_NORMAL)


func get_direction() -> Vector2:
	var drc:Vector2
	drc.x = Input.get_action_strength("move_right")-Input.get_action_strength("move_left")
	if Input.is_action_just_pressed("jump") and is_on_floor():
		drc.y = -1.0
	else:
		drc.y = 0.0
	return drc

func calculate_move_velocity(
	linear_velocity:Vector2,
	direction:Vector2,
	speed:Vector2,
	is_jump_interrupted:bool
) -> Vector2:
	var out = linear_velocity
	out.x = speed.x * direction.x
	out.y += gravity * get_physics_process_delta_time()
	if direction.y == -1.0:
		out.y = speed.y * direction.y
	if is_jump_interrupted:
		out.y = 0.0
	return out

func calculate_stomp_velocity(linear_velocity:Vector2, impulse:float) -> Vector2:
	linear_velocity.y = -impulse
	return linear_velocity


func _on_EnemyDetector_body_entered(body: Node) -> void:
	die()


func die() -> void:
	PlayerData.deaths += 1
	#queue_free()
