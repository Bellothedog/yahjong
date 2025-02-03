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
	var sliceStart = 0
	var suitOfTile = 0
	
	# Determine suit of current tile
	for suit in Global.suits:
		if Global.suits.find(Global.player1['Hand'][sliceStart]) != -1:
			suitOfTile = suit
			break
	
	while sliceStart <= 12:
		# Test if 3-tile slice is in the suit; chii
		if Global.player1['Hand'].slice(sliceStart, sliceStart + 3) in Global.suits[suitOfTile]:
			group += 1
			sliceStart += 3
		# Test if 3-tile slice is identical; pon. If not, test if containing pair
		elif Global.player1['Hand'][sliceStart] == Global.player1['Hand'][sliceStart + 1]:
			if Global.player1['Hand'][sliceStart] == Global.player1['Hand'][sliceStart + 2]:
				group += 1
				sliceStart += 3
			else:
				pair += 1
				sliceStart += 2
		else:
			print('No win!')
			break

func gameOver():
	print('Game Over!')
	score()
