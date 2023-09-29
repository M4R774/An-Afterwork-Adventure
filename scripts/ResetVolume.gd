extends Area3D


func _on_body_entered(body):
	body.global_position = Vector3(0,1.45,0)
