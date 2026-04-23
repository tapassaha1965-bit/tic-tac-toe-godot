extends Control
var selected_mode = "PVP"
var board = ["","","","","","","","",""]
var current_player = "X"
var game_over = false
var vs_ai = false
var ai_player = "O"
var ai_difficulty = "MEDIUM"
@onready var cells = [
	$Board/Cell0, $Board/Cell1, $Board/Cell2,
	$Board/Cell3, $Board/Cell4, $Board/Cell5,
	$Board/Cell6, $Board/Cell7, $Board/Cell8
]

func _ready():

	for i in range(9):
		cells[i].pressed.connect(_on_cell_pressed.bind(i))
	$MenuUI/PvPButton.pressed.connect(select_pvp)
	$MenuUI/AIButton.pressed.connect(select_ai)
	$MenuUI/StartButton.pressed.connect(start_game)
	$RestartButton.pressed.connect(restart_game)
	$ExitButton.pressed.connect(back_to_menu)
	$MenuUI/EasyButton.pressed.connect(set_easy)
	$MenuUI/MediumButton.pressed.connect(set_medium)
	$MenuUI/HardButton.pressed.connect(set_hard)	
	$MenuUI/PvPButton.pressed.connect(play_click)
	$MenuUI/AIButton.pressed.connect(play_click)
	$MenuUI/EasyButton.pressed.connect(play_click)
	$MenuUI/MediumButton.pressed.connect(play_click)
	$MenuUI/HardButton.pressed.connect(play_click)
	$MenuUI/StartButton.pressed.connect(play_click)
	$RestartButton.pressed.connect(play_click)
	$ExitButton.pressed.connect(play_click)

func _on_cell_pressed(index):

	if board[index] != "" or game_over:
		return

	board[index] = current_player
	cells[index].text = current_player
	$MoveSound.play()

	if current_player == "X":
		cells[index].modulate = Color(0.4, 0.7, 1)
	else:
		cells[index].modulate = Color(1, 0.5, 0.5)

	if vs_ai and not game_over:
		await get_tree().create_timer(0.4).timeout
		ai_move()
	check_winner()
	switch_player()


func switch_player():

	if game_over:
		return

	current_player = "O" if current_player == "X" else "X"

	if vs_ai:
		$StatusLabel.text = "Mode: AI (" + ai_difficulty + ") | Player " + current_player + "'s Turn"
	else:
		$StatusLabel.text = "Player " + current_player + "'s Turn"

func check_winner():

	var wins = [
		[0,1,2],[3,4,5],[6,7,8],
		[0,3,6],[1,4,7],[2,5,8],
		[0,4,8],[2,4,6]
	]

	for combo in wins:

		if board[combo[0]] != "" and \
		board[combo[0]] == board[combo[1]] and \
		board[combo[1]] == board[combo[2]]:

			game_over = true
			$StatusLabel.text = board[combo[0]] + " Wins!"
			$WinSound.play()
			highlight_win(combo)
			return


	if "" not in board:
		game_over = true
		$StatusLabel.text = "Draw!"


func restart_game():

	board = ["","","","","","","","",""]
	current_player = "X"
	game_over = false
	for cell in cells:
		cell.text = ""
		cell.modulate= Color(1,1,1)
		cell.scale=Vector2(1,1)
		
	if vs_ai:
		$StatusLabel.text = "Mode: AI (" + ai_difficulty + ") | Player X's Turn"
	else:
		$StatusLabel.text = "Player X's Turn"

func highlight_win(combo):

	for i in combo:
		var tween = create_tween()
		tween.tween_property(cells[i], "modulate", Color(0.2, 1, 0.4), 0.25)
		tween.tween_property(cells[i], "scale", Vector2(1.2, 1.2), 0.15)
		tween.tween_property(cells[i], "scale", Vector2(1, 1), 0.15)

func toggle_mode():

	vs_ai = !vs_ai

	if vs_ai:
		$ModeButton.text = "Mode: AI"
	else:
		$ModeButton.text = "Mode: PvP"
