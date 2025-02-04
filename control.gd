extends Control
@onready var mouse_slider: HSlider = $MouseSlider
@onready var check_button: CheckButton = $CheckButton



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#mouse_slider.value = settings.MOUSE_STRENGTH
	pass



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	queue_redraw()

func _draw() -> void:
	if settings.follow_mouse:
		var mouse_pos = get_local_mouse_position()
		var radius = settings.MOUSE_STRENGTH / 3
		var color = Color(1,1,1)
		var line_width = 2
		draw_arc(mouse_pos, radius, 0, TAU, 32, color, line_width)


func _on_check_button_toggled(toggled_on: bool) -> void:
	if toggled_on:
		settings.follow_mouse = true
		settings.toggle = toggled_on
	else:
		settings.follow_mouse = false
		settings.toggle = toggled_on
