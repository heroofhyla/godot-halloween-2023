extends TextureRect

const HEART_SPACING: int = 16
@export_enum("player_health", "player_max_health") var meter_type: String = "player_health"

func _ready():
	EventBus.player_health_changed.connect(_on_EventBus_player_health_changed)
	update_size()

func _on_EventBus_player_health_changed():
	update_size()

func update_size():
	size.x = 16 * GlobalVars[meter_type]
