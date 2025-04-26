extends Node2D

var particle_types: Dictionary[StringName, PackedScene] = {
	&"lazer_hit": preload("res://scenes/particles/lazer_hit.tscn"),
	&"player_hit_with_recoil": preload("res://scenes/particles/player_hit_by_recoil.tscn"),
	&"player_projectile_hit": preload("res://scenes/particles/player_projectile_hit.tscn")
};
var particle_cached: Dictionary[StringName, OneshotAutoplayParticles2D];
var cache_node: Node2D;

func _ready() -> void:
	self.add_child(
		(load("res://scenes/particles/world_particles.tscn") as PackedScene)
		.instantiate()
	);
	self.cache_node = self.get_node("./CanvasLayer/CacheNode");
	
	EventBus.spawn_particles.connect(self.on_spawn_particles);
	for key: StringName in self.particle_types.keys():
		var particle: PackedScene = self.particle_types[key];
		var inst: OneshotAutoplayParticles2D = particle.instantiate();
		self.particle_cached.set(key, inst);
		self.cache_node.add_child(inst);

func on_spawn_particles(_name: StringName, pos: Vector2, rot: float, attach_to: Node2D) -> void:
	var instance: OneshotAutoplayParticles2D = self.particle_cached[_name].duplicate();
	instance.cached_ver = false;
	instance.z_index += 1;
	if attach_to == null:
		self.add_child(instance);
	else: 
		attach_to.add_child(instance);
	instance.rotation = rot;
	instance.global_position = pos;
