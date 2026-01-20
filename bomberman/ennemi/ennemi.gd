extends CharacterBody3D

@export var speed = 3
var current_direction = Vector3.FORWARD

func _physics_process(delta: float) -> void:
	# Déplace le corps selon la vitesse velocity
	velocity = current_direction * speed
	move_and_slide()
	
	# S'il touche un mur lors de move and slide alors on change de direction
	if is_on_wall():
		choose_new_direction()
	
func choose_new_direction():
	# Les 4 directions possibles
	var directions = [Vector3.FORWARD, Vector3.BACK, Vector3.LEFT, Vector3.RIGHT]
	# On choisi un aléatoire
	current_direction = directions.pick_random()
	
func die():
	print("Ennemi Mort ...")
	# L'ennemi disparaît
	queue_free() 

func _on_hit_box_body_entered(body: Node3D) -> void:
	if body.has_method("take_damage"):
		body.take_damage()
