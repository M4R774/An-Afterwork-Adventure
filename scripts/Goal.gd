extends Area3D


func _on_body_entered(body):
	if body.is_in_group("Player"):
		var _result = get_tree().change_scene_to_file("res://scenes/highscores.tscn")
