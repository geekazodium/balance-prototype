extends Line2D
class_name ProjectileTrail

var launched: bool = false;
var last_position: Vector2 = Vector2.ZERO;
@export var trail_points: int = 20;

func on_launch() -> void:
	self.points = [];
	self.launched = true;
	self.last_position = self.global_position;

func _physics_process(_delta: float) -> void:
	if self.launched:
		var moved_vec: Vector2 = self.to_local(self.last_position);
		self.last_position = self.global_position;
		for i in range(self.points.size()):
			self.points[i] += moved_vec;
		self.add_point(Vector2.ZERO);
		if self.points.size() > self.trail_points:
			self.remove_point(0);
