# LITTLE HELPERS
# Make user input play nicely with the program
def input_to_index(user_input)
  user_input.to_i - 1
end

# Check that a space is open for a move
def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

# Do the Locomotion
def move(board, index, player)
  board[index] = player
end

# DISPLAY
# Display the current board state
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts '-----------'
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts '-----------'
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

# GAMEPLAY
# Count turns
def turn_count(board)
  turn_number = 0
  board.each do |move|
    if move == "X" || move == "O"
      turn_number += 1
    end
  end
  return turn_number
end

# Set current player based on turn_count
def current_player(board)
  turn_count(board) % 2 == 0 ? "X" : "O"
end

# Make your move
def turn(board)
  puts 'Please enter 1-9:'
  user_input = gets.strip
  index = input_to_index(user_input)
  if valid_move?(board, index)
    move(board, index, current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

# See if the move is valis
def valid_move?(board, index)
  index.between?(0, 8) && !position_taken?(board, index)
end

# Determine if the board has been filled
def full?(board)
  board.all?{|token| token == "X" || token == "O"}
end

# What counts as a win?
WIN_COMBINATIONS = [
  [0, 1, 2], # top row
  [3, 4, 5], # center row
  [6, 7, 8], # bottom row
  [0, 3, 6], # first column
  [1, 4, 7], # second column
  [2, 5, 8], # third column
  [0, 4, 8], # diagonal L-R
  [2, 4, 6] # diagonal R-L
]

# Determine if someone has won
def won?(board)
 WIN_COMBINATIONS.detect do |win|
   board[win[0]] == board[win[1]] &&
   board[win[0]] == board[win[2]] &&
   position_taken?(board, win[0])
 end
end

# Determine that there has been a draw
def draw?(board)
  full?(board) && !won?(board)
end

# Determine if the game is over
def over?(board)
  won?(board) || draw?(board)
end

# Announce the winner
def winner(board)
  if winner = won?(board)
    board[winner.first]
  end
end

# Play the game
def play(board)
  turn(board) until over?(board)
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cat's Game!"
  end
end
