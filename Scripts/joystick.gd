extends Control

@export var radius := 80.0
@export var knob_radius := 30.0

var input_vector := Vector2.ZERO
var knob_position := Vector2.ZERO
var touch_id := -1


func _ready():
	knob_position = size / 2.0
	queue_redraw()


func _draw():
	var center := size / 2.0

	draw_circle(knob_position, knob_radius, Color.WHITE)

	draw_arc(
		center,
		radius,
		0.0,
		TAU,
		64,
		Color.WHITE,
		4.0
	)


func _gui_input(event):
	if event is InputEventScreenTouch:
		if event.pressed and touch_id == -1:
			touch_id = event.index
			_update_joystick(event.position)

		elif not event.pressed and event.index == touch_id:
			touch_id = -1
			input_vector = Vector2.ZERO
			knob_position = size / 2.0
			queue_redraw()

	elif event is InputEventScreenDrag:
		if event.index == touch_id:
			_update_joystick(event.position)


func _update_joystick(pos: Vector2):
	var center := size / 2.0
	var offset := pos - center

	if offset.length() > radius:
		offset = offset.normalized() * radius

	knob_position = center + offset
	input_vector = offset / radius

	queue_redraw()
