extends Node
class_name EnemyDeath

func _on_death() -> void:
	self.get_parent().queue_free();
