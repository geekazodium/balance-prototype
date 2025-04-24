extends Node

func _ready() -> void:
	var button: GoToNextSceneButton = (self.get_parent() as GoToNextSceneButton);
	button.level_scene = load(CheckpointSaveState.get_state().next_level);
