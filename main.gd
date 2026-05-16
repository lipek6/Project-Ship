extends Node
@export var enemy_scene : PackedScene

signal apply_recoil(recoil_vector : Vector2)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	randomize()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_spawn_timer_timeout() -> void:
	var enemy_spawn_location : PathFollow2D = $EnemiesPath/EnemiesSpawnLocation
	enemy_spawn_location.progress_ratio = randf()
	
	var enemy : Node = enemy_scene.instantiate()
	add_child(enemy)
	
	enemy.position = enemy_spawn_location.position
	enemy.rotation = (enemy_spawn_location.rotation + PI / 2) + randf_range(-PI / 4, PI / 4)
	
	var velocity : Vector2 = Vector2(randf_range(enemy.MIN_SPEED, enemy.MAX_SPEED), 0)
	enemy.linear_velocity = velocity.rotated(enemy.rotation)


func _on_player_player_hitted() -> void:
	$HUD.show_game_over()


func _on_player_player_fired(firing_position: Vector2, firing_direction: Vector2, bullet_type: PackedScene) -> void:
	var bullet := bullet_type.instantiate()
	add_child(bullet)
	var recoil_vector : Vector2 = bullet.fire(firing_position, firing_direction)
	emit_signal("apply_recoil", recoil_vector)
