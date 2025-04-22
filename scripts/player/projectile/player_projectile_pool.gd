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

@export var aim_indicator: PlayerAimIndicator;

@export var aim_stick_deadzone: float = 0.1;

func _physics_process(delta: float) -> void:
	if Input.is_action_pressed(self.launch_action) || Input.is_action_just_released(self.launch_action):
		if self.hold_timer > 0:
			self.hold_timer -= delta;
			EventBus.player_projectile_charge.emit(self.max_hold_timer,self.max_hold_timer - self.hold_timer);
		
		# This method call was sponsored my ikea (THIS IS A JOKE, DO NOT SUE ME)
		self.aim_indicator.update_predicted_points(
			self.projectile,
			self.get_aim_direction(),
			self.projectile_source, 
			self.player_momentum_percentage,
			self.projectile_offset,
			fully_charged_multiplier * self.get_charge_percentage() + 1
		);
		self.aim_indicator.visible = true;
	else:
		self.aim_indicator.visible = false;
	if Input.is_action_just_released(self.launch_action):
		self.launch_projectile();

	if Input.is_action_just_pressed(self.launch_action):
		self.hold_timer = self.max_hold_timer;

func launch_projectile() -> void:
	self.projectile.launch(
		self.get_aim_direction(), 
		projectile_source.global_position + self.projectile_offset,
		fully_charged_multiplier * self.get_charge_percentage() + 1
	);
	
	self.hold_timer = self.max_hold_timer;
	
	self.projectile.velocity += self.projectile_source.velocity * self.player_momentum_percentage;
	EventBus.player_projectile_launch.emit();

func get_aim_direction() -> Vector2:
	var aim_direction: Vector2 = projectile_source.get_local_mouse_position();
	for joypad: int in Input.get_connected_joypads():
		var direction: Vector2 = Vector2(
			Input.get_joy_axis(joypad, JOY_AXIS_RIGHT_X), 
			Input.get_joy_axis(joypad, JOY_AXIS_RIGHT_Y)
		);
		if direction.length() < self.aim_stick_deadzone:
			continue;
		aim_direction = direction;
	return aim_direction.normalized();

func get_charge_percentage() -> float:
	return 1 - self.hold_timer / self.max_hold_timer;
