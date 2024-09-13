extends Node2D

var seek_time = 10; # Cuánto adelantar o retroceder (en segundos)
# Crea una instancia de FFmpegVideoStream
var ffmpeg_video_stream = FFmpegVideoStream.new() # se declara el plugin de reproducción de video
# Variable para saber si el usuario está arrastrando
#var is_dragging = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ffmpeg_video_stream.file = 'res://video/video-'+Global.numero_video+'.mov'
	$reproductor.set_stream(ffmpeg_video_stream)
		# Conecta la señal que se dispara cuando el video comienza a reproducirse

	# Configura la duración máxima de la barra de progreso
	$progressbar.min_value = 0
	$progressbar.max_value = $reproductor.get_stream_length()
	$reproductor.play()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if $reproductor.is_playing():
		var current_position = $reproductor.get_stream_position()
		$progressbar.value = current_position
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
		if new_position < $reproductor.get_stream_length():
			$reproductor.set_stream_position(new_position)


func _on_btnback_pressed() -> void:
	var new_position = $reproductor.get_stream_position() - seek_time
	# Asegurarse de no retroceder más allá del principio del video
	if new_position > 0:
		$reproductor.set_stream_position(new_position)
	else:
		$reproductor.set_stream_position(0)  # Ir al principio si pasa de 0


func _on_reproductor_finished() -> void:
	$progressbar.value = 0;
	pass # Replace with function body.


func _on_progressbar_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		# Obtener el tamaño de la ProgressBar y la posición del clic
		var progress_ratio = event.position.x / $progressbar.size.x
		var new_position = progress_ratio * $reproductor.get_stream_length()
		# Mover el video a la nueva posición
		$reproductor.set_stream_position(new_position)
		# Actualizar manualmente la barra de progreso
		$progressbar.value = new_position
	 #Si el usuario empieza a arrastrar
	#if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		#if event.pressed:
			#is_dragging = true  # Comienza a arrastrar
			#_update_progress(event.position.x)
		#else:
			#is_dragging = false  # Deja de arrastrar cuando suelta el clic
		## Mientras arrastra, actualiza la posición
		#if event is InputEventMouseMotion and is_dragging:
			#_update_progress(event.position.x)
			#
## Función que actualiza el progreso y la posición del video
#func _update_progress(mouse_x_position):
	#var progress_ratio = mouse_x_position / $progressbar.size.x
	#var new_position = progress_ratio * $reproductor.get_stream_length()
	## Mover el video a la nueva posición mientras arrastra
	#$reproductor.set_stream_position(new_position)
	## Actualizar manualmente la barra de progreso
	#$progressbar.value = new_position
