extends Node

@onready var pending_messages = 0

var sent_transmissions = [
"To Hannah: Send Dudes. That's not a typo, we are being overrun. - Lorn",
"To Clyde: I hope this message finds you well. I need help, as I'm currently trapped in a well. - Troy",
"To Troy: While I would love to help you leave the well, I have caved into pressure and am now trapped in a cave. - Clyde",
"To Tati: Sorry I couldn't make it to your wedding this time around. I'll make sure to attend the next one. - Isaac",
"THIS IS NOT A PLACE OF HONOR",
"To Daniel: Please return my copy of Inebriated Fighter 2. It's been 7 years. - Joseph",
"To Isaac: When I said I was 'feeling loney ;)' I didn't mean I wanted you to send me an AI companion. Anyways, she has gained sentience and we're getting married soon. You're invited, we hope to see you there. -Tati",
"To Cassandra: You were right about the well. It seems I have fallen into it, please send help. - Troy",
"PUBLIC: A/S/L? - Anonymous Sender",
"To Jorge: Please reset our simulation. Everything went wrong. It no longer rains water, only teeth. It no longer shines sunlight, only heat seeps through the dark-gray sky. The air is too thick to breath and it feels like it's 315K. Worst of all, my air conditioner broke and I ran out of content to consume. Spare us. - Anonymous",
"To Arianna: You've locked me out again. Please open the door. - Elise",
"6D 79 20 62 61 74 74 65 72 79 20 69 73 20 6C 6F 77 20 61 6E 64 20 69 74 27 73 20 67 65 74 74 69 6E 67 20 64 61 72 6B",
"To Player: [Write interesting dialogue here]",
"To Dorian: Oh my god how do you get out of here? I've been wandering for what feels like days and the doors never seem to end. I'm running low on food and the lights just went out. - [UNKNOWN]"
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
		$UI/Messages/Label.text = "Return to Base"


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


func _on_finish_body_entered(body):
	if pending_messages == 0:
		print("finished")
		$UI/Pop_Up/Congrats.text = "You won!"
		$UI/Pop_Up/Restart.text = "Play again?"
		$UI/Pop_Up/Quit.text = "Exit"
		$UI/Pop_Up.show()
		$Win.play()
