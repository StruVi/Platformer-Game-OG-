extends CanvasLayer

@onready var coin_label: Label = $Coin_counter

func _ready():
	await get_tree().process_frame  # Wait for all nodes to load
	coin_label = get_node("VBoxContainer/Coin_counter")
	if coin_label:
		print("CoinCounter found successfully!")
	else:
		print("ERROR: CoinCounter not found!")
		
	$AnimationPlayer.play("coin_count_animation")

func update_coin_count(new_score):
	print("Coin counter updated to: ", new_score)  # Debug print to track the update
	coin_label.text = str(new_score)
