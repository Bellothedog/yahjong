extends Button

@onready var tile = get_node('tile')
signal changeTileStatus

func _toggled(pressed) -> void:
	if pressed == true:
		tile.modulate.a8 = 150
		changeTileStatus.emit()
		# Global.player1['Tile Stats'][tile.handIndex] = 1
	else:
		tile.modulate.a8 = 255
		# Global.player1['Tile Stats'][tile.handIndex] = 0
		changeTileStatus.emit()
