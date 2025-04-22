extends ProgressBar

@export var number_label: Label;

func _ready() -> void:
	EventBus.player_health_changed.connect(self.on_health_changed);
	EventBus.player_max_health_changed.connect(self.on_max_health_changed);

func on_health_changed(current: int):
	self.value = current;
	self.number_label.text = String.num_int64(current);

func on_max_health_changed(current: int):
	self.max_value = current;
