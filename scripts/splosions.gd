extends Node3D

@onready var splosion_streams: Array[AudioStream] = [
	preload("res://assets/splosion_1.wav"),
	preload("res://assets/splosion_2.wav"),
	preload("res://assets/splosion_3.wav"),
	preload("res://assets/splosion_4.wav"),
	preload("res://assets/splosion_5.wav"),
	preload("res://assets/splosion_6.wav"),
	
]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for child in get_children():
		child.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func animate_splosions():
	var children = get_children().duplicate()
	children.shuffle()
	for child in children:
		Global.play_stream(splosion_streams.pick_random())
		await get_tree().create_timer(0.08 * randf()).timeout
		child.show()
	for child in children:
		await get_tree().create_timer(0.08 * randf()).timeout
		child.hide()
