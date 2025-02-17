extends Area2D

@onready var animation_player = $AnimationPlayer
@onready var pickup_sound = $pickup_sound  # Ensure this matches the node name in the Scene Tree
@onready var game_manager = get_node("/root/game/GameManager")  # Adjust this path to your GameManager

func _ready():
	if game_manager == null:
		print("ERROR: GameManager (score system) not found!")
	if pickup_sound == null:
		print("ERROR: PickupSound node not found!")
	if animation_player == null:
		print("ERROR: AnimationPlayer node not found!")

func _on_body_entered(body):
	if body.name == "Player":  # Ensure only the player can collect coins
		print("Player collected the coin!")
		
		# Update score
		if game_manager and game_manager.has_method("add_point"):
			game_manager.add_point()
			print("Score Updated!")  # Debugging

		# Play sound if available
		if pickup_sound and pickup_sound.stream:
			pickup_sound.play()
			print("Playing pickup sound!")  # Debugging
			await pickup_sound.finished  # Wait for sound to finish

		# Play animation before removing the coin
		if animation_player and animation_player.has_animation("collect"):
			animation_player.play("collect")
			await animation_player.animation_finished  # Wait for animation to finish

		queue_free()  # Remove the coin
