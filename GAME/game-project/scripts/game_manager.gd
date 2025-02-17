extends Node

var score := 0
@onready var hud = get_node("/root/game/CanvasLayer/HUD")  # Adjust this path to your HUD scene


func _ready():
	await get_tree().process_frame  # Wait for all nodes to load
	if hud:
		print("HUD found successfully!")
	else:
		print("ERROR: HUD not found!")

func add_point():
	score += 1
	print("Score updated to: ", score)  # Debug print to track score change
	if hud:
		hud.update_coin_count(score)  # Call the HUD function to update the coin counter
	else:
		print("HUD not found!")  # Check if GameManager can find the HUD node
