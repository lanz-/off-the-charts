extends Control

signal level_select(leveli: int)

@onready var vbox = $VBoxContainer


func _ready() -> void:
	var buttons = vbox.get_children()
	for i in buttons.size():
		buttons[i].pressed.connect(level_select.emit.bind(i))


func _process(delta: float) -> void:
	pass
