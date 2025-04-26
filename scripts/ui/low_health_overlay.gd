extends ColorRect
class_name LowHealthOverlay

func _ready() -> void:
	EventBus.player_health_changed.connect(self.on_health_change);

func on_health_change(current: int) -> void:
	self.visible = (current == 1);
