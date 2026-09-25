extends Item
class_name Bloco


@export var descricaoTutorial: String;
@export var tituloTutorial: String;
@export var image: Texture2D;
@export var imagemDescTemp: Texture2D;
@export var sceneMinigame: String;

func activate():
	print(title + " activaded");
	ModalManagement.abrirBloco(self);

func de_activate():
	print(title + " de-ativaded");
	ModalManagement.deActivate(); 
