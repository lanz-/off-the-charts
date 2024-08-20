extends Control


@export var curve: Curve = null:
	set(value):
		curve = value
		queue_redraw()

@export var steps: int = 20
@export var max_challenge: float = 100.0
@export var challenge_margin: float = 10.0


@onready var challenge_plot = $GridContainer/ChallengePlot

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	challenge_plot.curve = curve
	challenge_plot.steps = steps
	challenge_plot.max_challenge = max_challenge
	challenge_plot.challenge_margin = challenge_margin
	challenge_plot.actual_challenge.clear()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func init(level: Level):
	challenge_plot.actual_challenge.clear()
	challenge_plot.curve = level.curve
	challenge_plot.queue_redraw()
	

func resolve_entity(entity: ChallengeEntity):
	challenge_plot.append_result(entity.challenge_level)
	
	return challenge_plot.get_last_result()
