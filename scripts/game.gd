extends Node

@onready var main_scene: PackedScene = preload("res://scenes/main.tscn")
@onready var credits_scene: PackedScene = preload("res://scenes/credits.tscn")
@onready var main_menu_scene: PackedScene = preload("res://scenes/main_menu.tscn")
@onready var intro_scene: PackedScene = preload("res://scenes/intro.tscn")
@onready var level_select_scene: PackedScene = preload("res://scenes/level_select.tscn")

@onready var audio_player = $AudioStreamPlayer


@onready var levels = [
	preload("res://levels/tutorial_level.tres"),
	preload("res://levels/act_1.tres"),
	preload("res://levels/act_2.tres"),
	preload("res://levels/act_3.tres"),
	preload("res://levels/demo.tres"),
]
var leveli: int = 0

var current_scene: Node = null

var menu_music: AudioStream = preload("res://assets/_menu_01 - Sketchy Logic - Ride Onward.mp3")


func _ready() -> void:
	menu_music.loop
	go_to_menu()


func _switch_music(target_stream: AudioStream):
	if audio_player.playing:
		await create_tween().tween_property(audio_player, "volume_db", -100, 1.0).finished
		audio_player.stop()
	
	audio_player.volume_db = 0.0
	audio_player.stream = target_stream
	audio_player.play()

func _set_current_scene(node: Node):
	if current_scene:
		current_scene.queue_free()
	
	add_child(node)
	current_scene = node


func _play_level(i: int):
	leveli = i
	
	await _switch_music(levels[leveli].intro_music)
	var intro = intro_scene.instantiate()
	_set_current_scene(intro)
	intro.play_intro(levels[leveli])
	
	await intro.intro_completed
	
	await _switch_music(levels[leveli].level_music)
	var main = main_scene.instantiate()
	_set_current_scene(main)
	main.play_level(levels[leveli])
	
	main.level_lost.connect(_fail)
	main.level_quit.connect(go_to_menu)
	
	var next_level = leveli + 1
	if next_level >= levels.size():
		main.level_won.connect(_last_level)
	else:
		main.level_won.connect(_play_level.bind(next_level))

func _last_level():
	var levelr = preload("res://levels/last_level.tres")
	
	await _switch_music(levelr.intro_music)
	var intro = intro_scene.instantiate()
	_set_current_scene(intro)
	intro.play_intro(levelr)
	
	await intro.intro_completed
	go_to_menu()

func _fail():
	var levelr = preload("res://levels/lose_intro.tres")
	
	await _switch_music(levelr.intro_music)
	var intro = intro_scene.instantiate()
	_set_current_scene(intro)
	intro.play_intro(levelr)
	
	await intro.intro_completed
	go_to_menu()


func start_game(leveli: int):
	_play_level(leveli)


func go_to_menu():
	_switch_music(menu_music)
	var main_menu = main_menu_scene.instantiate()
	
	main_menu.start_game.connect(start_game.bind(0))
	main_menu.show_credits.connect(show_credits)
	main_menu.level_select.connect(level_select)
	_set_current_scene(main_menu)


func show_credits():
	var credits = credits_scene.instantiate()
	credits.close.connect(go_to_menu)
	
	_set_current_scene(credits)


func level_select():
	var level_select_inst = level_select_scene.instantiate()
	
	level_select_inst.level_select.connect(start_game)
	
	_set_current_scene(level_select_inst)
