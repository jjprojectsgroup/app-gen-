extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var name = get_current_scene_name()
	if name == 'registros':
		$Label/Label.text = 'REGISTROS'
	else :
		$Label/Label.text = 'GRADO '+ Global.nivel
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_button_pressed() -> void:
	var current_scene = get_current_scene_name();
	match current_scene:
		'nivel_1', 'nivel_2', 'nivel_3', 'registros':
			Trans.change_scene('res://Escenas/menu.tscn')
			return
	Trans.change_scene('res://Escenas/nivel_'+ Global.nivel +'.tscn')
	pass # Replace with function body.

func get_current_scene_name() -> String:
	var current_scene = get_tree().current_scene
	if current_scene != null:
		return current_scene.name
	return ""

func _on_respuesta_text_changed() -> void:
	pass # Replace with function body.

#func cropLineToMaxLength(maxLength: int) -> void:
	#var new_text = $Control/respuesta1.text
	##if new_text.length() > 1:
		#
