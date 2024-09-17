extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_btnaceptar_pressed():
	Trans.change_scene('res://Escenas/nivel_'+ Global.nivel +'.tscn')
