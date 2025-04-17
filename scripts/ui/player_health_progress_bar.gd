extends ProgressBar

func _ready() -> void:
	EventBus.player_health_changed.connect(self.on_health_changed);
	EventBus.player_max_health_changed.connect(self.on_max_health_changed);

func on_health_changed(current: float):
	self.value = current;

func on_max_health_changed(current: float):
	self.max_value = current;
