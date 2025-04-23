extends Button

@export var level_scene: PackedScene;

func _on_button_up() -> void:
	CheckpointSaveState.get_state().reset_last_checkpoint();
	self.get_tree().change_scene_to_packed(self.level_scene);
