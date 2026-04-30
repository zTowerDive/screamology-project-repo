extends Interactable3D

# Stores the auto-generated sequence that player must match
var simon_array : Array[int] = []
var simon_round = 1
var second_chance = true
var player_input = null

@export var symbols : MeshInstance3D = null
# For Lights
signal start_game
signal player_press
# Button Hook-Ups
#--------------------------------------------------
# Assign buttons for input
@export var button_1: InteractableButton3D = null
@export var button_2: InteractableButton3D = null
@export var button_3: InteractableButton3D = null
@export var button_4: InteractableButton3D = null

var button_array := []

@export var green_light: OmniLight3D = null
@export var pink_light: OmniLight3D = null
@export var yellow_light: OmniLight3D = null
@export var blue_light: OmniLight3D = null

var lights_array := []

#Hook-up all the signals
func _ready():
	symbols.visible = false
	button_1.button_pressed.connect(button_input)
	button_2.button_pressed.connect(button_input)
	button_3.button_pressed.connect(button_input)
	button_4.button_pressed.connect(button_input)
	button_array = [button_1, button_2, button_3, button_4]
	lights_array = [green_light, pink_light, yellow_light, blue_light]
	simon_reset()
#--------------------------------------------------

func simon_reset():
	print("Reset")
	simon_array.clear()
	simon_round = -1
	second_chance = true
	for i in lights_array:
		i.light_energy = 1.0
	await start_game
	print("Starting game...")
	#for i in button_array:
		#i.collision_shape.disabled = true
	for i in lights_array:
		i.light_energy = 0
	next_round()
	
func next_round():
	simon_round += 1
	print("Round " +  str(simon_round))
	if simon_round > 5:
		symbols.visible = true
		print("Winner!")
	else: 
		await simon_thinks()
		print("Get ready...")
		simon_says()

func simon_thinks():
	var number = randi_range(0, 3)
	simon_array.append(number)
	print(simon_array)

func simon_says():
	#for buttons in button_array:
		#buttons.collision_shape.disabled = true
	for steps in simon_array:
		await simon_lights(steps)
	print("Your turn")
	var status = await player_turn()
	match status:
		true:
			second_chance = true
			next_round()
			print("Nice!")
		false:
			if second_chance == true: 
				second_chance = false
				simon_says()
				print("Try again...")
			else:
				simon_fail()

func simon_fail():
	print("Failed...")
	simon_reset()

func simon_lights(num):
	print("Turning on lights")
	match num:
		0:
			green_light.light_energy = 1.0
			await get_tree().create_timer(.25).timeout
			green_light.light_energy = 0.0
		1:
			pink_light.light_energy = 1.0
			await get_tree().create_timer(.25).timeout
			pink_light.light_energy = 0.0
		2:
			yellow_light.light_energy = 1.0
			await get_tree().create_timer(.25).timeout
			yellow_light.light_energy = 0.0
		3:
			blue_light.light_energy = 1.0
			await get_tree().create_timer(.25).timeout
			blue_light.light_energy = 0.0

func player_turn():
	print("Your turn")
	for buttons in button_array:
		buttons.monitoring = true
		buttons.monitorable = true
	print("Waiting for input...")
	var check_input = await player_press
	for buttons in button_array:
		buttons.monitoring = false
		buttons.monitorable = false
	print(str(player_input) + " was pressed")
	for steps in simon_array.size():
		var valid_input = simon_array[steps-1]
		if check_input == valid_input:
			return true
		else: 
			return false
	
func interact():
	pass

func button_input(input):
	
	player_input = input.to_int()
	start_game.emit()
	await simon_lights(player_input)
	player_press.emit(player_input)
	
	



	
