extends Camera2D
class_name FollowCamera

@export var follow_targets: Array[Node2D] = [];

@export var boundary_center: Node2D = null;
@export var boundary_radius: float = 0;

func _ready() -> void:
	EventBus.camera_target_added.connect(self.add_target);
	EventBus.camera_target_removed.connect(self.remove_target);

func _process(_delta: float) -> void:
	var sum: Vector2 = Vector2.ZERO;
	var element_weight: float = 1./self.follow_targets.size();
	for target in self.follow_targets:
		sum += element_weight * target.global_position;
	
	var offset_vec = self.boundary_center.to_local(sum);
	
	if !offset_vec.is_zero_approx():
		var magnitude: float = offset_vec.length();
		magnitude = self.boundary_radius - log(1+exp(self.boundary_radius - magnitude));
		offset_vec = offset_vec.normalized() * magnitude;
	
	self.global_position = self.boundary_center.to_global(offset_vec);

func add_target(target: Node2D):
	if self.follow_targets.has(target):
		return;
	self.follow_targets.push_back(target);

func remove_target(target: Node2D):
	#O(n) is fine because technically if n is always less than 10 this is actually O(1)
	self.follow_targets.remove_at(self.follow_targets.find(target));
