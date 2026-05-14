extends Area2D

@export var SPEED : float = 400.0
var screen_size   : Vector2 = Vector2.ZERO
signal player_hitted



func _ready():
	screen_size = get_viewport_rect().size

# Used after being hitted
func restart_player_position(new_position):
	position = new_position
	show()
	$CollisionPolygon2D.disabled = false

func _process(delta: float) -> void:
	var direction : Vector2 = Vector2.ZERO
	var animation : AnimatedSprite2D = get_node("AnimatedSprite2D")
	
	# Handles input
	if(Input.is_action_pressed("mv_right")):
		direction.x += 1
	if(Input.is_action_pressed("mv_left")):
		direction.x -= 1
	if(Input.is_action_pressed("mv_forward")):
		direction.y -= 1
	if(Input.is_action_pressed("mv_back")):
		direction.y += 1
	direction = direction.normalized()
	
	# Handles updating position
	position  += direction * SPEED * delta
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)
	
	# Handles animation
	if(direction.y < 0):
		animation.play("forward_thrust")
	if(direction == Vector2.ZERO):
		animation.play("idle")


func _on_body_entered(body: Node2D) -> void:
	hide()
	$CollisionPolygon2D.set_deferred("disabled", true)
	
	emit_signal("player_hitted")
