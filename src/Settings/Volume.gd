extends HScrollBar

export var normal := Color(0.8, 0.2, 0.8, 1)

var begin : Vector2
var end : Vector2 
var currVal : float
var width := Vector2(1.0, 1.0)

func _ready() -> void:
	modulate = normal
	value = GameSettings.getVolume()
	begin = Vector2(0,7)
	end = Vector2(margin_right-margin_left, 7)

func _draw() -> void:
	draw_line(begin, end, Color.white)

func _Volume_value_changed(value: float) -> void:
	GameSettings.setVolume(value)
