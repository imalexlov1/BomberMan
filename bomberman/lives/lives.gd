extends CanvasLayer

var player: Player 
@onready var label_lives = $Label_lives

func update_label_lives(nb_lives):
	label_lives.text = "Vies : " + str(player.current_lives)
	
func _ready() -> void:
	var my_player: Player = get_tree().get_first_node_in_group("joueur")
	player = my_player
	player.update_lives.connect(on_player_update_lives)
	
func on_player_update_lives(new_value):
	update_label_lives(new_value)
	
