extends DefaultFireball

func fizzle():
	hit_something = true
	host.disable()
	terminate_hitboxes()
	hit_something_tick = current_tick

func _frame_60():
	fizzle()
