extends Area2D

@export var BULLET_SCENE : PackedScene = preload("res://bullet_default.tscn")
@export var SPEED  : float   = 400.0
var screen_size    : Vector2 = Vector2.ZERO

signal player_fired(firing_position : Vector2, firing_direction : Vector2, bullet_type : PackedScene)
signal player_hitted



func shoot_weapon():
	emit_signal("player_fired", $LeftGunBarrel.global_position,  get_global_mouse_position() - position, BULLET_SCENE)
	emit_signal("player_fired", $RightGunBarrel.global_position, get_global_mouse_position() - position, BULLET_SCENE)



func _ready():
	screen_size = get_viewport_rect().size
	preload("res://bullet_default.tscn")


# Used after being hitted
func restart_player_position(new_position):
	position = new_position
	show()
	$CollisionPolygon2D.disabled = false



func _draw() -> void:
	# Add conscise points into the gun to locate the shooting source
	draw_line(Vector2(+10,0), get_local_mouse_position(), Color.DARK_MAGENTA, 2.0, true)
	draw_line(Vector2(-10,0), get_local_mouse_position(), Color.DARK_MAGENTA, 2.0, true)



func _process(delta: float) -> void:
	var direction : Vector2 = Vector2.ZERO
	var animation : AnimatedSprite2D = get_node("AnimatedSprite2D")
	
	# Handles movement input
	if(Input.is_action_pressed("mv_right")):
		direction.x += 1
	if(Input.is_action_pressed("mv_left")):
		direction.x -= 1
	if(Input.is_action_pressed("mv_forward")):
		direction.y -= 1
	if(Input.is_action_pressed("mv_back")):
		direction.y += 1
	direction = direction.normalized()
	
	# Handles shooting input
	if(Input.is_action_pressed("shoot_primary_weapon")):
		shoot_weapon()
	
	
	# Handles updating position
	position  += direction * SPEED * delta
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)
	
	# Handles animation
	if(direction.y < 0):
		animation.play("forward_thrust")
	if(direction == Vector2.ZERO):
		animation.play("idle")
	
	# Handles the look at mouse 
	rotate(Vector2(0,-1).angle_to(get_local_mouse_position()))
	queue_redraw()
	
	
	



func _on_body_entered(body: Node2D) -> void:
	hide()
	$CollisionPolygon2D.set_deferred("disabled", true)
	emit_signal("player_hitted")




func _on_main_apply_recoil(recoil_vector: Vector2) -> void:
	position += recoil_vector * get_process_delta_time()
