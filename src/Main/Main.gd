extends Node

onready var modeManager := $ModeManager
onready var lbl_points := $GUI/lbl_points
onready var lbl_winner := $Pause/lbl_winner

var gameSettings = GameSettings
var player_score := 0
var enemy_score := 0
var original_color : Color
var gray := Color(0.75, 0.75, 0.75, 1)
var green := Color(0, 0.5, 0.25, 1)

func _ready() -> void:
	$Ball.mode = gameSettings.getDificulty()-1
	$Enemy.mode = gameSettings.getDificulty()-1
	
	$Music.play()
	original_color = $GUI/ColorRect.color
	updateScoreBoard()

func playerPoint() -> void:
	$Ball.restart_ball(Vector2.LEFT)
	player_score += 1
	updateScoreBoard()
	$GUI/ColorRect.color = green
	$Cam.isShake = true
	yield(countdown(), "completed")
	$GUI/ColorRect.color = original_color
	if player_score >= 5:
		win('player')

func enemyPoint() -> void:
	$Ball.restart_ball(Vector2.RIGHT)
	enemy_score += 1
	updateScoreBoard()
	if enemy_score >= 5:
		win('enemy')
		return
	$GUI/ColorRect.color -= gray
	$Cam.isShake = true
	yield(countdown(), "completed")
	$GUI/ColorRect.color = original_color

func updateScoreBoard() -> void:
	lbl_points.text = str(player_score,' X ',enemy_score)

func win(winner: String) -> void:
	if winner == 'enemy':
		$GUI/ColorRect.color -= gray
	$ModeManager/winner.text = str('The ',winner.capitalize(),' win!')
	modeManager.setMode(2)
	modeManager.pause()

func countdown() -> void:
	 yield(get_tree().create_timer(.2), "timeout")


func _on_pause_pressed() -> void:
	$ModeManager.setMode(1)
	$ModeManager.pause()
