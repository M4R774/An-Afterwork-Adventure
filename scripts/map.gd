extends Node3D


@onready var player = $Player


func _physics_process(delta):
	get_tree().call_group("npc", "update_target_location", player.global_transform.origin)
