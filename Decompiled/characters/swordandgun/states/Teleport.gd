extends SuperMove

const MOVE_DIST = "200"
const BACKWARDS_STALL_FRAMES = 5
const BACKWARDS_STALL_FRAMES_NEUTRAL_EXTRA = 5
const UPWARDS_STALL_FRAMES_NEUTRAL_EXTRA = 5
const EXTRA_FRAME_PER = "1000"
const EXTRA_FRAME_IN_COMBOS = 4
const EXTRA_FRAME_PER_BACKWARDS = "0.2"
const MOMENTUM_FORCE = "16.0"
const CROSS_THROUGH_RECOVERY = 8
const FORWARD_SUPER = 55

var backwards_stall_frames = 0
var starting_dir = 0
var extra_frames = 0
var in_place = false
var forward = false
var x_dist = "0"

func _frame_0():
	starting_dir = host.get_opponent_dir()
	iasa_at = 9
	backwards_stall_frames = 0
	host.start_throw_invulnerability()
	var comboing = false
	forward = false
	var scaled = xy_to_dir(data.x, data.y)
	in_place = fixed.lt(fixed.vec_len(scaled.x, scaled.y), "0.1")
	x_dist = fixed.abs(scaled.x)
	if super_level > 0:
		iasa_at = 7


		return 
	else :
		if host.opponent.current_state().busy_interrupt_type == BusyInterrupt.Hurt:
			comboing = true
	var dir = xy_to_dir(data.x, data.y, MOVE_DIST)
	var backward = fixed.sign(scaled.x) != host.get_facing_int() and scaled.x != "0"
	if fixed.gt(x_dist, "0.5"):
		if backward:
			host.add_penalty(10)
			backwards_stall_frames = BACKWARDS_STALL_FRAMES
			if not comboing:
				backwards_stall_frames += BACKWARDS_STALL_FRAMES_NEUTRAL_EXTRA
		else :
			host.add_penalty( - 5)
	forward = not (backward or in_place)
	if not comboing and fixed.lt(scaled.y, "-0.2"):
		backwards_stall_frames += UPWARDS_STALL_FRAMES_NEUTRAL_EXTRA
		host.add_penalty(10)
	extra_frames = fixed.round(fixed.div(fixed.abs(scaled.x), EXTRA_FRAME_PER if not backward else EXTRA_FRAME_PER_BACKWARDS)) + (EXTRA_FRAME_IN_COMBOS if comboing else 0)
	iasa_at += extra_frames


func _frame_4():
	host.end_throw_invulnerability()
	if in_place:
		host.start_invulnerability()
	host.start_projectile_invulnerability()
	host.colliding_with_opponent = false

func _frame_5():
	var dir = xy_to_dir(data.x, data.y, MOVE_DIST)

	host.move_directly(dir.x, dir.y)
	var vel = host.get_vel()
	host.set_vel(vel.x, "0")
	var tele_force = xy_to_dir(data.x, data.y, MOMENTUM_FORCE)
	if fixed.lt(tele_force.y, "0"):
		tele_force.y = fixed.mul(tele_force.y, "0.666667")
	host.apply_force(tele_force.x, tele_force.y)
	host.update_data()

func _frame_6():
	if starting_dir != host.get_opponent_dir() and host.combo_count <= 0 and super_level <= 0:
		iasa_at = iasa_at + CROSS_THROUGH_RECOVERY
	if forward:
		if host.combo_count <= 0:
			host.gain_super_meter(fixed.round(fixed.mul(str(FORWARD_SUPER), x_dist)))
	host.update_facing()

func _frame_7():
	host.end_invulnerability()
	host.end_projectile_invulnerability()
	host.colliding_with_opponent = true

func _tick():
	if backwards_stall_frames > 0:
		current_tick = 0
		backwards_stall_frames -= 1

	host.apply_fric()
	host.apply_grav()
	host.apply_forces()
	host.set_grounded(host.get_pos().y == 0)

func is_usable():
	return .is_usable() and host.current_state().state_name != "WhiffInstantCancel"
