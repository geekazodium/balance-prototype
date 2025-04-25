extends Sprite2D

@export var x_offset: float = 28.;

func _process(_delta: float) -> void:
	var mouse_pos: Vector2 = (self.get_parent() as Node2D).get_local_mouse_position();
	var flip: bool = false;
	if mouse_pos.x < 0:
		mouse_pos.x *= -1;
		flip = true;
	
	self.flip_h = flip;
	self.rotation = (-1 if flip else 1) * atan2(mouse_pos.y, mouse_pos.x);
	self.position = Vector2(self.x_offset,0).rotated(self.rotation);
	self.position *= -1 if flip else 1;
