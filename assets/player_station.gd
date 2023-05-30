extends Node2D

var minimap_icon = "station"
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _on_station_gravity_body_entered(body):
	if body.is_in_group("player"):
		print("station_gravity_body_entered passes")
