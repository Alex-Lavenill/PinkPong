extends "res://src/Pad/Pad.gd"

export var slow_percent := 0.2

func _ready() -> void:
	max_velocity[mode] -= (max_velocity[mode]*slow_percent)
	rotation_degrees = 180

func _physics_process(delta: float) -> void:
	enemyVelocity()

# Captura a posição da Ball, que determina a direção do Pad;
# Calcula a aceleração do Pad.
func enemyVelocity() -> void:
	if get_parent():
		var ball_posY : float = get_parent().get_node("Ball").position.y
		if ball_posY < (position.y-10):
			direction = Vector2.UP
			velocity += speed[mode] * acceleration[mode]
		elif ball_posY > (position.y+10):
			direction = Vector2.DOWN
			velocity += speed[mode] * acceleration[mode]
		else:
			direction = Vector2.ZERO
			velocity -= speed[mode] * acceleration[mode]/2
	
