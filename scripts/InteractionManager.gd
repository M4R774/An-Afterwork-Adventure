extends Node3D

@onready var player_camera = $".."
const ray_length = 1000
@onready var hand_pos = $"../Marker3D"

var item
var has_item_in_hand = false
var has_plug_in_hand = false

func _physics_process(_delta):
	if Input.is_action_just_released("use"):
		var space_state = get_world_3d().direct_space_state
		var mouse_position = get_viewport().get_mouse_position()
		var raycast_origin = player_camera.project_ray_origin(mouse_position)
		var raycast_target = raycast_origin + player_camera.project_ray_normal(mouse_position) * ray_length
		var physicsRaycastQuery = PhysicsRayQueryParameters3D.create(raycast_origin, raycast_target)
		var raycast_result = space_state.intersect_ray(physicsRaycastQuery)
		
		if has_item_in_hand:
			print("i has item")
			if raycast_result["collider"].is_in_group("socket"):
				print("Socket found")
				if raycast_result["collider"].can_plug_in(item):
					item.plug_in(raycast_result["collider"])
					has_item_in_hand = false
				else:
					item.drop()
					has_item_in_hand = false
			else:
				print("Item dropped")
				item.drop()
				has_item_in_hand = false
	if Input.is_action_just_pressed("use"):
		var space_state = get_world_3d().direct_space_state
		var mouse_position = get_viewport().get_mouse_position()
		var raycast_origin = player_camera.project_ray_origin(mouse_position)
		var raycast_target = raycast_origin + player_camera.project_ray_normal(mouse_position) * ray_length
		var physicsRaycastQuery = PhysicsRayQueryParameters3D.create(raycast_origin, raycast_target)
		var raycast_result = space_state.intersect_ray(physicsRaycastQuery)
		
		if raycast_result.is_empty():
			global_transform.origin = raycast_target
		else:
			global_transform.origin = raycast_result["position"]
			if !has_item_in_hand:
				if raycast_result["collider"].is_in_group("pickup") and !has_item_in_hand:
					#print("Plug found.")
					item = raycast_result["collider"]
					item.pick_up(hand_pos)
					has_item_in_hand = true
					if item.is_in_group("plug"):
						has_plug_in_hand = true
				elif raycast_result["collider"].is_in_group("socket"):
					print("i aint got no plug in hand")
			elif has_item_in_hand:
				print("i has item")
				if raycast_result["collider"].is_in_group("socket"):
					print("Socket found")
					if raycast_result["collider"].can_plug_in(item):
						item.plug_in(raycast_result["collider"])
						has_item_in_hand = false
					else:
						return
				else:
					print("Item dropped")
					item.drop()
					has_item_in_hand = false
	if Input.is_action_just_pressed("mouse_left"):
		$"../hand/AnimationPlayer".play("point")
		var space_state = get_world_3d().direct_space_state
		var mouse_position = get_viewport().get_mouse_position()
		var raycast_origin = player_camera.project_ray_origin(mouse_position)
		var raycast_target = raycast_origin + player_camera.project_ray_normal(mouse_position) * 1.5
		var physicsRaycastQuery = PhysicsRayQueryParameters3D.create(raycast_origin, raycast_target)
		var raycast_result = space_state.intersect_ray(physicsRaycastQuery)
		
		if raycast_result.is_empty():
			global_transform.origin = raycast_target
		else:
			global_transform.origin = raycast_result["position"]
			if raycast_result["collider"].is_in_group("socket") or raycast_result["collider"].is_in_group("water"):
				if raycast_result["collider"].has_electricity:
					print("ouch!")
	if Input.is_action_just_released("mouse_left"):
		$"../hand/AnimationPlayer".play_backwards("point")
	
	# cant have plug if u havent got nothing
	if !has_item_in_hand:
		has_plug_in_hand = has_item_in_hand
