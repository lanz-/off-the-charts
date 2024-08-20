extends Node

enum ChallengeResult {RES_OK, RES_RAGE, RES_BORE}

var num_players = 8

var available = []
var queue = []


func _ready():
	for i in num_players:
		var p = AudioStreamPlayer.new()
		add_child(p)
		available.append(p)
		p.finished.connect(_on_stream_finished.bind(p))


func _on_stream_finished(player):
	available.append(player)


func play_stream(stream):
	queue.append(stream)


func _process(delta):
	if not queue.is_empty() and not available.is_empty():
		available[0].stream = queue.pop_front()
		available[0].play()
		available.pop_front()
