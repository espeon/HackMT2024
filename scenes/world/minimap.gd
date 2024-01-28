extends SubViewport

@onready var camera = $Camera2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	camera.position.x = owner.find_child("Player").position.x
