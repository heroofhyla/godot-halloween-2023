extends Node

var songs: Dictionary = {
	bgm1 = preload("res://music/bgm1.ogg")
}
func play(song: String):
	$AudioStreamPlayer.stream = songs[song]
	$AudioStreamPlayer.play(0.0)
