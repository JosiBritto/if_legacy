extends Control

@export var painel: PanelContainer;
@onready var modalBloco : PackedScene = preload("res://scenes/ModalBloco.tscn");

var referencia : Dictionary; # refenrencia que guarda TODOS os modais dos blocos
var current_bloco = null; # guarda o modal atualmente referenciado

func abrirBloco(bloco: Bloco):
	current_bloco = bloco.node;
	print(current_bloco);
	print(current_bloco.item);
	print(current_bloco.item.sceneMinigame);
	if current_bloco == null:
		return;
	
	clear_Modal();
	add_new_modal(bloco); # ver o motivo de ter um parâmetro para o item de bloco (tutorial)
	
func clear_Modal():
	for modal in painel.get_children():
		modal.queue_free();

func add_new_modal(bloco: Bloco):
	var modal = modalBloco.instantiate();
	modal.tituloTutorial.text = current_bloco.item.tituloTutorial;
	modal.descricaoTutorial.text = current_bloco.item.descricaoTutorial;
	modal.imagemTutorial.texture = current_bloco.item.image;
	modal.imagemDescTemp.texture = current_bloco.item.imagemDescTemp;
	painel.add_child(modal);

func deActivate():
	clear_Modal();
	current_bloco = null;
	
func changeScenary():
	clear_Modal();
	get_tree().change_scene_to_file(current_bloco.item.sceneMinigame);
