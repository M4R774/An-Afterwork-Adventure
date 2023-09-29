extends CharacterBody3D

@onready var nav_agent = $electrician_assets/NavigationAgent3D
@onready var nav_path = $"../npc_path"

const SPEED = 2

var path_points = 5
var current_point = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	path_points = nav_path.curve.point_count
	print(path_points)
	#update_target_location(player.global_position)


func _physics_process(delta):
	var current_location = global_transform.origin
	var next_location = nav_agent.get_next_path_position()
	var new_velocity = (next_location - current_location).normalized() * SPEED
	
	velocity = new_velocity
	move_and_slide()
	if transform.origin != next_location:
		look_at(next_location)
	

func update_target_location(target_location):
	nav_agent.target_position = target_location
