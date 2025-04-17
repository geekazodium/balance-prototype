extends Node
class_name HealthTracker

@export var health: float = 10;
@export var max_health: float = 10;
@export var increase_per_second: float = 0;
var dead: bool = false;

@export_category("event bus signals")
@export var death_event: String = "";
@export var health_changed_event: String = "";
@export var max_health_changed_event: String = "";

signal health_changed(current:float);
signal max_health_changed(current: float);
signal death();

func _ready() -> void:
	self.on_max_health_change();
	self.on_health_change();

func _physics_process(delta: float) -> void:
	self.change_health(self.increase_per_second * delta);

## use this function to change the health of the entity.
func change_health(amount: float):
	self.health += amount;
	if self.health > self.max_health:
		self.health = self.max_health;
	
	self.on_health_change();
	
	if self.health <= 0.:
		self.on_death();

## this function is called when the entity's health changes and drops to zero or less.
## checks if self is already dead to avoid repeated death signals
func on_death():
	if self.dead:
		return;
	self.dead = true;
	self.death.emit();
	
	if self.death_event.length() != 0:
		EventBus.emit_signal(death_event);

func on_health_change():
	self.health_changed.emit(self.health);
	if self.health_changed_event != "":
		EventBus.emit_signal(self.health_changed_event, self.health);

func on_max_health_change():
	self.max_health_changed.emit(self.max_health);
	if self.max_health_changed_event != "":
		EventBus.emit_signal(self.max_health_changed_event, self.max_health);

func add_max_health(amount: float):
	self.health += amount;
	self.max_health += amount;
	self.on_max_health_change();
	self.on_health_change();

static var default_path: String = "HealthTracker";

static func get_health_tracker(entity: Node, path: String = default_path) -> HealthTracker:
	return entity.get_node(path);
