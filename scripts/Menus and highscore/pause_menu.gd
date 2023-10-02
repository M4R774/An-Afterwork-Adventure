extends PanelContainer


# Making sure the pause menu is not visible when game starts
func _ready():
	if visible:
		visible = false


func _input(_event):
	if Input.is_action_just_pressed("ui_cancel"):
		self.visible = not self.visible
		get_tree().paused = self.visible


func _on_continue_pressed():
	self.visible = false
	get_tree().paused = self.visible
