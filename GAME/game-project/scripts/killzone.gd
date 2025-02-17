extends Area2D

@onready var timer: Timer = $Timer

func _on_body_entered(body):
	print("You died!")
	Engine.time_scale = 0.5  # Slow motion effect

	if body.has_node("CollisionShape2D"):
		body.get_node("CollisionShape2D").set_deferred("disabled", true)  # Disable safely
	
	body.hide()  # Hide player before restarting
	timer.start()

func _on_timer_timeout():
	Engine.time_scale = 1.0
	get_tree().change_scene_to_packed(preload("res://scenes/GameOver.tscn"))
