extends Resource
class_name CheckpointSaveState

static var save_state_path: String = "user://checkpoint_save_state.tres";
static var save_state: CheckpointSaveState = null;

static func get_state() -> CheckpointSaveState:
	if save_state == null:
		push_warning("CheckpointSaveState: state was not preloaded, may not be good for performance");
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
@export var last_checkpoint_enabled: Dictionary[StringName, int] = {};

func enable_checkpoint_flag(level: StringName, index: int) -> void:
	var byte_index: int = index / 8;
	var shift: int = index % 8;
	self.init_if_needed(level);
	self.expand_if_needed(level,byte_index);
	
	self.checkpoint_flags[level][byte_index] |= 1 << shift;
	
	self.last_checkpoint_enabled[level] = index;
	ResourceSaver.save(self,save_state_path);

func get_checkpoint_flag(level: StringName, index: int) -> bool:
	var byte_index: int = index / 8;
	var shift: int = index % 8;
	self.init_if_needed(level);
	self.expand_if_needed(level,byte_index);
	
	return (checkpoint_flags[level][byte_index] & (1 << shift)) != 0;

func get_last_enabled_checkpoint(level: StringName) -> int:
	self.init_if_needed(level);
	return self.last_checkpoint_enabled[level];

func expand_if_needed(level: StringName, index_to_access: int) -> void:
	if !(self.checkpoint_flags[level].size() > index_to_access):
		self.checkpoint_flags[level].resize(index_to_access + 1);

func init_if_needed(level: StringName) -> void:
	if !self.checkpoint_flags.has(level):
		self.checkpoint_flags.set(level, PackedByteArray());
		self.last_checkpoint_enabled.set(level,0);
