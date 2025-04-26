extends AnimatedSprite2D
class_name AutoAnimatedSprite2D

func _process(_delta: float) -> void:
	self.play(self.animation);
