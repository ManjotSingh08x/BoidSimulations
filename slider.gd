extends HSlider
@onready var label: Label = $Label
@export var property = "MOUSE_STRENGTH"
@export var label_text = "Mouse Strength"
var frames = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	label.text = label_text + ": " + str(settings.get(property))
	value = settings.get(property)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:

	frames += 1
	if frames %  20==0:
		settings.set(property, value)
		label.text = label_text + ": " + str(settings.get(property))
		frames = 0
