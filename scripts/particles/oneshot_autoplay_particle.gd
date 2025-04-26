extends GPUParticles2D
class_name OneshotAutoplayParticles2D

var cached_ver: bool = true;

func _ready() -> void:
	self.emitting = true;

func _on_finished() -> void:
	if self.cached_ver:
		self.emitting = true;
	else:
		self.queue_free();
