extends CharacterBody3D

@export var speed = 3.0
@export var temps_avant_changement = 2.0 # Change de direction toutes les 2 secondes

var current_direction = Vector3.FORWARD
var timer = 0.0

func _ready():
	# On choisit une première direction au hasard dès le début
	choose_new_direction()

func _physics_process(delta: float) -> void:
	# 1. On gère le Timer manuellement (plus simple)
	timer -= delta
	if timer <= 0:
		choose_new_direction()
		timer = temps_avant_changement # On remet le chrono

	# 2. On avance bêtement dans la direction actuelle
	velocity = current_direction * speed
	
	# 3. On regarde où on va (pour que le visuel suive)
	if current_direction != Vector3.ZERO:
		look_at(global_position + current_direction, Vector3.UP)

	# 4. On bouge. S'il y a un mur, move_and_slide va juste le faire glisser/bloquer
	# On ne vérifie PAS s'il touche un mur, on s'en fiche.
	move_and_slide()

func choose_new_direction():
	var directions = [Vector3.FORWARD, Vector3.BACK, Vector3.LEFT, Vector3.RIGHT]
	
	# On prend une direction totalement au pif
	current_direction = directions.pick_random()

func die():
	print("Ennemi Mort ...")
	queue_free() 

func _on_hit_box_body_entered(body: Node3D) -> void:
	if body.has_method("take_damage"):
		body.take_damage()
