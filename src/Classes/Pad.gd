extends KinematicBody2D

export var color := Color.blueviolet
export var size := Vector2(30, 140)
export var speed := 500
export var padSize := Vector2(12, 65)

onready var preColl := preload("res://src/Classes/PadColl.tscn")

var offset := Vector2(-padSize.x, -padSize.y)

func _ready() -> void:
	var Coll := preColl.instance()
	add_child(Coll)

# Desenha o pad na tela
func _draw() -> void:
	draw_rect(Rect2(offset, padSize*2), color)
