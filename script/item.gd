extends Resource
class_name Item

@export var title : String;
@export var icon : Texture2D;
@export var price : int = 1;


var node = null # variável para armazenar o nó de referência

func activate():
	pass

func de_activate():
	pass
