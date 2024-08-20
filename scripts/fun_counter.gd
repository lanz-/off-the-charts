extends TextureProgressBar

const FUN_MAX = 10
const VALUE_MAX = 100

@onready var up_stream: AudioStream = preload("res://assets/fun_up.wav")
@onready var down_stream: AudioStream = preload("res://assets/fun_down.wav")

var fun: int = FUN_MAX
var tween = null


func _update_value():
	if tween:
		tween.kill()
	
	var new_val = (float(fun) / FUN_MAX) * VALUE_MAX
	tween = (
		create_tween()
		.set_ease(Tween.EASE_OUT)
		.set_trans(Tween.TRANS_CUBIC)
	)
		
	tween.tween_property(self, "value", new_val, 0.3)

func reset_fun():
	fun = FUN_MAX
	_update_value()


func increase_fun():
	fun += 1
	fun = min(fun, FUN_MAX)
	Global.play_stream(up_stream)
	_update_value()


func decrease_fun():
	fun -= 1
	fun = max(fun, 0)
	Global.play_stream(down_stream)
	_update_value()


func _ready() -> void:
	pass # Replace with function body.


func _process(delta: float) -> void:
	pass
