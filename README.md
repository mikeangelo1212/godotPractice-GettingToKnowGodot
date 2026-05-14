# godotPractice-GettingToKnowGodot
Practica de curso udemy en godot

# De momento...

Hemos visto el manejo simple de nodos, como a veces Godot recicla un objeto, en este caso la mesh, no el nodo padre que es Node3D. Y que para ello habra que desligarlos. Estos se crean asi cuando se crea una copia de la mesh ligada a la original para **toda manipulacion al mesh** es compartida hasta desligarlse.

Se agregaron unas meshes, camara, e ilumacion global con un sol a la escena.

Los materiales tambien estan ligados a la hora de copiar, o hacemos los materiales unicos para trabajarlos aparte, desligarlos vaya, o hacemos en el nodo de nuestra mesh, Geometry Material Override en nuestra GeometryInstance3D de nuestra MeshInstance3D.

Se pueden guardar los materiales para poder usarlos de manera invididual

DirectionalLight3D viene siendo un sol pues es una luz infinita.

Tambien se pueden poner una imagen hdr como el cielo, esta pondra sus propias propiedades del cielo.

El culling es cuando un poligono no dibuja lo que esta dentro, o fuera del mesh. Eso si se quiere, se puede descativar en el material>transparency>culling.

### Translation

Cuando creamos un script nos da un onready y un _process delta, este esta corriendo entre frames, lo cual nos permite ejecutar codigo cuando el juegoe esta corriendo.

Podemos importar los nodos al script de la escena arrastrandolos al codigo y con control lo exporta como variable @onready, la cual tiene el tipo explicito y la referencia al objeto que queremos.

```gdscript 
@onready var capsule_2: MeshInstance3D = $Capsule2
```

Las direcciones de godot "positivas" estan en negativas. Usualmente deben invertirse para que avancen

```gdscript
@onready var capsule_2: MeshInstance3D = $Capsule2
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	capsule_2.translate_object_local(Vector3.FORWARD * delta * -1)
	pass
```

Tambien existe el global translate, el cual este no le importa la rotacion del objeto local, lo hace con los angulos del mundo, en vez de como esta rotado el objeto local para usar su vector al moverse.

```gdscript
	capsule_2.global_translate(Vector3.FORWARD * delta * -1)
```

Se puede agregar input de la siguiente manera con este translate que hemos puesto
```gdscript
	if Input.is_action_pressed("ui_up"):
		capsule_2.global_translate(Vector3.FORWARD * delta * -1)
	if Input.is_action_pressed("ui_down"):
		capsule_2.global_translate(Vector3.BACK * delta * -1)
```

Ahora, la manera en la que quedo nuestro codigo para que tambien soportara aceleracion de cierta manera es la siguiente
**NOTA:** Normalized() es para que la suma de nuestros vectores en total sea 1, asi por si digamos. Hay movimiento en diagonal este no sea

```gdscript
Vector3(0,1,1)
```

sino

```gdscript
Vector3(0,0.5,0.5)
```

```gdscript
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

```

### Rotacion

Pondremos a la otra mesh a seguir el jugador.

```gdscript
capsule.transform.basis = capsule_2.transform.basis
```

La propiedad transform de nuestro nodo controla la rotacion del objeto

Si alguna vez, nuestro nodo es hijo de otro, las propiedades de posicion, y transformacion son alteradas por el padre, si solo queremos la rotacion del objeto hijo, usamos la propiedad global

```gdscript
capsule.global_transform.basis = capsule_2.global_transform.basis
```

Transform tambien tiene la escala en su propiedad implicita. De manera que como tenemos el codigo anterior, este tambien cambiara a la escala, si solo queremos la rotacion y no el transform completo que tambien incluye escala. Lo llamariamos asi.

```gdscript
capsule_2.global_transform.otrhonormalized()
```

Si queremos que nuestro nodo mire al otro usaremos el siguiente metodo
```gdscript
capsule.look_at(capsule_2.global_position,Vector3.UP,true)
#void look_at(target: Vector3, up: Vector3 = Vector3(0, 1, 0), use_model_front: bool = false)
```

Capsula mira a la posicion global de la capsula dos, giraras con el eje Y como tu pivote, o sea girar hacia los lados, usando el frente del modelo (true)
