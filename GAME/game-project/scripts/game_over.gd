extends Control

func _ready():
	$VBoxContainer/RestartButton.pressed.connect(_on_restart_pressed)
	$VBoxContainer/MainMenuButton.pressed.connect(_on_main_menu_pressed)

func _on_restart_pressed():
	var scene = load("res://scenes/game.tscn")  # Update path if necessary
	if scene == null:
		print("Error: Scene failed to load. Check file path!")
		return
	var _instance = scene.instantiate()
	get_tree().change_scene_to_packed(scene)  # Use change_scene_to_packed()

func _on_main_menu_pressed():
	get_tree().change_scene_to_packed(preload("res://scenes/main_menu.tscn"))
