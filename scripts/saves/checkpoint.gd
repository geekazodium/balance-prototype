extends Area2D
class_name Checkpoint

@export var index: int;
@export var level: StringName;
@export var display_sprite: AnimatedSprite2D;

func _ready() -> void:
	if CheckpointSaveState.get_state().is_last_checkpoint(self):
		EventBus.player_teleport_to_checkpoint.emit(self);

func _on_player_entered(_body: PhysicsBody2D) -> void:
	self.display_sprite.modulate = Color.WHITE;
	self.display_sprite.play("default");
	CheckpointSaveState.get_state().set_checkpoint(self.level,self.index);
