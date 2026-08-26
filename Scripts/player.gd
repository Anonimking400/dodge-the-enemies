extends CharacterBody2D

@export var speed := 300.0

@onready var joystick = $"../UI/Joystick"


func _physics_process(_delta):
	var direction: Vector2 = joystick.input_vector

	velocity = direction * speed
	move_and_slide()
