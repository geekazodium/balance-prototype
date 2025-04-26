extends Node2D
class_name WorldParticles

@export var particle_types: Dictionary[StringName, PackedScene];
@export var cache_node: Node2D;

func _ready() -> void:
	EventBus.spawn_particles.connect(self.on_spawn_particles);
	for particle: PackedScene in self.particle_types.values():
		var inst = particle.instantiate();
		self.cache_node.add_child(inst);

func on_spawn_particles(_name: StringName, pos: Vector2) -> void:
	var instance: Node2D = self.particle_types[_name].instantiate();
	self.add_child(instance);
	instance.global_position = pos;
