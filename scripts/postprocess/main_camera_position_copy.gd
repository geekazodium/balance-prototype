extends Camera2D
class_name PostProcessLayerCamera

@export var viewport: ScreenSizeSubViewport;

func _process(_delta: float) -> void:
	self.global_position = self.get_window().get_camera_2d().global_position * self.viewport.downscale_fac;
	self.zoom = Vector2.ONE * self.get_window().get_screen_transform().get_scale();
