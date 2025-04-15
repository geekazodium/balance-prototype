extends ProgressBar

@export var displayed_timer: Timer;

func _process(delta: float) -> void:
	if self.displayed_timer.is_stopped():
		self.value = 0;
	else:
		self.max_value = self.displayed_timer.wait_time;
		self.value = self.max_value - self.displayed_timer.time_left;
