extends Marker3D


var scene_instance: Node = null


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func despawn():
	if scene_instance:
		await scene_instance.animate_out()
		scene_instance.queue_free()
		scene_instance = null

func spawn_entity(entity: ChallengeEntity):
	despawn()

	var inst = entity.scene.instantiate()
	add_child(inst)
	await inst.animate_in()
	scene_instance = inst
