extends Control

signal close

func _ready() -> void:
	var close_button = $CloseButton
	close_button.pressed.connect(close.emit)
