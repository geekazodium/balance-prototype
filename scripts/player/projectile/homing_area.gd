extends Area2D

@export var projectile: PlayerProjectile;
@export var homing_force: float;

func _physics_process(_delta: float) -> void:
	var nearest: PhysicsBody2D = CollisionDetectionHelper.get_hit_nearest_body(self);
	if nearest == null:
		return;
	
	var relative_pos: Vector2 = self.to_local(nearest.global_position);
	var projectile_dir: Vector2 = self.projectile.velocity.normalized();
	var direction: Vector2 = relative_pos.normalized();
	
	if direction.dot(projectile_dir) < .9:
		return;
	var angle: float = projectile_dir.angle_to(direction);
	
	self.projectile.accelerate(homing_force*(self.projectile.velocity.rotated(angle) - self.projectile.velocity));
	self.projectile.accelerate(Vector2.UP * self.projectile.gravity);
