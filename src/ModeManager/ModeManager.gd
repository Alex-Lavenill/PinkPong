extends Control

onready var lbl_start := $InitialMenu/start
onready var btn_start := $InitialMenu/start/start
onready var btn_settings := $Setting
onready var btn_back := $Back
onready var btn_restart := $restart
onready var lbl_winner := $winner
onready var aud_ending := $Ending

var mode : int setget setMode
var last_mode : int
var desktop : bool
var mobileOS := ['android', 'ios']
var difclt : int

func _ready() -> void:
	if mobileOS.count(OS.get_name().to_lower()):
		desktop = false
	else:
		desktop = true
	if desktop:
		btn_start.visible = false
		get_parent().get_node("TouchManager").visible = false
		get_parent().get_node("TouchManager/btn_down").disabled = true
		get_parent().get_node("TouchManager/btn_up").disabled = true
		lbl_start.text = "Press any key to Start"
	else:
		lbl_start.text = "Start"
	setMode(-1)
	pause()

func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		if event.pressed and mode == -1:
			setMode(0)
			pause()
		elif Input.is_action_pressed('pause') and mode != 2:
			setMode(1)
			pause()

func pause() -> void:
	var new_pause_state := !get_tree().paused
	get_tree().paused = new_pause_state
	visible = new_pause_state

func setMode(value: int) -> void:
	last_mode = mode
	mode = value
	if mode == -1:
		lbl_start.visible = true
		btn_settings.visible = true
		btn_restart.visible = true
		btn_back.visible = false
		$Settings.visible = false
	if mode == 0:
		lbl_start.visible = false
		btn_restart.visible = true
		$Settings.visible = false
	if mode == 1:
		btn_back.visible = true
		btn_restart.visible = true
		btn_settings.visible = true
		$Settings.visible = false
		pass
	if mode == 2:
		lbl_winner.visible = true
		btn_restart.visible = true
		btn_settings.visible = true
		btn_back.visible = false
		$Settings.visible = false
		if last_mode < 3:
			aud_ending.play()
	if mode == 3:
		lbl_start.visible = false
		lbl_winner.visible = false
		btn_back.visible = false
		btn_restart.visible = false
		btn_start.visible = false
		btn_settings.visible = false
		$Settings.visible = true

func _on_btn_restart_pressed() -> void:
	pause()
	get_tree().change_scene("res://src/Restart/Restart.tscn")

func _Settings_pressed() -> void:
	last_mode = mode
	setMode(3)

func _Back_pressed() -> void:
	setMode(1)
	pause()
