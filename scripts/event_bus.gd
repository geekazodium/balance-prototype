extends Node

@warning_ignore("unused_signal")
signal player_projectile_hit(projectile_velocity: Vector2, projectile_damage: int);

@warning_ignore("unused_signal")
signal player_projectile_charge(max: float, current: float);

@warning_ignore("unused_signal")
signal player_projectile_launch();

@warning_ignore("unused_signal")
signal player_health_changed(current: int);

@warning_ignore("unused_signal")
signal player_max_health_changed(current: int);

@warning_ignore("unused_signal")
signal player_death();

@warning_ignore("unused_signal")
signal player_potion_count_changed(current: int);

@warning_ignore("unused_signal")
signal player_teleport_to_checkpoint(checkpoint: Checkpoint);

@warning_ignore("unused_signal")
signal unpause();

@warning_ignore("unused_signal")
signal camera_target_added(target: Node2D);

@warning_ignore("unused_signal")
signal camera_target_removed(target: Node2D);

@warning_ignore("unused_signal")
signal spawn_distortion(position: Vector2, direction: Vector2);
