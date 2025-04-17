extends ProgressBar

@export var projectile_pool: PlayerProjectilePool;

func _process(delta: float) -> void:
	self.max_value = self.projectile_pool.max_hold_timer;
	self.value = self.max_value - self.projectile_pool.hold_timer;
