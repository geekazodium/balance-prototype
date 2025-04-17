extends ProgressBar

func _ready():
	EventBus.player_projectile_charge.connect(self.on_projectile_charging);
	EventBus.player_projectile_launch.connect(self.on_projectile_shoot)

func on_projectile_charging(max: float, current: float) -> void:
	self.max_value = max;
	self.value = current;

func on_projectile_shoot() -> void:
	self.value = 0;
