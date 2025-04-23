extends Resource
class_name CheckpointSaveState

static var save_state_path: String = "user://checkpoint_save_state.tres";
static var save_state: CheckpointSaveState = null;

static func get_state() -> CheckpointSaveState:
	if save_state == null:
		load_state();
	return save_state;

static func load_state() -> void:
	var valid_save_exists: bool = ResourceLoader.exists(save_state_path);
	
	var state: CheckpointSaveState;
	if valid_save_exists:
		state = (
			ResourceLoader.load(save_state_path,"CheckpointSaveState") 
			as CheckpointSaveState
		);
		
		if state == null:
			push_warning("CheckpointSaveState: state was invalid, creating new");
			valid_save_exists = false;
	
	if !valid_save_exists:
		state = CheckpointSaveState.new();
	
	if state == null:
		push_error("SOMETHING WENT HORRIBLY WRONG......");
		push_error("(joke) if you see the above message, run.");
		## seriously, I don't think this should be possible.
	save_state = state;
	
@export var checkpoint_flags: Dictionary[StringName, PackedByteArray] = {};
var last_checkpoint: int = 0;

func set_checkpoint(level: StringName, index: int) -> void:
	@warning_ignore("integer_division")
	var byte_index: int = index / 8;
	var shift: int = index % 8;
	self.init_if_needed(level);
	self.expand_if_needed(level,byte_index);
	
	self.checkpoint_flags[level][byte_index] |= 1 << shift;
	
	self.last_checkpoint = index;
	ResourceSaver.save(self,save_state_path);

func get_last_checkpoint() -> int:
	return self.last_checkpoint;

func is_last_checkpoint(checkpoint: Checkpoint) -> bool:
	return checkpoint.index == self.get_last_checkpoint();

func reset_last_checkpoint() -> void:
	self.last_checkpoint = 0;

func get_checkpoint_flag(level: StringName, index: int) -> bool:
	@warning_ignore("integer_division")
	var byte_index: int = index / 8;
	var shift: int = index % 8;
	self.init_if_needed(level);
	self.expand_if_needed(level,byte_index);
	
	return (checkpoint_flags[level][byte_index] & (1 << shift)) != 0;

func expand_if_needed(level: StringName, index_to_access: int) -> void:
	if !(self.checkpoint_flags[level].size() > index_to_access):
		self.checkpoint_flags[level].resize(index_to_access + 1);

func init_if_needed(level: StringName) -> void:
	if !self.checkpoint_flags.has(level):
		self.checkpoint_flags.set(level, PackedByteArray());
