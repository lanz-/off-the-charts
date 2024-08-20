extends Control

signal entity_picked(entity: ChallengeEntity)


@onready var option_buttons: Array[Node] = [
	$Option1,
	$Option2,
	$Option3,
	$Option4,
	$Option5,
]

var current_options: Array[ChallengeEntity] = []


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in option_buttons.size():
		option_buttons[i].pressed.connect(_entity_picked.bind(i))
		

func _entity_picked(id: int):
	entity_picked.emit(current_options[id])


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func set_options(options: Array[ChallengeEntity]):
	current_options = options
	for i in options.size():
		option_buttons[i].text = options[i].name
