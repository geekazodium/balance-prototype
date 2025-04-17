extends Container
class_name DeathMenu

func _ready() -> void:
	EventBus.player_death.connect(self.on_player_death);

func on_player_death():
	self.visible = true;
	self.get_tree().paused = true;

func retry_button_clicked() -> void:
	self.get_tree().paused = false;
	self.get_tree().reload_current_scene();
