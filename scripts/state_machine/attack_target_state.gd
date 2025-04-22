extends Node2D
class_name AttackTargetState

## Class is a state to be added to a parent state machine as a possible state,
## Node must have parent of state machine.
## This state moves towards the target's position
##
## Use in enemies that need to be able to follow a target. must have a
## navigation agent 2d in that entity and set the `nav_agent` var to that.

@export var target_tracker: TargetTracker = null;
@export var character_body: PlatformerCharacterBody = null;
@export var attack_animation_player: AnimationPlayer;
@export var attack_animation: String = "";
@export var attack_over_state: String = "";
@export var attack_canceled_state: String = "";
@export var attack: Node2D;
var attack_position: Vector2 = Vector2.ZERO;

func process(_delta: float) -> void:
	pass;

# Called every physics tick. 'delta' is the elapsed time since the previous frame.
func physics_process(_delta: float) -> void:
	if (!self.target_tracker.has_target()) && (self.attack_position != Vector2.ZERO):
		StateMachine.switch_state(self, self.attack_canceled_state);
		return;
	if self.attack_position == Vector2.ZERO:
		self.attack_position = self.get_target_direction();
		self.attack.rotation = atan2(attack_position.y,attack_position.x);
		self.attack_animation_player.play(self.attack_animation);

func get_target_direction() -> Vector2:
	var target = self.target_tracker.get_target();
	var dir = self.character_body.to_local(target.global_position).normalized();
	if dir.is_zero_approx():
		return Vector2.UP;
	return dir;

func _attack_ended() -> void:
	StateMachine.switch_state(self, self.attack_over_state);
	self.attack_position = Vector2.ZERO;
