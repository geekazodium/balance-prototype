extends Node

func _ready() -> void:
	var button: GoToNextSceneButton = (self.get_parent() as GoToNextSceneButton);
	if CheckpointSaveState.get_state().next_level == "":
		button.disabled = true;
		return;
	button.level_scene = load(CheckpointSaveState.get_state().next_level);
