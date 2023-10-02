extends HSlider

@onready var settings = get_node("/root/SETTINGS")
var master_bus_index = AudioServer.get_bus_index("Master")


func _ready():
	connect("value_changed", _on_HSlider_value_changed)
	if settings.audio_volume != null: # no settings have been saved
		self.value = settings.audio_volume
	AudioServer.set_bus_volume_db(master_bus_index, linear_to_db(self.value))
	settings.audio_volume = self.value


func _on_HSlider_value_changed(new_value):
	AudioServer.set_bus_volume_db(master_bus_index, linear_to_db(new_value))
	settings.audio_volume = new_value
