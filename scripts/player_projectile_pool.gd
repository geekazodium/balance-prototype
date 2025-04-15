extends Node2D
class_name PlayerProjectilePool

@export var launch_action: String = "";
@export var projectile_source: PlatformerCharacterBody;
@export var projectile: Projectile;

func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed(self.launch_action):
		self.projectile.launch(
			projectile_source.get_local_mouse_position(), 
			projectile_source.global_position
		);
