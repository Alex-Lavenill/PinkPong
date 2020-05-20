extends Node2D

onready var player := get_parent().get_node("Player")

var click : InputEvent

func _physics_process(delta: float) -> void:
	if click:
		if !click.is_pressed():
			player.touchedUp = false
			player.touchedDown = false

func _input(event: InputEvent) -> void:
	if InputEventScreenTouch:
		click = event
		if click.get_position().y < 300:
			player.touchedUp = true
			player.touchedDown = false
		elif click.get_position().y > 300:
			player.touchedDown = true
			player.touchedUp = false

func _draw() -> void:
	draw_line(Vector2(0,300), Vector2(1024,300), Color.white, 2.0)
