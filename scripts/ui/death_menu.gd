extends Container
class_name DeathMenu

@export var retry_button: Button;

func _ready() -> void:
	EventBus.player_death.connect(self.on_player_death);

func on_player_death():
	self.visible = true;
	self.retry_button.grab_focus();
	self.get_tree().paused = true;

func on_retry_button_clicked() -> void:
	retry_button_clicked(self);

static func retry_button_clicked(_self) -> void:
	_self.get_tree().paused = false;
	_self.get_tree().reload_current_scene();
	
