extends RayCast3D

var current_collider: Object
@onready var interaction_label = $InteractionLabel


func _ready():
	set_interaction_text("")


func _process(_delta):
	var collider = get_collider()
	if is_colliding() and collider.has_method("get_interaction_text") and collider.has_method("interact") and collider != null:
		if !collider.is_in_group("socket"):
			if current_collider != collider:
				set_interaction_text(collider.get_interaction_text())
				current_collider = collider
			if Input.is_action_just_pressed("use"):
				current_collider.interact()
				set_interaction_text(collider.get_interaction_text())
		else:
			if $"../InteractionManager".has_plug_in_hand:
				if current_collider != collider:
					set_interaction_text(collider.get_interaction_text())
					current_collider = collider
				if Input.is_action_just_pressed("use"):
					current_collider.interact()
					set_interaction_text(collider.get_interaction_text())
	else:# is_instance_valid(current_collider):
		current_collider = null;
		set_interaction_text("");


func set_interaction_text(text):
	if !text:
		interaction_label.visible = false
	else:
		#var use_events = InputMap.action_get_events("use")
		#var first_use_event = use_events[0]
		#var button_name
		#if first_use_event.keycode:
		#	button_name = OS.get_keycode_string( first_use_event.keycode ) 
		var button_name = "Left click"
		interaction_label.text = "%s to %s" % [button_name, text]
		interaction_label.visible = true
