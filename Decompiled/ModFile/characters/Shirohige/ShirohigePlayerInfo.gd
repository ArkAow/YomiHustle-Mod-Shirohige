extends PlayerInfo

onready var haki_bar = $"%HakiBar"

func set_fighter(fighter):
	.set_fighter(fighter)
	if player_id == 2:
		$"%HakiBar".fill_mode = TextureProgress.FILL_RIGHT_TO_LEFT
		$HBoxContainer.alignment = BoxContainer.ALIGN_END

func _process(delta):
	if is_instance_valid(fighter):
		haki_bar.value = fighter.currentHakiAmount / float(fighter.maximumHakiAmount)
		haki_bar.modulate.a = 0.25 if fighter.currentHakiAmount <= fighter.maximumHakiAmount else 1.0
	
		haki_bar.tint_progress = Color("a10303")
