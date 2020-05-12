extends "res://src/Classes/Pad.gd"

export var acceleration := 0.12
export var tolerance := 5

var ball_posY : float
var target : Vector2
var velocity : float

func _ready() -> void:
	$Coll.rotation_degrees = 180

func _physics_process(delta: float) -> void:
	if get_parent():
		ball_posY = get_parent().get_node("Ball").position.y
		if ball_posY < (position.y-15):
			target = Vector2.UP
			velocity += speed * acceleration
		elif ball_posY > (position.y+15):
			target = Vector2.DOWN
			velocity += speed * acceleration
		else:
			target = Vector2.ZERO
			velocity += speed * -acceleration
	
	velocity = clamp(velocity, 5, 350)
	var movement_ammount := target * velocity * delta
	
	move_and_collide(movement_ammount)
