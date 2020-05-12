extends KinematicBody2D
# Classe abstrata Pad
# Herdada por Player e Enemy

# Configurações do Pad, exportadas para o editor
export var color := Color.blueviolet
export var size := Vector2(30, 140)
export var padSize := Vector2(12, 65)
export var speed := 500
export var acceleration := .2
export var max_velocity := 600

# Carrega o collisionshape "PadColl"
onready var preColl := preload("res://src/Classes/PadColl.tscn")

var offset := Vector2(-padSize.x, -padSize.y)
var velocity := speed
var direction : Vector2

# Adiciona o collisionshape
func _ready() -> void:
	var Coll := preColl.instance()
	add_child(Coll)

# Desenha o Pad na tela
func _draw() -> void:
	draw_rect(Rect2(offset, padSize*2), color)

# Calcula e trata a movimentação do Pad
func _physics_process(delta: float) -> void:
	velocity = clamp(velocity, .2, max_velocity)
	
	var movement_ammount := direction * velocity * delta
	move_and_collide(movement_ammount)

