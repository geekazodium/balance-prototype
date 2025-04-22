extends Node2D
class_name PlayerProjectilePool

@export var launch_action: String = "";
@export var projectile_source: PlatformerCharacterBody;
@export var projectile: PlayerProjectile;
@export var fully_charged_multiplier: float;
@export var projectile_offset: Vector2;
@export var player_momentum_percentage: float;

@onready var hold_timer: float = self.max_hold_timer;
@export var max_hold_timer: float = 0;

@export var aim_stick_deadzone: float = 0.1;

func _physics_process(delta: float) -> void:
	if Input.is_action_pressed(self.launch_action) || Input.is_action_just_released(self.launch_action):
		if self.hold_timer > 0:
			self.hold_timer -= delta;
			EventBus.player_projectile_charge.emit(self.max_hold_timer,self.max_hold_timer - self.hold_timer);
	if Input.is_action_just_released(self.launch_action):
		self.launch_projectile();

	if Input.is_action_just_pressed(self.launch_action):
		self.hold_timer = self.max_hold_timer;

func launch_projectile() -> void:
	var charge_percentage: float = (1 - self.hold_timer / self.max_hold_timer);
	self.hold_timer = self.max_hold_timer;
	
	var aim_direction: Vector2 = projectile_source.get_local_mouse_position();
	for joypad: int in Input.get_connected_joypads():
		var direction: Vector2 = Vector2(
			Input.get_joy_axis(joypad, JOY_AXIS_RIGHT_X), 
			Input.get_joy_axis(joypad, JOY_AXIS_RIGHT_Y)
		);
		if direction.length() < self.aim_stick_deadzone:
			continue;
		aim_direction = direction;
	
	self.projectile.launch(
		aim_direction, 
		projectile_source.global_position + self.projectile_offset,
		fully_charged_multiplier * charge_percentage + 1
	);
	self.projectile.velocity += self.projectile_source.velocity * self.player_momentum_percentage;
	EventBus.player_projectile_launch.emit();
