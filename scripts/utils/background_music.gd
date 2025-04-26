extends Node
class_name BackgroundMusic

@export var audio_stream: AudioStream;
@export var restart: bool = false;

func _ready() -> void:
	BackgroundMusicPlayer.play_stream_loop(self.audio_stream, self.restart);
