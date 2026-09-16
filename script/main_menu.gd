extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_botao_sair_pressed() -> void:
	get_tree().quit() 

func _on_botao_jogar_pressed():
	get_tree().change_scene_to_file("res://scenes/test_lobby.tscn")

func _on_botao_opcoes_pressed():
	get_tree().change_scene_to_file("res://scenes/menu_opções.tscn")

func _on_botao_creditos_pressed():
	get_tree().change_scene_to_file("res://scenes/creditos.tscn")
