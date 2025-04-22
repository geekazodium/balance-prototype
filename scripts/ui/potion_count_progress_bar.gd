extends ProgressBar

func _ready() -> void:
	EventBus.player_potion_count_changed.connect(self.on_count_changed);

func on_count_changed(current: float):
	self.value = current;
