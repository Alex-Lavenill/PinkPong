extends HScrollBar

export var normal := Color(0.8, 0.2, 0.8, 1)

var begin : Vector2
var end : Vector2 
var currVal : float

# o volume recebe isso: log(slider_value) * 20

func _ready() -> void:
	modulate = normal
	value = GameSettings.getVolume()
	begin = Vector2(0,4)
	end = Vector2(margin_right-margin_left, 4)

func _draw() -> void:
	draw_line(begin, end, Color.white, 1.5)

func _Volume_value_changed(value: float) -> void:
	GameSettings.setVolume(value)
