extends Area2D
class_name LevelExit

const LEVEL_CLEARED_SCENE: String = "res://scenes/ui/level_cleared.tscn";
@export var next_scene: String;

func _on_player_entered(_body: PhysicsBody2D) -> void:
	self.get_tree().call_deferred("change_scene_to_file",LEVEL_CLEARED_SCENE);
	CheckpointSaveState.get_state().reset_last_checkpoint();
	CheckpointSaveState.get_state().next_level = next_scene;
