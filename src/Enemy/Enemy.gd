extends "res://src/Classes/Pad.gd"

func _ready() -> void:
	$Coll.rotation_degrees = 180

func _physics_process(delta: float) -> void:
	enemyVelocity()

# Captura a posição da Ball, que determina a direção do Pad;
# Calcula a aceleração do Pad.
func enemyVelocity() -> void:
	if get_parent():
		var ball_posY : float = get_parent().get_node("Ball").position.y
		if ball_posY < (position.y-15):
			direction = Vector2.UP
			velocity += speed * acceleration
		elif ball_posY > (position.y+15):
			direction = Vector2.DOWN
			velocity += speed * acceleration
		else:
			direction = Vector2.ZERO
			velocity -= speed * acceleration/2
	
