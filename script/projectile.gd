extends Area2D

@export var speed: float = 400.0  
@export var direction: Vector2 = Vector2(0, 1)  
@export var damage: int = 1  

func _ready():
	pass

func _process(delta):
	position += direction.normalized() * speed * delta  

func _on_body_entered(body):
	if body.is_in_group("player"):
		body.current_hp -= damage  
		print("Player hit! HP:", body.current_hp)
		if body.current_hp <= 0:
			body.die()  
		queue_free() 
