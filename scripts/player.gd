extends CharacterBody2D

const SPEED = 30

# Limites de movimento
const MIN_X = 10
const MAX_X = 854
const MIN_Y = 10
const MAX_Y = 629

# Variável para armazenar a referência ao AnimatedSprite2D
var animated_sprite: AnimatedSprite2D

func _ready() -> void:
	# Inicializa a referência para o AnimatedSprite2D
	animated_sprite = get_node("AnimatedSprite2D")
	
func _physics_process(delta: float) -> void:
	var moving = false  # Variável para controlar se o personagem está se movendo
	
	# Movimentação horizontal
	var direction_horizontal := Input.get_axis("ui_left", "ui_right")
	if direction_horizontal != 0:
		velocity.x = direction_horizontal * SPEED
		if direction_horizontal < 0:
			animated_sprite.animation = "esquerda_andando"  # Andando para a esquerda
		else:
			animated_sprite.animation = "direita_andando"  # Andando para a direita
		moving = true  # Marcamos que há movimento horizontal
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	# Movimentação vertical
	var direction_vertical := Input.get_axis("ui_up", "ui_down")
	if direction_vertical != 0:
		velocity.y = direction_vertical * SPEED
		if direction_vertical < 0:
			animated_sprite.animation = "cima_andando"  # Andando para cima
		else:
			animated_sprite.animation = "baixo_andando"  # Andando para baixo
		moving = true  # Marcamos que há movimento vertical
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)
	
	# Se não houver movimento em nenhuma direção, coloca a animação "parado"
	#diagonal superior direita
	if direction_vertical != 0 and direction_horizontal !=0:
		if direction_horizontal > 0 and direction_vertical < 0:
			velocity.y = move_toward(velocity.y, 0, SPEED)
			velocity.x = move_toward(velocity.x, 0, SPEED)
			animated_sprite.animation = "cima_andando"
			
	#diagonal inferior direita
	if direction_vertical != 0 and direction_horizontal !=0:
		if direction_horizontal > 0 and direction_vertical > 0:
			velocity.y = move_toward(velocity.y, 0, SPEED)
			velocity.x = move_toward(velocity.x, 0, SPEED)
			animated_sprite.animation = "baixo_andando"
			
	#diagonal superior esquerda
	if direction_vertical != 0 and direction_horizontal !=0:
		if direction_horizontal < 0 and direction_vertical < 0:
			velocity.y = move_toward(velocity.y, 0, SPEED)
			velocity.x = move_toward(velocity.x, 0, SPEED)
			animated_sprite.animation = "cima_andando"
			
	#diagonal inferior esquerda
	if direction_vertical != 0 and direction_horizontal !=0:
		if direction_horizontal < 0 and direction_vertical > 0:
			velocity.y = move_toward(velocity.y, 0, SPEED)
			velocity.x = move_toward(velocity.x, 0, SPEED)
			animated_sprite.animation = "baixo_andando"
	
	
	if not moving:
		animated_sprite.animation = "parado"
	
	# Limitar movimento horizontal no eixo X
	position.x = clamp(position.x + velocity.x * delta, MIN_X, MAX_X)
	
	# Limitar movimento vertical no eixo Y
	position.y = clamp(position.y + velocity.y * delta, MIN_Y, MAX_Y)
	
	# Atualizar a posição do personagem
	move_and_slide()
