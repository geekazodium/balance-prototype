extends Node2D
class_name DistortLayer

@export var viewport: ScreenSizeSubViewport;
@export var distortion_scene: PackedScene;

func _ready() -> void:
	self.scale = self.viewport.downscale_fac * Vector2.ONE;
	EventBus.spawn_distortion.connect(self.spawn_distortion);

func spawn_distortion(center: Vector2, direction: Vector2) -> void:
	var node: Distortion = (self.distortion_scene.instantiate() as Distortion);
	self.add_child(node);
	node.global_position += center * self.viewport.downscale_fac;
	node.set_direction(direction);
