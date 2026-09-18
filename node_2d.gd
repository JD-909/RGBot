extends Node2D

@onready var light_sprite : Sprite2D = $Wings

@export var degrade_speed : int = 1

var to_color : Color = Color.WHITE
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
	
	$Label.text = "(" + str(light_sprite.modulate.r8) + "," + str(light_sprite.modulate.g8) + "," + str(light_sprite.modulate.b8) + ")"
	pass

func change_color(color : Color) -> void:
	to_color = color
	reached_color = false

func _on_button_r_pressed() -> void:
	change_color(Color.RED)

func _on_button_g_pressed() -> void:
	change_color(Color.GREEN)

func _on_button_b_pressed() -> void:
	change_color(Color.BLUE)

func _on_button_c_pressed() -> void:
	change_color(Color.CYAN)

func _on_button_m_pressed() -> void:
	change_color(Color.MAGENTA)

func _on_button_y_pressed() -> void:
	change_color(Color.YELLOW)

func _on_button_w_pressed() -> void:
	change_color(Color.WHITE)

func _on_button_k_pressed() -> void:
	change_color(Color.BLACK)


func _on_button_stop_pressed() -> void:
	change_color(light_sprite.modulate)


func _on_button_shoot_pressed() -> void:
	if reached_color:
		light_sprite.modulate.r8 -= 128
		light_sprite.modulate.g8 -= 128
		light_sprite.modulate.b8 -= 128
	reached_color = false
