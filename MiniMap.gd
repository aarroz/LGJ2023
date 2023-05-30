extends MarginContainer

@export_category("MiniMap Settings")
@export_node_path var player
@export var zoom = 1.5

@onready var grid = $MarginContainer/GlassPanel
@onready var player_marker = $MarginContainer/GlassPanel/PlayerMarker
@onready var mob_marker = $MarginContainer/GlassPanel/MobMarker
@onready var alert_marker = $MarginContainer/GlassPanel/AlertMarker

@onready var icons = {"planet": mob_marker, "station": alert_marker}

var grid_scale
var markers = {}

func _ready():
	player_marker.position = grid.size * 1.75
	grid_scale = grid.size / (get_viewport_rect().size * zoom)
	var map_objects = get_tree().get_nodes_in_group("minimap_objects")
	for item in map_objects:
		var new_marker = icons[item.minimap_icon].duplicate()
		grid.add_child(new_marker)
		new_marker.show()
		markers[item] = new_marker
	for object in get_tree().get_nodes_in_group("minimap_objects"):
		object.connect("object_removed", _on_object_removed)
		#pass

func _process(delta):
	#if !player:
	#	return
	player_marker.rotation = get_node(player).rotation
	for item in markers:
		var obj_pos = (item.position - get_node(player).position) * grid_scale + grid.size / 2
		obj_pos.x = clamp(obj_pos.x, 0, grid.size.x)
		obj_pos.y = clamp(obj_pos.y, 0, grid.size.y)
		if grid.get_rect().has_point(obj_pos + grid.position):
			#markers[item].hide()
			pass
		else:
			markers[item].show()
		markers[item].position = obj_pos

func _on_object_removed(object):
	if object in markers:
		markers[object].queue_free()
		markers.erase(object)
	print("object_removed passes")
