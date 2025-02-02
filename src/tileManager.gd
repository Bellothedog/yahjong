extends Node2D

# to be emitted when hand state changes
signal updateHand
signal gameOver

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var tableNode = get_node('..')
	tableNode.tileManagerStart.connect(loadTiles)

func _input(event)  -> void:
	if event.is_action_pressed("deal"):
		dealNew()

# Fill tiles array with 4 of every suit, remove dead wall and determine dora
func loadTiles() -> void:
	for suit in Global.suits:
		for n in 4:
			Global.tiles = Global.tiles + suit
	print(Global.tiles)
	Global.tiles.shuffle() # Shuffle the tiles
	
	Global.deadWall = Global.tiles.slice(121, 135) # Make last 14 tiles the dead wall
	for tile in range(13): # Remove the dead wall
		Global.tiles.remove_at(121)
	
	for suit in Global.suits:
		var suitIndex = suit.find(Global.deadWall[0]) # attempt to find dora indicator
		if suitIndex != -1: # if find() did not return not found
			Global.dora = Global.deadWall[suitIndex + 1]
			break
	dealTiles()
		
func sort(a, b):
	if Global.allTiles.find(a) < Global.allTiles.find(b):
		return true
	return false

# Deal 13 tiles to each player, one extra for East hand
func dealTiles() -> void:
	for n in 13: # fill hand
		Global.player1['Hand'].append(Global.tiles[0])
		Global.tiles.remove_at(0)
		Global.player1['Tile Stats'].append(0)
	Global.player1['Hand'].sort_custom(sort)
	
	Global.player1['Hand'].append(Global.tiles[0]) # draw tile
	Global.tiles.remove_at(0)
	Global.player1['Tile Stats'].append(0)
	
	updateHand.emit()

func dealNew():
	# Deal new tile to each unheld tile in hand
	for tile in len(Global.player1['Tile Stats']):
		if Global.player1['Tile Stats'][tile] == 0:
			if len(Global.tiles) > 0:
				Global.player1['Hand'][tile] = Global.tiles[0]
				Global.tiles.remove_at(0)
			else:
				Global.player1['Hand'].sort_custom(sort)
				gameOver.emit()
	updateHand.emit()
