# godotPractice-GettingToKnowGodot
Practica de curso udemy en godot

# De momento...

Hemos visto el manejo simple de nodos, como a veces Godot recicla un objeto, en este caso la mesh, no el nodo padre que es Node3D. Y que para ello habra que desligarlos. Estos se crean asi cuando se crea una copia de la mesh ligada a la original para **toda manipulacion al mesh** es compartida hasta desligarlse.

Se agregaron unas meshes, camara, e ilumacion global con un sol a la escena.

Los materiales tambien estan ligados a la hora de copiar, o hacemos los materiales unicos para trabajarlos aparte, desligarlos vaya, o hacemos en el nodo de nuestra mesh, Geometry Material Override en nuestra GeometryInstance3D de nuestra MeshInstance3D.

Se pueden guardar los materiales para poder usarlos de manera invididual

DirectionalLight3D viene siendo un sol pues es una luz infinita.
