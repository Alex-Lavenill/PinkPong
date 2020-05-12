extends Node

var player_score := 0
var enemy_score := 0

func _ready() -> void:
	
	pass

func playerPoint() -> void:
	player_score += 1

func enemyPoin() -> void:
	enemy_score += 1
