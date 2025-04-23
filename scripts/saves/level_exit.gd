extends Area2D
class_name LevelExit

func _on_player_entered(_body: PhysicsBody2D) -> void:
	self.get_tree().call_deferred("change_scene_to_file",PauseMenu.LEVEL_SELECT_SCENE);
