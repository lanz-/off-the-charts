extends Control

signal intro_completed


@onready var text_area = $VBoxContainer/RichTextLabel
@onready var page_label = $VBoxContainer/PageLabel

@onready var prev_button = $VBoxContainer/HBoxContainer/PrevButton
@onready var next_button = $VBoxContainer/HBoxContainer/NextButton

@onready var close_button = $VBoxContainer/HBoxContainer/CloseButton

var pagei: int = 0
var level: Level = null


func _ready() -> void:
	prev_button.pressed.connect(_on_previous_button_pressed)
	next_button.pressed.connect(_on_next_button_pressed)
	close_button.pressed.connect(_on_close_button_pressed)
	
	play_intro(preload("res://levels/tutorial_level.tres"))


func _process(delta: float) -> void:
	pass


func _update_page():
	page_label.text = "PAGE: %s/%s" % [pagei + 1, level.intro_pages.size()]
	text_area.text = level.intro_pages[pagei]


func _on_previous_button_pressed():
	if pagei > 0:
		pagei -= 1
		_update_page()


func _on_next_button_pressed():
	if pagei < (level.intro_pages.size() - 1):
		pagei += 1
		_update_page()
		

func _on_close_button_pressed():
	intro_completed.emit()
	

func play_intro(intro_level: Level):
	level = intro_level
	pagei = 0
	_update_page()
