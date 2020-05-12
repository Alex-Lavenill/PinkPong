extends "res://src/Classes/Pad.gd"

func _physics_process(delta: float) -> void:
	playerVelocity()

# Captura os inputs, que determinam a direção do Pad;
# Calcula a aceleração do Pad.
func playerVelocity() -> void:
	if Input.is_action_pressed("ui_up") and (position.y + offset.y) > 0:
		direction = Vector2.UP
		velocity += speed * acceleration
	elif Input.is_action_pressed("ui_down") and (position.y - offset.y) < 600:
		direction = Vector2.DOWN
		velocity += speed * acceleration
	else: 
		direction = Vector2.ZERO
		velocity -= speed * acceleration/2




