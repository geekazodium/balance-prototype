extends Area2D
class_name Checkpoint

@export var index: int;
@export var level: StringName;

func _ready() -> void:
	if CheckpointSaveState.get_state().get_last_enabled_checkpoint(self.level) == self.index:
		EventBus.player_teleport_to_checkpoint.emit(self);

func _on_player_entered(_body: PhysicsBody2D) -> void:
	CheckpointSaveState.get_state().enable_checkpoint_flag(self.level,self.index);
