extends Node
class_name CollisionDetectionHelper

static func get_hit_nearest_body(_self: Area2D) -> PhysicsBody2D:
	var nearest: PhysicsBody2D = null;
	var nearest_distance: float = 0.;
	for body in _self.get_overlapping_bodies():
		#optimization since exact distance is not required, just comparison.
		#(vector length requires sqrt operation, length_squared does not.)
		var distance = (body.global_position - _self.global_position).length_squared();
		if nearest == null || nearest_distance > distance:
			nearest = body;
			nearest_distance = distance;
	return nearest;

static func get_hit_nearest_area(_self: Area2D) -> Area2D:
	var nearest: Area2D = null;
	var nearest_distance: float = 0.;
	for body in _self.get_overlapping_areas():
		#optimization since exact distance is not required, just comparison.
		#(vector length requires sqrt operation, length_squared does not.)
		var distance = (body.global_position - _self.global_position).length_squared();
		if nearest == null || nearest_distance > distance:
			nearest = body;
			nearest_distance = distance;
	return nearest;
