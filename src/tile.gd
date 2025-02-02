extends Control

@export var index : int
@onready var tile = get_node('Button/tile')
var selfValue = '' # Value of own tile
var selfSuit = -1 # Suit of own tile
var selfIndex = 0 # Index of own tile in suit
var selfRect : Rect2 # Region rectangle of own tile

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var tableNode = get_node('../../../../tileManager')
	tableNode.updateHand.connect(updateHand)

func updateHand():
	selfValue = Global.player1['Hand'][index]
	for suit in Global.suits:
		selfIndex = suit.find(selfValue)
		if selfIndex != -1:
			selfSuit = Global.suits.find(suit)
			break
	selfRect = Global.suitToRectangle[selfSuit]
	selfRect.position.x += (32 * selfIndex) # NOTE: use merge() to enter the nightmare realm :D
	tile.region_rect = selfRect
