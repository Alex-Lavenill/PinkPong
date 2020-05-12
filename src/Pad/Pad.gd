extends KinematicBody2D

export var color := Color.blueviolet
export var size := Vector2(30, 140)
export var speed := 500

var offset := Vector2(-16, -70)

func _ready() -> void:
	pass

# Desenha o pad na tela
func _draw() -> void:
	draw_rect(Rect2(offset, size), color)

func _physics_process(delta: float) -> void:
	movement(delta)

# Captura os inputs e cuida da movimentação do pad
func movement(delta : float) -> void:
	if Input.is_action_pressed("ui_up") and (position.y + offset.y) > 0:
		position.y -= speed * delta
	if Input.is_action_pressed("ui_down") and (position.y - offset.y) < 600:
		position.y += speed * delta














