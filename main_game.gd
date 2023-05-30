extends Node

@onready var pending_messages = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	var messages = get_tree().get_nodes_in_group("message")
	for item in messages:
		pending_messages += 1
		item.message_recieved.connect(_on_message_recieved)
		message_update()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func message_update():
	print(pending_messages)
	$UI/Messages/Label.text = str(pending_messages) + " pending"
	$UI/Pop_Up.hide()
	if pending_messages == 0:
		print("finished")
		$UI/Pop_Up/Congrats.text = "You won!"
		$UI/Pop_Up/Restart.text = "Play again?"
		$UI/Pop_Up/Quit.text = "Exit"
		$UI/Pop_Up.show()


func _on_message_recieved():
	pending_messages -= 1
	print ("main_game.gd message_recieved passes")
	message_update()



func _on_quit_pressed():
	get_tree().quit()


func _on_rocket_fuel_empty():
	print("all gone")
	$UI/Pop_Up/Congrats.text = "You lost. :c"
	$UI/Pop_Up/Restart.text = "Try again! I believe in you!"
	$UI/Pop_Up/Quit.text = "Quit?"
	$UI/Pop_Up.show()


func _on_restart_pressed():
	get_tree().reload_current_scene()
