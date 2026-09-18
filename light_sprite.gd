class_name LightSprite2D
extends Sprite2D

@onready var light_sprite : Sprite2D = $"."

@export var degrade_speed : int = 5

var colors_on_me : Array[Color] = []
var to_color : Color = Color8(0,0,0,255)
var reached_color : bool

func _physics_process(_delta: float) -> void:
	if light_sprite.modulate != to_color:
		
		# R handler
		if light_sprite.modulate.r8 < to_color.r8:
			light_sprite.modulate.r8 += degrade_speed
		elif light_sprite.modulate.r8 > to_color.r8:
			light_sprite.modulate.r8 -= degrade_speed
		
		# G handler
		if light_sprite.modulate.g8 < to_color.g8:
			light_sprite.modulate.g8 += degrade_speed
		elif light_sprite.modulate.g8 > to_color.g8:
			light_sprite.modulate.g8 -= degrade_speed
		
		# B handler
		if light_sprite.modulate.b8 < to_color.b8:
			light_sprite.modulate.b8 += degrade_speed
		elif light_sprite.modulate.b8 > to_color.b8:
			light_sprite.modulate.b8 -= degrade_speed
	else:
		reached_color = true
	


func add_color(color : Color) -> void:
	#var new_color = Color8(0,0,0,255)
	#
	#for color_i in colors_on_me:
		#new_color += color_i
	#
	#to_color = new_color
	colors_on_me.append(color)
	to_color += color
	reached_color = false

func subtract_color(color : Color) -> void:
	colors_on_me.erase(color)
	
	var new_color = Color8(0,0,0,255)
	
	for color_i in colors_on_me:
		new_color += color_i
	
	to_color = new_color
	reached_color = false
