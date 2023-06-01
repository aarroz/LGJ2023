extends RigidBody2D

@export var thrust = Vector2(0, -250)
var torque = 20000

@export var max_fuel = 250
@onready var fuel = max_fuel
signal fuel_max(max_fuel)
signal fuel_updated(fuel)
signal fuel_empty()
signal message_recieved()

func _ready():
	pass
	#emit_signal("fuel_max", fuel)
	#var Interact_Area = $Interact_Area.get_overlapping_areas()

func burn_fuel(amount):
	_set_fuel(fuel - amount)

func get_message():
	print("message recieved")
	emit_signal("message_recieved")

func _set_fuel(value):
	var prev_fuel = fuel
	fuel = clamp(value, 0, max_fuel)
	if fuel != prev_fuel:
		emit_signal("fuel_updated", fuel)
	if fuel == 0:
		emit_signal("fuel_empty")


func _integrate_forces(state):
	if fuel != 0:
		if Input.is_action_just_pressed("ui_up"):
			state.apply_force(thrust.rotated(rotation) * 30)
			burn_fuel(5)
			$SFX.pitch_scale = 3.48
			$SFX.play()
		elif Input.is_action_just_pressed("ui_down"):
			state.apply_force(thrust.rotated(rotation) * -30)
		elif Input.is_action_just_pressed("ui_accept"):
			state.apply_force(thrust.rotated(rotation) * 300)
			burn_fuel(50)
			$SFX.pitch_scale = 2.8
			$SFX.play()
	else:
		state.apply_force(Vector2())
	var rotation_direction = 0
	if Input.is_action_pressed("ui_right"):
		rotation_direction += 1
	if Input.is_action_pressed("ui_left"):
		rotation_direction -= 1
	state.apply_torque(rotation_direction * torque)

func _input(_event):
	if Input.is_action_just_pressed("ui_up") and fuel != 0:
		$Rocket_Trail.emitting = true
		#SFX.play()
	elif Input.is_action_just_pressed("ui_accept") and fuel != 0:
		$Rocket_Trail.emitting = true
		#$SFX.play()
	else:
		$Rocket_Trail.emitting = false
		#SFX.stop()
	


func _on_interact_area_area_entered(area):
	if area.is_in_group("fuel_station"):
		_set_fuel(max_fuel)
		await get_tree().create_timer(0.25).timeout
		area.queue_free()
		#area.interact()
	elif area.is_in_group("radio"):
		pass
	else:
		pass
