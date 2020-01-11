extends KinematicBody2D
class_name Actor

var gravity = 3000.0
var velocity = Vector2.ZERO
var speed = Vector2.ZERO

func _physics_process(delta):
	velocity.y += gravity * delta