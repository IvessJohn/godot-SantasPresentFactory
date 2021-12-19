extends Node
class_name SFXPlayerClass
 
 
func play_sfx(sound: AudioStream, parent: Node = get_tree().current_scene,
		volume_db: float = 1.0, pitch_range: Vector2 = Vector2(0.9,1.1),
		pause_behavior = PAUSE_MODE_INHERIT):
	if sound != null and parent != null:
		var stream_player = AudioStreamPlayer.new()
		
		stream_player.stream = sound
		stream_player.connect("finished", stream_player, "queue_free")
		stream_player.pitch_scale = rand_range(pitch_range.x, pitch_range.y)
		stream_player.volume_db = volume_db
		stream_player.pause_mode = pause_behavior
#		stream_player.bus = AudioServer.get_bus
		
		parent.add_child(stream_player)
		stream_player.play()
