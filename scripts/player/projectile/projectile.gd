extends ShapeCast2D
class_name PlayerProjectile

@export var velocity: Vector2;
@export var sprite: Sprite2D;
@export var launch_speed: float;

@export var gravity: float = 30;

@export var damage: float = 2;
@export var damage_per_speed: float = 0.001;
@export var lifetime: float = 5;

var lifetime_current: float = 0;

var acceleration: Vector2 = Vector2.ZERO;

const KNOCKBACK_IMMUNE_LAYER: int = 5;

signal launched();

func _ready() -> void:
	self.enabled = false;
	self.visible = false;

func _physics_process(delta: float) -> void:
	if self.enabled == false:
		return;
	if self.is_colliding():
		var collider: PlatformerCharacterBody = self.get_collider(0) as PlatformerCharacterBody;
		if self.colliding_knockback_immune():
			var norm: Vector2 = self.get_collision_normal(0);
			var reflected = self.velocity - (2 * self.velocity.dot(norm) * norm);
			self.velocity = reflected;
			self.position = self.get_collision_point(0) + norm * .5;
		else:
			self.on_hit(false, collider);
			self.disable_projectile();
			return;
	else:
		self.position += delta * self.velocity;
		self.velocity += (Vector2.DOWN * gravity + self.acceleration) * delta;
		self.acceleration = Vector2.ZERO;
	self.sprite.rotation = atan2(self.velocity.y, self.velocity.x);
	
	self.target_position = delta * self.velocity;
	if self.lifetime_current > 0.:
		self.lifetime_current -= delta;
	else:
		if self.enabled:
			self.disable_projectile();

func visuals_initialize() -> void:
	self.visible = true;
	EventBus.camera_target_added.emit(self);

func launch(direction: Vector2, launch_position: Vector2, speed_multiplier: float) -> void:
	self.enabled = true;
	self.acceleration = Vector2.ZERO;
	self.global_position = launch_position;
	self.velocity = direction.normalized() * self.launch_speed * speed_multiplier;
	self.target_position = Vector2.ZERO;
	self.launched.emit();
	self.lifetime_current = self.lifetime;
	self.visuals_initialize();
	self.reset_physics_interpolation();

func on_hit(knockback_immune: bool, collider: PlatformerCharacterBody) -> void:
	var hit_damage: int = (self.damage + self.damage_per_speed * self.velocity.length()) as int;
	EventBus.player_projectile_hit.emit(self.velocity * (0 if knockback_immune else 1), hit_damage);
	if collider != null:
		collider.add_instant_acceleration(self.velocity);
		var hit_health_tracker: HealthTracker = HealthTracker.get_health_tracker(collider);
		if hit_health_tracker != null:
			hit_health_tracker.change_health(-hit_damage);
			(collider.get_node("./LockAccelerationTimer") as Timer).start();

func accelerate(force: Vector2):
	self.acceleration += force;

func disable_projectile() -> void:
	EventBus.camera_target_removed.emit(self);
	self.enabled = false;
	self.visible = false;

func colliding_knockback_immune() -> bool:
	var collision_point: Vector2 = self.to_local(self.get_collision_point(0));
	var saved_mask: int = self.collision_mask;
	self.target_position = collision_point;
	self.collision_mask = 1 << KNOCKBACK_IMMUNE_LAYER;
	
	self.force_shapecast_update();
	var colliding: bool = self.is_colliding();
	
	self.collision_mask = saved_mask;
	return colliding;
