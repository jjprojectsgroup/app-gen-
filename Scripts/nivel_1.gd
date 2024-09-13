extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_btnsalir_pressed() -> void:
	Trans.change_scene('res://Escenas/menu.tscn')
	pass # Replace with function body.


func _on_btnactividad_1_pressed() -> void:
	Trans.change_scene('res://Escenas/videos.tscn')
	pass # Replace with function body.
