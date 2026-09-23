extends Control

@export var painel: PanelContainer;
@onready var modalBloco : PackedScene = preload("res://scenes/ModalBloco.tscn");

var referencia : Dictionary; # refenrencia que guarda TODOS os modais dos blocos
var current_bloco = null; # guarda o modal atualmente referenciado

func abrirBloco(bloco: Bloco):
	current_bloco = bloco.node;
	if current_bloco == null:
		return;
	
	clear_Modal();
	add_new_modal(bloco);
	
func clear_Modal():
	for modal in painel.get_children():
		modal.free();

func add_new_modal(bloco: Bloco):
	var modal = modalBloco.instantiate();
	painel.add_child(modal);

func deActivate():
	clear_Modal();
	current_bloco = null;
