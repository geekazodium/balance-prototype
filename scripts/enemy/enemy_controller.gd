extends Node
class_name EnemyController

@export var character_body: PlatformerCharacterBody;
var target: Node2D = null;
@export var detection_area: Area2D = null;

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	if self.target != null:
		self.has_target_process(delta);
	else:
		self.character_body.set_input_direction(Vector2.ZERO);
		if self.detection_area.has_overlapping_bodies():
			self.target = self.detection_area.get_overlapping_bodies()[0];

func has_target_process(delta: float) -> void:
	var distance: Vector2 = self.character_body.to_local(target.global_position);
	
	self.character_body.set_input_direction(Vector2(sign(distance.x),0));
