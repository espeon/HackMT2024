extends Node2D

## Target to follow.
@export var follow_target: Node2D
## Copy value from Node2D - Transform - Position [Vector2]
@export var pos_offset := Vector2.ZERO
var prev_pos: Vector2
var current_pos: Vector2
var update := false

#==============================================================================

func _ready() -> void:
	if follow_target == null:
				push_error("[" + str(self) + "]: No target!")
	else:
		global_position = follow_target.global_position
		prev_pos = follow_target.global_position
		current_pos = follow_target.global_position

func _process(_delta: float) -> void:
	if update and follow_target != null:
		update_target_pos()
		update = false
	var fraction = clamp(Engine.get_physics_interpolation_fraction(), 0, 1)
	global_position = prev_pos.lerp(current_pos, fraction) + pos_offset

func _physics_process(_delta: float) -> void:
	update = true

#==============================================================================

func update_target_pos():
	prev_pos = current_pos
	current_pos = follow_target.global_position
