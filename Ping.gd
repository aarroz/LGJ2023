extends Marker2D

signal location(position)
# Called when the node enters the scene tree for the first time.
func _ready():
	position = get_transform()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	emit_signal("location")
