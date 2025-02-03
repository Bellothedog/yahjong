extends Node2D

signal tileManagerStart

# Choose random game wind, assign hand winds to all players
func _ready() -> void:
	Global.gameWind = Global.suits[3].pick_random()
	Global.handWind = Global.suits[3].pick_random()
	tileManagerStart.emit()
	var tileManagerNode = get_node('tileManager')
	tileManagerNode.gameOver.connect(gameOver)

func sort(a, b):
	if Global.allTiles.find(a) < Global.allTiles.find(b):
		return true
	return false

func _input(event) -> void:
	if event.is_action_pressed("score"):
		Global.player1['Hand'].sort_custom(sort)
		score()

func testIntersection(start, suit):
		if Global.suits[suit][Global.suits[suit].find(start)+1] == Global.player1['Hand'][start + 1]:
			if Global.suits[suit][Global.suits[suit].find(start)+2] == Global.player1['Hand'][start + 2]:
				return true
			else: return false
		else: return false

func score():
	var group = 0
	var pair = 0
	var sliceStart = 0
	var suitOfTile = 0
	
	while sliceStart <= 12:
		print(Global.player1['Hand'].slice(sliceStart, sliceStart + 3))
		print(sliceStart)
		# Determine suit of current tile
		for suit in Global.suits:
			if Global.suits.find(Global.player1['Hand'][sliceStart]) != -1:
				suitOfTile = suit
				print(suitOfTile)
				break
		# Test if 3-tile slice is in the suit; chii
		#if Global.player1['Hand'].slice(sliceStart, sliceStart + 3) in Global.suits[suitOfTile]:
		if testIntersection(sliceStart, suitOfTile):
			group += 1
			sliceStart += 3
			print('chii')
		# Test if 3-tile slice is identical; pon. If not, test if containing pair
		elif Global.player1['Hand'][sliceStart] == Global.player1['Hand'][sliceStart + 1]:
			if Global.player1['Hand'][sliceStart] == Global.player1['Hand'][sliceStart + 2]:
				group += 1
				sliceStart += 3
				print('pon')
			else:
				pair += 1
				sliceStart += 2
				print('pair')
		else:
			print('No win!')
			break

func gameOver():
	print('Game Over!')
	score()
