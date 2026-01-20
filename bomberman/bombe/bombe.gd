extends StaticBody3D

@onready var timer = $Timer
@onready var anim_player = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	anim_player.play("blink")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var time_left = timer.time_left
	var time_elapsed = 3.0 - time_left
	anim_player.speed_scale = 1.0 + (time_elapsed * 2.0)

func _on_timer_timeout() -> void:
	print("BOUM !")
	get_parent().queue_free()

	
	
