extends VBoxContainer

func _ready() -> void:
	(self.get_child(0) as Button).grab_focus();
