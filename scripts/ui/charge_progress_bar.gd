extends TextureProgressBar

func _ready():
	EventBus.player_projectile_charge.connect(self.on_projectile_charging);
	EventBus.player_projectile_launch.connect(self.on_projectile_shoot)

func on_projectile_charging(max_charge: float, current: float) -> void:
	self.visible = true;
	self.max_value = max_charge;
	self.value = current;

func on_projectile_shoot() -> void:
	self.visible = false;
	self.value = 0;
