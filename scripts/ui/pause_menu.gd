extends VBoxContainer
class_name PauseMenu

@export var default_focus_button: Button = null;

var unpause_call: bool = false;
const LEVEL_SELECT_SCENE: String = "res://scenes/level_select.tscn";

func on_pause_game() -> void:
	self.visible = true;
	self.default_focus_button.grab_focus();

func on_continue_pressed() -> void:
	self.visible = false;
	self.unpause_call = true;

func on_retry_pressed() -> void:
	DeathMenu.retry_button_clicked(self);

func on_return_to_level_select_pressed() -> void:
	self.get_tree().paused = false;
	self.get_tree().call_deferred("change_scene_to_file",LEVEL_SELECT_SCENE);

func _physics_process(_delta: float) -> void:
	if self.unpause_call:
		self.unpause_call = false;
		self.unpause();

func unpause() -> void:
	EventBus.unpause.emit();
	self.get_tree().paused = false;
