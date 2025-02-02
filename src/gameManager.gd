extends Node2D

signal tileManagerStart

# Choose random game wind, assign hand winds to all players
func _ready() -> void:
	Global.gameWind = Global.suits[3].pick_random()
	Global.handWind = Global.suits[3].pick_random()
	tileManagerStart.emit()
