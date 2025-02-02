extends Node

var gameWind = ''
var handWind = ''

# Stats for individual players. Numbers = turn order. In single player, the
# player is player 1 and the others are CPU.
var player1 = {
	'Hand' = [],
	'Score' = 0
}

var tiles = []
var deadWall = []
var suits = [ # TODO: consider letter-number for sorting, probz have to use sort_custom
		['n1', 'n2', 'n3', 'n4', 'n5', 'n6', 'n7', 'n8', 'n9'], # numbers
		['c1', 'c2', 'c3', 'c4', 'c5', 'c6', 'c7', 'c8', 'c9'], # circles
		['b1', 'b2', 'b3', 'b4', 'b5', 'b6', 'b7', 'b8', 'b9'], # bamboo
		['wE', 'wS', 'wW', 'wN'], # winds
		['dW', 'dG', 'dR'], # dragons
	]
var allTiles = suits[0] + suits[1] + suits[2] + suits[3] + suits[4]
var dora = ''

# Rect2's of first tile in suit
var suitToRectangle = [
	Rect2(7, 99, 18, 26), # numbers
	Rect2(7, 163, 18, 26), # circles
	Rect2(7, 131, 18, 26), # bamboo
	Rect2(7, 195, 18, 26), # winds
	Rect2(135, 195, 18, 26) # dragons
	
]
