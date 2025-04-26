extends Node2D
class_name FollowTargetState

## Class is a state to be added to a parent state machine as a possible state,
## Node must have parent of state machine.
## This state moves towards the target's position
##
## Use in enemies that need to be able to follow a target. must have a
## navigation agent 2d in that entity and set the `nav_agent` var to that.

@export var target_tracker: TargetTracker = null;
@export var character_body: PlatformerCharacterBody = null;
@export var target_lost_state: String = "";
@export var use_attack_state: String = "";
@export var line_of_sight: RayCast2D;
@export var line_of_sight_timeout: float = 1.;
var line_of_sight_timer: float = 0;
@export var attack_distance_tolerance: float = 0;
@export var animation_player: AnimationPlayer;
@export var animation_name: StringName = "";
@export var sprite: AnimatedSprite2D;

# Called every physics tick. 'delta' is the elapsed time since the previous frame.
func physics_process(delta: float) -> void:
	if !self.target_tracker.has_target():
		StateMachine.switch_state(self, self.target_lost_state);
		return;
	
	var target: Node2D = target_tracker.get_target();
	
	if !self.has_line_of_sight(target):
		self.line_of_sight_timer -= delta;
		if self.line_of_sight_timer < 0.:
			StateMachine.switch_state(self, self.target_lost_state);
			self.character_body.set_input_direction(Vector2(0,0));
			return;
	else:
		self.line_of_sight_timer = self.line_of_sight_timeout;
	
		if self.attack_distance_tolerance < self.character_body.to_local(target.global_position).length():
			StateMachine.switch_state(self, self.use_attack_state);
	
	var distance: Vector2 = self.character_body.to_local(target.global_position);
	self.character_body.set_input_direction(Vector2(sign(distance.x),0));
	self.sprite.flip_h = distance.x < 0.;
	if !self.animation_player.is_playing():
		self.animation_player.play(self.animation_name);

func has_line_of_sight(target: Node2D) -> bool:
	self.line_of_sight.target_position = self.line_of_sight.to_local(target.global_position);
	self.line_of_sight.force_raycast_update();
	return self.line_of_sight.get_collider() == target;
