extends Node2D
var par= []; # almacena temporalmente los botones emparejados
var par_count = 0; # contador para verificar cuantos pares se han encontrado

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_card_pressed(card: String, button_name: String) -> void:
	par.append([card, button_name])
	disabled_selected_card(button_name)
	if par.size() >= 2:
		if par[0][0] == card:
			print('son iguales')
			flat_selected_card(button_name, false)
			flat_selected_card(par[0][1], false)
		else :
			enabled_selected_card(button_name)
			enabled_selected_card(par[0][1])
		par.clear()


func disabled_selected_card(button_name: String) -> void:
	var button_path = "%s/%s" % ['Card'+button_name, 'Button']
	var button = get_node(button_path)
	button.disabled = true
	button.flat = false
	
func enabled_selected_card(button_name: String) -> void:
	var button_path = "%s/%s" % ['Card'+button_name, 'Button'] 
	var button = get_node(button_path)
	button.disabled = false
	button.flat = true
	
func flat_selected_card(button_name: String, flat:bool) -> void:
	var button_path = "%s/%s" % ['Card'+button_name, 'Button'] 
	var button = get_node(button_path)
	button.flat = flat
