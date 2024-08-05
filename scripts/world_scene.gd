extends Node2D

var player_alive = true

func _ready():
	# Инициализация сцены
	pass

func _process(delta):
	if player_alive:
		_check_player_status()

func _check_player_status():
	# Здесь добавьте логику для проверки состояния игрока
	# Если игрок умирает, установите player_alive в false и вызовите _goto_character_creation_scene
	if Input.is_action_just_pressed("ui_cancel"):  # Для тестирования, замените это на проверку здоровья или другого параметра
		player_alive = false
		_goto_character_creation_scene()

func _goto_character_creation_scene():
	get_tree().change_scene("res://scenes/CharacterCreationScene.tscn")
