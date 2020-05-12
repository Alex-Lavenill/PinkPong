extends "res://src/Classes/Pad.gd"

func _physics_process(delta: float) -> void:
	movement(delta)

# Captura os inputs e cuida da movimentação do pad
func movement(delta : float) -> void:
	if Input.is_action_pressed("ui_up") and (position.y + offset.y) > 0:
		position.y -= speed * delta
	if Input.is_action_pressed("ui_down") and (position.y - offset.y) < 600:
		position.y += speed * delta
