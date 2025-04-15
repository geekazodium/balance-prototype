extends Camera2D
class_name FollowCamera

@export var follow_target: Node2D = null;

func _process(_delta: float) -> void:
	self.global_position = self.follow_target.global_position;
