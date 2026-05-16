extends Area2D

@export var DAMAGE           : int                   # Damage dealt by the bullet 
@export var SPEED            : float                 # Bullet speed
@export var RECOIL_STRENGTH  : float                 # The strength that the bullet will throw the shooter back

var firing_direction : Vector2 = Vector2.ZERO        # Direction of the bullet, used to simulate project

# Returns the recoil vector
func shoot(source_firing_position : Vector2, source_firing_direction : Vector2, weapon : Node2D) -> Vector2:
	firing_direction = source_firing_direction.normalized()
	position         = source_firing_position
	SPEED            += weapon.BARREL_BULLET_SPEED
	DAMAGE           += weapon.DAMAGE
	RECOIL_STRENGTH  += weapon.RECOIL_STRENGTH
	
	return -(firing_direction * RECOIL_STRENGTH) 


# Updates the bullet position
func _physics_process(delta: float) -> void:
	position += firing_direction * SPEED * delta


# Deletes the bullet when out of bounds
func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()

# Will need a function later to make the bullet deal demage
