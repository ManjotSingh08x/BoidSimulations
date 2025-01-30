extends RigidBody2D
@export var SPEED = 1
@export var rotation_speed = 50
@onready var screen_size = Vector2(1920, 991)
var follow_mouse = false
var num_flock_mates: int = 0
var flockmates: Array = []
@onready var game: Node2D = $".."
@onready var all_birds = []
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	linear_velocity = SPEED*random_unit_vector()
	var x = randf_range(0, screen_size.x)
	var y = randf_range(0, screen_size.y)
	position = Vector2(x,y)

	pass # Replace with function body.

func _set_bird_properties(bird_array):
	all_birds = bird_array
	#print(len(all_birds))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	for bird in flockmates:
		if not is_close(bird):
			flockmates.erase(bird)
	for bird in all_birds:
		if is_close(bird):
			flockmates.append(bird)
			
	print(len(flockmates))
			
	
func _physics_process(delta: float) -> void:
	wrap_bird()
	if follow_mouse:
		var direction = (get_global_mouse_position() - global_position).normalized()
		apply_force(direction * SPEED)
	rotatebird()
	
func _input(event: InputEvent) -> void:
	if event is InputEventMouse and event.is_action_pressed("toggle follow"):
		follow_mouse = not follow_mouse

	
func rotatebird():
	var target_angle = rotation
	if linear_velocity.length() > 0:
		target_angle = linear_velocity.angle()
	var angle_diff = fmod(target_angle - rotation + PI, 2 * PI) - PI
	angular_velocity = angle_diff * rotation_speed  # Adjust rotation speed
	
func random_unit_vector():
	var x = randf_range(-1.0,1.0)
	var y = randf_range(-1.0,1.0)
	var vector = Vector2(x,y)
	return vector.normalized()
	
func wrap_bird():
	if position.x < 0:
		position.x = screen_size.x
	elif position.x > screen_size.x:
		position.x = 0
		
	if position.y < 0:
		position.y = screen_size.y
	elif position.y > screen_size.y:
		position.y = 0
		
func bird():
	pass
	
func is_close(other_bird):
	pass
