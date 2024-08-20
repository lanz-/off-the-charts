extends Control

signal start_game
signal show_credits
signal level_select


@onready var start_button = $VBoxContainer/StartButton
@onready var credits_button = $VBoxContainer/CreditsButton
@onready var levelselect_button = $VBoxContainer/LevelSelectButton


func _ready() -> void:
	start_button.pressed.connect(start_game.emit)
	credits_button.pressed.connect(show_credits.emit)
	levelselect_button.pressed.connect(level_select.emit)
