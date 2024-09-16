# Tic Tac Toe - Game Status
WIN_COMBINATIONS = [
  [0,1,2], # Top Row
  [3,4,5], # Middle Row
  [6,7,8], # Bottom Row
  [0,3,6], # Left Row
  [1,4,7], # Center Row
  [2,5,8], # Right Row
  [0,4,8], # Right Diagonal
  [2,4,6]  # Left Diagonal
]
# Methods - Display Tic Tac Toe Board
def display_board(board)
  row = '-----------'
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts row
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts row
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end
# Command Line Applications (CLIs) - Tic Tac Toe Move
def input_to_index(user_input)
  user_input.to_i - 1
end

 def move(board, index, character)
  board[index] = character
end
# Logic and Conditions - Tic Tac Toe Position Taken
def position_taken?(board, index)
  !(board[index] == ' ' || board[index] == '' || board[index] == nil)
end
# Valid Tic Tac Toe Move
def valid_move?(board, index)
  index.between?(0, 8) && !position_taken?(board, index)
end
# Loops - Tic Tac Toe Turn
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
# Iteration - Tic Tac Toe Current Player
def turn_count(board)
  count = 0

   board.each_with_index do |location, index|
    if position_taken?(board, index)
      count = count + 1
    end
  end

   count
end

 def current_player(board)
  turn_count(board).even? ? 'X' : 'O'
end
# Tic Tac Toe - Game Status (Cont.)
def won?(board)
  if board.all? { |place| place == ' ' }
    return false
  end
  for combo in WIN_COMBINATIONS
    if combo.all? { |index| board[index] == 'X' }
      return combo
    elsif combo.all? { |index| board[index] == 'O' }
      return combo
    end
  end
  false
end

 def full?(board)
  board.all? { |place| place != ' ' }
end

 def draw?(board)
  full?(board) && !won?(board)
end

 def over?(board)
  if won?(board)
    return true
  end

   draw?(board) || full?(board)
end

 def winner(board)
  if won?(board)
    board[won?(board)[0]]
  end
end
# TicTacToe.rb
def play(board)
  until over?(board)
    turn(board)
  end

   if won?(board)
    puts 'Congratulations ' + winner(board) + '!'
  elsif draw?(board)
    puts "Cat's Game!"
  end
end
