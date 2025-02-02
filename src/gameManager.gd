extends Node2D

signal tileManagerStart

# Choose random game wind, assign hand winds to all players
func _ready() -> void:
	Global.gameWind = Global.suits[3].pick_random()
	Global.handWind = Global.suits[3].pick_random()
	tileManagerStart.emit()
	var tileManagerNode = get_node('tileManager')
	tileManagerNode.gameOver.connect(gameOver)

func _input(event) -> void:
	if event.is_action_pressed("score"):
		score()

func score():
	var group = 0
	var pair = 0
	# Go through tiles one by one
	for tile in len(Global.player1['Hand']) - 2:
		for suit in Global.suits:
			# Try to find tile in suit
			if suit.find(Global.player1['Hand'][tile]) != -1:
				# Test if next tile is part of sequence
				if Global.player1['Hand'][tile + 1] == suit[suit.find(Global.player1['Hand'][tile + 1])]:
					# Test if next tile over is also part of sequence, chii
					if Global.player1['Hand'][tile + 2] == suit[suit.find(Global.player1['Hand'][tile + 2])]:
						group += 1
				# Test if next tile is identical
				elif Global.player1['Hand'][tile + 1] == Global.player1['Hand'][tile]:
					# Test if next tile over is also identical, pon
					if Global.player1['Hand'][tile + 1] == Global.player1['Hand'][tile]:
						group += 1
					else:
						pair += 1
				else:
					if (group == 4 and pair == 1) or (pair == 7):
						print('Win!')
					else:
						print('No win')
						break
	

func gameOver():
	print('Game Over!')
	score()
