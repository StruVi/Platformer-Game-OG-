extends Control

@onready var anim = $AnimationPlayer
@onready var fullscreen_toggle = $FullscreenToggle  # Ensure this exists in the scene

func _ready():
	anim.play("fade_in")

	# Load saved fullscreen setting
	var is_fullscreen = load_fullscreen_setting()
	fullscreen_toggle.button_pressed = is_fullscreen  # Set button state
	set_fullscreen(is_fullscreen)

	# Connect buttons
	fullscreen_toggle.toggled.connect(_on_fullscreen_toggled)
	$VBoxContainer/PlayButton.pressed.connect(_on_play_pressed)
	$VBoxContainer/QuitButton.pressed.connect(_on_quit_pressed)

func _on_fullscreen_toggled(pressed):
	set_fullscreen(pressed)
	save_fullscreen_setting(pressed)

func set_fullscreen(enable):
	if enable:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)

func save_fullscreen_setting(enable):
	var config = ConfigFile.new()
	config.set_value("Graphics", "Fullscreen", enable)
	config.save("user://settings.cfg")

func load_fullscreen_setting():
	var config = ConfigFile.new()
	if FileAccess.file_exists("user://settings.cfg"):
		if config.load("user://settings.cfg") == OK:
			return config.get_value("Graphics", "Fullscreen", false)  # Default: windowed
	return false

func _on_play_pressed():
	get_tree().change_scene_to_file("res://scenes/game.tscn")  # Load game scene

func _on_quit_pressed():
	get_tree().quit()  # Quit the game
