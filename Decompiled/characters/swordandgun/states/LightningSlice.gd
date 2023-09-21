extends CharacterState

const TRACKING_DISTANCE = "86.0"
const DEADZONE_RADIUS = "70.0"

const DEFAULT_HITBOX_X = 128
const DEFAULT_HITBOX_Y = - 16




export  var cancel = false
export  var followup = false

var stall = false

onready var hitbox = $Hitbox

func _frame_0():
	stall = false

func _frame_1():
	var vel = host.get_vel()
	if not host.used_aerial_l_slice:
		host.set_vel(vel.x, "0")
		host.used_aerial_l_slice = true
		stall = true
	else :
		stall = false


func _frame_8():

	spawn_particle_relative(particle_scene)

func _tick():
	var tracking_pos = {
		"x":DEFAULT_HITBOX_X, 
		"y":DEFAULT_HITBOX_Y, 
	}
	hitbox.x = DEFAULT_HITBOX_X
	hitbox.y = DEFAULT_HITBOX_Y
	if followup:
			hitbox.x = host.lightning_slice_x
			hitbox.y = host.lightning_slice_y
















	else :
		var hitbox_pos = xy_to_dir(data.x, data.y, TRACKING_DISTANCE)
		hitbox.x = DEFAULT_HITBOX_X + (fixed.round(hitbox_pos.x) * host.get_facing_int())
		hitbox.y = DEFAULT_HITBOX_Y + fixed.round(hitbox_pos.y)
		host.lightning_slice_x = hitbox.x
		host.lightning_slice_y = hitbox.y



func _tick_after():
	._tick_after()
	if cancel and current_tick == 1:
		current_tick = 3
	if current_tick > 16 or not stall:
		host.apply_grav()
