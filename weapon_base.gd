extends Node2D

@export var DAMAGE              : int                    # Damage dealt by the gun, needs to be added to the bullet damage
@export var FIRING_RATE         : float                  # How fast the gun shoots the bullets
@export var RECOIL_STRENGTH     : float                  # The strength that the gun will throw the shooter back (the bullet itself also has its own recoil that needs to be combined with this recoil)
@export var BARREL_BULLET_SPEED : float                  # The speed of the bullets that are shot(the bullet itself also has its own speed that needs to combined with this speed)
@export var BULLET_SCENE        : PackedScene            # The kind of the bullet being shot

signal fired(source_position : Vector2, source_direction : Vector2, weapon : Node2D)                 # Alerts main to instantiate the bullet

func _ready() -> void:
	# Setup the firing rate
	$FiringCooldown.wait_time = 60 / FIRING_RATE
	$FiringCooldown.autostart = false
	$FiringCooldown.one_shot  = true



func shoot(source_direction : Vector2) -> void:
	if $FiringCooldown.is_stopped():
		var source_position  : Vector2 = $Muzzle.global_position 
		emit_signal("fired", source_position, source_direction, self)
		$FiringCooldown.start()
