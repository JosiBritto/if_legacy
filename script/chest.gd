extends Item
class_name Chest

@export var size : int # tamnaho de slots disponíveis

func activate():
	print(title + " activaded");

func de_activate():
	print(title + " de-activaded");
