extends KinematicBody2D

# Características da Ball, exportadas para o editor
export var color := Color.aliceblue
export var radius := 15.0
export var speed = 200.0
export var speed_scale := 1.2

var origin : Vector2
var initial_direction: float
var direction: Vector2
var velocity : float

# Trata collisionshape;
# Inicializa variáveis (origin e velocity);
# Randomiza direção inicial da Ball. 
func _ready() -> void:
	$Coll.shape.radius = radius
	
	origin = position
	velocity = speed
	
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
	var collisor := move_and_collide(direction * velocity * delta)
	
	if collisor:
		if collisor.collider.name.begins_with('Left'):
			get_parent().playerPoint()
			restart_ball()
		elif collisor.collider.name.begins_with('Right'):
			get_parent().enemyPoin()
			restart_ball()
		else:
			velocity *= speed_scale # escalando a velocidade sempre que colide
			direction = direction.bounce(collisor.normal) # ricochete

# Reiniciando posição, e velocidade da Ball
# Reinicia na direção daquele que fez o ponto
func restart_ball() -> void:
	position = origin
	direction *= -1
	velocity = speed
