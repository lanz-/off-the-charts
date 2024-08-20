@tool
extends Node3D

@onready var camera = $Camera3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	camera.look_at(Vector3.ZERO)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	camera.look_at(Vector3.ZERO)
