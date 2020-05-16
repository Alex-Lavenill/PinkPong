extends Node

const PATH := 'user://game_settings.json'

var file := File.new()
var default := [2.5, 2]
var _settings := {'volume': 0.0, 'dificulty': 0}

func _init() -> void:
	if file.file_exists(PATH):
		loadSet()
	else:
		file.open(PATH, file.WRITE)
		file.store_line(to_json({'volume' : 20, 'dificulty' : 2}))
		file.close()

func setDefault() -> void:
	setVolume(default[0])
	setDificulty(default[1])

func saveSet() -> void:
	file.open(PATH, File.WRITE)
	file.store_line(to_json(_settings))
	file.close()

func loadSet() -> void:
	if file.file_exists(PATH):
		file.open(PATH, File.READ)
		_settings = parse_json(file.get_as_text())
		file.close()

func updateVolume() -> void:
	get_node('/root/Main/Music').volume_db = log(_settings.volume/30) * 10

func setVolume(value: float) -> void:
	_settings.volume = value
	updateVolume()
	saveSet()

func getVolume() -> float:
	loadSet()
	return _settings.volume

func setDificulty(value: int) -> void:
	_settings.dificulty = value
	saveSet()

func getDificulty() -> int:
	loadSet()
	return _settings.dificulty
