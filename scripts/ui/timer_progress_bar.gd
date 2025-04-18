extends ProgressBar

@export var timer_to_display: Timer = null;

func _process(_delta: float) -> void:
	self.visible = !timer_to_display.is_stopped();
	self.max_value = timer_to_display.wait_time;
	self.value = timer_to_display.time_left;
