extends Interactable_Base

signal fuel_reload()
signal message_recieved()
signal object_removed()
var minimap_icon = "planet"
@onready var avaliable_message = true

@onready var fuel_pack
# Called when the node enters the scene tree for the first time.
func _ready():
	fuel_pack = true
	#var Main = get_tree().get_nodes_in_group("Main")

func interact():
	if fuel_pack:
		emit_signal("fuel_reload")
		fuel_pack = false
	if !fuel_pack:
		pass
	#emit_signal("removed", self)

func _on_fuel_station_body_entered(body):
	if body.is_in_group("player"):
		print("asteroid.gd passes")
		body.get_message()
		emit_signal("message_recieved")
		$Fuel_Station/CollisionShape2D.disabled
		emit_signal("object_removed", self)
