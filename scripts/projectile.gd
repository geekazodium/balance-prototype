extends ShapeCast2D
class_name Projectile

@export var velocity: Vector2;
@export var sprite: Sprite2D;
@export var launch_speed: float;

@export var collide_event: String;
@export var gravity: float = 30;

func _ready() -> void:
	self.enabled = false;
	self.visible = false;

func _physics_process(delta: float) -> void:
	if self.is_colliding():
		self.on_hit();
	self.position += delta * self.velocity;
	self.velocity += Vector2.DOWN * gravity * delta;
	self.sprite.rotation = atan2(self.velocity.y, self.velocity.x);
	
	self.target_position = delta * self.velocity;

func launch(direction: Vector2, launch_position: Vector2, speed_multiplier: float) -> void:
	self.visible = true;
	self.enabled = true;
	self.global_position = launch_position;
	self.velocity = direction.normalized() * self.launch_speed * speed_multiplier;

func on_hit() -> void:
	EventBus.emit_signal(self.collide_event, self.velocity);
	self.enabled = false;
	self.visible = false;
