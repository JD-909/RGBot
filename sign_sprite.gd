extends LightSprite2D

func _process(_delta: float) -> void:
	if light_sprite.modulate.r8 > 128:
		if light_sprite.modulate.g8 > 128:
			if light_sprite.modulate.b8 > 128:
				light_sprite.frame = 6
			else:
				light_sprite.frame = 5
		elif light_sprite.modulate.b8 > 128:
			light_sprite.frame = 4
		else:
			light_sprite.frame = 0
	elif light_sprite.modulate.g8 > 128:
		if light_sprite.modulate.b8 > 128:
			light_sprite.frame = 3
		else: 
			light_sprite.frame = 1
	elif light_sprite.modulate.b8 > 128:
		light_sprite.frame = 2
	else:
		light_sprite.frame = 7
