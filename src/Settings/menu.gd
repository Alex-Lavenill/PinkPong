extends Control

onready var btn_easy := $easy
onready var btn_normal := $normal
onready var btn_hard := $hard
onready var btn_back := $Back
onready var btn_default := $Default
onready var btn_ok := $OK
onready var grandfather := get_parent().get_parent()
onready var currDificulty

var green := Color(0.1, 0.9, 0.6, 1)

func _ready() -> void:
	grandfather.difclt = GameSettings.getDificulty()
	buttonDificultyToGreen()
	btn_easy.connect("pressed", self, "Easy_pressed")
	btn_normal.connect("pressed", self, "Normal_pressed")
	btn_hard.connect("pressed", self, "Hard_pressed")
	btn_back.connect("pressed", self, "Ok_pressed")
	btn_default.connect("pressed", self, "Default_pressed")
	btn_ok.connect("pressed", self, "Ok_pressed")

func buttonDificultyToGreen() -> void:
	currDificulty = GameSettings.getDificulty()
	if currDificulty == 1:
		btn_easy.self_modulate = green
		btn_normal.self_modulate = Color.white
		btn_hard.self_modulate = Color.white
		btn_normal.pressed = true
	if currDificulty == 2:
		btn_easy.self_modulate = Color.white
		btn_normal.self_modulate = green
		btn_hard.self_modulate = Color.white
	if currDificulty == 3:
		btn_easy.self_modulate = Color.white
		btn_normal.self_modulate = Color.white
		btn_hard.self_modulate = green

func Easy_pressed() -> void:
	GameSettings.setDificulty(1)
	buttonDificultyToGreen()

func Normal_pressed() -> void:
	GameSettings.setDificulty(2)
	buttonDificultyToGreen()

func Hard_pressed() -> void:
	GameSettings.setDificulty(3)
	buttonDificultyToGreen()

func Default_pressed() -> void:
	GameSettings.setDefault()
	if GameSettings.getDificulty() == 1:
		Easy_pressed()
	if GameSettings.getDificulty() == 2:
		Normal_pressed()
	if GameSettings.getDificulty() == 3:
		Hard_pressed()
	$Volume.value = GameSettings.getVolume()

func Ok_pressed() -> void:
	grandfather.setMode(grandfather.last_mode)
