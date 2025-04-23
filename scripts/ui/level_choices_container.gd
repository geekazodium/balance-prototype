extends Control

@export var default_button: Button;

func _ready() -> void:
	default_button.grab_focus();
