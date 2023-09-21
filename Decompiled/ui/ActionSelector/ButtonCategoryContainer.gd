extends Control

class_name ButtonCategoryContainer

signal prediction_selected()

onready var action_data_container = $"%ActionDataContainer"
onready var action_data_panel_container = $"%ActionDataPanelContainer"
onready var button_container = $"%ButtonContainer"

var label_text = ""
var selected_button_text = ""
var active_button = null

var mouse_over = false

var game = null
var player_id = null

var category_int = - 1

var prediction_type = null

func init(name):
	label_text = name
	$"%Label".text = label_text







func any_buttons_visible():
	for button in $"%ButtonContainer".get_children():
		if button.visible:
			return true
	return false

















func enable_predict_button():
	$"%PredictButton".show()


func disable_predict_button():

	$"%PredictButton".hide()

func add_button(button):
	$"%ButtonContainer".add_child(button)
	button.connect("mouse_entered", self, "on_button_mouse_entered", [button])
	button.connect("mouse_exited", self, "on_button_mouse_exited")

func get_prediction():
	return $"%PredictButton".pressed and $"%PredictButton".visible

func reset_prediction():
	$"%PredictButton".set_pressed_no_signal(false)

func refresh():
	if get_prediction():
		$"%Label".text = label_text
		$"%Label".modulate = Color.white
		$"%Label".modulate.a = 1.0
		return 
	for button in $"%ButtonContainer".get_children():
		if button.is_pressed():
			on_button_mouse_entered(button)
			$"%Label".modulate = Color.cyan
			active_button = button
			selected_button_text = button.action_title
			return 
	$"%Label".text = label_text
	$"%Label".modulate = Color.white
	$"%Label".modulate.a = 0.25

func on_button_mouse_entered(button):
	if get_prediction():
		return 
	_on_ButtonContainer_mouse_entered()
	$"%Label".text = button.action_title
	if button.action_title == selected_button_text:
		return 
	$"%Label".modulate = Color.green

func on_button_mouse_exited():
	refresh()

func show_data_container():
	$"%ActionDataPanelContainer".show()



	
func hide_data_container():
	$"%ActionDataPanelContainer".hide()
















func _on_ButtonContainer_mouse_entered():


	pass

func _on_ButtonContainer_mouse_exited():


	pass


func _on_PredictButton_mouse_entered():
	$"%PredictLabel".show()
	$"%PredictLabel".text = "P" + str((player_id % 2) + 1) + " Prediction"
	pass


func _on_PredictButton_mouse_exited():
	$"%PredictLabel".hide()
	pass


func _on_PredictButton_pressed():
	refresh()
	emit_signal("prediction_selected")
	pass
