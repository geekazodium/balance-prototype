extends AnimationTree
class_name PlayerAnimationTree

@export var character_body: PlatformerCharacterBody;
@export var projectile_pool: PlayerProjectilePool;
var jumped: bool = false;

func _process(_delta: float) -> void:
	self.set("parameters/grounded_blend_space/blend_position", self.character_body.input_direction.x);
	self.set("parameters/jump_blend_space/blend_position", self.character_body.input_direction.x);
	self.set("parameters/conditions/on_ground", self.character_body.is_on_floor());
	self.set("parameters/conditions/in_air", !self.character_body.is_on_floor());
	self.set("parameters/conditions/jump", self.jumped);
	self.set("parameters/conditions/launch", self.projectile_pool.aim_indicator.visible);
	self.set("parameters/conditions/launch_end", !self.projectile_pool.aim_indicator.visible);
	self.jumped = false;

func on_jumped() -> void:
	self.jumped = true;
