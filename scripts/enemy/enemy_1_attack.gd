extends RayCast2D

@export var attack_sprite: Sprite2D;
@export var damage: int = 0;
@export var knockback: int = 200;

func attack() -> void:
	self.force_raycast_update();
	
	var collision_local: Vector2 = self.get_collision_point() - self.global_position;
	
	var distance: float = collision_local.length() + 3;
	
	self.attack_sprite.scale.x = distance / self.attack_sprite.texture.get_width();
	self.attack_sprite.position.x = distance * .5;
	
	var hit: PlatformerCharacterBody = self.get_collider() as PlatformerCharacterBody;
	if hit == null:
		return;
	var health_tracker: HealthTracker = HealthTracker.get_health_tracker(hit);
	if health_tracker == null:
		return;
	
	health_tracker.change_health(-damage);
	hit.add_instant_acceleration((collision_local.normalized() + Vector2.UP) * self.knockback);
	(hit.get_node("./LockAccelerationTimer") as Timer).start();
