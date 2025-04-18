extends Node
class_name BoostOnHit

@export var character_body: PlatformerCharacterBody;
@export var hit_deceleration_percent: float = .5;

func _ready() -> void:
	EventBus.player_projectile_hit.connect(self.on_projectile_hit);

func on_projectile_hit(projectile_velocity: Vector2, damage: float):
	character_body.add_instant_acceleration(
		- projectile_velocity
		- character_body.velocity * hit_deceleration_percent
	);
	HealthTracker.get_health_tracker(character_body).change_health(-(damage as int));
