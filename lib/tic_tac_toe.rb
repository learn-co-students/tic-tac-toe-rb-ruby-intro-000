# Helper Methods
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(user_input)
  user_input.to_i - 1
end

def move(board, index, current_player)
  board[index] = current_player
end

def position_taken?(board, location)
  board[location] != " " && board[location] != ""
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    player = current_player(board)
    move(board, index, player)
    display_board(board)
  else
    turn(board)
  end
end

WIN_COMBINATIONS = [
  [0,1,2], # Top row
  [3,4,5], # Middle row
  [6,7,8], # Bottom row
  [0,3,6], # Left column
  [1,4,7], # Middle column
  [2,5,8], # Right column
  [0,4,8], # Diag 1
  [2,4,6] # Diag 2
]

def won?(board)
  winner = false
  WIN_COMBINATIONS.each do |win_combo|
    if (board[win_combo[0]] == "X" && board[win_combo[1]] == "X" &&
      board[win_combo[2]] == "X") || (board[win_combo[0]] == "O" &&
      board[win_combo[1]] == "O" && board[win_combo[2]] == "O")
      winner = win_combo
    end
  end
  winner
end

def full?(board)
  (0..8).all? do |index|
    position_taken?(board, index)
  end
end

def draw?(board)
  !won?(board) && full?(board)
end

def over?(board)
  full?(board) || won?(board) || draw?(board)
end

def winner(board)
  win = won?(board)
  if win
    board[win[0]]
  end
end

def turn_count(board)
  counter = 0
  board.each do |space|
    if space == "X" || space == "O"
      counter += 1
    end
  end
  counter
end

def current_player(board)
  count = turn_count(board)
  count.even? ? "X" : "O"
end

##

def play(board)
  turns_played = 0
  until over?(board)
    turn(board)
    turns_played += 1
  end
  if won?(board)
    winner = winner(board)
    puts "Congratulations #{winner}!"
  elsif draw?(board)
    puts "Cats Game!"
  end
end
