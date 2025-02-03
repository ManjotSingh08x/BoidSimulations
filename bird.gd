extends RigidBody2D
@export var SPEED = 200
@export var MOUSE_STRENGTH = -500
@export var COHESION_STRENGTH = 200
@export var ALIGN_STRENGTH = 150
@export var SEPERATION_STR = 6000
@export var rotation_speed = 60
@onready var screen_size = Vector2(1920, 991)
@export var view_radius = 2
var max_speed = 700
var follow_mouse = false
var num_flock_mates: int = 0
var flockmates: Array = []
@onready var game: Node2D = $".."
@onready var all_birds = []
@onready var polygon_2d: Polygon2D = $Polygon2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	linear_velocity = SPEED*random_unit_vector()
	var x = randf_range(0, screen_size.x)
	var y = randf_range(0, screen_size.y)
	position = Vector2(x,y)
	if randi() % 3 == 0:
		polygon_2d.color = Color(0,0.46,0.83,1)
	elif randi() % 3 == 1:
		polygon_2d.color = Color(0.29, 0.63, 0.99,1)
	else:
		polygon_2d.color = Color(0.53,0.75,0.99,1)

	pass # Replace with function body.

func _set_bird_properties(bird_array):
	all_birds = bird_array
	#print(len(all_birds))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#draw_circle(Vector2(0, 0), view_radius, Color(255, 255, 255))
	pass
			
	
func _physics_process(delta: float) -> void:
	wrap_bird()
	var total_force:Vector2 = Vector2(0,0)
	total_force += cohesion_force()
	total_force += align_force()
	total_force += seperation_force()
	if follow_mouse:
		total_force += mouse_force()
		
	apply_force(total_force)
	rotatebird()
	linear_velocity = linear_velocity.clamp(Vector2(-max_speed,-max_speed), Vector2(max_speed,max_speed))
	
func _input(event: InputEvent) -> void:
	if event is InputEventMouse and event.is_action_pressed("toggle follow"):
		follow_mouse = not follow_mouse


func rotatebird():
	if linear_velocity.length() > 0:
		var target_angle = linear_velocity.angle()
		rotation = lerp_angle(rotation, target_angle, 0.1)  # Smooth transition	
#func rotatebird():
	#var target_angle = rotation
	#if linear_velocity.length() > 0:
		#target_angle = linear_velocity.angle()
	#var angle_diff = fmod(target_angle - rotation, 2 * PI) 
	#angular_velocity = angle_diff * rotation_speed  # Adjust rotation speed
	
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
	var dist = other_bird.position - position
	return dist.length_squared() > view_radius * view_radius

func _on_bird_exited(body: Node2D) -> void:
	flockmates.erase(body)
	pass # Replace with function body.

func _on_bird_entered(body: Node2D) -> void:
	flockmates.append(body)
	pass # Replace with function body.

func mouse_force():
	var direction = (get_global_mouse_position() - global_position)
	if direction.length() > 0:
		direction = direction.normalized()
		
	return direction*MOUSE_STRENGTH
	
func cohesion_force():
	var total_position = Vector2(0,0)
	var length = len(flockmates)
	if length > 1:
		for flockmate in flockmates:
			total_position += flockmate.position
		var average_position = (total_position / length - position).normalized()
		return average_position * COHESION_STRENGTH
	return Vector2(0,0)
		
func align_force():
	var total_direction = Vector2(0,0)
	var length = len(flockmates)
	if length > 1:
		for flockmate in flockmates:
			total_direction += flockmate.linear_velocity
		var average_direction= (total_direction).normalized()
		#print(average_direction
		return (average_direction) * ALIGN_STRENGTH
	return Vector2(0,0)
	
	
func seperation_force():
	var total_direction = Vector2(0,0)
	var length = len(flockmates)
	if length > 0:
		for flockmate in flockmates:
			var diff: Vector2 = position - flockmate.position
			total_direction += diff / (diff.length_squared() + 0.001)
		#print(total_direction)
		return total_direction * SEPERATION_STR
	return Vector2(0,0)
