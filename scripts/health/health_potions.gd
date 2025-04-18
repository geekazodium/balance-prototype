extends Node
class_name HealthPotions

@export var max_potions: int = 2;
var current_potions: int = 0;

func on_enter_checkpoint():
	self.current_potions = self.max_potions;
