extends Node

@onready var capsule_2: MeshInstance3D = $Capsule2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

var _speed: float = 0.0
var _topSpeed: float = 6.0
var _direction: Vector3


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	_direction=Vector3.ZERO
	
	if _speed>_topSpeed:_speed=_topSpeed
	elif  _speed <= 0: _speed= 0
	else: _speed-=.875
	print(_speed)
	
	#capsule_2.translate_object_local(Vector3.FORWARD * delta * -1)
	#capsule_2.global_translate(Vector3.FORWARD * delta * -1)
	
	if Input.is_action_pressed("ui_up"):
		_speed+=1.3
		_direction+=Vector3.FORWARD
	if Input.is_action_pressed("ui_down"):
		_speed+=1.3
		_direction+=Vector3.BACK
	if Input.is_action_pressed("ui_left"):
		_speed+=1.3
		_direction+=Vector3.LEFT
	if Input.is_action_pressed("ui_right"):
		_speed+=1.3
		_direction+=Vector3.RIGHT
	capsule_2.translate_object_local(_direction.normalized() * delta * -_speed)
	pass
