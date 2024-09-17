extends Label

var extra_data : Dictionary = {}
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

# Método para recibir los datos adicionales
func set_extra_data(data: Dictionary):
	extra_data = data

func _on_button_pressed() -> void:
	print(extra_data)
	var escena_emergente = preload("res://componentes/tarjeta_mostrar.tscn").instantiate()
	escena_emergente.get_data(extra_data)
	get_tree().root.add_child(escena_emergente)
