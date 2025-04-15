extends Node2D
class_name PlayerProjectilePool

@export var launch_action: String = "";
@export var projectile_source: PlatformerCharacterBody;
@export var projectile: Projectile;
@export var fully_charged_multiplier: float;
@export var projectile_offset: Vector2;

@export var hold_timer: Timer;

func _physics_process(_delta: float) -> void:
	if Input.is_action_just_released(self.launch_action) && !hold_timer.is_stopped():
		self.launch_projectile();

	if Input.is_action_just_pressed(self.launch_action):
		self.hold_timer.start();

func launch_projectile() -> void:
	var charge_percentage: float = (1 - self.hold_timer.time_left / self.hold_timer.wait_time);
	self.hold_timer.stop();
	self.projectile.launch(
		projectile_source.get_local_mouse_position(), 
		projectile_source.global_position + self.projectile_offset,
		fully_charged_multiplier * charge_percentage + 1
	);
