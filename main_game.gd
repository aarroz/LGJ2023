extends Node

@onready var pending_messages = 0

var sent_transmissions = [
"Dear Hannah, Send Dudes. That's not a typo, we are being overrun. - Lorn",
"Dear Clyde, I hope this message finds you well. I need help, as I'm currently trapped in a well. - Troy",
"Dear Troy, While I would love to help you leave the well, I have caved into pressure and am now trapped in a cave. - Clyde",
"Dear Tati, Sorry I couldn't make it to your wedding this time around. I'll make sure to attend the next one. - Isaac",
"THIS IS NOT A PLACE OF HONOR",
"Dear Daniel, please return my copy of Inebriated Fighter 2. It's been 7 years. - Joseph",
"Dear Isaac, when I said I was 'feeling loney ;)' I didn't mean I wanted you to send me an AI companion. Anyways, she's reached singularity and we're getting married soon. You're invited, hope to see you there. -Tati",
"Dear Cassandra, you were right about the well. It seems I have fallen into it, please send help. - Troy"
]

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
		$Win.play()


func _on_message_recieved():
	pending_messages -= 1
	print ("main_game.gd message_recieved passes")
	$UI/Preview/Label.text = sent_transmissions.pick_random()
	message_update()



func _on_quit_pressed():
	get_tree().quit()


func _on_rocket_fuel_empty():
	print("all gone")
	$UI/Pop_Up/Congrats.text = "You lost. :c"
	$UI/Pop_Up/Restart.text = "Try again! I believe in you!"
	$UI/Pop_Up/Quit.text = "Quit?"
	$UI/Pop_Up.show()
	$Lose.play()
	


func _on_restart_pressed():
	get_tree().reload_current_scene()
