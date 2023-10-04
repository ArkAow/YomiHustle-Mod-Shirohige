extends CharacterState

func _enter():
	if (host.hakiActivated):
		anim_name = "JumpHaki"
	else:
		anim_name = "Jump"
func _tick():
	host.apply_grav()
	host.apply_forces()
	if current_tick > 1 and host.is_grounded():
		return "Landing"
