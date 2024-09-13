extends Node2D

var seek_time = 10; # Cuánto adelantar o retroceder (en segundos)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_btnplaypause_pressed() -> void:
	if $reproductor.is_playing():
		$btnplaypause/Label.text = "Play";
		if $reproductor.paused:
			$btnplaypause/Label.text = "Pause";
		$reproductor.paused = !$reproductor.paused;
		

		


func _on_btnnext_pressed() -> void:
	if $reproductor.is_playing():
		var new_position = $reproductor.get_stream_position() + seek_time;
		# Asegurarse de no adelantar más allá del final del video
		#if new_position < $reproductor.get_stream_length():
		$reproductor.set_stream_position(new_position)


func _on_btnback_pressed() -> void:
	var new_position = $reproductor.get_stream_position() - seek_time
	# Asegurarse de no retroceder más allá del principio del video
	if new_position > 0:
		$reproductor.stream_position(new_position)
	else:
		$reproductor.stream_position(0)  # Ir al principio si pasa de 0
