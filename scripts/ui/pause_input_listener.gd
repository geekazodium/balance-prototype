extends Node

@export var pause_action: String = "pause";

signal pause_game();

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed(self.pause_action):
		if self.get_tree().paused == false:
			self.get_tree().paused = true;
			self.pause_game.emit();
