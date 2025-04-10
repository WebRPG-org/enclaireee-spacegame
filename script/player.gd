extends CharacterBody2D

@export var speed: float = 300.0  
@export var acceleration: float = 300.0  
@export var friction: float = 500.0  
@export var max_hp: int = 10  
@export var projectile_scene: PackedScene = preload("res://scenes/player_proj.tscn")
@export var fire_rate: float = 0.5

var current_hp: int

func _ready():
	current_hp = max_hp
	var shoot_timer = $ShootTimer
	shoot_timer.wait_time = fire_rate
	shoot_timer.one_shot = false
	shoot_timer.start()
	shoot_timer.timeout.connect(on_shoot_timer_timeout)

func _physics_process(delta):
	var direction = Vector2.ZERO  
	direction.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	direction.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	
	if direction != Vector2.ZERO:
		direction = direction.normalized()
		velocity = velocity.move_toward(direction * speed, acceleration * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, friction * delta)
	
	move_and_slide()
	
func die():
	print("Player Died!")  
	queue_free()

func shoot():
	var bullet = projectile_scene.instantiate()
	bullet.position = position + Vector2(0, -20)
	get_parent().add_child(bullet)

func on_shoot_timer_timeout() -> void:
	# Automatic shooting based on timer
	shoot()
