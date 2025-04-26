extends AudioStreamPlayer2D
class_name RandomizePitch

@export var min_pitch: float = .8;
@export var max_pitch: float = 1.1;

func _ready() -> void:
	self.pitch_scale = randf_range(self.min_pitch, self.max_pitch);
