extends Node2D
var icon_play = preload("res://img/play.png")
var icon_pausa = preload("res://img/pausa.png")
var seek_time = 10; # Cuánto adelantar o retroceder (en segundos)
# Crea una instancia de FFmpegVideoStream
var ffmpeg_video_stream = FFmpegVideoStream.new() # se declara el plugin de reproducción de video
# Variable para saber si el usuario está arrastrando
#var is_dragging = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var ruta_video = 'res://video/video-'+Global.numero_video+'.mov'
	if Global.numero_video == '5' || Global.numero_video == '6':
		ruta_video = 'res://video/video-'+Global.numero_video+'.mp4'
	ffmpeg_video_stream.file = ruta_video
	$reproductor.set_stream(ffmpeg_video_stream)
	# Configura la duración máxima de la barra de progreso
	$progressbar.min_value = 0
	$progressbar.max_value = $reproductor.get_stream_length()
	$reproductor.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if $reproductor.is_playing():
		var current_position = $reproductor.get_stream_position()
		$progressbar.value = current_position


func _on_btnplaypause_pressed() -> void:
	if $reproductor.is_playing():
		$btnplaypause.icon = icon_play;
		if $reproductor.paused:
			$btnplaypause.icon = icon_pausa;
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


func _on_progressbar_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		# Obtener el tamaño de la ProgressBar y la posición del clic
		var progress_ratio = event.position.x / $progressbar.size.x
		var new_position = progress_ratio * $reproductor.get_stream_length()
		# Mover el video a la nueva posición
		$reproductor.set_stream_position(new_position)
		# Actualizar manualmente la barra de progreso
		$progressbar.value = new_position


func _on_button_pressed() -> void:
	$reproductor.stop()
	Trans.change_scene('res://Escenas/nivel_'+ Global.nivel +'.tscn')
