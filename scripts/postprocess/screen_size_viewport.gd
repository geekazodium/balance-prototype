extends SubViewport
class_name ScreenSizeSubViewport

@export var downscale_fac: float = .25;

func _ready() -> void:
	self.get_window().size_changed.connect(self.on_update_size);
	self.on_update_size();

func on_update_size():
	self.call_deferred("update_size");

func update_size():
	self.size = self.get_window().size * self.downscale_fac;
