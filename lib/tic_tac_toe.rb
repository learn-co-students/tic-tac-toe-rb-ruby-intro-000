#display board
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

#check if position is taken
def position_taken?(board, index)
  board[index] == "X" || board[index] == "O"
end

#convert input to integer index method
def input_to_index(index)
  return index.to_i - 1
end

#move method
def move(board, index, player)
  return board[index] = player
end

#check if the user's move is already taken and if it falls on the board
def valid_move?(board, index)
  !position_taken?(board, index) && (index).between?(0,8)
end

#grab the user's turn input
def turn(board)
  puts "Please enter 1-9:"
  #gets user input=
  input = gets.strip
  index = input_to_index(input)

  player = current_player(board)
    #actions for valid move
    if valid_move?(board, index)
      move(board, index, player)
    else
      #action for invalid move
      turn(board)
    end
    display_board(board)
end

#play method
def play(board)
  until over?(board)
    turn(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  else
    puts "Cats Game!"
  end
end


#turn count method
def turn_count(board)
  counter = 0
  board.each do |position|
    counter += 1 if position == "X" || position == "O"
  end
  return counter
end


#determine current_player
def current_player(board)
  turn_count(board).even? ? "X" : "O"
end

# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [2,4,6],
]

#determine if a winning combination is currently represented by one player on the board
def won?(board)
	WIN_COMBINATIONS.each do |combo_array|
  		if board[combo_array[0]] == "X" && board[combo_array[1]] == "X" && board[combo_array[2]] == "X" || board[combo_array[0]] == "O" && board[combo_array[1]] == "O" && board[combo_array[2]] == "O"
          	return combo_array
    		end
	end
  #return false for no wins
	return false
end

#check if all spots on the board are filled with a player character
def full?(board)
  full_board = board.all? do |value|
    value == "X" || value == "O"
  end
  full_board
end

#determine if the full board is a draw or a win
def draw?(board)
  !won?(board) && full?(board)
end

#determine if the game is over.  a win, draw, and full board return true
def over?(board)
  won?(board) || draw?(board) || full?(board)
end

#determine who the winner is
def winner(board)
  #grab the result of the won? method (should be true or false)
  if won?(board)
    #if there is a win, grab the returned winning combination array
    winning_combination = won?(board)
    #check the first index in the winning combination against the matching board array index
            board[winning_combination[0]]
      else
        nil
  end
end
