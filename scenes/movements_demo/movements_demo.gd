extends Node

@onready var capsule_2: MeshInstance3D = $Capsule2
@onready var capsule: MeshInstance3D = $Capsule

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

var _speed: float = 0
var _topSpeed: float = 6
var _direction: Vector3
var _topRotationSpeed: float = 180
var _rotationSpeed: float = 0
var _rotationDirection:int=1


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	capsule.look_at(capsule_2.global_position,Vector3.UP,true)
	
	if Input.is_action_just_pressed("ui_accept"):
		print("VALEVERGA")
		capsule.transform.basis = capsule_2.transform.basis
		
	if _speed>_topSpeed:_speed=_topSpeed
	elif  _speed <= 0: _speed= 0
	else: _speed -=_topSpeed*0.05
	
	
	if _rotationSpeed > _topRotationSpeed:_rotationSpeed=_topRotationSpeed
	elif  _rotationSpeed <= 0: _rotationSpeed= 0
	else: _rotationSpeed -= _topRotationSpeed*0.3
	
	
	if Input.is_action_pressed("ui_up"):
		_speed+=_topSpeed*0.1
		_direction=Vector3.FORWARD
	if Input.is_action_pressed("ui_down"):
		_speed+=_topSpeed*0.1
		_direction=Vector3.BACK
	if Input.is_action_pressed("ui_left"):
		_rotationSpeed+=_topRotationSpeed*0.4
		_rotationDirection=1
	if Input.is_action_pressed("ui_right"):
		_rotationSpeed+=_topRotationSpeed*0.4
		_rotationDirection=-1
	capsule_2.translate_object_local(_direction.normalized() * delta * -_speed)
	capsule_2.global_rotate(Vector3.UP,deg_to_rad(_rotationSpeed)*delta*_rotationDirection)
	print("speed: ", _speed, 
	"\nrotationSpeed: ",_rotationSpeed,
	"\ndirection: ",_direction)
	pass
