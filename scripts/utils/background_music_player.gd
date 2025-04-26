extends AudioStreamPlayer2D

func _ready() -> void:
	self.finished.connect(self.on_finish);

func play_stream_loop(new_stream: AudioStream, restart: bool = true) -> void:
	if !restart:
		if self.stream == new_stream:
			return;
	self.stop();
	self.stream = new_stream;
	var camera: Camera2D = self.get_window().get_camera_2d();
	if camera == null:
		self.global_position = Vector2.ZERO;
	else:
		self.global_position = camera.get_screen_center_position();
	self.bus = "Music";
	self.play();

func on_finish() -> void:
	self.play();
