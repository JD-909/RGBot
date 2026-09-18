extends Area2D

@export var color_light : Color

func _ready() -> void:
	$Sprite2D.modulate = color_light


func _on_body_entered(body: Node2D) -> void:
	body.add_color(color_light)

func _on_body_exited(body: Node2D) -> void:
	body.subtract_color(color_light)
