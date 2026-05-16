extends Area2D

@export var SPEED  : float = 1000.00
@export var RECOIL : float = 100.00
var current_firing_direction : Vector2 = Vector2.ZERO


func fire(firing_position : Vector2, firing_direction : Vector2) -> Vector2:
	current_firing_direction = firing_direction.normalized()
	position = firing_position
	
	return -(current_firing_direction * RECOIL) 



func _physics_process(delta: float) -> void:
	position += current_firing_direction * SPEED * delta
