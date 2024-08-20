extends Node3D


@onready var anim_player = $AnimationPlayer
@export var anim_name: String = ""

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func animate_in():
	anim_player.play(anim_name)
	await anim_player.animation_finished

func animate_out():
	anim_player.play_backwards(anim_name)
	await anim_player.animation_finished
