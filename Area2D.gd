extends CharacterBody2D

var speed = 200
var rotation_speed = 1.5
@export var friction = 0.01
@export var acceleration = 0.1

var velocity2D = Vector2.ZERO
var rotation_dir = 0

func get_input():
	rotation_dir = 0
	velocity = Vector2.ZERO
	if Input.is_action_pressed('ui_right'):
		rotation_dir += 1
	if Input.is_action_pressed('ui_left'):
		rotation_dir -= 1
	if Input.is_action_pressed('ui_down'):
		velocity += transform.y * speed
	if Input.is_action_pressed('ui_up'):
		velocity -= transform.y * speed

func _physics_process(delta):
	get_input()
	rotation += rotation_dir * rotation_speed * delta
	velocity = lerp(velocity, velocity, 1)
	move_and_slide()
