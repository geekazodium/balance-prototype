extends Button

@export var level_scene: PackedScene;

func _on_button_up() -> void:
	self.get_tree().change_scene_to_packed(self.level_scene);
