extends ColorRect
class_name Distortion

@onready var vec_scale: float = self.max_vec;
var direction: Vector2;
var max_vec: float = .6;

func _process(delta: float) -> void:
	self.set_distort_vec(self.vec_scale/self.max_vec * self.direction);
	if self.vec_scale > 0.:
		self.vec_scale -= delta;
	else:
		self.queue_free();

func set_direction(vec: Vector2) -> void:
	self.direction = vec;

func set_distort_vec(vec: Vector2) -> void:
	self.material.set("shader_parameter/distort", vec);
