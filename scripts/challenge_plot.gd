extends Control

const SPEED = 300

@export var curve: Curve = null:
	set(value):
		curve = value
		queue_redraw()

@export var steps: int = 20
@export var max_challenge: float = 100.0
@export var challenge_margin: float = 20.0
@export var actual_challenge: Array[float] = []

var target_yy: float = 0
var animate_yy: float = 0


func _ready() -> void:
	pass

func _process(delta: float) -> void:
	if animate_yy < target_yy:
		animate_yy += SPEED * delta
		animate_yy = min(animate_yy, target_yy)
		queue_redraw()


func _get_xx(step):
	return float(step) / steps


func _draw_curve():
	var points = []
	for i in range(steps):
		var xx = _get_xx(i)
		points.append(Vector2(xx * size.x, size.y - (curve.sample(xx) * size.y)))
	
	draw_polyline(points, Color.CORNFLOWER_BLUE, 8.0, true)


func append_result(challenge):
	actual_challenge.append(challenge)
	animate_yy = 0
	target_yy = (challenge / max_challenge) * size.y
	queue_redraw()

func get_last_result():
	var i = actual_challenge.size() - 1
	if i < 0:
		return Global.ChallengeResult.RES_OK
	
	var xx = _get_xx(i)
	var expected_challenge = curve.sample(xx) * max_challenge
	var step_challenge = actual_challenge[i]
	
	if step_challenge > (expected_challenge + challenge_margin):
		return Global.ChallengeResult.RES_RAGE
	
	if step_challenge < (expected_challenge - challenge_margin):
		return Global.ChallengeResult.RES_BORE
	
	return Global.ChallengeResult.RES_OK


func _draw_actual_challenge():
	const WIDTH = 10.0
	
	for i in range(steps):
		if actual_challenge.size() <= i:
			return

		var xx = _get_xx(i)
		var expected_challenge = curve.sample(xx) * max_challenge
		var step_challenge = actual_challenge[i]
		
		var color = Color.YELLOW_GREEN

		if step_challenge > (expected_challenge + challenge_margin):
			color = Color.DARK_RED

		if step_challenge < (expected_challenge - challenge_margin):
			color = Color.LIGHT_GRAY

		
		xx = xx * size.x
		var yy = (step_challenge / max_challenge) * size.y
		if i == actual_challenge.size() - 1:
			yy = animate_yy
		
		draw_rect(Rect2(xx - WIDTH / 2.0, size.y - yy, WIDTH, yy), color)


func _draw() -> void:
	if curve:
		_draw_curve()
	_draw_actual_challenge()
