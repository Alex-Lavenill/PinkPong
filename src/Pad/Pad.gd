extends KinematicBody2D
# Classe abstrata Pad
# Herdada por Player e Enemy

# Configurações do Pad, exportadas para o editor
export var color := Color.blueviolet
export var size := Vector2(30, 140)
export var padSize := Vector2(12, 65)

# Carrega o collisionshape "PadColl"
onready var preColl := preload("res://src/Pad/PadColl.tscn")

var mode := 2
var speed := [400.0, 600.0, 800.0]
var acceleration := [.1 ,.2, .5]
var max_velocity := [600.0, 800.0, 1000.0]
var offset := Vector2(-padSize.x, -padSize.y)
var velocity : float = speed[mode]
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
	velocity = clamp(velocity, .1, max_velocity[mode])
	var movement_ammount := direction * velocity * delta
	move_and_collide(movement_ammount)

