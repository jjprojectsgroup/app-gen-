extends Node2D
var par= []; # almacena temporalmente los botones emparejados
var par_count = 0; # contador para verificar cuantos pares se han encontrado

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_card_pressed(card: String, buton: NodePath) -> void:
	par.append(card)
	disabled_selected_card(buton)
	if par.size() >= 2:
		if par[0] == card:
			print('son iguales')
		par.clear()

func disabled_selected_card(path_buton: NodePath) -> void:
	#var buton = get_node(path_buton)
	print(path_buton.get_as_property_path())
	pass
