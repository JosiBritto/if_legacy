extends Control

@export var inventory : GridContainer; # exporta a referencia do GridContainer 
@onready var slotNode: PackedScene = preload("res://scenes/slot.tscn");
