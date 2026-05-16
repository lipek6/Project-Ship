extends AnimatedSprite2D

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	position = get_global_mouse_position()
