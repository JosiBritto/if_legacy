extends CharacterBody2D
class_name PlayerController;

@export var mov_speed = 170.0;

func _physics_process(delta: float) -> void:
	velocity = Input.get_vector("moves_left","moves_right","moves_up","moves_down").normalized() *mov_speed;
	move_and_collide(velocity*delta);
