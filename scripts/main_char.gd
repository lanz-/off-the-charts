extends Node3D


@onready var anim_player = $AnimationPlayer
@onready var angry_stream = preload("res://assets/angry_1.wav")
@onready var bored_stream = preload("res://assets/bored_2.wav")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	anim_player.play("RESET")
	anim_player.play("idle_bob")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func animate_angry():
	Global.play_stream(angry_stream)
	anim_player.play("angry_bob")
	await anim_player.animation_finished
	anim_player.play("idle_bob")


func animate_bored():
	Global.play_stream(bored_stream)
	anim_player.play("bored_bob")
	await anim_player.animation_finished
	anim_player.play("idle_bob")
