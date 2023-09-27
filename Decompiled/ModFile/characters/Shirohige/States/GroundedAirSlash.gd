extends CharacterState

export var _c_CustomShot = 0
export (PackedScene) var AirSlashScene
export var projPosX = 0
export var projPosY = 0

func _frame_12():
	host.spawn_object(AirSlashScene, projPosX, projPosY)
