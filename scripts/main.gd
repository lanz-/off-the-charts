extends Node3D

signal level_lost
signal level_won
signal level_quit

const MAX_ACT: int = 20

@export var spawn_pool: Array[ChallengeEntity] = []

@onready var selectors = $UI/Selectors
@onready var challenge_graph = $UI/ChallengeGraph
@onready var challenge_spawn = $ChallengeSpawn
@onready var fun_counter = $UI/VBoxContainer/FunCounter
@onready var act_label = $UI/VBoxContainer/ActLabel
@onready var level_label = $UI/VBoxContainer/LevelLabel
@onready var main_char = $MainChar
@onready var splosions = $Splosions
@onready var main_menu_button = $UI/MainMenuButton


var current_options: Array[ChallengeEntity] = []
var act: int = 1
var leveli: int = 0

func _ready() -> void:
	selectors.entity_picked.connect(entity_picked)
	main_menu_button.pressed.connect(level_quit.emit)


func _pick_options():
	while current_options.size() < 5:
		var i: int = randi() % spawn_pool.size()
		var option: ChallengeEntity = spawn_pool[i]
		spawn_pool.remove_at(i)
		current_options.append(option)
	
	selectors.set_options(current_options)


func _process(delta: float) -> void:
	pass


func play_level(level: Level):
	act = 1
	spawn_pool = level.pool.duplicate()
	fun_counter.reset_fun()
	challenge_spawn.despawn()
	challenge_graph.init(level)
	current_options.clear()
	level_label.text = "Level: %s" % level.name
	act_label.text = "SCENE: %s/%s" % [act, MAX_ACT]
	
	_pick_options()


func entity_picked(entity: ChallengeEntity):
	selectors.hide()
	var id = current_options.find(entity)
	current_options.remove_at(id)
	
	await challenge_spawn.spawn_entity(entity)
	
	await splosions.animate_splosions()
	
	var result = challenge_graph.resolve_entity(entity)
	
	if result != Global.ChallengeResult.RES_OK:
		fun_counter.decrease_fun()
		if result == Global.ChallengeResult.RES_RAGE:
			await main_char.animate_angry()
		else:
			await main_char.animate_bored()	
	else:
		fun_counter.increase_fun()
	
	await challenge_spawn.despawn()
		
	if fun_counter.fun <= 0:
		level_lost.emit()
		return
	
	act += 1
	act_label.text = "SCENE: %s/%s" % [act, MAX_ACT]
	
	if act >= MAX_ACT:
		level_won.emit()
		return
	
	_pick_options()
	selectors.show()
