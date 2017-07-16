# Static variables
WIN_COMBINATIONS = [[0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,8], [0,4,8], [6,4,2]]

# Helper methods
# prints the board to the screen
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end
# converts the users input to an index
def input_to_index(user_input)
  user_input.to_i - 1
end
# registers a move
def move(board, index, current_player)
  board[index] = current_player
end
# Check if a position is taken
def position_taken?(board, index)
  return !(board[index].nil? || board[index] == " ")
end
# checks if the entered move is valid
def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end
# gets a turn for the board
def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    move(board, index, current_player(board))
    display_board(board)
  else
    turn(board)
  end
end
# get the current turn number
def turn_count(board)
  counter = 0
  board.each do |position|
    if !(position.nil? || position == " " || position == "")
      counter += 1
    end
  end
  return counter
end
# Get the current player ("X" or "O")
def current_player(board)
  position = turn_count(board) % 2
  if position == 0
    return "X"
  else
    return "O"
  end
end
# Returns false if game not done, index of winning positions if it is won
def won?(board)
  WIN_COMBINATIONS.each do |combination|
    if position_taken?(board, combination[0])
      if board[combination[0]] == board[combination[1]] && board[combination[1]] == board[combination[2]]
        return combination
      end
    end
  end
  return false
end
# Returns true if board is full
def full?(board)
  if board.detect{|cell| (cell.nil? || cell == " " || cell == "")} # returns nill which is falsy if none are nill or blank
    return false
  end
  return true
end
# returns true if the game is a draw
def draw?(board)
  if !won?(board) && full?(board)
    return true
  end
  return false
end
# returns true when the game is done
def over?(board)
  if won?(board) || draw?(board)
    return true
  end
  return false
end
# gets the winner from the board
def winner(board)
  won = won?(board)
  if won
    return board[won[0]]
  end
end
# run the game for 9 turns
def play(board)
  current_turn = 0
  until over?(board)
    turn(board)
    current_turn = current_turn + 1
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cats Game!"
  end
end
