extends Node
class_name BoostOnHit

@export var character_body: PlatformerCharacterBody;
@export var hit_deceleration_percent: float = .5;

func _ready() -> void:
	EventBus.player_projectile_hit.connect(self.on_projectile_hit);

func on_projectile_hit(projectile_velocity: Vector2, damage: int):
	character_body.add_instant_acceleration(
		- projectile_velocity
		- character_body.velocity * hit_deceleration_percent
	);
	var position: Vector2 = self.character_body.global_position;
	EventBus.spawn_distortion.emit(position, projectile_velocity.normalized());
	EventBus.spawn_particles.emit(
		"player_hit_with_recoil",
		position,
		atan2(-projectile_velocity.y,-projectile_velocity.x),
		null
	);
	HealthTracker.get_health_tracker(character_body).change_health(-damage);
