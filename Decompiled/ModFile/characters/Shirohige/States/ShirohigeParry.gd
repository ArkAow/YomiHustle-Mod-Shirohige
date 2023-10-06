extends ParryState

func _tick():
	if (host.hakiActivated):
		if (parry_type == ParryHeight.High):
			anim_name = "ParryHighHaki"
		if (parry_type == ParryHeight.Low):
			anim_name = "ParryLowHaki"
		if (parry_type == ParryHeight.Both):
			anim_name = "ParryLowHaki"
	else:
		if (parry_type == ParryHeight.High):
			anim_name = "ParryHigh"
		if (parry_type == ParryHeight.Low):
			anim_name = "ParryLow"
		if (parry_type == ParryHeight.Both):
			anim_name = "ParryLow"
