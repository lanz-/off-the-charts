extends Button

@export var effect: float = 1.1
@export var time: float = 0.1

@onready var hover_stream = preload("res://assets/s_button.wav")
@onready var click_stream = preload("res://assets/s_click.wav")


func _ready() -> void:
	mouse_entered.connect(_on_hover_start)
	mouse_exited.connect(_on_hover_end)
	
	pressed.connect(Global.play_stream.bind(click_stream))


func _process(delta: float) -> void:
	pass


func _on_hover_start():
	pivot_offset = size / 2
	Global.play_stream(hover_stream)
	create_tween().tween_property(self, "scale", Vector2.ONE * effect, time)


func _on_hover_end():
	create_tween().tween_property(self, "scale", Vector2.ONE, time)
