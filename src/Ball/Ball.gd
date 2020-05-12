extends KinematicBody2D

export var color := Color.aliceblue
export var radius := 15.0
export var speed = 200.0
export var speed_scale := 1.2

var initial_dir: float
var direction: Vector2
var variation_angle := 10

func _ready() -> void:
	$Coll.shape.radius = radius
	
	randomize()
	initial_dir = randi() %2
	
	if initial_dir == 0:
		direction = Vector2.LEFT
	else:
		direction = Vector2.RIGHT

func _draw() -> void:
	draw_circle(Vector2.ZERO, radius, color)

func _physics_process(delta: float) -> void:
	var collisor := move_and_collide(direction * speed * delta)
	if collisor:
		speed *= speed_scale
		direction = direction.bounce(collisor.normal)

