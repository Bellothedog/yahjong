extends Button

@onready var tile = get_node('tile')

func _toggled(pressed) -> void:
	if pressed == true:
		tile.modulate.a8 = 150
	else:
		tile.modulate.a8 = 255
