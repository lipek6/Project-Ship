extends RigidBody2D

@export var MIN_SPEED : float = 150.0
@export var MAX_SPEED : float = 250.0
 
func _ready() -> void:
	$AnimationPlayer.play("Thrust Forward")

func _process(delta: float) -> void:
	pass


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
