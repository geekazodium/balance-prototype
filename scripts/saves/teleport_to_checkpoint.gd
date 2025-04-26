extends Node
class_name TeleportToCheckpoint

@export var object_to_teleport: Node2D;

func _ready() -> void:
	EventBus.player_teleport_to_checkpoint.connect(self.teleport);

func teleport(checkpoint: Checkpoint):
	self.object_to_teleport.global_position = checkpoint.global_position;
	self.object_to_teleport.reset_physics_interpolation();
