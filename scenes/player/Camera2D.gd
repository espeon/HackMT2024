extends Camera2D

@onready var player = get_node("../../Player")
var camera_position: Vector2
var overshoot: Vector2 = Vector2(0.3, 0.3);

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	

static func lerp_overshoot(origin: float, target: float, weight: float, overshoot: float) -> float:
	var distance: float = (target - origin) * weight;
	if is_equal_approx(distance, 0.0):
		return target;
	var distanceSign := signf(distance);
	var lerpValue: float = lerp(origin, target + (overshoot * distanceSign), weight);

	if distanceSign == 1.0:
		lerpValue = min(lerpValue, target);
	elif distanceSign == -1.0:
		lerpValue = max(lerpValue, target);

	return lerpValue;
	
static func lerp_overshoot_v(from: Vector2, to: Vector2, weight: float, overshoot: Vector2) -> Vector2: 
	var x = lerp_overshoot(from.x, to.x, weight, overshoot.x); 
	var y = lerp_overshoot(from.y, to.y, weight, overshoot.y);
	return Vector2(x,y);

func _physics_process(delta): 
	self.camera_position = lerp_overshoot_v(self.position, player.position, 0.2, self.overshoot); 
	self.position = self.camera_position;

func fix_camera_jitter():
	if not $Player.is_moving():
		position = position.round()
