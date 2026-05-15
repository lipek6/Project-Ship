extends Node
@export var enemy_scene : PackedScene

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
