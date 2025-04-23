extends Area2D
class_name LevelExit

const LEVEL_COMPLETE_SCENE: String = "res://scenes/level_select.tscn";

func _on_player_entered(_body: PhysicsBody2D) -> void:
	self.get_tree().call_deferred("change_scene_to_file",LEVEL_COMPLETE_SCENE);
