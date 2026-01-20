class_name Player

extends CharacterBody3D

@export var speed = 5.0
@export var gravity = 9.8
@export var rotation_speed = 10.0

@export var bomb_scene : PackedScene 

@export var init_live = 3
var current_lives = init_live

var start_position : Vector3
signal update_lives(new_value)

func _ready ():
	# On mémorise la position au lancement du jeu pour le respawn
	start_position = global_position
	update_lives.emit(current_lives)

func _physics_process(delta):
	if not is_on_floor():
		velocity.y -= gravity * delta

	if Input.is_action_just_pressed("poser_bombe"):
		spawn_bomb()

	var input_dir = Input.get_vector("gauche", "droite", "avancer", "reculer")
	var direction = Vector3(input_dir.x, 0, input_dir.y).normalized()
	
	if direction:
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
		var target_angle = atan2(direction.x, direction.z)
		rotation.y = lerp_angle(rotation.y, target_angle, rotation_speed * delta)
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.z = move_toward(velocity.z, 0, speed)

	move_and_slide()

func spawn_bomb():
	if bomb_scene: 
		print("bomb !")
		var new_bomb = bomb_scene.instantiate()
		get_parent().add_child(new_bomb)
		new_bomb.global_position = global_position

func take_damage():
	current_lives -= 1
	print("Vies : ", current_lives)
	update_lives.emit(current_lives)
	
	if current_lives > 0 : 
		respawn()
	else :
		game_over() 
		
func respawn():
	print("Respawn")
	global_position = start_position
	
	velocity.x = move_toward(velocity.x, 0, speed)
	velocity.z = move_toward(velocity.z, 0, speed)

func game_over():
	print("Game over")
	
