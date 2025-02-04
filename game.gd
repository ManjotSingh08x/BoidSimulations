extends Node2D
var screen_size = Vector2(1920, 991)
var BirdScene = preload("res://bird.tscn")
@export var count:int = 150
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spawn_birds(count - 1)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func spawn_birds(count: int):
	#var screen_size = DisplayServer.window_get_size()
	#print(screen_size)
	var birds = []
	for i in range(count):
		var bird = BirdScene.instantiate()
		add_child(bird)
		birds.append(bird)
		
	for bird in birds:
		bird._set_bird_properties(birds)
		
func _input(event: InputEvent) -> void:
	if settings.toggle:
		if event is InputEventMouse and event.is_action_pressed("toggle follow"):
			settings.follow_mouse = true
		if event is InputEventMouse and event.is_action_released("toggle follow"):
			settings.follow_mouse = false
		
