extends KinematicBody2D

# Características da Ball, exportadas para o editor
export var color := Color.aliceblue
export var radius := 15.0

var speed := [200.0, 400.0, 600.0]
var max_velocity := [800.0, 1100.0, 1500.0]
var speed_scale := [1.1, 1.2, 1.3]
var origin : Vector2
var initial_direction: float
var direction: Vector2
var velocity : float
var last_pad_collided : Node
var mode := 2

# Trata collisionshape;
# Inicializa variáveis (origin e velocity);
# Randomiza direção inicial da Ball. 
func _ready() -> void:
	$Coll.shape.radius = radius
	
	origin = position
	velocity = speed[mode]
	
	# 0 == esquerda; 1 == direita
	randomize() # Para a ficar realmente aleatório
	initial_direction = randi() %2 # APENAS 0 ou 1
	if initial_direction == 0:
		direction = Vector2.LEFT 
	else:
		direction = Vector2.RIGHT

# Desenhando a Ball na tela
func _draw() -> void:
	draw_circle(Vector2.ZERO, radius, color)

# Move numa direção com velocidade constante, detecta colisões caso existam;
# Passar para trás de um Pad: ponto do adversário;
# Colidir com Pad/parede (supeior/inferior): escalar velocidade e ricochetear.  
func _physics_process(delta: float) -> void:
	# movendo a Ball e detectando colisões (quando existem)
	velocity = clamp(velocity, speed[mode], max_velocity[mode])
	var movement_ammount := direction * velocity * delta
	
	var collisor := move_and_collide(movement_ammount)
	if collisor:
		var collider := collisor.collider
		if collider.name.begins_with('Left'):
			get_parent().enemyPoint()
		elif collider.name.begins_with('Right'):
			get_parent().playerPoint()
		else:
			if !collider == last_pad_collided:
				if (collider.has_method('_draw')) and (position.x < 61 or position.x < 985):
					if  collider.direction.y > 0:
						direction += Vector2(0, .2)
					elif collider.direction.y < 0:
						direction += Vector2(0, -.2)
					last_pad_collided = collider
					direction.x = -direction.x
					velocity *= speed_scale[mode] # escalando a velocidade sempre que colide
					if collider.has_method('playerVelocity'):
						get_parent().get_node("Cam/aud_player").playerAudio()
					else:
						get_parent().get_node("Cam/aud_enemy").enemyAudio()
				else:
					direction = direction.bounce(collisor.normal) # ricochete
					get_parent().get_node("Cam/aud_center").wallAudio()

# Reiniciando posição, e velocidade da Ball
# Reinicia na direção daquele que fez o ponto
func restart_ball(initial_dir: Vector2) -> void:
	position = origin
	direction = initial_dir
	velocity = speed[mode]
	last_pad_collided = Node.new()
