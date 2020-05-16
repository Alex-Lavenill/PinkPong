extends Node2D

onready var btn_up := $btn_up
onready var btn_down := $btn_down
onready var player := get_parent().get_node("Player")

func _ready() -> void:
	btn_up.connect("button_down", self, 'up_pressed')
	btn_up.connect("button_up", self, 'up_relised')
	btn_down.connect("button_down", self, 'down_pressed')
	btn_down.connect("button_up", self, 'down_relised')

func _draw() -> void:
	draw_line(Vector2(0,300), Vector2(1024,300), Color.white)

func up_pressed() -> void:
	player.touchedUp = true

func up_relised() -> void:
	player.touchedUp = false

func down_pressed() -> void:
	player.touchedDown = true

func down_relised() -> void:
	player.touchedDown = false