func ai_move():

	if ai_difficulty == "EASY":
		random_move()

	elif ai_difficulty == "MEDIUM":
		block_or_random()

	elif ai_difficulty == "HARD":
		win_block_or_best()

func make_ai_play(index):

	board[index] = ai_player
	cells[index].text = ai_player
	cells[index].modulate = Color(1, 0.5, 0.5)

	check_winner()
	switch_player()


func check_future_win(player):

	var wins = [
		[0,1,2],[3,4,5],[6,7,8],
		[0,3,6],[1,4,7],[2,5,8],
		[0,4,8],[2,4,6]
	]

	for combo in wins:
		if board[combo[0]] == player and \
		   board[combo[1]] == player and \
		   board[combo[2]] == player:
			return true

	return false
func select_pvp():

	selected_mode = "PVP"

	$MenuUI/PvPButton.modulate = Color(0.6,1,0.6)
	$MenuUI/AIButton.modulate = Color(1,1,1)

	$MenuUI/EasyButton.visible = false
	$MenuUI/MediumButton.visible = false
	$MenuUI/HardButton.visible = false


func select_ai():

	selected_mode = "AI"

	$MenuUI/AIButton.modulate = Color(0.6,1,0.6)
	$MenuUI/PvPButton.modulate = Color(1,1,1)

	$MenuUI/EasyButton.visible = true
	$MenuUI/MediumButton.visible = true
	$MenuUI/HardButton.visible = true

	set_medium()

func start_game():

	if selected_mode == "AI":
		vs_ai = true
		$StatusLabel.text = "Mode: AI (" + ai_difficulty + ")"
	else:
		vs_ai = false
		$StatusLabel.text = "Player X's Turn"

	$MenuUI.visible = false

	$Board.visible = true
	$StatusLabel.visible = true
	$RestartButton.visible = true
	$ExitButton.visible = true

func back_to_menu():

	restart_game()

	$Board.visible = false
	$StatusLabel.visible = false
	$RestartButton.visible = false
	$ExitButton.visible = false

	$MenuUI.visible = true
	$MenuUI/PvPButton.modulate = Color(1,1,1)
	$MenuUI/AIButton.modulate = Color(1,1,1)

func set_easy():
	ai_difficulty = "EASY"

	$MenuUI/EasyButton.modulate = Color(0.6,1,0.6)
	$MenuUI/MediumButton.modulate = Color(1,1,1)
	$MenuUI/HardButton.modulate = Color(1,1,1)

func set_medium():
	ai_difficulty = "MEDIUM"

	$MenuUI/MediumButton.modulate = Color(0.6,1,0.6)
	$MenuUI/EasyButton.modulate = Color(1,1,1)
	$MenuUI/HardButton.modulate = Color(1,1,1)

func set_hard():
	ai_difficulty = "HARD"

	$MenuUI/HardButton.modulate = Color(0.6,1,0.6)
	$MenuUI/EasyButton.modulate = Color(1,1,1)
	$MenuUI/MediumButton.modulate = Color(1,1,1)

func random_move():

	var empty = []

	for i in range(9):
		if board[i] == "":
			empty.append(i)

	if empty.size() > 0:
		make_ai_play(empty.pick_random())

func block_or_random():

	for i in range(9):
		if board[i] == "":
			board[i] = "X"
			if check_future_win("X"):
				board[i] = ""
				make_ai_play(i)
				return
			board[i] = ""

	random_move()

func win_block_or_best():

	for i in range(9):
		if board[i] == "":
			board[i] = ai_player
			if check_future_win(ai_player):
				board[i] = ""
				make_ai_play(i)
				return
			board[i] = ""

	for i in range(9):
		if board[i] == "":
			board[i] = "X"
			if check_future_win("X"):
				board[i] = ""
				make_ai_play(i)
				return
			board[i] = ""

	if board[4] == "":
		make_ai_play(4)
		return

	random_move()

func play_click():
	$ClickSound.play()
