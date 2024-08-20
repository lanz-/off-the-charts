class_name Level
extends Resource

@export var name: String = ""
@export var curve: Curve = null
@export var pool: Array[ChallengeEntity]

@export_multiline var intro_pages: Array[String] = []

@export var intro_music: AudioStream = null
@export var level_music: AudioStream = null
