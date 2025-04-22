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
@export var attack_distance_tolerance: float = 0;

func process(_delta: float) -> void:
	pass;

# Called every physics tick. 'delta' is the elapsed time since the previous frame.
func physics_process(_delta: float) -> void:
	if !self.target_tracker.has_target():
		StateMachine.switch_state(self, self.target_lost_state);
		return;
	
	var target: Node2D = target_tracker.get_target();
	if !self.has_line_of_sight(target):
		StateMachine.switch_state(self, self.target_lost_state);
		return;
	
	if self.attack_distance_tolerance < self.character_body.to_local(target.global_position).length():
		StateMachine.switch_state(self, self.use_attack_state);
	
	var distance: Vector2 = self.character_body.to_local(target.global_position);
	self.character_body.set_input_direction(Vector2(sign(distance.x),0));

func has_line_of_sight(target: Node2D) -> bool:
	self.line_of_sight.target_position = self.line_of_sight.to_local(target.global_position);
	self.line_of_sight.force_raycast_update();
	return self.line_of_sight.get_collider() == target;
