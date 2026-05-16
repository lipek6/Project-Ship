extends CanvasLayer

@export var MESSAGE_TIMEOUT_TIME : float  =  3.0
@export var DEFAULT_MESSAGE      : String = "Ship Project"
signal start_game

func _on_start_button_pressed() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	$StartButton.hide()
	$MessageLabel.hide()
	$Crosshair.show()
	emit_signal("start_game")


func update_score(new_score : int):
	$ScoreLabel.text = str(new_score)

func show_game_over():
	show_message("GAME OVER")


func show_message(text_to_show : String):
	$MessageLabel.text = text_to_show
	$MessageLabel.show()
	$Timer.start(MESSAGE_TIMEOUT_TIME)

func _on_timer_timeout() -> void:
	$MessageLabel.text = DEFAULT_MESSAGE
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	$StartButton.show()
	$Crosshair.hide()
