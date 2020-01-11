extends Actor

var stomp_impulse = 1000.0

func _ready():
	speed = Vector2(800.0, 1000.0)
func _physics_process(delta):
	var direction = get_direction()
	var is_jump_interrupted = Input.is_action_just_released("jump") and velocity.y < 0.0
	velocity = calculate_move_velocity(velocity, speed, direction, is_jump_interrupted)
	velocity = move_and_slide(velocity, Vector2.UP)

func get_direction():
	return Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		-1.0 if Input.is_action_just_pressed("jump") and is_on_floor() else 0.0
	)

func calculate_move_velocity(linear_velocity, speed, direction, is_jump_interrupted):
	var new_velocity = linear_velocity
	new_velocity.x = speed.x * direction.x
	if direction.y == -1.0:
		new_velocity.y = speed.y * direction.y
	if is_jump_interrupted:
		new_velocity.y = 0.0
	return new_velocity

func _on_EnemyDetector_area_entered(area):
	velocity = calculate_stomp_velocity()
	
func calculate_stomp_velocity():
	var out = velocity
	out.y = -stomp_impulse
	return out


func _on_EnemyDetector_body_entered(body):
	queue_free()
