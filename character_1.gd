extends CharacterBody2D

const GRAVITY : float = 20

var speed : float = 500
var break_speed : float = 50
var jump_force : float = -800
var head_follow_speed : float = 30.0
var head_rotation_speed : float = 0.3

@onready var BodySprite = $Sprites/BodySprite
@onready var BodyLightSprite = $Sprites/BodySprite/BodyLightSprite
@onready var HeadSprite = $"../HeadSpriteBox/HeadSprite"
@onready var HeadLightSprite = $"../HeadSpriteBox/HeadSprite/HeadLightSprite"
@onready var SignSprite = $"../HeadSpriteBox/HeadSprite/SignSprite"
@onready var HeadSpriteBox = $"../HeadSpriteBox"

func _physics_process(delta: float) -> void:
	
	# Hacer que la cabeza se mueva despues del cuerpo
	HeadSprite.global_position = HeadSprite.global_position.lerp($".".global_position + Vector2(0, -45), delta * head_follow_speed)
	
	# direction tiene las teclas de direccion
	var direction : float = Input.get_axis("left_key", "right_key")
	var aim : float = Input.get_axis("up_key","down_key")
	
	# Apuntar con la cabeza	
	if aim == 1:
		if HeadSprite.rotation < PI/2:
			HeadSprite.rotation += head_rotation_speed
			SignSprite.rotation -= head_rotation_speed
		else:
			HeadSprite.rotation = PI/2
			SignSprite.rotation = -PI/2
	elif aim == -1:
		if HeadSprite.rotation > -PI/2:
			HeadSprite.rotation -= head_rotation_speed
			SignSprite.rotation += head_rotation_speed
		else:
			HeadSprite.rotation = -PI/2
			SignSprite.rotation = PI/2
	else:
		if (HeadSprite.rotation < 0.1) and (HeadSprite.rotation > -0.1):
			HeadSprite.rotation = 0
			SignSprite.rotation = 0
		elif HeadSprite.rotation < 0:
			HeadSprite.rotation += head_rotation_speed
			SignSprite.rotation -= head_rotation_speed
		elif HeadSprite.rotation > 0:
			HeadSprite.rotation -= head_rotation_speed
			SignSprite.rotation += head_rotation_speed
	
	# Movimiento handler
	if direction != 0 :
		
		# Movimiento de la cabeza
		var headPosQuickSave = HeadSprite.global_position
		
		if direction == -1:
			BodySprite.scale.x = -1.0
			HeadSpriteBox.scale.x = -2.0
		else:
			BodySprite.scale.x = 1.0
			HeadSpriteBox.scale.x = 2.0
		
		HeadSprite.global_position = headPosQuickSave
		
		# se mueve a los lados
		velocity.x = direction * speed
	else:
		
		# Si no, busca volver a 0. a quedarse quieto. Smooth
		velocity.x = velocity.move_toward(Vector2.ZERO, break_speed).x
	
	
	
	# Salto handler
	if is_on_floor() and Input.is_action_just_pressed("jump_key"):
		velocity.y = jump_force
		
	else:
		velocity.y += GRAVITY
	
	# No olvidarse de move and slide
	move_and_slide()


func add_color(color : Color) -> void:
	BodyLightSprite.add_color(color)
	HeadLightSprite.add_color(color)
	SignSprite.add_color(color)
	

func subtract_color(color : Color) -> void:
	BodyLightSprite.subtract_color(color)
	HeadLightSprite.subtract_color(color)
	SignSprite.subtract_color(color)
