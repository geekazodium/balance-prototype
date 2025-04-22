extends Line2D
class_name PlayerAimIndicator

const SIMULATION_ITERS: int = 80;

func update_predicted_points(
	projectile: PlayerProjectile, 
	direction: Vector2, 
	player: PlatformerCharacterBody, 
	player_vel_percent: float,
	offset: Vector2,
	speed_multiplier: float
	) -> void:
	
	self.points = [];
	
	var vel: Vector2 = direction.normalized() * projectile.launch_speed * speed_multiplier;
	vel += player.velocity * player_vel_percent;
	var pos: Vector2 = player.global_position + offset;
	
	var fixed_delta: float = self.get_physics_process_delta_time() * 3;
	
	for i in range(SIMULATION_ITERS):
		self.add_point(pos);
		pos += vel * fixed_delta;
		vel += Vector2.DOWN * projectile.gravity * fixed_delta;
