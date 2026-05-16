extends CharacterBody2D

@export var LEFT_WEAPON_SCENE  : PackedScene
@export var RIGHT_WEAPON_SCENE : PackedScene
@export var SPEED  : float   = 400.0
var screen_size    : Vector2 = Vector2.ZERO

var left_weapon
var right_weapon

signal player_hitted

func _ready():
	screen_size = get_viewport_rect().size
	
	left_weapon  = LEFT_WEAPON_SCENE.instantiate()
	right_weapon = RIGHT_WEAPON_SCENE.instantiate()
	left_weapon.position  = Vector2.ZERO
	right_weapon.position = Vector2.ZERO 
	
	right_weapon.get_node("Sprite2D").flip_h = true
	right_weapon.position.x += 2
	$LeftGunMountPoint.add_child(left_weapon)
	$RightGunMountPoint.add_child(right_weapon)




# Used after being hitted
func restart_player_position(new_position):
	position = new_position
	show()
	$CollisionPolygon2D.disabled = false



func _draw() -> void:
	draw_line(Vector2(+10,0), get_local_mouse_position(), Color.DARK_MAGENTA, 2.0, true)
	draw_line(Vector2(-10,0), get_local_mouse_position(), Color.DARK_MAGENTA, 2.0, true)



func _process(delta: float) -> void:
	var direction : Vector2 = Vector2.ZERO
	var animation : AnimationPlayer = $AnimationPlayer
	
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
	if(Input.is_action_pressed("shoot_left_weapon")):
		left_weapon.shoot(get_global_mouse_position() - left_weapon.get_node("Muzzle").global_position)
	if(Input.is_action_pressed("shoot_right_weapon")):
		right_weapon.shoot(get_global_mouse_position() - right_weapon.get_node("Muzzle").global_position)

	
	# Handles updating position
	position  += direction * SPEED * delta
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)
	
	# Handles animation
	if(direction.y < 0):
		animation.play("Thrust Forward")
	if(direction == Vector2.ZERO):
		animation.play("Idle")
	
	# Handles the look at mouse 
	rotate(Vector2(0,-1).angle_to(get_local_mouse_position()))
	queue_redraw()
	
	
	



func _on_body_entered(body: Node2D) -> void:
	hide()
	$CollisionPolygon2D.set_deferred("disabled", true)
	emit_signal("player_hitted")




func _on_main_apply_recoil(recoil_vector: Vector2) -> void:
	position += recoil_vector * get_process_delta_time()
