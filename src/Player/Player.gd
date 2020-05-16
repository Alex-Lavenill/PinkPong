extends "res://src/Pad/Pad.gd"

var touchedUp := false
var touchedDown := false

func _physics_process(delta: float) -> void:
	playerVelocity()

# Captura os inputs, que determinam a direção do Pad;
# Calcula a aceleração do Pad.
func playerVelocity() -> void:
	if (Input.is_action_pressed("ui_up") or touchedUp) and (position.y + offset.y) > 0:
		direction = Vector2.UP
		velocity += speed[mode] * acceleration[mode]
	elif (Input.is_action_pressed("ui_down") or touchedDown) and (position.y - offset.y) < 600:
		direction = Vector2.DOWN
		velocity += speed[mode] * acceleration[mode]
	else: 
		direction = Vector2.ZERO
		velocity -= speed[mode] * acceleration[mode]/2




