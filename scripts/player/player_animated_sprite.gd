extends AutoAnimatedSprite2D
class_name PlayerAnimatedSprite

@export var character_body: PlatformerCharacterBody;
@onready var initial_scale: Vector2 = self.scale;
@export var y_vel_sensitivity: float;

func _process(delta: float) -> void:
	super._process(delta);
	var y_vel: float = self.character_body.velocity.y;
	var m: float = clamp(exp(y_vel * self.y_vel_sensitivity * .01),.5,2);
	self.scale = self.initial_scale * Vector2(1./m,m);
