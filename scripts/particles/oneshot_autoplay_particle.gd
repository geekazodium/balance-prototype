extends GPUParticles2D
class_name OneshotAutoplayParticles2D

var cached_ver: bool = true;
@export var sub_emitters: Array[GPUParticles2D] = [];
@export var play_sounds: AudioStreamPlayer2D;

func _ready() -> void:
	self.emitting = true;
	for s in self.sub_emitters:
		s.emitting = true;
	if self.play_sounds != null && !self.cached_ver:
		self.play_sounds.play();

func _on_finished() -> void:
	if self.cached_ver:
		self.emitting = true;
		for s in self.sub_emitters:
			s.emitting = true;
	else:
		self.queue_free();
