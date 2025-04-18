extends Node
class_name HealthPotions

@export var max_potions: int = 2;
@export var health_regain_amount: float = 0;
var current_potions: int = 0;
@export var entity: Node = null;
@export var heal_use_timer: Timer = null;

@export var use_health_potion_input: String = "";

func on_enter_checkpoint(checkpoint: Area2D):
	self.change_potion_count(self.max_potions - self.current_potions);

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed(self.use_health_potion_input):
		if self.current_potions > 0:
			self.heal_use_timer.start();
	
	if Input.is_action_just_released(self.use_health_potion_input):
		self.heal_use_timer.stop();

func heal_timer_done() -> void:
	self.change_potion_count(-1);
	HealthTracker.get_health_tracker(self.entity).change_health(health_regain_amount);

func change_potion_count(amount: int):
	self.current_potions += amount;
	EventBus.player_potion_count_changed.emit(self.current_potions);
